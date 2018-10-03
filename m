Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF9C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579DD21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8dde0FF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579DD21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJDBep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:34:45 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:41266 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDBep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:34:45 -0400
Received: by mail-vs1-f73.google.com with SMTP id d20-v6so2165597vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2jqmZXZcmEO8jDaXajPefPx2WtSyp0rzTCLt0BhvU+o=;
        b=V8dde0FF/b11+nft1GNybJorR6zUgmoCIs7b3IpkG3YQWbmBGYnftw3KC8LQG+JrNN
         8nAruSauXuoc6KSrQhA51d7cevB9fYCzZC5fehPUQGDFu4KyPMZw8Fq6bVg3vUs8c+MU
         n9xhcdXON9Crc8o+N7ShWlpaeHEAWh0yf5jjYyUvmLaMUEEdZ2CIeiHzwrgiVb+O8dzT
         s7haKaaOXimzDzbbHNHBo/jkEwg7Mv8soIS8AsqNtVdphiRySCnhveqp9hJvyEJQDlhq
         0p+H4vosQqoD0RoJZY2aWZf4PyfXTLC0faxb0qX28aozbJWzT+Ko9y0rarta7dErJfRY
         lREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2jqmZXZcmEO8jDaXajPefPx2WtSyp0rzTCLt0BhvU+o=;
        b=OEgzZ0rmE/4G2n4EMvYr5YXEXBHH0lpSve7fXJVfkfX4fXGY2qtWV+K5fMTXQiPH99
         6abjBZyZ7pydYpJnAsLqwPwEpEGiJJzE1mejFCEblACuCsHMjUHby58NO+g7y397IRpt
         kT0Kj6aPqkW4BGD6kDBhC2X6ghSZ85vOSUrKqZRs+BSiHS+jrww13LIgQyvBwdyTnmDX
         y663PVqj8FbTzoKylxeWQI3OWpBmjbBVWeVaAsRJy+ocZvr1iq/FRFKe3YP9Gfz+/njl
         6rpXdZVyF2aWH95SaZBfxBYoovi0weF7asy38Y+9pJqGNm1tRZO3r1H4rWXEFyZ1RKB/
         +Ueg==
X-Gm-Message-State: ABuFfoi9apnAPMxzg5EqdlAj7qW/KauA2J/x8qQLA1omBbLdWQLXCdbb
        a7NVKpXW4e8+HjD4XLc0jQsu6yMlSJeVxg==
X-Google-Smtp-Source: ACcGV61S7w+cfR2qFuWVo6ZRdADPP3HTbuNREhLWJBRlnom1r7Kk+eyp3LsMsM3ID0gPgHdf/p0OaaLN4ikLaQ==
X-Received: by 2002:a67:46da:: with SMTP id a87mr198067vsg.3.1538592309254;
 Wed, 03 Oct 2018 11:45:09 -0700 (PDT)
Date:   Wed,  3 Oct 2018 11:45:06 -0700
Message-Id: <20181003184506.149579-1-egranata@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 2/2] platform/chrome: Add a new interrupt path for cros_ec_lpc
From:   Enrico Granata <egranata@google.com>
To:     Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        gwendal@chromium.org
Cc:     Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

This commit allows cros_ec_lpc to register a direct IRQ instead of relying
on the ACPI notification chain to receive MKBP events.

This change is done in the interest of allowing reduced jitter in the
communication path between the CrOS EC and the host for receiving sensor
data.

Signed-off-by: Enrico Granata <egranata@chromium.org>
---
 drivers/platform/chrome/cros_ec_lpc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 31c8b8c49e45..07eea608915e 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -25,6 +25,7 @@
 #include <linux/dmi.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
 #include <linux/mfd/cros_ec_lpc_reg.h>
@@ -248,7 +249,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	acpi_status status;
 	struct cros_ec_device *ec_dev;
 	u8 buf[2];
-	int ret;
+	int irq, ret;
 
 	if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
 				 dev_name(dev))) {
@@ -287,6 +288,18 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 			   sizeof(struct ec_response_get_protocol_info);
 	ec_dev->dout_size = sizeof(struct ec_host_request);
 
+	/*
+	 * Some boards do not have an IRQ allotted for cros_ec_lpc,
+	 * which makes ENXIO an expected (and safe) scenario.
+	 */
+	irq = platform_get_irq(pdev, 0);
+	if (irq > 0)
+		ec_dev->irq = irq;
+	else if (irq != -ENXIO) {
+		dev_err(dev, "couldn't retrieve IRQ number (%d)\n", irq);
+		return irq;
+	}
+
 	ret = cros_ec_register(ec_dev);
 	if (ret) {
 		dev_err(dev, "couldn't register ec_dev (%d)\n", ret);
@@ -294,11 +307,11 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Connect a notify handler to process MKBP messages if we have a
-	 * companion ACPI device.
+	 * If we have a companion ACPI device and no dedicated IRQ
+	 * connect a notify handler to process MKBP messages.
 	 */
 	adev = ACPI_COMPANION(dev);
-	if (adev) {
+	if (adev && ec_dev->irq <= 0) {
 		status = acpi_install_notify_handler(adev->handle,
 						     ACPI_ALL_NOTIFY,
 						     cros_ec_lpc_acpi_notify,
-- 
2.19.0.605.g01d371f741-goog

