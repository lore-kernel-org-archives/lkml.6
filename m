Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C107C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E492088F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0fcmkAdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E492088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeILMzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54883 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbeILMzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so1238235wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=874CbkmyKCyBfTs9WgjHeXXK4p9vYZrCF79UGreNijg=;
        b=0fcmkAdGGjX6PqCjtegwJhJeQhl48mWkz1eQv+8PZwAHo/5hd+j3atP4b/u0VjmmlA
         MTal8Ku460qYWGwIeAL659rffFpPc7eez67ISXar9sEWrQzGRQ+54ICt+evGI/fpuxoj
         2sHyzLW7feYy70LMaFSyjx3ca3A342/hAhIY4I8/ADzPFgPWouwsIon49aYIIAosIqTm
         F1IbwFbcxmxIs+kphF3MDOu+2hk6YTTd1r5DaE/imjpQLs+XlZHrpHp5qJ8F4s0xRPLt
         S4/PfwV7O1O0wwfNLqJ118AWdg9Ntyp6UIeZXn1w9+48I+FjfZ7lmpaxn52ylqhWjDKH
         c7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=874CbkmyKCyBfTs9WgjHeXXK4p9vYZrCF79UGreNijg=;
        b=IJsUob2Uy8QNs5TltsltAI/+zX6+R99ftK4IzoqQmidzWRAiVBEWLWHfi1nxMJ+3pF
         Sd4tM/TN3rZ8YVkWMUQ2QMrk3MJyNWk0I/8GZUpeycZmXtDyOEwB+GPe3eUnE/wWcF/V
         QmxcrE70Gvd1ZRBABYTLSLRa5kKhqU2Ce80JHO6DRD5PqIY32RrQx9fkjowQnA0yDIXE
         WU5uEZmGeVmbvTBlK7q9zAJmrWq4HNZmlS1IT1LvdDR5FwoFCbKfjvdQu168iye1n0DT
         My8IyE0rq4RktpNpfe447jY+83MYvdbrJCD9ygnWb9H11fkYJL/D1IO4TiZB4QhYODon
         4K4g==
X-Gm-Message-State: APzg51Az01hqpdagkr5r5oCAlpA3+cPVcYZH3LEMpk8C0ktHlM+CfxtS
        +JZMIUxKGt5c5zbFmX77MUJMFw==
X-Google-Smtp-Source: ANB0VdbYu2ZmSnEPzAYWqzN/NKyhQxTv34ot517c7yXNzw9NIn7TMv4uhlcVQQW2vZSLwxUgs7tkKg==
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr662825wme.135.1536738716982;
        Wed, 12 Sep 2018 00:51:56 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:51:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 08/21] nvmem: sunxi_sid: use devm_nvmem_register()
Date:   Wed, 12 Sep 2018 09:51:16 +0200
Message-Id: <20180912075129.25185-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the resource managed variant of nvmem_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/sunxi_sid.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index d020f89248fd..0296c23db322 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -181,15 +181,13 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	else
 		econfig.reg_read = sunxi_sid_read;
 	econfig.priv = sid;
-	nvmem = nvmem_register(&econfig);
+	nvmem = devm_nvmem_register(dev, &econfig);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
 	randomness = kzalloc(size, GFP_KERNEL);
-	if (!randomness) {
-		ret = -EINVAL;
-		goto err_unreg_nvmem;
-	}
+	if (!randomness)
+		return PTR_ERR(-EINVAL);
 
 	for (i = 0; i < size; i++)
 		econfig.reg_read(sid, i, &randomness[i], 1);
@@ -200,17 +198,6 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, nvmem);
 
 	return 0;
-
-err_unreg_nvmem:
-	nvmem_unregister(nvmem);
-	return ret;
-}
-
-static int sunxi_sid_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
 }
 
 static const struct sunxi_sid_cfg sun4i_a10_cfg = {
@@ -243,7 +230,6 @@ MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
 
 static struct platform_driver sunxi_sid_driver = {
 	.probe = sunxi_sid_probe,
-	.remove = sunxi_sid_remove,
 	.driver = {
 		.name = "eeprom-sunxi-sid",
 		.of_match_table = sunxi_sid_of_match,
-- 
2.18.0

