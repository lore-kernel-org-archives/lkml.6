Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FC1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C69820868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C69820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeKYHIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:08:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:40100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbeKYHIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:08:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C469AAEBC;
        Sat, 24 Nov 2018 20:19:36 +0000 (UTC)
Date:   Sat, 24 Nov 2018 21:19:35 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1811242114160.21108@cbobk.fhfr.pm>
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

to receive HID subsystem fixes

=====
- revert of the high-resolution scrolling feature, as it breaks certain 
  hardware due to incompatibilities between Logitech and Microsoft worlds.
  Peter Hutterer is working on a fixed implementation. Until that is
  finished, revert by Benjamin Tissoires.

- revert of incorrect strncpy->strlcpy conversion in uhid, from David 
  Herrmann

- fix for buggy sendfile() implementation on uhid device node, from Eric 
  Biggers

- a few assorted device-ID specific quirks
=====

Thanks.

----------------------------------------------------------------
Benjamin Tissoires (7):
      Revert "HID: input: simplify/fix high-res scroll event handling"
      Revert "HID: logitech: fix a used uninitialized GCC warning"
      Revert "HID: logitech: Use LDJ_DEVICE macro for existing Logitech mice"
      Revert "HID: logitech: Enable high-resolution scrolling on Logitech mice"
      Revert "HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration""
      Revert "HID: input: Create a utility class for counting scroll events"
      Revert "Input: Add the `REL_WHEEL_HI_RES` event code"

Benson Leung (1):
      HID: input: Ignore battery reported by Symbol DS4308

David Herrmann (1):
      Revert "HID: uhid: use strlcpy() instead of strncpy()"

Eric Biggers (1):
      HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges

Kai-Heng Feng (2):
      HID: multitouch: Add pointstick support for Cirque Touchpad
      HID: i2c-hid: Disable runtime PM for LG touchscreen

Rodrigo Rivas Costa (1):
      HID: steam: remove input device when a hid client is running.

Sebastian Parschauer (2):
      HID: Add quirk for Microsoft PIXART OEM mouse
      HID: Add quirk for Primax PIXART OEM mice

 Documentation/input/event-codes.rst    |  11 +-
 drivers/hid/hid-ids.h                  |   8 +
 drivers/hid/hid-input.c                |  47 +----
 drivers/hid/hid-logitech-hidpp.c       | 309 +++------------------------------
 drivers/hid/hid-multitouch.c           |   6 +
 drivers/hid/hid-quirks.c               |   3 +
 drivers/hid/hid-steam.c                | 154 +++++++++-------
 drivers/hid/i2c-hid/i2c-hid-core.c     |   2 +
 drivers/hid/uhid.c                     |  25 ++-
 include/linux/hid.h                    |  28 ---
 include/uapi/linux/input-event-codes.h |  10 --
 11 files changed, 159 insertions(+), 444 deletions(-)

-- 
Jiri Kosina
SUSE Labs

