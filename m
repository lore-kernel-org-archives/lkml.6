Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E1EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8A420657
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546515550;
	bh=SAGtDyd361piDUsGZYe8UW1x47aIQlLqdNzjoH62gzE=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=BqeDe+cSvPmOUgfGmhEWMNVLX5wMuuvIqjh48Tmw69aPUHj+gOCwAoVfRoILD7ZIj
	 zkGbURD3Az02sVXHy0m7SZWiRI9x/rBgH767GMQ1VG1z4VykSI9Rmc8vGy+LH62PPK
	 gQtf09qKem5tGwhAEUGxdChx3LzsxTH1YHmqR+hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbfACLjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:39:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:58972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730396AbfACLjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:39:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7346AF9B;
        Thu,  3 Jan 2019 11:39:07 +0000 (UTC)
Date:   Thu, 3 Jan 2019 12:39:07 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 4.21
Message-ID: <nycvar.YFH.7.76.1901031231040.14047@cbobk.fhfr.pm>
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

to receive HID merge window updates.

=====
This round is particularly tiny. Some highlights:

- MSI IRQ support for intel-ish driver, from Song Hongyan
- support for new hardware (Cougar 700K, Odys Winbook 13) from
  Daniel M. Lambea and Hans de Goede
- other small assorted fixups
=====

Thanks.

----------------------------------------------------------------
Aditya Pakki (1):
      HID: lenovo: Add checks to fix of_led_classdev_register

Daniel M. Lambea (1):
      HID: cougar: Add support for Cougar 700K Gaming Keyboard

Hans de Goede (1):
      HID: i2c-hid: Add Odys Winbook 13 to descriptor override

Jiri Kosina (1):
      HID: hidraw: enforce minors_lock locking via lockdep

Jonathan Davies (1):
      HID: samples/hidraw: fix typo in printed message

Pan Bian (1):
      HID: intel-ish-hid: fixes incorrect error handling

Peter Hutterer (1):
      HID: doc: fix wrong data structure reference for UHID_OUTPUT

Song Hongyan (1):
      HID: intel-ish-hid: add MSI interrupt support

Yangtao Li (1):
      HID: debug: Change to use DEFINE_SHOW_ATTRIBUTE macro

 Documentation/hid/uhid.txt               |  2 +-
 drivers/hid/hid-cougar.c                 |  2 ++
 drivers/hid/hid-debug.c                  | 12 +-----------
 drivers/hid/hid-ids.h                    |  1 +
 drivers/hid/hid-lenovo.c                 | 10 ++++++++--
 drivers/hid/hidraw.c                     |  8 ++++----
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |  8 ++++++++
 drivers/hid/intel-ish-hid/ipc/pci-ish.c  |  7 ++++++-
 drivers/hid/intel-ish-hid/ishtp-hid.c    |  2 +-
 samples/hidraw/hid-example.c             |  2 +-
 10 files changed, 33 insertions(+), 21 deletions(-)

-- 
Jiri Kosina
SUSE Labs

