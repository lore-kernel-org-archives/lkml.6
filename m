Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5635EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158002086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158002086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeKGUBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:01:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:59984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbeKGUBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:01:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC8ABB6E7;
        Wed,  7 Nov 2018 10:31:37 +0000 (UTC)
Date:   Wed, 7 Nov 2018 11:31:37 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1811071125360.21975@cbobk.fhfr.pm>
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

to receive HID subsytem fixes

=====
- hid.git is moving towards group maintainership (where group is myself 
  and Benjamin Tissoires), therefore this pull request updates MAINTAINERS
  accordingly
- fix for hid-asus config dependency from Arnd Bergmann
- two device-specific quirks for i2c-hid from Julian Sax and Kai-Heng Feng
- other few small assorted fixes
=====

Thanks.

----------------------------------------------------------------
Arnd Bergmann (1):
      HID: asus: fix build warning wiht CONFIG_ASUS_WMI disabled

Benjamin Tissoires (2):
      Revert "HID: add NOGET quirk for Eaton Ellipse MAX UPS"
      HID: alps: allow incoming reports when only the trackstick is opened

Breno Leitao (1):
      HID: hiddev: fix potential Spectre v1

Jiri Kosina (1):
      HID: moving to group maintainership model

Julian Sax (1):
      HID: i2c-hid: add Direkt-Tek DTLAPY133-1 to descriptor override

Kai-Heng Feng (1):
      HID: i2c-hid: Add a small delay after sleep command for Raydium touchpanel

Linus Walleij (1):
      HID: fix up .raw_event() documentation

 MAINTAINERS                              |  8 ++++----
 drivers/hid/hid-alps.c                   | 18 ++++++++++++++++++
 drivers/hid/hid-asus.c                   |  3 +++
 drivers/hid/hid-ids.h                    |  3 +++
 drivers/hid/hid-quirks.c                 |  1 -
 drivers/hid/i2c-hid/i2c-hid-core.c       | 19 +++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |  8 ++++++++
 drivers/hid/usbhid/hiddev.c              | 18 ++++++++++++++----
 include/linux/hid.h                      |  4 ++--
 9 files changed, 71 insertions(+), 11 deletions(-)

-- 
Jiri Kosina
SUSE Labs

