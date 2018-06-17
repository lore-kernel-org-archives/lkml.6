Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B9BC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADFC20693
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhERpl7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADFC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933575AbeFQKhk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 06:37:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39855 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754046AbeFQKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 06:37:38 -0400
Received: by mail-pg0-f67.google.com with SMTP id w12-v6so6264114pgc.6;
        Sun, 17 Jun 2018 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uIEaj9XQK8DvpwRgk0phnfWl5LHQ3tyMcYPVSUwBtUg=;
        b=nhERpl7qep57secD9CBPSulcf4YEoteq43s0cU4k2g7rSWAwv9x7LjuAekIf3pRSlN
         +F6hUnRBKDd/csJt9ReaaFbGVFHpYlyq0xTPFcNbmbyyNnpiOLRGp1xCp5wguwnY4DH7
         vSXoBBP+QOAfhPkwj9XKos+03Vgz18tX3oXr+VF4MyswNWLIowMSncjPxOw0LDM8/d0H
         f3U9X9DuqqRlEXkTTeusQ+V5/lGLmpGZjLI8NUiKUryGCd+7/FVskFHVaGOpN9Ktwm7K
         xqojQxbjQ7wNFQSB2b8yMosqyPEkjhZbbPyoBZLujJWAdhsBK6IJ86vvAUMyMesRTXzr
         Ouvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uIEaj9XQK8DvpwRgk0phnfWl5LHQ3tyMcYPVSUwBtUg=;
        b=ieNtrmA0kckOG1hmkVWVP56GUZgZtJlDoyb240ZH+dXF+01LdDAYvYsRO/g1lzOsha
         SYKwXkvUWqm4kGJPmzi2t8FG7jJOvcbcUEhfPcY7lihCVguZjCVi2RSi5Wds3+TB8wSP
         BYoZd1Wt8n+Jbn7X60rWWjCYPczS1ZytSZsGKNmCqxz5ChkSQ1xgVA86AIDRQ6VPiwOE
         cnYvNTjoLqrXzkqbiSHC382JWqtMj1Y82NPAI6xAuiXVPIoqZep5T/hGQ4f8rR0lVBym
         MtAQN4KnsH/Q203EHOfz61y5nuhUd5uWb/VB2otmbeIsvyG2I+5QvoC9nwewtsvNEau4
         bVdw==
X-Gm-Message-State: APt69E2p5hQZALGoTOkgUTEqjjfoiXn+N2BPidPWtHm8IFcHidDanqMa
        OiiDtc1S4F0DOui8EjJYHI9qyV9Z8AeGuA==
X-Google-Smtp-Source: ADUXVKKbVoXD/BexOr8RcfywLXq0ykjD0g4m1Hq08bxJhMjxg287fW6Fv/eEyF1LLxJGgvyFiwnnkw==
X-Received: by 2002:a63:3348:: with SMTP id z69-v6mr7370042pgz.171.1529231857649;
        Sun, 17 Jun 2018 03:37:37 -0700 (PDT)
Received: from localhost.localdomain ([101.23.151.28])
        by smtp.gmail.com with ESMTPSA id r27-v6sm24736197pfg.94.2018.06.17.03.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 03:37:37 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        andy@infradead.org, dvhart@infradead.org, hdegoede@redhat.com,
        youling257 <youling257@gmail.com>
Subject: [PATCH v1] platform/x86: silead_dmi: Add touchscreen info for the Onda V891w V3 tablet
Date:   Sun, 17 Jun 2018 18:37:36 +0800
Message-Id: <20180617103736.1162-1-youling257@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: youling257 <youling257@gmail.com>
---
 drivers/platform/x86/silead_dmi.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index 853a7ce4601c..9e61182c8aff 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -326,6 +326,23 @@ static const struct silead_ts_dmi_data onda_v891w_v1_data = {
 	.properties	= onda_v891w_v1_props,
 };
 
+static const struct property_entry onda_v891w_v3_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 35),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 15),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1625),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1135),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "FW_I89_GSL3676B_19201200_.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct silead_ts_dmi_data onda_v891w_v3_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= onda_v891w_v3_props,
+};
+
 static const struct dmi_system_id silead_ts_dmi_table[] = {
 	{
 		/* CUBE iwork8 Air */
@@ -554,6 +571,24 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
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
+	{
+		/* ONDA V891w P891WBECV3A02121 32GB */
+		.driver_data = (void *)&onda_v891w_v3_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ONDA Tablet"),
+			DMI_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
+		},
+	},
 	{ },
 };
 
-- 
2.17.1

