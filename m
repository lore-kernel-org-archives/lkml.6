Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeFDUud (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:50:33 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45913 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeFDUub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:50:31 -0400
X-Google-Smtp-Source: ADUXVKLn3j3U6v+NHg7Auel6BnXrlBiLE0mxJI5hp3WNUHVgW/OCVmo5YbGFIxK9EqVizzGvqVGM4g==
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, andriy.shevchenko@linux.intel.com,
        baolin.wang@linaro.org, dmurphy@ti.com, lhenriques@suse.com,
        oleg@kaa.org.ua, weiyongjun1@huawei.com
Subject: [GIT PULL] LED updates for 4.18-rc1
Date: Mon,  4 Jun 2018 22:50:09 +0200
Message-Id: <1528145409-4978-1-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull LED updates for 4.18-rc1. It was quite fruitful cycle, taking
into account usual traffic on linux-leds list, as we managed to merge
three new LED class drivers.

New LED class drivers with related DT bindings:
	- add LED driver for CR0014114 board
	- add Spreadtrum SC27xx breathing light controller driver
	- introduce the lm3601x LED driver

LED class fix:
	- ensure workqueue is initialized before setting brightness

Improvements and fixes to existing LED class drivers:
	- fix return value check in sc27xx_led_probe()
	- use sysfs_match_string() helper in wm831x_status_src_store()


This is my first pull request signed with use of a subkey exported to
Nitrokey, so please let me know if something is not as expected.


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/leds_for_4.18-rc1

for you to fetch changes up to 6d71021ab3b0bd6ff98270343353b03dfae5d550:

  leds: class: ensure workqueue is initialized before setting brightness (2018-05-24 22:08:26 +0200)

Best regards,
Jacek Anaszewski

----------------------------------------------------------------
LED updates for 4.18-rc1
----------------------------------------------------------------
Andy Shevchenko (1):
      leds: wm831x-status: Use sysfs_match_string() helper

Baolin Wang (2):
      dt-bindings: leds: Add SC27xx breathing light controller documentation
      leds: Add Spreadtrum SC27xx breathing light controller driver

Dan Murphy (2):
      dt: bindings: lm3601x: Introduce the lm3601x driver
      leds: lm3601x: Introduce the lm3601x LED driver

Luis Henriques (1):
      leds: class: ensure workqueue is initialized before setting brightness

Oleh Kravchenko (2):
      dt-bindings: Add vendor prefix and docs for CR0014114
      leds: add LED driver for CR0014114 board

Wei Yongjun (1):
      leds: sc27xx: Fix return value check in sc27xx_led_probe()

 .../devicetree/bindings/leds/leds-cr0014114.txt    |  54 +++
 .../devicetree/bindings/leds/leds-lm3601x.txt      |  45 ++
 .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |  41 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/leds/Kconfig                               |  33 ++
 drivers/leds/Makefile                              |   3 +
 drivers/leds/led-class.c                           |  10 +-
 drivers/leds/leds-cr0014114.c                      | 315 +++++++++++++
 drivers/leds/leds-lm3601x.c                        | 487 +++++++++++++++++++++
 drivers/leds/leds-sc27xx-bltc.c                    | 244 +++++++++++
 drivers/leds/leds-wm831x-status.c                  |  22 +-
 11 files changed, 1237 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-cr0014114.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3601x.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
 create mode 100644 drivers/leds/leds-cr0014114.c
 create mode 100644 drivers/leds/leds-lm3601x.c
 create mode 100644 drivers/leds/leds-sc27xx-bltc.c
