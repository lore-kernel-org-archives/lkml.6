Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E09C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3AC20843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3AC20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIARRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:46 -0400
Received: from mout.perfora.net ([74.208.4.197]:54909 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeIARRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:45 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M9Hgm-1g3G4G0y10-00CfT6; Sat, 01 Sep 2018 15:05:34 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 10/19] ARM: tegra: apalis-tk1: enable emmc ddr52 mode
Date:   Sat,  1 Sep 2018 15:04:55 +0200
Message-Id: <20180901130504.14318-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:7K4LfWGGkDJwKeSL+HGq5D869EwqT1R8bKH7am/WDu7rKu2vU7Y
 8xPqOGU3TG2DZcVLpnmYBKNw4tx9pbaakSWyzs/IK4fGg+JHn+YmWgvOVDWdUB8WV9zrWi0
 nd4HlixEVoLwu+p5k84vso0KxUqn5fFc1VV5HxdlprGCNYFbRZcKOz4s4vC+0jPCuUqg+3e
 PJcZApkJyXyPe9fHQdOCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KLAuuUqoPI4=:vabklxj2CU4GlzEz/6Qy6N
 0DR0ge9McbAc2ZFoCVT9iiKpuPDrbHj0GdR5fiXjLcyVOyP96Mby0XdReueZCm36FVnYPGunt
 qVd9uB0ZkfEVusNZuWwAmWdXVAvXqS+IB7efJU0FQibxmLFCb5f7DFfmA2OFmHt9zNhlolzYj
 YbbUrCmgrdqHLeinM4DuTekVcjOZUWM5KsNXn09I4j22rt3/f3tV2JMOBZyuTyLsVAtqYNYJD
 x/IEXqN2NHbvODfeOP7CsXME0E46HHyeizMDhO4lj7T1v+u1W094HTHTeDEwxv8jGCBBDZtfO
 FREdVo1hlWwFk57uduCoKvUzgzaLbR4b++5zQMgvTGr5QzkMM6JcXFwyCsy2eB/kv90hx2qaJ
 oJTtWo2NLqju7iFZ6L23BHg1IO6GgUYFHw8YfSLHu7pywAjjmF3jt1M32U0dDN4UwmPmrrgZi
 Sa2xS8velKjWDCNqzqAnEtiTkBMTMkBl3ce927uYJ7/QT1DNX0Mg++JyI1nH9GIjM9vL7xfEf
 KeRdt7vkdcEbLZdwCb7a8PlFINZIrqfVYAHP5yi+7bEzoOz0jXOWD60v5Al+E8xLzyVD23Hge
 7RRzNOSCJc6npNzurgyNpWtaxRSaa/xmXUmMGkEEOdO/l5YwM4DdhkgiNX4mMxr0SSYnnyheF
 a/7fPpfrCANv4viB4u5TzKjYSRJ7JN7l+OAvkAqIYCdKxYalIzw/qvvDlMJkB4+bBtYg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add mmc-ddr-1_8v property enabling eMMC DDR52 mode.

root@apalis-tk1-mainline:~# cat /sys/kernel/debug/mmc2/ios
clock:          52000000 Hz
actual clock:   52000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    8 (mmc DDR52)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)
root@apalis-tk1-mainline:~# hdparm -t /dev/mmcblk2

/dev/mmcblk2:
 Timing buffered disk reads: 256 MB in  3.02 seconds =  84.83 MB/sec

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 1 +
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 3408317c0f00..37e443e21ce6 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1919,6 +1919,7 @@
 		non-removable;
 		vmmc-supply = <&reg_module_3v3>; /* VCC */
 		vqmmc-supply = <&reg_1v8_vddio>; /* VCCQ */
+		mmc-ddr-1_8v;
 	};
 
 	/* CPU DFLL clock */
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index ba6fc2e51b2d..f76580f6cc80 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1948,6 +1948,7 @@
 		non-removable;
 		vmmc-supply = <&reg_module_3v3>; /* VCC */
 		vqmmc-supply = <&reg_1v8_vddio>; /* VCCQ */
+		mmc-ddr-1_8v;
 	};
 
 	/* CPU DFLL clock */
-- 
2.14.4

