Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeE3Knv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:43:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751637AbeE3Knq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:43:46 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] platform/x86: silead_dmi: Add touchscreen info for the Onda V891w tablet
Date: Wed, 30 May 2018 12:43:41 +0200
Message-Id: <20180530104341.30069-3-hdegoede@redhat.com>
In-Reply-To: <20180530104341.30069-1-hdegoede@redhat.com>
References: <20180530104341.30069-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the Onda V891w 8.9" windows tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Match on exact BIOS version there are a v1 and v3 of the hardware which
 use different digitizers which need different firmware / settings
---
 drivers/platform/x86/silead_dmi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index ca49deaa2336..64716b118c8e 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -309,6 +309,23 @@ static const struct silead_ts_dmi_data teclast_x3_plus_data = {
 	.properties	= teclast_x3_plus_props,
 };
 
+static const struct property_entry onda_v891w_v1_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 46),
+	PROPERTY_ENTRY_U32("touchscreen-min-y",  8),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1676),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1130),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl3680-onda-v891w-v1.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct silead_ts_dmi_data onda_v891w_v1_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= onda_v891w_v1_props,
+};
+
 static const struct dmi_system_id silead_ts_dmi_table[] = {
 	{
 		/* CUBE iwork8 Air */
@@ -517,6 +534,17 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Y8W81"),
 		},
 	},
+	{
+		/* ONDA V891w revision P891WBEBV1B00 aka v1 */
+		.driver_data = (void *)&onda_v891w_v1_data,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ONDA"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONDA Tablet"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V001"),
+			/* Exact match, different versions need different fw */
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
+		},
+	},
 	{ },
 };
 
-- 
2.17.0
