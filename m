Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B8AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5ED20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5ED20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbeGXLta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:30 -0400
Received: from mout.perfora.net ([74.208.4.194]:38521 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388583AbeGXLt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:29 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MQg7H-1fa3ce0bFt-00U3sZ; Tue, 24 Jul 2018 12:43:33 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 09/15] ARM: tegra: apalis-tk1: reorder backlight properties
Date:   Tue, 24 Jul 2018 12:43:03 +0200
Message-Id: <20180724104309.21741-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:54tF72tQSxGXek1nauQ9sPRNPusKLUAFDSBKytJ3GiCrRM5Oi2D
 MZ1hLk1x6E411I94nvVw5HayZF+Vf0n8Yl6jVbuwJWcK4r6pQ3mi/1c34pqcoPGCCPObP+q
 pjAocCICyllqpwt4FzzlI57R7tyfOTuAuB6g1zCAEHSNCmcpKhOGc/Pob70bsu/LVOjHk4U
 IPFCD4zmLNLmPe8SFbi9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UQ31p/meqqY=:6bi/DsMi40og5oDD+eTJw5
 nMn8ZkYourRSwBbR8zcx2aWMnq1Cukj4MndmLwf3pEGCSDN87ZmuqvQuLGt8XH+sigdRPzaEr
 8ZZSn7vUjqzI83RyOYaemoHUvvK6y/UCSaukgTMaV1APYhD9Pm85mvWInfsXuFJH56szhGmfJ
 42/yQdk1IB1b6SeSilTjFmJ3l0EERnsP9pTgbCoOMDxcqhI4SN+VRRn6XmYK3bTeeXTA7Dn2P
 qA6Tqqo9PqNBgUwRSmbiEEgeZsCl0oTTJWD5ZwrWrau1l4C8E0liEFJkUHFTn4TnDVoWEeS2y
 6t3KfyPnOdReEkkRClJzufPpTLxvcXU797eee1Oe5FTmVXU0coaBsn1Bnh87IaYiwOkzkkleX
 5Qn8+1yv9BvihcPrbT00E6OVfROrkP1D1oB0SaajiW6lcb8+LapWfy9Ybd9Qfkeqj5htuaH+b
 sLmBYoTysl0zvhEayCNp/K32kR4GbSPaoIf8Qi3TjqIsHHF2HpYRzZLxDELjVk3rhswAsJIod
 uOfS7ckACI/upqSrikScHySEgoAy5k3zx/SplUY9V44tlJqK7RrZ+a32nZosTHeaTuSl874aW
 mVpA2nScO3wUqg+O1itpjVj9EHNfqL/6SVgbxHim648fhS8Tq4CoE/2GMvXObEKjw4giLqsll
 XwqB3k3hxOhJZ9exZmahgILZWWQc8Cu+nadJeDrgOGjXbvC6fC7e9R56yOF1cW+r2ZZE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder backlight properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-eval.dts      | 2 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index c2e918d345de..d9805fc97f5e 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -228,12 +228,12 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 3 5000000>; /* BKL1_PWM */
 		brightness-levels = <255 231 223 207 191 159 127 0>;
 		default-brightness-level = <6>;
 		/* BKL1_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(BB, 5) GPIO_ACTIVE_HIGH>;
 		power-supply = <&reg_3v3>;
+		pwms = <&pwm 3 5000000>; /* BKL1_PWM */
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index eebcc013771e..aafaf2c3e195 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -193,12 +193,12 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 3 5000000>; /* BKL1_PWM */
 		brightness-levels = <255 231 223 207 191 159 127 0>;
 		default-brightness-level = <6>;
 		/* BKL1_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(BB, 5) GPIO_ACTIVE_HIGH>;
 		power-supply = <&reg_3v3>;
+		pwms = <&pwm 3 5000000>; /* BKL1_PWM */
 	};
 
 	gpio-keys {
-- 
2.14.4

