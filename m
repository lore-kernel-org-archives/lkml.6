Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeBFLIW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:08:22 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53013 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:08:15 -0500
X-Google-Smtp-Source: AH8x227rytdiOhUBfIh5Q9LW95QMHeJlsFU32L+TB/kkTVkiSEmb37yLe3seteQnDF2Q/JRpQ/rEew==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Alexey Brodkin <abrodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>
Cc: devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2] arc: dts: use 'atmel' as manufacturer for at24 in axs10x_mb
Date: Tue,  6 Feb 2018 12:08:10 +0100
Message-Id: <20180206110810.9093-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using compatible strings without the <manufacturer> part for at24 is
deprecated since commit 6da28acf745f ("dt-bindings: at24: consistently
document the compatible property"). Use a correct 'atmel,<model>'
value.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
- explicitly mention the commit in which we deprecated compatible
  fallbacks other than "atmel,<manufacturer>"

 arch/arc/boot/dts/axs10x_mb.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index 74d070cd3c13..47b74fbc403c 100644
--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -214,13 +214,13 @@
 			};
 
 			eeprom@0x54{
-				compatible = "24c01";
+				compatible = "atmel,24c01";
 				reg = <0x54>;
 				pagesize = <0x8>;
 			};
 
 			eeprom@0x57{
-				compatible = "24c04";
+				compatible = "atmel,24c04";
 				reg = <0x57>;
 				pagesize = <0x8>;
 			};
-- 
2.16.1
