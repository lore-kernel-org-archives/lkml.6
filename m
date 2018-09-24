Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7BCECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA902064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA902064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbeIXVHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:07:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbeIXVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:07:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8OF3rnn3096067
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 Sep 2018 08:03:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8OF3rqu3096064;
        Mon, 24 Sep 2018 08:03:53 -0700
Date:   Mon, 24 Sep 2018 08:03:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-0cbb76d6285794f30953bfa3ab831714b59dd700@git.kernel.org>
Cc:     daniel@iogearbox.net, zhenzhong.duan@oracle.com, mingo@redhat.com,
        udknight@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@suse.de,
        konrad.wilk@oracle.com, mingo@kernel.org, dwmw@amazon.co.uk
Reply-To: bp@suse.de, konrad.wilk@oracle.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          dwmw@amazon.co.uk, mingo@kernel.org, zhenzhong.duan@oracle.com,
          mingo@redhat.com, daniel@iogearbox.net, hpa@zytor.com,
          udknight@gmail.com
In-Reply-To: <c3975665-173e-4d70-8dee-06c926ac26ee@default>
References: <c3975665-173e-4d70-8dee-06c926ac26ee@default>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Add RETPOLINE_AMD support to the
 inline asm CALL_NOSPEC variant
Git-Commit-ID: 0cbb76d6285794f30953bfa3ab831714b59dd700
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

Commit-ID:  0cbb76d6285794f30953bfa3ab831714b59dd700
Gitweb:     https://git.kernel.org/tip/0cbb76d6285794f30953bfa3ab831714b59dd700
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Tue, 18 Sep 2018 07:45:00 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sun, 23 Sep 2018 15:25:28 +0200

x86/speculation: Add RETPOLINE_AMD support to the inline asm CALL_NOSPEC variant

..so that they match their asm counterpart.

Add the missing ANNOTATE_NOSPEC_ALTERNATIVE in CALL_NOSPEC, while at it.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang YanQing <udknight@gmail.com>
Cc: dhaval.giani@oracle.com
Cc: srinivas.eeda@oracle.com
Link: http://lkml.kernel.org/r/c3975665-173e-4d70-8dee-06c926ac26ee@default
---
 arch/x86/include/asm/nospec-branch.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index fd2a8c1b88bc..80dc14422495 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -170,11 +170,15 @@
  */
 # define CALL_NOSPEC						\
 	ANNOTATE_NOSPEC_ALTERNATIVE				\
-	ALTERNATIVE(						\
+	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
-	X86_FEATURE_RETPOLINE)
+	X86_FEATURE_RETPOLINE,					\
+	"lfence;\n"						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%[thunk_target]\n",				\
+	X86_FEATURE_RETPOLINE_AMD)
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
 #elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
@@ -184,7 +188,8 @@
  * here, anyway.
  */
 # define CALL_NOSPEC						\
-	ALTERNATIVE(						\
+	ANNOTATE_NOSPEC_ALTERNATIVE				\
+	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	"       jmp    904f;\n"					\
@@ -199,7 +204,11 @@
 	"       ret;\n"						\
 	"       .align 16\n"					\
 	"904:	call   901b;\n",				\
-	X86_FEATURE_RETPOLINE)
+	X86_FEATURE_RETPOLINE,					\
+	"lfence;\n"						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%[thunk_target]\n",				\
+	X86_FEATURE_RETPOLINE_AMD)
 
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
 #else /* No retpoline for C / inline asm */
