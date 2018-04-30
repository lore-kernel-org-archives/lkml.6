Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753615AbeD3NOO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:14:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51882 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeD3NON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:14:13 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com
Subject: [PATCH v2 0/3] mfd/power: cros_ec: add support for USBPD charger driver.
Date: Mon, 30 Apr 2018 15:14:00 +0200
Message-Id: <20180430131403.14296-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear all,

This is a second version of a patched to add support for the ChromeOS EC
USBPD charger driver, the driver has been used on Chromebooks kernel for
long time and has been ported now to mainline. The patches were tested
successfully with a Samsung Chromebook Plus and an Pixel 2 Chromebook.

This version is a rework with respect the first version, some features
like the PD log have been removed and will be send as follow up patches
for further discuss.

The second patch of this series depends on these series that are queued
for 4.18:

- https://lkml.org/lkml/2018/4/23/602 ([PATCH v8 0/6] typec: tcpm: Add
  sink side support for PPS)

The third patch of this series depends on the following patch to apply
cleanly:

- https://lkml.org/lkml/2018/4/18/229 ([RESEND PATCH v5 4/7] mfd:
  cros_ec_dev: Register cros-ec-rtc driver as a subdevice.)

Best regards,
 Enric

Changes in v2:
- [2/3] Add SPDX header, use devm_ variant and drop .owner
- [2/3] Removed the PD log functionality (will be send on a follow up patch)
- [2/3] Removed the extra custom sysfs attributes (will be send on a follow up patch)
- [3/3] Use ARRAY_SIZE instead of hardcoded 1.

Enric Balletbo i Serra (1):
  mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice.

Sameer Nanda (2):
  mfd: cros_ec: Add USBPD charger commands and struct definitions.
  power: supply: add cros-ec USBPD charger driver.

 drivers/mfd/cros_ec_dev.c                 |  16 +
 drivers/power/supply/Kconfig              |  10 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/cros_usbpd-charger.c | 511 ++++++++++++++++++++++
 include/linux/mfd/cros_ec.h               |   2 +
 include/linux/mfd/cros_ec_commands.h      | 132 +++++-
 6 files changed, 668 insertions(+), 4 deletions(-)
 create mode 100644 drivers/power/supply/cros_usbpd-charger.c

-- 
2.17.0
