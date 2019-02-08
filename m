Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE6DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E861820844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfBHNiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:38:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42583 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBHNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:38:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x18DbutY2188742
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 05:37:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x18Dbt122188739;
        Fri, 8 Feb 2019 05:37:55 -0800
Date:   Fri, 8 Feb 2019 05:37:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bo Yu <tipbot@zytor.com>
Message-ID: <tip-c81cd5c08d676483bb09f4809660d2a1abea0062@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, tsu.yubo@gmail.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, tsu.yubo@gmail.com
In-Reply-To: <20190208125343.11451-1-tsu.yubo@gmail.com>
References: <20190208125343.11451-1-tsu.yubo@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/mtrr: Remove unused variable
Git-Commit-ID: c81cd5c08d676483bb09f4809660d2a1abea0062
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

Commit-ID:  c81cd5c08d676483bb09f4809660d2a1abea0062
Gitweb:     https://git.kernel.org/tip/c81cd5c08d676483bb09f4809660d2a1abea0062
Author:     Bo Yu <tsu.yubo@gmail.com>
AuthorDate: Fri, 8 Feb 2019 07:53:43 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 8 Feb 2019 14:32:33 +0100

x86/mtrr: Remove unused variable

Compiling the kernel with W=1 results in the following warning:

arch/x86/kernel/cpu/mtrr/cleanup.c:299:16: warning: variable ‘second_basek’ set but not used [-Wunused-but-set-variable]
  unsigned long second_basek, second_sizek;

Remove the unused variable.

[ tglx: Massaged changelog ]

Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: puwen@hygon.cn
Link: https://lkml.kernel.org/r/20190208125343.11451-1-tsu.yubo@gmail.com

---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 3668c5df90c6..5bd011737272 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -296,7 +296,7 @@ range_to_mtrr_with_hole(struct var_mtrr_state *state, unsigned long basek,
 			unsigned long sizek)
 {
 	unsigned long hole_basek, hole_sizek;
-	unsigned long second_basek, second_sizek;
+	unsigned long second_sizek;
 	unsigned long range0_basek, range0_sizek;
 	unsigned long range_basek, range_sizek;
 	unsigned long chunk_sizek;
@@ -304,7 +304,6 @@ range_to_mtrr_with_hole(struct var_mtrr_state *state, unsigned long basek,
 
 	hole_basek = 0;
 	hole_sizek = 0;
-	second_basek = 0;
 	second_sizek = 0;
 	chunk_sizek = state->chunk_sizek;
 	gran_sizek = state->gran_sizek;
