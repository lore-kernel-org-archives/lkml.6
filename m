Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeBYSxI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 13:53:08 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55154 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeBYSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 13:53:04 -0500
X-Google-Smtp-Source: AG47ELuLDZX7QZvvKUZEkMGa1xMmADqUEbTlDZzyzBU79wt48i3RAkxWRKUioIgUVNWdipfTZk0REg==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v3 0/3] new driver for Valve Steam Controller
Date: Sun, 25 Feb 2018 19:52:47 +0100
Message-Id: <20180225185250.10759-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements a driver for Valve Steam Controller, based on a
reverse analysis by myself.

This is reroll v3, codenamed "lazy lizard". Changes from v2:
 * Use RCU to do the dynamic connec/disconnect of wireless devices. Please,
   to anybody that knows their way around RCU, review.
 * Remove entries in hid-quirks.c as they are no longer needed. This allows
   this module to be blacklisted without side effects.
 * Do not bypass the virtual keyboard/mouse HID devices to avoid breaking
   existing use cases (lizard mode). A user-space tool to do that is
   linked.
 * Fully separated axes for joystick and left-pad. As it happens, there are
   people with too many fingers.
 * Add fuzz values for left/right pad axes, they are a little wiggly.

Notable changes from patchset v1:
 * Remove references to USB. Now the interesting interfaces are selected by
   looking for the ones with feature reports.
 * Feature reports buffers are allocated with hid_alloc_report_buf().
 * Feature report length is checked, to avoid overflows in case of
   corrupt/malicius USB devices.
 * Resolution added to the ABS axes.
 * A lot of minor cleanups.

Rodrigo Rivas Costa (3):
  HID: add driver for Valve Steam Controller
  HID: steam: add serial number information.
  HID: steam: add battery device.

 drivers/hid/Kconfig     |   8 +
 drivers/hid/Makefile    |   1 +
 drivers/hid/hid-ids.h   |   4 +
 drivers/hid/hid-steam.c | 777 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 790 insertions(+)
 create mode 100644 drivers/hid/hid-steam.c

-- 
2.16.2
