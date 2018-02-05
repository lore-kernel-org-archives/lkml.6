Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3105817-1517855046-2-6391008446599203713
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
    t=1517855045; b=Yaf/g4x2EU+/QBPGxOSjhfDlKkpCtFE7CmtDyh2moO13syA
    V3dTeAZGaurnzkMnhKkk/VBtwqzxcFuwIVw7xAdcssEkq5NEWbDdjqQQhsieA2sY
    atqMZZaPWwtJCd526GG9di5RoL6MNfSIt2qBfknPfwEW3PRnE/vrAhl/gq2VSJpX
    cx7anHj5Mg7Jptv005dcFqtpl8LxLqqTauNdjJUnDtclkRetRHduhVA//qcDyH8C
    O0/5sUL9V+Ze0I8O2pysbL/wkz4T4drIbiEjrULaNIEQ1lnz3H9iJt0wz50JBmSQ
    zwXK90nqsLhuJIy14YF/sqT/OIS9SP9NmSwEcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855045; bh=M6JIMZM3X26rEuK1qZn9Q4TCQj
    tT6ZozRvtYjkCLvW4=; b=SPOunoxEpPCpVa7GnJpvgcEuSGtAgASMJdQydB4GTV
    wAJiMcLyfZkYtsUXQMCEc3VRRImc3E22ABweaI9Ifrg/k+ZQdUHwgtNO7lCM03Tt
    Mdv4s0Ms/myQQi/TT0IHQ1KQGktK8ACVhn1RJyi57JXaRfSKCD7GfPIWOCZUVyxu
    YQoLdOSlV87oCFvj5BN2/ci1yfvpu1l4l8b72ZNzvyG108yWmIPV+dHKsQVD8KLE
    jK/sfSEf4zbb3P0QUjoAi4F+RAAi7I+TkaZBNUBivx3R/1glZiosMYAzbj9cuDKc
    4cUtYYwdAXlfODW50LIBKMLwbXXOIq3E+YDzXuBQXJGQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753498AbeBESYE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:24:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753459AbeBESXu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:23:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 29/64] objtool: Add support for alternatives at the end of a section
Date: Mon,  5 Feb 2018 10:22:48 -0800
Message-Id: <20180205182139.777435102@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf jpoimboe@redhat.com

commit 17bc33914bcc98ba3c6b426fd1c49587a25c0597

Now that the previous patch gave objtool the ability to read retpoline
alternatives, it shows a new warning:

  arch/x86/entry/entry_64.o: warning: objtool: .entry_trampoline: don't know how to handle alternatives at end of section

This is due to the JMP_NOSPEC in entry_SYSCALL_64_trampoline().

Previously, objtool ignored this situation because it wasn't needed, and
it would have required a bit of extra code.  Now that this case exists,
add proper support for it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/2a30a3c2158af47d891a76e69bb1ef347e0443fd.1517284349.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |   53 +++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -594,7 +594,7 @@ static int handle_group_alt(struct objto
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
-	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump;
+	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
 	unsigned long dest_off;
 
 	last_orig_insn = NULL;
@@ -610,28 +610,30 @@ static int handle_group_alt(struct objto
 		last_orig_insn = insn;
 	}
 
-	if (!next_insn_same_sec(file, last_orig_insn)) {
-		WARN("%s: don't know how to handle alternatives at end of section",
-		     special_alt->orig_sec->name);
-		return -1;
-	}
-
-	fake_jump = malloc(sizeof(*fake_jump));
-	if (!fake_jump) {
-		WARN("malloc failed");
-		return -1;
+	if (next_insn_same_sec(file, last_orig_insn)) {
+		fake_jump = malloc(sizeof(*fake_jump));
+		if (!fake_jump) {
+			WARN("malloc failed");
+			return -1;
+		}
+		memset(fake_jump, 0, sizeof(*fake_jump));
+		INIT_LIST_HEAD(&fake_jump->alts);
+		clear_insn_state(&fake_jump->state);
+
+		fake_jump->sec = special_alt->new_sec;
+		fake_jump->offset = -1;
+		fake_jump->type = INSN_JUMP_UNCONDITIONAL;
+		fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
+		fake_jump->ignore = true;
 	}
-	memset(fake_jump, 0, sizeof(*fake_jump));
-	INIT_LIST_HEAD(&fake_jump->alts);
-	clear_insn_state(&fake_jump->state);
-
-	fake_jump->sec = special_alt->new_sec;
-	fake_jump->offset = -1;
-	fake_jump->type = INSN_JUMP_UNCONDITIONAL;
-	fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
-	fake_jump->ignore = true;
 
 	if (!special_alt->new_len) {
+		if (!fake_jump) {
+			WARN("%s: empty alternative at end of section",
+			     special_alt->orig_sec->name);
+			return -1;
+		}
+
 		*new_insn = fake_jump;
 		return 0;
 	}
@@ -654,8 +656,14 @@ static int handle_group_alt(struct objto
 			continue;
 
 		dest_off = insn->offset + insn->len + insn->immediate;
-		if (dest_off == special_alt->new_off + special_alt->new_len)
+		if (dest_off == special_alt->new_off + special_alt->new_len) {
+			if (!fake_jump) {
+				WARN("%s: alternative jump to end of section",
+				     special_alt->orig_sec->name);
+				return -1;
+			}
 			insn->jump_dest = fake_jump;
+		}
 
 		if (!insn->jump_dest) {
 			WARN_FUNC("can't find alternative jump destination",
@@ -670,7 +678,8 @@ static int handle_group_alt(struct objto
 		return -1;
 	}
 
-	list_add(&fake_jump->list, &last_new_insn->list);
+	if (fake_jump)
+		list_add(&fake_jump->list, &last_new_insn->list);
 
 	return 0;
 }
