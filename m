Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21018C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80EB20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80EB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeJWUGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:06:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:55862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbeJWUGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:06:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 324A2AF01;
        Tue, 23 Oct 2018 11:43:26 +0000 (UTC)
Date:   Tue, 23 Oct 2018 13:43:25 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 4.20
Message-ID: <nycvar.YFH.7.76.1810231337400.23511@cbobk.fhfr.pm>
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

to receive merge window updates for HID subsystem. Highlights:

=====
- rumble support for Xbox One S, from Andrey Smirnov
- high-resolution support for Logitech mice, from Harry Cutts
- support for recent devices requiring the HID parse to be
  able to cope with tag report sizes > 256
=====

----------------------------------------------------------------
Andrey Smirnov (2):
      HID: microsoft: Convert private data to be a proper struct
      HID: microsoft: Add rumble support for Xbox One S controller

Benjamin Tissoires (3):
      HID: input: do not append a suffix if the name already has it
      HID: multitouch: simplify the application retrieval
      Input: reserve 2 events code because of HID

Colin Ian King (1):
      HID: elan: fix spelling mistake "registred" -> "registered"

Daniel M. Lambea (2):
      HID: cougar: Make parameter 'g6_is_space' dinamically settable
      HID: cougar: Stop processing vendor events on hid-core

Dmitry Torokhov (3):
      mfd: cros: add "base attached" MKBP switch definition
      HID: google: add support tablet mode switch for Whiskers
      HID: google: add dependency on Cros EC for Hammer

Even Xu (6):
      HID: intel-ish-hid: ishtp: add helper function for driver data get/set
      HID: intel-ish-hid: use helper function for private driver data set/get
      HID: intel-ish-hid: ishtp: add helper functions for client buffer operation
      HID: intel-ish-hid: use helper function to access client buffer
      HID: intel-ish-hid: ishtp: add helper function for client search
      HID: intel-ish-hid: use helper function to search client id

Hanno Zulla (1):
      HID: hid-bigbenff: driver for BigBen Interactive PS3OFMINIPAD gamepad

Harry Cutts (5):
      Input: Add the `REL_WHEEL_HI_RES` event code
      HID: input: Create a utility class for counting scroll events
      HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration"
      HID: logitech: Enable high-resolution scrolling on Logitech mice
      HID: logitech: Use LDJ_DEVICE macro for existing Logitech mice

Hong Liu (2):
      HID: intel-ish-hid: use resource-managed api
      HID: intel-ish-hid: using list_head for ipc write queue

Jason Gerecke (1):
      HID: wacom: Work around HID descriptor bug in DTK-2451 and DTH-2452

Jiri Kosina (2):
      HID: microsoft: the driver now neeed MEMLESS_FF infrastructure
      HID: google: drop superfluous const before SIMPLE_DEV_PM_OPS()

Julian Sax (1):
      HID: i2c-hid: override HID descriptors for certain devices

Kai-Heng Feng (1):
      HID: usbhid: Add quirk for Redragon/Dragonrise Seymur 2

Sean O'Brien (1):
      HID: magicmouse: add support for Apple Magic Trackpad 2

Song, Hongyan (1):
      HID: increase maximum global item tag report size to 256

Srinivas Pandruvada (1):
      HID: intel_ish-hid: Enhance API to get ring buffer sizes

Tatsunosuke Tobita (1):
      HID: input: Set INPUT_PROP_-property for HID_UP_DIGITIZERS

zhong jiang (1):
      HID: logitech: fix a used uninitialized GCC warning

 Documentation/input/event-codes.rst               |  11 +-
 drivers/hid/Kconfig                               |  16 +-
 drivers/hid/Makefile                              |   1 +
 drivers/hid/hid-bigbenff.c                        | 414 ++++++++++++++++++++++
 drivers/hid/hid-core.c                            |   2 +-
 drivers/hid/hid-cougar.c                          |  66 +++-
 drivers/hid/hid-elan.c                            |   2 +-
 drivers/hid/hid-google-hammer.c                   | 413 ++++++++++++++++++++-
 drivers/hid/hid-ids.h                             |   6 +
 drivers/hid/hid-input.c                           |  64 +++-
 drivers/hid/hid-logitech-hidpp.c                  | 309 ++++++++++++++--
 drivers/hid/hid-magicmouse.c                      | 142 +++++++-
 drivers/hid/hid-microsoft.c                       | 141 +++++++-
 drivers/hid/hid-multitouch.c                      |  72 ++--
 drivers/hid/hid-quirks.c                          |   1 +
 drivers/hid/i2c-hid/Makefile                      |   3 +
 drivers/hid/i2c-hid/{i2c-hid.c => i2c-hid-core.c} |  60 ++--
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c          | 376 ++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.h                     |  20 ++
 drivers/hid/intel-ish-hid/ipc/ipc.c               |  32 +-
 drivers/hid/intel-ish-hid/ipc/pci-ish.c           |  75 ++--
 drivers/hid/intel-ish-hid/ishtp-hid-client.c      |  41 +--
 drivers/hid/intel-ish-hid/ishtp/bus.c             |  52 +++
 drivers/hid/intel-ish-hid/ishtp/bus.h             |   5 +
 drivers/hid/intel-ish-hid/ishtp/client-buffers.c  |  49 +++
 drivers/hid/intel-ish-hid/ishtp/client.c          |  24 ++
 drivers/hid/intel-ish-hid/ishtp/client.h          |   5 +
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h       |   2 +-
 drivers/hid/wacom_wac.c                           |  19 +
 include/linux/hid.h                               |  28 ++
 include/linux/mfd/cros_ec_commands.h              |   1 +
 include/uapi/linux/input-event-codes.h            |  18 +
 32 files changed, 2225 insertions(+), 245 deletions(-)
 create mode 100644 drivers/hid/hid-bigbenff.c
 rename drivers/hid/i2c-hid/{i2c-hid.c => i2c-hid-core.c} (96%)
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid.h

-- 
Jiri Kosina
SUSE Labs

