Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeDSIG2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:06:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:55372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752504AbeDSIF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:05:59 -0400
Date: Thu, 19 Apr 2018 10:05:58 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1804191000590.28129@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

to receive fixes for HID subsystem:

=====
- suspend/resume handling fix for Raydium I2C-connected touchscreen from 
  Aaron Ma
- protocol fixup for certain BT-connected Wacoms from Aaron Armstrong 
  Skomra 
- battery level reporting fix on BT-connected mice from Dmitry Torokhov
- hidraw race condition fix from Rodrigo Rivas Costa
=====

Thanks.

----------------------------------------------------------------
Aaron Armstrong Skomra (1):
      HID: wacom: bluetooth: send exit report for recent Bluetooth devices

Aaron Ma (1):
      HID: i2c-hid: Fix resume issue on Raydium touchscreen device

Dmitry Torokhov (1):
      HID: input: fix battery level reporting on BT mice

Jiri Kosina (1):
      HID: i2c-hid: fix inverted return value from i2c_hid_command()

Rodrigo Rivas Costa (1):
      HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device

 drivers/hid/hid-ids.h         |  3 ++
 drivers/hid/hid-input.c       | 24 ++++++++++----
 drivers/hid/hidraw.c          |  5 +++
 drivers/hid/i2c-hid/i2c-hid.c | 13 ++++++++
 drivers/hid/wacom_wac.c       | 76 ++++++++++++++++++++++++++-----------------
 include/linux/hid.h           |  9 ++++-
 6 files changed, 92 insertions(+), 38 deletions(-)

-- 
Jiri Kosina
SUSE Labs
