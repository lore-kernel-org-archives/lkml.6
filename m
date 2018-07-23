Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10DBECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D019208E1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D019208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbeGWNiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:50 -0400
Received: from mout.perfora.net ([74.208.4.194]:36213 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388302AbeGWNit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:49 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LaVAX-1gQqCu0qSN-00mK3u; Mon, 23 Jul 2018 14:37:35 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 15/26] ARM: tegra: colibri_t30: add i2c-thermtrip
Date:   Mon, 23 Jul 2018 14:36:46 +0200
Message-Id: <20180723123658.980-16-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:+zapLFhcFkDERlyFCusU6KRIqksYWPRTLQmqrvkqVYKMWOyggg7
 kWJU2kiFX7KI1d4yf2p7CBY4ZfdPamoQy+kQGKO0a6Z6YeiY8SLiIxLPmpzZKuw3Hrt5Ahs
 oIAQtF5Xv8ASlO7Z8Rgj/J94Mq2UwonKQnIis8jwnOqM0+MMLKt1tX4O50JrrFDeF0or2zV
 UNS6p6YKsikbHnbg26EXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1T187BazFJU=:wLPSnrxA6iH7DvAFKiqVd/
 1xmgTfw7P/T/CPP3zyj3/xIgX8lQkvsxhWUnJ6YpEsp5rY+DtHKdCcXqQpRWl5pa2LsrXR/nm
 bG7kWbJk+yGbC0v7KD9nwpwWYD5VQiH6gssf5Wu9CZtYMUMxVwkpnoajeOmCHSzzlEtAKQExc
 9Bu2UaIng6eVTzHUJZlVideGk2LMOEs04bx3FsLONV8Tu6EOh1ovraVkw/y74aGeZtN8SpND9
 /MgtBdSm52/ZD6O0a2l6AAP9y7STK4WVFQ418HKUdS+FAnz0CINs+09yEpBqsK0cpA0zK5y+E
 jIKnHbYnuedKCP6YdAS4vELbE+EOrj9k3ZtyFTGRj/bNH9dN2UhgUlETerqcD5BTC+k+7bEuV
 EvClpXLy8ao5auhgfmm2ja87GKOtckK3hN31V8WMcTBtuTw9yKutYo1xlmMESEBAzFVGGIV4g
 E+X5UHMqI2pNyDkGreu/dlqH9cJJFfYVaQNjdOF666kuh4IjRjYoitq7zWJyaoqYlUvTKXaMC
 9Trs7Vk5hw/ho2f+A5tfXRIscqSzXLtf3mMH/8Q0DzuId32PrcCyF4ZRZGmyEmPH8UIhVwwWr
 QJjBpA3sX/hvvlqzQHE0EdByS3YQRApiNa98OWDx+ECOKRiYuDVdMoDrF1ejDbZ3j+DdogR9x
 Wqp8qrDXVkofp3dyy3Z9XwC9NxbM9EWAlF7QRHC+WomC2hylvczAM3VaZWY8n3AhRn28=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add i2c-thermtrip which would set the DEV_OFF bit in the DCDC control
register of the TPS65911 PMIC.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 8266e42e1630..6608243e1d55 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -902,6 +902,14 @@
 		nvidia,core-pwr-off-time = <0>;
 		nvidia,core-power-req-active-high;
 		nvidia,sys-clock-req-active-high;
+
+		/* Set DEV_OFF bit in DCDC control register of TPS65911 PMIC */
+		i2c-thermtrip {
+			nvidia,i2c-controller-id = <4>;
+			nvidia,bus-addr = <0x2d>;
+			nvidia,reg-addr = <0x3e>;
+			nvidia,reg-data = <0x1>;
+		};
 	};
 
 	ahub@70080000 {
-- 
2.14.4

