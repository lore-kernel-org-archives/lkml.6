Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755592AbeDZKuz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:50:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51071 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755029AbeDZKux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:50:53 -0400
X-Google-Smtp-Source: AB8JxZqWFCy51jKRMldi6ynwc0EOCS+vObZnIjQI4ochFxp5Ixylj6fOTPXcfhe3txT4DWPaHr1WwA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson: disable sd-uhs modes on the libretech-cc
Date: Thu, 26 Apr 2018 12:50:46 +0200
Message-Id: <20180426105046.14817-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem with the sd-uhs mode when doing a soft reboot.
Switching back from 1.8v to 3.3v messes with the card, which no longer
respond (timeout errors). According to the specification, we should
perform a card reset (power cycling the card) but this is something we
cannot control on this design.

Then the only solution to restore the communication with the card is an
"unplug-plug" which is not acceptable

Until we find a solution, if any, disable the sd-uhs modes on this design.
For the people using uhs at the moment, there will a performance drop as
a result.

Fixes: 3cde63ebc85c ("ARM64: dts: meson-gxl: libretech-cc: enable high speed modes")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 3e3eb31748a3..f63bceb88caa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -234,9 +234,6 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 	disable-wp;
 
-- 
2.14.3
