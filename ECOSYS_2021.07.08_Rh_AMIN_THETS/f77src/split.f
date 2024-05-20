
      SUBROUTINE split(NT,NE,NAX,NDX,NTX,NEX,NHW,NHE,NVN,NVS)
C
C     THIS SUBROUTINE SPLITS OUTPUT FOR C, N, P, WATER AND HEAT
C     FROM OUTPUT FILES FOR THE ENTIRE LANDSCAPE WRITTEN DURING
C     EACH SCENE OF THE MODEL RUN INTO INDIVIDUAL FILES FOR EACH
C     GRID CELL AT THE END OF THE SCENE WITH FILE NAME PREFIXES
C     INDICATING ITS COLUMN AND ROW POSITION.
C
      include "parameters.h"
      include "filec.h"
      include "files.h"
      include "blkc.h"
      CHARACTER*16 DATA(30),DATAC(30,250,250),DATAP(JP,JY,JX)
     2,DATAM(JP,JY,JX),DATAX(JP),DATAY(JP),DATAZ(JP,JY,JX)
     3,OUTS(10),OUTP(10),OUTFILS(10,JY,JX),OUTFILP(10,JP,JY,JX)
      CHARACTER*3 CHOICE(102,20)
      CHARACTER*8 CDATE
      CHARACTER*8 CDOY,DATE,HOUR
      CHARACTER*16 CHEAD
      CHARACTER*16 OUTFILE
      CHARACTER*16 HEAD(50)
      DIMENSION HEAX(50)
      DO 9995 NX=NHW,NHE
      DO 9990 NY=NVN,NVS
      DO 1010 N=21,25
      IF(DATAC(N,NE,NEX).NE.'NO')THEN
      LUN=N+10
      LUX=N+30
      REWIND(LUN)
C      OPEN(LUX,FILE=OUTFILS(N-20,NY,NX),STATUS='UNKNOWN')
      OPEN(LUX,FILE=trim(outdir)//OUTFILS(N-20,NY,NX),STATUS='UNKNOWN')
      READ(LUN,'(A12,2A8,50A16)')CDOY,DATE,HOUR
     2,(HEAD(K),K=1,NOUTS(N-20))
      WRITE(LUX,'(A12,2A8,50A16)')CDOY,DATE,HOUR
     2,(HEAD(K),K=1,NOUTS(N-20))
1000  READ(LUN,'(A16,F8.3,4X,A8,I8,50E16.8)',END=1005)OUTFILE
     2,DOY,CDATE,J,(HEAX(K),K=1,NOUTS(N-20))
      IF(OUTFILE.EQ.OUTFILS(N-20,NY,NX))THEN
      WRITE(LUX,'(F8.3,4X,A8,I8,50E16.8)')
     2DOY,CDATE,J,(HEAX(K),K=1,NOUTS(N-20))
      ENDIF
      GO TO 1000
1005  CLOSE(LUX)
C     CLOSE(LUN)
      ENDIF
1010  CONTINUE
      DO 1110 N=26,30
      IF(DATAC(N,NE,NEX).NE.'NO')THEN
      LUN=N+10
      LUX=N+30
      REWIND(LUN)
C      OPEN(LUX,FILE=OUTFILS(N-20,NY,NX),STATUS='UNKNOWN')
      OPEN(LUX,FILE=trim(outdir)//OUTFILS(N-20,NY,NX),STATUS='UNKNOWN')
      READ(LUN,'(A12,A8,50A16)')CDOY,DATE,(HEAD(K),K=1,NOUTS(N-20))
      WRITE(LUX,'(A12,A8,50A16)')CDOY,DATE,(HEAD(K),K=1,NOUTS(N-20))
1100  READ(LUN,'(A16,F8.3,4X,A8,50E16.8)',END=1105)OUTFILE
     2,DOY,CDATE,(HEAX(K),K=1,NOUTS(N-20))
      IF(OUTFILE.EQ.OUTFILS(N-20,NY,NX))THEN
      WRITE(LUX,'(F8.3,4X,A8,50E16.8)')
     2DOY,CDATE,(HEAX(K),K=1,NOUTS(N-20))
      ENDIF
      GO TO 1100
1105  CLOSE(LUX)
C     CLOSE(LUN)
      ENDIF
1110  CONTINUE
      DO 9985 NZ=1,NP0(NY,NX)
      DO 1210 N=21,25
      IF(DATAC(N,NE,NEX).NE.'NO')THEN
      LUN=N+20
      LUX=N+40
      REWIND(LUN)
C      OPEN(LUX,FILE=OUTFILP(N-20,NZ,NY,NX),STATUS='UNKNOWN')
      OPEN(LUX,FILE=trim(outdir)//OUTFILP(N-20,NZ,NY,NX)
     2,STATUS='UNKNOWN')
      READ(LUN,'(A12,2A8,50A16)')CDOY,DATE,HOUR
     2,(HEAD(K),K=1,NOUTP(N-20))
      WRITE(LUX,'(A12,2A8,50A16)')CDOY,DATE,HOUR
     2,(HEAD(K),K=1,NOUTP(N-20))
1200  READ(LUN,'(A16,F8.3,4X,A8,I8,50E16.8)',END=1205)OUTFILE
     2,DOY,CDATE,J,(HEAX(K),K=1,NOUTP(N-20))
      IF(OUTFILE.EQ.OUTFILP(N-20,NZ,NY,NX))THEN
      WRITE(LUX,'(F8.3,4X,A8,I8,50E16.8)')
     2DOY,CDATE,J,(HEAX(K),K=1,NOUTP(N-20))
      ENDIF
      GO TO 1200
1205  CLOSE(LUX)
C     CLOSE(LUN)
      ENDIF
1210  CONTINUE
      DO 1310 N=26,30
      IF(DATAC(N,NE,NEX).NE.'NO')THEN
      LUN=N+20
      LUX=N+40
      REWIND(LUN)
C      OPEN(LUX,FILE=OUTFILP(N-20,NZ,NY,NX),STATUS='UNKNOWN')
      OPEN(LUX,FILE=trim(outdir)//OUTFILP(N-20,NZ,NY,NX)
     2,STATUS='UNKNOWN')
      READ(LUN,'(A12,A8,50A16)')CDOY,DATE,(HEAD(K),K=1,NOUTP(N-20))
      WRITE(LUX,'(A12,A8,50A16)')CDOY,DATE,(HEAD(K),K=1,NOUTP(N-20))
      IF(N.LE.29)THEN
1300  READ(LUN,'(A16,F8.3,4X,A8,50E16.8)',END=1305)OUTFILE
     2,DOY,CDATE,(HEAX(K),K=1,NOUTP(N-20))
      IF(OUTFILE.EQ.OUTFILP(N-20,NZ,NY,NX))THEN
      WRITE(LUX,'(F8.3,4X,A8,50E16.8)')
     2DOY,CDATE,(HEAX(K),K=1,NOUTP(N-20))
      ENDIF
      GO TO 1300
      ELSE
1400  READ(LUN,'(A16,F8.3,4X,A8,A16,I16,50E16.8)',END=1305)OUTFILE
     2,DOY,CDATE,CHEAD,IHEAD,(HEAX(K),K=1,NOUTP(N-20))
      IF(OUTFILE.EQ.OUTFILP(N-20,NZ,NY,NX))THEN
      WRITE(LUX,'(F8.3,4X,A8,A16,I16,50E16.8)')
     2DOY,CDATE,CHEAD,IHEAD,(HEAX(K),K=1,NOUTP(N-20))
      ENDIF
      GO TO 1400
      ENDIF
1305  CLOSE(LUX)
C     CLOSE(LUN)
      ENDIF
1310  CONTINUE
9985  CONTINUE
9990  CONTINUE
9995  CONTINUE
      RETURN
      END
