Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeC1POP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:14:15 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39625 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753763AbeC1POK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:14:10 -0400
X-Google-Smtp-Source: AIpwx49J8+h1SyanS/vAUYDGakSKWzLFP0MSO1fojXx3b8MyShoky00B8F8Mc66g9JwALd7xv69c2A==
From: Tim Harvey <tharvey@gateworks.com>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 0/4] Add support for the Gateworks System Controller
Date: Wed, 28 Mar 2018 08:13:59 -0700
Message-Id: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Gateworks System Controller used on Gateworks
Laguna, Ventana, and Newport product families.

The GSC is an MSP430 I2C slave controller whose firmware embeds the following
features:
 - I/O expander (16 GPIO's emulating a PCA955x)
 - EEPROM (enumating AT24)
 - RTC (enumating DS1672)
 - HWMON
 - Interrupt controller with tamper detect, user pushbotton
 - Watchdog controller capable of full board power-cycle
 - Power Control capable of full board power-cycle

see http://trac.gateworks.com/wiki/gsc for more details
---
v3:
 - removed unnecessary input driver
 - added wdt driver
 - bindings: encorporated feedback from mailng list
 - hwmon:
 - encoroprated feedback from mailng list
 - added support for raw ADC voltage input used in newer GSC firmware

v2:
 - change license comment block style
 - remove COMPILE_TEST
 - fixed whitespace issues
 - replaced a printk with dev_err
 - remove DEBUG
 - simplify regmap_bulk_read err check
 - remove break after returns in switch statement
 - fix fan setpoint buffer address
 - remove unnecessary parens
 - consistently use struct device *dev pointer
 - add validation for hwmon child node props
 - move parsing of of to own function
 - use strlcpy to ensure null termination
 - fix static array sizes and removed unnecessary initializers
 - dynamically allocate channels
 - fix fan input label
 - support platform data

Tim Harvey (4):
  dt-bindings: mfd: Add Gateworks System Controller bindings
  mfd: add Gateworks System Controller core driver
  hwmon: add Gateworks System Controller support
  watchdog: add Gateworks System Controller support

 .../devicetree/bindings/mfd/gateworks-gsc.txt      | 135 ++++++++
 drivers/hwmon/Kconfig                              |   9 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/gsc-hwmon.c                          | 368 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/gateworks-gsc.c                        | 285 ++++++++++++++++
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/gsc_wdt.c                         | 146 ++++++++
 include/linux/mfd/gsc.h                            |  75 +++++
 include/linux/platform_data/gsc_hwmon.h            |  43 +++
 12 files changed, 1087 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.txt
 create mode 100644 drivers/hwmon/gsc-hwmon.c
 create mode 100644 drivers/mfd/gateworks-gsc.c
 create mode 100644 drivers/watchdog/gsc_wdt.c
 create mode 100644 include/linux/mfd/gsc.h
 create mode 100644 include/linux/platform_data/gsc_hwmon.h

-- 
2.7.4
