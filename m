Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3869114-1524811390-2-13798520688471303569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524811389; b=K3+KrgNMYPYdejSd9zIdC9QWGx+6Cb/1SinvaI4hO0KqZE6jI3
    L0KGUBgbliN6u1ATEt/YZ/hXYD+BjLPfjhR0urIZhbPT8THpve7gxpTtBXmwChBr
    Rwll2PsrfcXykJzZ9XHnGM2q6SL0Azt7p+bLPf7q2AArBcFIh9DQD7PLEJglW/IS
    uAYSOBFeMPrxfuqQyuTl+FzndBGWrW6RIcO/66SokGBPtE25lkBUDzwNSQgMznAF
    Sp+P0HtmQlk3l9nLsUDePZs6kzTk+L3sms1wlfprMXR2fqhRbye86irMJe+5fSu2
    j0LBT7osZJH5ZSgAkZ9CFE94+leL4vpaqR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524811389;
    bh=mA1zVk7aXweYzeGkQaHpLZc/FLUzv0p1mhLbbqZPSxo=; b=WEwXZ1wtaC+R
    7+oNK1QXaIheaHq6nFo6dGW6YJwmD9RxmP+vJXM/jaNC78qYBSa/akmCytjAIopt
    21y+a4xL6jl66gSkl+kEqSDxHBmQM0TbWMP21nU++ACjZp1Fbv5aGMd26xZN7+ho
    cjfL1c+U2UdyQApkgvYL2yI8VfyeStC1+otUZfJmPbecqcZHLAYfuO990VXwzNhp
    39VAQd/Xap6hxbQ2GPCm+rf5CfvG/R8YYjuWe4wCa6vzFGhkmU1Y8N4eCmW6wsJQ
    0Okgg4NLvU5brTYT7v8RxVvsv8TjRpYSg8j50vFRhAGFqbgxXK46+t0UwTviK58T
    yMyQ/XvINA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK2kdsqcjLBjY354mMnaLwXKH48/GO37GQFuOSeUIA8OAz4H4EckrBqKVWQkQFQqozKKGH4phxh3P4nZWgEkIlAWhsEem+boBAdHERrsy3BXRjXVMb75
    UCp9EfSVLYnIzA6aEBCs/LyZheGrrLJ58xNVDwBiSEn9wkaA4QIA9nHCD2dkVhJkYN3+IufU7M+bzlVQQzvW9Z6SNE/DMN0A7zMGm4PAfRyu4YtoFZvtgN73
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=LbIdt4omAhMj5_klYnAA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757425AbeD0GnI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeD0GnH (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 02:43:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B882168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v3 6/7] kprobes/arm: Fix %p uses in error messages
Date: Fri, 27 Apr 2018 15:42:41 +0900
Message-Id: <152481136145.22588.9150341273556432748.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152481117776.22588.1210388093668905564.stgit@devbox>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix %p uses in error messages by removing it and
using general dumper.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/probes/kprobes/core.c      |   10 +++++-----
 arch/arm/probes/kprobes/test-core.c |    1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index e90cc8a08186..e90165a56620 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -289,8 +289,8 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 				break;
 			case KPROBE_REENTER:
 				/* A nested probe was hit in FIQ, it is a BUG */
-				pr_warn("Unrecoverable kprobe detected at %p.\n",
-					p->addr);
+				pr_warn("Unrecoverable kprobe detected.\n");
+				dump_kprobe(p);
 				/* fall through */
 			default:
 				/* impossible cases */
@@ -615,11 +615,11 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 		if (orig_sp != stack_addr) {
 			struct pt_regs *saved_regs =
 				(struct pt_regs *)kcb->jprobe_saved_regs.ARM_sp;
-			printk("current sp %lx does not match saved sp %lx\n",
+			pr_err("current sp %lx does not match saved sp %lx\n",
 			       orig_sp, stack_addr);
-			printk("Saved registers for jprobe %p\n", jp);
+			pr_err("Saved registers for jprobe\n");
 			show_regs(saved_regs);
-			printk("Current registers\n");
+			pr_err("Current registers\n");
 			show_regs(regs);
 			BUG();
 		}
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index 9ed0129bed3c..b5c892e24244 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -1460,7 +1460,6 @@ static bool check_test_results(void)
 	print_registers(&result_regs);
 
 	if (mem) {
-		pr_err("current_stack=%p\n", current_stack);
 		pr_err("expected_memory:\n");
 		print_memory(expected_memory, mem_size);
 		pr_err("result_memory:\n");
