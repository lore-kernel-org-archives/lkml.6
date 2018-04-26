Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209064-1524730322-2-9840947663798102389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES sk.us-asciiroen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524730321; b=AiR4m4ePxTAlsyANUdpcdvWkMbcLDDXXnyVMoDogrkwemKlC2h
    aBBJCLWbsHpkLGHew3U/DbBODvDxtLEl8rqX5MxTkCw+R7Z3ym18nrbDlBmY2Hkd
    WR4aeNj3LgvkQKuyT3SxDrh6t9H3zrnkjMvKBWNDO8Bxwp00A0apVV46wRs34ewA
    XxgRvllKQejogq+QOPjFtmI6U/bpKC/MAhqD45dd27FZ37J1ssbIzdC1dt8hxALX
    QAt+aawVjUj311QWqhmWmULMnPiSUqfs7l7sIq6LpMavu4ZF28YrCQMQXSBbJ068
    DPctBmePcyh+myfOhgCpLl88P+WKT2+GoAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524730321;
    bh=mA1zVk7aXweYzeGkQaHpLZc/FLUzv0p1mhLbbqZPSxo=; b=UmIwo4huAPNq
    gcc0LVwxdlMGaYldraUzhaL0R8K4r+dHkFzaRmH9V4LxLK78oc8W29q3A9/QeEKe
    zIB0yUsEDMAWpxPoUVsmvvGt/lNY978bzUV7CniYpsvxNTjn+URScKxAf++G+DqY
    HEAAtfXMM2Wskkh5FyYTuArVg2XxWRTjsMRh+EBrf0KsqOO7T/isYh5nfBhlNgh+
    lQoR5V0W4sFCOai8bE44kl9JROYov2w+f+4instK86UX6FqKZQ9EfHyMj0Msv9YB
    3nWg5tVot2MpM9ZZV5Zff9VqQA5upye7JArPQ2A2T+uTDNQWsTa+nFlyepELfoX8
    xrLAQUKQkQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfA/TWYg9bH12H2goSv2pML5xkzh8SlseDfCN1snxeasn9Ji+UzQkdTVeKmmeQXnUFSdKZ+8QlueeI1FutUv8GxRz3AAkEXSDyxtMOYcswYDz8HBu22Yx
    RBKt//xU2UtV+ZVUWxVkOgurhyEonNWS5+jIEnAp2CxPJQBuAYXCncET3Nni67SAvfWjWevXjfX9aSusAMP1YeZbptIIaln6cj82gz7i6saC7p6B++C3yN59
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=LbIdt4omAhMj5_klYnAA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753700AbeDZILe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753487AbeDZILa (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 04:11:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA0C21781
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
Subject: [PATCH -tip v2 6/7] kprobes/arm: Fix %p uses in error messages
Date: Thu, 26 Apr 2018 17:11:04 +0900
Message-Id: <152473026446.8819.16376993831486706257.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152473007907.8819.10449983839199591406.stgit@devbox>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
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
