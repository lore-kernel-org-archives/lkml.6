Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id W8PmHv4/GlvKUwAAmS7hNA
	; Fri, 08 Jun 2018 08:36:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 14707607DC; Fri,  8 Jun 2018 08:36:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 898256074D;
	Fri,  8 Jun 2018 08:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 898256074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbeFHIgS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:36:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:44327 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbeFHIgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:36:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7CB6EAC5B;
        Fri,  8 Jun 2018 08:36:14 +0000 (UTC)
Date: Fri, 8 Jun 2018 10:36:13 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID
Message-ID: <nycvar.YFH.7.76.1806081032200.6203@cbobk.fhfr.pm>
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

to receive merge window updates for HID subsystem:

=====
- Valve Steam Controller support from Rodrigo Rivas Costa
- Redragon Asura support from Robert Munteanu
- improvement of duplicate usage handling in generic hid-input from 
  Benjamin Tissoires
- Win 8.1 precisioun touchpad spec implementation from Benjamin Tissoires
- Support for "In Range" flag for Wacom Intuos/Bamboo devices from Jason 
  Gerecke
- other various assorted smaller fixes and improvements
=====

Thanks.

----------------------------------------------------------------
Arnd Bergmann (1):
      HID: steam: select CONFIG_POWER_SUPPLY

Ben Chan (1):
      HID: multitouch: fix calculation of last slot field in multi-touch reports

Benjamin Tissoires (8):
      HID: input: do not increment usages when a duplicate is found
      HID: store the full list of reports in the hidinput
      HID: generic: create one input report per application type
      HID: input: append a suffix matching the application
      HID: multitouch: make use of HID_QUIRK_INPUT_PER_APP
      HID: multitouch: simplify the settings of the various features
      HID: multitouch: implement precision touchpad latency and switches
      HID: rmi: use HID_QUIRK_NO_INPUT_SYNC

Christophe JAILLET (4):
      HID: alps: Report an error if we receive invalid data in 't4_read_write_register()'
      HID: alps: Save a memory allocation in 't4_read_write_register()' when writing data
      HID: alps: Check errors returned by 't4_read_write_register()'
      HID: alps: Fix some style in 't4_read_write_register()'

Dmitry Torokhov (1):
      HID: i2c-hid: check if device is there before really probing

Hans de Goede (2):
      HID: i2c-hid: Move i2c_hid_acpi_pdata error reporting to inside the function
      HID: i2c-hid: Silently fail probe for CHPN0001 touchscreen

Heiner Kallweit (1):
      HID: quirks: remove Delcom Visual Signal Indicator from hid_have_special_driver[]

Hisao Tanabe (1):
      HID: core: fix hid_hw_open() comment

Jason Gerecke (1):
      HID: wacom: Support "in range" for Intuos/Bamboo tablets where possible

Jiri Kosina (2):
      HID: steam: add missing fields in client initialization
      HID: multitouch: fix types returned from mt_need_to_apply_feature()

Robert Munteanu (1):
      HID: redragon: Fix modifier keys for Redragon Asura Keyboard

Rodrigo Rivas Costa (2):
      HID: add driver for Valve Steam Controller
      HID: steam: add battery device.

Sebastian Andrzej Siewior (1):
      HID: i2c-hid: remove i2c_hid_open_mut

Terry Junge (1):
      HID: hid-plantronics: Re-resend Update to map button for PTT products

 drivers/hid/Kconfig           |   16 +
 drivers/hid/Makefile          |    2 +
 drivers/hid/hid-alps.c        |   30 +-
 drivers/hid/hid-core.c        |   21 +-
 drivers/hid/hid-generic.c     |   15 +
 drivers/hid/hid-gfrm.c        |    2 +-
 drivers/hid/hid-ids.h         |    5 +
 drivers/hid/hid-input.c       |  123 ++++-
 drivers/hid/hid-magicmouse.c  |    6 +-
 drivers/hid/hid-multitouch.c  |  232 +++++----
 drivers/hid/hid-plantronics.c |    6 +-
 drivers/hid/hid-quirks.c      |    1 -
 drivers/hid/hid-redragon.c    |   86 ++++
 drivers/hid/hid-rmi.c         |   20 +
 drivers/hid/hid-steam.c       | 1115 +++++++++++++++++++++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.c |   33 +-
 drivers/hid/wacom_wac.c       |   74 +--
 include/linux/hid.h           |   19 +-
 18 files changed, 1621 insertions(+), 185 deletions(-)
 create mode 100644 drivers/hid/hid-redragon.c
 create mode 100644 drivers/hid/hid-steam.c

-- 
Jiri Kosina
SUSE Labs
