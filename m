Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D15C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF66621904
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbeLTVVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:21:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbeLTVVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:21:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7718E13ABF4;
        Thu, 20 Dec 2018 21:21:53 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-196.ams2.redhat.com [10.36.116.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC371019633;
        Thu, 20 Dec 2018 21:21:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for the PoV Wintab P1006w (v1.0) tablet
Date:   Thu, 20 Dec 2018 22:21:50 +0100
Message-Id: <20181220212150.1427-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 20 Dec 2018 21:21:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the Point of View Wintab P1006w (v1.0) tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index ac20797af9b1..7936fd72c50a 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -432,6 +432,24 @@ static const struct ts_dmi_data pov_mobii_wintab_p800w_v21_data = {
 	.properties	= pov_mobii_wintab_p800w_v21_props,
 };
 
+static const struct property_entry pov_mobii_wintab_p1006w_v10_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1984),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1520),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl3692-pov-mobii-wintab-p1006w-v10.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data pov_mobii_wintab_p1006w_v10_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= pov_mobii_wintab_p1006w_v10_props,
+};
+
 static const struct property_entry teclast_x3_plus_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
@@ -778,6 +796,17 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_DATE, "08/22/2014"),
 		},
 	},
+	{
+		/* Point of View mobii wintab p1006w (v1.0) */
+		.driver_data = (void *)&pov_mobii_wintab_p1006w_v10_data,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
+			/* Note 105b is Foxcon's USB/PCI vendor id */
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "105B"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "0E57"),
+		},
+	},
 	{
 		/* Teclast X3 Plus */
 		.driver_data = (void *)&teclast_x3_plus_data,
-- 
2.20.1

