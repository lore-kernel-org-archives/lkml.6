Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDAAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E306E20843
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E306E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbeGKIgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:36:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45086 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732427AbeGKIgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:36:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdAYj-0006EQ-5K; Wed, 11 Jul 2018 08:33:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: m48t59: remove redundant pointer 'name'
Date:   Wed, 11 Jul 2018 09:33:12 +0100
Message-Id: <20180711083312.5483-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'name' is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'name' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/rtc-m48t59.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index 1053a406b3aa..ac9ca1042889 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -373,7 +373,6 @@ static int m48t59_rtc_probe(struct platform_device *pdev)
 	struct m48t59_private *m48t59 = NULL;
 	struct resource *res;
 	int ret = -ENOMEM;
-	char *name;
 	const struct rtc_class_ops *ops;
 	struct nvmem_config nvmem_cfg = {
 		.name = "m48t59-",
@@ -448,17 +447,14 @@ static int m48t59_rtc_probe(struct platform_device *pdev)
 	}
 	switch (pdata->type) {
 	case M48T59RTC_TYPE_M48T59:
-		name = "m48t59";
 		ops = &m48t59_rtc_ops;
 		pdata->offset = 0x1ff0;
 		break;
 	case M48T59RTC_TYPE_M48T02:
-		name = "m48t02";
 		ops = &m48t02_rtc_ops;
 		pdata->offset = 0x7f0;
 		break;
 	case M48T59RTC_TYPE_M48T08:
-		name = "m48t08";
 		ops = &m48t02_rtc_ops;
 		pdata->offset = 0x1ff0;
 		break;
-- 
2.17.1

