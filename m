Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C9CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC2220779
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AcH9uUzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC2220779
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933199AbeGJGwb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:52:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44650 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932998AbeGJGwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:52:17 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6A6p7MN081006;
        Tue, 10 Jul 2018 01:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531205467;
        bh=WIbMvyfAXMYiYG7gTHdGijHurlc8TqwJKYs7wZxMqJo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AcH9uUzyy9u7VV/hhgRN5POwuM3RFB8sm6kCbiIPUvD0I61fE2RdJkM/O4GATIs4X
         9DLzpwPVGoC1Vs0YgWQCJcX8bAwp5EfwQmBQ+uQ/8esXFuVOrSlF0ER80Hh3n5u6Fk
         ZeIBwRZdZJUH+9XFp7Cd569lbZdQs//S0660bqRU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6A6p7fd014997;
        Tue, 10 Jul 2018 01:51:07 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 01:51:07 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 01:51:07 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6A6ouGV000378;
        Tue, 10 Jul 2018 01:51:05 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <t-kristo@ti.com>, <j-keerthy@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>
Subject: [PATCH v3 3/4] rtc: omap: use of_device_is_system_power_controller function
Date:   Tue, 10 Jul 2018 12:20:51 +0530
Message-ID: <1531205452-6086-4-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531205452-6086-1-git-send-email-j-keerthy@ti.com>
References: <1531205452-6086-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_is_system_power_controller instead of manually reading
the system-power-controller property from the device tree node.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/rtc-omap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index af46140..75a12eb 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -754,8 +754,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (of_id) {
 		rtc->type = of_id->data;
 		rtc->is_pmic_controller = rtc->type->has_pmic_mode &&
-				of_property_read_bool(pdev->dev.of_node,
-						"system-power-controller");
+			of_device_is_system_power_controller(pdev->dev.of_node);
 	} else {
 		id_entry = platform_get_device_id(pdev);
 		rtc->type = (void *)id_entry->driver_data;
-- 
1.9.1

