Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0757FC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCE620841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCE620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeIBOZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:09 -0400
Received: from mout.perfora.net ([74.208.4.196]:55091 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbeIBOZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:08 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MF3BF-1g6XOi0vt5-00GQT2; Sun, 02 Sep 2018 12:09:47 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 16/37] ARM: tegra: colibri_t20: iris: display controller rgb panel support
Date:   Sun,  2 Sep 2018 12:08:45 +0200
Message-Id: <20180902100906.25792-17-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:cQ6DGmRf1RPCWdP5HeJ2fScMdGoqHuZn61ppTNQ5NL00ufqpokP
 JlY6wMZtXbfT145BRRTjEiMldgRDyBcnuSnI06EYrXsVawjFttkQkL+yx8/dsQzSgITlWHs
 39QO3rlbMgeKDq0xLR3GL5vlnDwvERhvynafqtlIP+Jwgz6l+JGT3UL/+6WQpPPs0aG8qI/
 1LB0zXqgTtov4jUQb+wWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZmK2if0ZGB8=:U5a2n/ETsGq0pFKSlVRjaN
 gzEsz4f0NjpHBcpgSHSlF5w7GBV2GuIWTWUitJ5jwlxidghvp3kSJsfbEWCbgE7BmW3CmBmL2
 jHjFwWDktBpAexIrCHGVp/5m4VGMVO2x6Q7eilzuX12MyrypRNsw+hkCafIBSJR8dM1e7RHV4
 MNSgIjxv2TczAyHKliBhSkDZdF43HryHco9kak6aCSD04Kj24rxT2ruQfsAhB+f9Cti7AkOlo
 5Cl/kPJp2dmHMQviF8zo6cuDD2umJ9albB7ncj0msf+MNs/FK3b3lhCWHim+6RNvqw215huj7
 E+oSOcIsDcpYUIJoli6E/g2zORrDCXGWWyKLUZWrQEtAq6RgdHjdzfbwCb77RlJCsZrr2PFQA
 Sx5rrx8IbB3M6nI4+DKPLoNVYnu+hl6w/mbGc0/3H3YwfIHYlo2+XdCoEf+RXlhKVEG8B2uCD
 GePUwO/dNnxZDb+AnyYwJFqume+cycVduhDTfcNjZND1wzC7CBhTSdvEkSjDL4/EQq5CTgKbA
 UvCOCN4REIyzGkzP4BmXweRe9sTwNBWwZQMNs/rOsVyGH5NmgciefhbX97Bw8DXeTWhvq8TsH
 pC/uJ6KXEkmLXUMerBd9599TVk7Al9dqwpSWMgX5kS8zOS76y6rCa6rADfpWd33X/VoIefF7z
 a8aiAJfkI6idJEP8jmcecAA82KElv/0wFkVvUSgeKl9Ve1e1dObXxzWSGZbUCdp5I9aA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add display controller parallel RGB panel support incl. backlight PWM.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 28386b89d910..21713b7ae978 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -21,6 +21,13 @@
 	};
 
 	host1x@50000000 {
+		dc@54200000 {
+			rgb {
+				status = "okay";
+				nvidia,panel = <&panel>;
+			};
+		};
+
 		hdmi@54280000 {
 			status = "okay";
 			hdmi-supply = <&reg_5v0>;
@@ -99,6 +106,10 @@
 		status = "okay";
 	};
 
+	pwm@7000a000 {
+		status = "okay";
+	};
+
 	/*
 	 * GEN1_I2C: I2C_SDA/SCL on SODIMM pin 194/196 (e.g. RTC on carrier
 	 * board)
@@ -149,6 +160,26 @@
 		no-1-8-v;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <255 128 64 32 16 8 4 0>;
+		default-brightness-level = <6>;
+		/* BL_ON */
+		enable-gpios = <&gpio TEGRA_GPIO(T, 4) GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
+		pwms = <&pwm 0 5000000>; /* PWM<A> */
+	};
+
+	panel: panel {
+		/*
+		 * edt,et057090dhu: EDT 5.7" LCD TFT
+		 * edt,et070080dh6: EDT 7.0" LCD TFT
+		 */
+		compatible = "edt,et057090dhu", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+	};
+
 	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V";
-- 
2.14.4

