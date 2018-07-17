Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8ECECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE8520693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE8520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbeGQV3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:29:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:48314 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729907AbeGQV27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:28:59 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6HKsVhF030632;
        Wed, 18 Jul 2018 05:54:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Wed, 18 Jul 2018 05:54:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6HKsPYv030612
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Jul 2018 05:54:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] x86: Avoid pr_cont() in show_opcodes()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180707111209.GA27768@gmail.com>
 <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
 <12409dc4-c10a-d77a-f88d-165aa92b489e@rasmusvillemoes.dk>
 <f486debf-e824-0d0c-c0c9-cf1e278ee9eb@i-love.sakura.ne.jp>
 <218baff7-9473-ac1e-2449-13de98fa6dc9@rasmusvillemoes.dk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2c8fe03e-36f5-5126-283c-cabc358a7d52@i-love.sakura.ne.jp>
Date:   Wed, 18 Jul 2018 05:54:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <218baff7-9473-ac1e-2449-13de98fa6dc9@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected Signed-off-by: addresses.

From 96d9d4d135994a081e54d33d23f5007c53d9b5dd Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 17 Jul 2018 22:47:11 +0900
Subject: [PATCH v4] x86: Avoid pr_cont() in show_opcodes()

Since syzbot is confused by concurrent printk() messages [1],
this patch changes show_opcodes() to use %*ph format string.

When we start adding prefix to each line of printk() output,
we will be able to handle concurrent printk() messages.

[1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/dumpstack.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 666a284..ffdd484 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -93,26 +93,15 @@ static void printk_stack_address(unsigned long address, int reliable,
  */
 void show_opcodes(u8 *rip, const char *loglvl)
 {
-	unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
+	const unsigned int prologue = OPCODE_BUFSIZE * 2 / 3;
 	u8 opcodes[OPCODE_BUFSIZE];
-	u8 *ip;
-	int i;
 
-	printk("%sCode: ", loglvl);
-
-	ip = (u8 *)rip - code_prologue;
-	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
-		pr_cont("Bad RIP value.\n");
-		return;
-	}
-
-	for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
-		if (ip == rip)
-			pr_cont("<%02x> ", opcodes[i]);
-		else
-			pr_cont("%02x ", opcodes[i]);
-	}
-	pr_cont("\n");
+	if (probe_kernel_read(opcodes, rip - prologue, OPCODE_BUFSIZE))
+		printk("%sCode: Bad RIP value.\n", loglvl);
+	else
+		printk("%sCode: %*ph <%02x> %*ph\n", loglvl, prologue, opcodes,
+		       opcodes[prologue], OPCODE_BUFSIZE - prologue - 1,
+		       &opcodes[prologue + 1]);
 }
 
 void show_ip(struct pt_regs *regs, const char *loglvl)
-- 
1.8.3.1



