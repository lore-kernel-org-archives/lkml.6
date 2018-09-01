Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA90C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEE320843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEE320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeIARRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:37 -0400
Received: from mout.perfora.net ([74.208.4.194]:60503 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeIARRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:36 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LwY1Z-1fqHcg33CZ-018KUT; Sat, 01 Sep 2018 15:05:18 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 01/19] ARM: tegra: apalis-tk1: add local-mac-address property
Date:   Sat,  1 Sep 2018 15:04:46 +0200
Message-Id: <20180901130504.14318-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:RjYZmIBXgLWXT6D82hxF9P1aKepvRlti9iTVJ7CjTzKZDaF9AQp
 4BdNXSRRj5tl3cb00RpHjxgkc2cCSdcM9tLTs4faMlkX+HeTBA63k2tBfC3IoWO9IeSkpXf
 8VStPcY/vgoYXNxwQ7WJVvk+IM5S5yBmBqHZOoYWNYuXGJnW4kjPedtl/pnKSoEGN9KEBIA
 PnmHKIT9Y0rc4JiaMQIuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T6B9dNRdAd4=:91mO0LtipSPmTeGWCni5PB
 OKBTTWTDcUv9SZSePpS1+uRHt50r9lYBms7IhTLNRJfoQHHjVb/Ur6iA9V6cyrPYO8pfQC16y
 u2+aqw0ekkvGExMBe98sJwXwYZAcB0HsdRYxDp7XtSNEZpqHAkc8HvFkwYxvLN6ryBZ0nto1B
 mP1d9s/hRU+xiLd034NI6kpa8VDFgO1wVwCnyBUf2ADAX0YJCthJW3B0ryucJwQ6OMEuRZewu
 Br+mN7LgrhBhE6K0bUE4T4gc/kENdkYRtTAZEeYiu8BwhLQkj/jW5J5uOBsbJdDTaHEiyuVeT
 aWsjQ+AUsBIvmxcjmeSNyrNLKBa2NfoLNzeOvpovNWPk66w7+rmZU7FHOmFoebeE0e108Q1ce
 e2+PrSq95kQXn/WXHb22KYSId+TzcEPXChKDqXHU3RMyuWAStFUdBoLd9SaO49+2NxV+qKj8h
 TiFE47SFf+5Esjb1j+c5MEJ9GS+s760Zy7iQ6tknC+aJ/9bzp1DVoJQGez+y5Tw9x/XGlJApC
 rkYNStY2hvCfAGZ1NZe77HGz3QZ3YIWPgo7OqJ6mA9X1+7qJ/Em9V36qt/TAC8jP+WwHBDzIf
 zG2KMmMQhWkHIInLmX/YDaCXhbouy+2z4HjUycDgN51WQ4U2i7LEqtOlmRVHpJbOd7LO3+jKP
 q2dpVgJA2M8s45yMa3Mzn11NHWFHDQ5oeph9Q8Jxa76sjDQT13Y+5IMEsKB4POEdEpIA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add empty local-mac-address property to be filled in by boot loader
(e.g. U-Boot).

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 5 +++++
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 573aaa50fff1..09e3641258ae 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -42,6 +42,11 @@
 			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
 			phy-names = "pcie-0";
 			status = "okay";
+
+			pcie@0 {
+				reg = <0 0 0 0 0>;
+				local-mac-address = [00 00 00 00 00 00];
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 0f0d4a4988b9..5e7ae5e92fb8 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -77,6 +77,11 @@
 			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
 			phy-names = "pcie-0";
 			status = "okay";
+
+			pcie@0 {
+				reg = <0 0 0 0 0>;
+				local-mac-address = [00 00 00 00 00 00];
+			};
 		};
 	};
 
-- 
2.14.4

