Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6118CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E47C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k491ESF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E47C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeH3Xva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:51:30 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:53659 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeH3Xv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:51:29 -0400
Received: by mail-it0-f73.google.com with SMTP id d14-v6so2883743itc.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r8cWiaVKXuZOHVg9hO8ZjYewFazPPAgn1/cjdHRg1rs=;
        b=k491ESF4czlOX1BLxwCFaumCIzFZaVmuqaBqr9vu5Cre2qKfzzWujfsGuKFuUIN5yS
         g9wZihxQpMqYotrU4EzsEoUwNi9Ia0fGPBr8apD5LzrOzUrQYu9/kr2B+kxdbm9IIcsB
         A5yDmXME6iyZf4VhAKWYvAtlOvggY9uXzOudKciHUMYsxywrWeg3f776u6ACx1XK2AFd
         43WQP5BvY65CjJOC6VqpOIUTNtwQpVZdYbA3CPEFMq0c1KlPOAGxR3QB8yjarLhnGwwR
         7mhs0ddZ2gPoR+afaKv/5Z/P7SP8wZ9/OrCLMlrHPsfhgvNSYUZvsQdRpJW8jMoYEkM1
         K5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r8cWiaVKXuZOHVg9hO8ZjYewFazPPAgn1/cjdHRg1rs=;
        b=tYEr1RpLvzvfAtO1l6an1qK1+srg0fZX6KzqFXi3uV6vcsU4fA4Glu6w/x3tnYA15a
         NkgOo/LE4nLvEQm4WCCFup1jLCCNw2HsC97BzMueuZ9PTRzEMc+upWlNoEF87fXquS8e
         bT0RDrRS31iBdtxwyGq2kQrKsaTLrRvfCS11PTpGb0BKUpSx5vkf2+DbXi+147PHYimH
         ImKnVE9BvHAw1ikjMAfU2W/cUJwxCrBC1C1DuQr+evAYdXz8fz5rnAFoLj43vjZl7lXY
         4vkpd5QqMRRPxefBxPFRYiLXj/cE92gHZ9pGehdNwi1kc6VPB9Zy4mbuV+7Sd3iWa6+0
         w1vA==
X-Gm-Message-State: APzg51DLg/yopThcjeHxZ5jNHwC3BHeiFlQpPfJixqe/AgzslRit5xVO
        EVulxWHtJrw396VxyQQmHcER2mQpZA==
X-Google-Smtp-Source: ANB0VdacWRAD27gIGCtJjclsvcBdvGw1tSFq+EgdpQYMPPBTHv211xovftE0QT0aL750ixVtyXdTpnjyjg==
X-Received: by 2002:a24:5e93:: with SMTP id h141-v6mr1805255itb.19.1535658462443;
 Thu, 30 Aug 2018 12:47:42 -0700 (PDT)
Date:   Thu, 30 Aug 2018 21:47:36 +0200
Message-Id: <20180830194736.210039-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH] x86/dumpstack: fix address space casting in show_opcodes()
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sloppily passed a kernel-typed pointer to __range_not_ok(), and sparse
doesn't like that.
Make `prologue` a __user pointer (to protect against accidental
dereferences) and force-cast it to a kernel pointer when calling
probe_kernel_read(), which will then immediately force-cast it back to a
user pointer.

Fixes: a644cf538b11 ("x86/dumpstack: Don't dump kernel memory based on usermode RIP")
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/dumpstack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 605c60b1624f..651aed36291a 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -96,7 +96,7 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 #define EPILOGUE_SIZE 21
 #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
 	u8 opcodes[OPCODE_BUFSIZE];
-	u8 *prologue = (u8 *)(regs->ip - PROLOGUE_SIZE);
+	u8 __user *prologue = (u8 __user *)(regs->ip - PROLOGUE_SIZE);
 	bool bad_ip;
 
 	/*
@@ -106,7 +106,8 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 	bad_ip = user_mode(regs) &&
 		__range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
 
-	if (bad_ip || probe_kernel_read(opcodes, prologue, OPCODE_BUFSIZE)) {
+	if (bad_ip || probe_kernel_read(opcodes, (__force u8 *)prologue,
+					OPCODE_BUFSIZE)) {
 		printk("%sCode: Bad RIP value.\n", loglvl);
 	} else {
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

