Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DFFC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529BF2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeLaRqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:46:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49751 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbeLaRqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 12:46:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EA26420736; Mon, 31 Dec 2018 18:46:07 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id BA538206A6;
        Mon, 31 Dec 2018 18:45:57 +0100 (CET)
Date:   Mon, 31 Dec 2018 18:45:57 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 4.21
Message-ID: <20181231174557.GA16020@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the pull request for the RTC subsystem. I'm sorry to be so late
but lkp reported a bug breaking boot on some random configurations that
was not trivial to reproduce at the beginning of the merge window and I
wanted to fix it before sending the PR. With the end of year
celebrations, this took me some time. I also took that opportunity to
sneak in a file rename that kbuild tested on 178 configurations so this
should not cause any issues.

Have an happy new year's eve.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.21

for you to fetch changes up to 36e14f5fdfdf7cec8887b7ff69cd9bb5051ecf62:

  rtc: rename core files (2018-12-31 11:36:16 +0100)

----------------------------------------------------------------
RTC for 4.21

Subsystem:
 - new %ptR printk format
 - rename core files
 - allow registration of multiple nvmem devices

New driver:
 - i.MX system controller RTC

Drivers:
 - abx80x: handle voltage ioctls, correct binding doc
 - m41t80: correct month in alarm reads
 - pcf85363: add pcf85263 support
 - pcf8523: properly handle battery low flag
 - s3c: limit alarm to one year in the future as ALMYEAR is broken
 - sun6i: rework clock output binding

----------------------------------------------------------------
Alexandre Belloni (8):
      rtc: class: remove devm_rtc_device_unregister
      rtc: nvmem: use devm_nvmem_register()
      rtc: nvmem: remove nvmem from struct rtc_device
      rtc: enforce rtc_timer_init private_data type
      rtc: class: reimplement devm_rtc_device_register
      rtc: pcf2123: Add Microcrystal rv2123
      rtc: nvmem: fix possible use after free
      rtc: rename core files

Andy Shevchenko (20):
      lib/vsprintf: Print time and date in human readable format via %pt
      rtc: Switch to use %ptR
      rtc: at91rm9200: Switch to use %ptR
      rtc: at91sam9: Switch to use %ptR
      rtc: m41t80: Switch to use %ptR
      rtc: m48t59: Switch to use %ptR
      rtc: mcp795: Switch to use %ptR
      rtc: pcf50633: Switch to use %ptR
      rtc: pic32: Switch to use %ptR
      rtc: pm8xxx: Switch to use %ptR
      rtc: puv3: Switch to use %ptR
      rtc: rk808: Switch to use %ptR
      rtc: rx6110: Switch to use %ptR
      rtc: rx8025: Switch to use %ptR
      rtc: s3c: Switch to use %ptR
      rtc: s5m: Switch to use %ptR
      rtc: tegra: Switch to use %ptR
      Input: hp_sdc_rtc - Switch to use %ptR
      m68k/mac: Switch to use %ptR
      PM: Switch to use %ptR

Anson Huang (2):
      dt-bindings: fsl: scu: add rtc binding
      rtc: add i.MX system controller RTC support

Baruch Siach (2):
      rtc: dt-binding: abx80x: fix resistance scale
      rtc: pcf8523: don't return invalid date when battery is low

Biju Das (2):
      dt-bindings: rtc: pcf85363: Document pcf85263 real-time clock
      rtc: pcf85363: Add support for NXP pcf85263 rtc

Chen-Yu Tsai (9):
      dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a list
      dt-bindings: rtc: sun6i-rtc: Add compatible strings for pre-H6 variants
      dt-bindings: rtc: sun6i-rtc: Deprecate external clock output for A31
      dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
      rtc: sun6i: Add default clock name for LOSC
      rtc: sun6i: Add support for different variants
      rtc: sun6i: Add support for all known pre-H6 variants
      rtc: sun6i: Expose internal oscillator through device tree
      dt-bindings: rtc: sun6i-rtc: Fix register range in example

Christophe JAILLET (2):
      rtc: max77686: Fix the returned value in case of error in 'max77686_rtc_read_time()'
      rtc: max8997: Fix the returned value in case of error in 'max8997_rtc_read_alarm()'

Colin Ian King (1):
      rtc: clean up indentation issues, remove extraneous space, add missing tabs

Kuninori Morimoto (1):
      rtc: sh: convert to SPDX identifiers

Lubomir Rintel (1):
      dt-bindings: rtc: use a generic node name for ds1307

Maciej W. Rozycki (2):
      rtc: m41t80: Correct alarm month range with RTC reads
      rtc: m41t80: Complete error propagation from SMBus calls

Marek Szyprowski (1):
      rtc: s3c-rtc: Avoid using broken ALMYEAR register

Marek Vasut (1):
      rtc: abx80x: Implement RTC_VL_READ,CLR ioctls

Nathan Chancellor (1):
      rtc: omap: Use define directive for PIN_CONFIG_ACTIVE_HIGH

Trent Piepho (1):
      rtc: isl1208: Use i2c block read/write routines

 Documentation/core-api/printk-formats.rst          |  18 ++
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  10 ++
 .../devicetree/bindings/rtc/abracon,abx80x.txt     |   2 +-
 .../devicetree/bindings/rtc/nxp,rtc-2123.txt       |   1 +
 Documentation/devicetree/bindings/rtc/pcf85363.txt |   4 +-
 .../devicetree/bindings/rtc/rtc-ds1307.txt         |   2 +-
 .../devicetree/bindings/rtc/sun6i-rtc.txt          |  33 +++-
 arch/m68k/mac/misc.c                               |   8 +-
 drivers/base/power/trace.c                         |   4 +-
 drivers/char/rtc.c                                 |   7 +-
 drivers/input/misc/hp_sdc_rtc.c                    |   8 +-
 drivers/rtc/Kconfig                                |   7 +
 drivers/rtc/Makefile                               |   9 +-
 drivers/rtc/class.c                                | 187 +++++----------------
 drivers/rtc/{rtc-dev.c => dev.c}                   |   0
 drivers/rtc/hctosys.c                              |   8 +-
 drivers/rtc/interface.c                            |  27 ++-
 drivers/rtc/{rtc-lib.c => lib.c}                   |   0
 drivers/rtc/nvmem.c                                |  38 ++---
 drivers/rtc/{rtc-proc.c => proc.c}                 |  36 +---
 drivers/rtc/rtc-abx80x.c                           |  38 +++++
 drivers/rtc/rtc-at91rm9200.c                       |  15 +-
 drivers/rtc/rtc-at91sam9.c                         |  16 +-
 drivers/rtc/rtc-ep93xx.c                           |   2 +-
 drivers/rtc/rtc-imx-sc.c                           |  91 ++++++++++
 drivers/rtc/rtc-isl1208.c                          |  37 +---
 drivers/rtc/rtc-m41t80.c                           |  21 ++-
 drivers/rtc/rtc-m48t59.c                           |   8 +-
 drivers/rtc/rtc-max6916.c                          |   2 +-
 drivers/rtc/rtc-max77686.c                         |   2 +-
 drivers/rtc/rtc-max8997.c                          |   2 +-
 drivers/rtc/rtc-mcp795.c                           |  18 +-
 drivers/rtc/rtc-omap.c                             |   4 +-
 drivers/rtc/rtc-pcf2123.c                          |   1 +
 drivers/rtc/rtc-pcf50633.c                         |   8 +-
 drivers/rtc/rtc-pcf8523.c                          |  32 +++-
 drivers/rtc/rtc-pcf85363.c                         |  94 +++++++++--
 drivers/rtc/rtc-pic32.c                            |  18 +-
 drivers/rtc/rtc-pm8xxx.c                           |  16 +-
 drivers/rtc/rtc-puv3.c                             |  18 +-
 drivers/rtc/rtc-rk808.c                            |  22 +--
 drivers/rtc/rtc-rx6110.c                           |  12 +-
 drivers/rtc/rtc-rx8025.c                           |  19 +--
 drivers/rtc/rtc-s3c.c                              |  26 +--
 drivers/rtc/rtc-s5m.c                              |  27 +--
 drivers/rtc/rtc-sh.c                               |   7 +-
 drivers/rtc/rtc-sun6i.c                            | 121 ++++++++++++-
 drivers/rtc/rtc-tegra.c                            |  30 +---
 drivers/rtc/{rtc-sysfs.c => sysfs.c}               |  16 +-
 include/linux/rtc.h                                |  17 +-
 lib/test_printf.c                                  |  61 ++++++-
 lib/vsprintf.c                                     | 100 +++++++++++
 52 files changed, 744 insertions(+), 566 deletions(-)
 rename drivers/rtc/{rtc-dev.c => dev.c} (100%)
 rename drivers/rtc/{rtc-lib.c => lib.c} (100%)
 rename drivers/rtc/{rtc-proc.c => proc.c} (67%)
 create mode 100644 drivers/rtc/rtc-imx-sc.c
 rename drivers/rtc/{rtc-sysfs.c => sysfs.c} (97%)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
