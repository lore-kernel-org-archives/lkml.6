Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72343ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FE320840
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FE320840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeGPAAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:00:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeGPAAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:00:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNZjex922343
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:35:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNZiZh922340;
        Sun, 15 Jul 2018 16:35:44 -0700
Date:   Sun, 15 Jul 2018 16:35:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-bdc9c3e5ed953441a46ef3acd81c783d591c9a96@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, yamada.masahiro@socionext.com
Reply-To: tglx@linutronix.de, peterz@infradead.org,
          yamada.masahiro@socionext.com, mingo@kernel.org, hpa@zytor.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <1531138041-24200-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531138041-24200-1-git-send-email-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build: Remove old -funit-at-a-time GCC quirk
Git-Commit-ID: bdc9c3e5ed953441a46ef3acd81c783d591c9a96
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

Commit-ID:  bdc9c3e5ed953441a46ef3acd81c783d591c9a96
Gitweb:     https://git.kernel.org/tip/bdc9c3e5ed953441a46ef3acd81c783d591c9a96
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Mon, 9 Jul 2018 21:07:21 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:25:10 +0200

x86/build: Remove old -funit-at-a-time GCC quirk

The following commit:

  e501ce957a78 ("x86: Force asm-goto")

... bumped the minimum GCC version to 4.5 for building the x86 kernel.

arch/x86/Makefile no longer needs to take care of older GCC versions,
such as this pre-4.0 -funit-at-a-time quirk.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: http://lkml.kernel.org/r/1531138041-24200-1-git-send-email-yamada.masahiro@socionext.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index a08e82856563..7e3c07d6ad42 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -80,11 +80,6 @@ ifeq ($(CONFIG_X86_32),y)
         # alignment instructions.
         KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align4))
 
-        # Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
-        # a lot more stack due to the lack of sharing of stacklots:
-        KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0400, \
-				$(call cc-option,-fno-unit-at-a-time))
-
         # CPU-specific tuning. Anything which can be shared with UML should go here.
         include arch/x86/Makefile_32.cpu
         KBUILD_CFLAGS += $(cflags-y)
