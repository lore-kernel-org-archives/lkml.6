Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeDKVnl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 17:43:41 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39280 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbeDKVnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 17:43:39 -0400
X-Google-Smtp-Source: AIpwx48UxEm1ewTAz5aCBvTABKThWYW31hvFjtuuUS1ZvGsK3KIDHfLfE0+2z6+ghuBT/b+5pEJNkw==
From: Ricardo Silva <rjpdasilva@gmail.com>
To: devicetree@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Silva <rjpdasilva@gmail.com>
Subject: [PATCH] dt-bindings: pinctrl: mcp23s08: Clarify gpiospec flags cell usage
Date: Wed, 11 Apr 2018 22:42:57 +0100
Message-Id: <20180411214257.14902-1-rjpdasilva@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl-mcp23s08 driver doesn't provide a specific gpiospec
of_xlate() function, causing the gpiolib-of's of_gpio_simple_xlate()
function to be used instead, which takes the gpiospec's second cell as
the flags specifier according to 'include/dt-bindings/gpio/gpio.h'.

The pinctrl-mcp23s08 bindings document was mentioning that the flags
were unused, which is not accurate because values in that second cell
are indeed used by the gpiolib-of's of_gpio_simple_xlate() for
configuring the gpio (e.g. its polarity).

This way, replace the "flags currently unused" reference in the
dt-bindings document with references to the appropriate files specifying
the possible flag values and gpiospec description.

CC: devicetree@vger.kernel.org
Signed-off-by: Ricardo Silva <rjpdasilva@gmail.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
index 9c451c20dda4..c357c99c948f 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
@@ -18,7 +18,9 @@ Required properties:
     removed.
 - #gpio-cells : Should be two.
   - first cell is the pin number
-  - second cell is used to specify flags. Flags are currently unused.
+  - second cell is used to specify flags as described in
+    'Documentation/devicetree/bindings/gpio/gpio.txt'. Allowed values defined by
+    'include/dt-bindings/gpio/gpio.h' (e.g. GPIO_ACTIVE_LOW).
 - gpio-controller : Marks the device node as a GPIO controller.
 - reg : For an address on its bus. I2C uses this a the I2C address of the chip.
         SPI uses this to specify the chipselect line which the chip is
-- 
2.17.0
