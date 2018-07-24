Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED0CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3F220852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3F220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbeGXLte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:34 -0400
Received: from mout.perfora.net ([74.208.4.197]:50755 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388313AbeGXLte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:34 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LrLMg-1g9fM510rU-0137a6; Tue, 24 Jul 2018 12:43:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 11/15] ARM: tegra: apalis-tk1: enable emmc ddr52 mode
Date:   Tue, 24 Jul 2018 12:43:05 +0200
Message-Id: <20180724104309.21741-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:QiT9/UNRtZyLs7ENi1nRClMH6TsSQ3wXk3YjlA40MqMENR9IIYI
 jfRWL3VuY88KSwy4PsBgb6uqyCturmiGjhVlQ3Uabr9Igpdl8+nPbCasCWCw/QZmee92J95
 BPoHJZFqaZRg8UQaRjGRUAYzpk9RPe08zhiTtrYPKuGN2ewG8kjDfj2+INIUN3atzWWDHJ2
 rQa5PjnTmSzrnsOQNmK4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P0fmeH1AuLU=:zAXXuquu5VzRvwk4OnHx4P
 lUWQJRIAIcDvsq//F/TS8+S6S5OhA1zllQfqLZL2XfQ4J9eFu5bZJy2LBYRZyhVS1sL6IUBec
 z/YqIMmK/4P4WP6k8M65kxiPhe/iA+TRSNoxKkCiGnBNV2kK6vr7TbnyKso5n2H11ewegp0rR
 IttPEKsU+blSkif7qINSOnkNlI3vEodU0bwIcibMkL35VsaOKE7LRNVhXeuF6n36C2yJosA1W
 0eb/tI27xp+PZ6+DRAAAjkXB9n/m/USwB5u4Ykp90WTa+tTWI4j6+xocrjgugS1dxKwjwi1zF
 6k8rod1aqodMSmpC53WrUWQ4signlYJDPJVGB7TjEIYtMjaG1mORVpEyLe3JJqr4Ba6+R5Pm3
 4e1oGAbflpCPXUXmOXeAR1qarC71cchgOPC/DWzcoAWJ/MQHbfMgfLnpITJkoSGP4zOXH9Hiv
 yr8ivcNB6SBUq1F3DL+7eH/9GbtRWpu5bANaLmTal5FkHm3blpP4Cvxsb1NmhJ6NyVB641tv/
 nb9E/VdGdKO+lpJ2Z1oiKcJG/ZbanBWIPrg4VgzrraIOCqBQ7KMuPbciwwURTu3mMHDZlMWWq
 LnpesNKP/Ugae5iLGBZ5BvxvEEyqfvoVofoYRJ4IlF5L1YWL9lTWR4eVz3f1z8biiGWtAK4Cf
 DUDW7G7XCIPHTFt5ZUA/94a1/3c1u8xtQd7CGzg2r/mfuK60Qhl6AJSCvjNxrolQlCcA=
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

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 1 +
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 6c255cb70339..13486fe407d2 100644
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
index 72253d918ebd..77ca508d755e 100644
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

