Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC130C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADA92086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfANIQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:16:48 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:40653 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbfANIQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:16:46 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id 05/DB-12934-A654C3C5; Mon, 14 Jan 2019 08:16:42 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRWlGSWpSXmKPExsVy8+3OTbqZrjY
  xBieuWFhMffiEzWL+kXOsFqe2NzFZ3P96lNHi25UOJovLu+awWcxe0s9isfT6RSaL1r1H2C32
  X/Fy4PJYM28No8e3r5NYPHbOusvusWlVJ5vHnWt72DyO39jO5PF5k1wAexRrZl5SfkUCa8arG
  QvZC2bLVfyZ8IC9gfG+ZBcjJ4eQwGpGidvtiV2MXED2U0aJEy0PWSASFRKf1p5nB7HZBKwkdq
  9ZDBYXEZCTmPJ1OgtIA7PAViaJG38vsnUxcnAICzhJLH4ZBmKyCKhK/JlgAVLOK+ArsePZOzY
  QWwKo9ea5TmYQm1PAR+JB8xQ2iFXeEp+2P2aDqBeUODnzCdgqZgEJiYMvXjBD1GhJXP13kB1i
  joLEufXbmEBWSQjESSzdFw4R1pR4vuMpI4RtLzH9/VVmCNtQ4vusbywQtrnE7IYtUGNsJA79b
  YU6zVRixdzLzDD2hPnNLBMYJWYhuWgWkosWMDKtYrRIKspMzyjJTczM0TU0MNA1NDTWNdI1Md
  FLrNJN1Est1U1OzSspSgRK6iWWF+sVV+Ym56To5aWWbGIERn1KIZPODsZPC9MPMUpyMCmJ8n5
  2sokR4kvKT6nMSCzOiC8qzUktPsQow8GhJMFb5AKUEyxKTU+tSMvMAaYfmLQEB4+SCG88SJq3
  uCAxtzgzHSJ1ilFRSpz3G0hCACSRUZoH1wZLeZcYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqC
  fPOA5nCk5lXAjf9FdBiJqDFbG+sQRaXJCKkpBoYT2grXnyxW6pR3Xee+Ks9WW+qNpcd0Iictv
  aJzY0IjtdcHpr2/N9WTHzR8jXK/bEdo+Hkv28tor/sv65zX/ghF7vXL4tkWZ/pVnv2TZA9Faf
  Iw256j6f4tZnv9d7F+qtj/GdW/un41fzVPuTwq2SBwzN70mN45/gK83UzMx1r49sRzrSc9ZS7
  EktxRqKhFnNRcSIAChWHC3QDAAA=
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-37.tower-223.messagelabs.com!1547453801!105249!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24970 invoked from network); 14 Jan 2019 08:16:41 -0000
Received: from unknown (HELO SVEX01005.wago.local) (217.237.185.178)
  by server-37.tower-223.messagelabs.com with AES128-SHA encrypted SMTP; 14 Jan 2019 08:16:41 -0000
Received: from SVEX01012.wago.local (10.1.103.230) by SVEX01005.wago.local
 (10.1.101.121) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 14 Jan
 2019 09:16:40 +0100
Received: from lc010965.wago.local (10.1.101.138) by SVEX01012.wago.local
 (10.1.103.230) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Mon, 14 Jan
 2019 09:16:40 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)        id
 3A62617029E2; Mon, 14 Jan 2019 09:16:40 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Keerthy <j-keerthy@ti.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v3 2/2] mfd: tps65218.c: Add input voltage options
Date:   Mon, 14 Jan 2019 09:16:34 +0100
Message-ID: <1547453794-18770-3-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.138]
X-ClientProxiedBy: SVEX01009.wago.local (10.1.103.227) To SVEX01012.wago.local
 (10.1.103.230)
X-KSE-ServerInfo: SVEX01012.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 14.01.2019 03:24:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: deb34f4f-1670-42da-9b53-f8c7bceb0e0a
X-PP-Proceessed: 8707ce24-8c4e-4a04-80f2-2a31f9152b06
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These options apply to all regulators in this chip.

ti,strict-supply-voltage-supervision:
  Set STRICT flag in CONFIG1
ti,under-voltage-limit-microvolt:
  Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
ti,under-voltage-hyst-microvolt:
  Select 200mV or 400mV UVLOHYS in CONFIG2

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Tested-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/tps65218.c       | 89 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/tps65218.h |  4 ++
 2 files changed, 93 insertions(+)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 8bcdecf..a62ea4c 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -211,6 +211,83 @@ static const struct of_device_id of_tps65218_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
 
+static int tps65218_voltage_set_strict(struct tps65218 *tps)
+{
+	u32 strict;
+
+	if (of_property_read_u32(tps->dev->of_node,
+				 "ti,strict-supply-voltage-supervision",
+				 &strict))
+		return 0;
+
+	if (strict != 0 && strict != 1) {
+		dev_err(tps->dev,
+			"Invalid ti,strict-supply-voltage-supervision value\n");
+		return -EINVAL;
+	}
+
+	tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
+			     TPS65218_CONFIG1_STRICT,
+			     strict ? TPS65218_CONFIG1_STRICT : 0,
+			     TPS65218_PROTECT_L1);
+	return 0;
+}
+
+static int tps65218_voltage_set_uv_hyst(struct tps65218 *tps)
+{
+	u32 hyst;
+
+	if (of_property_read_u32(tps->dev->of_node,
+				 "ti,under-voltage-hyst-microvolt", &hyst))
+		return 0;
+
+	if (hyst != 400000 && hyst != 200000) {
+		dev_err(tps->dev,
+			"Invalid ti,under-voltage-hyst-microvolt value\n");
+		return -EINVAL;
+	}
+
+	tps65218_update_bits(tps, TPS65218_REG_CONFIG2,
+			     TPS65218_CONFIG2_UVLOHYS,
+			     hyst == 400000 ? TPS65218_CONFIG2_UVLOHYS : 0,
+			     TPS65218_PROTECT_L1);
+	return 0;
+}
+
+static int tps65218_voltage_set_uvlo(struct tps65218 *tps)
+{
+	u32 uvlo;
+	int uvloval;
+
+	if (of_property_read_u32(tps->dev->of_node,
+				 "ti,under-voltage-limit-microvolt", &uvlo))
+		return 0;
+
+	switch (uvlo) {
+	case 2750000:
+		uvloval = TPS65218_CONFIG1_UVLO_2750000;
+		break;
+	case 2950000:
+		uvloval = TPS65218_CONFIG1_UVLO_2950000;
+		break;
+	case 3250000:
+		uvloval = TPS65218_CONFIG1_UVLO_3250000;
+		break;
+	case 3350000:
+		uvloval = TPS65218_CONFIG1_UVLO_3350000;
+		break;
+	default:
+		dev_err(tps->dev,
+			"Invalid ti,under-voltage-limit-microvolt value\n");
+		return -EINVAL;
+	}
+
+	tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
+			     TPS65218_CONFIG1_UVLO_MASK, uvloval,
+			     TPS65218_PROTECT_L1);
+	return 0;
+}
+
 static int tps65218_probe(struct i2c_client *client,
 				const struct i2c_device_id *ids)
 {
@@ -249,6 +326,18 @@ static int tps65218_probe(struct i2c_client *client,
 
 	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
 
+	ret = tps65218_voltage_set_strict(tps);
+	if (ret)
+		return ret;
+
+	ret = tps65218_voltage_set_uvlo(tps);
+	if (ret)
+		return ret;
+
+	ret = tps65218_voltage_set_uv_hyst(tps);
+	if (ret)
+		return ret;
+
 	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
 			      ARRAY_SIZE(tps65218_cells), NULL, 0,
 			      regmap_irq_get_domain(tps->irq_data));
diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index c204d9a..3cbe103 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -137,6 +137,10 @@
 #define TPS65218_CONFIG1_PGDLY_MASK	0x18
 #define TPS65218_CONFIG1_STRICT		BIT(2)
 #define TPS65218_CONFIG1_UVLO_MASK	0x3
+#define TPS65218_CONFIG1_UVLO_2750000	0x0
+#define TPS65218_CONFIG1_UVLO_2950000	0x1
+#define TPS65218_CONFIG1_UVLO_3250000	0x2
+#define TPS65218_CONFIG1_UVLO_3350000	0x3
 
 #define TPS65218_CONFIG2_DC12_RST	BIT(7)
 #define TPS65218_CONFIG2_UVLOHYS	BIT(6)
-- 
2.7.4

