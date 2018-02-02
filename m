Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeBBK7W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:59:22 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:39428 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeBBK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:59:16 -0500
Date: Fri, 2 Feb 2018 11:59:02 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 4.16
Message-ID: <20180202105902.GA9418@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.16.

Not much this cycle. I've pushed the at32ap700x removal late but it is
unlikely to cause any issue.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.16

for you to fetch changes up to 4402be2b4ca7f53b6213a9e6b3abe9cdcc683e9b:

  rtc: remove rtc-at32ap700x (2018-01-19 09:59:32 +0100)

----------------------------------------------------------------
RTC for 4.16

Subsystem:
 - Move ABI documentation to Documentation/ABI

New driver:
 - NXP i.MX53 SRTC
 - Chrome OS EC RTC

Drivers:
 - Remove at32ap700x
 - Many fixes in various error paths

----------------------------------------------------------------
Aishwarya Pant (2):
      Documentation: rtc: add sysfs file permissions
      Documentation: rtc: move iotcl interface documentation to ABI

Alexandre Belloni (2):
      rtc: ac100: Fix multiple race conditions
      Documentation: rtc: move sysfs documentation to ABI

Alexey Khoroshilov (1):
      rtc: brcmstb-waketimer: fix error handling in brcmstb_waketmr_probe()

Andreas Platschek (1):
      rtc: omap: fix unbalanced clk_prepare_enable/clk_disable_unprepare

Arnd Bergmann (1):
      rtc: mxc_v2: remove __exit annotation

Benjamin Gaignard (1):
      rtc: stm32: Fix copyright

Cole Robinson (1):
      rtc: Remove unused RTC_DEVICE_NAME_SIZE

Colin Ian King (1):
      rtc: sun6i: ensure rtc is kfree'd on error

Corentin Labbe (1):
      rtc: remove rtc-at32ap700x

Fabio Estevam (1):
      rtc: mxc_v2: Remove unnecessary platform_get_resource() error check

Jia-Ju Bai (2):
      rtc: r7301: Fix a possible sleep-in-atomic bug in rtc7301_read_time
      rtc: r7301: Fix a possible sleep-in-atomic bug in rtc7301_set_time

Nobuhiro Iwamatsu (1):
      rtc: r9701: Remove r9701_remove function

Patrick Bruenn (2):
      dt-bindings: rtc: add bindings for i.MX53 SRTC
      rtc: add mxc driver for i.MX53 SRTC

Stephen Barber (2):
      mfd: cros_ec: Introduce RTC commands and events definitions.
      rtc: cros-ec: add cros-ec-rtc driver.

 Documentation/ABI/testing/rtc-cdev                 |  42 +++
 Documentation/ABI/testing/sysfs-class-rtc          |  91 +++++
 .../devicetree/bindings/rtc/rtc-mxc_v2.txt         |  17 +
 Documentation/rtc.txt                              |  81 +---
 drivers/rtc/Kconfig                                |  27 +-
 drivers/rtc/Makefile                               |   3 +-
 drivers/rtc/rtc-ac100.c                            |  19 +-
 drivers/rtc/rtc-at32ap700x.c                       | 287 --------------
 drivers/rtc/rtc-brcmstb-waketimer.c                |  15 +-
 drivers/rtc/rtc-cros-ec.c                          | 413 ++++++++++++++++++++
 drivers/rtc/rtc-mxc_v2.c                           | 419 +++++++++++++++++++++
 drivers/rtc/rtc-omap.c                             |   5 +-
 drivers/rtc/rtc-r7301.c                            |   4 +-
 drivers/rtc/rtc-r9701.c                            |   6 -
 drivers/rtc/rtc-stm32.c                            |   4 +-
 drivers/rtc/rtc-sun6i.c                            |   4 +-
 include/linux/mfd/cros_ec_commands.h               |   8 +
 include/linux/rtc.h                                |   1 -
 18 files changed, 1049 insertions(+), 397 deletions(-)
 create mode 100644 Documentation/ABI/testing/rtc-cdev
 create mode 100644 Documentation/ABI/testing/sysfs-class-rtc
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt
 delete mode 100644 drivers/rtc/rtc-at32ap700x.c
 create mode 100644 drivers/rtc/rtc-cros-ec.c
 create mode 100644 drivers/rtc/rtc-mxc_v2.c

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
