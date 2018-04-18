Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeDRKYP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:24:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbeDRKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:24:13 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
Subject: [RESEND PATCH v5 0/7] mfd: cros_ec: add subdevices and fixes
Date: Wed, 18 Apr 2018 12:23:57 +0200
Message-Id: <20180418102405.17790-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the five version of a patchset that collects some patches
already send but that needed some rework due the patchset to split the
cros_ec_devs modules in 2 parts. This patchset contains some improvements
and also some fixes. They can be applied independently and I think that
all can go through the MFD tree.

Note: In this RESEND I removed the patch

[PATCH v5 4/8] mfd: cros_ec_dev: Register cros-ec-rtc driver as a
               subdevice

This patch needs some minor changes but actually I don't have the
hardware to test it. The other patches has no dependency on this one,
I'll send the above patch once I have the hardware to test again.

Best regards,
 Enric

Changes in v5:
- [4/8] For mfd_cell struct use one line and no need for the comma.

Changes in v4:
- [2/8] Add Acked-by Lee Jones.
- [3/8] Add Acked-by Lee Jones.
- [4/8] Nit: check -> Check (Lee Jones)
- [4/8] Use ARRAY_SIZE() instead of hardcoded number (Lee Jones)
- [6/8] Add Acked-by Lee Jones.
- [7/8] Add Acked-by Lee Jones
- [7/8] Remove comma in terminator.
- [8/8] Add Acked-by Lee Jones.

Changes in v3:
- [2/8] Add Acked-by Vincent Palatin.
- [2/8] Add Reviewed-by Andy Shevchenko.
- [3/8] Add Reviewed-by Andy Shevchenko.
- [4/8] Add the Reviewed-by Andy Shevchenko.
- [6/8] Add the Reviewed-by Andy Shevchenko.
- [7/8] Add the Reviewed-by Andy Shevchenko.
- [7/8] Avoid commas in terminator entries.
- [8/8] Add static to cros_ec_i2c_pm_ops.
- [8/8] Add the Reviewed-by Andy Shevchenko.

Changes in v2:
- [2/8] Remove the free_irq in cros_ec_remove.
- [3/8] That patch is new in this series.
- [4/8] Add the Reviewed-by Gwendal.
- [6/8] This patch is new in this series.
- [7/8] Add the Reviewed-by Gwendal.
- [8/8] This patch is new in this series replacing [5/6] of v1.

Daniel Hung-yu Wu (1):
  mfd: cros_ec_dev: register shutdown function for debugfs

Douglas Anderson (1):
  mfd: cros_ec: Don't try to grab log when suspended

Enric Balletbo i Serra (1):
  mfd: cros_ec_dev: Register cros-ec-rtc driver as a subdevice.

Joseph Lo (1):
  mfd: cros_ec_i2c: moving the system sleep pm ops to late

Vincent Palatin (2):
  mfd: cros_ec: fail early if we cannot identify the EC
  mfd: cros_ec: free IRQ automatically

Wei-Ning Huang (1):
  mfd: cros_ec_i2c: add ACPI module device table

 drivers/mfd/cros_ec.c                     | 26 ++++++++-----------
 drivers/mfd/cros_ec_dev.c                 | 31 ++++++++++++++++++++++-
 drivers/mfd/cros_ec_i2c.c                 | 17 +++++++++++--
 drivers/platform/chrome/cros_ec_debugfs.c | 20 +++++++++++++++
 include/linux/mfd/cros_ec.h               |  2 ++
 5 files changed, 78 insertions(+), 18 deletions(-)

-- 
2.17.0
