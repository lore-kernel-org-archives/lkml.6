Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C954AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 08:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE9520879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 08:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMovuYYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfAMI4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 03:56:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40520 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfAMI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 03:56:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so6006349wmf.5;
        Sun, 13 Jan 2019 00:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1o2REoSJMB+yRrpHtq3S/8MWXI8bwdpI6mjqIixGpQ=;
        b=dMovuYYubf9yasjyWmCNdXfWpnOPJRRSQeLH8LeZq/rwInVF51YWIHU7uDh7vbUPHs
         vtxlS7TwR8a3jhPIrczxPFdt0h7XhizXBSky1r6HUhfE0zSsRBkyh9ZD/Ler5N2BxNyS
         ObYXH9NWfLtzQIBDF1FSvSQnjJVjF+EcAf2BcaSnYmbn0dd1V23qcVfURrhovza4KEZp
         NAFfTLntm+hFD++0PyhiUZ20coDd9N+BK5cN1G+p+mVzVGSN8y+WCZYcTOj1bMz9Af5o
         2/Pc3ngSklXO0r9jpd/ZxaZwaal2FS33xuybdZr/miP8DuGwUqtvDSktOfBO64jcvl3P
         /r0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1o2REoSJMB+yRrpHtq3S/8MWXI8bwdpI6mjqIixGpQ=;
        b=Sw1DsV52VtC+FIiUBokSYE7MyLvHOpFYG89lgmqtsMozKXYgYfmN0TKz/L+y5I4kEV
         ZgrIIMNOhb/6+FVay70HTHq0pxV64eNxXDLyxxtpORSZz8LRdTNt3vTDXjBjepxYudBB
         1BiHB0EGi+svOOfcx7ay++/isPAM4VqqJKtVwxBXzRqMCdncnzNvak3vKSRXKsrTrUz2
         T2xSRUTkU7/gl9y1Ptg57pLxgw3MIbn+N04yrabD7gdciIYDct8bXVP3oHtgZRnpxWUw
         tGKJr2R3XaqTGaA/EkzHyuHE1N6ezeXrcEEld4linYlDYtuFpkPJiv9VJukhsslWt+ot
         c5Fg==
X-Gm-Message-State: AJcUukcGbsvhRCLvzz9oWMsTRbRZJe4rk2hIMU5ZN/VXSno5b7XL0Aja
        tSAqEqALmegqp1pVdp6FNqs=
X-Google-Smtp-Source: ALg8bN61FSvU4Cb/iimeaCconEjCPul4bNUat5vx8+xB5fvfxXbjouDdd5Agx2/d2Y4nQNn7+CG1fA==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr7695729wmd.112.1547369810728;
        Sun, 13 Jan 2019 00:56:50 -0800 (PST)
Received: from localhost.localdomain (184.red-83-42-150.dynamicip.rima-tde.net. [83.42.150.184])
        by smtp.gmail.com with ESMTPSA id t18sm17421187wmt.35.2019.01.13.00.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Jan 2019 00:56:49 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     Woojung.Huh@microchip.com
Cc:     UNGLinuxDriver@microchip.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, robh+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: net: dsa: ksz9477: fix indentation for switch spi bindings
Date:   Sun, 13 Jan 2019 09:56:48 +0100
Message-Id: <20190113085648.26091-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch bindings for spi managed mode are using spaces instead of tabs.
Fix them to get a file with a proper kernel indentation style.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Changes in v2:
    - Rebase onto net-next
    - Collect previous Reviewed-by tags

 .../devicetree/bindings/net/dsa/ksz.txt       | 102 +++++++++---------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/ksz.txt b/Documentation/devicetree/bindings/net/dsa/ksz.txt
index 0f407fb371ce..8d58c2a7de39 100644
--- a/Documentation/devicetree/bindings/net/dsa/ksz.txt
+++ b/Documentation/devicetree/bindings/net/dsa/ksz.txt
@@ -19,58 +19,58 @@ Examples:
 
 Ethernet switch connected via SPI to the host, CPU port wired to eth0:
 
-                             eth0: ethernet@10001000 {
-                                             fixed-link {
-                                                             speed = <1000>;
-                                                             full-duplex;
-                                             };
-                             };
+	eth0: ethernet@10001000 {
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+		};
+	};
 
-                             spi1: spi@f8008000 {
-                                             pinctrl-0 = <&pinctrl_spi_ksz>;
-                                             cs-gpios = <&pioC 25 0>;
-                                             id = <1>;
+	spi1: spi@f8008000 {
+		pinctrl-0 = <&pinctrl_spi_ksz>;
+		cs-gpios = <&pioC 25 0>;
+		id = <1>;
 
-                                             ksz9477: ksz9477@0 {
-                                                             compatible = "microchip,ksz9477";
-                                                             reg = <0>;
+		ksz9477: ksz9477@0 {
+			compatible = "microchip,ksz9477";
+			reg = <0>;
 
-                                                             spi-max-frequency = <44000000>;
-                                                             spi-cpha;
-                                                             spi-cpol;
+			spi-max-frequency = <44000000>;
+			spi-cpha;
+			spi-cpol;
 
-                                                             ports {
-                                                                             #address-cells = <1>;
-                                                                             #size-cells = <0>;
-                                                                             port@0 {
-                                                                                             reg = <0>;
-                                                                                             label = "lan1";
-                                                                             };
-                                                                             port@1 {
-                                                                                             reg = <1>;
-                                                                                             label = "lan2";
-                                                                             };
-                                                                             port@2 {
-                                                                                             reg = <2>;
-                                                                                             label = "lan3";
-                                                                             };
-                                                                             port@3 {
-                                                                                             reg = <3>;
-                                                                                             label = "lan4";
-                                                                             };
-                                                                             port@4 {
-                                                                                             reg = <4>;
-                                                                                             label = "lan5";
-                                                                             };
-                                                                             port@5 {
-                                                                                             reg = <5>;
-                                                                                             label = "cpu";
-                                                                                             ethernet = <&eth0>;
-                                                                                             fixed-link {
-                                                                                                             speed = <1000>;
-                                                                                                             full-duplex;
-                                                                                             };
-                                                                             };
-                                                             };
-                                             };
-                             };
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					label = "lan1";
+				};
+				port@1 {
+					reg = <1>;
+					label = "lan2";
+				};
+				port@2 {
+					reg = <2>;
+					label = "lan3";
+				};
+				port@3 {
+					reg = <3>;
+					label = "lan4";
+				};
+				port@4 {
+					reg = <4>;
+					label = "lan5";
+				};
+				port@5 {
+					reg = <5>;
+					label = "cpu";
+					ethernet = <&eth0>;
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+			};
+		};
+	};
-- 
2.19.1

