Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76571C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF7D2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF7D2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeH3Pw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:52:29 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:8647 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeH3Pw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:52:28 -0400
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="19080227"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Aug 2018 04:50:42 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Thu, 30 Aug 2018 04:50:41 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/6] power: reset: at91-poweroff: rename at91_shdwc_base member of struct shdwc
Date:   Thu, 30 Aug 2018 14:50:10 +0300
Message-ID: <1535629811-13403-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename at91_shdwc_base member of struct shdwc to shdwc_base. There is
already an "at91" string in at91_shdwc object.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 945b41b4086a..ad6e2796690a 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -71,7 +71,7 @@ struct shdwc_config {
 struct shdwc {
 	const struct shdwc_config *cfg;
 	struct clk *sclk;
-	void __iomem *at91_shdwc_base;
+	void __iomem *shdwc_base;
 	void __iomem *mpddrc_base;
 	void __iomem *pmc_base;
 };
@@ -92,7 +92,7 @@ static void __init at91_wakeup_status(struct platform_device *pdev)
 	u32 reg;
 	char *reason = "unknown";
 
-	reg = readl(shdw->at91_shdwc_base + AT91_SHDW_SR);
+	reg = readl(shdw->shdwc_base + AT91_SHDW_SR);
 
 	dev_dbg(&pdev->dev, "%s: status = %#x\n", __func__, reg);
 
@@ -138,7 +138,7 @@ static void at91_poweroff(void)
 		:
 		: "r" (at91_shdwc->mpddrc_base),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
-		  "r" (at91_shdwc->at91_shdwc_base),
+		  "r" (at91_shdwc->shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW),
 		  "r" (at91_shdwc->pmc_base)
 		: "r6");
@@ -222,10 +222,10 @@ static void at91_shdwc_dt_configure(struct platform_device *pdev)
 		mode |= SHDW_RTCWKEN(shdw->cfg);
 
 	dev_dbg(&pdev->dev, "%s: mode = %#x\n", __func__, mode);
-	writel(mode, shdw->at91_shdwc_base + AT91_SHDW_MR);
+	writel(mode, shdw->shdwc_base + AT91_SHDW_MR);
 
 	input = at91_shdwc_get_wakeup_input(pdev, np);
-	writel(input, shdw->at91_shdwc_base + AT91_SHDW_WUIR);
+	writel(input, shdw->shdwc_base + AT91_SHDW_WUIR);
 }
 
 static const struct shdwc_config sama5d2_shdwc_config = {
@@ -262,10 +262,10 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, at91_shdwc);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	at91_shdwc->at91_shdwc_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(at91_shdwc->at91_shdwc_base)) {
+	at91_shdwc->shdwc_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(at91_shdwc->shdwc_base)) {
 		dev_err(&pdev->dev, "Could not map reset controller address\n");
-		return PTR_ERR(at91_shdwc->at91_shdwc_base);
+		return PTR_ERR(at91_shdwc->shdwc_base);
 	}
 
 	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
@@ -341,8 +341,8 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
 		pm_power_off = NULL;
 
 	/* Reset values to disable wake-up features  */
-	writel(0, shdw->at91_shdwc_base + AT91_SHDW_MR);
-	writel(0, shdw->at91_shdwc_base + AT91_SHDW_WUIR);
+	writel(0, shdw->shdwc_base + AT91_SHDW_MR);
+	writel(0, shdw->shdwc_base + AT91_SHDW_WUIR);
 
 	if (shdw->mpddrc_base)
 		iounmap(shdw->mpddrc_base);
-- 
2.7.4

