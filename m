Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECE3C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400E1218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZxISA8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfAYLZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:25:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33426 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfAYLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:25:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so4574924wmh.0;
        Fri, 25 Jan 2019 03:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGpF2IEBFq/BcOsKKLH+f+PsD7f218oogkPHqHMFg7w=;
        b=BZxISA8y5a+JpscJaygKikAzd1hyc0JUnnzegRpBa3t2vCftplYi+Akd4qP8CxiPdp
         az5LpPr7yJ+a/0NsP48rXRC0mS3+USSjllVZ6YSKtx4+RzFj1xmVEJTNuzVwVMIA86hZ
         VxXaIHXwtZpPYgkJikPuvr38W9x4UjIkqVGBowU71bI/DjWsFCBZE8jXx+nEoeyk8rtj
         +UTIInDPlyhNcmKmgQ+/h9J3csIGy/pmeu5QWIdfXjb+opNAfhmZxQJORXaq599egP7+
         z7ovdKic5gxbmx4UMNyECKBw3beTPVBbld0eSTIoGQ0c9hG6cIdQ8dlixxU2FVVs/6GE
         zgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGpF2IEBFq/BcOsKKLH+f+PsD7f218oogkPHqHMFg7w=;
        b=HDE560JvEwldB2Rfn4nsdQ2ScLsTas7QnxQ2KqNnxToDTMDl0CNqINdpQ+7FAjiMH7
         8JXItsLCakEPQjezFTqv68DwZB7rdgfGykZnwW3MmqBW5Amorom77VYgoLUjmWaKXyH/
         uuT/fDDM5kPa8ks6vxX5wt3/wuNA8AVk9Q0NqTnPW3BVWXalGetrQVN+u7YZrbXZ3vPc
         hKGD4P+TAKxoQ5G2dHHW6LRZZGD3wKjxPvY4p3if2WFsfbLh6zo2amOPNmnY9k5EmhHK
         3B5AkoWawC3udd2zIRig0K2eU98lCsStnFpsqT6LDPZYBSR61eBJvpnLHd8KjR0++u20
         v4wg==
X-Gm-Message-State: AJcUukfsrTybaLcXnVHumurrxh7ctijjPNxruSBv4JwBc04qD03ibdd0
        iGJQ/pL0nEiS8WG9rQtL+nlF0bk2gOs=
X-Google-Smtp-Source: ALg8bN4CFeV+ulgys9tgrzrOL5kVIulYpmvOG4GKk+P+X8ko+0gCHXl8YaKlyUmkPDVJGNl7KntW5g==
X-Received: by 2002:a1c:dd04:: with SMTP id u4mr6495206wmg.84.1548415532969;
        Fri, 25 Jan 2019 03:25:32 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id h17sm104181156wrt.59.2019.01.25.03.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:25:32 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] phy: tegra: xusb: Add support for power supplies
Date:   Fri, 25 Jan 2019 12:25:24 +0100
Message-Id: <20190125112525.10697-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125112525.10697-1-thierry.reding@gmail.com>
References: <20190125112525.10697-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Support enabling various supplies needed to provide power to the PLLs
and logic used to drive the USB, PCI and SATA pads.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/phy/tegra/xusb.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/phy/tegra/xusb.h |  5 +++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 57a2d08ef6da..e510629f4f1c 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -864,6 +864,7 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 	struct tegra_xusb_padctl *padctl;
 	const struct of_device_id *match;
 	struct resource *res;
+	unsigned int i;
 	int err;
 
 	/* for backwards compatibility with old device trees */
@@ -901,14 +902,38 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 		goto remove;
 	}
 
+	padctl->supplies = devm_kcalloc(&pdev->dev, padctl->soc->num_supplies,
+					sizeof(*padctl->supplies), GFP_KERNEL);
+	if (!padctl->supplies) {
+		err = -ENOMEM;
+		goto remove;
+	}
+
+	for (i = 0; i < padctl->soc->num_supplies; i++)
+		padctl->supplies[i].supply = padctl->soc->supply_names[i];
+
+	err = devm_regulator_bulk_get(&pdev->dev, padctl->soc->num_supplies,
+				      padctl->supplies);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to get regulators: %d\n", err);
+		goto remove;
+	}
+
 	err = reset_control_deassert(padctl->rst);
 	if (err < 0)
 		goto remove;
 
+	err = regulator_bulk_enable(padctl->soc->num_supplies,
+				    padctl->supplies);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to enable supplies: %d\n", err);
+		goto reset;
+	}
+
 	err = tegra_xusb_setup_pads(padctl);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to setup pads: %d\n", err);
-		goto reset;
+		goto power_down;
 	}
 
 	err = tegra_xusb_setup_ports(padctl);
@@ -921,6 +946,8 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 
 remove_pads:
 	tegra_xusb_remove_pads(padctl);
+power_down:
+	regulator_bulk_disable(padctl->soc->num_supplies, padctl->supplies);
 reset:
 	reset_control_assert(padctl->rst);
 remove:
@@ -936,6 +963,11 @@ static int tegra_xusb_padctl_remove(struct platform_device *pdev)
 	tegra_xusb_remove_ports(padctl);
 	tegra_xusb_remove_pads(padctl);
 
+	err = regulator_bulk_disable(padctl->soc->num_supplies,
+				     padctl->supplies);
+	if (err < 0)
+		dev_err(&pdev->dev, "failed to disable supplies: %d\n", err);
+
 	err = reset_control_assert(padctl->rst);
 	if (err < 0)
 		dev_err(&pdev->dev, "failed to assert reset: %d\n", err);
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index bb60fc09c752..5d5d22f6cb41 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -370,6 +370,9 @@ struct tegra_xusb_padctl_soc {
 	} ports;
 
 	const struct tegra_xusb_padctl_ops *ops;
+
+	const char * const *supply_names;
+	unsigned int num_supplies;
 };
 
 struct tegra_xusb_padctl {
@@ -393,6 +396,8 @@ struct tegra_xusb_padctl {
 	unsigned int enable;
 
 	struct clk *clk;
+
+	struct regulator_bulk_data *supplies;
 };
 
 static inline void padctl_writel(struct tegra_xusb_padctl *padctl, u32 value,
-- 
2.19.1

