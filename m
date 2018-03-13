Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520955886-2-11827563844829551139
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955885; b=AVMEcfHjq6+Wl5wjdZ3Z3Dyof3CTexizyTwqSdngDSw4A0J
    fH5WOqrd5irbomXQtKB/E7tZ13B3GE7G71UQ7/e6jsbXf6TaIg1a4s3LFRAxp33E
    1wh320gDgBgLF3sXYpM3XJDemFznOhArQS5lAJSX82qyQJQN1Nlt5qBBKeVr+VL3
    I4TDwCIdzcQ1YpmOVWCzG//SZncUlimhyHymzJfZbylcETcQfgEOkLJ8aEB/mxJP
    n+tJhUMkiAnlW7lrcYQVKwsH4deBh3fu+jJuBuYutToK86YT+0+rA6SQiyB8coDg
    CmwGHO2X9WvIZl3BvoluzJ4StUo8mYYVlTAc0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955885; bh=o3zv9hpt4s/bGOyCOb7IZHaUdG
    ghaWoRpCyDt92jLsg=; b=qeNJgNUXddjiW/iSNyXq/DW3J1a26Dnj7iXmbxjhIN
    eCK73w6/R7wtYiNQTBhjWvXWyJIHJaxDvbUiE7H4Rw8QE0lIRmGp1HJu7iAt+4PM
    dOdAWBSI/d1Q5pf4ZQrjDQQPTZCzDwc+YWHOY9bthRd8SkvMEs6Yv3TKx5mAEk1w
    sWajEoRIDJMw9cElgCvw1QNevCPcLaLxDSNFsJUd5Hx4ZyE3pPEQgg3AIgaEkECU
    hXbXdI1bvD7ckY4qxQAbny9tWbrNlGZ9dfW0pfnQr1cREFEo2A9Kad3U9ay5Jgpe
    L6nLlJ/cYih+ihXeqzkzMqRta4eHw/2911rWkn3iWWJw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S934823AbeCMPof (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:44:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37004 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935005AbeCMPle (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:41:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 131/140] objtool: Use existing global variables for options
Date: Tue, 13 Mar 2018 16:25:34 +0100
Message-Id: <20180313152506.977582248@linuxfoundation.org>
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

commit 43a4525f80534530077683f6472d8971646b0ace upstream.

Use the existing global variables instead of passing them around and
creating duplicate global variables.

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
 tools/objtool/builtin-check.c |    2 +-
 tools/objtool/builtin-orc.c   |    6 +-----
 tools/objtool/builtin.h       |    5 +++++
 tools/objtool/check.c         |    5 ++---
 tools/objtool/check.h         |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -53,5 +53,5 @@ int cmd_check(int argc, const char **arg
 
 	objname = argv[0];
 
-	return check(objname, no_fp, no_unreachable, false);
+	return check(objname, false);
 }
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -25,7 +25,6 @@
  */
 
 #include <string.h>
-#include <subcmd/parse-options.h>
 #include "builtin.h"
 #include "check.h"
 
@@ -36,9 +35,6 @@ static const char *orc_usage[] = {
 	NULL,
 };
 
-extern const struct option check_options[];
-extern bool no_fp, no_unreachable;
-
 int cmd_orc(int argc, const char **argv)
 {
 	const char *objname;
@@ -54,7 +50,7 @@ int cmd_orc(int argc, const char **argv)
 
 		objname = argv[0];
 
-		return check(objname, no_fp, no_unreachable, true);
+		return check(objname, true);
 	}
 
 	if (!strcmp(argv[0], "dump")) {
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -17,6 +17,11 @@
 #ifndef _BUILTIN_H
 #define _BUILTIN_H
 
+#include <subcmd/parse-options.h>
+
+extern const struct option check_options[];
+extern bool no_fp, no_unreachable;
+
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include "builtin.h"
 #include "check.h"
 #include "elf.h"
 #include "special.h"
@@ -33,7 +34,6 @@ struct alternative {
 };
 
 const char *objname;
-static bool no_fp;
 struct cfi_state initial_func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
@@ -2021,13 +2021,12 @@ static void cleanup(struct objtool_file
 	elf_close(file->elf);
 }
 
-int check(const char *_objname, bool _no_fp, bool no_unreachable, bool orc)
+int check(const char *_objname, bool orc)
 {
 	struct objtool_file file;
 	int ret, warnings = 0;
 
 	objname = _objname;
-	no_fp = _no_fp;
 
 	file.elf = elf_open(objname, orc ? O_RDWR : O_RDONLY);
 	if (!file.elf)
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -63,7 +63,7 @@ struct objtool_file {
 	bool ignore_unreachables, c_file, hints;
 };
 
-int check(const char *objname, bool no_fp, bool no_unreachable, bool orc);
+int check(const char *objname, bool orc);
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
