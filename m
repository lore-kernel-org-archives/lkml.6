Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF7AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29ADA214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29ADA214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbeHBOV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:21:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbeHBOV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:21:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72CUpOE3499846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 05:30:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72CUpNN3499843;
        Thu, 2 Aug 2018 05:30:51 -0700
Date:   Thu, 2 Aug 2018 05:30:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for zhong jiang <tipbot@zytor.com>
Message-ID: <tip-c7ba9f7cb55926605983187a68624999b93abb94@git.kernel.org>
Cc:     hpa@zytor.com, zhongjiang@huawei.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, zhongjiang@huawei.com, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1533053286-34990-1-git-send-email-zhongjiang@huawei.com>
References: <1533053286-34990-1-git-send-email-zhongjiang@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/platform/olpc: Use PTR_ERR_OR_ZERO()
Git-Commit-ID: c7ba9f7cb55926605983187a68624999b93abb94
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

Commit-ID:  c7ba9f7cb55926605983187a68624999b93abb94
Gitweb:     https://git.kernel.org/tip/c7ba9f7cb55926605983187a68624999b93abb94
Author:     zhong jiang <zhongjiang@huawei.com>
AuthorDate: Wed, 1 Aug 2018 00:08:06 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 14:25:40 +0200

x86/platform/olpc: Use PTR_ERR_OR_ZERO()

Replace the open coded equivalent with PTR_ERR_OR_ZERO().

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1533053286-34990-1-git-send-email-zhongjiang@huawei.com

---
 arch/x86/platform/olpc/olpc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc.c b/arch/x86/platform/olpc/olpc.c
index 7c3077e58fa0..f0e920fb98ad 100644
--- a/arch/x86/platform/olpc/olpc.c
+++ b/arch/x86/platform/olpc/olpc.c
@@ -311,10 +311,8 @@ static int __init add_xo1_platform_devices(void)
 		return PTR_ERR(pdev);
 
 	pdev = platform_device_register_simple("olpc-xo1", -1, NULL, 0);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(pdev);
 }
 
 static int olpc_xo1_ec_probe(struct platform_device *pdev)
