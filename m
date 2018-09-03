Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F212EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4FA20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASc6T1XR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4FA20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeICOVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40696 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeICOVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id 207-v6so515685wme.5;
        Mon, 03 Sep 2018 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9LXnz2fUikvXtzGPguMQqVne60eSM6Bi3/wfM9ERA6c=;
        b=ASc6T1XRSP/kNEywFxw90OG1YnpHJ4VQZ+PqmR+SWLpIB9Wh7pYhzG+vAE0G+Ebi1E
         O5QFT4TH9NSfb3jjSv/9OSYhX+jnrslrUWNL53S/hupKMjmjeMhpkRiT+NOv0g8lW8ph
         1i32SWXceUoP9UE1h/LfZ2HzgstomtNjVbMZ1EDd5MZGWa3Xg8/jwK2/yaD4EGQfyjMZ
         90gwkayHWTrzAnglB96xpKyFTX/JpaKlRU3DCa9mRuesMayYa0Gr3hT6TnNluM26PzCy
         XFY+IozKXf/TTz32pTRbCaF4UUR7w15OV6yp+E2G8VXuJbqvrnlntVgD76CNEgTbh151
         dBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9LXnz2fUikvXtzGPguMQqVne60eSM6Bi3/wfM9ERA6c=;
        b=mlPVooPOSBVaSN/lkM7+T8vGZI7UAWdlOu95E1ozf9yVr3pjkElQc7SQDoSVQKuqF3
         r38OLS2lPByICHn76GDUN0RchzYNvlIxnmtHNYwj/y3GzwKpC/Qitn++KWQWRtv/mR1P
         VA2akB/H48czRvoZdR6hy53re07Ou02V7XZamwQG21pSUZEKfrx39XtF5pD4M2Hkexhn
         ukjWBgaJLW84ZW2lsRMoJtHskkoi5H/jjRNyYKgv7+7SYJ90Yzvog38Lg94TCaO9Pqgs
         EegSbdqmleh6HoRYpG+/qrn10kxi86IihDQH3FKO49LHOr4tKBirZity8LG4cKpWopGv
         QOZg==
X-Gm-Message-State: APzg51D9KOtm6/4STyYRGu8MuQSJKJqnwYTmNQvf0+B14ofBhg6EUjQS
        VjBEIb0mFU8bvfuVmsOq/vM=
X-Google-Smtp-Source: ANB0VdZI120x0VHUXWNAWmRFu+EcW5fHDIy9v8o9znsWpScJc35G4xbJN0WpuA+55izJLaYmVUDo5Q==
X-Received: by 2002:a1c:32c4:: with SMTP id y187-v6mr4447461wmy.31.1535968931627;
        Mon, 03 Sep 2018 03:02:11 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm31773936wre.18.2018.09.03.03.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 03:02:10 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v5 4/9] ata: ahci_platform: add support for PHY controller regulator
Date:   Mon,  3 Sep 2018 12:01:56 +0200
Message-Id: <20180903100201.23131-5-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC R40 AHCI controller need a PHY regulator to work.
But since the PHY is embedded in the controller, we cannot do a DT node for it,
since phy-supply works only in node with a PHY compatible.
So this patch adds a way to add an optional phy-supply regulator on AHCI controller node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/ata/ahci.h             |  1 +
 drivers/ata/libahci_platform.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 1415f1012de5..ef356e70e6de 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -353,6 +353,7 @@ struct ahci_host_priv {
 	struct reset_control	*rsts;		/* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
 	struct regulator	*ahci_regulator;/* Optional */
+	struct regulator	*phy_regulator;/* Optional */
 	/*
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
 	 * the PHY position in this array.
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index a886b61476a3..dc4d79b1c9ae 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -157,6 +157,12 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 			return rc;
 	}
 
+	if (hpriv->phy_regulator) {
+		rc = regulator_enable(hpriv->phy_regulator);
+		if (rc)
+			goto disable_ahci_pwrs;
+	}
+
 	for (i = 0; i < hpriv->nports; i++) {
 		if (!hpriv->target_pwrs[i])
 			continue;
@@ -173,6 +179,9 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 		if (hpriv->target_pwrs[i])
 			regulator_disable(hpriv->target_pwrs[i]);
 
+	if (hpriv->phy_regulator)
+		regulator_disable(hpriv->phy_regulator);
+disable_ahci_pwrs:
 	if (hpriv->ahci_regulator)
 		regulator_disable(hpriv->ahci_regulator);
 	return rc;
@@ -198,6 +207,8 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 
 	if (hpriv->ahci_regulator)
 		regulator_disable(hpriv->ahci_regulator);
+	if (hpriv->phy_regulator)
+		regulator_disable(hpriv->phy_regulator);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
 /**
@@ -430,6 +441,15 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		hpriv->ahci_regulator = NULL;
 	}
 
+	hpriv->phy_regulator = devm_regulator_get_optional(dev, "phy");
+	if (IS_ERR(hpriv->phy_regulator)) {
+		rc = PTR_ERR(hpriv->phy_regulator);
+		if (rc == -EPROBE_DEFER)
+			goto err_out;
+		rc = 0;
+		hpriv->phy_regulator = NULL;
+	}
+
 	if (flags & AHCI_PLATFORM_GET_RESETS) {
 		hpriv->rsts = devm_reset_control_array_get_optional_shared(dev);
 		if (IS_ERR(hpriv->rsts)) {
-- 
2.16.4

