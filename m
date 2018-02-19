Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbeBSWjm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:39:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46538 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbeBSWjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:39:41 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: groeck@chromium.org, gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 0/6] mfd: cros_ec: add subdevices and fixes
Date: Mon, 19 Feb 2018 23:39:26 +0100
Message-Id: <20180219223932.21102-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now, that the patchset to split the cros_ec_devs modules in 2 parts has
been merged [1] it's time to some of the patches sent before this
patchset as now needs to be reworked. This patched contains some of
these patches and also some fixes. They can be applied independently and
I think that all can go through the MFD tree.

The first patch is an improvement, the patch was already sent some time
ago and acked-by Benson Leung [2]. The second patch is another improvement
never sent before. Patches 3 and 4 are to register the RTC and the
cros-ec-accel legacy drivers (these driver are now in mainline) Patch 5 is
a fix at resume and patch 6 is another patch already sent some time ago
and acked-by Benson Leung [3] but never merged.

[1] https://lkml.org/lkml/2017/11/20/408
[2] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1467256.html
[3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1467253.html

Best regards,

Enric Balletbo i Serra (1):
  mfd: cros_ec_dev: Register cros-ec-rtc driver as a subdevice.

Gwendal Grignou (1):
  mfd: cros_ec_dev: Check communication with ec at resume

Thierry Escande (1):
  mfd: cros_ec_dev: Register cros_ec_accel_legacy driver as a subdevice.

Vincent Palatin (2):
  mfd: cros_ec: fail early if we cannot identify the EC
  mfd: cros_ec: free IRQ automatically

Wei-Ning Huang (1):
  mfd: cros_ec_i2c: add ACPI module device table

 drivers/mfd/cros_ec.c     | 23 +++++++------
 drivers/mfd/cros_ec_dev.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/cros_ec_i2c.c | 12 +++++++
 3 files changed, 106 insertions(+), 12 deletions(-)

-- 
2.16.1
