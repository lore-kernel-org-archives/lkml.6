Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbeE3Knp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:43:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750904AbeE3Kno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:43:44 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        zy <574249312@qq.com>
Subject: [PATCH v2 1/3] platform/x86: silead_dmi: Add touchscreen info for the Jumper EZpad 6 Pro
Date: Wed, 30 May 2018 12:43:39 +0200
Message-Id: <20180530104341.30069-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the Jumper EZpad 6 Pro.

Cc: zy <574249312@qq.com>
Reported-and-tested-by: zy <574249312@qq.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/silead_dmi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index 452aacabaa8e..d7a67a53195f 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -53,6 +53,20 @@ static const struct silead_ts_dmi_data jumper_ezpad_mini3_data = {
 	.properties	= jumper_ezpad_mini3_props,
 };
 
+static const struct property_entry jumper_ezpad_6_pro_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-jumper-ezpad-6-pro.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct silead_ts_dmi_data jumper_ezpad_6_pro_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= jumper_ezpad_6_pro_props,
+};
+
 static const struct property_entry dexp_ursus_7w_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 890),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 630),
@@ -296,6 +310,17 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "jumperx.T87.KFBNEEA"),
 		},
 	},
+	{
+		/* Jumper EZpad 6 Pro */
+		.driver_data = (void *)&jumper_ezpad_6_pro_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Jumper"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EZpad"),
+			DMI_MATCH(DMI_BIOS_VERSION, "5.12"),
+			/* Above matches are too generic, add bios-date match */
+			DMI_MATCH(DMI_BIOS_DATE, "08/18/2017"),
+		},
+	},
 	{
 		/* DEXP Ursus 7W */
 		.driver_data = (void *)&dexp_ursus_7w_data,
-- 
2.17.0
