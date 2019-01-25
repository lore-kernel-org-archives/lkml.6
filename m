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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466EC218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtM12YcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfAYLZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:25:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35347 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:25:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so9923564wrb.2;
        Fri, 25 Jan 2019 03:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73PhPzZvbQ2Ilmb4WfNnZ6RVNfBIrtWaxQPD7Xifscc=;
        b=PtM12YcIP31FBY9DbFODt9rpmV434nV3o2v7y5VTHnwjA/TKsk6c4MZX4uva28LHd/
         nWjic1fNXYc9BVieOv7ntmFnT1a4wZvBEZLbevkdyc1DD0p3530wCnpZd0/oDzvRQsio
         JEsviqAb5OmM5b37Di0lNaI1nHXhRsrlCNavOW6lbCZOmBtfOTce2j5g488L/yfOuV9b
         vDcmXsYs7ASQ8a0n1Mi9wK0appnxCMB8qrvVM6KaMV6pQfdCmjrfZpujZOMh7kqH8dK4
         EOUfPwjY5B7+fotIH3uWimeWUo8msKTFqqBIJgRG7TwNvlL7JhkyLpvc4e/NJp3/uvPN
         2CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73PhPzZvbQ2Ilmb4WfNnZ6RVNfBIrtWaxQPD7Xifscc=;
        b=SgXfRowSWy3c6vP78jN7oOMg5P8nL84dbWe+SvKXUZ0anFHJYCxhtATFdElhQ7d1Q0
         2S0SHTnVYgGzi3/SWIw5WRMSg5vhuoDj18SWHdNijDQiJ2fdXdV304O3u+VS4phxErMV
         STzKc3xmggJ5HcjpJRwGNdyy62yrK07dgGit2ds4v14Sla9bItnWCbOOWKeF8qJPbxTl
         hkBOr1T3R1niXieVasRQsL97mQO563cK8zTB8mF+qEWo+6yFhvbwNcPWPaM3D+emLT43
         jnfmX7eN7sZqDzGcTyVPffP4ic7R5I4G54BimGZD47UrW1L4XYZlvWCgJ2kGQ/IhKqTN
         4NOw==
X-Gm-Message-State: AJcUukf46CUTimcYFVDOar9hE98wVJhdLRug49XMxxZU1ckEiSorl4dc
        WUJmLevR4oyc2jUjFAbmdQNmnPIOnPM=
X-Google-Smtp-Source: ALg8bN5416i1O8yVPd9Q0i16l0dIuld6v/0Yk3LEG933+Jy2E5FBbOxeS+ZCCBuWADsdRFOS47az+A==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr11931024wrw.50.1548415531220;
        Fri, 25 Jan 2019 03:25:31 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id n11sm40781313wrw.60.2019.01.25.03.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:25:30 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] phy: tegra: xusb: Parse dual-role mode property
Date:   Fri, 25 Jan 2019 12:25:23 +0100
Message-Id: <20190125112525.10697-3-thierry.reding@gmail.com>
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

The device tree bindings document the "mode" property of "ports"
subnodes, but the driver was not parsing the property. In preparation
for adding role switching, parse the property at probe time.

Based on work by JC Kuo <jckuo@nvidia.com>.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/phy/tegra/xusb.c | 21 +++++++++++++++++++++
 drivers/phy/tegra/xusb.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index e3bc60cfe6a1..57a2d08ef6da 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -546,13 +546,34 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
 	device_unregister(&port->dev);
 }
 
+static const char *const modes[] = {
+	[USB_DR_MODE_UNKNOWN] = "",
+	[USB_DR_MODE_HOST] = "host",
+	[USB_DR_MODE_PERIPHERAL] = "peripheral",
+	[USB_DR_MODE_OTG] = "otg",
+};
+
 static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
 {
 	struct tegra_xusb_port *port = &usb2->base;
 	struct device_node *np = port->dev.of_node;
+	const char *mode;
 
 	usb2->internal = of_property_read_bool(np, "nvidia,internal");
 
+	if (!of_property_read_string(np, "mode", &mode)) {
+		int err = match_string(modes, ARRAY_SIZE(modes), mode);
+		if (err < 0) {
+			dev_err(&port->dev, "invalid value %s for \"mode\"\n",
+				mode);
+			usb2->mode = USB_DR_MODE_UNKNOWN;
+		} else {
+			usb2->mode = err;
+		}
+	} else {
+		usb2->mode = USB_DR_MODE_HOST;
+	}
+
 	usb2->supply = devm_regulator_get(&port->dev, "vbus");
 	return PTR_ERR_OR_ZERO(usb2->supply);
 }
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index b49dbc36efa3..bb60fc09c752 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -19,6 +19,8 @@
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
 
+#include <linux/usb/otg.h>
+
 /* legacy entry points for backwards-compatibility */
 int tegra_xusb_padctl_legacy_probe(struct platform_device *pdev);
 int tegra_xusb_padctl_legacy_remove(struct platform_device *pdev);
@@ -271,6 +273,7 @@ struct tegra_xusb_usb2_port {
 	struct tegra_xusb_port base;
 
 	struct regulator *supply;
+	enum usb_dr_mode mode;
 	bool internal;
 };
 
-- 
2.19.1

