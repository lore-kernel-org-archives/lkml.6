Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933638AbeE2Luj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:50:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933410AbeE2Lu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:50:27 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: silead_dmi: Add touchscreen info for the Onda V891w tablet
Date: Tue, 29 May 2018 13:50:22 +0200
Message-Id: <20180529115022.12875-3-hdegoede@redhat.com>
In-Reply-To: <20180529115022.12875-1-hdegoede@redhat.com>
References: <20180529115022.12875-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the Onda V891w 8.9" windows tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/silead_dmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index ca49deaa2336..d8d40e981152 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -309,6 +309,23 @@ static const struct silead_ts_dmi_data teclast_x3_plus_data = {
 	.properties	= teclast_x3_plus_props,
 };
 
+static const struct property_entry onda_v891w_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 46),
+	PROPERTY_ENTRY_U32("touchscreen-min-y",  8),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1676),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1130),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl3680-onda-v891w.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct silead_ts_dmi_data onda_v891w_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= onda_v891w_props,
+};
+
 static const struct dmi_system_id silead_ts_dmi_table[] = {
 	{
 		/* CUBE iwork8 Air */
@@ -517,6 +534,15 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Y8W81"),
 		},
 	},
+	{
+		/* ONDA V891w */
+		.driver_data = (void *)&onda_v891w_data,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ONDA"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONDA Tablet"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V001"),
+		},
+	},
 	{ },
 };
 
-- 
2.17.0
