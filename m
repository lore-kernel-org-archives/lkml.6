Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955845-2-10923141880115111657
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfrro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955844; b=Evc4BMU8GHOpcLWt43h4SueZSMVAajvt0HSeOD0u0yIqJ4F
    yaVvs0BXdGbUlJwNbQVV9h3YDJ+7Q+sIg/srksbM4TFAh9cBJxyMPx11LCzieOTk
    9CrtOsJJKm2y3JRU0Zu6rSHmTkTQm5Hn0EuvQQgji2aAOmY8TDC1U6J44SUnoxPg
    IKZnlNGJmLOGjVfIyThz5JoPspQL3LLtiPHsZlspdr9Z8+HotSRix/5Es1y5qB+4
    oK77JD12BZFl3x84cBecSYKOYMWRM5y/RvgaoeXwQo3PVoIzxCVq1PnzboMT09L6
    +GLCQxEpXRZpoTpdgZrY0l4UfGqT34QtUAtabgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955844; bh=ZscA2Q52z+JnHfWFW2JtZtQZNV
    PlOTrGs+8sZ4uvGGU=; b=DyYct3Ghe9lvK1z5HFROF1Y6q1cc9FXjpRxHGcSyk6
    Zq/2VoVO8GrMhWKCfvv16T3VNRppWFG0xQan6YSOkfK0J1mEYKqJ6wPLIUzXZILS
    5ca2loQb1VZziAELh8cQcoZhR/vFae2ba/l2xMQaN7RdfJZv1wk8S9gI3cGUUrJe
    fv5fc0Ddf9lhntXJiML2MxAp9HHLULGdNejlQz6S/ox+RRtB0cwqd8+CrWHVpN/e
    lG9pn8Rt4XhqJgIrHO4TzZhIV9nxxfGuC4l3MxiaoFs/bApcC90apt1Q6i73UetX
    x8k+C8VnisMnckl8lsQd353JzDM6aT+TloJ8cRn4gRJw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S935055AbeCMPns (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:43:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935016AbeCMPlj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:41:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 136/140] objtool: Add module specific retpoline rules
Date: Tue, 13 Mar 2018 16:25:39 +0100
Message-Id: <20180313152507.316611450@linuxfoundation.org>
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

commit ca41b97ed9124fd62323a162de5852f6e28f94b8 upstream.

David allowed retpolines in .init.text, except for modules, which will
trip up objtool retpoline validation, fix that.

Requested-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/Makefile.build        |    2 ++
 tools/objtool/builtin-check.c |    3 ++-
 tools/objtool/builtin.h       |    2 +-
 tools/objtool/check.c         |    9 +++++++++
 4 files changed, 14 insertions(+), 2 deletions(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -261,6 +261,8 @@ __objtool_obj := $(objtree)/tools/objtoo
 
 objtool_args = $(if $(CONFIG_UNWINDER_ORC),orc generate,check)
 
+objtool_args += $(if $(part-of-module), --module,)
+
 ifndef CONFIG_FRAME_POINTER
 objtool_args += --no-fp
 endif
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -29,7 +29,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable, retpoline;
+bool no_fp, no_unreachable, retpoline, module;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -40,6 +40,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('f', "no-fp", &no_fp, "Skip frame pointer validation"),
 	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN('r', "retpoline", &retpoline, "Validate retpoline assumptions"),
+	OPT_BOOLEAN('m', "module", &module, "Indicates the object will be part of a kernel module"),
 	OPT_END(),
 };
 
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -20,7 +20,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline;
+extern bool no_fp, no_unreachable, retpoline, module;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1957,6 +1957,15 @@ static int validate_retpoline(struct obj
 		if (insn->retpoline_safe)
 			continue;
 
+		/*
+		 * .init.text code is ran before userspace and thus doesn't
+		 * strictly need retpolines, except for modules which are
+		 * loaded late, they very much do need retpoline in their
+		 * .init.text
+		 */
+		if (!strcmp(insn->sec->name, ".init.text") && !module)
+			continue;
+
 		WARN_FUNC("indirect %s found in RETPOLINE build",
 			  insn->sec, insn->offset,
 			  insn->type == INSN_JUMP_DYNAMIC ? "jump" : "call");
