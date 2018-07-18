Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E91ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A746E20856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="JTzXHNSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A746E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeGRQAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:00:40 -0400
Received: from smtpbg65.qq.com ([103.7.28.233]:60371 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730383AbeGRQAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1531927328;
        bh=qBIJT70L53W2TP0L9Rv0a8wrkIYbCvJ2iETSpv9Au9I=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=JTzXHNSPimgsuoTcPeIMuBhLSDiSEUFMQGhO7f54jaBFd08pBWi/2zzGtdm1tcepB
         k8R77Q/xTRu6xsgWQ04TNXXheq4bFBCnV9/dVA8/6VINTXvUTShrQ4GtuhSavta54Z
         qGiBYU8gvJktEpYefQrcoapB//Fh1MQ9eyfpgeoE=
X-QQ-mid: esmtp7t1531927327tyj5db33s
Received: from myserver.localdomain (unknown [115.171.112.219])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 18 Jul 2018 23:22:06 +0800 (CST)
X-QQ-SSF: B0000000000000F0FM300F00000000V
X-QQ-FEAT: RckgDqrZPfAY9DZwEY0qbXZ++mpbM4kRTnSCIqvlobLT5fOda0T0TOhcE8WSN
        c+R+ONTbMXg3JoEkgi/oosPX8chQue9na65y65fuf2XWW1lJF28R5RtQ3jPAiF5GB2csmLG
        tXAb8AGHX9KB1WERsCeZLZNNubVnXeiAUgs1JYllnYRzrC7GhY8PEHQZ+Eok5k/XW/EzNKy
        2ehxalpeSCv/hzWqLv9QpZXHs1p7UIH7/jrO0lGijQqjZ1hEZqUYRxwcKh2okUSScyNJrzB
        T85PkAXwblNW3c7lEcDNf/g7hjhtMCYgfJnA==
X-QQ-GoodBg: 0
From:   elicec <elicec@foxmail.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     elicec <elicec@foxmail.com>
Subject: [PATCH] power:ds2782:Fix description error
Date:   Wed, 18 Jul 2018 15:20:33 +0000
Message-Id: <20180718152033.5880-1-elicec@foxmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign3
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After add support for ds2786 battery gas gauge，the description
didn't update. fix it.

Signed-off-by: elicec <elicec@foxmail.com>
---
 drivers/power/supply/ds2782_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index a1b7e0592245..924e99d1e69e 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -471,5 +471,5 @@ static struct i2c_driver ds278x_battery_driver = {
 module_i2c_driver(ds278x_battery_driver);
 
 MODULE_AUTHOR("Ryan Mallon");
-MODULE_DESCRIPTION("Maxim/Dallas DS2782 Stand-Alone Fuel Gauage IC driver");
+MODULE_DESCRIPTION("Maxim/Dallas DS2782/DS2786 Stand-Alone Fuel Gauage IC driver");
 MODULE_LICENSE("GPL");
-- 
2.17.1



