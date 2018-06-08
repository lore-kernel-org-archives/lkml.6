Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HXO6CSH5GltYZgAAmS7hNA
	; Fri, 08 Jun 2018 21:46:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1776C607E4; Fri,  8 Jun 2018 21:46:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8BB34601B4;
	Fri,  8 Jun 2018 21:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BB34601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeFHVqG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:46:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752990AbeFHVqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:46:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59A54406E89B;
        Fri,  8 Jun 2018 21:46:04 +0000 (UTC)
Received: from dhcp-44-202.space.revspace.nl (ovpn-116-56.ams2.redhat.com [10.36.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC5061C70A;
        Fri,  8 Jun 2018 21:46:02 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] platform/x86: silead_dmi: Rename trekstor entries
Date: Fri,  8 Jun 2018 23:45:55 +0200
Message-Id: <20180608214558.30717-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 08 Jun 2018 21:46:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 08 Jun 2018 21:46:04 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
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
2.17.0
