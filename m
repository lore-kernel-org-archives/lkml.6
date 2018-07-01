Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5F7C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA3624D77
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXvjNnrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA3624D77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeGAVrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 17:47:40 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33169 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbeGAVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 17:47:36 -0400
Received: by mail-qt0-f196.google.com with SMTP id l10-v6so12379664qtj.0;
        Sun, 01 Jul 2018 14:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lVy5TAWvx22BqFCUQamA4m90HZcwdWMblej4nLaEIuE=;
        b=vXvjNnrJwu1KVKGLiHVoN2j62WaPHQrS9yYhETCdSXjzGDnU4cCOdP8YYESW5iigih
         uTMN/vNGXBEnL77WXqPgRIx1n4unQoXmU0PjLqkwpZDQLw9LJ0B8FFcVYH9+HzmHF6X0
         khiX7Qce9SxNo2TLjB/c7xODwjEEt9ZW6kqmMJwjeGaOYAJqoI9GCnvKKposfxOsMXhw
         fXooU2FAd3NgMaWEyOwL2XESbjJqA6LRRFdntWxDOsoxpTcyzgfthuxI9/jwlATdbW7k
         iw9keOCdElBencKzWS0A0GCB7yicvVy034P1oPttiqn6kdhxV1/C3QAlezVFUSgbajR5
         TL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lVy5TAWvx22BqFCUQamA4m90HZcwdWMblej4nLaEIuE=;
        b=VmGy875uPbT0a2YJnHJUxZuesR2Rl41LXpbdNFzRKHbJb9sIxpx73FKINjPsxHUXjV
         pL3kwdDQ0eYEDQeA6QgRGONFMVNpLiJ1177Jltskf1C+BFlAsWA6PREuOJs6TfAwn5Gk
         depRaD7lrprXvymtJVCaSdOteZrOaD5JC6hs1dbsZzjE5XGWxMxZhV9rUcwvMlXNHqDB
         rpZPONEt2/8lHnc0NUXwZs0Pq/vWlogjn1KsgECajkr2qsljToM5JS9tyexL7v1cWXXO
         ztmLXSKLImis4CQ7zjgG3tbtYyGWCa/k+uwdqQlWtdgmphHXvsklkq8oUyExMGzh+1SV
         bBWQ==
X-Gm-Message-State: APt69E3we0iGmlp1P49+k6DCQzw1TlRR1ZX0wvI9vGaprmMxpWgeWuOd
        CQI8/XXI6bOmZKVP9VgyEDVaDakG
X-Google-Smtp-Source: AAOMgpc1eylKfZ0w+mdz1S3VAUWlUNr57ILDV0iFiLjnvrkcJhdMkN/H8Un96NiT+L1/erxdgT1xsg==
X-Received: by 2002:ac8:1a90:: with SMTP id x16-v6mr20158512qtj.160.1530481655380;
        Sun, 01 Jul 2018 14:47:35 -0700 (PDT)
Received: from alienarch.lan (toroon4828w-lp130-01-76-71-113-250.dsl.bell.ca. [76.71.113.250])
        by smtp.googlemail.com with ESMTPSA id l22-v6sm3354095qkh.72.2018.07.01.14.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 14:47:34 -0700 (PDT)
From:   Jun Bo Bi <jambonmcyeah@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     jambonmcyeah@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        dvhart@infradead.org, andy@infradead.org
Subject: [PATCH] platform/x86: touchscreen_dmi: Add touchscreen platform data for the Onda V820w tablet
Date:   Sun,  1 Jul 2018 17:47:14 -0400
Message-Id: <20180701214714.2522-1-jambonmcyeah@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen platform data for the Onda V820w tablet

Signed-off-by: Jun Bo Bi <jambonmcyeah@gmail.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 6284946cb0d1..a8e083db0369 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -204,6 +204,22 @@ static const struct ts_dmi_data onda_obook_20_plus_data = {
 	.properties	= onda_obook_20_plus_props,
 };
 
+static const struct property_entry onda_v820w_32g_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1665),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl1680-onda-v820w-32g.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct silead_ts_dmi_data onda_v820w_32g_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= onda_v820w_32g_props,
+};
+
 static const struct property_entry onda_v891w_v1_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 46),
 	PROPERTY_ENTRY_U32("touchscreen-min-y",  8),
@@ -470,6 +486,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "OBOOK 20 PLUS"),
 		},
 	},
+	{
+		/* ONDA V820w DualOS */
+		.driver_data = (void *)&onda_v820w_32g_data,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ONDA"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "V820w DualOS")
+		},
+	},
 	{
 		/* ONDA V891w revision P891WBEBV1B00 aka v1 */
 		.driver_data = (void *)&onda_v891w_v1_data,
-- 
2.18.0

