Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674BA20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674BA20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeICV7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:59:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48838 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeICV7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:59:20 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96FD8BAE;
        Mon,  3 Sep 2018 17:38:08 +0000 (UTC)
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
Subject: [PATCH 4.18 096/123] kprobes: Replace %p with other pointer types
Date:   Mon,  3 Sep 2018 18:57:20 +0200
Message-Id: <20180903165723.582018086@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 4458515b2c52831ee622411d2fe3e774d1f5c49a upstream.

Replace %p with %pS or just remove it if unneeded.
And use WARN_ONCE() if it is a single bug.

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
Link: https://lkml.kernel.org/lkml/152491899284.9916.5350534544808158621.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/kprobes.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -710,9 +710,7 @@ static void reuse_unused_kprobe(struct k
 	 * there is still a relative jump) and disabled.
 	 */
 	op = container_of(ap, struct optimized_kprobe, kp);
-	if (unlikely(list_empty(&op->list)))
-		printk(KERN_WARNING "Warning: found a stray unused "
-			"aggrprobe@%p\n", ap->addr);
+	WARN_ON_ONCE(list_empty(&op->list));
 	/* Enable the probe again */
 	ap->flags &= ~KPROBE_FLAG_DISABLED;
 	/* Optimize it again (remove from op->list) */
@@ -985,7 +983,8 @@ static int arm_kprobe_ftrace(struct kpro
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 				   (unsigned long)p->addr, 0, 0);
 	if (ret) {
-		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
+			 p->addr, ret);
 		return ret;
 	}
 
@@ -1025,7 +1024,8 @@ static int disarm_kprobe_ftrace(struct k
 
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 			   (unsigned long)p->addr, 1, 0);
-	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
+		  p->addr, ret);
 	return ret;
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
@@ -2169,11 +2169,12 @@ out:
 }
 EXPORT_SYMBOL_GPL(enable_kprobe);
 
+/* Caller must NOT call this in usual path. This is only for critical case */
 void dump_kprobe(struct kprobe *kp)
 {
-	printk(KERN_WARNING "Dumping kprobe:\n");
-	printk(KERN_WARNING "Name: %s\nAddress: %p\nOffset: %x\n",
-	       kp->symbol_name, kp->addr, kp->offset);
+	pr_err("Dumping kprobe:\n");
+	pr_err("Name: %s\nOffset: %x\nAddress: %pS\n",
+	       kp->symbol_name, kp->offset, kp->addr);
 }
 NOKPROBE_SYMBOL(dump_kprobe);
 
@@ -2196,11 +2197,8 @@ static int __init populate_kprobe_blackl
 		entry = arch_deref_entry_point((void *)*iter);
 
 		if (!kernel_text_address(entry) ||
-		    !kallsyms_lookup_size_offset(entry, &size, &offset)) {
-			pr_err("Failed to find blacklist at %p\n",
-				(void *)entry);
+		    !kallsyms_lookup_size_offset(entry, &size, &offset))
 			continue;
-		}
 
 		ent = kmalloc(sizeof(*ent), GFP_KERNEL);
 		if (!ent)


