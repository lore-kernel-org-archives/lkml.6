Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30323C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32112070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546517229;
	bh=SOHQjJESruGUnPhzaq/7iBUrv81RJt6HWcsJ61P7aKc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=sgDBeJaU2t/fH2rzO/6HQC2jTO2gLYKhwdlWZ8UL+8GtcpGJJCpNID5wUllU7nn6a
	 jYZ2xsUs76bZs8TvvJpGjx1L1CBPxNE2m/pMl05Gy2TWzuygMlgDYuZo3bnSMlVLg9
	 +U+zAxU73jDDSdmDrKCVgvQUPz/Lz91T/BVzcnVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfACMHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:07:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:34570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729118AbfACMHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:07:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B928ACD9;
        Thu,  3 Jan 2019 12:07:05 +0000 (UTC)
Date:   Thu, 3 Jan 2019 13:07:04 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL v2] HID for 4.21
In-Reply-To: <nycvar.YFH.7.76.1901031231040.14047@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1901031300000.14047@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901031231040.14047@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID merge window updates (this is a fixed version, v1 was by 
accident missing branch (which was present in linux-next)):

=====
- high-resolution scrolling support that gracefully handles differences 
  between MS and Logitech implementations in HW, from Peter Hutterer and 
  Harry Cutts
- MSI IRQ support for intel-ish driver, from Song Hongyan
- support for new hardware (Cougar 700K, Odys Winbook 13, ASUS FX503VD, 
  ASUS T101HA) from Daniel M. Lambea, Hans de Goede and Aleix Roca Nonell
- other small assorted fixups
=====

----------------------------------------------------------------
Aditya Pakki (1):
      HID: lenovo: Add checks to fix of_led_classdev_register

Aleix Roca Nonell (1):
      HID: asus: Add support for the ASUS T101HA keyboard dock

Chris Chiu (2):
      HID: use macros in IS_INPUT_APPLICATION
      HID: input: support Microsoft wireless radio control hotkey

Daniel M. Lambea (1):
      HID: cougar: Add support for Cougar 700K Gaming Keyboard

Hans de Goede (3):
      HID: asus: Add event handler to catch unmapped Asus Vendor UsagePage codes
      HID: asus: Add support for the ASUS FX503VD laptop
      HID: i2c-hid: Add Odys Winbook 13 to descriptor override

Harry Cutts (3):
      HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration"
      HID: logitech: Enable high-resolution scrolling on Logitech mice
      HID: logitech: Use LDJ_DEVICE macro for existing Logitech mice

Jiri Kosina (1):
      HID: hidraw: enforce minors_lock locking via lockdep

Jonathan Davies (1):
      HID: samples/hidraw: fix typo in printed message

Pan Bian (1):
      HID: intel-ish-hid: fixes incorrect error handling

Peter Hutterer (6):
      Input: add `REL_WHEEL_HI_RES` and `REL_HWHEEL_HI_RES`
      HID: core: store the collections as a basic tree
      HID: core: process the Resolution Multiplier
      HID: input: use the Resolution Multiplier for high-resolution scrolling
      HID: logitech-hidpp: fix typo, hiddpp to hidpp
      HID: doc: fix wrong data structure reference for UHID_OUTPUT

Song Hongyan (1):
      HID: intel-ish-hid: add MSI interrupt support

Yangtao Li (1):
      HID: debug: Change to use DEFINE_SHOW_ATTRIBUTE macro

 Documentation/hid/uhid.txt               |   2 +-
 Documentation/input/event-codes.rst      |  21 +-
 drivers/hid/hid-asus.c                   |  28 +++
 drivers/hid/hid-core.c                   | 174 ++++++++++++++
 drivers/hid/hid-cougar.c                 |   2 +
 drivers/hid/hid-debug.c                  |  12 +-
 drivers/hid/hid-ids.h                    |   3 +
 drivers/hid/hid-input.c                  | 108 ++++++++-
 drivers/hid/hid-lenovo.c                 |  10 +-
 drivers/hid/hid-logitech-hidpp.c         | 375 ++++++++++++++++++++++++++++---
 drivers/hid/hidraw.c                     |   8 +-
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |   8 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c  |   7 +-
 drivers/hid/intel-ish-hid/ishtp-hid.c    |   2 +-
 include/linux/hid.h                      |  17 +-
 include/uapi/linux/input-event-codes.h   |   2 +
 samples/hidraw/hid-example.c             |   2 +-
 17 files changed, 720 insertions(+), 61 deletions(-)

-- 
Jiri Kosina
SUSE Labs

