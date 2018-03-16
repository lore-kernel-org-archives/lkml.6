Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753448AbeCPOua (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:50:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40019 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbeCPOu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:50:27 -0400
X-Google-Smtp-Source: AG47ELtDk6w0C8Pzo9ZiVDASYmGyj/ufQJmOMZGgjbYwZooIHZlkmJc0oTmRsf1pjS2+sopHUWGdLw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-gx: make efuse read-only
Date: Fri, 16 Mar 2018 15:50:21 +0100
Message-Id: <20180316145021.8517-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efuse is one time programmable, so it is safer to deny write request
to this memory, unless the user is savvy enough to remove the read-only
flag from DTB

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 2d51ccd60628..3c31e21cbed7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -132,6 +132,7 @@
 		compatible = "amlogic,meson-gx-efuse", "amlogic,meson-gxbb-efuse";
 		#address-cells = <1>;
 		#size-cells = <1>;
+		read-only;
 
 		sn: sn@14 {
 			reg = <0x14 0x10>;
-- 
2.14.3
