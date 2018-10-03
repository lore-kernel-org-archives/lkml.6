Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B3AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD0320878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD0320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeJCNSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:18:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCNSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:18:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w936UoZ22248682
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 23:30:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w936UnMF2248679;
        Tue, 2 Oct 2018 23:30:49 -0700
Date:   Tue, 2 Oct 2018 23:30:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-4f166564014aba65ad6f15b612f6711fd0f117ee@git.kernel.org>
Cc:     bp@alien8.de, dwmw2@infradead.org, torvalds@linux-foundation.org,
        luto@kernel.org, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, matt@softrans.com.au,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, matt@softrans.com.au,
          hpa@zytor.com, torvalds@linux-foundation.org, luto@kernel.org,
          dwmw2@infradead.org, bp@alien8.de
In-Reply-To: <08a1f29f2c238dd1f493945e702a521f8a5aa3ae.1538540801.git.luto@kernel.org>
References: <08a1f29f2c238dd1f493945e702a521f8a5aa3ae.1538540801.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vdso: Only enable vDSO retpolines when enabled
 and supported
Git-Commit-ID: 4f166564014aba65ad6f15b612f6711fd0f117ee
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

Commit-ID:  4f166564014aba65ad6f15b612f6711fd0f117ee
Gitweb:     https://git.kernel.org/tip/4f166564014aba65ad6f15b612f6711fd0f117ee
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 2 Oct 2018 21:26:50 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Oct 2018 08:26:14 +0200

x86/vdso: Only enable vDSO retpolines when enabled and supported

When I fixed the vDSO build to use inline retpolines, I messed up
the Makefile logic and made it unconditional.  It should have
depended on CONFIG_RETPOLINE and on the availability of compiler
support.  This broke the build on some older compilers.

Reported-by: nikola.ciprich@linuxbox.cz
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Rickard <matt@softrans.com.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: jason.vas.dias@gmail.com
Cc: stable@vger.kernel.org
Fixes: 2e549b2ee0e3 ("x86/vdso: Fix vDSO build if a retpoline is emitted")
Link: http://lkml.kernel.org/r/08a1f29f2c238dd1f493945e702a521f8a5aa3ae.1538540801.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index fa3f439f0a92..141d415a8c80 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -68,7 +68,13 @@ $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
        $(filter -g%,$(KBUILD_CFLAGS)) $(call cc-option, -fno-stack-protector) \
        -fno-omit-frame-pointer -foptimize-sibling-calls \
-       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO $(RETPOLINE_VDSO_CFLAGS)
+       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
+
+ifdef CONFIG_RETPOLINE
+ifneq ($(RETPOLINE_VDSO_CFLAGS),)
+  CFL += $(RETPOLINE_VDSO_CFLAGS)
+endif
+endif
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
@@ -138,7 +144,13 @@ KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
 KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
 KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
-KBUILD_CFLAGS_32 += $(RETPOLINE_VDSO_CFLAGS)
+
+ifdef CONFIG_RETPOLINE
+ifneq ($(RETPOLINE_VDSO_CFLAGS),)
+  KBUILD_CFLAGS_32 += $(RETPOLINE_VDSO_CFLAGS)
+endif
+endif
+
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
 $(obj)/vdso32.so.dbg: FORCE \
