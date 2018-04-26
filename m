Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209064-1524730280-2-14666184772405556644
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
    1524730280; b=rMgbGyAsLP89BjvsYqBAXGBtWgx38DsKqjSPG9iKv3pfA5O0/c
    /rUFiDI5Yz2HQjVbxiqd7ocw8a8C6WPILstIJMeOE7VnP/swL4GRzioESjho4HOl
    p8EXjWvto41s5SgLY1q9mE64+WVzd0vYKMXUgOhvwdZ+ovOcxnLcesLLSx3aPQld
    A5ImsMHfdPFaRZWEk6wivRilF3pPtke9pylSASEAfk7gt0AT+Odrj9Wvz3MqkqD7
    UAKrHPqDz1JFEmZ62Cyk5OW1Qo55JDkMKLgoaSm4Dd5pePkipXTidG8vijl8emHK
    nKrnUKBAX3fSDm+0QXzkVXV6sKIF94spMkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524730280;
    bh=3HH+23fMnRbCMhVVgD8fpahc47cM6JLTldj6hZBccFs=; b=YbdAIbJBqhw1
    WZaU1SKsIF49zt70P5/i4S90+Qa1gomswQG19OP60X0hAYKi2/SaZoHRgiWPmOSv
    i5Tw1ePMMHHoicOn534KwYHoEGFk3AhTcYX8ANgvfJwFNTIMuNSzTpileQhtkcBW
    TKyIPj4nc9fgWaKOT/hzEfWJSzIkHwn80E1zpkYVV74pDkgCXXAwLbYYZ0VWsY2v
    cChpK2VawJOQVT6L0VnxzSDqNGBcrO0NCn9l1B2fSesgMQw8qy0iAsIyHkXrmVTk
    hFW8Zhu8sxaKipn52rtdFAr8MLCMw3LMPT7sVWZZ4CIk2Kv0gK+sJJYhrSLIiWR7
    rtL+kgR0rQ==
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
X-CM-Envelope: MS4wfB0XIBQWeMon8YZboqVjc5UnbqX6ZsIek9Jgd4lSuRA0wZhet6vSPVp3Ss7B6mTLOzHaOzqWQ8NkA9FlMP4obWhJVAXS8yYVo1gtbq9DV04+78vvFJgu
    RsE+ooEWnY6vhkEw23QitpfbR7BzNOW+VtzdnAHng4A7t62vSAorBqLAfJjF07xfzbMNVYhqZCskRBAIv0E9NQhwG25tJ4CNpBBY0HKB0ez70tBnZYPpCwln
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=3KT6KFS39E_q7hwBfMUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbeDZILN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753882AbeDZIK7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 04:10:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B1E217B9
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
Subject: [PATCH -tip v2 5/7] kprobes/x86: Fix %p uses in error messages
Date: Thu, 26 Apr 2018 17:10:34 +0900
Message-Id: <152473023401.8819.7490686938838765816.stgit@devbox>
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

Fix %p uses in error messages in kprobes/x86.
- Some %p uses are not needed. Just remove it (or remove message).
- One %p use is right before the BUG() so replaced with %px.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 0715f827607c..b00778eaca47 100644
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
+			pr_err("current sp %px does not match saved sp %px\n",
 			       stack_addr(regs), saved_sp);
-			printk(KERN_ERR "Saved registers for jprobe %p\n", jp);
+			pr_err("Saved registers for jprobe\n");
 			show_regs(saved_regs);
-			printk(KERN_ERR "Current registers\n");
+			pr_err("Current registers\n");
 			show_regs(regs);
 			BUG();
 		}
