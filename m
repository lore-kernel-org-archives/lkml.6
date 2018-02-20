Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeBTTdh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:33:37 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33539 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbeBTTdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:33:35 -0500
X-Google-Smtp-Source: AH8x2245BUP7/1XewInH/aPuweupFORnP7bWRO+eibMzDG5rnPComU3PhTqx5VY6sprYZuASQcdOKA==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v2 0/3] new driver for Valve Steam Controller
Date: Tue, 20 Feb 2018 20:33:03 +0100
Message-Id: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements a driver for Valve Steam Controller, based on a
reverse analysis by myself.

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

 drivers/hid/Kconfig      |   8 +
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-ids.h    |   4 +
 drivers/hid/hid-quirks.c |   4 +
 drivers/hid/hid-steam.c  | 703 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 720 insertions(+)
 create mode 100644 drivers/hid/hid-steam.c

-- 
2.16.1
