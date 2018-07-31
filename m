Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D620C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E932F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E932F208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbeGaMcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:32:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45353 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbeGaMcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:32:47 -0400
Received: from [123.118.208.192] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1fkSGy-0001T8-9l; Tue, 31 Jul 2018 10:53:01 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, aaron.ma@canonical.com
Subject: [PATCH] ACPI / EC: Use ec_no_wakeup on ThinkPad X1 Yoga 3rd
Date:   Tue, 31 Jul 2018 18:52:39 +0800
Message-Id: <20180731105239.22008-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like on X1C6, on X1Y3 EC interrupts constantly wake up system from
s2idle, the power consumption is extremely high.
So make ec_no_wakeup be true as default to keep system in s2idle mode
and reduce power consumption.

Power button works when ec_no_wakeup=true.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/acpi/ec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 917f77f4cb55..6291d5c77267 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2045,6 +2045,13 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Thinkpad X1 Carbon 6th"),
 		},
 	},
+	{
+		.ident = "ThinkPad X1 Yoga 3rd",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Yoga 3rd"),
+		},
+	},
 	{ },
 };
 
-- 
2.17.1

