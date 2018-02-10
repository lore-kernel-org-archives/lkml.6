Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeBJBnv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:43:51 -0500
Received: from mout.perfora.net ([74.208.4.197]:50701 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeBJBnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:43:46 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/6] ARM: dts: tegra: apalis-tk1: activate pwm pin muxing for pwm3
Date: Sat, 10 Feb 2018 02:38:02 +0100
Message-Id: <20180210013806.28496-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013806.28496-1-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:xdLOrEuIzP2AmnCHfynM9E/x2E80LwZaQybJ1rHqjzNTQKOKRDY
 pwXEdxGdQTlGya2bjbRg980o4bLJ///ixuTY9tUjJZr5OSNLzuwfKth+/nFvCIGLwn76gd4
 f91jGLN+Ghx6N961IxKJscZviioqvpxzffKKq+Huis/TMFCMGDnPETEm3Nmtv67aSCUpDWf
 IitW7kuFYqu7mb8ngP8+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z2RndCEv/1s=:7l04btBKAwH55x/cY9KWvB
 kCp2SJl0TcwDS9SiaasxnTw+0cBTM0KbdqPX1uhSIDgZUvAIalNQqKZ3ZlZ+5KOB5kfg8e5VC
 torFwbtcNHhZ0yxdnl5trP7iJENVmbOoRirYiGfDtMXaggnAARMAGRjx91JJL80pz2Ij14H8P
 cPz3eA35t5u9Fm8tJYi10MWGVni81nEMLxqKZDcjLhDoRO8zgEoKN+V6+DxY0Iy41ljOYTC7L
 LLoyCO6JGcIo1I2iTQSzYEM7tNtpt66TfPkgLrz5tIrSTWs4bqXfMZK0A2b5ziohLMNmz+UTC
 OhcaPOFqR1QA6m7fiH5TImkR4un0Hh8gHg6YDP6k/yGQ70GnvcLyW76ZUh///RebGcHvTwLri
 QSUfpJSg/89VKHIA9dcezua7T3aXIDEfdkEZQfm938+ISgIkxFhsgSvpg850IfkAtNTtnzZKG
 KcoalJ5hV5iHXzYVMLu0ePIH/MqW1d9LTh8l8h0/9qoKXk7D1ipA4yx3if+0RLA0zy5tqBrnG
 hWLa3bFoB9eqW9JIrLqdaZmJql9bIfWL0moj0vKjVtalmjw1XyylswMBuVXXOTgs9bM4qQ71m
 HS+h6Ta1RadHuFmoOLSgCKqyeFyihhd4+E6mY9CX53T+cYUFrqMY9+9+6Y7VvtS+sV5bRkoEc
 ALzvSm7pmoAH/JpTxmkYjaUqHElI8CQ1GKoEG4/hDIi7k82bh9Ugdg78bc8jG8Gv3OYPgB+xE
 wi3avXem1TpJm1b2MelcTmA3hiELcXocTOid/g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Activate PWM pin muxing for Apalis PWM3. Note that the same PWM3 is
already active on pu6 being Apalis BKL1_PWM as well. Therefore exporting
that one for raw sysfs access will fail and one has to revert to using
the pwm backlight.

Downstream commit 668ddb921800 ("apalis-tk1: activate pwm pin muxing for
pwm3").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index be45b6753916..7fbaaf221029 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -453,12 +453,12 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			/* PWM3 active on pu6 being Apalis BKL1_PWM */
+			/* PWM3 active on pu6 being Apalis BKL1_PWM as well */
 			ph3 {
 				nvidia,pins = "ph3";
-				nvidia,function = "gmi";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 
-- 
2.14.3
