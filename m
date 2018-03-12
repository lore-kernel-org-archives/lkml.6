Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824562-2-13306817468113600693
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824561; b=L+WshDSQR2PEKb+k8V/m0UrCVvjZlDR9jGsMsf/bpuZQqK8
    6fuRL40Ph/D1eVa6i9kqjI9H75ijcq7Iml1nYBEwFkJBNfkZGoCGPR7tofzO4Kxw
    Ork2AoywFtIb4+75PnMMdiUUPjlyJuOjHvJkd0hjCVZOk13/VAtYxtjruZ9Ysbgv
    +iXzzdpo9UpVbQ3Ft1IO+8/fdP3p9ikTjEaxUi31d3MxOYtnE3t0vl/qhB+Z6xXu
    jyifF4f8jpiNRkDTK6nWLVYOJp+Ma6eEEpEqmJPqpbiq3yCXR0JJy+oBZXmwygdM
    mE4DQRxwkWWtgbye1P0E/cEaHZlHRURpW5VWIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824561; bh=9Nyj8Y1q2NSD9g2JzaC
    HC09/uRgMUjHGsq2jkhSlPEc=; b=TDBXb2Yu5+T8UG1u294NhCUoSp94B5ih+52
    68mXsoAzS9kbZOQXeCT5hzJtkQkqe1sOheYXPZ81RGl0axVWGo6dPsIfERsdHS6B
    9xvFDMTQZokaOF/d5MYezDCXLChmO54cj+dmGWptj6Ha1scLcy5hzFQq1jcoEq/p
    fSzWEMrIHtcpJmL+fyXHqwa5zX+BEihXb3SQBBZmJG5AexF76/XDe8LFm1hptT0L
    Ulyl6Dj4POMyOupuFX5Z/k6odYV++bip7nrOHgR7hiGaQF/aL2QGvgJsTl0ELHv/
    bwWvto1MERJzWQOhsH9HKOSz3mjm17ezZXo9KsNLzewiLxk9iPg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932823AbeCLDOw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:14:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41515 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932782AbeCLDHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:51 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andy Lutomirski" <luto@amacapital.net>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Quentin Casasnovas" <quentin.casasnovas@oracle.com>,
        "Brian Gerst" <brgerst@gmail.com>, "Borislav Petkov" <bp@suse.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.318631229@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 14/76] x86/alternatives: Fix ALTERNATIVE_2 padding
 generation properly
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit dbe4058a6a44af4ca5d146aebe01b0a1f9b7fd2a upstream.

Quentin caught a corner case with the generation of instruction
padding in the ALTERNATIVE_2 macro: if len(orig_insn) <
len(alt1) < len(alt2), then not enough padding gets added and
that is not good(tm) as we could overwrite the beginning of the
next instruction.

Luckily, at the time of this writing, we don't have
ALTERNATIVE_2() invocations which have that problem and even if
we did, a simple fix would be to prepend the instructions with
enough prefixes so that that corner case doesn't happen.

However, best it would be if we fixed it properly. See below for
a simple, abstracted example of what we're doing.

So what we ended up doing is, we compute the

	max(len(alt1), len(alt2)) - len(orig_insn)

and feed that value to the .skip gas directive. The max() cannot
have conditionals due to gas limitations, thus the fancy integer
math.

With this patch, all ALTERNATIVE_2 sites get padded correctly;
generating obscure test cases pass too:

  #define alt_max_short(a, b)    ((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))

  #define gen_skip(orig, alt1, alt2, marker)	\
  	.skip -((alt_max_short(alt1, alt2) - (orig)) > 0) * \
  		(alt_max_short(alt1, alt2) - (orig)),marker

  	.pushsection .text, "ax"
  .globl main
  main:
  	gen_skip(1, 2, 4, 0x09)
  	gen_skip(4, 1, 2, 0x10)
  	...
  	.popsection

Thanks to Quentin for catching it and double-checking the fix!

Reported-by: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20150404133443.GE21152@pd.tnic
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/alternative-asm.h | 14 ++++++++++++--
 arch/x86/include/asm/alternative.h     | 16 ++++++++++++----
 arch/x86/kernel/alternative.c          |  4 ++--
 3 files changed, 26 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -45,12 +45,22 @@
 	.popsection
 .endm
 
+#define old_len			141b-140b
+#define new_len1		144f-143f
+#define new_len2		145f-144f
+
+/*
+ * max without conditionals. Idea adapted from:
+ * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
+ */
+#define alt_max_short(a, b)	((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
+
 .macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
 140:
 	\oldinstr
 141:
-	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
-	.skip -(((145f-144f)-(144f-143f)-(141b-140b)) > 0) * ((145f-144f)-(144f-143f)-(141b-140b)),0x90
+	.skip -((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
+		(alt_max_short(new_len1, new_len2) - (old_len)),0x90
 142:
 
 	.pushsection .altinstructions,"a"
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -96,13 +96,21 @@ static inline int alternatives_text_rese
 	alt_end_marker ":\n"
 
 /*
+ * max without conditionals. Idea adapted from:
+ * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
+ *
+ * The additional "-" is needed because gas works with s32s.
+ */
+#define alt_max_short(a, b)	"((" a ") ^ (((" a ") ^ (" b ")) & -(-((" a ") - (" b ")))))"
+
+/*
  * Pad the second replacement alternative with additional NOPs if it is
  * additionally longer than the first replacement alternative.
  */
-#define OLDINSTR_2(oldinstr, num1, num2)					\
-	__OLDINSTR(oldinstr, num1)						\
-	".skip -(((" alt_rlen(num2) ")-(" alt_rlen(num1) ")-(662b-661b)) > 0) * " \
-		"((" alt_rlen(num2) ")-(" alt_rlen(num1) ")-(662b-661b)),0x90\n"  \
+#define OLDINSTR_2(oldinstr, num1, num2) \
+	"661:\n\t" oldinstr "\n662:\n"								\
+	".skip -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")) > 0) * "	\
+		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0x90\n"	\
 	alt_end_marker ":\n"
 
 #define ALTINSTR_ENTRY(feature, num)					      \
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -372,11 +372,11 @@ void __init_or_module apply_alternatives
 			continue;
 		}
 
-		DPRINTK("feat: %d*32+%d, old: (%p, len: %d), repl: (%p, len: %d)",
+		DPRINTK("feat: %d*32+%d, old: (%p, len: %d), repl: (%p, len: %d), pad: %d",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
 			instr, a->instrlen,
-			replacement, a->replacementlen);
+			replacement, a->replacementlen, a->padlen);
 
 		DUMP_BYTES(instr, a->instrlen, "%p: old_insn: ", instr);
 		DUMP_BYTES(replacement, a->replacementlen, "%p: rpl_insn: ", replacement);
