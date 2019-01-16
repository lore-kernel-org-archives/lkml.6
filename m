Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B963C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7248A206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbfAPL6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:58:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732248AbfAPL6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:58:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0GBvwIe252864
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 16 Jan 2019 03:57:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0GBvspF252860;
        Wed, 16 Jan 2019 03:57:54 -0800
Date:   Wed, 16 Jan 2019 03:57:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-1c1ed4731cc81942a5b25f284a85257573829b9e@git.kernel.org>
Cc:     jpoimboe@redhat.com, x86@kernel.org, thomas.lendacky@amd.com,
        hpa@zytor.com, mingo@kernel.org, bp@suse.de,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: mingo@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org,
          peterz@infradead.org, tglx@linutronix.de, luto@amacapital.net,
          jpoimboe@redhat.com, x86@kernel.org, hpa@zytor.com,
          thomas.lendacky@amd.com
In-Reply-To: <20181211222326.14581-2-bp@alien8.de>
References: <20181211222326.14581-2-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] x86/alternatives: Add macro comments
Git-Commit-ID: 1c1ed4731cc81942a5b25f284a85257573829b9e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1c1ed4731cc81942a5b25f284a85257573829b9e
Gitweb:     https://git.kernel.org/tip/1c1ed4731cc81942a5b25f284a85257573829b9e
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Mon, 10 Dec 2018 12:21:48 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 16 Jan 2019 12:40:07 +0100

x86/alternatives: Add macro comments

... so that when one stares at the .s output, one can find her way
around the resulting asm magic.

With it, ALTERNATIVE looks like this now:

          # ALT: oldnstr
  661:
          ...
  662:
          # ALT: padding
  .skip ...
  663:
  .pushsection .altinstructions,"a"

  ...

  .popsection
  .pushsection .altinstr_replacement, "ax"
          # ALT: replacement 1
  6641:
  	...
  6651:
          .popsection

Merge __OLDINSTR() into OLDINSTR(), while at it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: X86 ML <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181211222326.14581-2-bp@alien8.de
---
 arch/x86/include/asm/alternative.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 0660e14690c8..373e2baca6ce 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -94,13 +94,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
 #define alt_total_slen		alt_end_marker"b-661b"
 #define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
 
-#define __OLDINSTR(oldinstr, num)					\
+#define OLDINSTR(oldinstr, num)						\
+	"# ALT: oldnstr\n"						\
 	"661:\n\t" oldinstr "\n662:\n"					\
+	"# ALT: padding\n"						\
 	".skip -(((" alt_rlen(num) ")-(" alt_slen ")) > 0) * "		\
-		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"
-
-#define OLDINSTR(oldinstr, num)						\
-	__OLDINSTR(oldinstr, num)					\
+		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"		\
 	alt_end_marker ":\n"
 
 /*
@@ -116,7 +115,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * additionally longer than the first replacement alternative.
  */
 #define OLDINSTR_2(oldinstr, num1, num2) \
+	"# ALT: oldinstr2\n"									\
 	"661:\n\t" oldinstr "\n662:\n"								\
+	"# ALT: padding2\n"									\
 	".skip -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")) > 0) * "	\
 		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0x90\n"	\
 	alt_end_marker ":\n"
@@ -129,8 +130,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	" .byte " alt_rlen(num) "\n"			/* replacement len */ \
 	" .byte " alt_pad_len "\n"			/* pad len */
 
-#define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */     \
-	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n\t"
+#define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */	\
+	"# ALT: replacement " #num "\n"						\
+	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
 
 /* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, newinstr, feature)			\
