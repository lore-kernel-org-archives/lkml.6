Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbeBURH7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:07:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55612 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeBURH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:07:57 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        groeck@chromium.org, gwendal@chromium.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 0/6] platform/chrome: cros_ec debugfs and sysfs updates
Date: Wed, 21 Feb 2018 18:07:42 +0100
Message-Id: <20180221170748.27505-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a second patchset that introduces some cros_ec debugfs and sysfs
updates. Some patches that were send before but never merged and some
others are new.

First patch was already sent [1] but did not receive feedback so I am
resending it. Needs to go through platform/chrome tree and can be
picked without dependencies.

Patches 2 to 4 are cleanups of current code, basically is the
implementation of the changes suggested by Andy Shevchenko on the first
series. Again these must go through platform/chrome tree.

Patch 5 is new, and like the others must go through platform/chrome tree.

Finally, patch 6 was already sent [2] but now needed to be reworked due
the split of the cros_ec_devs in two parts [3]. This patch touches
platform/chrome and mfd so we will probably need an immutable branch.

Best regards,
  Enric

[1] https://patchwork.kernel.org/patch/9894655/
[2] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1488891.html
[3] https://lkml.org/lkml/2017/11/20/408

Changes since v1:
- Requested by Andy Shevchenko:
  - Introduce define to_cros_ec_dev.
  - Switch to DEVICE_ATTR_RO/RW variants. 
  - Drop unrelated changes on patch 5. Split in two patches, one for the
    pd feature and another one to use octal permissions.

Enric Balletbo i Serra (3):
  platform/chrome: cros_ec_sysfs: introduce to_cros_ec_dev define.
  platform/chrome: cros_ec_sysfs: use permission-specific DEVICE_ATTR
    variants
  platform/chrome: cros_ec_debugfs: Use octal permissions '0444'

Gwendal Grignou (2):
  platform/chrome: cros_ec_sysfs: Modify error handling
  platform/chrome: mfd/cros_ec_dev: Add sysfs entry to set keyboard wake
    lid angle

Shawn Nematbakhsh (1):
  platform/chrome: cros_ec_debugfs: Add PD port info to debugfs

 drivers/mfd/cros_ec_dev.c                 |  19 ++--
 drivers/platform/chrome/cros_ec_debugfs.c |  76 +++++++++++++++-
 drivers/platform/chrome/cros_ec_sysfs.c   | 141 +++++++++++++++++++++---------
 include/linux/mfd/cros_ec.h               |   1 +
 4 files changed, 187 insertions(+), 50 deletions(-)

-- 
2.16.1
