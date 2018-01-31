Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeAaHzD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:55:03 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50590 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbeAaHzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:55:02 -0500
X-Google-Smtp-Source: AH8x227xLjGIkQHJPrLOaZW5K3FpU1D7rDcrkGFeU9lg1AKZKKDxW4b6Iow4D89Ly4c8u80xf3Io1A==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/epapr: Move register keyword at the beginning of declaration
Date: Wed, 31 Jan 2018 08:54:43 +0100
Message-Id: <20180131075445.9292-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning for all register unsigned long (0,3-12) that appear during W=1
compilation:

./arch/powerpc/include/asm/epapr_hcalls.h:479:2: warning: ‘register’ is not at beginning of declaration [-Wold-style-declaration]
  unsigned long register r[\d] asm("r[\d]");

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/epapr_hcalls.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index 90863245df53..d3a7e36f1402 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -466,17 +466,17 @@ static inline unsigned long epapr_hypercall(unsigned long *in,
 			    unsigned long *out,
 			    unsigned long nr)
 {
-	unsigned long register r0 asm("r0");
-	unsigned long register r3 asm("r3") = in[0];
-	unsigned long register r4 asm("r4") = in[1];
-	unsigned long register r5 asm("r5") = in[2];
-	unsigned long register r6 asm("r6") = in[3];
-	unsigned long register r7 asm("r7") = in[4];
-	unsigned long register r8 asm("r8") = in[5];
-	unsigned long register r9 asm("r9") = in[6];
-	unsigned long register r10 asm("r10") = in[7];
-	unsigned long register r11 asm("r11") = nr;
-	unsigned long register r12 asm("r12");
+	register unsigned long r0 asm("r0");
+	register unsigned long r3 asm("r3") = in[0];
+	register unsigned long r4 asm("r4") = in[1];
+	register unsigned long r5 asm("r5") = in[2];
+	register unsigned long r6 asm("r6") = in[3];
+	register unsigned long r7 asm("r7") = in[4];
+	register unsigned long r8 asm("r8") = in[5];
+	register unsigned long r9 asm("r9") = in[6];
+	register unsigned long r10 asm("r10") = in[7];
+	register unsigned long r11 asm("r11") = nr;
+	register unsigned long r12 asm("r12");
 
 	asm volatile("bl	epapr_hypercall_start"
 		     : "=r"(r0), "=r"(r3), "=r"(r4), "=r"(r5), "=r"(r6),
-- 
2.11.0
