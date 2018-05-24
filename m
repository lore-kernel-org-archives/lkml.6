Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755225AbeEXFzL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:55:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54598 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755040AbeEXFzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:55:08 -0400
X-Google-Smtp-Source: AB8JxZpZJcLVj+2ZyS+BgUyv0qgJ+pKU085T543w6cJ6ZFthBPt8wfAoQI84bqIaYsPNqSbvNOPcLA==
Date: Thu, 24 May 2018 08:54:53 +0300
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH 0/9] mfd/regulator/clk: bd71837: ROHM BD71837 PMIC driver
Message-ID: <20180524055453.GA4249@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adding support for ROHM BD71837 PMIC.

BD71837 is a programmable Power Management IC for powering single-core,
dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for
low BOM cost and compact solution footprint. It integrates 8 buck
regulators and 7 LDO’s to provide all the power rails required by the
SoC and the commonly used peripherals.

The driver aims to not limit the usage of PMIC. Thus the buck and LDO
naming is generic and not tied to any specific purposes. However there
is following limitations which make it mostly suitable for use cases
where the processor where PMIC driver is running is powered by the PMIC:

- The PMIC is not re-initialized if it resets. PMIC may reset as a
  result of voltage monitoring (over/under voltage) or due to reset
  request. Driver is only initializing PMIC at probe. This is not
  problem as long as processor controlling PMIC is powered by PMIC.

- The PMIC internal state machine is ignored by driver. Driver assumes
  the PMIC is wired so that it is always in "run" state when controlled
  by the driver.

patch 1: 
        MFD driver and definitions bringing interrupt support and
        enabling clk and regulator subsystems.
Patch 2:
        Kconfig and Makefiles for MFD.
Patches 3, 4 and 5:
        device tree binding documents.
Patch 6:
        clock subsystem and support for gated clock.
Patch 7:
        Kconfig and Makefiles for clock.
Patch 8:
        regulator driver supporting 8 bucks and 7 LDOs.
Patch 9: 
        Kconfig and Makefiles for regulators

This patch series is based on for-mfd-next

---

Matti Vaittinen (9):
  mfd: bd71837: mfd driver for ROHM BD71837 PMIC
  mfd: bd71837: build BD71837 PMIC MFD driver
  mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC
  regulator: bd71837: Devicetree bindings for BD71837 regulators
  clk: bd71837: Devicetree bindings for ROHM BD71837 PMIC
  clk: bd71837: Add driver for BD71837 PMIC clock
  clk: bd71837: Build ROHM BD71837 PMIC clock driver
  regulator: bd71837: BD71837 PMIC regulator driver
  regulator: bd71837: Build BD71837 regulator driver

 .../bindings/clock/rohm,bd71837-clock.txt          |  37 ++
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  55 ++
 .../bindings/regulator/rohm,bd71837-regulator.txt  | 124 ++++
 drivers/clk/Kconfig                                |   9 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-bd71837.c                          | 155 +++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bd71837.c                              | 238 +++++++
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/bd71837-regulator.c              | 683 +++++++++++++++++++++
 include/linux/mfd/bd71837.h                        | 316 ++++++++++
 13 files changed, 1644 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
 create mode 100644 drivers/clk/clk-bd71837.c
 create mode 100644 drivers/mfd/bd71837.c
 create mode 100644 drivers/regulator/bd71837-regulator.c
 create mode 100644 include/linux/mfd/bd71837.h

-- 
2.14.3
