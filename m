Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD31C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A81A2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeLRIGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:06:39 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:37581 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbeLRIGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:06:36 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id B3/C6-08814-98AA81C5; Tue, 18 Dec 2018 08:06:33 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRWlGSWpSXmKPExsVy8+3OTbqdqyR
  iDA61ClhMffiEzWL+kXOsFve/HmW0+Halg8ni8q45bBazl/SzWCy9fpHJonXvEXaL/Ve8HDg9
  1sxbw+jx7eskFo+ds+6ye2xa1cnmcefaHjaPz5vkAtiiWDPzkvIrElgz+lZPZyl4IFzRtbuft
  YHxgkAXIxeHkMBqRonHX3azQDhPGSVuzJ3D2sXICeRUSCxfPQ3MZhOwkti9ZjFQEQeHiICKxL
  k35iD1zAJTmCQ2zp7GAlIjLGAvsfviWmYQm0VAVWLtoy6wOK+Aj8TkGd/A5kgIyEncPNcJVsM
  p4CtxdPpBZohdPhL3Z0xmg6gXlDg58wlYL7OAhMTBFy+garQkrv47yA4xR0Fi6vuVUHacxNpD
  J9kgbE2JhmXbmCBse4np768yQ9iGEt9nfWOBsM0ljn+8DBW3kTj0txWq11Ti1Y/JTDD2hPnNL
  BMYJWYhOWkWkpMWMDKtYrRIKspMzyjJTczM0TU0MNA1NDTWNdI1MdFLrNJN1Est1U1OzSspSg
  RK6iWWF+sVV+Ym56To5aWWbGIExnlKIZPODsZPC9MPMUpyMCmJ8p5eLhEjxJeUn1KZkVicEV9
  UmpNafIhRhoNDSYJ3xkqgnGBRanpqRVpmDjDhwKQlOHiURHiVVwCleYsLEnOLM9MhUqcYFaXE
  ebeB9AmAJDJK8+DaYEnuEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3gCQ8TyZeSVw018BL
  WYCWpyzhQlkcUkiQkqqgdF28n3Vj5XTz75Yn2SXYnD/tr6omxbrr+u7jp0+d/V/cT/zh2c9fX
  ymLa9emHWV599vKhDUFjjj838jn+bVHVsVZTnrGFIW62x//cvjpy3vz9Kabzmcm+uu9p5bsUn
  +7+sC9irHhE8rvu1LMMh7dZ69RjtEJz1ISp3vJ6OXP6M+1+lFs7lPlSmxFGckGmoxFxUnAgCZ
  vwqybQMAAA==
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-24.tower-223.messagelabs.com!1545120392!2439111!3
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21190 invoked from network); 18 Dec 2018 08:06:33 -0000
Received: from unknown (HELO SVEX01005.wago.local) (217.237.185.178)
  by server-24.tower-223.messagelabs.com with AES128-SHA encrypted SMTP; 18 Dec 2018 08:06:33 -0000
Received: from SVEX01009.wago.local (10.1.103.227) by SVEX01005.wago.local
 (10.1.101.121) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 18 Dec
 2018 09:06:32 +0100
Received: from lc010965.wago.local (10.1.101.132) by SVEX01009.wago.local
 (10.1.103.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Tue, 18 Dec
 2018 09:06:31 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)        id
 9AA6F170069F; Tue, 18 Dec 2018 09:06:31 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Tony Lindgren" <tony@atomide.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 2/2] mfd: tps65218.c: Add input voltage options
Date:   Tue, 18 Dec 2018 09:05:56 +0100
Message-ID: <1545120356-7749-3-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.132]
X-ClientProxiedBy: SVEX01014.wago.local (10.1.103.232) To SVEX01009.wago.local
 (10.1.103.227)
X-KSE-ServerInfo: SVEX01009.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 18.12.2018 03:56:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 81a9f692-418a-4f33-bb70-032f75efc73b
X-PP-Proceessed: 8707ce24-8c4e-4a04-80f2-2a31f9152b06
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These options apply to all regulators in this chip.

strict-supply-voltage:
  Set STRICT flag in CONFIG1
under-voltage-limit:
  Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
under-voltage-hysteresis:
  Select 200mV or 400mV UVLOHYS in CONFIG2

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 drivers/mfd/tps65218.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 8bcdecf..f5e559b 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -211,6 +211,50 @@ static const struct of_device_id of_tps65218_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
 
+static void tps65218_options(struct tps65218 *tps)
+{
+	struct device *dev = tps->dev;
+	struct device_node *np = dev->of_node;
+	u32 pval;
+
+	if (!of_property_read_u32(np, "strict-supply-voltage", &pval)) {
+		tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
+			TPS65218_CONFIG1_STRICT,
+			pval ? TPS65218_CONFIG1_STRICT : 0,
+			TPS65218_PROTECT_L1);
+		dev_dbg(dev, "tps65218 strict-supply-voltage: %d\n", pval);
+	}
+	if (!of_property_read_u32(np, "under-voltage-hysteresis", &pval)) {
+		if (pval != 400000 && pval != 200000) {
+			dev_err(dev,
+				 "under-voltage-hysteresis must be %d or %d\n",
+				 200000, 400000);
+		} else {
+			tps65218_update_bits(tps, TPS65218_REG_CONFIG2,
+				TPS65218_CONFIG2_UVLOHYS,
+				pval == 400000 ? TPS65218_CONFIG2_UVLOHYS : 0,
+				TPS65218_PROTECT_L1);
+		}
+		dev_dbg(dev, "tps65218 under-voltage-hysteresis: %d\n", pval);
+	}
+	if (!of_property_read_u32(np, "under-voltage-limit", &pval)) {
+		int i, vals[] = { 275, 295, 325, 335 };
+
+		for (i = 0; i < ARRAY_SIZE(vals); i++) {
+			if (pval == vals[i] * 10000)
+				break;
+		}
+		if (i < ARRAY_SIZE(vals)) {
+			tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
+				TPS65218_CONFIG1_UVLO_MASK, i,
+				TPS65218_PROTECT_L1);
+		} else {
+			dev_err(dev, "Invalid under-voltage-limit: %d\n", pval);
+		}
+		dev_dbg(dev, "tps65218 under-voltage-limit: %d=%d\n", pval, i);
+	}
+}
+
 static int tps65218_probe(struct i2c_client *client,
 				const struct i2c_device_id *ids)
 {
@@ -249,6 +293,8 @@ static int tps65218_probe(struct i2c_client *client,
 
 	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
 
+	tps65218_options(tps);
+
 	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
 			      ARRAY_SIZE(tps65218_cells), NULL, 0,
 			      regmap_irq_get_domain(tps->irq_data));
-- 
2.7.4

