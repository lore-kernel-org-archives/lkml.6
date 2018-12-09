Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBCFC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045DA20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544393010;
	bh=Rf43K54ogS258ol5X66usGQBwG82ZC4Qrk5E1V3uT3U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uKDh5x+h6vApFXp6bnRm0bxqIDbG9BrHxhji4FEnEpjslXZc+GTZrplGagJKYPAud
	 YjxZ2ZUPKiFNRoNDlDOuF98mxO578jcTtYsOjkcX1ABTQJZpAQYR8oY3p6AHSq1e6F
	 sOV7WaGMPhQN+u7ELjOSyzgAZcgux4OV5ZFGp95U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045DA20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeLIWD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:03:28 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40737 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeLIWDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:03:25 -0500
Received: by mail-wm1-f47.google.com with SMTP id q26so9263636wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 14:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=X5zk8nsK4IIMAtm01wdoqwoc6SRKa04AZ9pN5M4A7Nk=;
        b=kDA5Gs5jN0dgRc7lFEHPD7iUWMTgzBkGLqEv3d2G9WJnl+PRdyCsFLDw2ly0d8NqIt
         1Xx29HgwurVVMagoocTyOKuvjMYlMUOMRi4pIe4btZ/TRdWeP4YTjbeu5kSNPJQZoohG
         aTd/qnd0zNgT8m+ywDGN8z3G82DTkBo064GmRX1zHNNYlisqxdfFr8k07zx9pE+i7pZ5
         HZTF0HlcHqyZC6gJtJe1IAsnWjqAyzKI6Fi8gOAKi6Xjx4QWjoYpoGjrgODJcxohAI/p
         ITxx/xDwx5TwEZWKXlMuHlSljZdhx1x2NiEUk8BI6UUwWih+cd6/WuaS40uwuvj+cktB
         7yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=X5zk8nsK4IIMAtm01wdoqwoc6SRKa04AZ9pN5M4A7Nk=;
        b=qZhw5Xt++fvZF/NG5IuVknB0ylPt9vTSQjfNEdoBSCuM/iH2eLC0kx5sHj0I9B9qrJ
         82ZsTy8fepI0ecvENrrANlE1q6j5QJqBReLEhFEU5r8j81I4bAIjbYWPk1dx6zMr2J2o
         oEcnylQcchvnRUWMuIR3wGImb3TofDdP005/y83rJvWm95zCj5nKYW4YcdUBMOPjHlMo
         zWd/FGxPNhfVPQ/vcM988srBRZ9Pqd6bhGqw1E2I99F5fGWn28IbnUU4trQ30o41tpUF
         0gzIPv5prcaej1DN8MFeASe83KfuTSYL9l5kcj+O36NHXzLnwEWYaflOhxNQEs3zkJhM
         lelw==
X-Gm-Message-State: AA+aEWY4DVzqVGaDj8TYfwiPMlrNczrlZoiPsib8M1AiOrIr2xUJ3Or/
        MYG75mrZLfKbGQHzcc1fqD0=
X-Google-Smtp-Source: AFSGD/VTn6ALF9lvm34Iu/V03J2KvA7T5ooY/7jJisYmDSJwJz6zNY0qFR2vDrLlgAaBPr3+ecpy7g==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr8342094wmf.111.1544393003366;
        Sun, 09 Dec 2018 14:03:23 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x20sm20849681wme.6.2018.12.09.14.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 14:03:22 -0800 (PST)
Date:   Sun, 9 Dec 2018 23:03:20 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] kprobes fixes
Message-ID: <20181209220320.GA84693@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: a50480cb6d61d5c5fc13308479407b628b6bc1c5 kprobes/x86: Blacklist non-attachable interrupt functions

Two kprobes fixes: a blacklist fix and an instruction patching related 
corruption fix.

 Thanks,

	Ingo

------------------>
Andrea Righi (1):
      kprobes/x86: Blacklist non-attachable interrupt functions

Masami Hiramatsu (1):
      kprobes/x86: Fix instruction patching corruption when copying more than one RIP-relative instruction


 arch/x86/entry/entry_64.S     | 4 ++++
 arch/x86/kernel/kprobes/opt.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ce25d84023c0..1f0efdb7b629 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -566,6 +566,7 @@ ENTRY(interrupt_entry)
 
 	ret
 END(interrupt_entry)
+_ASM_NOKPROBE(interrupt_entry)
 
 
 /* Interrupt entry/exit. */
@@ -766,6 +767,7 @@ native_irq_return_ldt:
 	jmp	native_irq_return_iret
 #endif
 END(common_interrupt)
+_ASM_NOKPROBE(common_interrupt)
 
 /*
  * APIC interrupts.
@@ -780,6 +782,7 @@ ENTRY(\sym)
 	call	\do_sym	/* rdi points to pt_regs */
 	jmp	ret_from_intr
 END(\sym)
+_ASM_NOKPROBE(\sym)
 .endm
 
 /* Make sure APIC interrupt handlers end up in the irqentry section: */
@@ -960,6 +963,7 @@ ENTRY(\sym)
 
 	jmp	error_exit
 	.endif
+_ASM_NOKPROBE(\sym)
 END(\sym)
 .endm
 
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 40b16b270656..6adf6e6c2933 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -189,7 +189,7 @@ static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
 	int len = 0, ret;
 
 	while (len < RELATIVEJUMP_SIZE) {
-		ret = __copy_instruction(dest + len, src + len, real, &insn);
+		ret = __copy_instruction(dest + len, src + len, real + len, &insn);
 		if (!ret || !can_boost(&insn, src + len))
 			return -EINVAL;
 		len += ret;
