Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8C4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B682172E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tOOcRHpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B682172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeI1F7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:59:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40698 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeI1F7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:59:41 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8RNcokK004671;
        Thu, 27 Sep 2018 18:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538091530;
        bh=7H18ATYtkZ7ntXdwhBId23h6MAPEp21p910ygKNaZGc=;
        h=From:To:CC:Subject:Date;
        b=tOOcRHpGe9lsgpTrSt/o+FGLRz6P3NdIHAsceplZ02X1aIPihg19oi9qCjxGaeP5Q
         juJALMshbre3zKwl1jyM5ln9/NTzIE34WHahWwyC7NOSJyl2/eb/2wZXZYa3lycyPU
         0EKxITKrYfTovIfBwndxt71bFThi34C/xvb9lVeI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8RNcod9003726;
        Thu, 27 Sep 2018 18:38:50 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 27
 Sep 2018 18:38:49 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 27 Sep 2018 18:38:50 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8RNcnnC011093;
        Thu, 27 Sep 2018 18:38:49 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8RNcnx19942;
        Thu, 27 Sep 2018 18:38:49 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] gpio: omap: drop omap_gpio_list
Date:   Thu, 27 Sep 2018 18:38:44 -0500
Message-ID: <20180927233844.18443-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

omap_gpio_list is unused so drop it.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c0d7ae7..287c933 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -34,8 +34,6 @@
 #define OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER	BIT(2)
 #define OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN	BIT(1)
 
-static LIST_HEAD(omap_gpio_list);
-
 struct gpio_regs {
 	u32 irqenable1;
 	u32 irqenable2;
@@ -1493,8 +1491,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	pm_runtime_put(dev);
 
-	list_add_tail(&bank->node, &omap_gpio_list);
-
 	return 0;
 }
 
-- 
2.10.5

