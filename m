Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeBUVrV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:47:21 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50216 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:47:19 -0500
X-Google-Smtp-Source: AH8x226iwA4hD9d+ktypwwcncmPjZyp4Or4Yihw2y+AM5Zs7HpC0ZLtkg+vJy98d1u8IQUM870O4+w==
From: Florian Vaussard <florian.vaussard@gmail.com>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Vaussard <florian.vaussard@gmail.com>
Subject: [PATCH v4 0/2] leds: Add driver for NCP5623 3-channel I2C LED driver
Date: Wed, 21 Feb 2018 22:46:52 +0100
Message-Id: <20180221214654.3306-1-florian.vaussard@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jacek and Pavel,

Winter came, then spring, summer and automn went away. Snow came again,
and now here is the v4 of the NCP5623 patch... Never too late!

This series add a new driver for On Semiconductor NCP5623, a 3-channel I2C
LED driver. It is used in our design to drive a RGB LED.

The first patch introduces the device tree binding, while the second patch
adds the driver itself.

Best regards,
Florian

---
v3 -> v4:
- Rebased on Linux 4.15
- Moved ncp5623_of_match[] after probe
- Fixed computation of max_brightness
- Some more simplifications
- Updated copyright and SPDX license

v2 -> v3:
- Rebased on latest leds/for-next
- Minor fixes to the binding documentation
- Removed ncp5623_set_pwm() by inlining it directly inside the caller
- Removed ncp5623_destroy_devices() as we are already using devm_ flavours
- Got rid of the 'active' state variable by using 'led_no' instead
- Some other cosmetic fixes

v1 -> v2:
- Adapted the DT binding (led-max-microamp for each LED node)
- Removed underscores from node names in the example
- Use brightness_set_blocking to avoid workqueue
- Introduced LED_to_CMD macro to avoid switch statement
- Various other fixes

Florian Vaussard (2):
  leds: ncp5623: Add device tree binding documentation
  leds: Add driver for NCP5623 3-channel I2C LED driver

 .../devicetree/bindings/leds/leds-ncp5623.txt      |  60 ++++++
 drivers/leds/Kconfig                               |  11 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-ncp5623.c                        | 228 +++++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-ncp5623.txt
 create mode 100644 drivers/leds/leds-ncp5623.c

-- 
2.13.6
