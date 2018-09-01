Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48B8C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FD720841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FD720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeIAMYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:23 -0400
Received: from mout.perfora.net ([74.208.4.196]:59965 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeIAMYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:23 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LhMWM-1faCsh2fjs-00mXuC; Sat, 01 Sep 2018 10:13:04 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 02/34] ARM: tegra: colibri_t30: reorder host1x/hdmi properties
Date:   Sat,  1 Sep 2018 10:12:16 +0200
Message-Id: <20180901081248.22639-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:wWxfOFE8DUYWODi+4TWDepbK6OOpJPpAxE+XAhLSKIo8ibiFhcO
 XgS2opKe0mdY5qR/2oTFhX4n4AktuAKH3lBFx++bU6a6hOZO0sb01i4cxYUki73SpS2PNU2
 Pkrb4o/dAK8Q24vcBexN8b2D+xn3BfY+HTww5Ju+7JNZpqPRF4Ef1/ytW0EI8Yg/HK8QOkB
 BhHGnUK61dSIxEH9xhb9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bu8Bfwz7AGg=:biET/RXfB/6yKEeJ0YYg8A
 FLUc7rV04JJk7I8dGJrPwTJLMtZ9i18HhhHBF5jgXcI895+iDxRcr4776cAOANrItqQIopylw
 XwML7k1qQH12Ra2hngzKW2oOut+x4fVcA+aJUU8I8oZ+/wGvP6b5gCRA+7zDOfy2KzctkOHMt
 7+KktI+HSSuIcBjBccAc/V96bJ5J9QL9aLtcwD6RGuAQfBpxerdunG3ChUTvIaqKHmVwsAr2z
 eBXVBeoKruhMbCteJNuWNQXdwJ02/ODLpDcLU/iFeimUV4dLfVsSigDRy6fIOusoNPP1UQCiC
 T423FZS+z2qYGkp3setWNHM6i1pZUZ2cXOsHh09HbOEaCaxg3Oci4IhnLrkaBxB2zbP6r0Lv7
 nLTyesz14ldZSZeWWNkq0JFDN0dFWkguYSq7BhHkTey9Tw2+WRcGXRRpamY6WFVt7/DXFkhmZ
 y/mnz3355MXyUmnJywlD8gYgep5cxT8zwAE81pH/gglghlO4yrWQ/BWsT9EVfjoamez0o7lKo
 /8rGvoPJ+i2HA1oHqV8nhZ8OjM66+MOjn3M8PWxkaNvxPtUZTueMhKv5yoiYnQpwHMhG86Y5v
 8Rqf1aY9RynKwJkWCMX027Fb7ZQsY1/mPyulxyErahTuNHnE/kdiaWvF1QCbr1fzfP+jzRTj4
 5zYHjCoSl5xaAOYmN/CPhoPCh9biWKBQYxjXOL/w0gfzeBdUXlOUDLI282kgIix11jGg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder Host1x/HDMI properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index a392b65a0b64..48c41a36b4dc 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -16,12 +16,11 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			vdd-supply = <&avdd_hdmi_3v3_reg>;
-			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
-
+			nvidia,ddc-i2c-bus = <&hdmiddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
-			nvidia,ddc-i2c-bus = <&hdmiddc>;
+			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
+			vdd-supply = <&avdd_hdmi_3v3_reg>;
 		};
 	};
 
-- 
2.14.4

