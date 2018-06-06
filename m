Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20DCB60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932117AbeFFPMR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:12:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56792 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeFFPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:09:10 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paolo Cretaro <paolocretaro@gmail.com>,
        linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        linux-rtc@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 00/12] cros_ec: Match licenses and switch to SPDX identifier.
Date: Wed,  6 Jun 2018 17:08:48 +0200
Message-Id: <20180606150900.8342-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

This patchset is just to adopt the SPDX license identifier for all
ChromeOS Embedded Controller related drivers. The patches touches
different subsystems but every patch can be picked from their respective
maintainer independently.

This third version takes the license note as the valid license (I did
the contrary in the second version) so apart from add the SPDX tags it
also introduces new patches to match the license.

Best regards,
    Enric

Changes in v3:
- Add new patches to match license text with MODULE_LICENSE (Dmitry)
- If there is a conflict between the license notice and MODULE_LICENSE
  go by license notice not MODULE_LICENSE. (Dmitry)
- Reintroduced again the patch for the rtc-cros-ec driver as license
  should be GPL v2-only.
- Removed '[PATCH 7/9] pwm: cros-ec: Switch to SPDX identifier.' as
  maintainer told me that I don't need to resend.

Changes in v2:
- Removed '[PATCH 5/9] rtc: cros-ec: Switch to SPDX identifier' from
  series as it was applied.
- s/Chrome OS/ChromeOS/
- [1/9] Fixed wrong copyright year.
- [6/9] Do not remove last paragraph.
- [8/9] Fixed wrong copyright year.

Enric Balletbo i Serra (12):
  platform/chrome: Make license text and module license match.
  platform/chrome: Switch to SPDX identifier.
  mfd: cros_ec: Make license text and module license match.
  mfd: cros_ec: Switch to SPDX identifier.
  rtc: cros-ec: Make license text and module license match.
  rtc: cros-ec: Switch to SPDX identifier.
  extcon: usbc-cros-ec: Make license text and module license match.
  extcon: usbc-cros-ec: Switch to SPDX identifier.
  Input: cros_ec_keyb - Make license text and module license match.
  Input: cros_ec_keyb - Switch to SPDX identifier.
  iio: cros_ec: Switch to SPDX identifier.
  i2c: i2c-cros-ec-tunnel: Switch to SPDX identifier.

 drivers/extcon/extcon-usbc-cros-ec.c          | 22 ++++--------
 drivers/i2c/busses/i2c-cros-ec-tunnel.c       | 14 +++-----
 drivers/iio/accel/cros_ec_accel_legacy.c      | 27 +++++---------
 .../common/cros_ec_sensors/cros_ec_sensors.c  | 24 ++++---------
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 18 +++-------
 .../cros_ec_sensors/cros_ec_sensors_core.h    | 12 ++-----
 drivers/iio/light/cros_ec_light_prox.c        | 18 +++-------
 drivers/iio/pressure/cros_ec_baro.c           | 18 +++-------
 drivers/input/keyboard/cros_ec_keyb.c         | 36 +++++++------------
 drivers/mfd/cros_ec.c                         | 28 +++++----------
 drivers/mfd/cros_ec_dev.c                     | 23 +++---------
 drivers/mfd/cros_ec_dev.h                     | 16 ++-------
 drivers/mfd/cros_ec_i2c.c                     | 20 +++--------
 drivers/mfd/cros_ec_spi.c                     | 18 +++-------
 drivers/platform/chrome/chromeos_pstore.c     | 15 +++-----
 drivers/platform/chrome/cros_ec_debugfs.c     | 22 +++---------
 drivers/platform/chrome/cros_ec_lightbar.c    | 22 +++---------
 drivers/platform/chrome/cros_ec_lpc.c         | 36 +++++++------------
 drivers/platform/chrome/cros_ec_lpc_mec.c     | 34 +++++++-----------
 drivers/platform/chrome/cros_ec_lpc_reg.c     | 34 +++++++-----------
 drivers/platform/chrome/cros_ec_proto.c       | 19 +++-------
 drivers/platform/chrome/cros_ec_sysfs.c       | 22 +++---------
 drivers/platform/chrome/cros_ec_vbc.c         | 24 +++----------
 .../platform/chrome/cros_kbd_led_backlight.c  | 19 +++-------
 drivers/rtc/rtc-cros-ec.c                     | 23 ++++--------
 include/linux/mfd/cros_ec.h                   | 10 +-----
 include/linux/mfd/cros_ec_commands.h          | 10 +-----
 include/linux/mfd/cros_ec_lpc_mec.h           | 14 ++------
 include/linux/mfd/cros_ec_lpc_reg.h           | 14 ++------
 29 files changed, 159 insertions(+), 453 deletions(-)

-- 
2.17.1
