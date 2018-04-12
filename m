Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeDLJ2F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:28:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39425 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeDLJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:28:03 -0400
X-Google-Smtp-Source: AIpwx4/m2I7/Tl8OEkt6dx9e/u63XEl6RbKY9nRBNWQFub2YNWSMUG/KoPK3FoqtQ84XrONXX5J7Bw==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v4.17-rc1
Date: Thu, 12 Apr 2018 11:27:59 +0200
Message-Id: <20180412092759.9984-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.17-rc1

for you to fetch changes up to 6873842235d678a245a378669f35e145df2441b9:

  pwm: rcar: Add suspend/resume support (2018-03-28 01:27:10 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.17-rc1

This set of changes adds support for more generations of the RCar
controller as well as runtime PM support. The JZ4740 driver gains
support for device tree and can now be used on all Ingenic SoCs.

Rounding things off is a random assortment of fixes and cleanups
all across the board.

----------------------------------------------------------------
Alexandre Belloni (1):
      pwm: sun4i: Properly check current state

Andre Przywara (3):
      pwm: sun4i: Drop unused .has_rdy member
      pwm: sun4i: Simplify controller mapping
      dt-bindings: pwm: sunxi: Add new compatible strings

Arvind Yadav (1):
      pwm: sysfs: Use put_device() instead of kfree()

Benjamin Gaignard (1):
      pwm: stm32: Adopt SPDX identifier

Corentin Labbe (1):
      pwm: Remove depends on AVR32

Fabio Estevam (1):
      pwm: imx: Let PWM be active during suspend

Fabrice Gasnier (2):
      pwm: stm32: Remove unused struct device
      pwm: stm32: Protect common prescaler for all channels

Fabrizio Castro (2):
      dt-bindings: pwm: renesas-tpu: Document r8a774[35] support
      dt-bindings: pwm: rcar: Document r8a774[35] PWM bindings

Geert Uytterhoeven (2):
      dt-bindings: pwm: renesas-tpu: Correct example TPU register block size
      dt-bindings: pwm: renesas-tpu: Correct SoC part numbers and family names

Gerald Baeza (2):
      dt-bindings: pwm-stm32-lp: Add #pwm-cells
      pwm: stm32: LPTimer: Use 3 cells ->of_xlate()

Hien Dang (1):
      pwm: rcar: Use PM Runtime to control module clock

Maarten ter Huurne (1):
      pwm: jz4740: Make disable operation compatible with TCU2 mode

Markus Elfring (2):
      pwm: puv3: Delete an error message for a failed memory allocation
      pwm: atmel-tcb: Delete an error message for a failed memory allocation

Paul Cercueil (3):
      pwm: jz4740: Implement ->set_polarity()
      pwm: jz4740: Add support for devicetree
      pwm: jz4740: Enable for all Ingenic SoCs

Ryo Kodama (1):
      pwm: rcar: Fix a condition to prevent mismatch value setting to duty

Sean Wang (3):
      pwm: mediatek: Fix up PWM4 and PWM5 malfunction on MT7623
      pwm: mediatek: Remove redundant MODULE_ALIAS entries
      pwm: mediatek: Improve precision in rate calculation

Yoshihiro Shimoda (2):
      dt-bindings: pwm: rcar: Add bindings for R-Car M3N support
      pwm: rcar: Add suspend/resume support

 .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt | 25 ++++++++++
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  3 ++
 .../devicetree/bindings/pwm/pwm-sun4i.txt          |  2 +
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   | 11 ++--
 .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    | 10 ++--
 drivers/pwm/Kconfig                                |  8 +--
 drivers/pwm/pwm-atmel-tcb.c                        |  1 -
 drivers/pwm/pwm-imx.c                              |  3 +-
 drivers/pwm/pwm-jz4740.c                           | 41 ++++++++++++++-
 drivers/pwm/pwm-mediatek.c                         | 36 +++++++++++---
 drivers/pwm/pwm-puv3.c                             |  4 +-
 drivers/pwm/pwm-rcar.c                             | 58 +++++++++++++++++++---
 drivers/pwm/pwm-stm32-lp.c                         |  5 +-
 drivers/pwm/pwm-stm32.c                            | 22 ++++++--
 drivers/pwm/pwm-sun4i.c                            | 38 +++++---------
 drivers/pwm/sysfs.c                                |  3 +-
 16 files changed, 206 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
