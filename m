Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D131C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070EC2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070EC2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeH3PEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:04:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39119 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeH3PEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:04:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7UB2AMp1728310
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 04:02:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7UB29E01728307;
        Thu, 30 Aug 2018 04:02:09 -0700
Date:   Thu, 30 Aug 2018 04:02:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-113fc08357ad4e8b84caa75402430875d9ac4c1a@git.kernel.org>
Cc:     peterz@infradead.org, michal.lkml@markovi.net, hpa@zytor.com,
        yamada.masahiro@socionext.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jpoimboe@redhat.com
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          peterz@infradead.org, michal.lkml@markovi.net, hpa@zytor.com,
          yamada.masahiro@socionext.com
In-Reply-To: <1535341183-19994-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535341183-19994-1-git-send-email-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Remove workaround for unreachable
 warnings from old GCC
Git-Commit-ID: 113fc08357ad4e8b84caa75402430875d9ac4c1a
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

Commit-ID:  113fc08357ad4e8b84caa75402430875d9ac4c1a
Gitweb:     https://git.kernel.org/tip/113fc08357ad4e8b84caa75402430875d9ac4c1a
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Mon, 27 Aug 2018 12:39:43 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Aug 2018 12:56:40 +0200

objtool: Remove workaround for unreachable warnings from old GCC

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
bumped the minimum GCC version to 4.6 for all architectures.

This effectively reverts commit da541b20021c ("objtool: Skip unreachable
warnings for GCC 4.4 and older"), which was a workaround for GCC 4.4 or
older.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Link: https://lkml.kernel.org/r/1535341183-19994-1-git-send-email-yamada.masahiro@socionext.com

---
 scripts/Makefile.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 1c48572223d1..5a2d1c9578a0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -246,8 +246,6 @@ objtool_args += --no-fp
 endif
 ifdef CONFIG_GCOV_KERNEL
 objtool_args += --no-unreachable
-else
-objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
 ifdef CONFIG_RETPOLINE
 ifneq ($(RETPOLINE_CFLAGS),)
