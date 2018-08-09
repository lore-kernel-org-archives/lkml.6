Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC61FC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB5521E17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2lercml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB5521E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeHIO5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:57:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33135 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:57:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so4357416ljj.0;
        Thu, 09 Aug 2018 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1koQvgLpOHKSo2UbGrEiF0QLYvVVtdV9mxihlxpb/Nw=;
        b=E2lercmlgb5/VqkzwFD6YxIzZsPckLI24/pGbZMMWD1JlqAOguQwcWj4K5rPuEfdIR
         n0wLJiZUiNysWfAi+IWwVHpwZv2YrUkgA17ICLc/soWpamqTPZXm+v8Q9HLsvYIRm3Z4
         PjeeCrupojMX7GKyNHuH/O+q8y2pqu3JpCz6epYk96F0Sh1v5jQplo/JlMkBFzOzBg49
         QSnENVqd3oahkgXg5ypS2U59v9Aqqs9zbKXQ1OQBtdsfz+ZzzwyquCgOXYgUc4WrLJ45
         hS+VcsG3eReVYTAfJRxO543LzyJeK/errxBBenhsHM3x0OZhMnvAX6x42MvcAcZPTP04
         jPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=1koQvgLpOHKSo2UbGrEiF0QLYvVVtdV9mxihlxpb/Nw=;
        b=hv+880l76/mdYvAUNsGVb4bsffivGxGVypVnTUyOwc498sYI4oGsJFTtK7zZYTIesL
         ujF/pv7zG/yNBb3geUzxT1+k3Iyzq0DjZ/mY9mhchzifWyWAdEVaQGw95l8YkgQOwjll
         LEfQ0qBBoqxn9RTs7PrdCeE9RmUOsD2T6Ot+PXZ+9knpAeG4YO6QrKnR6BgIAZ9+oA/L
         7dbXaXroMd8mLmrVIBeXviOQrz74v7V/XDwf2N35VQLRjcLDom3312yXAL4R2M8DrCgz
         RI1/qMAPytjYaZ6OUrODCWvD2Vrev6fxRDSov+HXGEpryYeObOdFQIFKlZBCI5D33Kea
         mqGQ==
X-Gm-Message-State: AOUpUlESdq3hDk1l7xKDnaM5/h18Sb0YXhHowsdSefIFWBEu1+rgoOZB
        jFAd9oBGmHKeiFGSUREVU5gP9tDz44g=
X-Google-Smtp-Source: AA+uWPziJ2DKPvJ7pnIe2ipuye1DSsfPepcI9PhJUNg+e4IaNcJOQOe56rGNISDFShj6L0yPTZONiA==
X-Received: by 2002:a2e:63c5:: with SMTP id s66-v6mr1636237lje.23.1533817938724;
        Thu, 09 Aug 2018 05:32:18 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id l3-v6sm1344110lfi.36.2018.08.09.05.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:32:17 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     Esben Haabendal <eha@deif.com>, Shawn Guo <shawnguo@kernel.org>,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm: dts: ls1021a: Enable I2C DMA support
Date:   Thu,  9 Aug 2018 14:32:07 +0200
Message-Id: <20180809123207.9732-4-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809123207.9732-1-esben.haabendal@gmail.com>
References: <20180809123207.9732-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Gives substantial performance improvement for transfers larger than 16
bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c55d479971cc..1e5640701c65 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -363,6 +363,8 @@
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 39>, <&edma0 1 38>;
 			status = "disabled";
 		};
 
@@ -374,6 +376,8 @@
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 37>, <&edma0 1 36>;
 			status = "disabled";
 		};
 
@@ -385,6 +389,8 @@
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 35>, <&edma0 1 34>;
 			status = "disabled";
 		};
 
-- 
2.18.0

