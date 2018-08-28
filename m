Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD52C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125D4208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCC+/h+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125D4208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeH1NET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:04:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33560 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeH1NES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:04:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so447856pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=hj1DhWCgZDwiFhg5QFAQVYtMr6py/Geftx6coxS25Do=;
        b=PCC+/h+02f+swgWKqYaDaDJRIhz8Vg//BE2/TDjGQbkMpd2LCnratRZEgKpqZCVAdG
         ReXOtAujXloiK8BgzujEpNq4f11CGmkTlBDilyqut81TxoWLue0MB6v2d3JfBkj+bD1Z
         lVaLoPF28yCiAsZsW4pkKlDAg78yo8h1M7XvFo7JUFCNO5JMzAUsdz/BDHBfd8le6PgC
         r2gtgaN0vav36HR6TY+VIunzFT2daVb9DsR54c2P1aViYCrI/coPeJmuCOx3M36Sj6/1
         6DTrstOQFusNgMGjRCelA9YqIrmik0vrR0+idfeAPDuPzgUhlxqkuOrO4/GpDeEybX3z
         FGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=hj1DhWCgZDwiFhg5QFAQVYtMr6py/Geftx6coxS25Do=;
        b=R8S8v/fFP+O04X+4dsrIA+guqj+lTjzrnwB6S/aWgfHQHzPBBU3vv0tfsJU9MvNb/A
         4OU6Vqbu4Vkhl60fPk0duccAuhXtJC8pQLBRZa8IZyOV/ooP0M9+A/Z3uNYCsdJQSRIN
         T09/H2IhqO+bedQPq2RfPF/WCteyG1/BW5gpNoZuSy8OH0yf+lVGgUP7kmYo2AXBIRV+
         hfw+iaUDCLVAQ5bw6GuMVpK2M0x+wGdET+fC0mYKYI4nLFCoRpLqM1gvHetqWlMy78Qd
         GJi22s4BOnwU1cfcPrenG5TJdT9RtTRL4PPpuGwUtTz0UqrRhCRICUYYkdYPMdwOzfjp
         crtg==
X-Gm-Message-State: APzg51CGeCObMH5D+UWasgxNY/7oXi03ES6Z4G7zVxM7yWhi88SQnZX7
        K2rPeHhoS9pWZcbsItiKK28=
X-Google-Smtp-Source: ANB0VdZavGJlhYWAxm3umvtYHV6/YWnn4QykgWTJ9Ws1BgMuHfyYYw0lVz1k/hAQKojQspGzQDXe7g==
X-Received: by 2002:a63:481:: with SMTP id 123-v6mr669973pge.129.1535447615746;
        Tue, 28 Aug 2018 02:13:35 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id l9-v6sm1083027pgg.79.2018.08.28.02.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:13:35 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] nds32: Only print one page of stack when die to prevent printing too much information.
Date:   Tue, 28 Aug 2018 17:12:20 +0800
Message-Id: <20180828091222.31672-1-greentime@andestech.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may print too much information sometimes if the stack is wrong or
too big. This patch can limit the debug information in a page of stack.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/kernel/traps.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index b0b85b7ab079..1496aab48998 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -173,11 +173,10 @@ void die(const char *str, struct pt_regs *regs, int err)
 	pr_emerg("CPU: %i\n", smp_processor_id());
 	show_regs(regs);
 	pr_emerg("Process %s (pid: %d, stack limit = 0x%p)\n",
-		 tsk->comm, tsk->pid, task_thread_info(tsk) + 1);
+		 tsk->comm, tsk->pid, end_of_stack(tsk));
 
 	if (!user_mode(regs) || in_interrupt()) {
-		dump_mem("Stack: ", regs->sp,
-			 THREAD_SIZE + (unsigned long)task_thread_info(tsk));
+		dump_mem("Stack: ", regs->sp, (regs->sp + PAGE_SIZE) & PAGE_MASK);
 		dump_instr(regs);
 		dump_stack();
 	}
-- 
2.18.0

