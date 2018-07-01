Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB561C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 07:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6B024F3C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 07:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwLwuoAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6B024F3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeGAHr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 03:47:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34822 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbeGAHr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 03:47:26 -0400
Received: by mail-pl0-f65.google.com with SMTP id k1-v6so6477261plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 00:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KJxujqIsxbshG/5M2I8trplc1K+XiWvOqPOO0DZgX5M=;
        b=nwLwuoAknqLJ8H9OdcDyyS8UlKW0MJjFoO0ePzi+ILB8djD1+JeeVHelg6kusMhZOH
         d6yEo7nUR65l2MeRWZ2vxdPQLSX3IGL572vKqsHqMe4vPKwnYMGnxXg0YZQbWjboe3cS
         o6vMJiu1OGAocXnD9BPINv1RKY1vM4uXqRgJWCkd1AiwAvldyy981afSqQMT9lJ4Cb1e
         1S9z3q3fFVvM8Y1JtSTpBhZhUm1aIl6bvnrpVxq4YPlr9uM7FIQBimMKZJmNvaqQA+kR
         fz+hU6X+xw+N1F2qNTWfdcPji4uyPIHuIGJpJbfxWsY5N0GIR73icdnhKPZWQ2Dckwig
         bfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KJxujqIsxbshG/5M2I8trplc1K+XiWvOqPOO0DZgX5M=;
        b=BaDvJWTM8UmTmeGPqZsuwjYkqFtSwmr+4LCy3c4as36iCyvpkd894j2UzWCLAD2VWT
         MJymkiTVTwjmjHjR3H3vtBLJBYXdKqqK0hz7HuTxwN3X0AGyJeC7vHK5n7swxopQdkhr
         wu2TrHriRyIt3AgybfIymhP1UEBjDCxHS3QPhEr5cQI6J8arO/rnGvVxY49rCoyw9UOv
         wf7QxCILZGTaXePiWZmgpwFPHt3FXFXnbM7NGQgNudcKSlD1ze4VUQCGxfK+R+wETzq8
         OVvUTOcRUcTjnosqQZml5FQphlQQL9j0z7+Ay0DauqQyoMpB6yavJ0R98IL2KRA5SYb1
         Sy3Q==
X-Gm-Message-State: APt69E2zCNpAI5NmkRI72+FMF/6VukZ74wJ5kV1Lq9ZutVPX4/jA3thg
        evzdU3etZfSzYig/3oJiKhh+j7w2gn4=
X-Google-Smtp-Source: ADUXVKL20YIDNkNwMv9ucXlrvowu36iEzCblZF3sHGmgQNBtIwm9IzjgxwDSeQMCVccBUfbOHnIPDA==
X-Received: by 2002:a17:902:6e09:: with SMTP id u9-v6mr20915822plk.13.1530431245421;
        Sun, 01 Jul 2018 00:47:25 -0700 (PDT)
Received: from localhost (g90.124-44-6.ppp.wakwak.ne.jp. [124.44.6.90])
        by smtp.gmail.com with ESMTPSA id x11-v6sm827078pge.15.2018.07.01.00.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 00:47:24 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, openrisc@lists.librecores.org
Subject: [PATCH] openrisc: entry: Fix delay slot exception detection
Date:   Sun,  1 Jul 2018 16:47:02 +0900
Message-Id: <20180701074705.849-1-shorne@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally in patch e6d20c55a4 ("openrisc: entry: Fix delay slot
detection") I fixed delay slot detection, but only for QEMU.  We missed
that hardware delay slot detection using delay slot exception flag (DSX)
was still broken.  This was because QEMU set the DSX flag in both
pre-exception supervision register (ESR) and supervision register (SR)
register, but on real hardware the DSX flag is only set on the SR
register during exceptions.

Fix this by carrying the DSX flag into the SR register during exception.
We also update the DSX flag read locations to read the value from the SR
register not the pt_regs SR register which represents ESR.  The ESR
should never have the DSX flag set.

In the process I updated/removed a few comments to match the current
state.  Including removing a comment saying that the DSX detection logic
was inefficient and needed to be rewritten.

I have tested this on QEMU with a patch ensuring it matches the hardware
specification.

Link: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg00000.html
Fixes: e6d20c55a4 ("openrisc: entry: Fix delay slot detection")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 8 +-------
 arch/openrisc/kernel/head.S  | 9 ++++++---
 arch/openrisc/kernel/traps.c | 2 +-
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 690d55272ba6..0c826ad6e994 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -277,12 +277,6 @@ EXCEPTION_ENTRY(_data_page_fault_handler)
 	l.addi  r3,r1,0                    // pt_regs
 	/* r4 set be EXCEPTION_HANDLE */   // effective address of fault
 
-	/*
-	 * __PHX__: TODO
-	 *
-	 * all this can be written much simpler. look at
-	 * DTLB miss handler in the CONFIG_GUARD_PROTECTED_CORE part
-	 */
 #ifdef CONFIG_OPENRISC_NO_SPR_SR_DSX
 	l.lwz   r6,PT_PC(r3)               // address of an offending insn
 	l.lwz   r6,0(r6)                   // instruction that caused pf
@@ -314,7 +308,7 @@ EXCEPTION_ENTRY(_data_page_fault_handler)
 
 #else
 
-	l.lwz   r6,PT_SR(r3)               // SR
+	l.mfspr r6,r0,SPR_SR               // SR
 	l.andi  r6,r6,SPR_SR_DSX           // check for delay slot exception
 	l.sfne  r6,r0                      // exception happened in delay slot
 	l.bnf   7f
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index fb02b2a1d6f2..9fc6b60140f0 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -210,8 +210,7 @@
  *	 r4  - EEAR     exception EA
  *	 r10 - current	pointing to current_thread_info struct
  *	 r12 - syscall  0, since we didn't come from syscall
- *	 r13 - temp	it actually contains new SR, not needed anymore
- *	 r31 - handler	address of the handler we'll jump to
+ *	 r30 - handler	address of the handler we'll jump to
  *
  *	 handler has to save remaining registers to the exception
  *	 ksp frame *before* tainting them!
@@ -244,6 +243,7 @@
 	/* r1 is KSP, r30 is __pa(KSP) */			;\
 	tophys  (r30,r1)					;\
 	l.sw    PT_GPR12(r30),r12				;\
+	/* r4 use for tmp before EA */				;\
 	l.mfspr r12,r0,SPR_EPCR_BASE				;\
 	l.sw    PT_PC(r30),r12					;\
 	l.mfspr r12,r0,SPR_ESR_BASE				;\
@@ -263,7 +263,10 @@
 	/* r12 == 1 if we come from syscall */			;\
 	CLEAR_GPR(r12)						;\
 	/* ----- turn on MMU ----- */				;\
-	l.ori	r30,r0,(EXCEPTION_SR)				;\
+	/* Carry DSX into exception SR */			;\
+	l.mfspr r30,r0,SPR_SR					;\
+	l.andi	r30,r30,SPR_SR_DSX				;\
+	l.ori	r30,r30,(EXCEPTION_SR)				;\
 	l.mtspr	r0,r30,SPR_ESR_BASE				;\
 	/* r30:	EA address of handler */			;\
 	LOAD_SYMBOL_2_GPR(r30,handler)				;\
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index fac246e6f37a..d8981cbb852a 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -300,7 +300,7 @@ static inline int in_delay_slot(struct pt_regs *regs)
 		return 0;
 	}
 #else
-	return regs->sr & SPR_SR_DSX;
+	return mfspr(SPR_SR) & SPR_SR_DSX;
 #endif
 }
 
-- 
2.17.0

