Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23549C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED7321473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gjaZIx/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfA2Nfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:35:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50355 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfA2Nfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:35:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so17903124wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYbQf7Ftq94NoTrCoNs53HmaI2VN3lVTpXUwyN8aUw8=;
        b=gjaZIx/Mm3Y5mJ6EkZT9uPrwbdHOWndGA88lUCRIJpwbBZMR7BFoTDlsozVAWx+XD/
         KINjIu3NONzFYp5FRE97lvNJO9ydXF58a0ydblP2mB3xowX6dyL2z68XPUneSSY8a28E
         P86DUBzSr0PJBOR1b0ahEnByJL26SHJOFSk7neAruXl5ZlJxyABliGz8hS776epmYOaR
         i07W+zqmJe+KPf2E8I0bNqi0YJ8zTC5OOipdikqaB6YpT3QYDh+2X7+Vf/10pUKRPcO7
         UUCiC/kHQPLXKZxi5YDsGkRVFCe/5651MZbb/tC3U2MEmnAQupTmSq6OA1/7rNbcx/XP
         MCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYbQf7Ftq94NoTrCoNs53HmaI2VN3lVTpXUwyN8aUw8=;
        b=ELhRYO6BJoZYD21zE7TeZWJ1dRli/rUKdXuPX7qfbzECT2MwU1PgXg30l4lpabvume
         FK2MO8bIKqRmZOx4vrMMEYnaPOU8I3aJE/T65XKzuqxzKDiqIf+hCmNx5HXP0cUTeGQ0
         MkS/Im+RTMDuDnnH/KLyrNHE7IRhcWTu0WCyb2VD7JLVBgJodWBR/Xt/IkS3/4I0hx1j
         2w0MTYs+cFIsTwwYgmoK+N8qp6Ouw+yhVS+IHl8XbMF+jPdtgX70MqHsR7O3JhqqVKMT
         lmiJ41gwhGXIsg5d2m3LGSmiDmNOxNy+HFEU4rim7A7phYThhvJQ2Zxt7V/r0ajJ6iod
         DYcg==
X-Gm-Message-State: AJcUukei6dl/nydhwQXEqos7dJTu3eMqIAMj0UCH+RT5VmcfndU1Ulh0
        UNSl8hZ4ph5dbVIhoCbsqFG3vg==
X-Google-Smtp-Source: ALg8bN6OHIN3kNRPaoTOigcQGvWPgNdY67rcuLzp6rmQBMJ7taD36vgSYyt3nMJpNphEAD9362GNlg==
X-Received: by 2002:a1c:494:: with SMTP id 142mr21257911wme.111.1548768951009;
        Tue, 29 Jan 2019 05:35:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:35:50 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 00/13] mfd: add support for max77650 PMIC
Date:   Tue, 29 Jan 2019 14:35:31 +0100
Message-Id: <20190129133545.1931-1-brgl@bgdev.pl>
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

Bartosz Golaszewski (13):
  dt-bindings: mfd: add DT bindings for max77650
  dt-bindings: regulator: add DT bindings for max77650
  dt-bindings: power: supply: add DT bindings for max77650
  dt-bindings: gpio: add DT bindings for max77650
  dt-bindings: leds: add DT bindings for max77650
  dt-bindings: input: add DT bindings for max77650
  mfd: max77650: new core mfd driver
  regulator: max77650: add regulator support
  power: supply: max77650: add support for battery charger
  gpio: max77650: add GPIO support
  leds: max77650: add LEDs support
  input: max77650: add onkey support
  MAINTAINERS: add an entry for max77650 mfd driver

 .../bindings/gpio/gpio-max77650.txt           |  34 ++
 .../bindings/input/max77650-onkey.txt         |  26 +
 .../bindings/leds/leds-max77650.txt           |  57 ++
 .../devicetree/bindings/mfd/max77650.txt      |  28 +
 .../power/supply/max77650-charger.txt         |  27 +
 .../bindings/regulator/max77650-regulator.txt |  41 ++
 MAINTAINERS                                   |  14 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-max77650.c                  | 189 +++++++
 drivers/input/misc/Kconfig                    |   9 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/max77650-onkey.c           | 127 +++++
 drivers/leds/Kconfig                          |   6 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-max77650.c                  | 152 +++++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77650.c                        | 338 ++++++++++++
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max77650-charger.c       | 355 ++++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77650-regulator.c        | 518 ++++++++++++++++++
 include/linux/mfd/max77650.h                  |  59 ++
 26 files changed, 2019 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt
 create mode 100644 drivers/gpio/gpio-max77650.c
 create mode 100644 drivers/input/misc/max77650-onkey.c
 create mode 100644 drivers/leds/leds-max77650.c
 create mode 100644 drivers/mfd/max77650.c
 create mode 100644 drivers/power/supply/max77650-charger.c
 create mode 100644 drivers/regulator/max77650-regulator.c
 create mode 100644 include/linux/mfd/max77650.h

-- 
2.20.1

