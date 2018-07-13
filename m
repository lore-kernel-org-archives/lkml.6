Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2370ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7526720843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UPiDDMdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7526720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbeGMLR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:17:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37817 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbeGMLR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:17:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so9029400wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8N17TUv2hsESNkx+Cax5KPCXmGDz3bBQAuV4+ifEOls=;
        b=UPiDDMdwwisjWbFptcD7wMvpO4rpaX9GJpiXihlJa/leVosGuqvzxHECySKr1roFCA
         8yxKz5LigOqZAb7auOJplzz2t2s3wNajJXTsoFScY8XyoD0nOZr93Gc7+NhTkAhhidLM
         rcQ+Rcx2mdPslTKu05p9U4aonJMOVuRHDYGCsicAp8B4EhMtHDtI9iuEL+cU9Gjm9H/7
         cuOhXX5xgi+JRTosxC5rYYc4c4Dh38hz66dGZW07jgcLvIOmFo5BU4WiUN5BmHptF1Ld
         tPfWttP5IwMT/gVu8fUAsKtAEVkKJv15IEloHsob8CcpAoyzxH73CVqA55Xet6WC1AoE
         dgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8N17TUv2hsESNkx+Cax5KPCXmGDz3bBQAuV4+ifEOls=;
        b=DQ/L8b25QFvvasywsZAhcW50HgwtwqdFuNYKa3GZJpNzV8wJHl5sBScJYRDzOzCDZo
         ekwut/lA1+Wg3zud2rbdX0Tb/y8OpyycvMYn1SeekyVNOSf3WO0OZORVLI1WrfRXLI1t
         cRf7/KKh6lOaegM2yGHu/8xGkZnr5I8Rn12Ujwx2GGOkJSAlWsnijTIGNQe8Uzq1+0lR
         KCqdqGLbAgF7Jes7eZ2NWjNDmvxVQqDzyfgcHNmzJ1AgQa6PjTXOv5tkmeNbVRJ6L9Bq
         dqraoU1jA10MQRcClVJyGcagtALKl/sSR6PYRXk3s8RwDBv9ZEwUh8vPvjUH1nu4DFOU
         KE3w==
X-Gm-Message-State: AOUpUlG/rD0QET+Ql94HQXeIjKOHVpfwHkWRegB9/tERMlG8mGtUvFgN
        OfZIjrUZrVO7yguU/HlwmGel6g==
X-Google-Smtp-Source: AAOMgpfceD8wgllGeLora+iAMfI4WgNaZbkS083h7AN41AH07yVtf9OTL+kXCKDncba73+qgSkuPYg==
X-Received: by 2002:a1c:ed4:: with SMTP id 203-v6mr3771055wmo.96.1531479797060;
        Fri, 13 Jul 2018 04:03:17 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y14-v6sm4598045wrq.45.2018.07.13.04.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:03:16 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 3/9] ata: ahci_platform: add support for AHCI controller reset
Date:   Fri, 13 Jul 2018 11:03:00 +0000
Message-Id: <1531479786-4911-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC R40 AHCI controller need a reset to work.
So this patch add a way to add an optional reset on AHCI controller.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/ahci.h             |  2 ++
 drivers/ata/libahci_platform.c | 28 ++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 633d3ec5c1df..274c1885a5ad 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -40,6 +40,7 @@
 #include <linux/libata.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 
 /* Enclosure Management Control */
 #define EM_CTRL_MSG_TYPE              0x000f0000
@@ -352,6 +353,7 @@ struct ahci_host_priv {
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
 	struct regulator	*ahci_regulator;/* Optional */
+	struct reset_control	*ahci_reset;	/* Optional */
 	/*
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
 	 * the PHY position in this array.
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index d997a30ce793..1199ba411c15 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -207,7 +207,8 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
  * following order:
  * 1) Regulator
  * 2) Clocks (through ahci_platform_enable_clks)
- * 3) Phys
+ * 3) reset
+ * 4) Phys
  *
  * If resource enabling fails at any point the previous enabled resources
  * are disabled in reverse order.
@@ -227,12 +228,19 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 	if (rc)
 		goto disable_regulator;
 
-	rc = ahci_platform_enable_phys(hpriv);
+	rc = reset_control_assert(hpriv->ahci_reset);
 	if (rc)
 		goto disable_clks;
 
+	rc = ahci_platform_enable_phys(hpriv);
+	if (rc)
+		goto disable_reset;
+
 	return 0;
 
+disable_reset:
+	reset_control_deassert(hpriv->ahci_reset);
+
 disable_clks:
 	ahci_platform_disable_clks(hpriv);
 
@@ -250,13 +258,16 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_resources);
  * This function disables all ahci_platform managed resources in the
  * following order:
  * 1) Phys
- * 2) Clocks (through ahci_platform_disable_clks)
- * 3) Regulator
+ * 2) reset
+ * 3) Clocks (through ahci_platform_disable_clks)
+ * 4) Regulator
  */
 void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
 {
 	ahci_platform_disable_phys(hpriv);
 
+	reset_control_deassert(hpriv->ahci_reset);
+
 	ahci_platform_disable_clks(hpriv);
 
 	ahci_platform_disable_regulators(hpriv);
@@ -414,6 +425,15 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		hpriv->ahci_regulator = NULL;
 	}
 
+	hpriv->ahci_reset = devm_reset_control_get_optional(dev, "ahci");
+	if (IS_ERR(hpriv->ahci_reset)) {
+		rc = PTR_ERR(hpriv->ahci_reset);
+		if (rc == -EPROBE_DEFER)
+			goto err_out;
+		rc = 0;
+		hpriv->ahci_reset = NULL;
+	}
+
 	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
 
 	/*
-- 
2.16.4

