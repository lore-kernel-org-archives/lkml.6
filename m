Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DC0ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F51208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HZRXHqQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F51208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeGMLR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:17:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41006 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbeGMLR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:17:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so18171113wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=06XgonBAUAzG/IWfHRvq4KPgrVcZhKwaTfH5JfBakzQ=;
        b=HZRXHqQWYMttiqcxJUM20p7C/ykU/cF1gDNpVKC6m8PUS2qcrfKI/UesStY+fLxkTX
         taSeqGEYyrRGur9j2n+uQaroTXnqkYaodRDdsiMUAl80qUNQqOK2vHmjV9g0rkJmk2Sf
         OFgiGgUkQkAA0VYfcf75u5WaSbu7Afzu+WY/PccC/FjBK7XHHx8i15hrdfiTzs2EowgV
         l+mDHIUg3xccnhDXntrXFy3t9utB9Jx7zu4gPvTwkIAcj9hMqlJlJiuN9LtJjflvKx3c
         czXEMeC98NpsUCDBOCOPEt9Fcv3W0LxpCgArTmq3M5AJLlya6QTo2qJEIrzI0q0VpOU0
         tGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=06XgonBAUAzG/IWfHRvq4KPgrVcZhKwaTfH5JfBakzQ=;
        b=eUJJug06H9SBXNqWX0xs6D3eyPfsBOQr9mZpEVyzSR1CSet57nAvMfQzSKDvuFpkK9
         i/FA+LgDTWXNsZ0uCoHqM9miMgHDF3eQKq3yp3UM/eAnVSUN+IWj8rRugkI1WN6bpSuc
         6b4bnTuXm7EblnRppTcpNjohO1StXukZYNkSfeZrBRCSMPBZwy2HJ6blVQHEHKiZdkVN
         McNnWl/LppjuxHR1LmdlWijV59nkP7C9nrv752+S7VFOQz/fcrDfwmE/H7yDe6HtSmrW
         dc1vvqwc0iQxFpBXgfFWjZMFwP5gsb5U0NpDrFPKgi0t2C20bJuYeRlOIIqWW62G3fqL
         9vWQ==
X-Gm-Message-State: AOUpUlGVaxg04I7QgqWYTu/YH0fOs0C6VLBoHy010GIck3tTt8vIwfEm
        e4t0yeBuzAbHtWSRIoRyROEA/Q==
X-Google-Smtp-Source: AAOMgpcGqQmNop83jtxfMZy3n6SOunUFLPBkCXTRkXcsml7F6MftHE4WN7gbulFF74DxM/l7ayGN5Q==
X-Received: by 2002:adf:c581:: with SMTP id m1-v6mr1035974wrg.253.1531479794918;
        Fri, 13 Jul 2018 04:03:14 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y14-v6sm4598045wrq.45.2018.07.13.04.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:03:14 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 1/9] ata: ahci_platform: add support for AHCI controller regulator
Date:   Fri, 13 Jul 2018 11:02:58 +0000
Message-Id: <1531479786-4911-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC R40 AHCI controller need a regulator to work.
So this patch add a way to add an optional regulator on AHCI controller.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/ahci.h             |  1 +
 drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 1609ebab4e23..633d3ec5c1df 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -351,6 +351,7 @@ struct ahci_host_priv {
 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
+	struct regulator	*ahci_regulator;/* Optional */
 	/*
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
 	 * the PHY position in this array.
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index fe8939e161ea..d997a30ce793 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -138,7 +138,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
  * ahci_platform_enable_regulators - Enable regulators
  * @hpriv: host private area to store config values
  *
- * This function enables all the regulators found in
+ * This function enables all the regulators found in controller and
  * hpriv->target_pwrs, if any.  If a regulator fails to be enabled, it
  * disables all the regulators already enabled in reverse order and
  * returns an error.
@@ -150,6 +150,12 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 {
 	int rc, i;
 
+	if (hpriv->ahci_regulator) {
+		rc = regulator_enable(hpriv->ahci_regulator);
+		if (rc)
+			return rc;
+	}
+
 	for (i = 0; i < hpriv->nports; i++) {
 		if (!hpriv->target_pwrs[i])
 			continue;
@@ -166,6 +172,8 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 		if (hpriv->target_pwrs[i])
 			regulator_disable(hpriv->target_pwrs[i]);
 
+	if (hpriv->ahci_regulator)
+		regulator_disable(hpriv->ahci_regulator);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_platform_enable_regulators);
@@ -174,7 +182,8 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_regulators);
  * ahci_platform_disable_regulators - Disable regulators
  * @hpriv: host private area to store config values
  *
- * This function disables all regulators found in hpriv->target_pwrs.
+ * This function disables all regulators found in hpriv->target_pwrs and
+ * AHCI controller.
  */
 void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 {
@@ -185,6 +194,9 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 			continue;
 		regulator_disable(hpriv->target_pwrs[i]);
 	}
+
+	if (hpriv->ahci_regulator)
+		regulator_disable(hpriv->ahci_regulator);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
 /**
@@ -336,6 +348,7 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
  *
  * 1) mmio registers (IORESOURCE_MEM 0, mandatory)
  * 2) regulator for controlling the targets power (optional)
+ *    regulator for controlling the AHCI controller (optional)
  * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
  *    or for non devicetree enabled platforms a single clock
  * 4) phys (optional)
@@ -391,6 +404,16 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		hpriv->clks[i] = clk;
 	}
 
+	hpriv->ahci_regulator = devm_regulator_get_optional(dev, "ahci");
+
+	if (IS_ERR(hpriv->ahci_regulator)) {
+		rc = PTR_ERR(hpriv->ahci_regulator);
+		if (rc == -EPROBE_DEFER)
+			goto err_out;
+		rc = 0;
+		hpriv->ahci_regulator = NULL;
+	}
+
 	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
 
 	/*
-- 
2.16.4

