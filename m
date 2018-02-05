Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeBEPcQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:32:16 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33429 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeBEPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:32:09 -0500
X-Google-Smtp-Source: AH8x225dr0igwuOuEkpQcL+oFhjFOoEJg68MiP2SOK3GGoO50pKup4uXURANSej6v86WlSK/N9OV4w==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] ARM: dts: da850-lcdk: add clock properties to the nand node
Date: Mon,  5 Feb 2018 16:32:04 +0100
Message-Id: <20180205153204.20317-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Make nand work with the common clock framework by specifying which
clock should be used and what name to look up.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index a1f4d6d5a569..2e725c57a0fe 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -264,6 +264,9 @@
 			reg = <0 0x02000000 0x02000000
 			       1 0x00000000 0x00008000>;
 
+			clocks = <&psc0 3>;
+			clock-names = "aemif";
+
 			ti,davinci-chipselect = <1>;
 			ti,davinci-mask-ale = <0>;
 			ti,davinci-mask-cle = <0>;
-- 
2.16.1
