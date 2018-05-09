Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934840AbeEIMJ2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:09:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:51267 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934641AbeEIMJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:09:27 -0400
Date: Wed, 9 May 2018 14:09:26 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes for 4.17
Message-ID: <nycvar.YFH.7.76.1805091404320.27054@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

to receive -rc fixes for 4.17 for HID subsystem:

=====
- quirk for Toshiba Click Mini L9W-B, from Hans de Goede
- intel-ish-hid and wacom error handling (device freeing) path fixes from 
  Arvind Yadav
- memory corruption fix in intel-ish-hid driver from Hans de Goede
- a few new device ID additions to hid-lenovo from Peter Ganzhorn
=====

Thanks.

----------------------------------------------------------------
Arvind Yadav (2):
      HID: wacom: Release device resource data obtained by devres_alloc()
      HID: intel-ish-hid: use put_device() instead of kfree()

Hans de Goede (3):
      HID: intel_ish-hid: Move header size check to inside the loop
      HID: intel_ish-hid: Stop using a static local buffer in get_report()
      HID: i2c-hid: Add RESEND_REPORT_DESCR quirk for Toshiba Click Mini L9W-B

Peter Ganzhorn (1):
      HID: lenovo: Add support for IBM/Lenovo Scrollpoint mice

 drivers/hid/Kconfig                          |  7 +++---
 drivers/hid/hid-ids.h                        |  9 +++++++
 drivers/hid/hid-lenovo.c                     | 36 ++++++++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.c                |  2 ++
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 36 +++++++++++++---------------
 drivers/hid/intel-ish-hid/ishtp/bus.c        |  2 +-
 drivers/hid/wacom_sys.c                      |  4 +++-
 7 files changed, 71 insertions(+), 25 deletions(-)

-- 
Jiri Kosina
SUSE Labs
