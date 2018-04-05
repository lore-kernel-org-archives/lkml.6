Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDELiy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:38:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeDELix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:38:53 -0400
Date: Thu, 5 Apr 2018 13:38:51 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 4.17
Message-ID: <nycvar.YFH.7.76.1804051333400.28129@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

to receive HID updates for 4.17 merge window

=====
- 3rd generation Wacom Intuos BT device support from Aaron Armstrong 
  Skomra
- Support for support for NSG-MR5U and NSG-MR7U devices from Todd Kelner
- Multitouch Razer Blade Stealth support from Benjamin Tissoires
- Elantech toucpad support from Alexandrov Stansilav
- a few other scattered-around fixes and cleanups to drivers and
  generic code
=====

Thanks.

----------------------------------------------------------------
Aaron Armstrong Skomra (3):
      HID: wacom: Add support for 3rd generation Intuos BT
      HID: wacom: generic: Support multiple tools per report
      HID: wacom: generic: add the "Report Valid" usage

Aaron Bottegal (1):
      HID: corsair: Add K70 Vengeance and K70 RAPIDFIRE to

Aaron Ma (3):
      HID: i2c-hid: fix size check and type usage
      HID: core: Fix size as type u32
      HID: Fix hid_report_len usage

Aishwarya Pant (2):
      HID: logitech-hidpp: document sysfs interface
      HID: ntrig: document sysfs interface

Alexandrov Stansilav (1):
      HID: Add driver for USB ELAN Touchpad

Andy Shevchenko (1):
      HID: i2c-hid: Use ACPI_COMPANION() directly

Benjamin Tissoires (8):
      HID: core: rewrite the hid-generic automatic unbind
      HID: multitouch: export a quirk for the button handling of touchpads
      HID: multitouch: remove dead zones of Razer Blade Stealth
      HID: use BIT macro instead of plain integers for flags
      HID: use BIT() macro for quirks too
      HID: core: remove the need for HID_QUIRK_NO_EMPTY_INPUT
      HID: multitouch: do not set HID_QUIRK_NO_INIT_REPORTS
      HID: core: reset the quirks before calling probe again

Colin Ian King (1):
      HID: asus: make array 'buf' static const

Filip Alac (1):
      HID: usbhid: extend the polling interval configuration to keyboards

Gustavo A. R. Silva (2):
      HID: hid-ntrig: use true and false for boolean values
      HID: hid-multitouch: Use true and false for boolean values

Guus Sliepen (1):
      HID: corsair: Add support for the GLAIVE RGB gaming mouse

Haridhar Kalvala (1):
      HID: google: Enable PM Full On mode when adjusting backlight

Jiri Kosina (1):
      HID: wacom: wacom_wac_collection() is local to wacom_wac.c

Todd Kelner (1):
      HID: sony: Add touchpad support for NSG-MR5U and NSG-MR7U remotes

Tomasz Kramkowski (2):
      HID: elecom: refer to trackballs by model name instead of series
      HID: elecom: add support for EX-G M-XT4DRBK trackball

Wei-Ning Huang (1):
      HID: google: add google hammer HID driver

Xiongfeng Wang (1):
      HID: uhid: use strlcpy() instead of strncpy()

 .../ABI/testing/sysfs-driver-hid-logitech-hidpp    |  19 +
 Documentation/ABI/testing/sysfs-driver-hid-ntrig   |  70 ++++
 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 drivers/hid/Kconfig                                |  20 +-
 drivers/hid/Makefile                               |   2 +
 drivers/hid/hid-asus.c                             |   7 +-
 drivers/hid/hid-core.c                             |  47 ++-
 drivers/hid/hid-corsair.c                          |  24 +-
 drivers/hid/hid-elan.c                             | 421 +++++++++++++++++++++
 drivers/hid/hid-elecom.c                           |  32 +-
 drivers/hid/hid-generic.c                          |  33 --
 drivers/hid/hid-google-hammer.c                    | 138 +++++++
 drivers/hid/hid-ids.h                              |  21 +-
 drivers/hid/hid-input.c                            |  13 +-
 drivers/hid/hid-multitouch.c                       |  68 ++--
 drivers/hid/hid-ntrig.c                            |  12 +-
 drivers/hid/hid-quirks.c                           |  20 +-
 drivers/hid/hid-rmi.c                              |   4 +-
 drivers/hid/hid-sony.c                             | 131 ++++++-
 drivers/hid/hid-uclogic.c                          |   1 -
 drivers/hid/i2c-hid/i2c-hid.c                      |  17 +-
 drivers/hid/uhid.c                                 |  12 +-
 drivers/hid/usbhid/hid-core.c                      |  12 +-
 drivers/hid/wacom_sys.c                            |   4 +-
 drivers/hid/wacom_wac.c                            | 223 ++++++++---
 drivers/hid/wacom_wac.h                            |   4 +-
 include/linux/hid.h                                |  75 ++--
 27 files changed, 1180 insertions(+), 253 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-ntrig
 create mode 100644 drivers/hid/hid-elan.c
 create mode 100644 drivers/hid/hid-google-hammer.c

-- 
Jiri Kosina
SUSE Labs
