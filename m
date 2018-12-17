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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCD5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C78C2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6WnmBUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbeLQPsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:48:13 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34230 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387794AbeLQPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:48:09 -0500
Received: by mail-io1-f68.google.com with SMTP id w21so10355105ioc.1;
        Mon, 17 Dec 2018 07:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZXWaJwC1A+WNGPeFi0U9PbUUrRl71zxhx1AMGSVMKlc=;
        b=r6WnmBUG0aDC2CDpcY0z7uhTBERCMGdnR1SWEQEHKoVsvCoBaullBGXwm3a9nEZPcN
         ek79+bdx5oF8GSY1rge8AeEe3TxWThQ4iZR9qYKBjdY7/vIgQsPOV7Xai2HeH4EjGVQr
         6M9dTecr9Ha1nwDuDryeLAQN5AqBBIqyCyp+L+TA6kLRFD14EhY88E8jA1Bhn+DXNFIL
         DkQPeQrrri9pkWM6LPfp7OyW4BWMENxlemnjChojcTsMeSKiTLzAyMwSvXHG6yH/sypw
         ho3MmgVfK90aps4E+fNY4liE5yNo7L2Uy7/LyYYNASoNXb1mbOtEkcA9b0kY1zwCA/Zd
         sZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZXWaJwC1A+WNGPeFi0U9PbUUrRl71zxhx1AMGSVMKlc=;
        b=ss9W25BXaWs8/l1CDds11yg1x2Hkto9e+6anDf8Ztmp4AfQ6NmsLKQ6kJVddYeXIWE
         q3rqxPoA0af/G/o4XoDoUUzFOeyKqd2mIw4aKJ0czxAqxUqEYi1gh89jBVgQ07xI+V7D
         ptoJDy5rW+FsBhP8N2Znz6kzEm/uTsPjgdihXyiROe2A+jUL+tiWUsL9y7EmJulzwzUc
         TmK91iIvSV40bmYr66hmqvokKmkPxnk98eTpg1RQqgPXHnofVGDpEUmaluV+mYCisPw9
         YYg45F5PsEl5/I0yy+WJp4n7ALu8SBnsQLolla2xwR6xleAD0xqHNf0i4d0gbch0YuDV
         FWPA==
X-Gm-Message-State: AA+aEWb1ojWWnv/JZ3yTpTqhzE7BZDWNnXH9sUCLrLafRIz9dUe1xZGd
        MGDDVrryw5jyvtmwQDGpsuw=
X-Google-Smtp-Source: AFSGD/XsKRCDo5QatwarDxG8fTqaP63Ds6Fr3M/4qsK87syqeNkfqQW9O2nnBDHNegX6M5QEh2eCJg==
X-Received: by 2002:a6b:1411:: with SMTP id 17mr11653316iou.252.1545061687925;
        Mon, 17 Dec 2018 07:48:07 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id y23sm18824174ita.1.2018.12.17.07.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 07:48:07 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/3] bus: imx-weim: guard against timing configuration conflicts
Date:   Mon, 17 Dec 2018 10:48:00 -0500
Message-Id: <20181217154800.7448-4-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181217154800.7448-1-TheSven73@googlemail.com>
References: <20181217154800.7448-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When specifying weim child devices, there is a risk that more than
one timing setting is specified for the same chip select.

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
 drivers/bus/imx-weim.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 1a0e0277a404..db74334ca5ef 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -46,8 +46,18 @@ static const struct imx_weim_devtype imx51_weim_devtype = {
 };
 
 #define MAX_CS_REGS_COUNT	6
+#define MAX_CS_COUNT		6
 #define OF_REG_SIZE		3
 
+struct cs_timing {
+	bool is_applied;
+	u32 regs[MAX_CS_REGS_COUNT];
+};
+
+struct cs_timing_state {
+	struct cs_timing cs[MAX_CS_COUNT];
+};
+
 static const struct of_device_id weim_id_table[] = {
 	/* i.MX1/21 */
 	{ .compatible = "fsl,imx1-weim", .data = &imx1_weim_devtype, },
@@ -112,15 +122,20 @@ static int __init imx_weim_gpr_setup(struct platform_device *pdev)
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
 	int i, ret;
 	int reg_idx, num_regs;
+	struct cs_timing *cst;
 
 	if (WARN_ON(devtype->cs_regs_count > MAX_CS_REGS_COUNT))
 		return -EINVAL;
+	if (WARN_ON(devtype->cs_count > MAX_CS_COUNT))
+		return -EINVAL;
 
 	ret = of_property_read_u32_array(np, "fsl,weim-cs-timing",
 					 value, devtype->cs_regs_count);
@@ -146,10 +161,23 @@ static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
 		if (cs_idx >= devtype->cs_count)
 			return -EINVAL;
 
+		/* prevent re-configuring a CS that's already been configured */
+		cst = &ts->cs[cs_idx];
+		if (cst->is_applied && memcmp(value, cst->regs,
+					devtype->cs_regs_count * sizeof(u32))) {
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
+				devtype->cs_regs_count * sizeof(u32));
+		}
 	}
 
 	return 0;
@@ -163,6 +191,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 	const struct imx_weim_devtype *devtype = of_id->data;
 	struct device_node *child;
 	int ret, have_child = 0;
+	struct cs_timing_state ts = {};
 
 	if (devtype == &imx50_weim_devtype) {
 		ret = imx_weim_gpr_setup(pdev);
@@ -171,7 +200,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 	}
 
 	for_each_available_child_of_node(pdev->dev.of_node, child) {
-		ret = weim_timing_setup(child, base, devtype);
+		ret = weim_timing_setup(&pdev->dev, child, base, devtype, &ts);
 		if (ret)
 			dev_warn(&pdev->dev, "%pOF set timing failed.\n",
 				child);
-- 
2.17.1

