Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1897398-1524919094-2-13422249546513768727
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
    1524919094; b=TVCabiCSXspgDTjEe31oeTriqW/dFQfXl9BWylAJ/uG5gpXJ49
    3m8YlMKZn9bqkPzYPChAa0PWscTPG3gqQxNBvo+D0y8vd0LygRXBfJI6TzjWHndj
    AqONswOLkdDQK6f7FfK5vwWwhnT9kErD1tsCR0kQiIyPzSNv5ESzvE1/ypCD2Gih
    ad5tqh0OvxB3F0iJCOTShJ4kq/+4k3nUIMFl2/t3Za16rsi696ZVyM+mqMSh4Aab
    m7roKAWufMCdGpuUZBuKdffW/3u2kW8GtGkq3w/60b2dMPiTjWeTbRo0Sux+5J5o
    qMBsrKB5xIa1iC1WqquhMVJ6iWz9JRmTCWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524919094;
    bh=B7y7Dd66g23een/GBcBa17GDaZ66Y+LUs1mSWH+On+8=; b=UMbx+zyQHkj1
    qK5NEz9pnIHrmV8/o7vCu8B4FXSY8xbqPCtMzFEFRnD0AC46gVm2roEIbuzyHdoX
    woK1R7Lm0FMk/FC5CQtQy6At6Ko/RA3EhjySgS9MSkg8kCz0xGeZNglR5AZkHLpz
    yhvS4RQBdQOWrr3oTbEYgkcO4s3k6EYiQCurRvhcIEc4JgmJj7fLWbNBgfRNGTHc
    K4XW4UsaHTwwKLk7lEZc6t5X3/hZD+6Sncunfswm1K2+GgxZZBYLYgWIACkWspou
    imb64pWisGMiS7pD4CbwyVx8lInTO+Vhl0YMDetG7BZ0HRsJNrl1zhkjaB3uoWMt
    /SXpkV2zTQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfLUtksrQee1/n7+XzGYu74V6kR8gB8LHPXDnSXyIR1/PGs21S2HacxI4Ro1g74iQSSdOQ02/9VDUy0mzggWkHtGrcWQN/bPkqHXmuwqUlrVWsAW22aLk
    mRjATRCsaDkmIgFlqWIygg6x9phL5GM10VN6A36sMh3qcRZnyqLmCue65Iaw7U6Fin/tDYRD7gm0o6UpsORgsuOv69CPUY8kJxY2OcSTFsqJb1rJpqMf2uKe
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=xlo8E_76G_VwogKDEjMA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759952AbeD1MiA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 08:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759778AbeD1Mh7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 08:37:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36CD21A96
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
Subject: [PATCH v4 6/7] kprobes/arm: Fix %p uses in error messages
Date: Sat, 28 Apr 2018 21:37:33 +0900
Message-Id: <152491905361.9916.15300852365956231645.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152491886943.9916.18051658590418236184.stgit@devbox>
References: <152491886943.9916.18051658590418236184.stgit@devbox>
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
Cc: stable@vger.kernel.org
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
