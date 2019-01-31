Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCBDC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E04218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klE/m9gS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbfAaKue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:50:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50462 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAaKud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:50:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so1988215wmd.0;
        Thu, 31 Jan 2019 02:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpOFQVTdPMzHuOrokx7Qka8a6O6m5/TkqZP0WYMyOK8=;
        b=klE/m9gSRY88VvHTOuG39Zy16lgijK9uBeUd31Yp8D4BdjRH9I+NfNOODBYDJWH1Pm
         wuMJaZ2scOqEe7CszcskzsgHBmV2GHNBvkTGGpfkiq5XzSmot/gg3q8+oUkMYeMdgOeR
         yzTY6mnulF2+39f7k32nmv8gZn+juH8EJ9j3gfhjWJuh7IO6SoGnpWdsKQJAjnHcIwuA
         Pjz137zzuYkbUcQWt/JKzXcWXsJEvVG9zs+13ETmGuCGJqdQgWU5Q6Y0nuEVEdF0Kz0d
         Sg3cNDJ3R8s78jjx3ftiecKl9NOuGLmq0nxASWed/mN1KtM4eXuAFozdDZS11ozRTOWu
         pjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpOFQVTdPMzHuOrokx7Qka8a6O6m5/TkqZP0WYMyOK8=;
        b=Y9Wd3fdzQuptTX0YgaC5n66dI8QnBqtLpPWH14CHTuo75GAKQdjlqt7FJp0n0LaMEa
         0VYsvAQf2puRS1mLPLHx5D/9E3SB27p1S15HEjG6K7X0RLfc3+xYFGWB9w77cTZl64er
         VCuvUHO+jBvWSojafE4DuYu+C3sBFETWLwyFG1ATuBOVNHiaUgfYUPFkM91J7+gfCD0N
         30qUfL4St9Dt/M2Yp02cnfe5Hn42sUUpqqp9deh1twDcHws5+lOTQ6qbrdMjadIAY24R
         9l9V/gIU6z9DDvr+DsbtpdzbbUyW+0xi+yXfq9kppfv50D+YytR7guzCz7HxPwFB8veO
         bnfQ==
X-Gm-Message-State: AJcUukdokuyyGeWGI2SJcdQTeaC1NFjlUp2Sd0EP6UNtxePSuAgAmj/j
        rS5IGCE3IJAZZ9NB2aQz5aQ=
X-Google-Smtp-Source: ALg8bN6LBRclS+qbpKTjlzoT8ZVXFWxDRNa5ep7Lj8dlARe8gub6LeS+ORmS+T5VBucEpgxleG3zYg==
X-Received: by 2002:a1c:9d57:: with SMTP id g84mr29524482wme.16.1548931830663;
        Thu, 31 Jan 2019 02:50:30 -0800 (PST)
Received: from localhost.localdomain (ip-37-201-6-149.hsi13.unitymediagroup.de. [37.201.6.149])
        by smtp.googlemail.com with ESMTPSA id k23sm3377232wmj.32.2019.01.31.02.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 02:50:30 -0800 (PST)
From:   Kai Renzig <k.renzig@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kai Renzig <k.renzig@gmail.com>
Subject: [PATCH] platform/x86: silead_dmi: Add touchscreen platform data for the Chuwi Hi8 Air tablet
Date:   Thu, 31 Jan 2019 11:49:07 +0100
Message-Id: <20190131104907.9649-1-k.renzig@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen platform data for the Chuwi Hi8 Air tablet.

Signed-off-by: Kai Renzig <k.renzig@gmail.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 8c5d47c0aea6..48e5d92040ab 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -41,6 +41,20 @@ static const struct ts_dmi_data chuwi_hi8_data = {
 	.properties     = chuwi_hi8_props,
 };
 
+static const struct property_entry chuwi_hi8_air_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-chuwi-hi8-air.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct ts_dmi_data chuwi_hi8_air_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= chuwi_hi8_air_props,
+};
+
 static const struct property_entry chuwi_hi8_pro_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 6),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
@@ -497,6 +511,15 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "H1D_S806_206"),
 		},
 	},
+	{
+		/* Chuwi Hi8 Air (CWI543) */
+		.driver_data = (void *)&chuwi_hi8_air_data,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Default string"),
+			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Hi8 Air"),
+		},
+	},
 	{
 		/* Chuwi Hi8 Pro (CWI513) */
 		.driver_data = (void *)&chuwi_hi8_pro_data,
-- 
2.19.1

