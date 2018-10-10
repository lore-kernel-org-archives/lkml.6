Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4999BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3D9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAbxJ1uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3D9214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJJQXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:23:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43819 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeJJQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:23:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id r8-v6so4161115ljc.10;
        Wed, 10 Oct 2018 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2OCDbqMb6nYqZMgYt5ZgfyBJjth2xz5R26iqEUWcAQ=;
        b=hAbxJ1ufKoTUfC9+bybFXqMl6xW9gPx+FObVDUNTyVkBcCW9ztLNHOjb5WAK1mDd8l
         zm3E4wnDrAjX8ToF6eRABtTHdUWplLFNXscwkbjfH4QH/GizXljSYTlfMwMtdhluEyyJ
         FOsChJObB6cZu8imfx9BkC4NZ/SSJpAJAGtabZqlEI9TxiMdf8LHGzvBt4kMO89tdHL7
         NkWfhJFpfbamQxjph9JI3J5hbtFclGIUKdppPhsnIs0WL+jF/7GT+h8sp8is0fXnYOtX
         OL3Z+gQiWYFbmLxmVuLuUJEG4yL2CPX8KGmk5vPEkozPLz7sU7LmYvlzfTI35VfO4lhO
         OiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=J2OCDbqMb6nYqZMgYt5ZgfyBJjth2xz5R26iqEUWcAQ=;
        b=Y9gbO2fyMRFXyS2UyqLLN/u/oWb+JdpzDXYgKCO3f5JuE9/lVO+F74p1jIVrR6JG2j
         EktW0purR6KqxdE1vPI8r3gF6xqnezb5OFqiaI/CI8dl6Eo6iI0L6Ru1yh2ktUFIngi/
         3WMe43bzFid+wVO01OIXb/JtNoCVD8Z/84ukis/lOplwN/tr5unAWeqdgbmKtDGz3j4k
         3gLcHBUYPBa6RoQra87ks7552SrUyDpYnkZ9bbBh6Xb5Jeic4E34T7FOaerV6dKHeH4h
         UIkrzYid2aP4FIpLen6Pkyt9P1w+eG60geVfxAHdXYsiS3Ev5FTqNtF4JvNzoQFRKjkP
         IEsw==
X-Gm-Message-State: ABuFfohZvOrMYeWrkZ/D2MUQhItParQG01ARS2ZexzvzOimux8HU/yjU
        eXUYr0VfnRPNwbOf/Ejs+1g=
X-Google-Smtp-Source: ACcGV63uwLPLZdfv3hnbQRd0TrjuL4yIGVC5cnIviIAM0Gehi8XYdbWm1+MDo/RYkKayofZmOx7GbA==
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr16663276ljc.61.1539162110537;
        Wed, 10 Oct 2018 02:01:50 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id q2-v6sm2150078lfc.67.2018.10.10.02.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 02:01:49 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-rockchip@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 3/7] arm64: dts: rockchip: add rk3399 SPI DMAs
Date:   Wed, 10 Oct 2018 11:00:34 +0200
Message-Id: <20181010090038.20834-4-kernel@esmil.dk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181010090038.20834-1-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spi dma channels as specified by the rk3399 TRM.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index c88e603396f6..c11b5ae6f1ad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -653,6 +653,8 @@
 		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
 		clock-names = "spiclk", "apb_pclk";
 		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 10>, <&dmac_peri 11>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
 		#address-cells = <1>;
@@ -666,6 +668,8 @@
 		clocks = <&cru SCLK_SPI1>, <&cru PCLK_SPI1>;
 		clock-names = "spiclk", "apb_pclk";
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 12>, <&dmac_peri 13>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
 		#address-cells = <1>;
@@ -679,6 +683,8 @@
 		clocks = <&cru SCLK_SPI2>, <&cru PCLK_SPI2>;
 		clock-names = "spiclk", "apb_pclk";
 		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 14>, <&dmac_peri 15>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi2_clk &spi2_tx &spi2_rx &spi2_cs0>;
 		#address-cells = <1>;
@@ -692,6 +698,8 @@
 		clocks = <&cru SCLK_SPI4>, <&cru PCLK_SPI4>;
 		clock-names = "spiclk", "apb_pclk";
 		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 18>, <&dmac_peri 19>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi4_clk &spi4_tx &spi4_rx &spi4_cs0>;
 		#address-cells = <1>;
@@ -705,6 +713,8 @@
 		clocks = <&cru SCLK_SPI5>, <&cru PCLK_SPI5>;
 		clock-names = "spiclk", "apb_pclk";
 		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_bus 8>, <&dmac_bus 9>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi5_clk &spi5_tx &spi5_rx &spi5_cs0>;
 		power-domains = <&power RK3399_PD_SDIOAUDIO>;
-- 
2.19.1

