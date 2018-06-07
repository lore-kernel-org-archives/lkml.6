Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id D9b7Em2XGVuYeAAAmS7hNA
	; Thu, 07 Jun 2018 20:37:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2D2DB6089E; Thu,  7 Jun 2018 20:37:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9889B6063F;
	Thu,  7 Jun 2018 20:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9889B6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeFGUg7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:36:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753229AbeFGUgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:36:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42C1AC12A1;
        Thu,  7 Jun 2018 20:36:21 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73A48100294F;
        Thu,  7 Jun 2018 20:36:20 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: silead_dmi: Rename trekstor entries
Date: Thu,  7 Jun 2018 22:36:15 +0200
Message-Id: <20180607203617.11240-2-hdegoede@redhat.com>
In-Reply-To: <20180607203617.11240-1-hdegoede@redhat.com>
References: <20180607203617.11240-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 20:36:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 20:36:21 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefix the entries for trekstor tablets with trekstor_ and drop the
detailed model version (still available as comment in the dmi table)
to keep things within 80 chars.

This is a preparation patch for sorting all the entries alphabetically.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/silead_dmi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
index 853a7ce4601c..1f0246e69967 100644
--- a/drivers/platform/x86/silead_dmi.c
+++ b/drivers/platform/x86/silead_dmi.c
@@ -81,7 +81,7 @@ static const struct silead_ts_dmi_data dexp_ursus_7w_data = {
 	.properties	= dexp_ursus_7w_props,
 };
 
-static const struct property_entry surftab_twin_10_1_st10432_8_props[] = {
+static const struct property_entry trekstor_surftab_twin_10_1_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1900),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
 	PROPERTY_ENTRY_U32("touchscreen-inverted-y", 1),
@@ -91,12 +91,12 @@ static const struct property_entry surftab_twin_10_1_st10432_8_props[] = {
 	{ }
 };
 
-static const struct silead_ts_dmi_data surftab_twin_10_1_st10432_8_data = {
+static const struct silead_ts_dmi_data trekstor_surftab_twin_10_1_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= surftab_twin_10_1_st10432_8_props,
+	.properties	= trekstor_surftab_twin_10_1_props,
 };
 
-static const struct property_entry surftab_wintron70_st70416_6_props[] = {
+static const struct property_entry trekstor_surftab_wintron70_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 884),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 632),
 	PROPERTY_ENTRY_STRING("firmware-name",
@@ -106,9 +106,9 @@ static const struct property_entry surftab_wintron70_st70416_6_props[] = {
 	{ }
 };
 
-static const struct silead_ts_dmi_data surftab_wintron70_st70416_6_data = {
+static const struct silead_ts_dmi_data trekstor_surftab_wintron70_data = {
 	.acpi_name	= "MSSL1680:00",
-	.properties	= surftab_wintron70_st70416_6_props,
+	.properties	= trekstor_surftab_wintron70_props,
 };
 
 static const struct property_entry gp_electronic_t701_props[] = {
@@ -366,7 +366,7 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 	},
 	{
 		/* TrekStor SurfTab twin 10.1 ST10432-8 */
-		.driver_data = (void *)&surftab_twin_10_1_st10432_8_data,
+		.driver_data = (void *)&trekstor_surftab_twin_10_1_data,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "TrekStor"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "SurfTab twin 10.1"),
@@ -374,7 +374,7 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 	},
 	{
 		/* Trekstor Surftab Wintron 7.0 ST70416-6 */
-		.driver_data = (void *)&surftab_wintron70_st70416_6_data,
+		.driver_data = (void *)&trekstor_surftab_wintron70_data,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "ST70416-6"),
@@ -384,7 +384,7 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 	},
 	{
 		/* Trekstor Surftab Wintron 7.0 ST70416-6, newer BIOS */
-		.driver_data = (void *)&surftab_wintron70_st70416_6_data,
+		.driver_data = (void *)&trekstor_surftab_wintron70_data,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "TrekStor"),
 			DMI_MATCH(DMI_PRODUCT_NAME,
@@ -395,7 +395,7 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 	},
 	{
 		/* Ployer Momo7w (same hardware as the Trekstor ST70416-6) */
-		.driver_data = (void *)&surftab_wintron70_st70416_6_data,
+		.driver_data = (void *)&trekstor_surftab_wintron70_data,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Shenzhen PLOYER"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "MOMO7W"),
@@ -528,7 +528,7 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
 	},
 	{
 		/* I.T.Works TW701 */
-		.driver_data = (void *)&surftab_wintron70_st70416_6_data,
+		.driver_data = (void *)&trekstor_surftab_wintron70_data,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "i71c"),
-- 
2.17.1
