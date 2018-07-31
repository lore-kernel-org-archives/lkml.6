Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35D8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C329208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrmd1VdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C329208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbeGaLOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:14:35 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:47103 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbeGaLOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:14:35 -0400
Received: by mail-pl0-f43.google.com with SMTP id t17-v6so6887636ply.13;
        Tue, 31 Jul 2018 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m7lOQXW3KyJGkWo1MmPVwt7BcYYw5Y3h8uYDyaHxMh8=;
        b=lrmd1VdU1qlCy9YPdZOzU4k6mdtLfgDNaTwoyY86Xh7UNm8lMP00J1QXFLajRZPZQQ
         lO0bepSDycmy1JUB1Xan7jSzFrYc6oFpBZ3+0kwiAd11ONPkw5YSAMo/5jPasXWryMKQ
         NeUGSq0NON9SLtVs/LuiYXxNZmctnhC6JWaN3KyW5YDmjDOSTBCiimudvqu7MiobHkOZ
         zFy9XjyjkdNqERzyw7PR0zH1igOusyKXftWYVcwzqcHHsOPeNj3XvElJdE0wU0n5WcqX
         KJBmeRdksTxC+RdnxtY1kdg8e+FqUc5zqV0iiJ1Y8hXU0GbEncD5pMvnRTPZjRxdVrFJ
         YG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m7lOQXW3KyJGkWo1MmPVwt7BcYYw5Y3h8uYDyaHxMh8=;
        b=FSZ+itcDJCyMu/Bjwp9jbLdVqdGV4y8DCHs4eJVL2UsWeO3ylFoqneZxRo7kYKu7Ij
         uSXvXZk7Ag4Z9r+B6pwgm3gU6HZPC5e0dVbCrY3rKWSe0V/kF+kWTF1nAG+0LoIYmpiU
         7DpvWCA86kVZgTsBgNNaGTvyfGpDK1NAL6kLdIHokL+pTLJYxgw5dbf4+ireOrtNNsSZ
         otf+eSg3RCT87vAPW4eQd0rJOHnV36417MuQ/xgumiNjsx2a4omTF4pSdhkL3hm414ic
         ZF47Qjrf9FKp7T2AYDhJzGSh+U61ZCGu25MP1Pnt+fVMW6Kpee+9sKm6u7QYX+rVuUiX
         1z9A==
X-Gm-Message-State: AOUpUlFjqgMzl0p99hDoUBv43pKLwmJx4EWjDgkvUXeJyVXP/xWMQakk
        r8DqsGG7XKn+Vvj3IyMNxcJeqfiybcEHVA==
X-Google-Smtp-Source: AAOMgpf77D+LN+gbKpiWQFGtzThzQfyirCeFdFMu63fRruICMWVZld6FOYyw2TspEsSijvkHFmoWOA==
X-Received: by 2002:a17:902:8481:: with SMTP id c1-v6mr19615550plo.177.1533029707745;
        Tue, 31 Jul 2018 02:35:07 -0700 (PDT)
Received: from localhost.localdomain ([45.124.136.112])
        by smtp.gmail.com with ESMTPSA id n26-v6sm14925793pgv.78.2018.07.31.02.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 02:35:07 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        andy@infradead.org, dvhart@infradead.org, hdegoede@redhat.com,
        youling257 <youling257@gmail.com>
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for the Cube KNote i1101 tablet
Date:   Tue, 31 Jul 2018 17:32:56 +0800
Message-Id: <20180731093256.30533-1-youling257@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the Cube KNote i1101 tablet.

Reported-and-tested-by: lkongl <lkongl@163.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 85e425420da2..cb204f973491 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -117,6 +117,22 @@ static const struct ts_dmi_data cube_iwork8_air_data = {
 	.properties	= cube_iwork8_air_props,
 };
 
+static const struct property_entry cube_knote_i1101_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 20),
+	PROPERTY_ENTRY_U32("touchscreen-min-y",  22),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1961),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1513),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-cube-knote-i1101.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data cube_knote_i1101_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= cube_knote_i1101_props,
+};
+
 static const struct property_entry dexp_ursus_7w_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 890),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 630),
@@ -458,6 +474,16 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
 		},
 	},
+	{
+		/* Cube KNote i1101 */
+		.driver_data = (void *)&cube_knote_i1101_data,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_BOARD_NAME, "L1W6_I1101"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ALLDOCUBE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "i1101"),
+		},
+	},
 	{
 		/* DEXP Ursus 7W */
 		.driver_data = (void *)&dexp_ursus_7w_data,
-- 
2.18.0

