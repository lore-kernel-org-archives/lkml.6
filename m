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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75AB218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ui2jqoU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfAYLZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:25:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38521 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYLZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:25:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so9880325wrw.5;
        Fri, 25 Jan 2019 03:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzzh5HqkKWgeEDulmsMk+XDsAXJUDsr9GECqwiKTZHY=;
        b=ui2jqoU21dkv9PHSREaC/P3MeCoDXR0bKcvOXSXVmEmtG0FfptyBW+0nusccGmI43J
         0QVnq5jKiYdVZlAIecnpvqSjylRCpIQKrszuLwp3fUNTufAufCx1cUCwHPpQsc7U3p++
         MkffM4oTV+F2pz6Bbx2Q9RbDNE3VZtEC5+TGHw9paYCclp0UoNyWdQhcROlgP/8ZR95Z
         dwU/kUIyPfstWOOpE4hq4yJ0Tzvm5bhqNcdWAuhK3MAshUBZriENuvLjNaluojiETcSd
         biM2GXLWu8J8SJEhduO5Im3FlNhJKCmMFj/TIHW0hE79yUbLyFmz65gaK87MEHqc6+Rl
         3Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzzh5HqkKWgeEDulmsMk+XDsAXJUDsr9GECqwiKTZHY=;
        b=LwvVuWb0UFn7K88ySqRnozy5jN4QKE9NYh9MPsxdwHjniWdvpFqkPUrUE6Jbf5V7UJ
         bP4S3wDFrUJy5KLunj3YwmKRQxQEMWrLhfxZ5wChJODdeF7pSItjDPK4/m7NE/pddd8H
         rnv00HmtMBabXcx6gtHxsg1ZEvuYd8SxQwRs0/PFQZO+sXuO7j8FW+VwQbM9rUvZdYkJ
         Z44+Uz5wow1xhGC8hndJGInIC9F4kNdlcqm74O4Z3NLsYS/KT1UYVvD7CseZNU+7OlrU
         ZqivuA5waG1h/wrKOaeWh2TPjr0pSv+x4XjWBXm49LVBx/fWEUHv6njo5pUFG3Gop/kz
         rDUA==
X-Gm-Message-State: AJcUukd1P1jMI+d5TnyahCpdGvxsahRfDev8V4Plfq99/7omHll8w3jd
        vJDJdzHNBo92MScBAIKtueU=
X-Google-Smtp-Source: ALg8bN7hkAX0wsJwZClkm2Erd1RqVkH0yvfj7pK9yyQ+qaLUJTb339kP8lADUow5fcNX454xzQ0zkg==
X-Received: by 2002:adf:bb44:: with SMTP id x4mr11560285wrg.24.1548415527927;
        Fri, 25 Jan 2019 03:25:27 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id v132sm63626106wme.20.2019.01.25.03.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:25:27 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: phy: tegra: Add Tegra186 support
Date:   Fri, 25 Jan 2019 12:25:21 +0100
Message-Id: <20190125112525.10697-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
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
2.19.1

