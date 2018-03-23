Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeCWJgZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:36:25 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46624 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeCWJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:36:18 -0400
X-Google-Smtp-Source: AG47ELsuawrzeFlA0C7akZesA9VezXksSqw2HPLk2iOhQP/yP38Aq1pyPZ8EJFGQrHAomttgGtq2OQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/8] ARM: davinci: dts: make psc0 a reset provider
Date: Fri, 23 Mar 2018 10:36:03 +0100
Message-Id: <20180323093609.24576-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180323093609.24576-1-brgl@bgdev.pl>
References: <20180323093609.24576-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The psc driver registers with the reset framework as a provider. Add
the #reset-cells property to the psc0 node.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index a3b9a99b43ca..dad64dbf1f23 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -123,6 +123,7 @@
 			compatible = "ti,da850-psc0";
 			reg = <0x10000 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 			clocks = <&pll0_sysclk 1>, <&pll0_sysclk 2>,
 				 <&pll0_sysclk 4>, <&pll0_sysclk 6>,
-- 
2.16.1
