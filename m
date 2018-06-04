Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeFDXPA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:15:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36481 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeFDXO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:14:57 -0400
X-Google-Smtp-Source: ADUXVKLiB8fFD+Z/HNFskftF6CDXSC0Sh6cmJF0sia76q37lK7/JmOxx++ggX6GWBOpL3NdNrokqlg==
Date: Mon, 4 Jun 2018 16:14:54 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.18-rc0
Message-ID: <20180604231454.GA186514@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a new driver to ChipOne icn8505 based touchscreens

- on certain systems with Elan touch controllers they will be switched
  away form PS/2 emulation and over to native SMbus mode.

- assorted driver fixups and improvements.

Changelog:
---------

Benjamin Tissoires (6):
      Input: elan_i2c - add trackstick report
      Input: elantech - split device info into a separate structure
      Input: elantech - query the resolution in query_info
      Input: elantech - add support for SMBus devices
      Input: elantech - detect new ICs and setup Host Notify for them
      Input: psmouse-smbus - allow to control psmouse_deactivate

Dmitry Torokhov (1):
      Input: atmel_mxt_ts - require device properties present when probing

Ethan Lee (2):
      Input: xpad - add GPD Win 2 Controller USB IDs
      Input: goodix - add new ACPI id for GPD Win 2 touch screen

Grygorii Strashko (2):
      Input: ti_am335x_tsc - ack pending IRQs at probe and before suspend
      Input: ti_am335x_tsc - prevent system suspend when TSC is in use

Hans de Goede (1):
      Input: add support for ChipOne icn8505 based touchscreens

Johannes Wienke (1):
      Input: elan_i2c - add ELAN0612 (Lenovo v330 14IKB) ACPI ID

Leo Sperling (1):
      Input: xpad - fix some coding style issues

Marcus Folkesson (3):
      Input: xpad - avoid using __set_bit() for capabilities
      Input: as5011 - avoid using __set_bit() for capabilities
      Input: gamecon - avoid using __set_bit() for capabilities

Martin Kepplinger (1):
      Input: mk712 - update documentation web link

Nick Dyer (1):
      Input: usbtouchscreen - add sysfs attribute for 3M MTouch firmware rev

Nick Simonov (1):
      Input: replace hard coded string with __func__ in pr_err()

Pali Rohár (1):
      Input: alps - demystify trackstick initialization for v3 and v6 protocols

Ravi Chandra Sadineni (1):
      Input: cros_ec_keyb - mark cros_ec_keyb driver as wake enabled device.

Sebastian Reichel (1):
      Input: atmel_mxt_ts - fix reset-gpio for level based irqs

Wolfram Sang (1):
      Input: ati_remote2 - fix typo 'can by' to 'can be'

Diffstat:
--------

 .../devicetree/bindings/input/elan_i2c.txt         |   1 +
 MAINTAINERS                                        |   6 +
 drivers/input/input.c                              |   3 +-
 drivers/input/joystick/as5011.c                    |   4 +-
 drivers/input/joystick/gamecon.c                   |  27 +-
 drivers/input/joystick/xpad.c                      |  35 +-
 drivers/input/keyboard/cros_ec_keyb.c              |  33 +-
 drivers/input/misc/ati_remote2.c                   |   2 +-
 drivers/input/mouse/Kconfig                        |  12 +
 drivers/input/mouse/alps.c                         |  80 ++--
 drivers/input/mouse/elan_i2c_core.c                |  89 +++-
 drivers/input/mouse/elantech.c                     | 479 ++++++++++++++-----
 drivers/input/mouse/elantech.h                     |  69 ++-
 drivers/input/mouse/psmouse-base.c                 |  21 +-
 drivers/input/mouse/psmouse-smbus.c                |  24 +-
 drivers/input/mouse/psmouse.h                      |   2 +
 drivers/input/mouse/synaptics.c                    |   2 +-
 drivers/input/touchscreen/Kconfig                  |  11 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/atmel_mxt_ts.c           | 170 +------
 drivers/input/touchscreen/chipone_icn8505.c        | 520 +++++++++++++++++++++
 drivers/input/touchscreen/goodix.c                 |   1 +
 drivers/input/touchscreen/mk712.c                  |   2 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          |   7 +
 drivers/input/touchscreen/usbtouchscreen.c         |  94 ++++
 drivers/mfd/cros_ec.c                              |  19 +-
 26 files changed, 1325 insertions(+), 389 deletions(-)
 create mode 100644 drivers/input/touchscreen/chipone_icn8505.c

Thanks.


-- 
Dmitry
