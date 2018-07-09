Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0687C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F60D20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F60D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeGIMyH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:54:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:48880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932567AbeGIMyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:54:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DA75AD0F;
        Mon,  9 Jul 2018 12:54:05 +0000 (UTC)
Date:   Mon, 9 Jul 2018 14:54:04 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1807091445200.997@cbobk.fhfr.pm>
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

to receive HID subsystem fixes:

=====
- spectrev1 pattern fix in hiddev from Gustavo A. R. Silva
- Bounds check fix for hid-debug from Daniel Rosenberg
- Regression fix for HID autobinding from Benjamin Tissoires
- Removal of excessive logging from i2c-hid driver from Jason Andryuk
- fix specific to 2nd generation of Wacom Intuos devices from Jason 
  Gerecke
=====

Thanks.

----------------------------------------------------------------
Benjamin Tissoires (1):
      HID: core: allow concurrent registration of drivers

Daniel Rosenberg (1):
      HID: debug: check length before copy_to_user()

Gustavo A. R. Silva (1):
      HID: hiddev: fix potential Spectre v1

Jason Andryuk (1):
      HID: i2c-hid: Fix "incomplete report" noise

Jason Gerecke (1):
      HID: wacom: Correct touch maximum XY of 2nd-gen Intuos

 drivers/hid/hid-core.c        |  5 ++++-
 drivers/hid/hid-debug.c       |  8 +++++++-
 drivers/hid/i2c-hid/i2c-hid.c |  2 +-
 drivers/hid/usbhid/hiddev.c   | 11 +++++++++++
 drivers/hid/wacom_wac.c       | 10 ++++++++--
 include/linux/hid.h           |  3 ++-
 6 files changed, 33 insertions(+), 6 deletions(-)

-- 
Jiri Kosina
SUSE Labs

