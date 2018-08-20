Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7E3C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1735B2173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1735B2173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeHUAj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:39:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52822 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbeHUAj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:39:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EB1FF20750; Mon, 20 Aug 2018 23:22:08 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id B35D8207AD;
        Mon, 20 Aug 2018 23:21:58 +0200 (CEST)
Date:   Mon, 20 Aug 2018 23:21:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 4.19
Message-ID: <20180820212157.GA20956@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.19.

It is now possible to add custom sysfs attributes while avoiding a
possible race condition. Unused code has been removed resulting in a
nice reduction of the code base. And more drivers have been switched to
SPDX by their maintainers.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.19

for you to fetch changes up to 6b583a64fd1e019fd01626b46892ebf2361951c5:

  rtc: ds1307: simplify hwmon config (2018-08-16 07:46:41 +0200)

----------------------------------------------------------------
RTC for 4.19

Subsystem:
 - new helpers to add custom sysfs attributes
 - struct rtc_task removal along with rtc_irq_register/rtc_irq_unregister
 - rtc_irq_set_state and rtc_irq_set_freq are not exported anymore

Drivers:
 - armada38x: reset after rtc power loss
 - ds1307: now supports m41t11
 - isl1208: now supports isl1219 and tamper detection
 - pcf2127: internal SRAM support

----------------------------------------------------------------
Alexandre Belloni (10):
      rtc: ds1685: remove improper datetime access ABI
      rtc: ds1685: remove sysfs access to control registers
      rtc: sa1100: don't set PIE frequency
      rtc: sh: remove dead code
      rtc: remove rtc_irq_register/rtc_irq_unregister
      rtc: remove irq_task and irq_task_lock
      rtc: simplify rtc_irq_set_state/rtc_irq_set_freq
      rtc: unexport rtc_irq_set_*
      char: rtc: remove task handling
      rtc: remove struct rtc_task

Alvin Šipraga (1):
      rtc: pcf85063: preserve control register value between stop and start

Anders Roxell (1):
      rtc: sh: remove unused variable rtc_dev

Arnd Bergmann (1):
      rtc: use ktime_get_real_ts64() instead of getnstimeofday64()

Baruch Siach (1):
      rtc: armada38x: reset after rtc power loss

Colin Ian King (2):
      rtc: test: make array pdev static
      rtc: m48t59: remove redundant pointer 'name'

Denis Osterland (4):
      rtc: sysfs: facilitate attribute add to rtc device
      rtc: isl1208: Add "evdet" interrupt source for isl1219
      rtc: isl1208: set ev-evienb bit from device tree
      rtc: isl1219: add device tree documentation

Giulio Benetti (2):
      rtc: ds1307: fix data pointer to m41t0
      rtc: ds1307: support m41t11 variant

Heiner Kallweit (1):
      rtc: ds1307: simplify hwmon config

Johan Hovold (4):
      rtc: omap: fix potential crash on power off
      rtc: omap: fix resource leak in registration error path
      rtc: omap: add missing register lock in error path
      rtc: omap: drop unnecessary register unlock around reads

Krzysztof Kozlowski (2):
      rtc: maxim: Add SPDX license identifiers
      rtc: s5m: Add SPDX license identifier

Michael Grzeschik (1):
      rtc: isl1208: add support for isl1219 with tamper detection

Trent Piepho (1):
      rtc: snvs: Add timeouts to avoid kernel lockups

Uwe Kleine-König (2):
      rtc: pcf2127: add support for accessing internal static RAM
      rtc: stmp3xxx: Don't reset the rtc in .probe() when watchdog is running

Zhouyang Jia (1):
      rtc: bq4802: add error handling for devm_ioremap

 .../devicetree/bindings/rtc/isil,isl1219.txt       |  29 +
 .../devicetree/bindings/rtc/rtc-ds1307.txt         |   1 +
 drivers/char/rtc.c                                 |  13 -
 drivers/rtc/Kconfig                                |  21 -
 drivers/rtc/class.c                                |   5 +-
 drivers/rtc/interface.c                            |  97 +---
 drivers/rtc/rtc-armada38x.c                        |  23 +
 drivers/rtc/rtc-bq4802.c                           |   4 +
 drivers/rtc/rtc-core.h                             |  14 +
 drivers/rtc/rtc-dev.c                              |   8 +-
 drivers/rtc/rtc-ds1307.c                           |  18 +-
 drivers/rtc/rtc-ds1685.c                           | 590 ---------------------
 drivers/rtc/rtc-isl1208.c                          | 192 ++++++-
 drivers/rtc/rtc-m48t59.c                           |   4 -
 drivers/rtc/rtc-max77686.c                         |  20 +-
 drivers/rtc/rtc-max8997.c                          |  20 +-
 drivers/rtc/rtc-max8998.c                          |  20 +-
 drivers/rtc/rtc-omap.c                             |  23 +-
 drivers/rtc/rtc-pcf2127.c                          |  68 ++-
 drivers/rtc/rtc-pcf85063.c                         |  21 +-
 drivers/rtc/rtc-s5m.c                              |  22 +-
 drivers/rtc/rtc-sa1100.c                           |   1 -
 drivers/rtc/rtc-sh.c                               |  90 +---
 drivers/rtc/rtc-snvs.c                             | 105 ++--
 drivers/rtc/rtc-stmp3xxx.c                         |  20 +-
 drivers/rtc/rtc-sysfs.c                            |  43 ++
 drivers/rtc/rtc-test.c                             |   2 +-
 include/linux/rtc.h                                |  21 +-
 28 files changed, 524 insertions(+), 971 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1219.txt

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
