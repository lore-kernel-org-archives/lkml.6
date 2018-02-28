Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834312-8-10058509794232706987
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834312; b=PnmuRXXcnsU0R0uMwJmMiIEqi6gvyxV/ixBAeAm3oQMJRaC
    rIpRleErkN1xWzRb2FO8Y9XVcWC9U4JfzUjwb/06G0PLduywDR5yBEKbSe9W0oQ5
    j9UMmlyIfeOuC+dow+BOLjpe88CDe5h0mPn5jJf/n3fu+rgkT5T2Ibg7BE3LdHUA
    zOepNe8G20jJBUY4U6eMi9AuxpEh+sCO2pMGRnpbnFzVvDoqkbqZNf5yZRiOxL4o
    WKqfPdr+J7345aTWDGf3wKqKR1yfmATDBi2Vt9uzCc5M2No6obC2ivduAxS6IL+W
    7NoE4/OiUg0Vycwzg3s1o2RbVmxHgJ7NBMJ3sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834312; bh=GHwI+yRMBcfsFAZDbaF
    DF0fYc9PniaGYaQ8nw+SL0xA=; b=I7ShUZmvgL1+stvUiTt5mzi9PlLqCI3xwoE
    NQa5wlY61lFgnyoV7KdHDlhHfs8smcT7AS4ovIldKiIt0dOKr2ewNCQGi5b2HbBm
    Ghr0/5R4EHaHcKR0VSPNKyfZMQ20pe8EyTHt+7jC5qYHQ7fIMIksGgWArAI6Ejr9
    rsmjBPjsC4YLrZ701SjjuwM1fCyat2JdRJgxFpY1cM2z6uPe6JGlWf/G3auHUANO
    VzZ1Kkyg+UeiUd9yufB0rrWdWeKXITSTQCAViwTTPe7Q5yezumX9Pp4l93Joz92p
    voRvxEAaw3MEGG0RNq322tI+s7z2NX6hksCK+eKSl/D6rxxkcuA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbeB1QIZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:08:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34941 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934474AbeB1QIY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:08:24 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.942966468@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 099/254] MIPS: math-emu: Define IEEE 754-2008 feature
 control bits
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit f1f3b7ebac08161761c352fd070cfa07b7b94c54 upstream.

Define IEEE 754-2008 feature control bits: FIR.HAS2008, FCSR.ABS2008 and
FCSR.NAN2008, and update the `_ieee754_csr' structure accordingly.

For completeness define FIR.UFRP too.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9709/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16: In cop1Emulate(), keep converting the rounding mode]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -136,10 +136,13 @@
 #define FPU_CSR_COND7	0x80000000	/* $fcc7 */
 
 /*
- * Bits 18 - 20 of the FPU Status Register will be read as 0,
+ * Bits 22:20 of the FPU Status Register will be read as 0,
  * and should be written as zero.
  */
-#define FPU_CSR_RSVD	0x001c0000
+#define FPU_CSR_RSVD	(_ULCAST_(7) << 20)
+
+#define FPU_CSR_ABS2008	(_ULCAST_(1) << 19)
+#define FPU_CSR_NAN2008	(_ULCAST_(1) << 18)
 
 /*
  * X the exception cause indicator
@@ -687,6 +690,8 @@
 #define MIPS_FPIR_W		(_ULCAST_(1) << 20)
 #define MIPS_FPIR_L		(_ULCAST_(1) << 21)
 #define MIPS_FPIR_F64		(_ULCAST_(1) << 22)
+#define MIPS_FPIR_HAS2008	(_ULCAST_(1) << 23)
+#define MIPS_FPIR_UFRP		(_ULCAST_(1) << 28)
 
 /*
  * Bits in the MIPS32 Memory Segmentation registers.
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -929,10 +929,12 @@ emul:
 					 MIPSInst_RT(ir), value);
 
 				/*
-				 * Don't write reserved bits,
+				 * Don't write unsupported bits,
 				 * and convert to ieee library modes
 				 */
-				ctx->fcr31 = (value & ~(FPU_CSR_RSVD | FPU_CSR_RM)) |
+				ctx->fcr31 = (value &
+					      ~(FPU_CSR_RSVD | FPU_CSR_ABS2008 |
+						FPU_CSR_NAN2008 | FPU_CSR_RM)) |
 					     modeindex(value);
 			}
 			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
--- a/arch/mips/math-emu/ieee754.h
+++ b/arch/mips/math-emu/ieee754.h
@@ -195,15 +195,17 @@ static inline int ieee754dp_ge(union iee
  * The control status register
  */
 struct _ieee754_csr {
-	__BITFIELD_FIELD(unsigned pad0:7,
-	__BITFIELD_FIELD(unsigned nod:1,	/* set 1 for no denormalised numbers */
-	__BITFIELD_FIELD(unsigned c:1,		/* condition */
-	__BITFIELD_FIELD(unsigned pad1:5,
+	__BITFIELD_FIELD(unsigned fcc:7,	/* condition[7:1] */
+	__BITFIELD_FIELD(unsigned nod:1,	/* set 1 for no denormals */
+	__BITFIELD_FIELD(unsigned c:1,		/* condition[0] */
+	__BITFIELD_FIELD(unsigned pad0:3,
+	__BITFIELD_FIELD(unsigned abs2008:1,	/* IEEE 754-2008 ABS/NEG.fmt */
+	__BITFIELD_FIELD(unsigned nan2008:1,	/* IEEE 754-2008 NaN mode */
 	__BITFIELD_FIELD(unsigned cx:6,		/* exceptions this operation */
 	__BITFIELD_FIELD(unsigned mx:5,		/* exception enable  mask */
 	__BITFIELD_FIELD(unsigned sx:5,		/* exceptions total */
 	__BITFIELD_FIELD(unsigned rm:2,		/* current rounding mode */
-	;))))))))
+	;))))))))))
 };
 #define ieee754_csr (*(struct _ieee754_csr *)(&current->thread.fpu.fcr31))
 
