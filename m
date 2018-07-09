Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A11C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30F0208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AAJpyl6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30F0208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933503AbeGIPVT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:21:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36413 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933387AbeGIPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:21:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so11416665wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P2n+dbh0pf2JlTt/2aTmjrTkU5W81yVSeGZDp8AkMgc=;
        b=AAJpyl6tGGRZsG6t391YsyAQsxRg+ynjRiC7xqxcDf0etUOMii8/Gw7a9F30qUL2qi
         LKDLQRODcMJeJ449ddicc1wf58zRvQwujxNg7zlhSWwmvzf3LKOkTMVfAggakad/n5Fq
         rNGssX1tF1mmyG79KaE+jSmTTzxgy8i/PgSEn1TsliUato/MtzhpIatE92dNkoERuZix
         yftf4Zk6qAdAkQbd737TVZxTqu+XhteT/G5I0CQ/1URuCRLw/F1ngd6p/2TGj2ua1hLh
         p8WktB3TQIDhtnmqCY174Kvd4gq88IFJ7qLO0cqKX0fEqEz0YDouVLiV64vvkPuVlx0/
         KOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P2n+dbh0pf2JlTt/2aTmjrTkU5W81yVSeGZDp8AkMgc=;
        b=m69bXGRDD+aOYhfXYX/MwSyJR8G7J1+uLxcdUW2Vh3c0yL8ccwq8d2kRXIq3POFzAM
         3zbZfBQjqH3KT89BhimhxTx+uo1sYO9NHtG0CUCY93BZCNi7DyuRi4CLuX5md0XRK7IK
         FmSoS13TNve4Z1kpnHTOjdfzCWu/8euEhzB4/S64NdC/n3s1Jp9+mTNV8GOk/4JU/C2R
         IYamxKbBJt2bZMEYGZOjNbFrikDz7m39A6kMC3hhIuDY17evoDWbXHwheKFSGLtQNCcn
         HYhu5FxQBBiK+FtkwBIm+NLaRbgMJpYPXzqPltnrZzCrOq7vF3pDCCKCRkD3We3+M++m
         t5vw==
X-Gm-Message-State: APt69E0o8EnvApS/i5mdeLrLxQnujxzVqs9jiXyFqnAeHnDYO6JMRCnw
        TlpXnA7wYYRy68qW4ZPlMa+v4w==
X-Google-Smtp-Source: AAOMgpdjcCD4tDC09MgRxn3K8w7EcOSsZQPrErl3jBGULWeBBt92SS6gXLD/voHN80W0B4M1GAyY6Q==
X-Received: by 2002:adf:e24d:: with SMTP id n13-v6mr15566595wri.205.1531149673748;
        Mon, 09 Jul 2018 08:21:13 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id p4-v6sm14468474wrj.71.2018.07.09.08.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 08:21:13 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.io,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 1/4] dt-bindings: add binding for Allwinner R40 SATA AHCI controller
Date:   Mon,  9 Jul 2018 15:20:55 +0000
Message-Id: <1531149658-27030-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The Allwinner R40 SoC contains a SATA AHCI controller like the one in
A10/A20 SoCs, however a reset control and two power supplies are added
to it.

Add a binding document for it.

As a dedicated binding document is needed now for the A10/A20/R40 AHCI
controller, drop the A10 compatible line from generic platform AHCI
controller binding document.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |  1 -
 .../bindings/ata/allwinner,sun4i-a10-ahci.txt      | 40 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c760ecb81381..1bea4b5ef9fd 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -9,7 +9,6 @@ PHYs.
 
 Required properties:
 - compatible        : compatible string, one of:
-  - "allwinner,sun4i-a10-ahci"
   - "brcm,iproc-ahci"
   - "hisilicon,hisi-ahci"
   - "cavium,octeon-7130-ahci"
diff --git a/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt
new file mode 100644
index 000000000000..0eea78c14ad3
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt
@@ -0,0 +1,40 @@
+Allwinner A10/A20/R40 SoC SATA AHCI Controller
+
+Required properties:
+- compatible        : compatible string, one of:
+  - "allwinner,sun4i-a10-ahci"
+  - "allwinner,sun8i-r40-ahci"
+- interrupts        : the SATA IRQ
+- reg               : the register mapping
+- clocks            : the clocks needed by SATA controller, usually contains
+		      an AHB clock and a mod clock
+
+Optional properties:
+- target-supply     : regulator for SATA target power
+
+Required properties for the following compatibles:
+  - "allwinner,sun8i-r40-ahci"
+- resets            : the reset control needed by SATA controller
+- vdd1v2-supply     : regulator for SATA controller's 1.2V VDD
+- vdd2v5-supply     : regulator for SATA controller's 2.5V VDD
+
+
+Examples for A10:
+	ahci: sata@1c18000 {
+		compatible = "allwinner,sun4i-a10-ahci";
+		reg = <0x01c18000 0x1000>;
+		interrupts = <56>;
+		clocks = <&pll6 0>, <&ahb_gates 25>;
+		target-supply = <&reg_ahci_5v>;
+	};
+
+Examples for R40:
+	ahci: sata@1c18000 {
+		compatible = "allwinner,sun8i-r40-ahci";
+		reg = <0x01c18000 0x1000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&ccu CLK_SATA>, <&ccu CLK_BUS_SATA>;
+		resets = <&ccu RST_BUS_SATA>;
+		vdd1v2-supply = <&reg_eldo3>;
+		vdd2v5-supply = <&reg_dldo4>;
+	};
-- 
2.16.4

