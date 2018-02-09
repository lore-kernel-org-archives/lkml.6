Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184748-2-14335234378616423255
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184747; b=ICb84FCfQ/heXDdYQ96PAyx67XW8EvqP1RkIzxpP8BkQm3Z
    Ym3Hn+lyG8UKzoT1xro6U31hLmuWphEC1FlPxbLGxbhANSQJ40MZz1GqF4T0wfiQ
    6RntIRfKUdEFH1TgBKxN+WahTEfLpYW5UY4OqcYF8biWvRHfXRvhRjEXPsKcjrkL
    FpROTqUfQpfRPq3+QxDQpuiQfG9eLiW9ShIrDHq2vFfo8TuRtTiIizXasA124SvV
    o8Ec6Xo5nHdKtCLLsd+wAWlv+PrSmWR+uDJZwZLP71/GAx+1nJRDnlF5f3jP7H70
    G+pF2GTRYPi3NSnCscvLJuB1ANr7XtFtpaHYwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184747; bh=cBEOWApNg7vCJbn45XfoErhgD6
    OwLmqJrMNYqVUhz1c=; b=EJBcLI944vvK9BNdQOcfYUblmgFYJukPSUW8gja6DZ
    jFAafUUSfaWpkE/fSO+y7BGQ3qVYHTrxquy9horn0uz7pgluPzHGeJXsn04F9qGh
    lOIhRhM/EFMJd+uB1xugS99RrAHsvRILjEGTq0gTs2f6bZuUC5pLBVe/hL5kjSOT
    GBWEThvuKkF28qpJFyKKhH73sjTlTYFMd+cHRlgDsSSmp4yLkXnVu9OxxpXzHEi0
    2ZHZ5B7liiamgAMUBYv58Sv3eZD+e0Mp/B0hNdidVve6lSdIT7KbjZYNsVQRwD5S
    FnAQrtn25N1aOsQCjmQ8unBHj1oQiMuoBGlagm/qga2w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeBIN6u (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:58:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753337AbeBINod (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:33 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, riel@redhat.com,
        ak@linux.intel.com, peterz@infradead.org,
        David Woodhouse <dwmw2@infradead.org>, jikos@kernel.org,
        luto@amacapital.net, dave.hansen@intel.com,
        torvalds@linux-foundation.org, keescook@google.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        tim.c.chen@linux.intel.com, pjt@google.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        gregkh@linux-foundation.org
Subject: [PATCH 4.9 46/92] x86/alternative: Print unadorned pointers
Date: Fri,  9 Feb 2018 14:39:15 +0100
Message-Id: <20180209133934.472824776@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

(cherry picked from commit 0e6c16c652cadaffd25a6bb326ec10da5bcec6b4)

After commit ad67b74d2469 ("printk: hash addresses printed with %p")
pointers are being hashed when printed. However, this makes the alternative
debug output completely useless. Switch to %px in order to see the
unadorned kernel pointers.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: riel@redhat.com
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: jikos@kernel.org
Cc: luto@amacapital.net
Cc: dave.hansen@intel.com
Cc: torvalds@linux-foundation.org
Cc: keescook@google.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Cc: pjt@google.com
Link: https://lkml.kernel.org/r/20180126121139.31959-2-bp@alien8.de
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/alternative.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -298,7 +298,7 @@ recompute_jump(struct alt_instr *a, u8 *
 	tgt_rip  = next_rip + o_dspl;
 	n_dspl = tgt_rip - orig_insn;
 
-	DPRINTK("target RIP: %p, new_displ: 0x%x", tgt_rip, n_dspl);
+	DPRINTK("target RIP: %px, new_displ: 0x%x", tgt_rip, n_dspl);
 
 	if (tgt_rip - orig_insn >= 0) {
 		if (n_dspl - 2 <= 127)
@@ -352,7 +352,7 @@ static void __init_or_module optimize_no
 	sync_core();
 	local_irq_restore(flags);
 
-	DUMP_BYTES(instr, a->instrlen, "%p: [%d:%d) optimized NOPs: ",
+	DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
 		   instr, a->instrlen - a->padlen, a->padlen);
 }
 
@@ -370,7 +370,7 @@ void __init_or_module apply_alternatives
 	u8 *instr, *replacement;
 	u8 insnbuf[MAX_PATCH_LEN];
 
-	DPRINTK("alt table %p -> %p", start, end);
+	DPRINTK("alt table %px, -> %px", start, end);
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -394,14 +394,14 @@ void __init_or_module apply_alternatives
 			continue;
 		}
 
-		DPRINTK("feat: %d*32+%d, old: (%p, len: %d), repl: (%p, len: %d), pad: %d",
+		DPRINTK("feat: %d*32+%d, old: (%px len: %d), repl: (%px, len: %d), pad: %d",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
 			instr, a->instrlen,
 			replacement, a->replacementlen, a->padlen);
 
-		DUMP_BYTES(instr, a->instrlen, "%p: old_insn: ", instr);
-		DUMP_BYTES(replacement, a->replacementlen, "%p: rpl_insn: ", replacement);
+		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
+		DUMP_BYTES(replacement, a->replacementlen, "%px: rpl_insn: ", replacement);
 
 		memcpy(insnbuf, replacement, a->replacementlen);
 		insnbuf_sz = a->replacementlen;
@@ -422,7 +422,7 @@ void __init_or_module apply_alternatives
 				 a->instrlen - a->replacementlen);
 			insnbuf_sz += a->instrlen - a->replacementlen;
 		}
-		DUMP_BYTES(insnbuf, insnbuf_sz, "%p: final_insn: ", instr);
+		DUMP_BYTES(insnbuf, insnbuf_sz, "%px: final_insn: ", instr);
 
 		text_poke_early(instr, insnbuf, insnbuf_sz);
 	}
