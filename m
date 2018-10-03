Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A3C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2532098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2532098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJCNVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:21:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49873 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCNVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:21:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w936Xqib2249320
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 23:33:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w936XqS22249317;
        Tue, 2 Oct 2018 23:33:52 -0700
Date:   Tue, 2 Oct 2018 23:33:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nathan Chancellor <tipbot@zytor.com>
Message-ID: <tip-88296bd42b4e9d24e138a68b337c235b5cac89a7@git.kernel.org>
Cc:     natechancellor@gmail.com, bp@alien8.de,
        torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: natechancellor@gmail.com, bp@alien8.de,
          torvalds@linux-foundation.org, peterz@infradead.org,
          mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <20181002224511.14929-1-natechancellor@gmail.com>
References: <20181002224511.14929-1-natechancellor@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpu/amd: Remove unnecessary parentheses
Git-Commit-ID: 88296bd42b4e9d24e138a68b337c235b5cac89a7
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

Commit-ID:  88296bd42b4e9d24e138a68b337c235b5cac89a7
Gitweb:     https://git.kernel.org/tip/88296bd42b4e9d24e138a68b337c235b5cac89a7
Author:     Nathan Chancellor <natechancellor@gmail.com>
AuthorDate: Tue, 2 Oct 2018 15:45:11 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Oct 2018 08:27:47 +0200

x86/cpu/amd: Remove unnecessary parentheses

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

arch/x86/kernel/cpu/amd.c:925:14: warning: equality comparison with
extraneous parentheses [-Wparentheses-equality]
        if ((c->x86 == 6)) {
             ~~~~~~~^~~~
arch/x86/kernel/cpu/amd.c:925:14: note: remove extraneous parentheses
around the comparison to silence this warning
        if ((c->x86 == 6)) {
            ~       ^   ~
arch/x86/kernel/cpu/amd.c:925:14: note: use '=' to turn this equality
comparison into an assignment
        if ((c->x86 == 6)) {
                    ^~
                    =
1 warning generated.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181002224511.14929-1-natechancellor@gmail.com
Link: https://github.com/ClangBuiltLinux/linux/issues/187
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 22ab408177b2..eeea634bee0a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -922,7 +922,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 static unsigned int amd_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 {
 	/* AMD errata T13 (order #21922) */
-	if ((c->x86 == 6)) {
+	if (c->x86 == 6) {
 		/* Duron Rev A0 */
 		if (c->x86_model == 3 && c->x86_stepping == 0)
 			size = 64;
