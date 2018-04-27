Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3869068-1524811372-2-6929752426207252183
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524811371; b=bnGfC3JEkm3GZL/CZKW0P1tGBNuqaSJGmU1wyj8lbP5vPsQT3s
    eeGB7JUysWO5/SRE6zYno02pObtbKuV97lV6WcO7wRTcltbD9Dv7FHUc0oB9iFT8
    D/VgiCX6+f3QpFg10/qcW9CXtwR5IgBHJYraSugfVZ+G2gJfyOCORwvY3ooFq5p3
    wToQwCHed2rUqln1s9A44qBprV5sYUCeMSgLES6iNbOFbwp86013eVo615aTfVNl
    q1iFSlBSI3qHFjbCbfJN8k/BKsbW9NsG7OEgJCGRd9arZiGemYaUXIJZtUIsSFIy
    c9LaxmY5IDxSyWxfPwQRrtGugvTbctK6n9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524811371;
    bh=YWYSj8CD91Ox70Yoz5vekg5WpYtrEYwLigLw0RaT1CI=; b=HOHmGbVnNZzX
    bAwKo6VfJzRk5nNqDc4j5M1Nb5NzMyop6gFMwfUUm7yGJKd+FEur+mdvZccqHWr8
    sTH7xhj9CYUHj/6ZNgYMVYokYk1EaBvW/B0t2hjRUZ504pE5YpUTb+KqSmw5eXEo
    JO96Q/hAcp5DzAftj4M18B7aKzWcgvDWVDOipTExj7M+ZxndWx24awYQRFuw50ap
    SPFgs+JtG5xseS7iy0zHjsWq+dT2n035GrSFdGKCS/9rOFTWMqqt9jAToAfdP5yY
    VCZB3lfkq7LGlJGgaa69Yf0XhbrC5bhmHmmWv9UoofW460+QTRuYPe4k1oek/iJg
    xZIycm3Yjg==
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
X-CM-Envelope: MS4wfP8D04Wp5TGKTbd+5jwZYmJuGKCdSFufe7IBMcJCKP9rRSq5hnn7nitK+i+S+R26Tqe7bCpUS2eIkW5mG5iHJQ09/Oz9X5qQ3TX6oC8YHaEos8J9JA3t
    zBJsN/Aur1+sCvrjhBbRmwXOyi4ZR2XTN+2wrRezkgy80qiwZMQ4RIqAs9FwAkStH/76oL0KAtplJbJOAfB34UpWJsZpsb4sWQ1Fvm+RKqFgnksfin2UlG/s
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Q4zXA6fk_zm2YvbgkZYA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757428AbeD0Gmh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeD0Gmg (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 02:42:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158BA2168C
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
Subject: [PATCH v3 5/7] kprobes/x86: Fix %p uses in error messages
Date: Fri, 27 Apr 2018 15:42:11 +0900
Message-Id: <152481133105.22588.10668983189195179761.stgit@devbox>
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

Fix %p uses in error messages in kprobes/x86.
- Some %p uses are not needed. Just remove it (or remove message).
- One %p use seems important to show some address
  so replaced with %pS.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Do not use %px.
---
 arch/x86/kernel/kprobes/core.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 0715f827607c..d2c9d5c8e4ce 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -391,8 +391,6 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 			  - (u8 *) real;
 		if ((s64) (s32) newdisp != newdisp) {
 			pr_err("Kprobes error: new displacement does not fit into s32 (%llx)\n", newdisp);
-			pr_err("\tSrc: %p, Dest: %p, old disp: %x\n",
-				src, real, insn->displacement.value);
 			return 0;
 		}
 		disp = (u8 *) dest + insn_offset_displacement(insn);
@@ -636,8 +634,7 @@ static int reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
 		 * Raise a BUG or we'll continue in an endless reentering loop
 		 * and eventually a stack overflow.
 		 */
-		printk(KERN_WARNING "Unrecoverable kprobe detected at %p.\n",
-		       p->addr);
+		pr_err("Unrecoverable kprobe detected.\n");
 		dump_kprobe(p);
 		BUG();
 	default:
@@ -1146,12 +1143,11 @@ int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	    (addr < (u8 *) jprobe_return_end)) {
 		if (stack_addr(regs) != saved_sp) {
 			struct pt_regs *saved_regs = &kcb->jprobe_saved_regs;
-			printk(KERN_ERR
-			       "current sp %p does not match saved sp %p\n",
+			pr_err("current sp %pS does not match saved sp %pS\n",
 			       stack_addr(regs), saved_sp);
-			printk(KERN_ERR "Saved registers for jprobe %p\n", jp);
+			pr_err("Saved registers for jprobe\n");
 			show_regs(saved_regs);
-			printk(KERN_ERR "Current registers\n");
+			pr_err("Current registers\n");
 			show_regs(regs);
 			BUG();
 		}
