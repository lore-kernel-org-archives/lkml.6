Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA55EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668492085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRAhz7/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668492085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbeKFQne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:43:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43128 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbeKFQne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:43:34 -0500
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so5400125pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 23:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=VhqwiRJVewsvjrVYgT58Eqm7HsVp4xYXZ9L9ccRvD+s=;
        b=oRAhz7/T7M1VHZYu71FDZWupZoEIrBV9xXtJgQF2muXgZ5i6ZDu8p1c5Lt17EWv+5y
         Jbwhz1cSANOyuF8lapVlaHJ8Er0dmZmcD+t6Yh2tf5lMJD82/Pn5JrkBHWnEpqTtdIXS
         Om8srcjQ1IN3CP/rULsq4m2WcDywEQQqEMj/9ijqCLOsTAwOaqMQDpA2t9VH5DoslVO6
         NDz99J1lMwHOgvqYkcjSJDzZae7a1xDhmVYGkE/Hc/zSxxG8lz6KHTkt5ht+I8Mk0MvV
         SRezzTV0QBm4AXb/IW+srz3e0lkI7zLZhJ+LPJPEnOGm2/i9mV7YIjiyiKqL1mSABThX
         Y91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=VhqwiRJVewsvjrVYgT58Eqm7HsVp4xYXZ9L9ccRvD+s=;
        b=cjT2exrtqVeLO2o7TRIMWeUXFYnXyzEn6DBtHjn2xw2pswoZxZHWCrj6kcbelTX0oC
         6HghQNRnZ+MJYiLpglHbsDp2uYGBgukzeYLmjDdQhRYJPQg7O3SskLSqwODi1+18yL2Y
         BCh1RKFyPovslL/IJuAG0SndYuixGTwEjzUvWsIeLGRih3F2WinKbJqWHAsm3kFSaQsr
         jyOJrlL4dySS7i7x2ckLCvgYhHNpd0fJdAOm5SPkWwaw9nxg4LxQSzxoT5vzfCZpj99e
         ce6Tw8eMYdaqVI2yHZWuHqBDCxX7ws5Ju+1Me1Kw1rqwUNdsLOxyuSJKnz/wdxPxMUun
         ZaOQ==
X-Gm-Message-State: AGRZ1gJRiia9gTBMB4uwurhAHDkfHOwcAW7xLY5Q/5Qyog64hcMkP9bE
        A5pWw7hVM2rjViFxE/wru/PBnYdf
X-Google-Smtp-Source: AJdET5c/qVse4CtsW5UB+G/TNjIdTXD0+QueFWVF4GtT7yDMHZqnzklluBFLqBtUNDz5r2JFe6NDLA==
X-Received: by 2002:a62:5e83:: with SMTP id s125-v6mr10679627pfb.232.1541488783752;
        Mon, 05 Nov 2018 23:19:43 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o27-v6sm60832337pfk.85.2018.11.05.23.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 23:19:43 -0800 (PST)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Michael Weiser <michael.weiser@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/arm64 : fix error in dump_backtrace
Date:   Tue,  6 Nov 2018 15:19:35 +0800
Message-Id: <1541488775-29610-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

In some cases, the instruction of "bl foo1" will be the last one of the
foo2[1], which will cause the lr be the first instruction of the adjacent
foo3[2]. Hence, the backtrace will show the weird result as bellow[3].
The patch will fix it by miner 4 of the lr when dump_backtrace

[1]
0xffffff80081e6b04 <handle_mm_fault+3996>:      adrp    x0, 0xffffff8008ca8000
0xffffff80081e6b08 <handle_mm_fault+4000>:      add     x0, x0, #0x5a8
0xffffff80081e6b0c <handle_mm_fault+4004>:      bl      0xffffff80081b0ca0 <panic>
0xffffff80081e6b10 <access_remote_vm>:  stp     x29, x30, [sp,#-64]!
0xffffff80081e6b14 <access_remote_vm+4>:        mov     x29, sp

[2]
crash_arm64> rd ffffffc02eec3bd0 2
ffffffc02eec3bd0:  ffffffc02eec3cb0 ffffff80081e6b10

[3]
wrong:
[<ffffff80081b0d90>] panic+0xf0/0x24c
[<ffffff80081e6b10>] access_remote_vm+0x0/0x5c
[<ffffff800809d7b0>] do_page_fault+0x290/0x3b8
[<ffffff8008081570>] do_mem_abort+0x64/0xdc

correct:
[ffffffc02eec3bd0] panic at ffffff80081b0da4
[ffffffc02eec3cb0] handle_mm_fault at ffffff80081e6b0c
[ffffffc02eec3d80] do_page_fault at ffffff800809d7ac
[ffffffc02eec3df0] do_mem_abort at ffffff800808156c

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 arch/arm64/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d399d45..7a097cc 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -113,7 +113,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 
 	if (tsk == current) {
 		frame.fp = (unsigned long)__builtin_frame_address(0);
-		frame.pc = (unsigned long)dump_backtrace;
+		frame.pc = (unsigned long)dump_backtrace + 4;
 	} else {
 		/*
 		 * task blocked in __switch_to
@@ -130,7 +130,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	do {
 		/* skip until specified stack frame */
 		if (!skip) {
-			dump_backtrace_entry(frame.pc);
+			dump_backtrace_entry(frame.pc - 4);
 		} else if (frame.fp == regs->regs[29]) {
 			skip = 0;
 			/*
-- 
1.9.1

