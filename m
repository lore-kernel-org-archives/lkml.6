Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeCTOqW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:46:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38466 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeCTOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:46:18 -0400
From: Khalid Aziz <khalid.aziz@oracle.com>
To: davem@davemloft.net
Cc: Khalid Aziz <khalid.aziz@oracle.com>, shannon.nelson@oracle.com,
        nagarathnam.muthusamy@oracle.com, nick.alcock@oracle.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH sparc-next] sparc: Make auxiliary vectors for ADI available on 32-bit as well
Date: Tue, 20 Mar 2018 08:46:02 -0600
Message-Id: <20180320144602.16535-1-khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8837 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c6202ca764ac ("sparc64: Add auxiliary vectors to report
platform ADI properties") adds auxiliary vectors to report ADI
capabilities on sparc64 platform only. This needs to be uniform
across 64-bit and 32-bit. This patch makes the same vectors
available on 32-bit as well.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
 arch/sparc/include/uapi/asm/auxvec.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/auxvec.h b/arch/sparc/include/uapi/asm/auxvec.h
index f9937ccfcd99..ab8780fb9df1 100644
--- a/arch/sparc/include/uapi/asm/auxvec.h
+++ b/arch/sparc/include/uapi/asm/auxvec.h
@@ -3,7 +3,6 @@
 
 #define AT_SYSINFO_EHDR		33
 
-#ifdef CONFIG_SPARC64
 /* Avoid overlap with other AT_* values since they are consolidated in
  * glibc and any overlaps can cause problems
  */
@@ -12,8 +11,5 @@
 #define AT_ADI_UEONADI	50
 
 #define AT_VECTOR_SIZE_ARCH	4
-#else
-#define AT_VECTOR_SIZE_ARCH	1
-#endif
 
 #endif /* !(__ASMSPARC_AUXVEC_H) */
-- 
2.11.0
