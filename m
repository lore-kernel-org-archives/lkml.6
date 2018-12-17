Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685BFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D902146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlaoE5Ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbeLQPsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:48:20 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50868 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeLQPsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:48:07 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so19220250iti.0;
        Mon, 17 Dec 2018 07:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9I/xPB4Y0cqV12qjFH+ohxJh1d3RR5ieESc8rLL9bh4=;
        b=DlaoE5AcE15BULt2jv+Zge8SWSW2X3Xe537noFwkIQpWb0msmABxRJZGDtBwxphAxn
         IGDBYO/Fi/yRYauL4tbgrWJkayKeLyNvsh8U90VhYlcaxBOFqbFS7AiI7FVU5XeLaRyY
         TjANnlbV59RiHeqZ+/bYeJbuUNyFE0JYMQWS/laJy5IhW35Iot7yPlqdrdhY34hPqQQ1
         uqpEM1T+RX3qjIs5VAkvZ05tMk9NfYxdA7WzBwVoTPj1A8/0FTU/yCjoguXBijt4RJ32
         QGONXfU5R+0uP10v9CO9iE7JUoLlNvdwdBJkJqTsEWTAvswMClyKaUmVseMRRdvkKrld
         MbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9I/xPB4Y0cqV12qjFH+ohxJh1d3RR5ieESc8rLL9bh4=;
        b=IczBG8rugGnnCV9NHRfcIvDOmcOSA1MNxkGXFPisEZGH/p1uESufvjHdcBwWz1bWm2
         PzDla9oa75QjxNvlBDw2Pig3DEufkVuu9JhcXeoX2X2CvbsjqJaPaBPYZdoUFodmcGYM
         asPFWMZSa0zD8/dNbr+TZ4El6zykrteAqx0T99lwLGanxU5J16EvnUOIiYvsqm/fDQx2
         +ZcZjkjgRo+HSbU9OSwZUZmz9OZ/+CLRLGwnuq95n/50Tl2t5D5TocJIJaRi9QzMGlWR
         sl0jv/G3XdLPHE1MZSHwADuFGB2lySC9bAMHdw5ahyGAl69odXwxLasDwt1y5PySbMjZ
         0m+Q==
X-Gm-Message-State: AA+aEWbXbndPha2LC0EutLHccNuxtKNv7ZRuZHAChng3ouJCyqaLDU9/
        tBoCambI2t8NEj8/yjuaE1s=
X-Google-Smtp-Source: AFSGD/WTI1gdCrXK9P9kO0d3KvXp7d7EjzFpNsN4BoVZn33jU5zxH9Chs3js7Z5Wwxov7w18EB8KPA==
X-Received: by 2002:a24:5493:: with SMTP id t141mr12748457ita.57.1545061686847;
        Mon, 17 Dec 2018 07:48:06 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id y23sm18824174ita.1.2018.12.17.07.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 07:48:06 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/3] bus: imx-weim: support multiple address ranges per child node
Date:   Mon, 17 Dec 2018 10:47:59 -0500
Message-Id: <20181217154800.7448-3-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181217154800.7448-1-TheSven73@googlemail.com>
References: <20181217154800.7448-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that timing values for the child node are applied to
all chip selects in the child's address ranges.

Note that this does not support multiple timing settings per
child; this can be added in the future if required.

Example:
&weim {
	acme@0 {
		compatible = "acme,whatever";
		reg = <0 0 0x100>, <0 0x400000 0x800>,
				<1 0x400000 0x800>;
		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
				0x00000000 0xa0000240 0x00000000>;
	};
};

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 drivers/bus/imx-weim.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index d84996a4528e..1a0e0277a404 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -46,6 +46,7 @@ static const struct imx_weim_devtype imx51_weim_devtype = {
 };
 
 #define MAX_CS_REGS_COUNT	6
+#define OF_REG_SIZE		3
 
 static const struct of_device_id weim_id_table[] = {
 	/* i.MX1/21 */
@@ -116,26 +117,40 @@ static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
 {
 	u32 cs_idx, value[MAX_CS_REGS_COUNT];
 	int i, ret;
+	int reg_idx, num_regs;
 
 	if (WARN_ON(devtype->cs_regs_count > MAX_CS_REGS_COUNT))
 		return -EINVAL;
 
-	/* get the CS index from this child node's "reg" property. */
-	ret = of_property_read_u32(np, "reg", &cs_idx);
+	ret = of_property_read_u32_array(np, "fsl,weim-cs-timing",
+					 value, devtype->cs_regs_count);
 	if (ret)
 		return ret;
 
-	if (cs_idx >= devtype->cs_count)
+	/*
+	 * the child node's "reg" property may contain multiple address ranges,
+	 * extract the chip select for each.
+	 */
+	num_regs = of_property_count_elems_of_size(np, "reg", OF_REG_SIZE);
+	if (num_regs < 0)
+		return num_regs;
+	if (!num_regs)
 		return -EINVAL;
+	for (reg_idx = 0; reg_idx < num_regs; reg_idx++) {
+		/* get the CS index from this child node's "reg" property. */
+		ret = of_property_read_u32_index(np, "reg",
+					reg_idx * OF_REG_SIZE, &cs_idx);
+		if (ret)
+			break;
 
-	ret = of_property_read_u32_array(np, "fsl,weim-cs-timing",
-					 value, devtype->cs_regs_count);
-	if (ret)
-		return ret;
+		if (cs_idx >= devtype->cs_count)
+			return -EINVAL;
 
-	/* set the timing for WEIM */
-	for (i = 0; i < devtype->cs_regs_count; i++)
-		writel(value[i], base + cs_idx * devtype->cs_stride + i * 4);
+		/* set the timing for WEIM */
+		for (i = 0; i < devtype->cs_regs_count; i++)
+			writel(value[i],
+				base + cs_idx * devtype->cs_stride + i * 4);
+	}
 
 	return 0;
 }
-- 
2.17.1

