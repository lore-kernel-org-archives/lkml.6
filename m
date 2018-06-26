Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D515C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5632120B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrEoUoHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5632120B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeFZQO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:14:59 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41716 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeFZQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:14:57 -0400
Received: by mail-io0-f193.google.com with SMTP id k16-v6so13733450ioa.8;
        Tue, 26 Jun 2018 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gP9v2fmne2smu1Vznk+rGDHavaPx2W7RrXAKh5vt+Is=;
        b=qrEoUoHuwI6NXphZGBLEmKCuRfvfoM5vdx3ilWAMW6nW21qxNQv7Yd/mRiJ7k0p2FV
         H5SFIFE/W1945hxGtfQuIKahc2SaJ/DSDnMlAxjhvkIhu5un2i+YAA8Sq6h3OfFsr9Vv
         JbmdiM+8kwh6wQHQcYE5D+Kt7Duw0LATQW5+elAZvHUqHZCxV1YIbYB5EqPKPbDgZmKR
         xZONla7JCtsyXZ1Lvc6AtPqcymXN0hEJ9ST51eUsBB9k5yR4w6nYJ79vaeZQtSkDwASn
         vqZk7gB5RrSIgftV3s5d2icg1ZJDpdKMIMF+CgpA+P/1UKEQ1QeG+Tv5e6jjennIWgPp
         nHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gP9v2fmne2smu1Vznk+rGDHavaPx2W7RrXAKh5vt+Is=;
        b=HDtg7aFWMO/zFv5APE/aV5NlWS/V59W6a0qEalMcZfeAHlPGboBqXnc5poeS6+MwoK
         yXzy7zf6gcQY1JWxnnEn4aq0s8OgY9baTG6RRtPj9OK/O0ZuCC8gi86awTR8MOHbWyVe
         tZetngwlNkwCeJqDzQ5Ruy3up65mAztAQF0vjVhVLtssaB/4JDJjh7Ahn2eDEXf93LOG
         b+hIXlrL7DibrW+MfjmqV+fSGsPXWNPxqL0K3KBgtLApEzuJbD0nrbajedzpXo08Ew3t
         VfvL3Ryoqzx5dmxrdKc3hbsvjBzDsUnf/8Z+w6P65ifCNIfXWr4tUW0ytqFLyfvhkTuA
         iodQ==
X-Gm-Message-State: APt69E3/KfAlDJx/vZWxnWuKjzI/WXJ2/KC78ZxZOgwYUXPHVdrhin4L
        CpY2eI5AVr2ZNhLaBYRzEQ==
X-Google-Smtp-Source: AAOMgpcZMktJwACzg0V7ICXpum6v5PKdWIGsTOjcUTZfoiyzKCrxm59Mtsp+8/mjG2weQnPDqzd2vA==
X-Received: by 2002:a6b:5903:: with SMTP id n3-v6mr1803786iob.7.1530029696660;
        Tue, 26 Jun 2018 09:14:56 -0700 (PDT)
Received: from localhost ([2607:fcc8:9d4d:2c00:4078:ed49:e613:2b77])
        by smtp.gmail.com with ESMTPSA id p25-v6sm1105683itf.42.2018.06.26.09.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 09:14:56 -0700 (PDT)
From:   Mason Lee Back <masonleeback@gmail.com>
To:     pbonzini@redhat.com
Cc:     Mason Lee Back <masonleeback@gmail.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kvm: implement VEX prefix decoder, bextr/andn
Date:   Tue, 26 Jun 2018 06:14:49 -0600
Message-Id: <20180626121449.30353-1-masonleeback@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 arch/x86/include/asm/kvm_emulate.h | 17 ++++++
 arch/x86/kvm/emulate.c             | 96 +++++++++++++++++++++++++++---
 2 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
index 0f82cd91cd3c..7aa42ae90bf7 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -327,6 +327,23 @@ struct x86_emulate_ctxt {
 	 */
 	bool rip_relative;
 	u8 rex_prefix;
+	/* vex */
+	struct {
+		u8 prefix;
+		union {
+			struct {
+				uint8_t m : 5;
+				uint8_t b : 1;
+				uint8_t x : 1;
+				uint8_t r : 1;
+				uint8_t p : 2;
+				uint8_t l : 1;
+				uint8_t v : 4;
+				uint8_t w : 1;
+			};
+			u16 value;
+		};
+	}vex;
 	u8 lock_prefix;
 	u8 rep_prefix;
 	/* bitmaps of registers in _regs[] that can be read */
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 4c4f4263420c..2cca6d61a12f 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -66,6 +66,7 @@
 #define OpXLat            28ull  /* memory at BX/EBX/RBX + zero-extended AL */
 #define OpAccLo           29ull  /* Low part of extended acc (AX/AX/EAX/RAX) */
 #define OpAccHi           30ull  /* High part of extended acc (-/DX/EDX/RDX) */
+#define OpVex			  31ull  /* Vector extensions */
 
 #define OpBits             5  /* Width of operand field */
 #define OpMask             ((1ull << OpBits) - 1)
@@ -117,6 +118,7 @@
 #define SrcMem8     (OpMem8 << SrcShift)
 #define SrcAccHi    (OpAccHi << SrcShift)
 #define SrcMask     (OpMask << SrcShift)
+#define SrcVex      (OpVex << SrcShift)
 #define BitOp       (1<<11)
 #define MemAbs      (1<<12)      /* Memory operand is absolute displacement */
 #define String      (1<<13)     /* String instruction (rep capable) */
@@ -160,6 +162,7 @@
 #define Src2FS      (OpFS << Src2Shift)
 #define Src2GS      (OpGS << Src2Shift)
 #define Src2Mask    (OpMask << Src2Shift)
+#define Src2Vex     (OpVex << Src2Shift)
 #define Mmx         ((u64)1 << 40)  /* MMX Vector instruction */
 #define AlignMask   ((u64)7 << 41)
 #define Aligned     ((u64)1 << 41)  /* Explicitly aligned (e.g. MOVDQA) */
@@ -4118,6 +4121,46 @@ static int em_fxrstor(struct x86_emulate_ctxt *ctxt)
 	return rc;
 }
 
+static int em_andn(struct x86_emulate_ctxt *ctxt)
+{
+	u64 temp;
+	int signbit = 63;
+
+	temp = ~ctxt->src.val & ctxt->src2.val;
+	if (ctxt->op_bytes == 4) {
+		temp &= 0xFFFFFFFF;
+		signbit = 31;
+	}
+	ctxt->dst.val = temp;
+	ctxt->eflags &= ~EFLAGS_MASK;
+	ctxt->eflags |= (temp == 0) ? X86_EFLAGS_ZF : 0;
+	ctxt->eflags |= (temp >> signbit) ? X86_EFLAGS_SF : 0;
+
+	return X86EMUL_CONTINUE;
+}
+
+static int em_bextr(struct x86_emulate_ctxt *ctxt)
+{
+	u8 start, len;
+	u64 temp;
+
+	start = ctxt->src2.val & 0xFF;
+	len = (ctxt->src2.val >> 8) & 0xFF;
+	temp = ctxt->src.val;
+	if (ctxt->op_bytes == 4) 
+	{
+		temp &= 0xFFFFFFFF;
+	}
+
+	temp >>= start;
+	temp &= ~(~0ULL << len);
+	ctxt->dst.val = temp;
+	ctxt->eflags &= ~EFLAGS_MASK;
+	ctxt->eflags |= (temp == 0) ? X86_EFLAGS_ZF : 0;
+
+	return X86EMUL_CONTINUE;
+}
+
 static bool valid_cr(int nr)
 {
 	switch (nr) {
@@ -4849,7 +4892,10 @@ static const struct opcode opcode_map_0f_38[256] = {
 	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f0),
 	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f1),
 	/* 0xf2 - 0xff */
-	N, N, X4(N), X8(N)
+	I(ModRM | DstReg | SrcVex | Src2Mem, em_andn), 
+	X4(N),
+	I(ModRM | DstReg | SrcMem | Src2Vex, em_bextr),
+	X8(N)
 };
 
 #undef D
@@ -5208,15 +5254,51 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
 	}
 	ctxt->d = opcode.flags;
 
-	if (ctxt->d & ModRM)
-		ctxt->modrm = insn_fetch(u8, ctxt);
+	if (ctxt->b == 0xC4 || ctxt->b == 0xC5) {
+		ctxt->vex.prefix = ctxt->b;
+		if (ctxt->b == 0xC4) {
+			ctxt->vex.value = insn_fetch(u16, ctxt);
+		} else {
+			ctxt->vex.value = insn_fetch(u8, ctxt) << 8;
+			ctxt->vex.r = ctxt->vex.w;
+			ctxt->vex.w = 1;
+			ctxt->vex.x = 1;
+			ctxt->vex.b = 1;
+			ctxt->vex.m = 1;
+		}
 
-	/* vex-prefix instructions are not implemented */
-	if (ctxt->opcode_len == 1 && (ctxt->b == 0xc5 || ctxt->b == 0xc4) &&
-	    (mode == X86EMUL_MODE_PROT64 || (ctxt->modrm & 0xc0) == 0xc0)) {
-		ctxt->d = NotImpl;
+		if (mode != X86EMUL_MODE_PROT64 && (!ctxt->vex.r || !ctxt->vex.x)) {
+			/* todo: reinterpret as LES (0xC4) or LDS (0xC5) instruction */
+			return EMULATION_FAILED;
+		}
+
+		ctxt->rex_prefix |= ctxt->vex.r ? 0 : (1 << 2); /* rex.r */
+		ctxt->rex_prefix |= ctxt->vex.x ? 0 : (1 << 1); /* rex.x */
+		ctxt->rex_prefix |= ctxt->vex.b ? 0 : (1 << 0); /* rex.b */
+		if (mode == X86EMUL_MODE_PROT64 && ctxt->vex.w) {
+			ctxt->op_bytes = 8;
+		}
+
+		ctxt->b = insn_fetch(u8, ctxt);
+		switch (ctxt->vex.m) {
+		case 1:
+			opcode = twobyte_table[ctxt->b];
+			break;
+		case 2:
+			opcode = opcode_map_0f_38[ctxt->b];
+			break;
+		case 3:
+			/* KVM doesn't support this */
+			return EMULATION_FAILED;
+		default:
+			return EMULATION_FAILED;
+		}
 	}
 
+	ctxt->d = opcode.flags;
+	if (ctxt->d & ModRM)
+		ctxt->modrm = insn_fetch(u8, ctxt);
+
 	while (ctxt->d & GroupMask) {
 		switch (ctxt->d & GroupMask) {
 		case Group:
-- 
2.17.1

