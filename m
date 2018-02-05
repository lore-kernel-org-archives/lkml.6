Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeBEPwd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:52:33 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34235 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbeBEPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:52:26 -0500
X-Google-Smtp-Source: AH8x227trh81qMoUVAa2oDmWVQB2ec5B9so8f0Rz2UUUCBqUoewK32CibEca0bUJ+JdSRm+Gtwwz3Q==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] ARM: dts: da850-evm: add clock properties to the nand node
Date: Mon,  5 Feb 2018 16:52:22 +0100
Message-Id: <20180205155222.22189-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Make nand work with the common clock framework by specifying which
clock should be used and what name to look up.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index a86a8a1816f2..2602ad8e99ee 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -296,6 +296,9 @@
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
