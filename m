Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FADEC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1FB208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XssYln3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1FB208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933496AbeFQNMk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 09:12:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46074 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933183AbeFQNMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 09:12:37 -0400
Received: by mail-pl0-f65.google.com with SMTP id c23-v6so7606000plz.12;
        Sun, 17 Jun 2018 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YhWiE2BT2wgwnTSx8pjE1mvCNO0Xc0SVyeUywctcgcc=;
        b=XssYln3TfJGom7fOygp5ULjp2z7pjOpeO4UmMsW1mDcAPZxufm5d/pPkaIFkkuI/0+
         R3wOvczcHv5tZY5s0jAJiHEMW93NfIgy7I8ZMGHK0NxL9sZSpVWs+hkZ6BFLXqPUOQEb
         7ogbGeJunCBE3dyom0JvRRNQzA2npmumc7Uypov5a6q4D9hvU6fhSaTAiV1AXJlmyPZM
         GBNsi9CDijcJ8qfODOhSlolBcyQCiM8Nmo7UHnd7OoAG4ns24/yUuaVs/VPw0HnrW1mW
         Z3ow+AolRNDMjSRAPXajGcZsl+QBo+SsJ6zzL8w38/M2Yxv1Ypw0Rw6KoEe+EV+nw+VI
         BYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YhWiE2BT2wgwnTSx8pjE1mvCNO0Xc0SVyeUywctcgcc=;
        b=HBSiTO9S9ZACcf3zI08Uygv3juaauUgGguWfG72nWS2682y8j9yJKYsC2o8N9Ub31V
         eaB7JQSeY9z7IRrw8heNDfpSmIyh/GvRlv4PF/Ac2WwFRcZ2b42VlSTrh748KFFkRzjc
         6IFdV5odofD0Bx2EPnfHZ8I9WJXabJeMLOcSrt2qN1pxCnQDs++mMP9Af9nva9sJwOW5
         8O4x8JDPTVUcHAqfAqWuoBRBCfdhZkz5coGyyIy/j0S1rZa6aoAYOYChyy/1b+DLIq06
         a69aRH9t/Y51VAxIcHapqK9ZqGW6t5PhVqhcVt+TSOPuf3hgKkRgzYHD4LFgAb63kbq/
         3S2Q==
X-Gm-Message-State: APt69E0ncWmU5xUEmveuPEF3WAEPAxf5ViX4oePT2FyEZBZUK47ITiG5
        6BjUEOJlHzhYGY32wZiXUOe8/XWKKTc=
X-Google-Smtp-Source: ADUXVKLNxPoJhPE1H0Fj04bpc6XKcPsIVIpJKEWEfwNetHgNgFdUvL8n6tzBnjKWdikdtgzaMC/znw==
X-Received: by 2002:a17:902:59ce:: with SMTP id d14-v6mr10096062plj.253.1529241156443;
        Sun, 17 Jun 2018 06:12:36 -0700 (PDT)
Received: from localhost.localdomain ([101.23.151.28])
        by smtp.gmail.com with ESMTPSA id y11-v6sm17744746pfn.92.2018.06.17.06.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 06:12:35 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        andy@infradead.org, dvhart@infradead.org, hdegoede@redhat.com,
        youling257 <youling257@gmail.com>
Subject: [PATCH V2] platform/x86: touchscreen_dmi: Add info for ONDA V891W Dual OS
Date:   Sun, 17 Jun 2018 21:12:16 +0800
Message-Id: <20180617131216.6604-1-youling257@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

