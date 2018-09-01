Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B130C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1029520841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1029520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeIAMZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:20 -0400
Received: from mout.perfora.net ([74.208.4.194]:32889 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbeIAMZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:20 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M8Pa8-1fiLoO2M6M-00vzpy; Sat, 01 Sep 2018 10:14:03 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 32/34] ARM: tegra: colibri_t30: add mcp2515 vdd and xceiver supplies
Date:   Sat,  1 Sep 2018 10:12:46 +0200
Message-Id: <20180901081248.22639-33-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:PCooBjie54IKRIJUHybA4glQKcF9T/N0po0kMCnS87FzqSiaDzV
 gGSSLhLeQWd9mUULm1vvECps1pd2G0eFwycBNoZnl1C1L+t5Lz2OBD/GjwITSiCZFXxMnxc
 aA3DZboHDTlsp/2AyaVFsbmGOqbaDGoPz/1h6/UP5koRa5mrF0s6em7J9YjQtjBZxaThXJ2
 G5dl1tZAvArDjpFUZnV4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eATmTcBd53Y=:jmwDrx+0XeSjX+oZmJY6Lv
 Hh8NqZj2Fp6ufku4nGrl83jS0I0zSz9ulx1s40fi1yYuOstSXPPmDkhHwcMiNEgKU2H0v6JDb
 RVhVF/3ffLz+TPNJ0uBlomeetoYLfAfhsf3rdp/NRDYLHcAG3w38Jq4YfU7sToM+3P8KmcF7/
 z56xlyQfz+KxKwSu1yXbiHBBDP1Itkx4YQTs6hLVC3o1hd2N274GRq7FjQWSJzXyPmU8MhzSv
 PzK0B8TDDG0qt26I2BJS7viic4fom8X3C2/l7/t0SoksYiKQ2cbgjWg/mfOTNd5EIof6y9VAU
 xsEvpaOjcTDpaQmwddeADA6ZFSfxza+RB5dboO48fJ0dprzKkbRAW5B9SVZmq1zzUgtEJkUAM
 pPHfozfjbLRdcSphWOHDuMbRskZKQJ9MAo37fwy2/TOy9tHPFmfI0M0TuRJKTVwWVBowFKeAd
 qEryOmu8ZAz2fux8tZirccpgmpvL/2NQUELRpfLxvFIw9EjHNlSZP1PQUCuPkiLRHnUpb5STf
 CyYz4RkUBu+Rg8oPTAJ6r5SvpRo8wcUeQO3rgxOon7XmaGB5pM1jAxdkmhIRBtdbyH0mfNT1T
 zXbxJm2U3i9f1fn4+iTCKstZ0R2U3c+NOHtP2xCee33+RCRjiJl0kDw6084rbbaII5f7euBr0
 HMnIsbNVOQeVAgRJ13s+0+4oec9ujtXoppoAIawyhTAPUzXhCAmrdLqTOoWrxgrqfHV8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add the MCP2515 SPI CAN controller's vdd-supply being the regular
carrier board's reg_3v3 and xceiver-supply being reg_5v0.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 618a4b3b6bc8..9985d0a91f69 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -88,6 +88,8 @@
 			/* CAN_INT */
 			interrupts = <TEGRA_GPIO(S, 0) IRQ_TYPE_EDGE_FALLING>;
 			spi-max-frequency = <10000000>;
+			vdd-supply = <&reg_3v3>;
+			xceiver-supply = <&reg_5v0>;
 		};
 	};
 
-- 
2.14.4

