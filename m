Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeEVH1N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:27:13 -0400
Received: from mout.perfora.net ([74.208.4.197]:43213 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbeEVH1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:27:10 -0400
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 1/9] staging: rtl8723bs: Rename 'Hal8723BPwrSeq.{c,h}' to 'hal_pwr_seq.*'.
Date: Tue, 22 May 2018 00:26:29 -0700
Message-Id: <20180522072637.9782-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.0
X-Provags-ID: V03:K1:jMKWC3G+MXbFiUOj0i8tE8VYxk+ObFy6IXkz6byE5gkoop23yxu
 c1YVw65+H4QrFXVJfvbL7yHs0tcL2ghmjP5iSKOTBOwXwFok1lmS+gql98WSaBFdz8r0H5N
 aB8VHhaPx+YwpI0DwcWFa4EOIHoim2Uw60Adr3gEUpc34o0DSQ75aefZaEW/2BqeTZ2wPyd
 IPwJmxHxMgvS4QmLZ6DLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qbhV+4mimZ4=:ZUdlzIhmIA3uwZnSjp4JkI
 4yRIbrdtdSxff3FQOetuVppuV+OdFo0rEt5Djt54vaPlaZDngDvLEYUsxP8I+HM+HtS+qPwWM
 gqEMAyVbzcQEkID/so9LJdM6n1/2DkkpfBrm4BnQeAPiLg8mRQssCDAVY/MWosnRjcOKhqJHc
 E429uNzTR9FWhvgC0Pzxv+qMXkn6v11mkkS9WFLKdFYLrNiKvrAny5d6gcsM60hukhna18IXm
 RyRBYPTAZnibLryNFn2lb50ZhaxdzHY1T7C3xkZKcPk30/4hJqAXD1yef4vyP2ljOArJDznsK
 7ug9Dxz+gDGyOknlmAaNFtTPLHOh/O4Qb0rOxXl4Vci1OSxTdshlOWiiMMJjNn8/7fUi+N81k
 GMxe/S/uP16qnaYBMjcEmwb1TuHLnzV3csKq66gZwaPpnIYrTrApOxYejsIOKnM+voP5qogDx
 mInaAvlX7RuOhHB/27DD+gdBvLu9Vc9amlSe6Tza96tGGRqReM1W03QfBRSdksqHRt713wi2g
 XXrV4wGHUpCUP0hZWIXxEKvuUaUBJ5WaamZkQv1UaIufwF5g2Z47hCffi8CzJITBAHMXpYR+6
 Zfsp2cFY3lTiaFPw8slWBcIs068PlviDvPXxrfB2WYhMKVxeefJpL+MTZQwCILbXUbQuOuAdw
 j/eZYIRHJWkSiKp2PGQOsUyEJPCJ+rf0c5OQvWcIWKmNKRBoZRoG+8JIvstrSdcrZXVw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Camel-case naming is discouraged int the linux kernel coding style.
Rename these files using snake case, and update the makefile to use
the new names.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/Makefile                              | 2 +-
 .../staging/rtl8723bs/hal/{Hal8723BPwrSeq.c => hal_pwr_seq.c}   | 2 +-
 .../rtl8723bs/include/{Hal8723BPwrSeq.h => hal_pwr_seq.h}       | 0
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h                | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/staging/rtl8723bs/hal/{Hal8723BPwrSeq.c => hal_pwr_seq.c} (99%)
 rename drivers/staging/rtl8723bs/include/{Hal8723BPwrSeq.h => hal_pwr_seq.h} (100%)

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index f236acfd3afa..a12cf8dd8ed9 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -23,7 +23,7 @@ r8723bs-y = \
 		hal/hal_com_phycfg.o \
 		hal/hal_btcoex.o \
 		hal/hal_sdio.o \
-		hal/Hal8723BPwrSeq.o \
+		hal/hal_pwr_seq.o \
 		hal/HalPhyRf.o \
 		hal/HalPwrSeqCmd.o \
 		hal/odm.o \
diff --git a/drivers/staging/rtl8723bs/hal/Hal8723BPwrSeq.c b/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c
similarity index 99%
rename from drivers/staging/rtl8723bs/hal/Hal8723BPwrSeq.c
rename to drivers/staging/rtl8723bs/hal/hal_pwr_seq.c
index 57f7f09b3ab9..589e7aae7bbd 100644
--- a/drivers/staging/rtl8723bs/hal/Hal8723BPwrSeq.c
+++ b/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c
@@ -17,7 +17,7 @@ Major Change History:
 
 */
 
-#include "Hal8723BPwrSeq.h"
+#include "hal_pwr_seq.h"
 
 /* drivers should parse below arrays and do the corresponding actions */
 /* 3 Power on  Array */
diff --git a/drivers/staging/rtl8723bs/include/Hal8723BPwrSeq.h b/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
similarity index 100%
rename from drivers/staging/rtl8723bs/include/Hal8723BPwrSeq.h
rename to drivers/staging/rtl8723bs/include/hal_pwr_seq.h
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index 98408e8e33f2..46ac61b058c8 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -16,7 +16,7 @@
 #include "rtl8723b_xmit.h"
 #include "rtl8723b_cmd.h"
 #include "rtw_mp.h"
-#include "Hal8723BPwrSeq.h"
+#include "hal_pwr_seq.h"
 #include "Hal8723BPhyReg.h"
 #include "Hal8723BPhyCfg.h"
 
-- 
2.17.0
