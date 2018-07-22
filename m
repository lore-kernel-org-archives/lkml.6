Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B058ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C02420881
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C02420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbeGVRrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:16 -0400
Received: from mout.perfora.net ([74.208.4.197]:39473 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbeGVRrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:15 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MOh96-1fcJTe0jl0-00661J; Sun, 22 Jul 2018 18:49:48 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 02/28] ARM: tegra: apalis_t30: fix mmc1 cmd pull-up
Date:   Sun, 22 Jul 2018 18:49:10 +0200
Message-Id: <20180722164936.20581-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:udMLPhY5wOSUyT1MpnSFmDqYgBA0dYsaIeG62ifvx5pQsAkZnE1
 KRjzzGB0AGpcDh9PqiH4/cg2sPiozulBRv6w1YGJ4a0FtRpuzmHJrPJFEgh+Uf03IyCeoPa
 oPWetkNy8Lf9BiAVL1VMfMOffdMI/0AQvjl/Ue/6UWknTug6hpsRiYxKxCfEby6uGfoh1vM
 CG4oltfz56M8/WaYOiWVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X9HMvVbi6yk=:DjwIkb9s24wvj5VXT/h86m
 VyEOuOCQvu/0nrFc+juX4EfxbiN510ak5Yb1NmP+Z6p/GBeLT9keqKaM79po50WXfTlSlBS3V
 t1oDohcXs0u5+Qqk7XFNmAoiRvirijRwJq4z+TlSVmXp706bLN0LpDJTtOW/J6PEEoCHMWkni
 3WQMbI2C2dhpuiWXzVdFiPgDhCmtbuwbZrua8w4Oj3RYisL5jtFXHw6xI5ZWR6OGXmzQJjLdJ
 U7AX1omRg8zmBsiXwLryBN8I9CwitO8yx59vPyBGF2MqtgX6lY7RM31uRT+FwRFi6ar6AWhQL
 OJ9ZKe6qinTOqEYTwfhi6gR4ihUf7g0K+7qPHQZ+/BnAQpUJ1m1bN/qrQe0qTvot95bf33yND
 DHeVzwkG610dUlVYzSBH+wjCUtetjNyJj5H42PUU+14UHtRfGmKEakqaDqlBSUlPwIV8lc0XF
 Bh4X+mrg8vrwRa3qlGKZJUpZv6mL34dfxdzVc35Z9KmnaWOfXE9NFVWsbfvrw2+QfooSjj1CL
 Azq33aYsF6kxgvJaONZ7VMdJfxKnU7wTLLd0jy4f85TVK44s6mWMi+O8aUAGL0KJaet5f/5p5
 YmrgICgJSWnzjob5KkLSrHgzZzaYL6scrgmIZiTaTyx0RRds0a6Zi5JvAjKAvgWRO91QPi4pZ
 2Xk9EVuiCWCStzCVSVwPmvxlCxjDAERI2T4xCO1MTK2Kodj4EHyenRYCykesP4MlY/oU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix MMC1 cmd pin pull-up causing issues on carrier boards without
external pull-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 23ffe6a3bc2d..e7f3dd52a209 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -171,14 +171,14 @@
 
 			/* Apalis MMC1 */
 			sdmmc3_clk_pa6 {
-				nvidia,pins = "sdmmc3_clk_pa6",
-					      "sdmmc3_cmd_pa7";
+				nvidia,pins = "sdmmc3_clk_pa6";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc3_dat0_pb7 {
-				nvidia,pins = "sdmmc3_dat0_pb7",
+				nvidia,pins = "sdmmc3_cmd_pa7",
+					      "sdmmc3_dat0_pb7",
 					      "sdmmc3_dat1_pb6",
 					      "sdmmc3_dat2_pb5",
 					      "sdmmc3_dat3_pb4",
-- 
2.14.4

