Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EE7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E862077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DVXoGJxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfBUTev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:34:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32957 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBUTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:34:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so14665697plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 11:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wHmyEQWcYmfGuxqF9at/FtBIGcS67/2bcgFa6BHBtw=;
        b=DVXoGJxf+pwEAbGu2VxoD5GGWWtYKdUCcTqK3mY3A/+rfWZN85VnmTN6Z5PRbvoZkE
         kOsyG4VJEUt6YoMH4bYsMKWKdBK3oKzxNHexxDKJTyxFVhob45dNjGNpXk8Nr27mOnkH
         LFZvKPbxhXqb4AKMR9FRsiRN0pTUVS5TOyMUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wHmyEQWcYmfGuxqF9at/FtBIGcS67/2bcgFa6BHBtw=;
        b=Ha6dyK/E6RkQ72F8ZZ7bWQeqn5Dgw+Xmqx6Qu6CfLriyBRxY50LKKDhQ8R+RIygHGv
         g/G/YVUMg8EH5XfbXyjH0NGd3hKwyoFy7/xjxaFrG7e6Yqyrj3XFx08+0xFt0kH3af1r
         uHVjFRQ46pTapiW37wxDXXEgvOvztHN+H62GsggSCHwoQtZ5du3ykTWBLKpd4IosWkuj
         doQGgJzWTK2C7Aecpq9xK+gNexyMfnTKx0nnvbAZlGfNYMry9BMPZew92WzLQ65trqj6
         le4u863xh6LqRnjpboBN8dogJIddfwkoWGbporNI8ARZR+KBJkWrLpympB5fBWfIMdHH
         GiQg==
X-Gm-Message-State: AHQUAubpfLQFE729xKnjkF4eyE/cN4oBkFVK+uwq4lr7Je4ACNC1vr+z
        Zv4SBAc1D/1J476y9DRY7RFHrw==
X-Google-Smtp-Source: AHgI3IYRH9xeguWlRd8zbzRZVjocQ9i+QJimFuhUK4oeJZDhxxc+HPEDIvQd2CFu8Rg7MK8m8RrG+w==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91mr153608plb.215.1550777690549;
        Thu, 21 Feb 2019 11:34:50 -0800 (PST)
Received: from egranata0.mtv.corp.google.com ([2620:15c:202:1:e209:54cf:7c16:6776])
        by smtp.gmail.com with ESMTPSA id k26sm37982389pfb.87.2019.02.21.11.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 11:34:49 -0800 (PST)
From:   egranata@chromium.org
To:     gwendal@chromium.org, briannorris@chromium.org,
        hdegoede@redhat.com, mika.westerberg@linux.intel.com,
        dtor@chromium.org, andy.shevchenko@gmail.com, rafael@kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        andriy.shevchenko@linux.intel.com
Cc:     egranata@google.com, Enrico Granata <egranata@chromium.org>
Subject: [PATCH v3] driver: platform: Support parsing GpioInt 0 in platform_get_irq()
Date:   Thu, 21 Feb 2019 11:34:29 -0800
Message-Id: <20190221193429.161300-1-egranata@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190220180538.GA42642@google.com>
References: <20190220180538.GA42642@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

ACPI 5 added support for GpioInt resources as a way to provide
information about interrupts mediated via a GPIO controller.

Several device buses (e.g. SPI, I2C) have support for retrieving
an IRQ specified via this type of resource, and providing it
directly to the driver as an IRQ number.

This is not currently done for the platform drivers, as platform_get_irq()
does not try to parse GpioInt() resources. This requires drivers to
either have to support only one possible IRQ resource, or to have code
in place to try both as a failsafe.

While there is a possibility of ambiguity for devices that exposes
multiple IRQs, it is easy and feasible to support the common case
of devices that only expose one IRQ which would be of either type
depending on the underlying system's architecture.

This commit adds support for parsing a GpioInt resource in order
to fulfill a request for the index 0 IRQ for a platform device.

Signed-off-by: Enrico Granata <egranata@chromium.org>
---
Changes in v3:
 - ensured that -ENOENT return from acpi_dev_gpio_irq_get is not propagated
   upwards, as some drivers expect platform_get_irq to return either a valid
   IRQ or -ENXIO and will break otherwise

 drivers/base/platform.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4d..afd8b916303e4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -127,7 +127,24 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
+
+	/*
+	 * For the index 0 interrupt, allow falling back to GpioInt
+	 * resources. While a device could have both Interrupt and GpioInt
+	 * resources, making this fallback ambiguous, in many common cases
+	 * the device will only expose one IRQ, and this fallback
+	 * allows a common code path across either kind of resource.
+	 */
+	if (num == 0 && has_acpi_companion(&dev->dev)) {
+		int ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
+
+		if (ret > 0 || ret == -EPROBE_DEFER)
+			return ret;
+	}
+
+	return -ENXIO;
 #endif
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

