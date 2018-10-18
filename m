Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B74EECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB4621476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB4621476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeJRTPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:15:12 -0400
Received: from mout.perfora.net ([74.208.4.197]:37223 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbeJRTPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:15:11 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LlGWu-1ffgz01jr4-00b4L2; Thu, 18 Oct 2018 13:14:24 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LlGWu-1ffgz01jr4-00b4L2; Thu, 18 Oct 2018 13:14:24 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 3/7] ARM: tegra: colibri_t20: reorder pmic properties
Date:   Thu, 18 Oct 2018 13:14:07 +0200
Message-Id: <20181018111411.26623-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181018111411.26623-1-marcel@ziswiler.com>
References: <20181018111411.26623-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:45jbjI0xri2Qj9ioYbOT/frDydSzIoadi8O3WWZKyVTyxGdbIdW
 UzIofpqJx/LKV6IFUpNE1EhELL/cpJwHLzEBQl2pSaWdHGRepBVVuIbXSN9VXrzzLpZxipg
 Y2iAjLHYfOIAy1ANe908DlpogzwIIsvHYtNEt7CBTGl/yqgJPFHO5P+LCivs8KYq5oZzR2n
 NbhRYeVZJEsFfPVQYycJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GCr+GZ+grHw=:DD5ZWLV4GA/bciIYDOwuHw
 L3cQD4Ar+LlYpvOthsmciINcEi4OqjSb8nR3EULly8Bo+O/BlCi+gFOCP3Hc9NKYSJ5Q5AU2b
 3RH4GSvD7fmMduG9T2JY5E0pyggWmtD1JF8pkJZ9AGLHbkFf7Ez/TUE8JvjRnT9cm7yz65LYO
 PU+JF5ghwUY0g68mXAbyYlpOuAS9DOPaxWutK9VfkwfsOgT9EiI9WJDj4PAiCkhFQcoL74o1m
 Nilqnm0dyVLPF1R9ZLd7v7g5uYfKrovF5OUDVS2w7ibh/LQqukfKhnNAL5aaVlHj4yICGph2f
 lYq/f1PgSKkkjhJknXuIf2mHWWZNfNw3q5l0riKMGmuvc8WMDXlk8N1zPAlZEMJgfMC26V07j
 cyWtMyBChxJC0uoDKeKZfxx/hW6ql2JKDeohJemJ9aIodUrvSFkQ0KplWp0b4Wr+DjNYd+NQ1
 B3EZEccjHZo03XYoHYDW/5wuG/6aJN6gQn191OxRyYi0FQz1Nu3VoURIdr4ZktX0xbhEyRq2r
 me0+x460cWMINxEVZaIOauNcd+ZXpF6LP+Gkn49fQMUMfIXaFQWdWNxRx2F+i2mcxRtSp6uu8
 LgAGJom+fCo/ChWgA7FZ29YvR/eEt5zhd16GQZhLvO5VnnG0ynTzMHNfCopVHp3CsqUUa4Hut
 BAr2x7YRkArX8K4R5zQEu+j/YwGpjfofBONLfJVucMO0UaJNsvXZjEBRJKgy/YesFb8w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder PMIC properties to be more in-line with any of our other device
trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v3: None
Changes in v2: None
Changes in v1: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 6162d193e12c..d3aba6501510 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -475,11 +475,11 @@
 		pmic@34 {
 			compatible = "ti,tps6586x";
 			reg = <0x34>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-			ti,system-power-controller;
 			#gpio-cells = <2>;
 			gpio-controller;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			sys-supply = <&reg_module_3v3>;
+			ti,system-power-controller;
 			vin-sm0-supply = <&reg_3v3_vsys>;
 			vin-sm1-supply = <&reg_3v3_vsys>;
 			vin-sm2-supply = <&reg_3v3_vsys>;
-- 
2.14.4

