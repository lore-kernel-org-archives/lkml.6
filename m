Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48767C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D9120878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D9120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLDJUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:20:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbeLDJUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:20:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB15A811D8;
        Tue,  4 Dec 2018 09:20:07 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB9125C25D;
        Tue,  4 Dec 2018 09:20:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for the Mediacom Flexbook Edge 11
Date:   Tue,  4 Dec 2018 10:20:04 +0100
Message-Id: <20181204092004.5033-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 04 Dec 2018 09:20:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DMI match for the Mediacom Flexbook Edge 11, this is the same hw
as the Trekstor Primebook C11, so we use the same settings.

Reported-by: rmbg <alexofrichardmilitiabg@hotmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 0faf3fd895e3..ac20797af9b1 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -686,6 +686,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "jumperx.T87.KFBNEEA"),
 		},
 	},
+	{
+		/* Mediacom Flexbook Edge 11 (same hw as TS Primebook C11) */
+		.driver_data = (void *)&trekstor_primebook_c11_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDIACOM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
+		},
+	},
 	{
 		/* Onda oBook 20 Plus */
 		.driver_data = (void *)&onda_obook_20_plus_data,
-- 
2.19.2

