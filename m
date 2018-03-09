Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932223AbeCIOEE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:04:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751120AbeCIOEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:04:01 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: silead_dmi: Add entry for the Yours Y8W81 tablet
Date: Fri,  9 Mar 2018 15:03:58 +0100
Message-Id: <20180309140358.11432-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry with touchscreen info for the Yours Y8W81 8" tablet.

This tablet has the same case and mostly the same internals as the Chuwi
Vi8. Both seem to be from an ODM called inet-tek. Both are labelled:
"INET-I86M-REVxx" on the PCB, with the Chuwi Vi8 being REV03 (and having
an ALC5640 audio codec) and the Yours Y8W81 being REV21 (and having an
ALC5651 audio codec). The wifi, accelerometer and touchscreen are
identical on both.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/silead_dmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index 1091539fa230..452aacabaa8e 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -455,6 +455,14 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "itWORKS.G.WI71C.JGBMRB"),
 		},
 	},
+	{
+		/* Yours Y8W81, same case and touchscreen as Chuwi Vi8 */
+		.driver_data = (void *)&chuwi_vi8_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "YOURS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Y8W81"),
+		},
+	},
 	{ },
 };
 
-- 
2.14.3
