Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BE3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF08F20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF08F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbeGVRtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:49:49 -0400
Received: from mout.perfora.net ([74.208.4.197]:60595 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730223AbeGVRrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:16 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LimxX-1gHihH0tRd-00cy7m; Sun, 22 Jul 2018 18:49:50 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 03/28] ARM: tegra: apalis_t30: pull-up sd card detect pins
Date:   Sun, 22 Jul 2018 18:49:11 +0200
Message-Id: <20180722164936.20581-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:SudBfemKvTH/jO2hzjbqgvjqjOm+cyiDYVVKChBjuzuQb5kYOJr
 c/lEt7WAsvq7LZ8JH1hS4nu+5ZNMQeajDQkOjJO3tUHkfosx84WuvyqaTJ8WNrPpAeLXX7G
 JLDfwZkhCbp1UNMKY33DZQAJbGZylQqlAbp0jo1VrmQibWLiwoL23WCV6qlLYyTS7PvSunZ
 CSldrrbrk0witjzCYcShA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DD31oYuHr54=:/ioVJvJMGvHHzz8l6ReiR/
 3iOjk+eqhErGtd8OWqblL2FSSzv9H7eHPjTEYHNAi8YRLtfnlYLRuIg7GzeDYpQ290ErENHYp
 0iNgR6OQvKZ0Ya8GdTbtFT4FOcrI33AyUEcA02137QDxobVZbduRRRV16UDfYCbT3CssjsvSe
 wRTSgYorFuE3Uy7BSsT5/f4AI+P3ITtRP44n2Hil7fR1wTeqAidmXy8ed5RTXxclTEUKZL2s0
 WWDV2TByAa5RiwkcAQg2jKSUzp/b+Z8YWsaSPYawi+/OGfgJWr8FqTIxTejyZqWmpl1NCq72C
 +QzBdKiHv/co0pEGjUK8HmJNFCdEX0fjZ1xWarpnZphNEzzY5wDJ7/CwQXjHB/qjEP072fnlh
 n5Oy7H1ry4/h9xDRAoMnYHeYThCkmiiZZA75V840vgp1b1uiIw7nsX2qcFdDdTRn5cgSkxRdZ
 NYTYkM4whHBPwUGcEtCRQbHrpEbdZshhLXJBZSYgMoLOqJ8vOKgC+Fp1VDH82BAdFLXQ/lLzW
 K+Gm1ZzA9Kf2Kl+dFfPL5CZ3d3UCOri7iDbWBj5kA3DJl6ca/mDst8taTnT7Rq39oXt7wids7
 igB55gdG2g6KKtGJn75RQjhcJTaR0p/PxmyoV/B0g+u4cNWD+kJg2cWaX79g1jZZhZOdc83hk
 FguPlD1ukkACziG2VjfiZywnOgKBx1oIBBT8B9+3JRqxe0LV01JAR+kiwhis3hQfCGCA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

In order to avoid any floating SD card detect pins as may e.g. happen on
Ixora V1.1A pull them all up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index e7f3dd52a209..f4dc7e77114f 100644
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

