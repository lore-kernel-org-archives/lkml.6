Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6173BC43146
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C9023C61
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="m8Vr7s5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C9023C61
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934745AbeF1INl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:13:41 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49406 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934371AbeF1INg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:13:36 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id CB6715C0990;
        Thu, 28 Jun 2018 10:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530173615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fGpRj7bu1wHG7EhMVTjqZY8lfXwb38OmL43qWaQpm7o=;
        b=m8Vr7s5ukgvRLdfpJA0soX2sR6W93QGxwIT5xh23dkn26rTN/NTm5K6S4q8E3vgVps0Z+D
        OjlUYWRz1FNbXeULVSxchZMu9Xpm9oS9WG/P25CBkQb4YlNMQonfvzFHib+vE0jf8PPiga
        lLgOv3aJfEHNja8Y1JzNByno3zpZ3/g=
From:   Stefan Agner <stefan@agner.ch>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com,
        michael@amarulasolutions.com, rmk+kernel@armlinux.org.uk,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
Date:   Thu, 28 Jun 2018 10:13:29 +0200
Message-Id: <20180628081331.13051-2-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180628081331.13051-1-stefan@agner.ch>
References: <20180628081331.13051-1-stefan@agner.ch>
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[kernel];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field support_vsel is currently only used in the device tree
case. Get rid of it. No change in behavior.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-esdhc-imx.c          | 8 ++------
 include/linux/platform_data/mmc-esdhc-imx.h | 2 --
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6f444731754d..20a420b765b3 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1145,18 +1145,14 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 			     &boarddata->tuning_start_tap);
 
 	if (of_find_property(np, "no-1-8-v", NULL))
-		boarddata->support_vsel = false;
-	else
-		boarddata->support_vsel = true;
+		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line = 0;
 
 	mmc_of_parse_voltage(np, &host->ocr_mask);
 
-	/* sdr50 and sdr104 need work on 1.8v signal voltage */
-	if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
-	    !IS_ERR(imx_data->pins_default)) {
+	if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pins_default)) {
 		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
 						ESDHC_PINCTRL_STATE_100MHZ);
 		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index 7daa78a2f342..640dec8b5b0c 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -34,7 +34,6 @@ enum cd_types {
  * @cd_gpio:	gpio for card_detect interrupt
  * @wp_type:	type of write_protect method (see wp_types enum above)
  * @cd_type:	type of card_detect method (see cd_types enum above)
- * @support_vsel:  indicate it supports 1.8v switching
  */
 
 struct esdhc_platform_data {
@@ -43,7 +42,6 @@ struct esdhc_platform_data {
 	enum wp_types wp_type;
 	enum cd_types cd_type;
 	int max_bus_width;
-	bool support_vsel;
 	unsigned int delay_line;
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
 	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
-- 
2.18.0

