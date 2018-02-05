Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3155980-1517855123-2-4291764761343318376
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855122; b=LQjnycYytT9n0Y/cbJf0BneHcxHKp4BthPnRcGfmM/pB3Rj
    7KiVKxoEipHO6ZRlbkOXaRhwXQ+7gQUo2O6bBn/mnQVeIhbYLjTXnKRxmCkpg7rk
    tYGkC37l5wCVB2K6bXwnBoHzqIETUBKBtl+DzSmkukWa8kivsxOfS8q6gFjlCKRt
    cPBkWzycC1XLfXwXXZzXq8f+filhCpRb6kqWu84upGVOIWLweLuLH4H4gUjOUj0V
    zOIxsMA/YMG0fsFvWxNncKdWfVGiR10v4XSAPNn9IaK39Rq2JlZfJXj1YPRpyI7Z
    dI6++t6a9RCdKI2HjvnzhglbAkGkRsAl/CoLI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855122; bh=YlgFhsI5NkVSQuaa6OkP5+1qOR
    7hn75yGgQpoyaX7Fo=; b=KELPTh6P8zS3FPUyOyX+herpEhuoCK1brmz/Ulvj0P
    U7hF4ZZxKx/rR0JZ28GnlxhbHwXEtsw8piuYJtkdbAZLr0vVVGHE8LBqDHvy8DhC
    pvNB2sJPs2Jm5LSO1fwUZwCIefs4i9JrCfsd7Ggplate1pO/kSNMgK8c1+PepWwM
    IUrt1LyqDUuOmBbBC3HcoNmJwjffa5PVU/EqTgejM8ahfPAa1GGYt2SANT58UNO+
    SVFIbJejvdDUX9HPJGPy7BuEtuYP+PWPbVRDv3vCtknB30OPajAGo/BeVrxPw7Pn
    bGoEsqO7L49PSXMmI6vZKllcVu6lh1abU4IzRCG0owSw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753721AbeBESZS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:25:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753709AbeBESZN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:25:13 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 24/60] objtool: Improve retpoline alternative handling
Date: Mon,  5 Feb 2018 10:22:57 -0800
Message-Id: <20180205182214.927673937@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf jpoimboe@redhat.com

commit a845c7cf4b4cb5e9e3b2823867892b27646f3a98

Currently objtool requires all retpolines to be:

  a) patched in with alternatives; and

  b) annotated with ANNOTATE_NOSPEC_ALTERNATIVE.

If you forget to do both of the above, objtool segfaults trying to
dereference a NULL 'insn->call_dest' pointer.

Avoid that situation and print a more helpful error message:

  quirks.o: warning: objtool: efi_delete_dummy_variable()+0x99: unsupported intra-function call
  quirks.o: warning: objtool: If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.

Future improvements can be made to make objtool smarter with respect to
retpolines, but this is a good incremental improvement for now.

Reported-and-tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/819e50b6d9c2e1a22e34c1a636c0b2057cc8c6e5.1517284349.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -543,18 +543,14 @@ static int add_call_destinations(struct
 			dest_off = insn->offset + insn->len + insn->immediate;
 			insn->call_dest = find_symbol_by_offset(insn->sec,
 								dest_off);
-			/*
-			 * FIXME: Thanks to retpolines, it's now considered
-			 * normal for a function to call within itself.  So
-			 * disable this warning for now.
-			 */
-#if 0
-			if (!insn->call_dest) {
-				WARN_FUNC("can't find call dest symbol at offset 0x%lx",
-					  insn->sec, insn->offset, dest_off);
+
+			if (!insn->call_dest && !insn->ignore) {
+				WARN_FUNC("unsupported intra-function call",
+					  insn->sec, insn->offset);
+				WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
 				return -1;
 			}
-#endif
+
 		} else if (rela->sym->type == STT_SECTION) {
 			insn->call_dest = find_symbol_by_offset(rela->sym->sec,
 								rela->addend+4);
@@ -648,6 +644,8 @@ static int handle_group_alt(struct objto
 
 		last_new_insn = insn;
 
+		insn->ignore = orig_insn->ignore_alts;
+
 		if (insn->type != INSN_JUMP_CONDITIONAL &&
 		    insn->type != INSN_JUMP_UNCONDITIONAL)
 			continue;
@@ -729,10 +727,6 @@ static int add_special_section_alts(stru
 			goto out;
 		}
 
-		/* Ignore retpoline alternatives. */
-		if (orig_insn->ignore_alts)
-			continue;
-
 		new_insn = NULL;
 		if (!special_alt->group || special_alt->new_len) {
 			new_insn = find_insn(file, special_alt->new_sec,
@@ -1089,11 +1083,11 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = add_call_destinations(file);
+	ret = add_special_section_alts(file);
 	if (ret)
 		return ret;
 
-	ret = add_special_section_alts(file);
+	ret = add_call_destinations(file);
 	if (ret)
 		return ret;
 
@@ -1720,10 +1714,12 @@ static int validate_branch(struct objtoo
 
 		insn->visited = true;
 
-		list_for_each_entry(alt, &insn->alts, list) {
-			ret = validate_branch(file, alt->insn, state);
-			if (ret)
-				return 1;
+		if (!insn->ignore_alts) {
+			list_for_each_entry(alt, &insn->alts, list) {
+				ret = validate_branch(file, alt->insn, state);
+				if (ret)
+					return 1;
+			}
 		}
 
 		switch (insn->type) {
