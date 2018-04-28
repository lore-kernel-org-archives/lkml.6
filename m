Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1907442-1524919022-2-2786157771305465971
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
    1524919022; b=kKWEeT5Xqu+/O8XTPU1xoxAeyBQc/t2xr1/Fy8QRJnJlDRxJl2
    u5TQN5SFLQYD6JAujHouB6/Cbs+b67UlajBNzlZ4hBZ30S6EXoCNg2gwgx4eK9+e
    Po+3Lhck0bz5cGWNiEE+nEGLLsx7zE2FP/LSmZipF+Gtd/qZm9Br+SGg8GbUd6r/
    xF9RiMfLuon+b+ZO0ycXuyCGGSDtMHYpgfk/1BqUxpoWsyJVQSm40Fk72VcFwX5R
    tuUePgaaZ5zMJXCZBwHJK3fQhEmjkxSJPg5aLX5UJjX19cewzbOc3H88UIz8JiTD
    Jl5gOCOJPlYrWjMoXquQPrGGGuCyOQICSjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524919022;
    bh=47g6I39SFOGs9cMEJa/zI+/4YcBdeEZ9Wqqzn0VYf7g=; b=ZAZqf5zdmcDM
    X2BbcPUshI0Eds4w3kKTOEwWJ+Z8yJlL1Kbicvv+xDKOl4kOzwFLlSBJ0L7KzEoN
    aYXqJ9VTZgPz/R8Tigm1UT/5tIpjMonffuyA1rWPpoLEt5HrtrpzjnJLK74ijKje
    QoY9r7NZ3zp0rM6Z7d7xbx6jslqVKBdiwt8k5VEhaMGF+qt9PaXXwF3dr67I3Fz/
    b0bEVUBLGJH3617Kw2jpmmNdtaKc4TMmHq/Mm+wTZwL6MJpzfmLDVIosZ9E6JXTp
    EHvFj8uj4jPRaZogOFyefReYpEuAbeX3+PMrtzvUh+A0QSgM7V5CkZ0TXuSZZY+7
    76sY3f8X9g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfPWheGTT9UWXMf/g+vO/G8CDyq+XPVouvg4a+iprB8OxrIYIu1+ZbhMv3NZkxVFh5xfzesQB/VL6ybMSoofO0aRASWK4/Tz5xTzAO3+l/FFmuEvnBUbB
    bNkpl8d6wd7PI8UIzS0PsHV3WwoI+UysHckr42Ec7XT7DnA5o7Da31v1tFIPBajnf8TALCnCTF/zXSDThMpeGPN1JSkXTCnwteU2SJ5FaGiYLGRjJggMGET0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=eTFDDVV5-x8s3ZdA51sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759874AbeD1Mg7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 08:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759699AbeD1Mg6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 08:36:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C755021DEF
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
Subject: [PATCH v4 4/7] kprobes: Replace %p with other pointer types
Date: Sat, 28 Apr 2018 21:36:33 +0900
Message-Id: <152491899284.9916.5350534544808158621.stgit@devbox>
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

Replace %p with %pS or just remove it if unneeded.
And use WARN_ONCE() if it is a single bug.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 Changes in v4:
  - Use WARN_ONCE() for single bug.
 Changes in v3:
  - Do not use %px in any case.
 Changes in v2:
  - Rebased on linux-next
---
 kernel/kprobes.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 548903deaee5..bb70658acb97 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -710,9 +710,7 @@ static void reuse_unused_kprobe(struct kprobe *ap)
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
@@ -985,7 +983,8 @@ static int arm_kprobe_ftrace(struct kprobe *p)
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 				   (unsigned long)p->addr, 0, 0);
 	if (ret) {
-		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
+			 p->addr, ret);
 		return ret;
 	}
 
@@ -1025,7 +1024,8 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 			   (unsigned long)p->addr, 1, 0);
-	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
+		  p->addr, ret);
 	return ret;
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
@@ -2169,11 +2169,12 @@ int enable_kprobe(struct kprobe *kp)
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
 
@@ -2196,11 +2197,8 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
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
