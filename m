Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD65C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F84920658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F84920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeHaUrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:22 -0400
Received: from mout.perfora.net ([74.208.4.197]:43335 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbeHaUrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:21 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MBUbw-1g6BmS3PaY-00ATcR; Fri, 31 Aug 2018 18:38:55 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 15/34] ARM: tegra: apalis_t30: reorder backlight properties
Date:   Fri, 31 Aug 2018 18:37:57 +0200
Message-Id: <20180831163817.23970-16-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:02A5rdEZDYSjeHnSdyngSHpXR60fvpfGlCIQmYKLj40VdmhSNnv
 ab6BXGkhOD8xjZ3D4TdpdUY3M0tH3M5PUfQF42oqMsDXlCfZetTi8pV6jpc2RLffejT/EI8
 TSk127zPJHRIn/kisOfuhiAKyopRNIbs/X4WRHZc0k4s9pqK2Zbnbkt1MY+XPPjF0+HM4Rp
 sdhvZhK4/BMRoCdikJBJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yiQT5W/EpXo=:xGoxwxU6pG6KIXV5yQ2ONa
 XNWv5hRrD9kyuAVvSDqFNqfqnBULw1wQl779ts7Dvu/FaC4+t7C04zsgrKx0zvb3n8xHoyLFj
 Kdid8pqEsS9plEPp3QlMyIP3N3+T4fJcsS7tUracjGAdpFP20yb6LXim7tUVM2FgM66mKno35
 fDSliRv51WxuG4MkP0p0ZuK95EBW8eopEH/BjWvOdu8TaGPTp1eu0lkIr1xjtBqhwd89hWtuA
 WLgsdJ/LfAHiJ/FDifSFLzgyojnKMDKe+3agEIk8GMQ0CLVfViu8UOlupqwzVhMBdhvPiu2pT
 kFQQ5azTAnYVNFoGdTAf46x7+xIK78l0U5mTxLxv84PIgZamcPWVn2GW5oKdgvigjprGWumWI
 lW5KOrXbFNcXuj+3Jt8PWwR0DneB/0/TE1ybN5XXfgDM+O9vyYXv1IC99tohfJJcHwUertYIa
 0elNIKOklWioDFg7uGuXdgx9DpgCa/FC/UdBLpxZADsK0r+ig0g3pFjfq5vTAElxKT5FH2z/y
 dxm1KhrfqhLvCHjI7FP+pZOIDa5LHYghVCL+0douUIldveIzy3ZB0CJ4/s8OZbbxrgF024Wl9
 c1mOaS5TwaO/zILsHzZcV8TafZu0gXPw7IErlRiTfePsAfY5KBdtpXExaqRvUz858Zp4L8Qo3
 xmk31Hv6ABrVWC8iiOz/juDNbfCQktOEtWY+/r6wyeJDZ+0Ma2w7CY7iee50yM92yn4k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder backlight properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 9f2392a05532..300ce726ff4d 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -185,13 +185,12 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		/* PWM_BKL1 */
-		pwms = <&pwm 0 5000000>;
 		brightness-levels = <255 231 223 207 191 159 127 0>;
 		default-brightness-level = <6>;
 		/* BKL1_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		power-supply = <&reg_3v3>;
+		pwms = <&pwm 0 5000000>; /* BKL1_PWM */
 	};
 
 	gpio-keys {
-- 
2.14.4

