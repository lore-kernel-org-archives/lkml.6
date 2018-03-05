Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbeCEWDR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:03:17 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35620 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCEWDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:03:13 -0500
X-Google-Smtp-Source: AG47ELtJL9vPay3TXsRxUrqXoYgR9bXKzjdFW6eZuwzFQJg8CFiTyppu33NLGCFoFKkUUEy4uEMhTw==
From: Tim Harvey <tharvey@gateworks.com>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v2 0/4] Add support for the Gateworks System Controller
Date: Mon,  5 Mar 2018 14:02:37 -0800
Message-Id: <1520287361-12569-1-git-send-email-tharvey@gateworks.com>
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

Tim Harvey (4):
  dt-bindings: mfd: Add Gateworks System Controller bindings
  mfd: add Gateworks System Controller core driver
  hwmon: add Gateworks System Controller support
  input: misc: Add Gateworks System Controller support

 Documentation/devicetree/bindings/mfd/gsc.txt | 159 +++++++++++++
 drivers/hwmon/Kconfig                         |   9 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/gsc-hwmon.c                     | 330 ++++++++++++++++++++++++++
 drivers/input/misc/Kconfig                    |   9 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/gsc-input.c                | 180 ++++++++++++++
 drivers/mfd/Kconfig                           |  13 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/gsc.c                             | 330 ++++++++++++++++++++++++++
 include/linux/mfd/gsc.h                       |  82 +++++++
 include/linux/platform_data/gsc_hwmon.h       |  34 +++
 include/linux/platform_data/gsc_input.h       |  30 +++
 13 files changed, 1179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/gsc.txt
 create mode 100644 drivers/hwmon/gsc-hwmon.c
 create mode 100644 drivers/input/misc/gsc-input.c
 create mode 100644 drivers/mfd/gsc.c
 create mode 100644 include/linux/mfd/gsc.h
 create mode 100644 include/linux/platform_data/gsc_hwmon.h
 create mode 100644 include/linux/platform_data/gsc_input.h

-- 
2.7.4
