Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF55BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B58D2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="waYaO2hF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B58D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGRMSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:18:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36206 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbeGRMS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:18:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so4360633wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kirFAyfc4bsCjq/mtoSAOlwPsx2v2IzEA2qSKZoPQWI=;
        b=waYaO2hFZaNTHOVrGmruDKtsSa78Mligqpu1ygJDVW2nuZu/mYWw+qbEvXn9wYm5AI
         a/aixuaHVOJkWJ44KF7oldxzJZktWBN4uab5s+WiHnhQUkpfF4L+fmg/khZA1TCQSUEF
         UlZkudr3pXMT86IAlruCCZkscg7V4WMRbhv1euhJJ96d6wmk2ZqPil6HXD22wMVOjTqX
         5paOWrnq1waQDDR47TatjtfbEfZPZ0dk8/xt8C4efXso1Cih/Ka4TFwSgCSKb2QH6cDX
         37/J7XeeS5g3pSfn8bKmSWvLbHgQQ4+k8HsHKPSfB9heLh+4H5CCrYmcbIl9hY/zvsXm
         xxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kirFAyfc4bsCjq/mtoSAOlwPsx2v2IzEA2qSKZoPQWI=;
        b=Jw/VwSXKqT4lArWyjEm1ZAS9cotuVXyGhQX2G+/czh18I7dDKJVeHI2pLd+L8Zq/pi
         +c8Mz4HzsZQYlup9c/Xi6e4KOicH6GLk30w8Kivdo038lk6kAvKcy2KJeU+92iEeHe7t
         32sVHKQNMcurGuJbZFRr/PTgh8a0Ss5IVM/TVCRPG77xliN407RwFw5lc5OUrlURB8cl
         qSw5da8Gb/rT1pUuvoFh2tOoQTw2l3Xr2AvMPf/yyeIkxUw1lZz6Y0vKfmUWxYmD309F
         eVOzszI2cqLYuDXqAKCxyYg7FLyUCUTGPeNWzl0BOo7TD57A1p0KI12SVi8RUUHFDrFG
         yJ6g==
X-Gm-Message-State: AOUpUlEc1IVS9MZks7yocxtj92hIqgBzUQZcBs2KphaNajFs92QSvEaj
        Jv8+QGQRthcVx75md5kXojZfLw==
X-Google-Smtp-Source: AAOMgpfqUSlKqGjRNazaEoiJssP2adIZdPafD930o3s+tiU2nnWkLmfwlg33KCHhaXQABGtmw+/wUg==
X-Received: by 2002:adf:83c6:: with SMTP id 64-v6mr4054489wre.5.1531914056160;
        Wed, 18 Jul 2018 04:40:56 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y102-v6sm3805129wmh.9.2018.07.18.04.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 04:40:55 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     catalin.marinas@arm.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        robh+dt@kernel.org, wens@csie.org, will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 5/5] ARM64: dts: sun50i: a64: Remove unused address-cells/size-cells of dwmac-sun8i
Date:   Wed, 18 Jul 2018 11:40:41 +0000
Message-Id: <1531914041-14751-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
References: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

address-cells/size-cells is unnecessary for dwmac-sun8i node.
It was in early days, but since a mdio node is used, it could be
removed.

This patch fix the following DT warning:
Warning (avoid_unnecessary_addr_size): /soc/ethernet@1c50000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 91dd5dd9e205..357f6cba00cd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -668,8 +668,6 @@
 			clocks = <&ccu CLK_BUS_EMAC>;
 			clock-names = "stmmaceth";
 			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
 
 			mdio: mdio {
 				compatible = "snps,dwmac-mdio";
-- 
2.16.4

