Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137BFC46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7C82150B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7C82150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389514AbeHNU2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:28:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731979AbeHNU2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:28:21 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A376D83;
        Tue, 14 Aug 2018 17:40:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jon Medhurst <tixy@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Will Deacon <will.deacon@arm.com>, acme@kernel.org,
        akpm@linux-foundation.org, brueckner@linux.vnet.ibm.com,
        linux-arch@vger.kernel.org, rostedt@goodmis.org,
        schwidefsky@de.ibm.com, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 025/107] kprobes/x86: Fix %p uses in error messages
Date:   Tue, 14 Aug 2018 19:16:48 +0200
Message-Id: <20180814171522.260150789@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 0ea063306eecf300fcf06d2f5917474b580f666f upstream.

Remove all %p uses in error messages in kprobes/x86.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jon Medhurst <tixy@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Tobin C . Harding <me@tobin.cc>
Cc: Will Deacon <will.deacon@arm.com>
Cc: acme@kernel.org
Cc: akpm@linux-foundation.org
Cc: brueckner@linux.vnet.ibm.com
Cc: linux-arch@vger.kernel.org
Cc: rostedt@goodmis.org
Cc: schwidefsky@de.ibm.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/lkml/152491902310.9916.13355297638917767319.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kprobes/core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -396,7 +396,6 @@ int __copy_instruction(u8 *dest, u8 *src
 		newdisp = (u8 *) src + (s64) insn.displacement.value - (u8 *) dest;
 		if ((s64) (s32) newdisp != newdisp) {
 			pr_err("Kprobes error: new displacement does not fit into s32 (%llx)\n", newdisp);
-			pr_err("\tSrc: %p, Dest: %p, old disp: %x\n", src, dest, insn.displacement.value);
 			return 0;
 		}
 		disp = (u8 *) dest + insn_offset_displacement(&insn);
@@ -612,8 +611,7 @@ static int reenter_kprobe(struct kprobe
 		 * Raise a BUG or we'll continue in an endless reentering loop
 		 * and eventually a stack overflow.
 		 */
-		printk(KERN_WARNING "Unrecoverable kprobe detected at %p.\n",
-		       p->addr);
+		pr_err("Unrecoverable kprobe detected.\n");
 		dump_kprobe(p);
 		BUG();
 	default:


