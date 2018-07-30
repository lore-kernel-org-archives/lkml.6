Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD701625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C32220881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C32220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeG3TZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:25:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeG3TZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:25:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UHmrjO2392421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 10:48:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UHmrtw2392418;
        Mon, 30 Jul 2018 10:48:53 -0700
Date:   Mon, 30 Jul 2018 10:48:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for zhong jiang <tipbot@zytor.com>
Message-ID: <tip-5db1b1e1ee34871b1965b3f890e3ccbdb185fa52@git.kernel.org>
Cc:     tglx@linutronix.de, zhongjiang@huawei.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          zhongjiang@huawei.com
In-Reply-To: <1532958273-47725-1-git-send-email-zhongjiang@huawei.com>
References: <1532958273-47725-1-git-send-email-zhongjiang@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot/KASLR: Make local variable mem_limit static
Git-Commit-ID: 5db1b1e1ee34871b1965b3f890e3ccbdb185fa52
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

Commit-ID:  5db1b1e1ee34871b1965b3f890e3ccbdb185fa52
Gitweb:     https://git.kernel.org/tip/5db1b1e1ee34871b1965b3f890e3ccbdb185fa52
Author:     zhong jiang <zhongjiang@huawei.com>
AuthorDate: Mon, 30 Jul 2018 21:44:33 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 19:46:03 +0200

x86/boot/KASLR: Make local variable mem_limit static

Fix the following sparse warning:

arch/x86/boot/compressed/kaslr.c:102:20: warning: symbol 'mem_limit' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/1532958273-47725-1-git-send-email-zhongjiang@huawei.com

---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 531c9876f573..302517929932 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -102,7 +102,7 @@ static bool memmap_too_large;
 
 
 /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
-unsigned long long mem_limit = ULLONG_MAX;
+static unsigned long long mem_limit = ULLONG_MAX;
 
 
 enum mem_avoid_index {
