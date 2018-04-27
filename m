Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524811342-2-12389637557433196850
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524811341; b=Er175cGKNUOmkynQO2ONm8qr9L8+91Qorg0weV4j/xOyn7fUE8
    1AvhkTIT6GIpY7VXtH3uENTzTLm5P4Wh0Jc/hRc+OXiWoUbrxdLoJhSaJOJ5wl56
    KMyCMC4zTF8J/cI6uaMpegLZ7XF3KMZbV5u67tFqaTXg2a9m2nmPZfDAOVFb3cLf
    5DGohTZiHMEQQxxzdbhpw7IK6ATCp+Wr5IoBeTTN3UI28UVWReCNSijx7o9YECDy
    nEbU9p9dotcHBO7AJiqueO6GAwWbIMLFEB0diuPhcN0WuHki9AN/2vcuARWU97/p
    Ie9aRJyPPgYfhZ1GFAfrcSfnmTO2+kLsv88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524811341;
    bh=6JoAnDGv/VFYAASA297vIPU79KrjuDDaCN06D0xCjxg=; b=Q4BheKfJp7+f
    ayij2Iuc6XqLfjcmZvLHNIhN7c4hegvE0PVBezXi4dyB/7n/yUjel1tcAb8oD7Wi
    1uoyVe6gWsKSGWToouGJvsbpXczZFCMpbfz8t7KTp96DnXY9B0INXjsVC3V053yo
    OegVbev17fozUACI8vZSqJMcuYEh4PTsRLBQU1jhKk8hNAD7MkAnXWf/TPdT+5kS
    AyzBtxFdouzLuMcVwJujHi2X9M8BZX1PZ+8JMsusTYIWg/WWMpbDTJ0NhEKpUid0
    9vC4ffd310TM8LF9SORL0S3aHoZZmWualZrUU1EYNqp4JUXXngoAVUQ7O3imwT6G
    pC6b3ysBKQ==
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
X-CM-Envelope: MS4wfIs/65nG7siV2kbirkA5xm0EN7lwYqSC4wiJIDG4jYkNbHHYbSrEsVv0KCL45fMDdFrroOgf/zeHW8NT2+91PDDUAigjmJbnYAH5vfAJAq1iyDed1VY8
    Jner2f70YSAaRBRUrd+q81Nwi1uS1L7oREqpAB712zlK+62TTGAghXncAd5QLBLPHfNdee9bHVnHCgmrIFvwUeFf1ijy5sPntSnTn0mTsv/geiC5FroJnz+y
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=eTFDDVV5-x8s3ZdA51sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757334AbeD0GmH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeD0GmG (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 02:42:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A092168C
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
Subject: [PATCH v3 4/7] kprobes: Replace %p with other pointer types
Date: Fri, 27 Apr 2018 15:41:40 +0900
Message-Id: <152481130062.22588.10747314456340608852.stgit@devbox>
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

Replace %p with %pS or just remove it if unneeded.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Do not use %px in any case.
 Changes in v2:
  - Rebased on linux-next
---
 kernel/kprobes.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 94af7c99cf81..a72ff4999b11 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -712,7 +712,7 @@ static void reuse_unused_kprobe(struct kprobe *ap)
 	op = container_of(ap, struct optimized_kprobe, kp);
 	if (unlikely(list_empty(&op->list)))
 		printk(KERN_WARNING "Warning: found a stray unused "
-			"aggrprobe@%p\n", ap->addr);
+			"aggrprobe@%pS\n", ap->addr);
 	/* Enable the probe again */
 	ap->flags &= ~KPROBE_FLAG_DISABLED;
 	/* Optimize it again (remove from op->list) */
@@ -985,7 +985,8 @@ static int arm_kprobe_ftrace(struct kprobe *p)
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 				   (unsigned long)p->addr, 0, 0);
 	if (ret) {
-		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
+			 p->addr, ret);
 		return ret;
 	}
 
@@ -1025,7 +1026,8 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 			   (unsigned long)p->addr, 1, 0);
-	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
+	     p->addr, ret);
 	return ret;
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
@@ -2169,11 +2171,12 @@ int enable_kprobe(struct kprobe *kp)
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
 
@@ -2196,11 +2199,8 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
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
