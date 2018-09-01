Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26262C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB19D20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB19D20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeIAMYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:30 -0400
Received: from mout.perfora.net ([74.208.4.194]:51409 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbeIAMY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:29 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MfXPZ-1gFTiU1dql-00P7rX; Sat, 01 Sep 2018 10:13:13 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 07/34] ARM: tegra: colibri_t30: move dr_mode property from phy to controller
Date:   Sat,  1 Sep 2018 10:12:21 +0200
Message-Id: <20180901081248.22639-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:3KrIJEAE3E6ETZ2EG+fVlv/tFfmIsnlrrvEWuoB6bI4ei3PnclL
 RBmzfr5ZSq3VypQiKq3HMrSQua/7GWioMPvne3P4dBGrIzdSZA0Zpeqh7dIebf8/xt+7V6s
 IOn9i39GXCI6IyqfChLAX3YuDxbQ5VwirUf3eMQAB12w3Wgr+hBrbA6VfVzGGb/wYlgJ2jj
 ArS29ekdSAM9SDY6U4aCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ra57fp7oNN8=:shYl7/l8Yij/Yh8aGzTxti
 oBhB/n25JeUsIXwXzZ5wInyJzB3zcKGYlNIfUw9M17dwapCnw+euh5AQWcn1kDGDpyfAi4Nyj
 lefxOFoLhOITLasiPlvFpVa4XlzrmFSxTAdCqn+P0aGELC5bNHs04q2Yucf1IeQZiHio5EONm
 4To8vIqJ2L9A6o6cw0oE/6zgBCbE6ZPyBeJbV/8zKDhNOHqBff1Jcsm/3wzSrTS0ukESeDGCl
 4fdM3A2yA5YnxFN/ixfXPGXTz4ArDg6rL1Z8CuDBGcjvYmjn24GztcarxY7FAwVWG9gOhGoBd
 6K69yZqtrvN+QNDY9ToNSWDpjl+U7SKwMEEhBxGetcry31bIxG630hwAOrYIAT3K33gP/+V/J
 Ba2lbyW/VCLMWnABoeYjcnYQsBc1gaH+Nc114MZiVfCMdZM2Rl9H0/V13Elv+SGX04r30TZ3g
 yZOfY/0gOjI0+9fDLr/HtTDezOUiSbvYYm56Dm5krLsvjxkcpyXbFXtB3AxrZIhExQThhpHTl
 eQ4VEKjD9FUBLvQAmMkp4Al5YtAxr4zkfcYtTqw2AbvD+rb6f4ySb8RUQfD00wVns9hevO0fj
 IjIyWxrpsjKErvyEX97hL5uZitkVzLrehv9W+EKt/v0/Q+ltbnddzmBU7nBJSLGsIlb3hTHTC
 Lzj21D44ZU35cjxW+dhcRz/MTwr8Y2j9JJfBg7MKmoXiZ88NOla2/2TSFAmi3+FdWwo0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move dr_mode property from USB PHY node to controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index ff321964d225..709ff95a1614 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -105,11 +105,11 @@
 	/* EHCI instance 0: USB1_DP/N -> USBC_P/N */
 	usb@7d000000 {
 		status = "okay";
+		dr_mode = "otg";
 	};
 
 	usb-phy@7d000000 {
 		status = "okay";
-		dr_mode = "otg";
 		vbus-supply = <&reg_usbc_vbus>;
 	};
 
-- 
2.14.4

