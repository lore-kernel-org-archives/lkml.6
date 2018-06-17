Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8837C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B44A20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tASNR7ZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B44A20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbeFQODk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 10:03:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38012 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeFQODh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:03:37 -0400
Received: by mail-pl0-f65.google.com with SMTP id b14-v6so7645856pls.5;
        Sun, 17 Jun 2018 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JY4ecY2hNvoD2gJibJnty0k2GYL4jklbWXnltNxBS04=;
        b=tASNR7ZMtzFW/I0cF2D4lsjzkAWuRQDktbd/36yhB81daqZtBrqofBcGseAOStbyhX
         P2AvJmaFRSvsMATLLgWk72dmAVAorC7XkJ6RKSUknZGdDo0+7MI72hZyAggy0vx+s2tw
         I9nUkm/xy4vDezaTCYa91qtQZwJ9FbBoRWnZfGS/FxEhCX45rZCV2NNwix8mOnIGy1zK
         e1h4u81A4xheIYmDrGZIfy0WCKwBP4LMjncWimPZNYtX9qR5KRj/d30rNY28xP8FwaVR
         tfznB4x+tFPughf3qoPNMqpbC5GosLrd11xIJ0gGuOe79V8xgup7bdVvXwKKRpiZMnMk
         fNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JY4ecY2hNvoD2gJibJnty0k2GYL4jklbWXnltNxBS04=;
        b=tgBhsikPnIAtK6saDWsa1LI48dCT7hVqiypzqIieIeXtAHAW9xR5xx+ovr8rF5tsYK
         O70AYxy454E8RyKejNOw/qVBqvmFkZR/UXjhzU3PxaEY6amJf1kvhYOXEpMrEpKVIzwZ
         Vk9W7QUSjnV710kBaCqWI4oJPTPh/fxn9RazqDRAxt1rjVYWP8dY5eMtwbofeas/S5mu
         NRry2h1iFZD0EmAgbXVwGYyQS/ei8zoTQv3wgpHknLb5c80PrY5T6pAgbFixi0r7arCT
         2AQhtwJ79IhHF+n9uHt4ESU9rWN+VvGnJRIfMm8TUmksf3MYVq3KbHKqjfpzUMN/wKZT
         BIXQ==
X-Gm-Message-State: APt69E030Xvy1iVSaI7x6iwsd61y3s6M2uXMwrEGzcTcEiTpgtQKmzYr
        mZnNvuWMeCxZFc49UnMpAbDLEdEraXA=
X-Google-Smtp-Source: ADUXVKIfvooDxiKEpX5BED0GqeU1+KZegBq8ugQgz7jhAx/61z0qJgBBfNlA97Cym8zUEbN6rDG61Q==
X-Received: by 2002:a17:902:7c8b:: with SMTP id y11-v6mr9947875pll.222.1529244216213;
        Sun, 17 Jun 2018 07:03:36 -0700 (PDT)
Received: from localhost.localdomain ([101.23.151.28])
        by smtp.gmail.com with ESMTPSA id k84-v6sm34465470pfh.110.2018.06.17.07.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 07:03:35 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        andy@infradead.org, dvhart@infradead.org, hdegoede@redhat.com,
        youling257 <youling257@gmail.com>
Subject: [PATCH v3] platform/x86: touchscreen_dmi: Add info for the ONDA V891W Dual OS
Date:   Sun, 17 Jun 2018 22:03:26 +0800
Message-Id: <20180617140326.12854-1-youling257@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the ONDA V891W Dual OS

Signed-off-by: youling257 <youling257@gmail.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 6284946cb0d1..2ad9327c8c0f 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -221,6 +221,24 @@ static const struct ts_dmi_data onda_v891w_v1_data = {
 	.properties	= onda_v891w_v1_props,
 };
 
+static const struct property_entry onda_v891w_v3_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 35),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 15),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1625),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1135),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl3676-onda-v891w-v3.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data onda_v891w_v3_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= onda_v891w_v3_props,
+};
+
 static const struct property_entry pipo_w2s_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 880),
@@ -481,6 +499,15 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
 		},
 	},
+	{
+		/* ONDA V891w Dual OS P891DCF2V1A01274 64GB */
+		.driver_data = (void *)&onda_v891w_v3_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ONDA Tablet"),
+			DMI_MATCH(DMI_BIOS_VERSION, "ONDA.D890HBBNR0A"),
+		},
+	},
 	{
 		/* Pipo W2S */
 		.driver_data = (void *)&pipo_w2s_data,
-- 
2.17.1

