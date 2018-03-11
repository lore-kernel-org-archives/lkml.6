Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbeCKT64 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:58:56 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:41440 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932235AbeCKT6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:58:53 -0400
X-Google-Smtp-Source: AG47ELvZ080PN52nf0sC3RuyKbl3NL6vnnOF6elwEJ1Ckt4OL+/LQBmVUpxFPJ6abwlEvru5ByiF5Q==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v5 0/4] new driver for Valve Steam Controller
Date: Sun, 11 Mar 2018 20:58:38 +0100
Message-Id: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements a driver for Valve Steam Controller, based on a
reverse analysis by myself.

Sorry, I've been out of town for a few weeks and couldn't keep up with this...

@Pierre-Loup and @Clément, could you please have another look at this and
check if it is worthy? Benjamin will not commit it without an express ACK from
Valve. Of course he is right to be cautious, but I checked this driver with
the Steam Client and all seems to go just fine. I think that there is a lot of
Linux out of the desktop that could use this driver and cannot use the Steam
Client. Worst case scenario, this driver can now be blacklisted, but I hope
that will not be needed.

For full reference, I'm adding a full changelog of this patchset.

Changes in v5:
 * Fix license SPDX to GPL-2.0+.
 * Minor stylistic changes (BIT(3) instead 0x08 and so on).

Changes in v4:
 * Add command to check the wireless connection status on probe, without
   waiting for a message (thanks to Clément Vuchener for the tip).
 * Removed the error code on redundant connection/disconnection messages. That
   was harmless but polluted dmesg.
 * Added buttons for touching the left-pad and right-pad.
 * Fixed a misplaced #include from 2/4 to 1/4.

Changes in v3:
 * Use RCU to do the dynamic connec/disconnect of wireless devices.
 * Remove entries in hid-quirks.c as they are no longer needed. This allows
   this module to be blacklisted without side effects.
 * Do not bypass the virtual keyboard/mouse HID devices to avoid breaking
   existing use cases (lizard mode). A user-space tool to do that is
   linked.
 * Fully separated axes for joystick and left-pad. As it happens.
 * Add fuzz values for left/right pad axes, they are a little wiggly.

Changes in v2:
 * Remove references to USB. Now the interesting interfaces are selected by
   looking for the ones with feature reports.
 * Feature reports buffers are allocated with hid_alloc_report_buf().
 * Feature report length is checked, to avoid overflows in case of
   corrupt/malicius USB devices.
 * Resolution added to the ABS axes.
 * A lot of minor cleanups.

Rodrigo Rivas Costa (4):
  HID: add driver for Valve Steam Controller
  HID: steam: add serial number information.
  HID: steam: command to check wireless connection
  HID: steam: add battery device.

 drivers/hid/Kconfig     |   8 +
 drivers/hid/Makefile    |   1 +
 drivers/hid/hid-ids.h   |   4 +
 drivers/hid/hid-steam.c | 794 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 807 insertions(+)
 create mode 100644 drivers/hid/hid-steam.c

-- 
2.16.2
