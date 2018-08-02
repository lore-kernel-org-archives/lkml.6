Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC75C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F69C2150B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F69C2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbeHBOW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:22:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54817 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbeHBOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:22:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72CVs053499909
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 05:31:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72CVsYs3499906;
        Thu, 2 Aug 2018 05:31:54 -0700
Date:   Thu, 2 Aug 2018 05:31:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chengguang Xu <tipbot@zytor.com>
Message-ID: <tip-765d28f136291f9639e3c031a1070fb76d6625c7@git.kernel.org>
Cc:     cgxu519@gmx.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, cgxu519@gmx.com
In-Reply-To: <1528804132-154948-1-git-send-email-cgxu519@gmx.com>
References: <1528804132-154948-1-git-send-email-cgxu519@gmx.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Remove redundant check for kmem_cache_create()
Git-Commit-ID: 765d28f136291f9639e3c031a1070fb76d6625c7
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

Commit-ID:  765d28f136291f9639e3c031a1070fb76d6625c7
Gitweb:     https://git.kernel.org/tip/765d28f136291f9639e3c031a1070fb76d6625c7
Author:     Chengguang Xu <cgxu519@gmx.com>
AuthorDate: Tue, 12 Jun 2018 19:48:52 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 14:27:35 +0200

x86/mm: Remove redundant check for kmem_cache_create()

The flag 'SLAB_PANIC' implies panic on failure, So there is no need to
check the returned pointer for NULL.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/1528804132-154948-1-git-send-email-cgxu519@gmx.com

---
 arch/x86/mm/pgtable.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e3deefb891da..0f1683fcb196 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -329,9 +329,6 @@ static int __init pgd_cache_init(void)
 	 */
 	pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_ALIGN,
 				      SLAB_PANIC, NULL);
-	if (!pgd_cache)
-		return -ENOMEM;
-
 	return 0;
 }
 core_initcall(pgd_cache_init);
