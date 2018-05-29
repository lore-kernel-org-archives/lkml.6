Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933365AbeE2Lug (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:50:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933385AbeE2Lu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:50:26 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: silead_dmi: Add info for the PoV mobii TAB-P800W (v2.0)
Date: Tue, 29 May 2018 13:50:21 +0200
Message-Id: <20180529115022.12875-2-hdegoede@redhat.com>
In-Reply-To: <20180529115022.12875-1-hdegoede@redhat.com>
References: <20180529115022.12875-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the necessary device-properties to make the touchscreen
on Point of View mobii TAB-P800W (v2.0) tablets work.

Note that we already have an entry for the Point of View mobii
TAB-P800W (v2.1), that version uses a different digitizer and different
firmware, so the v2.0 version needs its own entry.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/silead_dmi.c | 39 +++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index d7a67a53195f..ca49deaa2336 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -141,7 +141,25 @@ static const struct silead_ts_dmi_data pipo_w2s_data = {
 	.properties	= pipo_w2s_props,
 };
 
-static const struct property_entry pov_mobii_wintab_p800w_props[] = {
+static const struct property_entry pov_mobii_wintab_p800w_v20_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 32),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 16),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1692),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1146),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl3680-pov-mobii-wintab-p800w-v20.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct silead_ts_dmi_data pov_mobii_wintab_p800w_v20_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= pov_mobii_wintab_p800w_v20_props,
+};
+
+static const struct property_entry pov_mobii_wintab_p800w_v21_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1800),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
@@ -151,9 +169,9 @@ static const struct property_entry pov_mobii_wintab_p800w_props[] = {
 	{ }
 };
 
-static const struct silead_ts_dmi_data pov_mobii_wintab_p800w_data = {
+static const struct silead_ts_dmi_data pov_mobii_wintab_p800w_v21_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= pov_mobii_wintab_p800w_props,
+	.properties	= pov_mobii_wintab_p800w_v21_props,
 };
 
 static const struct property_entry itworks_tw891_props[] = {
@@ -386,8 +404,19 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 		},
 	},
 	{
-		/* Point of View mobii wintab p800w */
-		.driver_data = (void *)&pov_mobii_wintab_p800w_data,
+		/* Point of View mobii wintab p800w (v2.0) */
+		.driver_data = (void *)&pov_mobii_wintab_p800w_v20_data,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			DMI_MATCH(DMI_BIOS_VERSION, "3BAIR1014"),
+			/* Above matches are too generic, add bios-date match */
+			DMI_MATCH(DMI_BIOS_DATE, "10/24/2014"),
+		},
+	},
+	{
+		/* Point of View mobii wintab p800w (v2.1) */
+		.driver_data = (void *)&pov_mobii_wintab_p800w_v21_data,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
-- 
2.17.0
