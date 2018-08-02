Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656F0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186F5214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186F5214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbeHBO2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:28:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbeHBO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:28:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72CatHe3501285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 05:36:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72CatnX3501282;
        Thu, 2 Aug 2018 05:36:55 -0700
Date:   Thu, 2 Aug 2018 05:36:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhong Jiang <tipbot@zytor.com>
Message-ID: <tip-0b2c1aec49ddb2260894df6c69ae7b34142ff936@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, zhongjiang@huawei.com,
        mingo@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, gregkh@linuxfoundation.org, mingo@kernel.org,
          zhongjiang@huawei.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com
In-Reply-To: <1532162004-24670-1-git-send-email-zhongjiang@huawei.com>
References: <1532162004-24670-1-git-send-email-zhongjiang@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/iommu: Use NULL instead of 0
Git-Commit-ID: 0b2c1aec49ddb2260894df6c69ae7b34142ff936
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

Commit-ID:  0b2c1aec49ddb2260894df6c69ae7b34142ff936
Gitweb:     https://git.kernel.org/tip/0b2c1aec49ddb2260894df6c69ae7b34142ff936
Author:     Zhong Jiang <zhongjiang@huawei.com>
AuthorDate: Sat, 21 Jul 2018 16:33:24 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 14:33:19 +0200

x86/iommu: Use NULL instead of 0

Fixes the following sparse warning:

arch/x86/kernel/pci-iommu_table.c:63:37: warning: Using plain integer as NULL pointer

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <hpa@zytor.com>
Cc: <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/1532162004-24670-1-git-send-email-zhongjiang@huawei.com

---
 arch/x86/kernel/pci-iommu_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pci-iommu_table.c b/arch/x86/kernel/pci-iommu_table.c
index 4dfd90a75e63..2e9006c1e240 100644
--- a/arch/x86/kernel/pci-iommu_table.c
+++ b/arch/x86/kernel/pci-iommu_table.c
@@ -60,7 +60,7 @@ void __init check_iommu_entries(struct iommu_table_entry *start,
 			printk(KERN_ERR "CYCLIC DEPENDENCY FOUND! %pS depends on %pS and vice-versa. BREAKING IT.\n",
 			       p->detect, q->detect);
 			/* Heavy handed way..*/
-			x->depend = 0;
+			x->depend = NULL;
 		}
 	}
 
