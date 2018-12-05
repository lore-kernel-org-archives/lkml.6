Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A14C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C48520878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rixo+vtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C48520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeLEPTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:19:49 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54308 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeLEPTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:19:48 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB5FJj1R013242;
        Wed, 5 Dec 2018 09:19:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544023185;
        bh=z1nWhNHQgfUtwFJxgzO+epxyHRSr7YEr+iRwu0V9p9I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Rixo+vtxBvU6EelT0P2GCNKE87V9vEQx5Fa/iogc7csv8KEr7MjCvnm5tgkDARygM
         hb8/j8htesfuJORGWcbeZmXupWNBGX6v1BopFv/9bxrysDVMWcdbwCizFOHmNvzdk6
         Uw7LXiIrw4/PpBY/zDIQJoRC3e5KtrNe83xPsaj8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB5FJjFJ101314
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 09:19:45 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 5
 Dec 2018 09:19:44 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 5 Dec 2018 09:19:44 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5FJhSw020000;
        Wed, 5 Dec 2018 09:19:43 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.247])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5FJWnc025493;
        Wed, 5 Dec 2018 09:19:41 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <vigneshr@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <rogerq@ti.com>
Subject: [PATCH 3/3] usb: dwc3: keystone: Add support for ti,am654-dwc3
Date:   Wed, 5 Dec 2018 17:19:31 +0200
Message-ID: <1544023171-5796-4-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544023171-5796-1-git-send-email-rogerq@ti.com>
References: <1544023171-5796-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM654 SoC contains a DWC3 controller with TI specific
wrapper. Add support for that.

Unlike the Keystone 2 case, for AM654 We don't need to
process any IRQs for basic USB operation.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/Kconfig         |  6 +++---
 drivers/usb/dwc3/dwc3-keystone.c | 11 ++++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 1a0404f..a83a84f 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -86,11 +86,11 @@ config USB_DWC3_HAPS
 	  platform, please say 'Y' or 'M' here.
 
 config USB_DWC3_KEYSTONE
-	tristate "Texas Instruments Keystone2 Platforms"
-	depends on ARCH_KEYSTONE || COMPILE_TEST
+	tristate "Texas Instruments Keystone2/3 Platforms"
+	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	default USB_DWC3
 	help
-	  Support of USB2/3 functionality in TI Keystone2 platforms.
+	  Support of USB2/3 functionality in TI Keystone2/3 platforms.
 	  Say 'Y' or 'M' here if you have one such device
 
 config USB_DWC3_OF_SIMPLE
diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index 193a9a8..cbee5fb 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -106,6 +106,10 @@ static int kdwc3_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
+	/* IRQ processing not required currently for AM65 */
+	if (of_device_is_compatible(node, "ti,am654-dwc3"))
+		goto skip_irq;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "missing irq\n");
@@ -123,6 +127,7 @@ static int kdwc3_probe(struct platform_device *pdev)
 
 	kdwc3_enable_irqs(kdwc);
 
+skip_irq:
 	error = of_platform_populate(node, NULL, NULL, dev);
 	if (error) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");
@@ -152,8 +157,11 @@ static int kdwc3_remove_core(struct device *dev, void *c)
 static int kdwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+
+	if (!of_device_is_compatible(node, "ti,am654-dwc3"))
+		kdwc3_disable_irqs(kdwc);
 
-	kdwc3_disable_irqs(kdwc);
 	device_for_each_child(&pdev->dev, NULL, kdwc3_remove_core);
 	pm_runtime_put_sync(kdwc->dev);
 	pm_runtime_disable(kdwc->dev);
@@ -165,6 +173,7 @@ static int kdwc3_remove(struct platform_device *pdev)
 
 static const struct of_device_id kdwc3_of_match[] = {
 	{ .compatible = "ti,keystone-dwc3", },
+	{ .compatible = "ti,am654-dwc3" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, kdwc3_of_match);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

