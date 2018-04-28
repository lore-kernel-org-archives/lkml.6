Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1907442-1524919052-2-7233591279274518115
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enrosk.us-ascii, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524919052; b=moh2d3ShYrLmvH0xIQDBbAIPTcSAUeoAfGjvbiV89mZa1EWYgD
    51B2Ly9YHvNDYV6zZlleZPuzbLnGSJy2EwbPwI4gAccAmqo8x+ND1ztuH+Ekc7gh
    +KM7iN2Tidreu9Fi44JKQnRZS5LTOYGAfvp3L5Sy5XMqTs0xVDwBxFx+tKJSLtfk
    fnkXZr2LHqmJmpVIJTkYHeXkPM41BPtCMIZKbEa6I9sB6+mnwV1KrkSvHURnJP2i
    H5VXvgeLgJDcRPniDzv510Qyr1oPppFtBSu54F8zrp9U/+HwONfS1xqRvcuAnpfP
    X8PC1JSekVn2kfIH/h8ENSY1VO9K29mqPNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524919052;
    bh=rqgm0qNmo0V8SwiS0yzRLvW3b3gGLg/LvlMlBjAnR3w=; b=Qont+MJW5ZhQ
    F7pvQcpbc7bi73WYW/JRCRDbRCNE5UFZSmZUXF5mT4NlFxGsHLHqzFFsXVtHWqJh
    ILCErXE7gFQa+k568m8eu2TY6r3Rx13VZxh80rEgg3m3Ig4I1RRUmEZqLfJWlRMA
    cao+NlQZDo4v3JItHY8FVTO4d19Xh2RXk8q8PxAXfBLtpql9y/PohuqjauumI4C1
    VLs7NKYeU05vLsO+TbG59NyQQvaH0E8Ct4cDMl6JqGXsQAoIVtwWFuxluewMUMtr
    OzfvuiZE2Xvfc1VdWAMzO4/lEfR0d8QuF7Ra75fu8pN4DcZ7WELGuBkoiOci7JwO
    hPDTrumPkg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfF5JjRsOiQkV56AIIL9lT2PnUkLqhpLGOKaBb1tm90wEBFwgDQkPlTTHer+J4N1PnFAdNLAlwgw6k+viX83ssVTpqMOIxPgzYcq57ndXpz4EjuWfrGEI
    Am2giuAPXaoNf5zKDvwDChyCtO01pYfe0DVvVyVMx88bZI1iZB6vtVIq0xI1TC6Hym9bQtVBMbEJdL09OSRmatcnDlSqZJzCEodAbE6cLGPb+YMI4bopgg65
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=jv78PU4_S0Nm2EabIzkA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759899AbeD1Mh3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 08:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759699AbeD1Mh2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 08:37:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C8021A96
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
Subject: [PATCH v4 5/7] kprobes/x86: Fix %p uses in error messages
Date: Sat, 28 Apr 2018 21:37:03 +0900
Message-Id: <152491902310.9916.13355297638917767319.stgit@devbox>
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

Remove all %p uses in error messages in kprobes/x86.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 Changes in v4:
  - Just remove %p.
 Changes in v3:
  - Do not use %px.
---
 arch/x86/kernel/kprobes/core.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 0715f827607c..2c7ec4ae660c 100644
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
@@ -1146,12 +1143,10 @@ int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	    (addr < (u8 *) jprobe_return_end)) {
 		if (stack_addr(regs) != saved_sp) {
 			struct pt_regs *saved_regs = &kcb->jprobe_saved_regs;
-			printk(KERN_ERR
-			       "current sp %p does not match saved sp %p\n",
-			       stack_addr(regs), saved_sp);
-			printk(KERN_ERR "Saved registers for jprobe %p\n", jp);
+			pr_err("current %%sp does not match saved %%sp\n");
+			pr_err("Saved registers for jprobe\n");
 			show_regs(saved_regs);
-			printk(KERN_ERR "Current registers\n");
+			pr_err("Current registers\n");
 			show_regs(regs);
 			BUG();
 		}
