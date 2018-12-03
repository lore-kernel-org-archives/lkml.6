Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D925C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1731920864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6XZD/hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1731920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeLCVX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:23:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50210 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCVX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:23:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so4976562wmd.0;
        Mon, 03 Dec 2018 13:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VY0CS726ctG/XTA5cA2acotby14lIXeidLt3qAUnP5A=;
        b=g6XZD/hmUjVmC8T3y+LnBc9AHouQ8nJmYXrYF7g81N+AtjF6JeEgi8GOV9C6INzmFN
         Tapl7XDmo1+sbakBdjuz6XGOcVhpO7+Z25aywkg63tUMp/4T9zaTD2dk8hy+6OOJ2EPv
         Y6k53v5vE7j0F3Rthl+uaNzsm66cQgdCShng6R9OjD2NHio3g04NsbMrnQ33LHZ5ekEf
         eWlfU7zd4A/nHySOtfkEQgOoRtB3wGkCz/6z5s5tyvglvhJ9yAqnBIiluXG+7pgJLkN0
         7aa42Wsd+qMl7lx+cClwWmRl/Wtc5+SuD16gYU/KWylrbT+hYxMoN2UVPwZ8mqrsr3eP
         2Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VY0CS726ctG/XTA5cA2acotby14lIXeidLt3qAUnP5A=;
        b=n6oRsGjsnyG24mmmoKxgao+lOcJB633XJS1av6/eOh3nMLHgu7OScJqDxnh+cUVud0
         cS9HOqkc5vdCCJ6i7Ve9C+9EMN+SjetXO+YFGu2WbKKqoiyl/TFLh0CmsLh58A5TDcS0
         1S9kbkMmWBFqV1UzLw47YcUsvMNjZAPtDkGL8ALtHcUKqZA2mS8hWCDYGoD6ByNqAkb1
         RBBht+Fjt7HoBSUzqdyy1gppdJV3E0/S+6CiUQdSn6a/RmX3YZe4XwSXvwggnityt3vn
         /iKGpZtrsDuKFMaVRVWMWe4cq9Z5qtrzmrmvWoXO7jgdqFN3c5xZZ8je0r/cIDpHQtxq
         gwbQ==
X-Gm-Message-State: AA+aEWZ4/KdD7KqeSTe8qQITpf36DC4inlW7xwqJBXqlWrkw/nr3a7Yu
        UtKZ0NOQtxZsjYcnW/N3PS4=
X-Google-Smtp-Source: AFSGD/UiGWzFVYkBJhWZkQ3FArjzT0Hpcpa3XZ5S+W3ANCw2SeKFYhHtR4Bg9RtZrjRAnvkqUz3oSQ==
X-Received: by 2002:a1c:66c5:: with SMTP id a188mr9469935wmc.129.1543872232821;
        Mon, 03 Dec 2018 13:23:52 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id 14sm16869166wmv.36.2018.12.03.13.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 13:23:52 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 1A638114100F; Mon,  3 Dec 2018 22:23:50 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Kees Cook <keescook@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: annotate implicit fall throughs
Date:   Mon,  3 Dec 2018 22:23:43 +0100
Message-Id: <20181203212344.9372-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings. Fix them up.

This patch produces no change in behaviour, but should be reviewed in
case these are actually bugs not intentional fallthoughs.

Cc: Kees Cook <keescook@google.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/kernel/branch.c    |  7 +++++++
 arch/mips/kernel/cpu-probe.c |  7 +++++++
 arch/mips/kernel/watch.c     | 13 +++++++++++++
 arch/mips/mm/c-r4k.c         |  2 ++
 arch/mips/mm/tlbex.c         |  1 +
 5 files changed, 30 insertions(+)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index e48f6c0a9e4a..a81862493c3d 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -447,6 +447,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		case bltzl_op:
 			if (NO_R6EMU)
 				goto sigill_r2r6;
+			/* fall through */
 		case bltz_op:
 			if ((long)regs->regs[insn.i_format.rs] < 0) {
 				epc = epc + 4 + (insn.i_format.simmediate << 2);
@@ -460,6 +461,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		case bgezl_op:
 			if (NO_R6EMU)
 				goto sigill_r2r6;
+			/* fall through */
 		case bgez_op:
 			if ((long)regs->regs[insn.i_format.rs] >= 0) {
 				epc = epc + 4 + (insn.i_format.simmediate << 2);
@@ -555,6 +557,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	case jalx_op:
 	case jal_op:
 		regs->regs[31] = regs->cp0_epc + 8;
+		/* fall through */
 	case j_op:
 		epc += 4;
 		epc >>= 28;
@@ -571,6 +574,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	case beql_op:
 		if (NO_R6EMU)
 			goto sigill_r2r6;
+		/* fall through */
 	case beq_op:
 		if (regs->regs[insn.i_format.rs] ==
 		    regs->regs[insn.i_format.rt]) {
@@ -585,6 +589,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	case bnel_op:
 		if (NO_R6EMU)
 			goto sigill_r2r6;
+		/* fall through */
 	case bne_op:
 		if (regs->regs[insn.i_format.rs] !=
 		    regs->regs[insn.i_format.rt]) {
@@ -599,6 +604,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	case blezl_op: /* not really i_format */
 		if (!insn.i_format.rt && NO_R6EMU)
 			goto sigill_r2r6;
+		/* fall through */
 	case blez_op:
 		/*
 		 * Compact branches for R6 for the
@@ -634,6 +640,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	case bgtzl_op:
 		if (!insn.i_format.rt && NO_R6EMU)
 			goto sigill_r2r6;
+		/* fall through */
 	case bgtz_op:
 		/*
 		 * Compact branches for R6 for the
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d535fc706a8b..7f4df795d1d2 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -489,12 +489,16 @@ static void set_isa(struct cpuinfo_mips *c, unsigned int isa)
 	switch (isa) {
 	case MIPS_CPU_ISA_M64R2:
 		c->isa_level |= MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2;
+		/* fall through */
 	case MIPS_CPU_ISA_M64R1:
 		c->isa_level |= MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1;
+		/* fall through */
 	case MIPS_CPU_ISA_V:
 		c->isa_level |= MIPS_CPU_ISA_V;
+		/* fall through */
 	case MIPS_CPU_ISA_IV:
 		c->isa_level |= MIPS_CPU_ISA_IV;
+		/* fall through */
 	case MIPS_CPU_ISA_III:
 		c->isa_level |= MIPS_CPU_ISA_II | MIPS_CPU_ISA_III;
 		break;
@@ -502,14 +506,17 @@ static void set_isa(struct cpuinfo_mips *c, unsigned int isa)
 	/* R6 incompatible with everything else */
 	case MIPS_CPU_ISA_M64R6:
 		c->isa_level |= MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6;
+		/* fall through */
 	case MIPS_CPU_ISA_M32R6:
 		c->isa_level |= MIPS_CPU_ISA_M32R6;
 		/* Break here so we don't add incompatible ISAs */
 		break;
 	case MIPS_CPU_ISA_M32R2:
 		c->isa_level |= MIPS_CPU_ISA_M32R2;
+		/* fall through */
 	case MIPS_CPU_ISA_M32R1:
 		c->isa_level |= MIPS_CPU_ISA_M32R1;
+		/* fall through */
 	case MIPS_CPU_ISA_II:
 		c->isa_level |= MIPS_CPU_ISA_II;
 		break;
diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
index 0e61a5b7647f..ba73b4077668 100644
--- a/arch/mips/kernel/watch.c
+++ b/arch/mips/kernel/watch.c
@@ -27,12 +27,15 @@ void mips_install_watch_registers(struct task_struct *t)
 	case 4:
 		write_c0_watchlo3(watches->watchlo[3]);
 		write_c0_watchhi3(watchhi | watches->watchhi[3]);
+		/* fall through */
 	case 3:
 		write_c0_watchlo2(watches->watchlo[2]);
 		write_c0_watchhi2(watchhi | watches->watchhi[2]);
+		/* fall through */
 	case 2:
 		write_c0_watchlo1(watches->watchlo[1]);
 		write_c0_watchhi1(watchhi | watches->watchhi[1]);
+		/* fall through */
 	case 1:
 		write_c0_watchlo0(watches->watchlo[0]);
 		write_c0_watchhi0(watchhi | watches->watchhi[0]);
@@ -55,10 +58,13 @@ void mips_read_watch_registers(void)
 		BUG();
 	case 4:
 		watches->watchhi[3] = (read_c0_watchhi3() & watchhi_mask);
+		/* fall through */
 	case 3:
 		watches->watchhi[2] = (read_c0_watchhi2() & watchhi_mask);
+		/* fall through */
 	case 2:
 		watches->watchhi[1] = (read_c0_watchhi1() & watchhi_mask);
+		/* fall through */
 	case 1:
 		watches->watchhi[0] = (read_c0_watchhi0() & watchhi_mask);
 	}
@@ -85,18 +91,25 @@ void mips_clear_watch_registers(void)
 		BUG();
 	case 8:
 		write_c0_watchlo7(0);
+		/* fall through */
 	case 7:
 		write_c0_watchlo6(0);
+		/* fall through */
 	case 6:
 		write_c0_watchlo5(0);
+		/* fall through */
 	case 5:
 		write_c0_watchlo4(0);
+		/* fall through */
 	case 4:
 		write_c0_watchlo3(0);
+		/* fall through */
 	case 3:
 		write_c0_watchlo2(0);
+		/* fall through */
 	case 2:
 		write_c0_watchlo1(0);
+		/* fall through */
 	case 1:
 		write_c0_watchlo0(0);
 	}
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 05bd77727fb9..4f0e1fc9f887 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1251,6 +1251,7 @@ static void probe_pcache(void)
 
 	case CPU_VR4133:
 		write_c0_config(config & ~VR41_CONF_P4K);
+		/* fall through */
 	case CPU_VR4131:
 		/* Workaround for cache instruction bug of VR4131 */
 		if (c->processor_id == 0x0c80U || c->processor_id == 0x0c81U ||
@@ -1498,6 +1499,7 @@ static void probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_PINDEX;
 			break;
 		}
+		/* fall through */
 	default:
 		if (has_74k_erratum || c->dcache.waysize > PAGE_SIZE)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 067714291643..37b1cb246332 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -576,6 +576,7 @@ void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_R5500:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
+		/* fall through */
 	case CPU_ALCHEMY:
 		tlbw(p);
 		break;
-- 
2.19.2

