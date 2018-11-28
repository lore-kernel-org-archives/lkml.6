Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5356E20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FJyqYHb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5356E20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeK1X7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:59:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60774 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeK1X7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tlR5O0+EUrQ0tG3awhsa1rRlV6CkcZu8pwJ+AnuzZdc=; b=FJyqYHb5IhHo
        bUzex7h79/fEIrtFEQsFIw6mVCXoIf1rYQ1LcM1kZvLFm6Y+UMB8wBim4zoFmMwTDEujTRoT/WVhy
        uge4AeZDeyuuCaOxoHjVn7tnZeO1AH3et57OI9ocZe2Ys2+6UyatWmYEhvzaAksXC6V1DmDfgEiUi
        MQkpI=;
Received: from 92.40.248.202.threembb.co.uk ([92.40.248.202] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRzPA-0005Gc-Kn; Wed, 28 Nov 2018 12:57:24 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C26FE440078; Wed, 28 Nov 2018 12:57:23 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, jsarha@ti.com, robh+dt@kernel.org,
        misael.lopez@ti.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: davinci-mcasp: Implement configurable dismod handling" to the asoc tree
In-Reply-To:  <20181116134141.17396-5-peter.ujfalusi@ti.com>
Message-Id: <20181128125723.C26FE440078@finisterre.ee.mobilebroadband>
Date:   Wed, 28 Nov 2018 12:57:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: davinci-mcasp: Implement configurable dismod handling

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From bc184549853133303cf08d1f19477f9c87ef39fb Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 16 Nov 2018 15:41:41 +0200
Subject: [PATCH] ASoC: davinci-mcasp: Implement configurable dismod handling

If the dismod is specified in the DT node, use the specified custom value
to configure the drive on state of the inactive TX slots.

If the dismod is not present or booted in legacy mode, the dismod is set
to low as it was the original behavior.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/platform_data/davinci_asp.h |  1 +
 sound/soc/davinci/davinci-mcasp.c         | 19 ++++++++++++++++++-
 sound/soc/davinci/davinci-mcasp.h         |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index 85ad68f9206a..7fe80f1c7e08 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -79,6 +79,7 @@ struct davinci_mcasp_pdata {
 	/* McASP specific fields */
 	int tdm_slots;
 	u8 op_mode;
+	u8 dismod;
 	u8 num_serializer;
 	u8 *serial_dir;
 	u8 version;
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 0f3911be1c8e..40d3a916fb74 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -85,6 +85,7 @@ struct davinci_mcasp {
 	u32	tdm_mask[2];
 	int	slot_width;
 	u8	op_mode;
+	u8	dismod;
 	u8	num_serializer;
 	u8	*serial_dir;
 	u8	version;
@@ -834,7 +835,7 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 		if (mcasp->serial_dir[i] == TX_MODE &&
 					tx_ser < max_active_serializers) {
 			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
-				       DISMOD_LOW, DISMOD_MASK);
+				       mcasp->dismod, DISMOD_MASK);
 			set_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 			tx_ser++;
 		} else if (mcasp->serial_dir[i] == RX_MODE &&
@@ -847,6 +848,8 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 		} else if (mcasp->serial_dir[i] == TX_MODE) {
 			/* Unused TX pins, clear PDIR  */
+			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
+				       mcasp->dismod, DISMOD_MASK);
 			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 		}
 	}
@@ -1709,6 +1712,7 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 
 	if (pdev->dev.platform_data) {
 		pdata = pdev->dev.platform_data;
+		pdata->dismod = DISMOD_LOW;
 		return pdata;
 	} else if (match) {
 		pdata = devm_kmemdup(&pdev->dev, match->data, sizeof(*pdata),
@@ -1798,6 +1802,18 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 	if (ret >= 0)
 		pdata->sram_size_capture = val;
 
+	ret = of_property_read_u32(np, "dismod", &val);
+	if (ret >= 0) {
+		if (val == 0 || val == 2 || val == 3) {
+			pdata->dismod = DISMOD_VAL(val);
+		} else {
+			dev_warn(&pdev->dev, "Invalid dismod value: %u\n", val);
+			pdata->dismod = DISMOD_LOW;
+		}
+	} else {
+		pdata->dismod = DISMOD_LOW;
+	}
+
 	return  pdata;
 
 nodata:
@@ -1973,6 +1989,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	mcasp->version = pdata->version;
 	mcasp->txnumevt = pdata->txnumevt;
 	mcasp->rxnumevt = pdata->rxnumevt;
+	mcasp->dismod = pdata->dismod;
 
 	mcasp->dev = &pdev->dev;
 
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index acb024ab6a9d..5e4060d8fe56 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -209,6 +209,7 @@
 #define DISMOD_3STATE	(0x0)
 #define DISMOD_LOW	(0x2 << 2)
 #define DISMOD_HIGH	(0x3 << 2)
+#define DISMOD_VAL(x)	((x) << 2)
 #define DISMOD_MASK	DISMOD_HIGH
 #define TXSTATE		BIT(4)
 #define RXSTATE		BIT(5)
-- 
2.19.1

