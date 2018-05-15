Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeEOJ6E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:58:04 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37684 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752730AbeEOJ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:58:01 -0400
X-Google-Smtp-Source: AB8JxZpelunEUT2M874OgO3jq5mgidN0H50nzQc6Hm9YR4lbjQbG8VaPPKOKxYF960uHb6831LQBJA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mmc: meson-gx: add reset
Date: Tue, 15 May 2018 11:57:47 +0200
Message-Id: <20180515095748.6794-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180515095748.6794-1-jbrunet@baylibre.com>
References: <20180515095748.6794-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset to the documentation of the meson-gx mmc controller
bindings.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
index 50bf611a4d2c..2d54a08487f5 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
@@ -19,6 +19,7 @@ Required properties:
 	"clkin1" - Other parent clock of internal mux
   The driver has an internal mux clock which switches between clkin0 and clkin1 depending on the
   clock rate requested by the MMC core.
+- resets     : phandle of the internal reset line
 
 Example:
 
@@ -29,4 +30,5 @@ Example:
 		clocks = <&clkc CLKID_SD_EMMC_A>, <&xtal>, <&clkc CLKID_FCLK_DIV2>;
 		clock-names = "core", "clkin0", "clkin1";
 		pinctrl-0 = <&emmc_pins>;
+		resets = <&reset RESET_SD_EMMC_A>;
 	};
-- 
2.14.3
