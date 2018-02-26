Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeBZK0Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:26:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48308 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbeBZK0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:26:15 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
Subject: [PATCH v3 0/8] mfd: cros_ec: add subdevices and fixes
Date: Mon, 26 Feb 2018 11:25:58 +0100
Message-Id: <20180226102606.15093-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a third version of a patchset that collects some patches
already send but that needed some rework due the patchset to split the
cros_ec_devs modules in 2 parts [1]. This patchset contains some of
imrpovements and also some fixes. They can be applied independently
and I think that all can go through the MFD tree.

Best regards,
 Enric

Changes in v3:
- [2/8] Add Acked-by Vincent Palatin.
- [2/8] Add Reviewed-by Andy Shevchenko.
- [3/8] Add Reviewed-by Andy Shevchenko.
- [4/8] Add the Reviewed-by Andy Shevchenko.
- [5/8] Add the Reviewed-by Andy Shevchenko.
- [6/8] Add the Reviewed-by Andy Shevchenko.
- [7/8] Add the Reviewed-by Andy Shevchenko.
- [7/8] Avoid commas in terminator entries.
- [8/8] Add static to cros_ec_i2c_pm_ops.
- [8/8] Add the Reviewed-by Andy Shevchenko.

Changes in v2:
- [2/8] Remove the free_irq in cros_ec_remove.
- [3/8] That patch is new in this series.
- [4/8] Add the Reviewed-by Gwendal.
- [5/8] Add the Reviewed-by Gwendal.
- [6/8] This patch is new in this series.
- [7/8] Add the Reviewed-by Gwendal.
- [8/8] This patch is new in this series replacing [5/6] of v1.

Daniel Hung-yu Wu (1):
  mfd: cros_ec_dev: register shutdown function for debugfs

Douglas Anderson (1):
  mfd: cros_ec: Don't try to grab log when suspended

Enric Balletbo i Serra (2):
  mfd: cros_ec_dev: Register cros-ec-rtc driver as a subdevice.
  mfd: cros_ec_dev: Register cros_ec_accel_legacy driver as a subdevice.

Joseph Lo (1):
  mfd: cros_ec_i2c: moving the system sleep pm ops to late

Vincent Palatin (2):
  mfd: cros_ec: fail early if we cannot identify the EC
  mfd: cros_ec: free IRQ automatically

Wei-Ning Huang (1):
  mfd: cros_ec_i2c: add ACPI module device table

 drivers/mfd/cros_ec.c                     | 26 ++++-----
 drivers/mfd/cros_ec_dev.c                 | 87 +++++++++++++++++++++++++++++++
 drivers/mfd/cros_ec_i2c.c                 | 17 +++++-
 drivers/platform/chrome/cros_ec_debugfs.c | 20 +++++++
 include/linux/mfd/cros_ec.h               |  2 +
 5 files changed, 135 insertions(+), 17 deletions(-)

-- 
2.16.1
