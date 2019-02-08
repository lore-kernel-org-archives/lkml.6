Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82994C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DB820844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfBHNlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:41:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46335 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfBHNlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:41:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x18DdH0T2189076
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 05:39:17 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x18DdGBt2189072;
        Fri, 8 Feb 2019 05:39:16 -0800
Date:   Fri, 8 Feb 2019 05:39:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sergey Senozhatsky <tipbot@zytor.com>
Message-ID: <tip-653a561bb2fd34e470594eb1bdba3357630e8df7@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de,
        mingo@kernel.org, luto@kernel.org, hpa@zytor.com,
        sergey.senozhatsky@gmail.com, tglx@linutronix.de,
        sergey.senozhatsky.work@gmail.com
Reply-To: luto@kernel.org, bp@alien8.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          sergey.senozhatsky.work@gmail.com, tglx@linutronix.de,
          hpa@zytor.com, sergey.senozhatsky@gmail.com
In-Reply-To: <20190108130225.5066-2-sergey.senozhatsky@gmail.com>
References: <20190108130225.5066-2-sergey.senozhatsky@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/fpu: Move init_xstate_size() to __init
 section
Git-Commit-ID: 653a561bb2fd34e470594eb1bdba3357630e8df7
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

Commit-ID:  653a561bb2fd34e470594eb1bdba3357630e8df7
Gitweb:     https://git.kernel.org/tip/653a561bb2fd34e470594eb1bdba3357630e8df7
Author:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
AuthorDate: Tue, 8 Jan 2019 22:02:25 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 8 Feb 2019 14:32:34 +0100

x86/fpu: Move init_xstate_size() to __init section

WARNING: vmlinux.o(.text.unlikely+0x1c05): Section mismatch in
         reference from the function init_xstate_size() to the
         function .init.text:get_xsave_size()

WARNING: vmlinux.o(.text.unlikely+0x1c19): Section mismatch in
         reference from the function init_xstate_size() to the
         function .init.text:get_xsaves_size()

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Link: https://lkml.kernel.org/r/20190108130225.5066-2-sergey.senozhatsky@gmail.com

---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9cc108456d0b..d7432c2b1051 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -669,7 +669,7 @@ static bool is_supported_xstate_size(unsigned int test_xstate_size)
 	return false;
 }
 
-static int init_xstate_size(void)
+static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
 	unsigned int possible_xstate_size;
