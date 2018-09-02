Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C691C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6151320841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6151320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeIBOYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:24:47 -0400
Received: from mout.perfora.net ([74.208.4.197]:46593 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbeIBOYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:24:47 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lu5Nw-1fo30z0i98-011Lif; Sun, 02 Sep 2018 12:09:19 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 01/37] ARM: tegra: colibri_t20: move aliases from module to carrier board
Date:   Sun,  2 Sep 2018 12:08:30 +0200
Message-Id: <20180902100906.25792-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Vi2OWs/iqy8ZAJ/PHvYSTdYj0taKa24vWvtqjSvu1Zlt/xvmfxn
 92z56Ei+6csQ4OF4BmBVYYOOw55pmOHvavsVgaGPlns82b5qCN/XLCjq87QIcCUrTh9Kfri
 /8KQ3xGxTesjtSJ9+Pr2SJ2Jws74VuEQuv6dt0OaBSBxsfpAPdjLWZ4h1llHBdDkHK3+68i
 VRwNygDj0PD3EOugfZ2Yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TkgL0K6bBj0=:68k1DTQnPbreONBm1MNf2V
 mJPMvKiJaFQy/42A8O5GhMyThwRa7wNBbAzDqYhyVNpodxJGeKjJzlaN0Mz26vHmwjBTEvw5F
 VzWMhqk9+5fffrv9SIHKo6yenZBiWELTu31rnCgALtRrjwXoM7e5JhRgLPiiT6jRaYQXkgp5n
 xsCxQL1+F1daeYlft+9ilG22jCUVJyT2ulDlKL3Nbm4F6H+m/gGLOnK99qtnUeuUCKNPOpCHy
 uFrMypRVQMG+7vXaZbjj1bRt3kxc+Trj6fMWuB2AWTd17UyyeqLC1vONgLO66Z0dzhFEBg7Nt
 UV6VfvukRbJ2gZEHsFqSpqdMxMS30lCfcsy6mQ9pxP/UwuDL/tSW5ugvV1jU3tI+bAFn6BSEB
 WJPU7UCxtQpi/TzHvxf9kkKm7U80Bif08tzfa5Qik8tR51Afag0UIYJAL1VsG6S8YSx3EQsW4
 OeEyiVbTZQfgCG8++sRqzGC+IFzM9E0qbVD5AyrxCx7Itueq5YHoOBkHN0nN36itOpHT44RE0
 Mpcl30P6MGXDH2jdCoi/Qp/KxcD2DGc+rqtrQfdZQYQ5jSqJADX7y0y0t2iLrhAmHvGXGQzyy
 rqH4sPMUDxuqXvXmY26DZW4W8TLdXAinc45wpEvUG4uy1ghW/C+JjwuqZ6z5vNzJPRx8d+RS5
 49mT/8LuW5NJpgZvagyQf4DfnYzYtKHwG384f9DcPC6R9zyPc67zoFV7wsXS8lzs2SLU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move RTC aliases from module to carrier board to be more in-line with
all our other device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 2 ++
 arch/arm/boot/dts/tegra20-colibri.dtsi     | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 57f16c0e9917..496b96e229d2 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -8,6 +8,8 @@
 	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
 
 	aliases {
+		rtc0 = "/i2c@7000d000/tps6586x@34";
+		rtc1 = "/rtc@7000e000";
 		serial0 = &uarta;
 		serial1 = &uartd;
 	};
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index fa1af2dc276c..e34ab4a76158 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -5,11 +5,6 @@
 	model = "Toradex Colibri T20 256/512 MB";
 	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
 
-	aliases {
-		rtc0 = "/i2c@7000d000/tps6586x@34";
-		rtc1 = "/rtc@7000e000";
-	};
-
 	memory@0 {
 		/*
 		 * Set memory to 256 MB to be safe as this could be used on
-- 
2.14.4

