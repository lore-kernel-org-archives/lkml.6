Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC0BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D882083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D882083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeIAMYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:49 -0400
Received: from mout.perfora.net ([74.208.4.196]:44621 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbeIAMYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:49 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M9peg-1g2dnM0XuK-00B1Ee; Sat, 01 Sep 2018 10:13:28 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 14/34] ARM: tegra: colibri_t30: add i2c-thermtrip
Date:   Sat,  1 Sep 2018 10:12:28 +0200
Message-Id: <20180901081248.22639-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:pJ+Wec6iJlA0nruioYaKUvQ9v5daRMdkKILIXRrcGrzFEgph7LT
 0UEZoi8/dK+FbmqlqZpM2mtWabWqu7E0OfKOk7WERx5SD996lMvPdD1h+AULpkRnGjkqkA2
 L5jRkxdOCq1sVTARatlRNFI72I09E6XpAnxCistQAQZT7Qj2CNP1X7MNzok7oy92N5T8saT
 Sn8O88MYzNSa3N4P6hXzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cAdeIaX8Nls=:FJi04n79OkrSJ+5vWyhpec
 89TnqqndiZrF9Zx2KkAPJ441C0ewNhgLS2Yf3S01UH1rsKl3K03hhxWFMagp7mMo/a0Iyu8KL
 +J52xK8qGZQ79Jrgc2yZl75xaUNNmRLh2n3CsvT8Xuqt1XGr4XOAnt3n8MCsWWxV/d/is4TlW
 pi2HhsyW0hU/M53XYSybSf2Yzkdbur9KtPDWm+ws0/y2Crq0/XZOaB/o0yTvS+1tnX8Vnz3XI
 wV60GHe4AchUKz48yus2IeXrotX9gPLjxXvEvjoOH5AjJmjXbZj0GtV6m9DRWbDIqt3iI+lhn
 DIECfEEpCqndEchdy8IdQIymdeoFUy89eZI6l2WkHRwqPDdEVzD7o9bVoUKMmm1JQ+EzdmoH1
 ONjunIME9X4QmOTRC1xDIvYqgN1zygxycWDL3rJe8YIx6FvAWIZ4/4NJu42UrfBtqk+69hpoH
 7BlM0AYe/fjJvgQsnOO1MLUSoazsxFaNQTkzDNtabVgSzlhXcXUJ9/gX4Qe0osStLKxrtbDEG
 WM6JaCMKV763rQxflANshk0E/VxhpE9einCsPmSvQMFlVgFNf0opDeiK7ZIP0vkM3T5dqfqEQ
 mBxDTq3h/kHZrKOADWIkzWWizCvT57ucVuW/AvSIZQC+XzyZ3rskZ56NQu5JvxdsZZbtRDtlh
 W1XLvGLdkyUU2dDIN7rKFvWmZRSqapgZffoW5zjHA/Yo14/UaTgLRU4E0RCbyg97D3NE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add i2c-thermtrip which would set the DEV_OFF bit in the DCDC control
register of the TPS65911 PMIC.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- When running some more tests I realized that the reg-addr should
  really be 0x3f. Fix this.

 arch/arm/boot/dts/tegra30-colibri.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 73ff098612a2..670edd5e4754 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -910,6 +910,14 @@
 		nvidia,core-pwr-off-time = <0>;
 		nvidia,core-power-req-active-high;
 		nvidia,sys-clock-req-active-high;
+
+		/* Set DEV_OFF bit in DCDC control register of TPS65911 PMIC */
+		i2c-thermtrip {
+			nvidia,i2c-controller-id = <4>;
+			nvidia,bus-addr = <0x2d>;
+			nvidia,reg-addr = <0x3f>;
+			nvidia,reg-data = <0x1>;
+		};
 	};
 
 	ahub@70080000 {
-- 
2.14.4

