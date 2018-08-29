Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0A4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA2B2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA2B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeH2MKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:07 -0400
Received: from mout.perfora.net ([74.208.4.197]:40449 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeH2MKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:06 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LoXz2-1fRuWA3HlC-00gWC4; Wed, 29 Aug 2018 10:14:17 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 02/31] ARM: tegra: colibri_t20: iris: integrate i2c real time clock support
Date:   Wed, 29 Aug 2018 10:13:38 +0200
Message-Id: <20180829081407.11304-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:tz3pZgEtUJnSRaNOqDeVL6ubtQ1u7zQlYCeKNa4qA+mY/Dn7UXe
 6KtOMUeo8Uhjx+bzgYoDJ/iwWp6hn8SOFORLv/hMhdj/F0HxDOpch/o5f7hvd/Cmne526rT
 8sKwWz7GXyZKDPomqKlw56cLw4bJsSdkBeHqyqyA4EIP5R4aYtzxJyKZ4tvoYQRM6u35Xad
 vA0hv8Q1dYf8CJio/eW8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VOL6CGFdag4=:sKaXz2/FwKmX0LVUQuBcxa
 5l8tImDu5PVoaud70rhfj9xczvKOLwzl407fPW8+qQpVRLhUjbCBIbDgjyYITSoYew0z2c/s0
 TXLsxB9x75tiJCuovTz31izF7luBd1Tk4T0VIdIluNDPl8N2KSy2I3NQxTCppIv776n8vnVHD
 eCMtAKbiu51sEx+rA6HzlHS22uElsghEkmPUuOTjrfvdhaf1SdzcxzRY/5WUeRLuCCblox00M
 ZCKrJiLtMsOpDmk15zUUxmbkbV71sR7OsvJrnoRQP94CG9hZn5YeW8d9f9G/wK5x4sUsp9ViI
 08UVcriShYfyRwGMRRbZVnC+Gjmt9xfzQd+ar0Tqs4ZxmerKVmNIDTtIeKFbBV3oWqQBmV/pD
 zAzUFB0v47/9c74H+6wb6qjcp0D3eQCaVy/6SjBhMnZsw4r2zkyVM/waI66eTgGzRMSIrBDUN
 jZQEBaoo3VqiSBmk7KD/dvNx7xXjPZiZ0mdrMriSgcSbonyohfUNqM2TuVT540pPtHFZ47M8A
 FiYHhPHAWxrCDRCYfi9HfP5g0K9roAyf0kwVOiFV6dEEF/PIvk3elgO1tIdycK1gDrQPOp90v
 jKbRxGpHfQBRZTUIxYKbn6l67n3MPJoqeg4sZWf2fUNkI146LB+v9dtJAxjRkOEe13Eg24bog
 OxQ0479GpRBBUf5vZ27X7KRAbkp6t2sLGTequXdKBFI9ZJm0CNCUi+pmWVvmFP070mcc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Integrate support for GEN1_I2C aka I2C_SDA/SCL on SODIMM pin 194/196 and
the M41T0M6 real time clock on the carrier board.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 496b96e229d2..b6d05da8c93c 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -56,6 +56,21 @@
 		status = "okay";
 	};
 
+	/*
+	 * GEN1_I2C: I2C_SDA/SCL on SODIMM pin 194/196 (e.g. RTC on carrier
+	 * board)
+	 */
+	i2c@7000c000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		/* M41T0M6 real time clock on carrier board */
+		rtc@68 {
+			compatible = "st,m41t0";
+			reg = <0x68>;
+		};
+	};
+
 	i2c_ddc: i2c@7000c400 {
 		status = "okay";
 	};
-- 
2.14.4

