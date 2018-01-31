Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932157AbeAaPs7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:48:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:40271 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932066AbeAaPs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:48:57 -0500
Date: Wed, 31 Jan 2018 16:48:55 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID
Message-ID: <nycvar.YFH.7.76.1801311625240.11852@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

to receive HID updates queued for 4.16 merge window:

=====
- Removal of hid_have_special_driver[] entry hard requirement for any 
  newly supported VID/PID by a specific non-core hid driver, and general 
  related cleanup of HID matching core, from Benjamin Tissoires

- Support for new Wacom devices and a few small fixups for already 
  supported ones in Wacom driver, from Aaron Armstrong Skomra and Jason 
  Gerecke

- sysfs interface fix for roccat driver from Dan Carpenter

- Support for new Asus HW (T100TAF, T100HA, T200TA) from Hans de Goede

- improved support for Jabra devices, from Niels Skou Olsen

- other assorted small fixes and new device IDs
=====

Thanks.

----------------------------------------------------------------
Aaron Armstrong Skomra (1):
      HID: wacom: EKR: ensure devres groups at higher indexes are released

Andrew Duggan (1):
      HID: rmi: Support the Fujitsu R726 Pad dock using hid-rmi

Andy Shevchenko (1):
      HID: sony: Print reversed MAC address via %pMR

Benjamin Tissoires (4):
      HID: core: move the dynamic quirks handling in core
      HID: quirks: move the list of special devices into a quirk
      HID: core: move the list of ignored devices in hid-quirks.c
      HID: core: remove the absolute need of hid_have_special_driver[]

Colin Ian King (1):
      HID: quirks: make array hid_quirks static

Dan Carpenter (1):
      HID: roccat: prevent an out of bounds read in kovaplus_profile_activated()

Dave Young (1):
      HID: add quirk for another PIXART OEM mouse used by HP

Hans de Goede (8):
      HID: multitouch: Fix alphabetic sorting of mt_devices table.
      HID: multitouch: Properly deal with Win8 PTP reports with 0 touches
      HID: multitouch: Only look at non touch fields in first packet of a frame
      HID: multitouch: Combine all left-button events in a frame
      HID: asus: Add product-id for the T100TAF and T100HA keyboard docks
      HID: asus: Add touchpad max x/y and resolution info for the T200TA
      HID: asus: Fix special function keys on T200TA
      HID: quirks: Fix keyboard + touchpad on Toshiba Click Mini not working

Jason Gerecke (4):
      HID: wacom: Properly handle AES serial number and tool type
      HID: wacom: Queue events with missing type/serial data for later processing
      HID: wacom: Fix reporting of touch toggle (WACOM_HID_WD_MUTE_DEVICE) events
      HID: wacom: Add support for One by Wacom (CTL-472 / CTL-672)

Jiri Kosina (1):
      HID: elo: clear BTN_LEFT mapping

Niels Skou Olsen (2):
      HID: Ignore Jabra HID interface based on firmware version
      HID: Add special driver for Jabra devices

Rajat Jain (1):
      HID: i2c-hid: Allow ACPI systems to specify "post-power-on-delay-ms"

Roderick Colenbrander (1):
      HID: sony: Report DS4 version info through sysfs

Srinivas Pandruvada (1):
      HID: intel-ish-hid: Enable Cannon Lake and Coffee Lake laptop/desktop

Tomasz Kramkowski (1):
      HID: elecom: rewrite report fixup for EX-G and future mice

Wei-Ning Huang (1):
      HID: hid-multitouch: support fine-grain orientation reporting

 .../devicetree/bindings/input/hid-over-i2c.txt     |    2 +-
 Documentation/input/multi-touch-protocol.rst       |    9 +-
 drivers/hid/Kconfig                                |   12 +
 drivers/hid/Makefile                               |    3 +-
 drivers/hid/hid-asus.c                             |   41 +-
 drivers/hid/hid-core.c                             |  932 +-------------
 drivers/hid/hid-elecom.c                           |   78 +-
 drivers/hid/hid-elo.c                              |    6 +
 drivers/hid/hid-generic.c                          |   68 +-
 drivers/hid/hid-ids.h                              |    7 +-
 drivers/hid/hid-jabra.c                            |   58 +
 drivers/hid/hid-multitouch.c                       |  137 ++-
 drivers/hid/hid-quirks.c                           | 1276 ++++++++++++++++++++
 drivers/hid/hid-rmi.c                              |    1 +
 drivers/hid/hid-roccat-kovaplus.c                  |    2 +
 drivers/hid/hid-sony.c                             |   93 +-
 drivers/hid/i2c-hid/i2c-hid.c                      |   18 +-
 drivers/hid/intel-ish-hid/ipc/hw-ish.h             |    1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |    1 +
 drivers/hid/usbhid/Makefile                        |    2 +-
 drivers/hid/usbhid/hid-core.c                      |   11 +-
 drivers/hid/usbhid/hid-quirks.c                    |  402 ------
 drivers/hid/wacom_sys.c                            |  134 +-
 drivers/hid/wacom_wac.c                            |   67 +-
 drivers/hid/wacom_wac.h                            |    6 +
 include/linux/hid.h                                |   22 +-
 net/bluetooth/hidp/core.c                          |    2 +-
 27 files changed, 1995 insertions(+), 1396 deletions(-)
 create mode 100644 drivers/hid/hid-jabra.c
 create mode 100644 drivers/hid/hid-quirks.c
 delete mode 100644 drivers/hid/usbhid/hid-quirks.c

-- 
Jiri Kosina
SUSE Labs
