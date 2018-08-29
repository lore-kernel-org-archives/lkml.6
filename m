Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AE7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A192082B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A192082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeH2MLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:11:51 -0400
Received: from mout.perfora.net ([74.208.4.196]:55267 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbeH2MKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:47 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M0jDU-1fdx2k0yvG-00uuLI; Wed, 29 Aug 2018 10:14:56 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 20/31] ARM: tegra: colibri_t20: iris: add gpio wakeup key
Date:   Wed, 29 Aug 2018 10:13:56 +0200
Message-Id: <20180829081407.11304-21-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:xvOBkawqvWBGPbLDryeOsIix43eNrSZ5P0Kl3UlqwUsGihQ21U0
 fBWV9mamME713hQkbX5Ld/xTBsDizZbt6QIrljbxpPdqlc8pTa4G7j2I+SwUybtsPqPZrYZ
 OkWfdo5pSC7fy9ITMC8bgFKCFKBMLci3Y4kOqpEp1H6tylNRNErJAhgjzi+p7yP6EiZr18H
 oB/+FAnrWfpEVFjkwktOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3noZk4AIKuI=:ypvkcSuN38PARfX8oCrFSr
 iYnb0hk77EZUVD7nibBts7LRrrywcyw+YqyVoFjOYIs+/ibblk9boDy2x6Nzg1J+Ga9n4e3Hd
 AyPTmtyb5wDqE+lDaWwIdHTi/q32vA2R99frCFk/xhxkHWumtw6gpV4tMVzgeqkqUMeOIotjR
 qIbYfRvpeNCt5aHmd0p0szcWx4MBpRXJpgACCLiQU6VzxZRKEC/+qWCHdDeQag0gu7jGgsOQd
 c8fguL7qTfHMJmVhystqaUmcvBnm8zfVbjzoBuFVE5SNZCzTtvPA3w1LCVyVIH2dSNe3VwypM
 8p2oQR8Sckjx95WkDe92xE+/qH8r8woaiuDna/N9LAQMwrqMxbNG3milgoH1LUWjNhV6Xo2s3
 ILpbGB4rri9iNYXA9Rr6aIaFzFaf8utS9qn8kTVIRqIuPyk8I2TrB8TL9ju01vAtG/yKN7uUJ
 JrNlj6NwtikdIM2QSRtt0rd3IdTLOTshZz0qxzg9ip9vktddwX3xz/42GSzEoQ/uoa4NyCR0V
 gIZAekLUs8mpuGjn67nAVdanZmAlXh2EjpIptpaJjuvBsu7LLBdHb/06N/KMbFamGj/6syhyD
 Fd7Jro2FZJTVplZy+TmxfuBoWqcCAyTbyFHspqIl7SAz0U5oS6VNGZpdRqX4CobOjfLsZp57U
 ST2PgB86oB2vxJSzES5U7cXXmhNXUpj+XH6rstUQHhR/mCjEmykCwTtQcCvFeT6nY5UE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add SODIMM pin 45 as GPIO wakeup key.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index a2364e39c131..f615e3b9490f 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include "tegra20-colibri.dtsi"
 
 / {
@@ -177,6 +178,18 @@
 		pwms = <&pwm 0 5000000>; /* PWM<A> */
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		wakeup {
+			label = "SODIMM pin 45 wakeup";
+			gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_WAKEUP>;
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+	};
+
 	panel: panel {
 		/*
 		 * edt,et057090dhu: EDT 5.7" LCD TFT
-- 
2.14.4

