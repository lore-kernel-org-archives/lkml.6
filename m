Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbeDKHuc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:50:32 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:51798 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeDKHua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:50:30 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: Palmer Dabbelt <palmer@sifive.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/4] Add notrace to lib/ucmpdi2.c
Date: Wed, 11 Apr 2018 08:50:16 +0100
Message-ID: <1523433019-17419-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523433018-321458-16603-21186-1
X-BESS-VER: 2018.4-r1804052328
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191870
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

As part of the MIPS conversion to use the generic GCC library routines,
Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
patch rectifies the problem.

CC: Matt Redfearn <matt.redfearn@mips.com>
CC: Antony Pavlov <antonynpavlov@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
  add notrace to lib/ucmpdi2.c

 lib/ucmpdi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
index 25ca2d4c1e19..597998169a96 100644
--- a/lib/ucmpdi2.c
+++ b/lib/ucmpdi2.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/libgcc.h>
 
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
+word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
 {
 	const DWunion au = {.ll = a};
 	const DWunion bu = {.ll = b};
-- 
2.7.4
