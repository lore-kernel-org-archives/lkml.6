Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF81EC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43B520841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43B520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeIAMYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:32 -0400
Received: from mout.perfora.net ([74.208.4.196]:36491 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbeIAMYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:31 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M9Yfh-1g3T9g1Eb9-00Cwe7; Sat, 01 Sep 2018 10:13:15 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 08/34] ARM: tegra: colibri_t30: reorder backlight properties
Date:   Sat,  1 Sep 2018 10:12:22 +0200
Message-Id: <20180901081248.22639-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:RngoWeBwGY2yd4/w+wA0gLMinOKRMS6Nla2H5pta8AiH6XTuCPr
 SM8hL6mrxJgM8anMWZ92oaBVan39vEAeL1eppJ/tczaulyqAi1qHkA/BKwJhi1eFuCIWpf2
 nmwvD+MtAL3++nc0TPFoVgOatdBwUl9Jnz8/WBUmX2e6vk1pqt+QUPvuxXyv9xIFXZ9/E6p
 XOsLPmDNd1CgQZnLIa3bw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+H5pC01yTOs=:wQGxvqwkVKu90XtO3Y1Vy0
 oVNFnyuaXrnpKUPuALkuVaRx5YuVd+JP7zUsQ7EAuuXMQHNosa9YeDskgk2Khtktith728jzM
 4L3uRpbL/krdghd/+xmE3TJRPK7azePuNb9nk68WRlErMHVewHGPv3el6tEZ4Mpt8shTYJDi7
 kZ9ZtyqG2BA1+deySHExsb1YYA1TCiGTRk1luvVcjylZp4Fj0cP0+LpKDkP99ZbgEmadAceQb
 wdAxdGScveQW1iYZ7ZLyOWmsd+droG6Jv2CQnVCBykUX8Tfe3WPPjIjqMRigWUlHZvba+JOIC
 YotOCr5B3iRdih77PXlx5MTvaS9aBMrioXee7j/GH7TjXPtTdQFjjRkp0p6UNYK/Bg8+AJsJf
 HTTSQpRo/O+KUVMnI0O/am0QBvNyYE0posEPUJbJMDfRY2oAKhk6kO85adYYOPa05JdQ7xWSq
 BZn7TL3ya2OW1LnetFv28tMxKsEXSKW4ytoRRWN96WPLMpo/B625mERxcs7bRh2ULzGIBg2aZ
 tyc7X7nm4PLY9XneB7ihPBVGZgFxVN4n4qj+GvMZNhJvL+ZyEEqudvYJ/A6aluX49bOUho6Kl
 hO/x2cDtbXASegMxJIUWSWTxyHqEVLhLvLhohXcKsNhccRhbuFi6OOG4AaBxxj0paxULLI4K1
 rNiwGQWEBOxXQgbOTHPUerVOXi0omAsX7pMHBjHjZ3y212d3AOLkQyIpFo7v7AysUS94=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder backlight properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 709ff95a1614..8c492daac165 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -125,13 +125,12 @@
 
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

