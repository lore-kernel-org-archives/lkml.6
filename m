Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520955709-2-6563414985371691079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955708; b=OiXa9TnZSOhyKUth+py9olH/gDh++NFi44ELL36U/zMs5Kt
    7Ogmk9jSlC6sWwRqBr/BclLqYLIkZJUusjMpk2sh9u4ZhPqaS6G73ADOAdtzrUkR
    8qOQgUuMcdu7dsGYHRPoOT4SKCYfEBixvmdzhDMm+scWIoJnwEkXMZ6hfF6ITvAe
    qekEqPraFcmlTJ2FgSgUQLicXLSn9tNE29RCtohg/c3P7X1qUWFObSI6dnxUNsTx
    1G2Pj0p7zm6+cPz+g+AnJfA96E+cs/S0L/w/Oz5KjKuGUn+5or7ygfbYjBuvGiQn
    qhx6OUr4GsjaUfncXckpnS3JVfKbYFgSrdNBYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955708; bh=ktU1i38EF0XodHOZOm5xF+x1If
    Djf7SKxUzqbl77NOg=; b=LJfjoTtKkIh/shB/4hxYt9ys/tBUBKQkaxRbvC9T7y
    CYZIgp+XyC8JkNx1teXYPU99ptTPwdw/64uCHVJGodL79x3uohcIhfHCCJWcT+8U
    3XKtuSX7Jn0RxCD/gyGuD5Aqvjy/+RCTD8+eSLO4zEgbQlsBabrGsAA4McEdwJR/
    QnYJonlpzHQ/ChacEd1s1Obqy3FlbiXiWNBRcPnougqhjuSVUBvi7mQB0ch4o/RU
    P9iiIM7YsfVvqXxEplyYnFtMN4hJytVvvhhNTjRF1ktCM7PShjsInZzEVEyOttjc
    cSqbi9MIudKh9Ce9b6czfwS/QlAI6pvB8jJm4379TmnA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964843AbeCMPlk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:41:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934523AbeCMPlg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:41:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 132/140] objtool: Add retpoline validation
Date: Tue, 13 Mar 2018 16:25:35 +0100
Message-Id: <20180313152507.046143471@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit b5bc2231b8ad4387c9641f235ca0ad8cd300b6df upstream.

David requested a objtool validation pass for CONFIG_RETPOLINE=y enabled
builds, where it validates no unannotated indirect  jumps or calls are
left.

Add an additional .discard.retpoline_safe section to allow annotating
the few indirect sites that are required and safe.

Requested-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/Makefile.build        |    4 +
 tools/objtool/builtin-check.c |    3 -
 tools/objtool/builtin.h       |    2 
 tools/objtool/check.c         |   86 +++++++++++++++++++++++++++++++++++++++++-
 tools/objtool/check.h         |    1 
 5 files changed, 93 insertions(+), 3 deletions(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -269,6 +269,10 @@ objtool_args += --no-unreachable
 else
 objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
+ifdef CONFIG_RETPOLINE
+  objtool_args += --retpoline
+endif
+
 
 ifdef CONFIG_MODVERSIONS
 objtool_o = $(@D)/.tmp_$(@F)
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -29,7 +29,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable;
+bool no_fp, no_unreachable, retpoline;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -39,6 +39,7 @@ static const char * const check_usage[]
 const struct option check_options[] = {
 	OPT_BOOLEAN('f', "no-fp", &no_fp, "Skip frame pointer validation"),
 	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
+	OPT_BOOLEAN('r', "retpoline", &retpoline, "Validate retpoline assumptions"),
 	OPT_END(),
 };
 
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -20,7 +20,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable;
+extern bool no_fp, no_unreachable, retpoline;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -496,6 +496,7 @@ static int add_jump_destinations(struct
 			 * disguise, so convert them accordingly.
 			 */
 			insn->type = INSN_JUMP_DYNAMIC;
+			insn->retpoline_safe = true;
 			continue;
 		} else {
 			/* sibling call */
@@ -547,7 +548,8 @@ static int add_call_destinations(struct
 			if (!insn->call_dest && !insn->ignore) {
 				WARN_FUNC("unsupported intra-function call",
 					  insn->sec, insn->offset);
-				WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
+				if (retpoline)
+					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
 				return -1;
 			}
 
@@ -1107,6 +1109,54 @@ static int read_unwind_hints(struct objt
 	return 0;
 }
 
+static int read_retpoline_hints(struct objtool_file *file)
+{
+	struct section *sec, *relasec;
+	struct instruction *insn;
+	struct rela *rela;
+	int i;
+
+	sec = find_section_by_name(file->elf, ".discard.retpoline_safe");
+	if (!sec)
+		return 0;
+
+	relasec = sec->rela;
+	if (!relasec) {
+		WARN("missing .rela.discard.retpoline_safe section");
+		return -1;
+	}
+
+	if (sec->len % sizeof(unsigned long)) {
+		WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
+		return -1;
+	}
+
+	for (i = 0; i < sec->len / sizeof(unsigned long); i++) {
+		rela = find_rela_by_dest(sec, i * sizeof(unsigned long));
+		if (!rela) {
+			WARN("can't find rela for retpoline_safe[%d]", i);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("can't find insn for retpoline_safe[%d]", i);
+			return -1;
+		}
+
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC) {
+			WARN_FUNC("retpoline_safe hint not a indirect jump/call",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
+		insn->retpoline_safe = true;
+	}
+
+	return 0;
+}
+
 static int decode_sections(struct objtool_file *file)
 {
 	int ret;
@@ -1145,6 +1195,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_retpoline_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1890,6 +1944,29 @@ static int validate_unwind_hints(struct
 	return warnings;
 }
 
+static int validate_retpoline(struct objtool_file *file)
+{
+	struct instruction *insn;
+	int warnings = 0;
+
+	for_each_insn(file, insn) {
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC)
+			continue;
+
+		if (insn->retpoline_safe)
+			continue;
+
+		WARN_FUNC("indirect %s found in RETPOLINE build",
+			  insn->sec, insn->offset,
+			  insn->type == INSN_JUMP_DYNAMIC ? "jump" : "call");
+
+		warnings++;
+	}
+
+	return warnings;
+}
+
 static bool is_kasan_insn(struct instruction *insn)
 {
 	return (insn->type == INSN_CALL &&
@@ -2050,6 +2127,13 @@ int check(const char *_objname, bool orc
 	if (list_empty(&file.insn_list))
 		goto out;
 
+	if (retpoline) {
+		ret = validate_retpoline(&file);
+		if (ret < 0)
+			return ret;
+		warnings += ret;
+	}
+
 	ret = validate_functions(&file);
 	if (ret < 0)
 		goto out;
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -45,6 +45,7 @@ struct instruction {
 	unsigned char type;
 	unsigned long immediate;
 	bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
+	bool retpoline_safe;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
