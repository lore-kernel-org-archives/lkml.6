Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5CCC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCC721470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCC721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeJDT1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbeJDT1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:27:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 268FB3082129;
        Thu,  4 Oct 2018 12:34:48 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-47.ams2.redhat.com [10.36.117.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6D7C65903;
        Thu,  4 Oct 2018 12:34:46 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alicia Hormann <ahormann@gmx.net>
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for the Trekstor Primebook C11 convertible
Date:   Thu,  4 Oct 2018 14:34:45 +0200
Message-Id: <20181004123445.17497-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 04 Oct 2018 12:34:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the Trekstor Primebook C11 convertible.

Cc: Alicia Hormann <ahormann@gmx.net>
Suggested-by: Alicia Hormann <ahormann@gmx.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index f30337d68007..4e6fdc1fbfdf 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -421,6 +421,22 @@ static const struct ts_dmi_data teclast_x98plus2_data = {
 	.properties	= teclast_x98plus2_props,
 };
 
+static const struct property_entry trekstor_primebook_c11_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1970),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1530),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl1680-trekstor-primebook-c11.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data trekstor_primebook_c11_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= trekstor_primebook_c11_props,
+};
+
 static const struct property_entry trekstor_primebook_c13_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 2624),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1920),
@@ -706,6 +722,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "X98 Plus II"),
 		},
 	},
+	{
+		/* Trekstor Primebook C11 */
+		.driver_data = (void *)&trekstor_primebook_c11_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Primebook C11"),
+		},
+	},
 	{
 		/* Trekstor Primebook C13 */
 		.driver_data = (void *)&trekstor_primebook_c13_data,
-- 
2.19.0

