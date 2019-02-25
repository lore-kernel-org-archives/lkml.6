Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F779C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615A32146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfBYWnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:43:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbfBYWnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 17:43:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1PMhKfZ1880528
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 25 Feb 2019 14:43:20 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1PMhK8X1880525;
        Mon, 25 Feb 2019 14:43:20 -0800
Date:   Mon, 25 Feb 2019 14:43:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-2e7614c0736de93c8796bb2d58debb8871a59db8@git.kernel.org>
Cc:     tobin@kernel.org, jannh@google.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, bp@suse.de,
        torvalds@linux-foundation.org, x86@kernel.org, luto@kernel.org,
        mingo@kernel.org, hpa@zytor.com
Reply-To: tobin@kernel.org, jannh@google.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, bp@suse.de, peterz@infradead.org,
          x86@kernel.org, torvalds@linux-foundation.org, luto@kernel.org,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190225191109.7671-1-bp@alien8.de>
References: <20190225191109.7671-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/uaccess: Remove unused __addr_ok() macro
Git-Commit-ID: 2e7614c0736de93c8796bb2d58debb8871a59db8
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

Commit-ID:  2e7614c0736de93c8796bb2d58debb8871a59db8
Gitweb:     https://git.kernel.org/tip/2e7614c0736de93c8796bb2d58debb8871a59db8
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Mon, 25 Feb 2019 20:08:27 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 25 Feb 2019 23:13:05 +0100

x86/uaccess: Remove unused __addr_ok() macro

This was caught while staring at the whole {set,get}_fs() machinery.

It's last user, the 32-bit version of strnlen_user() went away with

  5723aa993d83 ("x86: use the new generic strnlen_user() function")

so drop it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: the arch/x86 maintainers <x86@kernel.org>
Cc: "Tobin C. Harding" <tobin@kernel.org>
Link: https://lkml.kernel.org/r/20190225191109.7671-1-bp@alien8.de
---
 arch/x86/include/asm/uaccess.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index a77445d1b034..ec8d36f04786 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -35,10 +35,7 @@ static inline void set_fs(mm_segment_t fs)
 }
 
 #define segment_eq(a, b)	((a).seg == (b).seg)
-
 #define user_addr_max() (current->thread.addr_limit.seg)
-#define __addr_ok(addr) 	\
-	((unsigned long __force)(addr) < user_addr_max())
 
 /*
  * Test whether a block of memory is a valid user space address.
