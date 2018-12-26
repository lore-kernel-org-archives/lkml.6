Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E05EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D778C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864018;
	bh=ZZ1RdygRSCYy79Zcp4TIkZadUMDonlgGZb1VdQ63aZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vTzEN6LPil+KFwln9KloJZ9BEU1v1HEk25jFdTMpC/Y62W0nO/4/4PDYQwm4SUW3b
	 jeN4XrqiPAWb3loM3cqc93VtA0mdMq+rZudY+gQwks7rCcg7ytcPsfzKQ7+xxWWP4p
	 +dTsgZd8HV5LsZUbg7H8D2bnkplmg0D8TGO6CgYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeLZWkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbeLZWkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3720B21741;
        Wed, 26 Dec 2018 22:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864004;
        bh=ZZ1RdygRSCYy79Zcp4TIkZadUMDonlgGZb1VdQ63aZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSbtX/rE/m8dZ+FGGcg4Ou3v0YVIGadDvGzUjoYgvkvWpt1WH8YcIZmsvEJ07WgAu
         fQmMYwHuoRhxCopcznLSuV8xJlm4VvzTjwQY4uehLbAMNB9yK0ITO/B+CnvzD55lTc
         D3rvoDSFLzl1yBxNJaWE71FK5v69G+h45s8QzVO4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 06/59] ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock
Date:   Wed, 26 Dec 2018 17:37:46 -0500
Message-Id: <20181226223839.150262-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit f15096f12a4e9340168df5fdd9201aa8ed60d59e ]

According to bindings/regulator/fixed-regulator.txt the 'clocks' and
'clock-names' properties are not valid ones.

In order to turn on the Wifi clock the correct location for describing
the CLKO2 clock is via a mmc-pwrseq handle, so do it accordingly.

Fixes: 56354959cfec ("ARM: dts: imx: add Boundary Devices Nitrogen7 board")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Troy Kisky <troy.kisky@boundarydevices.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7d-nitrogen7.dts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index e7998308861f..f8caea16bc2d 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -117,13 +117,17 @@
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
-		clock-names = "slow";
 		regulator-name = "reg_wlan";
 		startup-delay-us = <70000>;
 		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	usdhc2_pwrseq: usdhc2_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
+		clock-names = "ext_clock";
+	};
 };
 
 &adc1 {
@@ -430,6 +434,7 @@
 	bus-width = <4>;
 	non-removable;
 	vmmc-supply = <&reg_wlan>;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
 	cap-power-off-card;
 	keep-power-in-suspend;
 	status = "okay";
-- 
2.19.1

