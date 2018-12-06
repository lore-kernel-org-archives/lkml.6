Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463DCC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033B0214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngK2u1pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033B0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeLFT0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:26:50 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40411 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeLFT0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:26:45 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so3314116ita.5;
        Thu, 06 Dec 2018 11:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1y/GHNFcb5pNtH6X5wwY4HJs0F+4ty2YJBVnm/r1T9c=;
        b=ngK2u1pwzxBZFetVBbNIVHdsqMTB6ZK3qRVaXb1nWG2rm8ayS+nvPW9GxrZf1VscHT
         AigJH6WSpGjNOEZkOxVWzpgVNoPkOouh/BnJs/BGYIPE4qBxNGHxn2aOTvRrr3GvFAxg
         HsDzXi3Kc0ymqHO42Sf977AHX5wPA+CpBHObhbRrBhBysZUYbkv8+Tz6CIXA83j7IHry
         Jz4IQjsYfD/3jxdQUz6AFV6wgQQPM18CGdD+GEuFGO1xMHZJNSDlHaWVp+YGrQPjtNvw
         I5j7uN6wl4/CX+T5M7n4GCwfVjgqk/CYTiL3dmWJZiuP5pM2Q+fyA/41JtG1DYmHrGeM
         MgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1y/GHNFcb5pNtH6X5wwY4HJs0F+4ty2YJBVnm/r1T9c=;
        b=RTxJ8aNtoaJs5qwNT0xhiwuip52bgXXjPNYk3J+WMsO4bynCAqDrchJoKsCTqc6s70
         LRQLOz56r4F9hToIDVjgsQJKhwIx/e6LOSYnyZAcfqTYOMwVMeDdZLO2JTk/qFw0/lJ2
         5aYlSsJUJbftHTmNPm+JaWonOpzyPEV4LfZlZ7CGmOfxjQDg2uGY5QvGO8tG++WIOBwb
         zCT/pMGCVWoVrAtnQlF+ZvDJ7apvDrTdr6QVrXd879QIHf4sGhVBO7eiqwFOi9+Envgf
         rBbwEAgVIM4R3Vf3oq91CEP6qE9cvJlp8qmUdwMsmBUessTL48uZvg4LGqUqRjyq3vEg
         tsHw==
X-Gm-Message-State: AA+aEWYaxGa+U7paMu9xUWn5oHbkLuJ4zKWsngMR3tsfUgiGHTdHGHCX
        /4PVv7VGxVqy3+fGy55f1iU/lKXs
X-Google-Smtp-Source: AFSGD/XpIWI0KhcdAFYFEX/y2RlARUYKJr1yGIRSFQY6MpQOO2cosySv+BBMzexHe6n/tqek8PrRqw==
X-Received: by 2002:a24:26c4:: with SMTP id v187mr13737124itv.54.1544124404151;
        Thu, 06 Dec 2018 11:26:44 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 195sm819524itm.2.2018.12.06.11.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:26:43 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] bus: imx-weim: guard against timing configuration conflicts
Date:   Thu,  6 Dec 2018 14:26:33 -0500
Message-Id: <20181206192633.25319-4-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181206192633.25319-1-TheSven73@googlemail.com>
References: <20181206192633.25319-1-TheSven73@googlemail.com>
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
 drivers/bus/imx-weim.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 5452d22d1bd8..dfe74b8c512a 100644
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
@@ -162,6 +188,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 	const struct imx_weim_devtype *devtype = of_id->data;
 	struct device_node *child;
 	int ret, have_child = 0;
+	struct cs_timing_state ts = {};
 
 	if (devtype == &imx50_weim_devtype) {
 		ret = imx_weim_gpr_setup(pdev);
@@ -170,7 +197,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 	}
 
 	for_each_available_child_of_node(pdev->dev.of_node, child) {
-		ret = weim_timing_setup(child, base, devtype);
+		ret = weim_timing_setup(&pdev->dev, child, base, devtype, &ts);
 		if (ret)
 			dev_warn(&pdev->dev, "%pOF set timing failed.\n",
 				child);
-- 
2.17.1

