Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA8BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE702147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="g9GXnWbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfBTLMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:12:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51581 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfBTLMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:12:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id n19so6162418wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 03:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Bf5dwgVrtAeYPaTQyE6LLHmqh5tStzzBNVA9ZQP9F0=;
        b=g9GXnWbVWDFrhUXPyCPVZ2tnLmjtyPd6kUlcFNSZtTIIwu7R5KAnk2FMK+34sSSNtb
         uv7rsFMBHENrr6DCc7EANsfez/b4ajevXz5a2RFlu8+Rb3M2sZBKSHgi2scBNbWBClfN
         +qxt05bIDU+F596abgw6rZG/uSuw/ckvuGT6FwXjcorWeSrw4i4QrKQRicaStbS5WRXQ
         ldlote89rbWpuBtB2pTM8PVJ/i1xecugXB4n3ooADHJFZB3yLMuET4ACBfD7dDolWlXq
         NfUMUWTm3bcffcOkXFQGa1IDfbFC07xnwgkiYG1HAv+d8/4c08jxUnAi8bFz9aBJPLyn
         OL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Bf5dwgVrtAeYPaTQyE6LLHmqh5tStzzBNVA9ZQP9F0=;
        b=Fr3Ab2v9Lsmsi7MfR+juVOLajS+UmfjZcLuGr8wHCbJYbneKbuTTTlp0gu5vPs3MJb
         gDzcYrioyY6UKfWEPYWE9Ee/Ri3khVD3+4EC1Cm0Wnt+3PBv/dxHatXCCsP3PBUj81QR
         AoEedZ3wmY7CaAWYG7y52jvLRcBAXv6nAuIQLnY7AkhfwFMcuYEyaTpc1MyPTYJQ4+HY
         4xtTlm0NpMUDwAgmHA1FmjlDE7szodYiyUZ6oI9aTXiO3Dma0BgdoJOa6tNVta1AP1YO
         4LOZOsxM0so3R9Iv0sbhvCmTRrNn1nelt4/CY4gk9Q9glr+f9TUz98oa+OzS8s33bi0z
         8YQw==
X-Gm-Message-State: AHQUAuamhDUgmTK5Jr+FT82iWK7FWltPDDxhFWopYGOIs88s5tYfDVB+
        2W7TnPOpWKWNJ7P1QIFNMMKbNw==
X-Google-Smtp-Source: AHgI3Ib/ALjnRI3t38JISI8vEaaurxG7wz7YBEXLiLD0eiuJy3OK/VZ3UyuxyGC+Tap3bsBtIqZQpA==
X-Received: by 2002:a1c:a9d0:: with SMTP id s199mr6180316wme.142.1550661168549;
        Wed, 20 Feb 2019 03:12:48 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c18sm22969770wre.32.2019.02.20.03.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:12:47 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/2] drivers: provide devm_platform_ioremap_resource()
Date:   Wed, 20 Feb 2019 12:12:39 +0100
Message-Id: <20190220111240.10041-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220111240.10041-1-brgl@bgdev.pl>
References: <20190220111240.10041-1-brgl@bgdev.pl>
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
index 1c958eb33ef4..f82691e1c26c 100644
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
+EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
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

