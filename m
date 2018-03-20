Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbeCTPvk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:51:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50892 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCTPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:51:34 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org, bleung@chromium.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v3 0/6] platform/chrome: cros_ec debugfs and sysfs updates
Date: Tue, 20 Mar 2018 16:51:19 +0100
Message-Id: <20180320155125.3046-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a third patchset that introduces some cros_ec debugfs and sysfs
updates. Some patches were send before but never merged and some others
are new.

First patch was already sent [1] but did not receive feedback so I am
resending it. Needs to go through platform/chrome tree and can be
picked without dependencies.

Patches 2 to 4 are cleanups of current code, basically is the
implementation of the changes suggested by Andy Shevchenko on the first
series. Again these must go through platform/chrome tree.

In Patch 5 I added a missing define, so now this patch can be picked
without any dependency, although now needs the ack from mfd and
platform/chrome maintainer as touches both sub-systems.

Finally, patch 6 was already sent [2] but now needed to be reworked due
the split of the cros_ec_devs in two parts [3]. This patch touches
platform/chrome and mfd so we will probably need an immutable branch.
This version also include a fix found by Gwendal.

Best regards,
  Enric

Changes in v3:
- [2/6] Add Reviewed-by Andy Shevchenko
- [3/6] Add Reviewed-by Andy Shevchenko
- [4/6] Add Reviewed-by Andy Shevchenko
- [5/6] Add EC_USB_PD_MAX_PORTS define to avoid interdependencies.
- [5/6] Add Reviewed-by Andy Shevchenko
- [6/6] Add Reviewed-by Andy Shevchenko
- [6/6] Fix the code that has_kb_wake_angle in cros_ec_sensors_register().

Changes in v2:
- [2/6] Add a new define to get the cros_ec_dev.
- [3/6] Use DEVICE_ATTR variants.
- [4/6] Use octal permissions.
- [5/6] Drop unrelated changes.
- [6/6] Use DEVICE_ATTR_RW variant.
- [6/6] Use one line when fits in 80 characters.
- [6/6] Use the previous defined to_cros_ec_dev

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

 drivers/mfd/cros_ec_dev.c                 |  29 +++---
 drivers/platform/chrome/cros_ec_debugfs.c |  76 +++++++++++++++-
 drivers/platform/chrome/cros_ec_sysfs.c   | 141 +++++++++++++++++++++---------
 include/linux/mfd/cros_ec.h               |   2 +
 include/linux/mfd/cros_ec_commands.h      |   3 +
 5 files changed, 193 insertions(+), 58 deletions(-)

-- 
2.16.2
