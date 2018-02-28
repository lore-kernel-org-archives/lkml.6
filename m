Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933116AbeB1Snn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:43:43 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:42039 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932311AbeB1Snl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:43:41 -0500
X-Google-Smtp-Source: AH8x227I2CAKdQOMOeDjjxliEBgLenFmUYg4mmkFFbHf97RyCR0gwktsjbcOnAQuVnGFxmdNh+5Z/g==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v4 0/4] new driver for Valve Steam Controller
Date: Wed, 28 Feb 2018 19:43:18 +0100
Message-Id: <20180228184322.29636-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements a driver for Valve Steam Controller, based on a
reverse analysis by myself.

This is reroll v4, changes since v3:
 * Add command to check the wireless connection status on probe, without
   waiting for a message (thanks to Clément Vuchener for the tip).
 * Removed the error code on redundant connection/disconnection messages. That
   was harmless but polluted dmesg.
 * Added buttons for touching the left-pad and right-pad.
 * Fixed a misplaced #include from 2/4 to 1/4.

I've added the new command from the first point in a new commit, so now there
are 4 parts. Feel free to merge that with the previous (or all of them) if you
wish.

About the new buttons, before I considered those unnecesary because I thought
of the pads as a kind of flat joysticks, so when they are not touched they go
back to the virtual center (0,0), and the touch/untouch events are not useful.
But I've been proved short-sighted in this kind of decisions before, so I've
added them, sure they are useful for somebody.

Also, I've been running some tests, with the driver, the Steam Client and my
stemctrl utility [1], and all works just fine. Even unloading and reloading
the modules (with a UDEV rule to disable the lizard mode) while the Steam
Client is running works without any issue.

[1]: https://github.com/rodrigorc/steamctrl

Rodrigo Rivas Costa (4):
  HID: add driver for Valve Steam Controller
  HID: steam: add serial number information.
  HID: steam: command to check wireless connection
  HID: steam: add battery device.

 drivers/hid/Kconfig     |   8 +
 drivers/hid/Makefile    |   1 +
 drivers/hid/hid-ids.h   |   4 +
 drivers/hid/hid-steam.c | 797 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 810 insertions(+)
 create mode 100644 drivers/hid/hid-steam.c

-- 
2.16.2
