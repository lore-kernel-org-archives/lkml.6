Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF7BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3694208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3694208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeHTTj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:39:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:38572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbeHTTj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:39:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BEF0AFFE;
        Mon, 20 Aug 2018 16:23:07 +0000 (UTC)
Date:   Mon, 20 Aug 2018 18:23:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID
Message-ID: <nycvar.YFH.7.76.1808201816300.25787@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

to receive HID subsystem updates:

=====
- touch_max detection improvements and quirk handling fixes in wacom
  driver from Jason Gerecke and Ping Cheng
- Palm rejection from Dmitry Torokhov and _dial support from Benjamin  
  Tissoires for hid-multitouch driver
- Low voltage support for i2c-hid driver from Stephen Boyd
- Guitar-Hero support from Nicolas Adenis-Lamarre
- other assorted small fixes and device ID additions
=====

Thanks.

----------------------------------------------------------------
Anton Vasilyev (1):
      HID: intel_ish-hid: tx_buf memory leak on probe/remove

Benjamin Tissoires (9):
      input: add MT_TOOL_DIAL
      HID: multitouch: make sure the static list of class is not changed
      HID: multitouch: Store per collection multitouch data
      HID: multitouch: store a per application quirks value
      HID: multitouch: ditch mt_report_id
      HID: multitouch: remove one copy of values
      HID: input: enable Totem on the Dell Canvas 27
      HID: core: do not upper bound the collection stack
      HID: microsoft: support the Surface Dial

Colin Ian King (1):
      HID: intel-ish-hid: remove redundant variable num_frags

Daniel M. Lambea (2):
      HID: cougar: make compare_device_paths reusable
      HID: cougar: Add support for the Cougar 500k Gaming Keyboard

Dmitry Torokhov (3):
      HID: multitouch: report MT_TOOL_PALM for non-confident touches
      HID: multitouch: touchscreens also use confidence reports
      HID: multitouch: handle palm for touchscreens

Hanno Zulla (5):
      HID: hid-sony.c: Use devm_ api to simplify sony_register_touchpad()
      HID: hid-sony.c: Use devm_ api to simplify sony_register_sensors()
      HID: hid-sony.c: Use devm_ api to simplify sony_leds_init()
      HID: hid-sony.c: Use devm_ api to simplify sony_battery_probe()
      HID: hid-sony.c: Use devm_ api to simplify sc->output_report_dmabuf

Hans de Goede (9):
      HID: elan: Remove unused max_area_x and max_area_y vatiables
      HID: elan: Stop claiming we have TOUCH_MAJOR and then never reporting it
      HID: elan: Correctly report MT_PRESSURE instead of TOOL_WIDTH
      HID: elan: Hardcode finger-count and usb-interface
      HID: elan: Query device max_x and max_y value from touchpad
      HID: elan: Query resolution from the touchpad
      HID: elan: Add a flag for selecting if the touchpad has a LED
      HID: elan: Add USB-id for HP x2 10-n000nd touchpad
      HID: elan: Add support for touchpad on the Toshiba Click Mini L9W

Jason Gerecke (2):
      HID: wacom: Replace touch_max fixup code with static touch_max definitions
      HID: wacom: Move handling of HID quirks into a dedicated function

Nicolas Adenis-Lamarre (1):
      HID: wiimote: add support for Guitar-Hero devices

Ping Cheng (1):
      HID: wacom: convert Wacom custom usages to standard HID usages

Robert Munteanu (1):
      HID: redragon: fix num lock and caps lock LEDs

Sebastian Andrzej Siewior (1):
      HID: usbhid: use irqsave() in USB's complete callback

Srinivas Pandruvada (1):
      HID: intel-ish-hid: Prevent loading of driver on Mehlow

Stephen Boyd (2):
      HID: i2c-hid: Use devm to allocate i2c_hid struct
      HID: i2c-hid: Add vddl regulator control

Zhouyang Jia (1):
      HID: hid-ntrig: add error handling for sysfs_create_group

 .../devicetree/bindings/input/hid-over-i2c.txt     |   3 +-
 Documentation/input/multi-touch-protocol.rst       |  12 +-
 drivers/hid/Kconfig                                |  10 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/hid-core.c                             |  40 +-
 drivers/hid/hid-cougar.c                           | 312 +++++++
 drivers/hid/hid-elan.c                             | 235 +++--
 drivers/hid/hid-ids.h                              |   5 +
 drivers/hid/hid-input.c                            |   3 +
 drivers/hid/hid-microsoft.c                        |  49 +-
 drivers/hid/hid-multitouch.c                       | 989 +++++++++++++--------
 drivers/hid/hid-ntrig.c                            |   2 +
 drivers/hid/hid-redragon.c                         |  26 +-
 drivers/hid/hid-sony.c                             | 164 +---
 drivers/hid/hid-wiimote-core.c                     |  14 +
 drivers/hid/hid-wiimote-modules.c                  | 440 +++++++++
 drivers/hid/hid-wiimote.h                          |   3 +
 drivers/hid/i2c-hid/i2c-hid.c                      |  57 +-
 drivers/hid/intel-ish-hid/ipc/ipc.c                |   9 +-
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |  13 +-
 drivers/hid/intel-ish-hid/ishtp/hbm.c              |   2 -
 drivers/hid/usbhid/hid-core.c                      |   7 +-
 drivers/hid/wacom_sys.c                            | 123 ++-
 drivers/hid/wacom_wac.c                            |  20 +-
 include/linux/hid.h                                |  17 +-
 include/linux/platform_data/i2c-hid.h              |   7 +-
 include/uapi/linux/input.h                         |   9 +-
 27 files changed, 1824 insertions(+), 748 deletions(-)
 create mode 100644 drivers/hid/hid-cougar.c

-- 
Jiri Kosina
SUSE Labs

