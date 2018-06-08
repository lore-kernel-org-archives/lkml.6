Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IRXtB3PzGlvGQAAAmS7hNA
	; Fri, 08 Jun 2018 21:46:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7B540607E7; Fri,  8 Jun 2018 21:46:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E82EA601B4;
	Fri,  8 Jun 2018 21:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E82EA601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeFHVqK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:46:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753031AbeFHVqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:46:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50A69BB42F;
        Fri,  8 Jun 2018 21:46:06 +0000 (UTC)
Received: from dhcp-44-202.space.revspace.nl (ovpn-116-56.ams2.redhat.com [10.36.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B584B83B72;
        Fri,  8 Jun 2018 21:46:04 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] platform/x86: silead_dmi: Sort entries alphabetically
Date: Fri,  8 Jun 2018 23:45:56 +0200
Message-Id: <20180608214558.30717-2-hdegoede@redhat.com>
In-Reply-To: <20180608214558.30717-1-hdegoede@redhat.com>
References: <20180608214558.30717-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 08 Jun 2018 21:46:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 08 Jun 2018 21:46:06 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have so much entries now that it is good to bring some form of order
to them. This should also reduce conflicts when multiple patches make
changes at the same time (compared to tagging all new entries at the end).

Note this commit purely moves stuff around and adds 2 comments about
keeping the data and table alphabetically sorted. There are no functional
changes.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/silead_dmi.c | 507 +++++++++++++++---------------
 1 file changed, 255 insertions(+), 252 deletions(-)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index 1f0246e69967..e466e6d8226f 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -25,46 +25,63 @@ struct silead_ts_dmi_data {
 	const struct property_entry *properties;
 };
 
-static const struct property_entry cube_iwork8_air_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 900),
+/* NOTE: Please keep all entries sorted alphabetically */
+
+static const struct property_entry chuwi_hi8_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1665),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
-	PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-cube-iwork8-air.fw"),
-	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-chuwi-hi8.fw"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data cube_iwork8_air_data = {
-	.acpi_name	= "MSSL1680:00",
-	.properties	= cube_iwork8_air_props,
+static const struct silead_ts_dmi_data chuwi_hi8_data = {
+	.acpi_name      = "MSSL0001:00",
+	.properties     = chuwi_hi8_props,
 };
 
-static const struct property_entry jumper_ezpad_mini3_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1700),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
+static const struct property_entry chuwi_hi8_pro_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
-	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-jumper-ezpad-mini3.fw"),
-	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-chuwi-hi8-pro.fw"),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data jumper_ezpad_mini3_data = {
+static const struct silead_ts_dmi_data chuwi_hi8_pro_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= jumper_ezpad_mini3_props,
+	.properties	= chuwi_hi8_pro_props,
 };
 
-static const struct property_entry jumper_ezpad_6_pro_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
-	PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-jumper-ezpad-6-pro.fw"),
+static const struct property_entry chuwi_vi8_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1724),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-chuwi-vi8.fw"),
 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data jumper_ezpad_6_pro_data = {
+static const struct silead_ts_dmi_data chuwi_vi8_data = {
+	.acpi_name      = "MSSL1680:00",
+	.properties     = chuwi_vi8_props,
+};
+
+static const struct property_entry cube_iwork8_air_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 900),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-cube-iwork8-air.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct silead_ts_dmi_data cube_iwork8_air_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= jumper_ezpad_6_pro_props,
+	.properties	= cube_iwork8_air_props,
 };
 
 static const struct property_entry dexp_ursus_7w_props[] = {
@@ -81,34 +98,20 @@ static const struct silead_ts_dmi_data dexp_ursus_7w_data = {
 	.properties	= dexp_ursus_7w_props,
 };
 
-static const struct property_entry trekstor_surftab_twin_10_1_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1900),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
-	PROPERTY_ENTRY_U32("touchscreen-inverted-y", 1),
-	PROPERTY_ENTRY_STRING("firmware-name",
-			      "gsl3670-surftab-twin-10-1-st10432-8.fw"),
-	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
-	{ }
-};
-
-static const struct silead_ts_dmi_data trekstor_surftab_twin_10_1_data = {
-	.acpi_name	= "MSSL1680:00",
-	.properties	= trekstor_surftab_twin_10_1_props,
-};
-
-static const struct property_entry trekstor_surftab_wintron70_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 884),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 632),
+static const struct property_entry digma_citi_e200_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
 	PROPERTY_ENTRY_STRING("firmware-name",
-			      "gsl1686-surftab-wintron70-st70416-6.fw"),
+			      "gsl1686-digma_citi_e200.fw"),
 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data trekstor_surftab_wintron70_data = {
+static const struct silead_ts_dmi_data digma_citi_e200_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= trekstor_surftab_wintron70_props,
+	.properties	= digma_citi_e200_props,
 };
 
 static const struct property_entry gp_electronic_t701_props[] = {
@@ -126,157 +129,142 @@ static const struct silead_ts_dmi_data gp_electronic_t701_data = {
 	.properties	= gp_electronic_t701_props,
 };
 
-static const struct property_entry pipo_w2s_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 880),
-	PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
+static const struct property_entry itworks_tw891_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1600),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 890),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
-	PROPERTY_ENTRY_STRING("firmware-name",
-			      "gsl1680-pipo-w2s.fw"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-itworks-tw891.fw"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data pipo_w2s_data = {
+static const struct silead_ts_dmi_data itworks_tw891_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= pipo_w2s_props,
+	.properties	= itworks_tw891_props,
 };
 
-static const struct property_entry pov_mobii_wintab_p800w_v20_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-min-x", 32),
-	PROPERTY_ENTRY_U32("touchscreen-min-y", 16),
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1692),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1146),
-	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
-	PROPERTY_ENTRY_STRING("firmware-name",
-			      "gsl3680-pov-mobii-wintab-p800w-v20.fw"),
+static const struct property_entry jumper_ezpad_6_pro_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-jumper-ezpad-6-pro.fw"),
 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data pov_mobii_wintab_p800w_v20_data = {
+static const struct silead_ts_dmi_data jumper_ezpad_6_pro_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= pov_mobii_wintab_p800w_v20_props,
+	.properties	= jumper_ezpad_6_pro_props,
 };
 
-static const struct property_entry pov_mobii_wintab_p800w_v21_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1800),
+static const struct property_entry jumper_ezpad_mini3_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1700),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
-	PROPERTY_ENTRY_STRING("firmware-name",
-			      "gsl3692-pov-mobii-wintab-p800w.fw"),
-	PROPERTY_ENTRY_BOOL("silead,home-button"),
-	{ }
-};
-
-static const struct silead_ts_dmi_data pov_mobii_wintab_p800w_v21_data = {
-	.acpi_name	= "MSSL1680:00",
-	.properties	= pov_mobii_wintab_p800w_v21_props,
-};
-
-static const struct property_entry itworks_tw891_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1600),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 890),
-	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
-	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
-	PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-itworks-tw891.fw"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-jumper-ezpad-mini3.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	{ }
 };
 
-static const struct silead_ts_dmi_data itworks_tw891_data = {
+static const struct silead_ts_dmi_data jumper_ezpad_mini3_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= itworks_tw891_props,
+	.properties	= jumper_ezpad_mini3_props,
 };
 
-static const struct property_entry chuwi_hi8_pro_props[] = {
+static const struct property_entry onda_obook_20_plus_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
-	PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-chuwi-hi8-pro.fw"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-onda-obook-20-plus.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data chuwi_hi8_pro_data = {
+static const struct silead_ts_dmi_data onda_obook_20_plus_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= chuwi_hi8_pro_props,
+	.properties	= onda_obook_20_plus_props,
 };
 
-static const struct property_entry digma_citi_e200_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
-	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+static const struct property_entry onda_v891w_v1_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 46),
+	PROPERTY_ENTRY_U32("touchscreen-min-y",  8),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1676),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1130),
 	PROPERTY_ENTRY_STRING("firmware-name",
-			      "gsl1686-digma_citi_e200.fw"),
+			      "gsl3680-onda-v891w-v1.fw"),
 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data digma_citi_e200_data = {
+static const struct silead_ts_dmi_data onda_v891w_v1_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= digma_citi_e200_props,
+	.properties	= onda_v891w_v1_props,
 };
 
-static const struct property_entry onda_obook_20_plus_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
+static const struct property_entry pipo_w2s_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 880),
 	PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
-	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
-	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-onda-obook-20-plus.fw"),
-	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
-	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl1680-pipo-w2s.fw"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data onda_obook_20_plus_data = {
+static const struct silead_ts_dmi_data pipo_w2s_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= onda_obook_20_plus_props,
+	.properties	= pipo_w2s_props,
 };
 
-static const struct property_entry chuwi_hi8_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1665),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
+static const struct property_entry pov_mobii_wintab_p800w_v20_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 32),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 16),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1692),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1146),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl3680-pov-mobii-wintab-p800w-v20.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
-	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-chuwi-hi8.fw"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data chuwi_hi8_data = {
-	.acpi_name      = "MSSL0001:00",
-	.properties     = chuwi_hi8_props,
+static const struct silead_ts_dmi_data pov_mobii_wintab_p800w_v20_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= pov_mobii_wintab_p800w_v20_props,
 };
 
-static const struct property_entry chuwi_vi8_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1724),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
+static const struct property_entry pov_mobii_wintab_p800w_v21_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1800),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
-	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-chuwi-vi8.fw"),
-	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl3692-pov-mobii-wintab-p800w.fw"),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data chuwi_vi8_data = {
-	.acpi_name      = "MSSL1680:00",
-	.properties     = chuwi_vi8_props,
+static const struct silead_ts_dmi_data pov_mobii_wintab_p800w_v21_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= pov_mobii_wintab_p800w_v21_props,
 };
 
-static const struct property_entry trekstor_primebook_c13_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 2624),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1920),
-	PROPERTY_ENTRY_STRING("firmware-name",
-			      "gsl1680-trekstor-primebook-c13.fw"),
+static const struct property_entry teclast_x3_plus_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-teclast-x3-plus.fw"),
 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data trekstor_primebook_c13_data = {
+static const struct silead_ts_dmi_data teclast_x3_plus_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= trekstor_primebook_c13_props,
+	.properties	= teclast_x3_plus_props,
 };
 
 static const struct property_entry teclast_x98plus2_props[] = {
@@ -295,38 +283,87 @@ static const struct silead_ts_dmi_data teclast_x98plus2_data = {
 	.properties	= teclast_x98plus2_props,
 };
 
-static const struct property_entry teclast_x3_plus_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
-	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-teclast-x3-plus.fw"),
+static const struct property_entry trekstor_primebook_c13_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 2624),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1920),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl1680-trekstor-primebook-c13.fw"),
 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data teclast_x3_plus_data = {
+static const struct silead_ts_dmi_data trekstor_primebook_c13_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= teclast_x3_plus_props,
+	.properties	= trekstor_primebook_c13_props,
 };
 
-static const struct property_entry onda_v891w_v1_props[] = {
-	PROPERTY_ENTRY_U32("touchscreen-min-x", 46),
-	PROPERTY_ENTRY_U32("touchscreen-min-y",  8),
-	PROPERTY_ENTRY_U32("touchscreen-size-x", 1676),
-	PROPERTY_ENTRY_U32("touchscreen-size-y", 1130),
+static const struct property_entry trekstor_surftab_twin_10_1_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1900),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
+	PROPERTY_ENTRY_U32("touchscreen-inverted-y", 1),
 	PROPERTY_ENTRY_STRING("firmware-name",
-			      "gsl3680-onda-v891w-v1.fw"),
+			      "gsl3670-surftab-twin-10-1-st10432-8.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct silead_ts_dmi_data trekstor_surftab_twin_10_1_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= trekstor_surftab_twin_10_1_props,
+};
+
+static const struct property_entry trekstor_surftab_wintron70_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 884),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 632),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl1686-surftab-wintron70-st70416-6.fw"),
 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
 	PROPERTY_ENTRY_BOOL("silead,home-button"),
 	{ }
 };
 
-static const struct silead_ts_dmi_data onda_v891w_v1_data = {
+static const struct silead_ts_dmi_data trekstor_surftab_wintron70_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= onda_v891w_v1_props,
+	.properties	= trekstor_surftab_wintron70_props,
 };
 
+/* NOTE: Please keep this table sorted alphabetically */
 static const struct dmi_system_id silead_ts_dmi_table[] = {
+	{
+		/* Chuwi Hi8 */
+		.driver_data = (void *)&chuwi_hi8_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ilife"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S806"),
+		},
+	},
+	{
+		/* Chuwi Hi8 (H1D_S806_206) */
+		.driver_data = (void *)&chuwi_hi8_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
+			DMI_MATCH(DMI_BIOS_VERSION, "H1D_S806_206"),
+		},
+	},
+	{
+		/* Chuwi Hi8 Pro (CWI513) */
+		.driver_data = (void *)&chuwi_hi8_pro_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
+		},
+	},
+	{
+		/* Chuwi Vi8 (CWI506) */
+		.driver_data = (void *)&chuwi_vi8_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "i86"),
+			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI.D86JLBNR"),
+		},
+	},
 	{
 		/* CUBE iwork8 Air */
 		.driver_data = (void *)&cube_iwork8_air_data,
@@ -337,12 +374,46 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 		},
 	},
 	{
-		/* Jumper EZpad mini3 */
-		.driver_data = (void *)&jumper_ezpad_mini3_data,
+		/* DEXP Ursus 7W */
+		.driver_data = (void *)&dexp_ursus_7w_data,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
-			/* jumperx.T87.KFBNEEA02 with the version-nr dropped */
-			DMI_MATCH(DMI_BIOS_VERSION, "jumperx.T87.KFBNEEA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "7W"),
+		},
+	},
+	{
+		/* Digma Citi E200 */
+		.driver_data = (void *)&digma_citi_e200_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Digma"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CITI E200"),
+			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+		},
+	},
+	{
+		/* GP-electronic T701 */
+		.driver_data = (void *)&gp_electronic_t701_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T701"),
+			DMI_MATCH(DMI_BIOS_VERSION, "BYT70A.YNCHENG.WIN.007"),
+		},
+	},
+	{
+		/* I.T.Works TW701 (same hardware as the Trekstor ST70416-6) */
+		.driver_data = (void *)&trekstor_surftab_wintron70_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "i71c"),
+			DMI_MATCH(DMI_BIOS_VERSION, "itWORKS.G.WI71C.JGBMRB"),
+		},
+	},
+	{
+		/* I.T.Works TW891 */
+		.driver_data = (void *)&itworks_tw891_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TW891"),
 		},
 	},
 	{
@@ -357,40 +428,39 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 		},
 	},
 	{
-		/* DEXP Ursus 7W */
-		.driver_data = (void *)&dexp_ursus_7w_data,
+		/* Jumper EZpad mini3 */
+		.driver_data = (void *)&jumper_ezpad_mini3_data,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "7W"),
+			/* jumperx.T87.KFBNEEA02 with the version-nr dropped */
+			DMI_MATCH(DMI_BIOS_VERSION, "jumperx.T87.KFBNEEA"),
 		},
 	},
 	{
-		/* TrekStor SurfTab twin 10.1 ST10432-8 */
-		.driver_data = (void *)&trekstor_surftab_twin_10_1_data,
+		/* Onda oBook 20 Plus */
+		.driver_data = (void *)&onda_obook_20_plus_data,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TrekStor"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "SurfTab twin 10.1"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ONDA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OBOOK 20 PLUS"),
 		},
 	},
 	{
-		/* Trekstor Surftab Wintron 7.0 ST70416-6 */
-		.driver_data = (void *)&trekstor_surftab_wintron70_data,
+		/* ONDA V891w revision P891WBEBV1B00 aka v1 */
+		.driver_data = (void *)&onda_v891w_v1_data,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ST70416-6"),
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ONDA"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONDA Tablet"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V001"),
 			/* Exact match, different versions need different fw */
-			DMI_MATCH(DMI_BIOS_VERSION, "TREK.G.WI71C.JGBMRBA04"),
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
 		},
 	},
 	{
-		/* Trekstor Surftab Wintron 7.0 ST70416-6, newer BIOS */
-		.driver_data = (void *)&trekstor_surftab_wintron70_data,
+		/* Pipo W2S */
+		.driver_data = (void *)&pipo_w2s_data,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TrekStor"),
-			DMI_MATCH(DMI_PRODUCT_NAME,
-					     "SurfTab wintron 7.0 ST70416-6"),
-			/* Exact match, different versions need different fw */
-			DMI_MATCH(DMI_BIOS_VERSION, "TREK.G.WI71C.JGBMRBA05"),
+			DMI_MATCH(DMI_SYS_VENDOR, "PIPO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "W2S"),
 		},
 	},
 	{
@@ -403,23 +473,6 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "MOMO.G.WI71C.MABMRBA02"),
 		},
 	},
-	{
-		/* GP-electronic T701 */
-		.driver_data = (void *)&gp_electronic_t701_data,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "T701"),
-			DMI_MATCH(DMI_BIOS_VERSION, "BYT70A.YNCHENG.WIN.007"),
-		},
-	},
-	{
-		/* Pipo W2S */
-		.driver_data = (void *)&pipo_w2s_data,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "PIPO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "W2S"),
-		},
-	},
 	{
 		/* Point of View mobii wintab p800w (v2.0) */
 		.driver_data = (void *)&pov_mobii_wintab_p800w_v20_data,
@@ -443,62 +496,20 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 		},
 	},
 	{
-		/* I.T.Works TW891 */
-		.driver_data = (void *)&itworks_tw891_data,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TW891"),
-		},
-	},
-	{
-		/* Chuwi Hi8 Pro */
-		.driver_data = (void *)&chuwi_hi8_pro_data,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
-		},
-	},
-	{
-		/* Digma Citi E200 */
-		.driver_data = (void *)&digma_citi_e200_data,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Digma"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CITI E200"),
-			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
-		},
-	},
-	{
-		/* Onda oBook 20 Plus */
-		.driver_data = (void *)&onda_obook_20_plus_data,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ONDA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OBOOK 20 PLUS"),
-		},
-	},
-	{
-		/* Chuwi Hi8 */
-		.driver_data = (void *)&chuwi_hi8_data,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ilife"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "S806"),
-		},
-	},
-	{
-		/* Chuwi Hi8 (H1D_S806_206) */
-		.driver_data = (void *)&chuwi_hi8_data,
+		/* Teclast X3 Plus */
+		.driver_data = (void *)&teclast_x3_plus_data,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
-			DMI_MATCH(DMI_BIOS_VERSION, "H1D_S806_206"),
+			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X3 Plus"),
+			DMI_MATCH(DMI_BOARD_NAME, "X3 Plus"),
 		},
 	},
 	{
-		/* Chuwi Vi8 (CWI506) */
-		.driver_data = (void *)&chuwi_vi8_data,
+		/* Teclast X98 Plus II */
+		.driver_data = (void *)&teclast_x98plus2_data,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "i86"),
-			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI.D86JLBNR"),
+			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X98 Plus II"),
 		},
 	},
 	{
@@ -510,29 +521,32 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 		},
 	},
 	{
-		/* Teclast X98 Plus II */
-		.driver_data = (void *)&teclast_x98plus2_data,
+		/* TrekStor SurfTab twin 10.1 ST10432-8 */
+		.driver_data = (void *)&trekstor_surftab_twin_10_1_data,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X98 Plus II"),
+			DMI_MATCH(DMI_SYS_VENDOR, "TrekStor"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SurfTab twin 10.1"),
 		},
 	},
 	{
-		/* Teclast X3 Plus */
-		.driver_data = (void *)&teclast_x3_plus_data,
+		/* Trekstor Surftab Wintron 7.0 ST70416-6 */
+		.driver_data = (void *)&trekstor_surftab_wintron70_data,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X3 Plus"),
-			DMI_MATCH(DMI_BOARD_NAME, "X3 Plus"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ST70416-6"),
+			/* Exact match, different versions need different fw */
+			DMI_MATCH(DMI_BIOS_VERSION, "TREK.G.WI71C.JGBMRBA04"),
 		},
 	},
 	{
-		/* I.T.Works TW701 */
+		/* Trekstor Surftab Wintron 7.0 ST70416-6, newer BIOS */
 		.driver_data = (void *)&trekstor_surftab_wintron70_data,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "i71c"),
-			DMI_MATCH(DMI_BIOS_VERSION, "itWORKS.G.WI71C.JGBMRB"),
+			DMI_MATCH(DMI_SYS_VENDOR, "TrekStor"),
+			DMI_MATCH(DMI_PRODUCT_NAME,
+					     "SurfTab wintron 7.0 ST70416-6"),
+			/* Exact match, different versions need different fw */
+			DMI_MATCH(DMI_BIOS_VERSION, "TREK.G.WI71C.JGBMRBA05"),
 		},
 	},
 	{
@@ -543,17 +557,6 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Y8W81"),
 		},
 	},
-	{
-		/* ONDA V891w revision P891WBEBV1B00 aka v1 */
-		.driver_data = (void *)&onda_v891w_v1_data,
-		.matches = {
-			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ONDA"),
-			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONDA Tablet"),
-			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V001"),
-			/* Exact match, different versions need different fw */
-			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
-		},
-	},
 	{ },
 };
 
-- 
2.17.0
