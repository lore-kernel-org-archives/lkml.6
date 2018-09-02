Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0629C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E1720841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E1720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeIBOZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:16 -0400
Received: from mout.perfora.net ([74.208.4.194]:58471 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbeIBOZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:15 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LhdIt-1fZwfL23NZ-00mjHe; Sun, 02 Sep 2018 12:09:55 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 20/37] ARM: tegra: colibri_t20: iris: add gpio wakeup key
Date:   Sun,  2 Sep 2018 12:08:49 +0200
Message-Id: <20180902100906.25792-21-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:ycZ49IY+7CU19T7ui6UrhBjUyq8i7h9HLCFNdxiqIxSfmaUpA8o
 xX8tybqq6XTFXmtlvK68XShtDz4oYDQ9AlPxLUdbZnRMHxv0J+Q+PkKqL2FNw0FDWLtuDGd
 J8u1H60f4+JHc2z+EsHZ8FQGzTYP43kulMhgiG/fbkvjkw4+O0czwBCx7N7if/glRuDYnM2
 OMr4nwpAOwIQ7Dgn3F+Vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:25BIPaKGyrI=:1ioTNcecFkSM/VDCA5G7I+
 hp6PMktMfQ0aLk6pxSKkJni1XY7ICZulCiuDlMMa1P2SoNsCqgPm5uslUs8I1P0BQT3CP4lcm
 3t+dSr3B7ZepZoB9JZPaByLZLZ0oGS+e1KvTHyovlIY05JrnSKCJHnRLBhIZH4UMoAa5tz+Fo
 LRMWWkzcs1Aw19g5aGRSyBzoQPYPTOShn/VX5yFrZr3+x1KhX3aNBCRUqhunl36RDMobM10FZ
 IbYY8Akw4q80ZKnoVSWN7P0aPi0IEmP7ClQjyIRhntFX/80YgsnBwmgKGBJfgRfRXY0Vx2zeO
 gDd0oN37XOV0CmyA9UHfypCgKqXA2yvLdMXzwDOWNpiRgCtbgwe//h2g7e5OYEjdVEL6UTeJl
 Oz/wEDKnWrnzdIu5qQszzqGSR4R7b1t9s4xg9aR4e8wpXxm3W7eFmyhVUQL/+o3CfVV8bzHfB
 Anlp1WC/Ajcl2S9qpOzyKoTzBQwmTMz0zUgyHQu4YIImwiZLn3+0m9qQRq/SK/yK8Xf8142Gh
 0KQ5iTbDaGf7Huzg1PjbFAN5ecfJJ+EH2mn0/j90igMVcy7Ah0+dDnvgtBJr1Vpz+A7BoIaD+
 i4GMI+iyPMcCtOTKrpYKzt57Etxdeo3MNFhZBAzNBES0p4aHFtdazjWgajuHFYtddZV5osdKE
 AaAL61Q4IT8eAuKm99TLTgGNcm2Q/JzQcuD32CSaStpjkZwO7TeP1fYANzyTKS3/qHSo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add SODIMM pin 45 as GPIO wakeup key.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index cb7b11567437..5b25e4b38a69 100644
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

