Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578A3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A0020837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYUh2g6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A0020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeHaR7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:59:43 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:53588 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeHaR7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:59:43 -0400
Received: by mail-yw1-f73.google.com with SMTP id g126-v6so8406621ywg.20
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RPN2S1NHn+2YDmI7u9kXCHpH3MKVKL/Zd+8oO0UdIZk=;
        b=TYUh2g6MvPPUbwkKotZP/o0aqiaS/Za1QhDW5mQwOZ1RHR516FdMyDb/D/tXXGp332
         YDVBT4BWwPWi4ydrzpzuEifeYUZyMYoz29aFavPNTqkB1qOC5qD68ZRZpoLCvSNxhilm
         Y/LaHpdI2o6tw47x3BXwE9PEzy1bH90YtPLsw/W0dmHPaVeVFzvoRKonoH0WdHoxCP6s
         xEpg6+olybbycW09F/mOr8fG6vlldPo7eyw3f6ju37ih+uwwC57u3G713eyzCwWgLQlU
         hK+gG6vB4xuRsGW6vQsMjcuZWVSpr0AcyEr95TNAyz0jmcY+F4lit1mXUDyOF4W8s8De
         ndNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RPN2S1NHn+2YDmI7u9kXCHpH3MKVKL/Zd+8oO0UdIZk=;
        b=dYokMDGokHD5oEqc1egf3Ly0r1YF4ILynarB9wvCpmnA1+30bFRbQeq8qaE/dF8gCI
         OyORWs1E9wND2z4W8pI6jIWPCam0NTwSOhlaKZ4Z1L2wz38VkejpdZFjypumwXF6X3X7
         MQoWFOz5wh1yrfP7whOthmvNttd0F/2NaGv6gWpnBb0iP1XotXxm94ZogKZKvnuwhy30
         qKNERN7WJhIv8GOr+6pxBtwXhNicH6+d19NXGwRlFa0GGW15nzQa3RR1OPHKW4qFp2HR
         HS6etMJydgktKwoya2AqIne1wPjSVjLEye+qpaAxpmhMcWDurd1FXTj7p2/7KkmfCXQz
         5iSg==
X-Gm-Message-State: APzg51CjVPWVZ166gl6MOolswGpkM3aERepDyIvTL6xqZwi0epPF7f84
        26zLz7thoM9F+qKysz9yBtQsexusAQ==
X-Google-Smtp-Source: ANB0VdZTjsiOYBSuwTjy8SqeSG5jQFQv4AuPukIqMfoht1ayKeiOD21kITgLXy5RYqspsqZeyTkwq5ehKg==
X-Received: by 2002:a81:b381:: with SMTP id r123-v6mr2852732ywh.216.1535723527369;
 Fri, 31 Aug 2018 06:52:07 -0700 (PDT)
Date:   Fri, 31 Aug 2018 15:51:52 +0200
Message-Id: <20180831135152.171747-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH v2] x86/dumpstack: fix address space casting in show_opcodes()
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sloppily passed a kernel-typed pointer to __range_not_ok(), and sparse
doesn't like that.
Make `prologue` an unsigned long and cast it to a kernel pointer when
calling probe_kernel_read(), just like ~everyone else who calls
probe_kernel_read().
Instead of __range_not_ok() with a cast, call __chk_range_not_ok directly.

Fixes: a644cf538b11 ("x86/dumpstack: Don't dump kernel memory based on usermode RIP")
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/dumpstack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 605c60b1624f..f56895106ccf 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -96,7 +96,7 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 #define EPILOGUE_SIZE 21
 #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
 	u8 opcodes[OPCODE_BUFSIZE];
-	u8 *prologue = (u8 *)(regs->ip - PROLOGUE_SIZE);
+	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
 	bool bad_ip;
 
 	/*
@@ -104,9 +104,10 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 	 * memory by pointing the userspace instruction pointer at it.
 	 */
 	bad_ip = user_mode(regs) &&
-		__range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
+		__chk_range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
 
-	if (bad_ip || probe_kernel_read(opcodes, prologue, OPCODE_BUFSIZE)) {
+	if (bad_ip || probe_kernel_read(opcodes, (u8 *)prologue,
+					OPCODE_BUFSIZE)) {
 		printk("%sCode: Bad RIP value.\n", loglvl);
 	} else {
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

