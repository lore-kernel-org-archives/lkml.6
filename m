Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9D8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E81F20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E81F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeHaUrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:03 -0400
Received: from mout.perfora.net ([74.208.4.194]:42067 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbeHaUrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:02 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LaDv6-1fUv9G3zzC-00m0IV; Fri, 31 Aug 2018 18:38:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 06/34] ARM: tegra: apalis_t30: reorder host1x/hdmi properties
Date:   Fri, 31 Aug 2018 18:37:48 +0200
Message-Id: <20180831163817.23970-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Wm1yJe9tWrcDt4OaMURCBL4q73PycYyciJLsamTkHw63zkoZHuq
 Jfw4C/D662ZT7ua+ujCnLqtuNTgBtj4ZYgqEA6+sZGy5X6MJlZWDq6rc9fcOriRWQl3+7xb
 lz3JhUp+pA+hI89r/4FXY7aE44yiXXtMih5meUymTNlygGrsen7KEizURqjjfCvyGHRk73k
 SJ3ipjfhMG6Zv4Ps76PwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vzspGBO91ZE=:QSwEuOAT5+oqxyfcgQMbpO
 j0jjXexrCQ12rfGsdnLNrIUVwaHL03Lr2qOU2Ablz9C9zENZNSbDE2gNJhChhPsd09beIy67Y
 CGgjehl3wJBfRxuh65qILpxC6eqagaBZIggRMLf0AURcU/WpS1LO1qBDm2jidmB+tlwK9diIB
 dwsoA2XNNyZK6qwDYmh2mXW0P0GN54lGbJh3gY2UGjk4+MAkQl8bUQE1dr2obFegG/WWE4UE4
 UxEXs5TzV0IJVBjeoHPvUmucii3YPQY0obgF7V/X/9+FvQhw8d9LCal8OVB1yszes6BbAlsmF
 4kOxbsdi2GoZGWbtJStpdO3aWGE7+YVkMRjEDLgBO5W8YLRRQRCI8eDK/TSE9+2VysIRcprHX
 W3e+k+kPld4X+ZjJxliQ8x5gAS6moMUT4QutGF78DM20dlbKcqNsTQILxSY8ACm/m1BmURCgj
 MhiXiXebXZVs0VZwPyZ+X5Wf1SZUjl3FD984F1pFhZitlaCuXboEcPtDIXbO5bQSWZxC5BbtY
 4I08bb4yZPghMdXlU319KHhL7mACbBa+ljLdDxiyX7khLjh2zMT6cswH6jfjOdvdXWyM9bd3G
 i1wFg8hCpKaKQsJ4T8LeWyd3GnME19W6Z0/G0PcxzeQ1bTUp+Bp2a3PPXdNQjhk5O/lK8anRc
 +pWBZ6NEBke/j7dKIBCDvsjcRyVO4PHklNGRoaclZe/3E+gBFxRxsLFLL7/9Hzw+iWy4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder Host1x/HDMI properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index c810c044025a..648db524abae 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -48,12 +48,11 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			vdd-supply = <&avdd_hdmi_3v3_reg>;
-			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
-
+			nvidia,ddc-i2c-bus = <&hdmiddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
-			nvidia,ddc-i2c-bus = <&hdmiddc>;
+			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
+			vdd-supply = <&avdd_hdmi_3v3_reg>;
 		};
 	};
 
-- 
2.14.4

