Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED89ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1F620843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="o80Djutf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1F620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbeGMLRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:17:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33117 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:17:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so4244746wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FmKePY8cO2Z3BAl+6ruUNdCH+AeRm0CrHUVMa6DpYGY=;
        b=o80Djutf0GiwdjrCGE6+2U7Ek0QNYxax81Cd5yZ60zXBw2tNF+l3En4pNrBve+vAnu
         H1cjmEVWN/S7QK8Szk9ybus/dkALaOmdEgY3iSWNrSXiSIoXLdCQGNWAUdmrLRADHllo
         YW58rkRCdGPhK04K4D5qH4lYdrN5JUMbe7//wVqnaptjswGdKLWYZ5EqLgODmEh5jZj5
         Bwk66WLMk7pwpl52zNHn7i6/HmGCjgeS0NdEs6h6voJ492uiE69vlJ19mRe1gJnGj1yY
         WP46FybQHa7VS7AbIjKJ2Q0af4PUrKmmqK49vjcNtMxRzqNxE0r24ksQTmieYkH1AVLE
         58lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FmKePY8cO2Z3BAl+6ruUNdCH+AeRm0CrHUVMa6DpYGY=;
        b=MpYKXTwQZdQVG/2Da+uIl4Jx8h6rmq3s++E3a+oucK72L2n1DMurDDBfbNCI33wsst
         dx3SDXCIRrB3ffJpaXetIvGW1o2CKCJmIvUoDAup0gRnwgTnTblO3Qg4uD6G1ss3EThd
         Cw+loOFRcxcL/ssIHug9mzN3YaKBo8f3qAD27mnqhVSsCgv1+JuSHROJt6xZZRk3DN+n
         wRgNj0v6zhSk2ygs2pGSvR2Yskh7HJVtGza2m3gsk3ogq4RHhLo4nkzFarjhs7DGbBLT
         qKqqSWr6wG8M2I6k7LbvB3Wd81BcyLMAz9qKZHiljOdR3BTFv6iXlJd7oNPIg9Yz6ujq
         2hwQ==
X-Gm-Message-State: AOUpUlH5ZgXupB1kxx9EEE6JlTHslEESg/i8T/4YI2vD55I7L0YgEeVe
        BKTFAkIfW0hiF6bJoKcobHHCkQ==
X-Google-Smtp-Source: AAOMgpfSZrikfitDhPmgJUjjpozvPsPOMpR8HhDBAf3tkltcMaueTldnMwJbSJ7B1t2BQ8fU9IIxsA==
X-Received: by 2002:a1c:910f:: with SMTP id t15-v6mr3848854wmd.51.1531479799995;
        Fri, 13 Jul 2018 04:03:19 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y14-v6sm4598045wrq.45.2018.07.13.04.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:03:19 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 6/9] ata: ahci_platform: add support for port regulator
Date:   Fri, 13 Jul 2018 11:03:03 +0000
Message-Id: <1531479786-4911-7-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC R40 AHCI controller need a port regulator to work.
We cannot use the "target-supply" since it's not a target power regulator.
So this patch add a way to add an optional port regulator.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/ahci.h             |  1 +
 drivers/ata/libahci_platform.c | 47 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 274c1885a5ad..716fd679dd3e 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -352,6 +352,7 @@ struct ahci_host_priv {
 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
+	struct regulator	**port_regulators;/* Optional */
 	struct regulator	*ahci_regulator;/* Optional */
 	struct reset_control	*ahci_reset;	/* Optional */
 	/*
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 1199ba411c15..d7574b3e1f6a 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
  */
 int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 {
-	int rc, i;
+	int rc, i, j;
 
 	if (hpriv->ahci_regulator) {
 		rc = regulator_enable(hpriv->ahci_regulator);
@@ -164,9 +164,21 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 		if (rc)
 			goto disable_target_pwrs;
 	}
+	for (j = 0; j < hpriv->nports; j++) {
+		if (!hpriv->port_regulators[j])
+			continue;
+
+		rc = regulator_enable(hpriv->port_regulators[j]);
+		if (rc)
+			goto disable_port_regulators;
+	}
 
 	return 0;
 
+disable_port_regulators:
+	while (--j >= 0)
+		if (hpriv->port_regulators[j])
+			regulator_disable(hpriv->port_regulators[j]);
 disable_target_pwrs:
 	while (--i >= 0)
 		if (hpriv->target_pwrs[i])
@@ -190,9 +202,10 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 	int i;
 
 	for (i = 0; i < hpriv->nports; i++) {
-		if (!hpriv->target_pwrs[i])
-			continue;
-		regulator_disable(hpriv->target_pwrs[i]);
+		if (hpriv->target_pwrs[i])
+			regulator_disable(hpriv->target_pwrs[i]);
+		if (hpriv->port_regulators[i])
+			regulator_disable(hpriv->port_regulators[i]);
 	}
 
 	if (hpriv->ahci_regulator)
@@ -291,9 +304,12 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
 	 * SATA device itself. So we can't use devm for automatically
 	 * releasing them. We have to do it manually here.
 	 */
-	for (c = 0; c < hpriv->nports; c++)
+	for (c = 0; c < hpriv->nports; c++) {
 		if (hpriv->target_pwrs && hpriv->target_pwrs[c])
 			regulator_put(hpriv->target_pwrs[c]);
+		if (hpriv->port_regulators && hpriv->port_regulators[c])
+			regulator_put(hpriv->port_regulators[c]);
+	}
 }
 
 static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
@@ -338,6 +354,7 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
 				struct device *dev)
 {
 	struct regulator *target_pwr;
+	struct regulator *port_regulator;
 	int rc = 0;
 
 	target_pwr = regulator_get_optional(dev, "target");
@@ -346,6 +363,21 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
 		hpriv->target_pwrs[port] = target_pwr;
 	else
 		rc = PTR_ERR(target_pwr);
+	/* Only EPROBE_DEFER is important since it's an optional regulator */
+	if (rc != -EPROBE_DEFER)
+		rc = 0;
+	else
+		return rc;
+
+	port_regulator = regulator_get_optional(dev, "port");
+
+	if (!IS_ERR(port_regulator))
+		hpriv->port_regulators[port] = port_regulator;
+	else
+		rc = PTR_ERR(port_regulator);
+	/* Only EPROBE_DEFER is important since it's an optional regulator */
+	if (rc != -EPROBE_DEFER)
+		rc = 0;
 
 	return rc;
 }
@@ -454,6 +486,11 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		rc = -ENOMEM;
 		goto err_out;
 	}
+	hpriv->port_regulators = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->port_regulators), GFP_KERNEL);
+	if (!hpriv->port_regulators) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
 
 	if (child_nodes) {
 		for_each_child_of_node(dev->of_node, child) {
-- 
2.16.4

