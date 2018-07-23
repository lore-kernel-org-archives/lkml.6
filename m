Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3BAECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C578320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C578320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389137AbeGWNib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:31 -0400
Received: from mout.perfora.net ([74.208.4.197]:36903 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388362AbeGWNia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:30 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lw0KJ-1g4EtL16rN-017ovY; Mon, 23 Jul 2018 14:37:22 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 09/26] ARM: tegra: colibri_t30: reorder backlight properties
Date:   Mon, 23 Jul 2018 14:36:40 +0200
Message-Id: <20180723123658.980-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:K6rvKfG4crYEJ2Zxp4E38X431SNSXMTpKOl1nP2lyJ0VsOyl6db
 8yOjhb7hnQC8Z+zqd2nQWKF1tLmX0s4T1+rMckpuVHElvEHmHAVBX+MZ8fXyPmmHifkeM7x
 tsBjwxNtavCpJEzvC3ek6uxnTwi7vwalxpaJml3shOVf94ZwYgftPzIrQ7hhYJUuPhorYaV
 we0RDHEKTcv7tV1D39vqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sEu5/vWdLUU=:qgGOhnKOg4F8xnNy7mjpSX
 RRVpdVO60kuWFLTXoVjoIDIGlxq6T/yZPlQ1GqDs+j4cN2tiFZrmRRx0ncCKIwWShBe+47qH5
 8JpYnbdunebQLyBtBY9RfnXUBayGLE5nUz/aB6tMWPeHytMteqJ1M2QFRHoTRSIWAEa8VYibl
 63o2gsvAWQPdk3nQNP2OZR+uZJoWT2sR65ePFUbSXYvUcs+G4+1mLdHcAGg7kCPdNl/ZfqAQ4
 gZy/+fKgtp9gOD3w0ZsKBrV/LWnPk4wpwA89g+R/tyyxWG1rxPanWpwrd8j/eibpZs02LW/bE
 +25oqOAH3VDTzkzRcGhEp3Zb680GfbUpoUpQLRdHdPqVSSpZouF3eSUMd/RakZ0vjUuIVcHpZ
 nIFMg089H3vSXyFHpjzWY0D38KsXqRMtOND0i2vkH54cP+NNL+JlSLTYZ2CDkDS2AZZEhV+ZJ
 ipRU4ElIx9p5XftOV/S3Ql08N21i4p9QhMZGaGTA4HmtvrfyC+qaFaTBU+2LGN3/pBiye4W6s
 awp2uET4GsdrQ2A2vgmIbbwOaJhRo/y6UdJaIyxaetkEOfpTA4oLGglnYYfuVK8QdqJ8ASv82
 kdUPtr2QTJ5i4loPw0zKQKqWEZjW+iSHut6gjc15qXGrsapO2JliHvehpM1oDT50OmWYo/lHJ
 oEeCYYF53Sm0AF8W89koTGRXshrCb7twdt+NhNM648arM5wtY2poodBfcBpP3wChdSxY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder backlight properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 70d3a89825a4..a3c607d07a1b 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -127,13 +127,12 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		/* PWM<A> */
-		pwms = <&pwm 0 5000000>;
 		brightness-levels = <255 128 64 32 16 8 4 0>;
 		default-brightness-level = <6>;
 		/* BL_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		power-supply = <&reg_3v3>;
+		pwms = <&pwm 0 5000000>; /* PWM<A> */
 	};
 
 	clocks {
-- 
2.14.4

