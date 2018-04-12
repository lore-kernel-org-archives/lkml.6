Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbeDLWVG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 18:21:06 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43734 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753308AbeDLWVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 18:21:05 -0400
X-Google-Smtp-Source: AIpwx49OCUDGI2BnTRIRoNSS8qDHtuwEYITSdzcK8+emdJHse2NXrqz3e+uyYlIQUj/9PMJW++/8gw==
Date: Thu, 12 Apr 2018 15:21:01 -0700
From: Benson Leung <bleung@google.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, bleung@chromium.org, groeck@chromium.org,
        dtor@chromium.org, dmitry.torokhov@gmail.com, olof@lixom.net,
        linux@roeck-us.net, bleung@google.com, enric.balletbo@collabora.com,
        gwendal@chromium.org
Subject: [GIT PULL] chrome-platform updates for v4.17
Message-ID: <20180412222101.GA242548@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
tags/chrome-platform-for-linus-4.17

for you to fetch changes up to c171d3b8a67e08884d915ffbb1dbc475747d7df2:

  Merge remote-tracking branch 'origin/ib-chrome-platform-cros-ec-sysfs-deb=
ugfs-for-v4.17' into working-branch-for-4.17 (2018-04-10 22:30:34 -0700)

----------------------------------------------------------------
Changes to chrome-platform for v4.17

Incorporates a series from Dmitry to remove platform data from
chromeos_laptop.c, which was the only user of platform data
for the atmel_mxt_ts driver.

Includes a series to clean up sysfs and debugfs for cros_ec.

Other misc. cleanups.

Thanks,
Benson

----------------------------------------------------------------
Benson Leung (2):
      Merge remote-tracking branch 'chrome-platform-stop-being-a-platform-d=
river-plus-atmel_mxt_ts-for-v4.17' into working-branch-for-4.17
      Merge remote-tracking branch 'origin/ib-chrome-platform-cros-ec-sysfs=
-debugfs-for-v4.17' into working-branch-for-4.17

Dmitry Torokhov (14):
      Input: atmel_mxt_ts - do not pass suspend mode in platform data
      Input: atmel_mxt_ts - switch from OF to generic device properties
      Input: atmel_mxt_ts - switch ChromeOS ACPI devices to generic props
      platform/chrome: chromeos_laptop - add SPDX identifier
      platform/chrome: chromeos_laptop - stop setting suspend mode for Atme=
l devices
      platform/chrome: chromeos_laptop - introduce pr_fmt()
      platform/chrome: chromeos_laptop - factor out getting IRQ from DMI
      platform/chrome: chromeos_laptop - rework i2c peripherals initializat=
ion
      platform/chrome: chromeos_laptop - parse DMI IRQ data once
      platform/chrome: chromeos_laptop - use I2C notifier to create devices
      platform/chrome: chromeos_laptop - rely on I2C to set up interrupt tr=
igger
      platform/chrome: chromeos_laptop - use device properties for Pixel
      platform/chrome: chromeos_laptop - discard data for unneeded boards
      Input: atmel_mxt_ts - remove platform data support

Enric Balletbo i Serra (3):
      platform/chrome: cros_ec_sysfs: introduce to_cros_ec_dev define.
      platform/chrome: cros_ec_sysfs: use permission-specific DEVICE_ATTR v=
ariants
      platform/chrome: cros_ec_debugfs: Use octal permissions '0444'

Gwendal Grignou (2):
      platform/chrome: cros_ec_sysfs: Modify error handling
      platform/chrome: mfd/cros_ec_dev: Add sysfs entry to set keyboard wak=
e lid angle

Salvatore Bellizzi (1):
      platform/chrome: cros_ec_lpc: Add support for Google devices using cu=
stom coreboot firmware

Shawn Nematbakhsh (1):
      platform/chrome: cros_ec_debugfs: Add PD port info to debugfs

Wenkai Du (1):
      platform/chrome: cros_ec_lpc: wake up from s2idle on Chrome EC

 MAINTAINERS                                |   1 -
 drivers/input/touchscreen/atmel_mxt_ts.c   | 231 ++++----
 drivers/mfd/cros_ec_dev.c                  |  31 +-
 drivers/platform/chrome/chromeos_laptop.c  | 896 +++++++++++++++----------=
----
 drivers/platform/chrome/cros_ec_debugfs.c  |  76 ++-
 drivers/platform/chrome/cros_ec_lpc.c      |  16 +
 drivers/platform/chrome/cros_ec_sysfs.c    | 141 +++--
 include/linux/mfd/cros_ec.h                |   2 +
 include/linux/mfd/cros_ec_commands.h       |   3 +
 include/linux/platform_data/atmel_mxt_ts.h |  31 -
 10 files changed, 789 insertions(+), 639 deletions(-)
 delete mode 100644 include/linux/platform_data/atmel_mxt_ts.h


--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlrP280ACgkQHwn1ewov
5li2BBAAsiFUCxL/pBCGZ6/SECDZC2z9WXSdFtWiXPYVgq2vvwwiOHiEmdYWuMjL
lEa6f4hSebXZ+HJdotPVCEIh0uCZE3US+rD3V260gIPVrxmLUNTZdyOfTzCtgbjU
9XMcNOzIfpuKfPvSk4fVHh8v9msDtVhnmKkXIqQGvPuqcaH48l1gXGHD/WlfcqZz
rdPd8mxh0t9gHHv6zV2xcF7DIT2CA9J7yeD8H8SF4WxwXOYq3nlAT+Gg+HjmLhtz
MctRIhIk8pNQImihfUEgJb2m2ZyFPz8eQmTyZEGLEN2eV1dF6io3IL8qGfiG64pe
AK54+PJFdhTUimaeH8Bw3Z3VXx6XFBM+0u6Iv2Cs12CTBo1z5mfvjInlXzfncAJH
M1GXodM3BwX6N/Q9g4P6DrIdZFvDZN0OtFGNOBdbBZu/r/5hwHfA5mWHK8fqqMnd
Nm6ix4k/p7wDt63zOYHMa8aPOtcHcDpAuLoXNF3iHaX/XyayGLkDhBjYhpWHAjDp
rUwT/IOY7o+WLblD7CVI7CsQTtJCtGNRzm4QcF5/v0Bd/50lH+4OIA7TVN6RXgQa
aazrPh1Kd2NsqUCisDWZVkfRpuZ8D6SHaUzNRt6ue7GstvIHOw+MkcYeAf6I+an4
dIjefCdD3RC74/sTQsUAUAAinDg+40lHslEYYiO+rivyWgEn2bo=
=Fwix
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
