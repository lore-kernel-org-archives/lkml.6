Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFE8C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E5D218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FSuJA6Oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfBAJsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:48:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54182 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbfBAJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:48:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so5395226wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=72sHdsqDgbxs9TTw2d62EDss6OuvwE0R6tMTpCfK6lw=;
        b=FSuJA6OqnHBNC1l6Z42zRUG4KySPZlmhxD1iI1DEaYlu5btVJf8ueThTD6hCWuf9u+
         JZdwI3W0PoO/qlh1z0aCbD38+33bVzIHdFR+qXjIl2y/Ej0wSYr6hlLnH2IQUQmwH0kB
         g7MuiUMoL1WWC+U1dAMq7vIjXdS11F6dwWEAO3XnObU3nWib9LB+XVPJ22zhvOT2NCJk
         b36PcuSZsOLwZ48/JsaHnHIBdaFdB7wM/j41P8g4ec6iZSqiI8UvpAhummQ0NlfQiH28
         Dc2TDToRTD2Gb1aUs9JEtPP6f3shSbunkKm056ilRUnWx8rTXxKPAxcO123qQyicwmHn
         +plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=72sHdsqDgbxs9TTw2d62EDss6OuvwE0R6tMTpCfK6lw=;
        b=EVr561VLZVlGYpkGCkddUfXRlq+XU5/1R8qBziiVrREKzzEhDR9s+Q9Rv2Cfv/go/n
         TtDRsuruvEn8zRrRM7s2yC4MEum8aflgljKUAICIq9KmRMHHAXgX47W5PxKEKFtFEUVJ
         OcVfTtJL2a++fu1UH82ts2oNGB9wss+C+PRlL4pUcA5ov4QwlfpWtmH8Od9kbrywJSdX
         jiKuspZrzbZa225NXaCQxNSKcvUAHw0DOJGu5hG+mx3PaHPl/bd4j9PYgX8+AbgvkhBC
         KpRq32WfNAMJCVhQBx1CGGPFTiP6qiOiPJgOJsuvKvAydhtYspl9XyblqtQQTeWeh51A
         jRew==
X-Gm-Message-State: AHQUAuai9XGGSKb6hnXt+JIJ8KggbG7daw6RjCGr0Zrh6Shz+ZVkNFwl
        tOS0O4WOayhu/iecruXU0B0Khg==
X-Google-Smtp-Source: AHgI3IZyZj4eKc4tw3q8bGa0WoQ0+hio6XXtzoiRBvfyFaAmqwLTFf1YKYSTVSXVzaGMqhxBrwtHsg==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr1572967wmb.153.1549014481885;
        Fri, 01 Feb 2019 01:48:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m15sm9648970wrr.95.2019.02.01.01.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:48:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 00/11] mfd: add support for max77650 PMIC
Date:   Fri,  1 Feb 2019 10:47:25 +0100
Message-Id: <20190201094736.32057-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series adds support for max77650 ultra low-power PMIC. It provides
the core mfd driver and a set of five sub-drivers for the regulator,
power supply, gpio, leds and input subsystems.

Patches 1-6 add the DT binding documents. Patches 7-12 add all drivers.
Last patch adds a MAINTAINERS entry for this device.

Note that patch 8/13 depends on commit 03c87b95ac04 ("regulator: provide
rdev_get_regmap()") which was picked up by Mark Brown for v5.1.

v1 -> v2:

General:
- use C++ style comments for the SPDX license identifier and the
  copyright header
- s/MODULE_LICENSE("GPL")/MODULE_LICENSE("GPL v2")/
- lookup the virtual interrupt numbers in the MFD driver, setup
  resources for child devices and use platform_get_irq_byname()
  in sub-drivers
- picked up review tags
- use devm_request_any_context_irq() for interrupt requests

LEDs:
- changed the max77650_leds_ prefix to max77650_led_
- drop the max77650_leds structure as the only field it held was the
  regmap pointer, move said pointer to struct max77650_led
- change the driver name to "max77650-led"
- drop the last return value check and return the result of
  regmap_write() directly
- change the labeling scheme to one consistent with other LED drivers

ONKEY:
- drop the key reporting helper and call the input functions directly
  from interrupt handlers
- rename the rv local variable to error
- drop parent device asignment

Regulator:
- drop the unnecessary init_data lookup from the driver code
- drop unnecessary include

Charger:
- disable the charger on driver remove
- change the power supply type to POWER_SUPPLY_TYPE_USB

GPIO:
- drop interrupt support until we have correct implementation of hierarchical
  irqs in gpiolib

v2 -> v3:

General:
- dropped regulator patches as they're already in Mark Brown's branch

LED:
- fix the compatible string in the DT binding example
- use the max_brightness property
- use a common prefix ("MAX77650_LED") for all defines in the driver

MFD:
- add the MODULE_DEVICE_TABLE()
- add a sentinel to the of_device_id array
- constify the pointers to irq names
- use an enum instead of defines for interrupt indexes

Bartosz Golaszewski (11):
  dt-bindings: mfd: add DT bindings for max77650
  dt-bindings: power: supply: add DT bindings for max77650
  dt-bindings: gpio: add DT bindings for max77650
  dt-bindings: leds: add DT bindings for max77650
  dt-bindings: input: add DT bindings for max77650
  mfd: max77650: new core mfd driver
  power: supply: max77650: add support for battery charger
  gpio: max77650: add GPIO support
  leds: max77650: add LEDs support
  input: max77650: add onkey support
  MAINTAINERS: add an entry for max77650 mfd driver

 .../bindings/gpio/gpio-max77650.txt           |  34 ++
 .../bindings/input/max77650-onkey.txt         |  26 ++
 .../bindings/leds/leds-max77650.txt           |  57 +++
 .../devicetree/bindings/mfd/max77650.txt      |  28 ++
 .../power/supply/max77650-charger.txt         |  27 ++
 MAINTAINERS                                   |  14 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-max77650.c                  | 189 ++++++++++
 drivers/input/misc/Kconfig                    |   9 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/max77650-onkey.c           | 127 +++++++
 drivers/leds/Kconfig                          |   6 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-max77650.c                  | 147 ++++++++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77650.c                        | 342 +++++++++++++++++
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max77650-charger.c       | 355 ++++++++++++++++++
 include/linux/mfd/max77650.h                  |  59 +++
 22 files changed, 1450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 drivers/gpio/gpio-max77650.c
 create mode 100644 drivers/input/misc/max77650-onkey.c
 create mode 100644 drivers/leds/leds-max77650.c
 create mode 100644 drivers/mfd/max77650.c
 create mode 100644 drivers/power/supply/max77650-charger.c
 create mode 100644 include/linux/mfd/max77650.h

-- 
2.20.1

