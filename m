Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3A5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E39A20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E39A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeHaUrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:07 -0400
Received: from mout.perfora.net ([74.208.4.197]:45305 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbeHaUrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:07 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lalt0-1fTHFr0C1w-00kM8b; Fri, 31 Aug 2018 18:38:35 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 05/34] ARM: tegra: apalis_t30: annotate/clean-up pcie controller/port nodes
Date:   Fri, 31 Aug 2018 18:37:47 +0200
Message-Id: <20180831163817.23970-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:LyWEpCOPnp31vKFp6T2fAOKyTSloy3//JVV/p6LJbXRUrb8i/h3
 x1oiXzXf1c1yFFBk5tScsOKQCxwL1q9UduPCdXlCbpwXwComdGtHhyDqSmpWXxzceAwGN0e
 Ule/PRLpdfQARZKLgGMENjueAAmsAl621MYRjmySkBiFI6HptmkaEa3PVj5BBm/UbzxrRu2
 uutHSyM7J2y561/hwcYtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ItJgjGLjSuI=:BtKW4nhsnYepdkhd5+qt/v
 9CzInaVbmIePzWC8LXX3JoEUevpgv8+Mb1WWF49fzJm6xt7vRK02SEJmBv7n9XnNjXgIEhEGb
 mJNx4Ut7sLWtXovCQCQS33+zCsMPRYdfe9LyL8Ok0SiOtHX128rz0WwZVuJJ6dhlbgMzaDbBd
 hVvev0D2EaWO3Y6fclQm9bPrcrZD7gZj7Y9zYYzG1Gi38sIEIi8yNGZVzAhkNqoASCn3XxSmW
 GtN5eepXfLosACJAEsw84lK19Yfy5XY3IcEZ13LklcPZpengsawFm2jMSN3BswFWY+zFzJTNC
 tunaMxUn3vUXFmUARmqKlH9hqhRrIn9S1xDjMalBwRdep6qNzDXzbT8HjARxuaFa5G7a3bbLD
 fHmChuJNOhKlrD0sOH6JRSgN7bGShpxM/EEx5YheS/O6mBW7ydZNMSmy9u88fWgjtr/3uTPtn
 80ZmtFBrbRwpa1lAmKjAIg8yoWUlIFZXAlfOiyn3xoNYg2WxkMajwhjfv+U3vefQgWZwtnPzL
 d5Afxi4I6XtrpAKJ2in9xAzekYGHi3LycBflSPkhV/5o02IjfWvnjBcCj7s56wrXxL6969uhw
 RTQArApO2trxytVIQb/zFfXz9mJVvHhIjYLmZyKS+XQka9c6zLg3TMRKgv6pAOBnjZf0vqxkD
 qFVo+VBrjMBKCnKXYKxY2/wuHLtB02xH+pPG1jLCQIJrKxDVy1+ug0aJTIk1scblI7WU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate PCIe port nodes and clean-up PCIe controller/port status' with
respect to carrier board vs. module level device trees. As port 3
connects to the on-module Gigabit Ethernet MACPHY it is always enabled
together with the PCIe controller itself.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Clean-up PCIe controller/port status' as well.

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 6 ------
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 0dc85a20bd45..e3c70e7d8d37 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -23,8 +23,6 @@
 	};
 
 	pcie@3000 {
-		status = "okay";
-
 		pci@1,0 {
 			status = "okay";
 		};
@@ -32,10 +30,6 @@
 		pci@2,0 {
 			status = "okay";
 		};
-
-		pci@3,0 {
-			status = "okay";
-		};
 	};
 
 	host1x@50000000 {
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index fc279a073ac5..c810c044025a 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -15,6 +15,7 @@
 	};
 
 	pcie@3000 {
+		status = "okay";
 		avdd-pexa-supply = <&vdd2_reg>;
 		avdd-pexb-supply = <&vdd2_reg>;
 		avdd-pex-pll-supply = <&vdd2_reg>;
@@ -24,15 +25,19 @@
 		vdd-pexa-supply = <&vdd2_reg>;
 		vdd-pexb-supply = <&vdd2_reg>;
 
+		/* Apalis type specific */
 		pci@1,0 {
 			nvidia,num-lanes = <4>;
 		};
 
+		/* Apalis PCIe */
 		pci@2,0 {
 			nvidia,num-lanes = <1>;
 		};
 
+		/* I210/I211 Gigabit Ethernet Controller (on-module) */
 		pci@3,0 {
+			status = "okay";
 			nvidia,num-lanes = <1>;
 			pcie@0 {
 				reg = <0 0 0 0 0>;
-- 
2.14.4

