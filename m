Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeDENZs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:25:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751298AbeDENZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:25:46 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/8] Input: support for latest Lenovo thinkpads (series 80)
Date: Thu,  5 Apr 2018 15:25:29 +0200
Message-Id: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

well, this year, Lenovo gave us a surprise and decided to not use
the same touchpad/trackstick in all its model. And by default, the
support under Linux is less than ideal.

Please find a series that should fix those issues. Compared to the 60
series, there do not seem to e BIOS table issues this time, and suspend/resume
works fine thanks to your latest trackstick fixes.

The T480s is a different beast, as it uses an Elan touchpad.
I have been carrying the patches 3-6 for a while and tested previous
versions on various Elan PS/2 hardware without an issue as far as I
could tell. I was lacking tests from users with SMBus as all the laptops
I tried where puer PS/2.

Anyway, it would be cool if you could have a look at the series.

Cheers,
Benjamin

Benjamin Tissoires (8):
  Input: synaptics - add Lenovo 80 series ids to SMBus
  input: elan_i2c_smbus - fix corrupted stack
  Input: elan_i2c - add trackstick report
  Input: elantech - split device info into a separate structure
  Input: elantech - query the resolution in query_info
  Input: elantech - add support for SMBus devices
  Input: elantech - detect new ICs and setup Host Notify for them
  input: psmouse-smbus: allow to control psmouse_deactivate

 drivers/input/mouse/Kconfig          |  12 +
 drivers/input/mouse/elan_i2c.h       |  10 +
 drivers/input/mouse/elan_i2c_core.c  |  91 ++++++-
 drivers/input/mouse/elan_i2c_smbus.c |  22 +-
 drivers/input/mouse/elantech.c       | 475 ++++++++++++++++++++++++++---------
 drivers/input/mouse/elantech.h       |  69 ++++-
 drivers/input/mouse/psmouse-base.c   |  21 +-
 drivers/input/mouse/psmouse-smbus.c  |  13 +-
 drivers/input/mouse/psmouse.h        |   2 +
 drivers/input/mouse/synaptics.c      |   5 +-
 10 files changed, 564 insertions(+), 156 deletions(-)

-- 
2.14.3
