Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD64C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E88821B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cPrdr72K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfBKTBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:01:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45960 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733288AbfBKTBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:01:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id j3so5672671pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ospWOkK/asl+2XUsQlMJFKpsi9hzWjjt+jhjOjpJePI=;
        b=cPrdr72Kr46b07xpUQKaCG7VTFOHLxgcw45o9iw78EhuSq7MrWyovKXYsbT1a4Opkh
         34TWfkx3SN4fwpRBy0nuoPsIbVAH4sR0fPSl76R3+KoOHMQQ7cPgWu3+aOI+szFQmiCV
         FJ59yNb8z42cC15frnhqLLeFhkijlhl6IdKX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ospWOkK/asl+2XUsQlMJFKpsi9hzWjjt+jhjOjpJePI=;
        b=IxSVQZ4h2k2/a7WqeSmhdV9iAVvSBzVAeuVErptrOIuLTzziC891VKvWvABfBkO+g1
         OXjxJuDa8WmBSIc5EYL62z/+TehGSSZSHoBNxYkfm+T2GuLX9VldO3ObDwbxD1Pa5jW9
         ZpcwVBf4C30w9HqoRQpvYlBp17c7AbcXtD3TwzAbVLgl9rzlgnWrpjYhtddODKtaOHlw
         +dt32bluYzBrdqP+wiMgSYGvzFtff1CN17rMoEXwMhG9yTlLLitMNTPlgwVzW6s83u3z
         H2GganopI1Drt5+N9INlBkzrtVd9FGn5gDiVGi07Uni93tKmkPXp909GWYhkJU6UaVO9
         KFwA==
X-Gm-Message-State: AHQUAube3Dd8Hg8Kt58rs7k1lpCROd5/ewlpmlz8pjwChgWTtJ7+LTGd
        2PspUu3kYfz750aFWWz0aJv2jQ==
X-Google-Smtp-Source: AHgI3IaBVulANnnt7/Hga9dkaw0EBHRVy/8a59aq7GsateTny2FVQHpSAUn1T9iDVh4zv2fqS+aVHA==
X-Received: by 2002:a63:2ad4:: with SMTP id q203mr10550084pgq.43.1549911676251;
        Mon, 11 Feb 2019 11:01:16 -0800 (PST)
Received: from egranata0.mtv.corp.google.com ([2620:15c:202:1:e209:54cf:7c16:6776])
        by smtp.gmail.com with ESMTPSA id k66sm976877pgc.24.2019.02.11.11.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:01:15 -0800 (PST)
From:   egranata@chromium.org
To:     hdegoede@redhat.com, mika.westerberg@linux.intel.com,
        dtor@chromium.org, andy.shevchenko@gmail.com, rafael@kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org, gwendal@chromium.org,
        linux-acpi@vger.kernel.org, briannorris@chromium.org,
        andriy.shevchenko@linux.intel.com
Cc:     egranata@google.com, Enrico Granata <egranata@chromium.org>
Subject: [PATCH v2] driver: platform: Support parsing GpioInt 0 in platform_get_irq()
Date:   Mon, 11 Feb 2019 11:01:12 -0800
Message-Id: <20190211190112.209286-1-egranata@chromium.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <20190207185917.167829-1-egranata@google.com>
References: <20190207185917.167829-1-egranata@google.com>
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
Changes in v2:
 - only support IRQ index 0

 drivers/base/platform.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4d..0d3611cd1b3bc 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -127,7 +127,20 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
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
+	if (num == 0 && has_acpi_companion(&dev->dev))
+		return acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
+
+	return -ENXIO;
 #endif
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
-- 
2.20.1.791.gb4d0f1c61a-goog

