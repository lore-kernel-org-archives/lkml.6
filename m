Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE01C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DB320823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxABZZa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfBUPql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:46:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46034 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbfBUPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:46:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so31087135wrn.12;
        Thu, 21 Feb 2019 07:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOwrGhxoTmPxUOoladdpz7HIYQJzlmSQBtiDPSXWQ6w=;
        b=uxABZZa/YLTFCPLJw5wWC3eqLnt+/HZsbG749j6X2YNhfKiD8nwWbXpKq9iOUj+e/J
         JssofceCLVnSDLsjp6lanbCYBWa8Smv5Tgkv2m56Mfv4I/ab3FAMnxvzoWLWa27SZffW
         U//8xG1u4buQ5t4KqFvle8TiQxPVGgCGy6c/39kxmyhtitlFFP9J8KFd7RaOzPhtySYj
         ebFSJ4DADs8bGaVzBALiIw6ttfW29VrOWBpibk4WOxf5bheDKIWa0XAJTHoeYYBTdipQ
         hQoH1MS2npMNakZj4cPqthpfaczWn7cdSa8prcqOImlWBCt2/dWtF2NwCz/PFP3/FDGV
         ltgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOwrGhxoTmPxUOoladdpz7HIYQJzlmSQBtiDPSXWQ6w=;
        b=NkgG2yVrI9tDh6P3HP60FwU9ls3q6UI1zc+C7aSLRO/9/BZ2yXgpAkEbnShw3wdjXY
         /M6jk9bcoSK/dNqOqpe6DfpyYHd5wNN4jteyFhAC20+JqnIXk9GeX3W1gfgn4IF/m4/x
         /GZpKKSL2KwqMs5aWipUtyedGhsBGzpYWgM9Y/QVPXMpcGS3m3l6F3gFU+/px98hUz7i
         3eijcR2o6yaE98Emof/fqxRz75r8/GD5GCiiS6v0KuXSqCrvzniZIo905QsD8Y1UUmAo
         S7ca8AhDLkYITq8QWqLxsC+NSUFcap9JOuLcuPIIsXnvFGwljguuP8e+eKLDmkGGjeta
         n1Qg==
X-Gm-Message-State: AHQUAub3TuzptEct4Nf4sAnnvmNvjqKWJUScUDbo+nlQE0/VH+u+10WN
        iDi11dxLUd3UaZjnwRNCDBD4L2Wd
X-Google-Smtp-Source: AHgI3IYasUh12bHz3YpKPvhdmfHsCOh5tesMyndKYhSAwSH2pZaO4pESCftNa9foW3uY9IA4qbWE6g==
X-Received: by 2002:adf:8294:: with SMTP id 20mr14772981wrc.223.1550763997569;
        Thu, 21 Feb 2019 07:46:37 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id x12sm2643485wrs.84.2019.02.21.07.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:46:36 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: phy: tegra: Add Tegra186 support
Date:   Thu, 21 Feb 2019 16:46:30 +0100
Message-Id: <20190221154634.10684-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154634.10684-1-thierry.reding@gmail.com>
References: <20190221154634.10684-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Extend the bindings to cover the set of features found in Tegra186. Note
that, technically, there are four more supplies connected to the XUSB
pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL), but
the power sequencing requirements of Tegra186 require these to be under
the control of the PMIC.

Reviewed-by: JC Kuo <jckuo@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
index 3742c152c467..daedb15f322e 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
@@ -36,11 +36,20 @@ Required properties:
   - Tegra124: "nvidia,tegra124-xusb-padctl"
   - Tegra132: "nvidia,tegra132-xusb-padctl", "nvidia,tegra124-xusb-padctl"
   - Tegra210: "nvidia,tegra210-xusb-padctl"
+  - Tegra186: "nvidia,tegra186-xusb-padctl"
 - reg: Physical base address and length of the controller's registers.
 - resets: Must contain an entry for each entry in reset-names.
 - reset-names: Must include the following entries:
   - "padctl"
 
+For Tegra186:
+- avdd-pll-erefeut-supply: UPHY brick and reference clock as well as UTMI PHY
+  power supply. Must supply 1.8 V.
+- avdd-usb-supply: USB I/Os, VBUS, ID, REXT, D+/D- power supply. Must supply
+  3.3 V.
+- vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
+- vddio-hsic-supply: HSIC PHY power supply. Must supply 1.2 V.
+
 
 Pad nodes:
 ==========
-- 
2.20.1

