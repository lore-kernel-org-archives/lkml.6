Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30463C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE99D2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy/evIQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE99D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeLAESC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:18:02 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33728 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeLAESA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:18:00 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so2438398itk.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pkkhki6gOw8na4aLzcjKwCRPB4mHo2I09YZSWHEShAA=;
        b=Vy/evIQhFHTxXtmT1GrpIk+f15L2ffu7raGxmXLyznJ97xd7OTwSGnJAFFX+uRkwA4
         uwN1XdUCR2VZQXBNz8QRNsbml8zb/rDSo534jymsRbkgVE+FU4wwDS629OP3j8GuF8K3
         2Cklkw7iarnakGVEMiuZ4d0k8+FmT8mrbfNisiTsDezXx3F2IWi/SgoQZpB7exdlLlsD
         6BLrRp3kcwRV1eB5Fjp73Iz9GvB0om+aoVYRI44rHJp83603OPgidFms0SXbmmXIzAvm
         IiwM8udIKza60NT80MMyJU69X056tIIxVlSjk8hxI7lcFp0YcgFeFPLJIrGt6p4dM1Gy
         /lHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pkkhki6gOw8na4aLzcjKwCRPB4mHo2I09YZSWHEShAA=;
        b=LAgmHqlFtDw7PvvdiKGVPKNAD+Bvf0s2LUSaBgVeh9OwpN1wTotfujgNUJKxCAjYAt
         nKmUll2SHlPEfx7yaP+XS7BkWTUjpePP5iqtW3c3wwHzJVfYqP+pBOhfcJhjJckenrmd
         dp1gdBW07QO3864lCEJMH2lkA2/d6yZEMddFL5kY27wTM5lbBLPdpYZvZh9pN+dJywi+
         /NGdAH7x3SN+VnKOh5p0+aPGC0gmSAJhyT3reA3ESTdUIQAl6vwM6tkipuCSqFKDzAYy
         hrFmi5BHqDp+F4ao0nflqLITmmnhElRooQW/DU7nZVPYlZkEkADiwQ5gk6kbEkdr+/he
         lYFg==
X-Gm-Message-State: AA+aEWaTArGeLy+xS03LYWmZ+V3RxFqLiKoHN4SC+9f1AvaWBiO+3/p0
        osj1HenroHkce5UASUbEDeQ=
X-Google-Smtp-Source: AFSGD/VQMggFAhEpwbZ93hE177TGK5/CrwBSEO/MK9tOg9CiQLKBP0JEdWSeEvtfc8dSY/v2yKxBlw==
X-Received: by 2002:a02:8ca8:: with SMTP id f37mr6067381jak.80.1543597682784;
        Fri, 30 Nov 2018 09:08:02 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id u26sm2143387iob.31.2018.11.30.09.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:08:02 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] bus: imx-weim: guard against timing configuration conflicts
Date:   Fri, 30 Nov 2018 12:07:54 -0500
Message-Id: <20181130170754.346-3-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130170754.346-1-TheSven73@googlemail.com>
References: <20181130170754.346-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@googlemail.com>

When adding weim child devices, there is a risk that the developer will
(by mistake) specify more than one timing setting for the same chip select.

The driver cannot support such a configuration.

In case of conflict, this patch will print a warning to the log,
and will ignore the child node in question.

In this example, node acme@1 will be ignored, as it tries to modify
timing settings for CS0:

&weim {
	acme@0 {
		compatible = "acme,whatever";
		reg = <0 0 0x100>;
		fsl,weim-cs-timing = <something>;
	};
	acme@1 {
		compatible = "acme,whatnot";
		reg = <0 0x500 0x100>;
		fsl,weim-cs-timing = <something else>;
	};
};

However in this example, the driver will be happy:

&weim {
        acme@0 {
                compatible = "acme,whatever";
                reg = <0 0 0x100>;
                fsl,weim-cs-timing = <something>;
        };
        acme@1 {
                compatible = "acme,whatnot";
                reg = <0 0x500 0x100>;
                fsl,weim-cs-timing = <something>;
        };
};

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 drivers/bus/imx-weim.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 24f22285395d..114e503ec785 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -46,8 +46,18 @@ static const struct imx_weim_devtype imx51_weim_devtype = {
 };
 
 #define MAX_CS_REGS_COUNT	6
+#define MAX_CS_REGS		6
 #define OF_REG_SIZE		3
 
+struct cs_timing {
+	bool is_applied;
+	u32 regs[MAX_CS_REGS_COUNT];
+};
+
+struct cs_timing_state {
+	struct cs_timing cs[MAX_CS_REGS];
+};
+
 static const struct of_device_id weim_id_table[] = {
 	/* i.MX1/21 */
 	{ .compatible = "fsl,imx1-weim", .data = &imx1_weim_devtype, },
@@ -112,11 +122,14 @@ static int __init imx_weim_gpr_setup(struct platform_device *pdev)
 }
 
 /* Parse and set the timing for this device. */
-static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
-				    const struct imx_weim_devtype *devtype)
+static int __init weim_timing_setup(struct device *dev,
+				    struct device_node *np, void __iomem *base,
+				    const struct imx_weim_devtype *devtype,
+				    struct cs_timing_state *ts)
 {
 	u32 cs_idx, value[MAX_CS_REGS_COUNT];
 	int i, ret, reg_idx, num_regs;
+	struct cs_timing *cst;
 
 	if (WARN_ON(devtype->cs_regs_count > MAX_CS_REGS_COUNT))
 		return -EINVAL;
@@ -145,10 +158,23 @@ static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
 		if (cs_idx >= devtype->cs_count)
 			return -EINVAL;
 
+		/* prevent re-configuring a CS that's already been configured */
+		cst = &ts->cs[cs_idx];
+		if (cst->is_applied && memcmp(value, cst->regs,
+					devtype->cs_regs_count*sizeof(u32))) {
+			dev_err(dev, "fsl,weim-cs-timing conflict on %pOF", np);
+			return -EINVAL;
+		}
+
 		/* set the timing for WEIM */
 		for (i = 0; i < devtype->cs_regs_count; i++)
 			writel(value[i],
 				base + cs_idx * devtype->cs_stride + i * 4);
+		if (!cst->is_applied) {
+			cst->is_applied = true;
+			memcpy(cst->regs, value,
+				devtype->cs_regs_count*sizeof(u32));
+		}
 	}
 
 	return 0;
@@ -165,6 +191,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 	const struct imx_weim_devtype *devtype = of_id->data;
 	struct device_node *child;
 	int ret, have_child = 0;
+	struct cs_timing_state ts = {};
 
 	if (devtype == &imx50_weim_devtype) {
 		ret = imx_weim_gpr_setup(pdev);
@@ -179,7 +206,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 	}
 
 	for_each_available_child_of_node(pdev->dev.of_node, child) {
-		ret = weim_timing_setup(child, base, devtype);
+		ret = weim_timing_setup(&pdev->dev, child, base, devtype, &ts);
 		if (ret)
 			dev_warn(&pdev->dev, "%pOF set timing failed.\n",
 				child);
-- 
2.17.1

