Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756786AbeEAS64 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:58:56 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38875 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756652AbeEAS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:58:53 -0400
X-Google-Smtp-Source: AB8JxZqLd8WH5pDDnTWrT0A1USndCkCxf/fmgbZeOcCpebB+0CeP+j3icZKcZ2tJEWGolwhPdpXzCQ==
From: Anand Moon <linux.amoon@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Anand Moon <linux.amoon@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM64: dts: meson: update maximum frequency for sdcard to 200MHz
Date: Wed,  2 May 2018 00:29:02 +0530
Message-Id: <20180501185902.3556-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180501185902.3556-1-linux.amoon@gmail.com>
References: <20180501185902.3556-1-linux.amoon@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update the maximum frequency of the sdcard to 200Mhz
to support high speed read/write with uhs mode.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
odroid@odroid64:~$ sudo cat /sys/kernel/debug/mmc1/ios
[sudo] password for odroid:
clock:          200000000 Hz
actual clock:   200000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    6 (sd uhs SDR104)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index c90f8b46c60c..ab868eaddb46 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -256,7 +256,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <200000000>;
 	disable-wp;
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
-- 
2.17.0
