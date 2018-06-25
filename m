Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179D4C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD21C2557A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD21C2557A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbeFYIAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:00:06 -0400
Received: from mout.perfora.net ([74.208.4.196]:55099 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751821AbeFYIAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:00:04 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MFKMM-1fLFS114Xk-00ENLh; Mon, 25 Jun 2018 09:59:53 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org, linux-can@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] apalis_t30: fix can2
Date:   Mon, 25 Jun 2018 09:59:48 +0200
Message-Id: <20180625075948.32040-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:N/0KozSzT2u9n6v7TtdjClWNzzAsQ/O3xgT+L72cZBrEbZcCMp8
 iccCXTWaiwzo/U3b4uxxnOhMzTXcowHXLW4+yyKDwJZEfZxr5KikHQqPLLxVi3US/GLC1VY
 TG7I89aBX1aesQv8c8N4/YKjldnKRz1lQw/VqXHyHBkk8NsSxzYZKwD69RuQJuHQnovwq2U
 1HAjOldrmr8aY6Pv+TBIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qGMpSrAMtbs=:Fs687a+y3YbQv3cArdoCEd
 UrK5lTOLc6qlPWZXEF6l4lYa6qjClbpxSZLK+Ff7bWxiLBAf5UVIwhOMlUrluafv2BLKmr0V/
 +m/fBHujCXVXlta/seTjvU3hXcf8Rl8P7gMf/QhXf0ct0SzX8rp/DyhLPMUmiwLbKu1SP1zr9
 395qd6sgr43hsZ0rum4gN2V7i46Ta9/ssb3VqJ1ts25DNk2U9lcvQ+G1Vw48fx7YrnCXvYgEX
 YhilS5WZb/Y5naagGwTEo9nO65qH07hFEjrlzGN3A8135E9VK9bpoQDhCXLyQ+HI+VYduf4Zi
 MobWQNX3JK12oOJojokLYnZ5oe/xHuzB6gd57xFzIeMBm1AswF5NjP12twmkE1MAr4f1dro4e
 PZZEZ00IRCR7qPoIXZrIBO/wN9bK82xPYqm/hX4QGVym1/n0wjXHJQbx/0+JaA6cLM54MeDz7
 pAKEnV2ZAMg4+vHc11I8NSLvn6gIQmeeq/k741U233vHooQGLc15yX9NVJbSDycPedzWHzJeu
 JQVfWdCwUHNInvh32o/0JULdPZVuSyupgbUght/45rhn9S0OGjuMxKFW3vcq4Nc8u9HdG+ihz
 YicJihO1yepUylmMzn8rQVmSCtRlVS6kjfTTEz2YZdLhYrikFloiv2FNEGaWxWCDsZsLot5UC
 2JbTAnKMcFEVrFNdjcI8iaitjm74SzalmEEg1V/xrKKLwvAVqjTLhUgBUWEpC5Q5KkfQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

CAN2 currently fails on probe as follows:

mcp251x spi1.1: Probe failed, err=19

Fix this by enabling input on pin mux of resp. SPI4 pins.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index d1d21ec2a844..9ff6aafd72b3 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -118,6 +118,7 @@
 				nvidia,function = "spi4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			/* CAN_INT2 */
 			spi2_cs2_n_pw3 {
-- 
2.14.4

