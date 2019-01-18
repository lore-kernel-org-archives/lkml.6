Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C741C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8522086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfARVkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:40:23 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.87]:40326 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729595AbfARVkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:40:23 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 8F17A182FE8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 15:40:22 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id kbsEgahwJ4FKpkbsEg0HWy; Fri, 18 Jan 2019 15:40:22 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=59080 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gkbsD-001fP8-QU; Fri, 18 Jan 2019 15:40:21 -0600
Date:   Fri, 18 Jan 2019 15:40:18 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/komeda: Remove unused variable
Message-ID: <20190118214018.GA24089@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gkbsD-001fP8-QU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:59080
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable *pdev* in komeda_parse_dt():

drivers/gpu/drm/arm/display/komeda//komeda_dev.c: In function ‘komeda_parse_dt’:
drivers/gpu/drm/arm/display/komeda//komeda_dev.c:52:26: warning: unused variable ‘pdev’ [-Wunused-variable]
  struct platform_device *pdev = to_platform_device(dev);
                          ^~~~

Fixes: 7e8d4fcf8daf ("drm: arm/komeda: Remove IRQ parsing from initial series")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index 16f4e72abc1a..0fe6954fbbf4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -49,7 +49,6 @@ static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_node *np)
 
 static int komeda_parse_dt(struct device *dev, struct komeda_dev *mdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *child, *np = dev->of_node;
 	struct clk *clk;
 	int ret;
-- 
2.20.1

