Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BFCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119B320658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119B320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeHaUqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:46:55 -0400
Received: from mout.perfora.net ([74.208.4.197]:57519 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeHaUqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:46:55 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lykwj-1fsnh41QRD-0168dm; Fri, 31 Aug 2018 18:38:29 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 02/34] ARM: tegra: apalis_t30: pull-up sd card detect pins
Date:   Fri, 31 Aug 2018 18:37:44 +0200
Message-Id: <20180831163817.23970-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Yr70LlBH7KTK6Fg4ERaBbOczVCT5iNut4bGUPX+LO5ilWqjG7Zg
 3NsR0zvvT/A76jD5NOs6EJ92RZEjaMLmiJVD81a/a90m/398YJECo/izt62PbXqkBHuFRsR
 qV1xSsjudSI2OPo4zZnXzsgpPaMjJMrgqNRuvv4+OGNd0e2m9MGCFJRLSznxFKM/NstY+Kr
 z4MBdJ+n4viTEQVby3v6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:05wAse1YdJI=:gvzNQ9VtHdiDTp88oe4zWV
 os0ppFNFfeKALcP+BOXlMHgQkk9hVzk9f6nCWiUAxmjtPQ4toMk9voHCIryTWbPlVQVRSQj5O
 8Kkud4+REcgPOZqAQH5R4s6l2MvgC/LVVbT2EHFsJQf3asQ/SoYO+1B6u/WEQGCOBfzZzjT3r
 4nkpia3qRnZ9wVtLS5TNpk3kgYt1SivSK+HNA51iOZUtRfpKWNmGORIDyedXG3rvp2+9pEqQn
 2eEu/k441ZML/3vOhl0EIrPMmlCJQYMF3ITHoZ9Zh3JV1uuaL7eSlMH6qoKSw3FplkMYb91x0
 FCsQlXf+rp7UjX0PLcOV1tEodMT2mYmFjTIr7YR2PmfYBOsyfkVL8oi0DwfNceeTB8Y0v8l0m
 3ewrEGvkvXTqzWEJ95CLCelkEjGp2Pzryx3RuUWOmeRpz4x7d/dn4GfgDbrqMEqyqOmbLG+PT
 Ecs9QXZ0mmVpZ9mi0PdITqhScIeQD8nrW16f5r39+lE4VK5LuAM0/EVitkehTeVgaYq5QouvH
 ZnYtDalhPm2+oekmrlN6Y+wgZCOjKvRVdlnqu4QyNRF9AiL8jlOnMCRs835dC7X4xiXA1Osiw
 JtuFAF//pJN56+KPTdO/qjA9VzlDVoWsR7O/kTQAE6j1qLOCb9RN6i+pKzMsEuD2AiLLMGUn7
 gG3hCkeQwDcWbXiJx28omxVkSqOvWkPKLLRs8j9XAx8uINZyK4gHE7Cb/JqVk4ISTOvI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

In order to avoid any floating SD card detect pins as may e.g. happen on
Ixora V1.1A pull them all up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index e749e047db7a..69bb11c31d77 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -194,7 +194,7 @@
 			pv3 {
 				nvidia,pins = "pv3";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
@@ -260,7 +260,7 @@
 			clk2_req_pcc5 {
 				nvidia,pins = "clk2_req_pcc5";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-- 
2.14.4

