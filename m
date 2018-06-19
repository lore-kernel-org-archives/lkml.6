Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFA9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51002075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51002075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937728AbeFSMAJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:00:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:33338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937609AbeFSMAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:00:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4EE79AE96;
        Tue, 19 Jun 2018 12:00:07 +0000 (UTC)
Date:   Tue, 19 Jun 2018 14:00:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1806191356280.6203@cbobk.fhfr.pm>
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

to receive -rc HID fixes:

=====
- Wacom 2nd-gen Intuos Pro large Y axis handling fix from Jason Gerecke
- Fix for hibernation in Intel ISH driver, from Even Xu
- Crash fix for hid-steam driver, from Rodrigo Rivas Costa
- i2c-hid fix for devices (such as SIPODEV SP1064) that fail to provide
  their report descriptor, from Julian Sax
- new device ID addition to google-hammer driver
=====

Thanks.

----------------------------------------------------------------
Even Xu (1):
      HID: intel_ish-hid: ipc: register more pm callbacks to support hibernation

Jason Gerecke (1):
      HID: wacom: Correct logical maximum Y for 2nd-gen Intuos Pro large

Julian Sax (1):
      HID: i2c-hid: override HID descriptors for certain devices

Nicolas Boichat (1):
      HID: google: Add support for whiskers

Rodrigo Rivas Costa (1):
      HID: steam: use hid_device.driver_data instead of hid_set_drvdata()

 drivers/hid/hid-google-hammer.c                   |   2 +
 drivers/hid/hid-ids.h                             |   1 +
 drivers/hid/hid-steam.c                           |  10 +-
 drivers/hid/i2c-hid/Makefile                      |   3 +
 drivers/hid/i2c-hid/{i2c-hid.c => i2c-hid-core.c} |  58 ++++++---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c          | 149 ++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.h                     |  17 +++
 drivers/hid/intel-ish-hid/ipc/pci-ish.c           |  22 +---
 drivers/hid/wacom_sys.c                           |   8 ++
 9 files changed, 230 insertions(+), 40 deletions(-)
 rename drivers/hid/i2c-hid/{i2c-hid.c => i2c-hid-core.c} (96%)
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid.h

-- 
Jiri Kosina
SUSE Labs

