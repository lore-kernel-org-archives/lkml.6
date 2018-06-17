Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA354C5CFC1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 00:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BE2208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 00:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S59XC7uS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BE2208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbeFRAAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 20:00:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39114 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbeFRAAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 20:00:08 -0400
Received: by mail-pf0-f193.google.com with SMTP id r11-v6so7259019pfl.6;
        Sun, 17 Jun 2018 17:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6I3Rk+XVG5DCzpHQAYBNwGSxhzfj1pRJa6gqMHgE5KI=;
        b=S59XC7uS1ApMdD5seBu7wsXk0kk12Li5ukHCkqu7Lt4KVT3yZfVxHfW7cbe933ZeT0
         zsWB28iWvKHJGzc28JpYoe/YBTuYrSwgdNHGbaYUxTNHcOW4KiJn3DLdzJ5UpghsoULf
         i8aN4w2WVaEavY059OEbMoZiI5wq42iubm6M02cxioXOdMaGkko/rPDBLQAAeOCEp4Z5
         XKTDjs77w00zTggIB2S+QWK46h6V5/t7OUQSv620ELFWJTU7+i1gmKZ/4KG6cMBgjMHa
         PdOtwA6/P2MTfKdMrCvFn4u8DNkJPvHbSXr+umwAsO1SM6dp33/N37vhA7g+LakKomN2
         v0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6I3Rk+XVG5DCzpHQAYBNwGSxhzfj1pRJa6gqMHgE5KI=;
        b=A9sTGgQG6gW9GdJnmNhJ2oSCSXyC0mTZwZNabNKE1u3cWmRHmfoQxx5k359QTWEpU0
         tZdjU9j689OPZLHrctokFvvVPTG2jHFU3HeqbnnEoQmXyqI28MnBsD9SVETeErI13gnF
         DglspHTLMuuXD1SmiOi07VZZsKG6ecrCEF2xc+TvXe0JWumN/7xa0chNB4nm3IcUeZ6A
         H9JabbxLDpVm+IfLcqqLvAsZjZWybKfDjGQde0voVjkkSkIioE6pi3gQNsGkdDqfwkKH
         FOhZxzLJb+zATS7HsmZQ4ocXfy2dl4ANyh9sBDx8e6lnXGwpcHUGLfsQxyyexwThiaKc
         nRVw==
X-Gm-Message-State: APt69E3HAmktqpX2Gj+tRPB62D3hzaHczSiUV6ryDwuT/1FFqs8d90YV
        4IOXEbTNnWyAWQrL+gTzpLIVuG9TRDI=
X-Google-Smtp-Source: ADUXVKIMHi5PsPohm0C8DG4TjnWI/nILy/bXob3SAMx0Q2GqErE7NY9iMYturo/j5F/9vSAHqnHhuQ==
X-Received: by 2002:a62:df12:: with SMTP id u18-v6mr11207815pfg.230.1529280007401;
        Sun, 17 Jun 2018 17:00:07 -0700 (PDT)
Received: from localhost.localdomain ([101.23.151.28])
        by smtp.gmail.com with ESMTPSA id r79-v6sm26855096pfe.115.2018.06.17.17.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 17:00:06 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        andy@infradead.org, dvhart@infradead.org, hdegoede@redhat.com,
        youling257 <youling257@gmail.com>
Subject: [PATCH v4] platform/x86: touchscreen_dmi: Add info for the ONDA V891W Dual OS tablet
Date:   Mon, 18 Jun 2018 07:58:12 +0800
Message-Id: <20180617235812.18596-1-youling257@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the ONDA V891W Dual OS tablet

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

