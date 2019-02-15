Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48737C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159FC21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TOgggReB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395213AbfBOPZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:25:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43549 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732791AbfBOPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:25:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id r2so10724455wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2674JCCrS9ITncu8th674o5gf1yN0RXwfPoyp/h8nM=;
        b=TOgggReBQ7YFwVJQsEWDGzCJaaD1AnAVozGNy0bvhHFOM+NCF3CMY2Ifa4K9xxqTpD
         0aOjxC6hngHY8KWVTp5aMuSe4hXVDcsvSqUMog9hOB3huB+Iq8Uq4MRLnRmh4CMtE+3i
         JezdTJZG09qgAlyDPOcPsylQ0Ue39VCGF0hk3czv3H679p+4z5HEeC7yYPuE5e1Gd2jn
         X/KviqrEB6+PfUI5Gw9LHGMR5KpHEfbctm0+0vEOnDi4oRFoxPaE4/JEKbeUCVyWX/pv
         +3oeUvY2UBV0gZwgglrNDghcAwhbdIFiAYjLqTxDOJuRQm1vDqoeY0wyfBBAYgBX0eid
         jrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2674JCCrS9ITncu8th674o5gf1yN0RXwfPoyp/h8nM=;
        b=hoP7zB/Hh7oFaqdIoPTDQS/TWeb+s2tLkexu/TqvOGdyL+7TDS0wrySnU30dC2apOw
         zD9LjwcVNJ5EjbGZbBYi7IwrSq1HmncsRkmOc/oe4DH91jLkFmIjdno7Aw8M/s4+CfGv
         e1zjUmM/Cl/3xvfxn79/nPm3iBq6BqGI8U04nYMzx+E+18Z6pfh6oiOk23nFBgKtdpXt
         +vCGcBd3Vgkbnj0l9IA/q8ybllHrbaqiVc1oUpVcbA2AVNdPS3OV4H7tDVw/ILNISUXz
         IDRxI/TVs62NqzJHrHSE83vDB7oXrDNzgXGOd/6yGXSLSIvlE3S0YMy2H8FEoSIQzq/o
         /eBg==
X-Gm-Message-State: AHQUAuY3oecGATFVxkHc5NiCoADJia7gR080riILm2Kswu0kCQlMf5Ep
        Tt6OBeXtz6V8O5Bd4h4R9chq9w==
X-Google-Smtp-Source: AHgI3IbsIGofMuWx/ozKHTufDMCzmmS9hoA3NmXbN0u977ok5e5byljrKHNMuHJhXKCy3ILqjWCzDQ==
X-Received: by 2002:a5d:68c2:: with SMTP id p2mr6462464wrw.23.1550244318453;
        Fri, 15 Feb 2019 07:25:18 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id y5sm1904337wmg.31.2019.02.15.07.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:25:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] drivers: provide devm_platform_ioremap_resource()
Date:   Fri, 15 Feb 2019 16:25:06 +0100
Message-Id: <20190215152507.31066-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215152507.31066-1-brgl@bgdev.pl>
References: <20190215152507.31066-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are currently 1200+ instances of using platform_get_resource()
and devm_ioremap_resource() together in the kernel tree.

This patch wraps these two calls in a single helper. Thanks to that
we don't have to declare a local variable for struct resource * and can
omit the redundant argument for resource type. We also have one
function call less.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/platform.c         | 18 ++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4..14400a63cc81 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -79,6 +79,24 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
+/**
+ * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
+ *				    device
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource managemend
+ * @index: resource index
+ */
+void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
+					     unsigned int index)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	return devm_ioremap_resource(&pdev->dev, res);
+}
+EXPORT_SYMBOL(devm_platform_ioremap_resource);
+
 /**
  * platform_get_irq - get an IRQ for a device
  * @dev: platform device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index c7c081dc6034..b126b73ed8ef 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -52,6 +52,9 @@ extern struct device platform_bus;
 extern void arch_setup_pdev_archdata(struct platform_device *);
 extern struct resource *platform_get_resource(struct platform_device *,
 					      unsigned int, unsigned int);
+extern void __iomem *
+devm_platform_ioremap_resource(struct platform_device *pdev,
+			       unsigned int index);
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_irq_count(struct platform_device *);
 extern struct resource *platform_get_resource_byname(struct platform_device *,
-- 
2.20.1

