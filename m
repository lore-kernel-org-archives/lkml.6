Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4127C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB7F20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB7F20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeLLOCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:02:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:24389 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbeLLOCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:02:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 06:02:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; 
   d="scan'208";a="108966982"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 12 Dec 2018 06:02:26 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gX55l-0000pL-Cd; Wed, 12 Dec 2018 16:02:25 +0200
Date:   Wed, 12 Dec 2018 16:02:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.21-1
Message-ID: <20181212140225.GA3138@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is PR for _v4.21_ (next cycle) to collect and pull when it would be
suitable time for you.

No conflicts found for testing merge I tried locally.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.21-1

for you to fetch changes up to fb7255a923115188ac134bb562d1c44f4f3a413b:

  platform/x86: mlx-platform: Convert to use SPDX identifier (2018-12-10 17:54:42 -0800)

----------------------------------------------------------------
platform-drivers-x86 for v4.21-1

The USB Power Delivery discrete components now can be enumerated by
i2c-multi-instantiate driver via several resources under single ACPI
device node (ACPI ID is INT3515).

Touchscreen support is added for the Mediacom Flexbook Edge 11.

Mellanox driver got fixed due to updates in their firmware.

The power management stub driver for AtomISP v2 is fixed in order to support
Intel Baytrail SoCs where same quirk is needed for S0ix to work.

Special key handling has been fixed for Favorites hotkey on Thinkpad, and
Screen LOCK on ASUS.

Ideapad Yoga 2 13 has no HW rfkill switch, thus, driver has been updated
to support this.

Few cleanups related to debugfs have been made in Intel IPS and
Intel PMC drivers. Besides that Intel PMC has been extended
to show more detailed information about Latency Tolerance.

The following is an automated git shortlog grouped by driver:

ACPI / scan:
 -  Create platform device for INT3515 ACPI nodes

Add the VLV ISP PCI ID to atomisp2_pm:
 - Add the VLV ISP PCI ID to atomisp2_pm

asus-nb-wmi:
 -  Drop mapping of 0x33 and 0x34 scan codes
 -  Map 0x35 to KEY_SCREENLOCK

asus-wmi:
 -  Tell the EC the OS will handle the display off hotkey

dell-laptop:
 -  Mark expected switch fall-throughs

Documentation/ABI:
 -  Add new attribute for mlxreg-io sysfs interfaces

Fix config space access for intel_atomisp2_pm:
 - Fix config space access for intel_atomisp2_pm

i2c:
 -  acpi: Introduce i2c_acpi_get_i2c_resource() helper
 -  acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
 -  acpi: Return error pointers from i2c_acpi_new_device()

i2c-multi-instantiate:
 -  Allow to have same slaves
 -  Introduce IOAPIC IRQ support
 -  Distinguish IRQ resource type
 -  Count I2cSerialBus() resources
 -  Get rid of obsolete conditional
 -  Defer probe when no adapter found
 -  Accept errors of i2c_acpi_new_device()

ideapad-laptop:
 -  Add Yoga 2 13 to no_hw_rfkill list

iio:
 -  inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper

intel_cht_int33fe:
 -  Get rid of obsolete conditional
 -  Accept errors of i2c_acpi_new_device()
 -  Remove duplicate NULL check

intel_ips:
 -  Convert to use DEFINE_SHOW_ATTRIBUTE macro
 -  Remove never happen condition
 -  NULL check before some freeing functions is not needed
 -  remove unnecessary checks in ips_debugfs_init

intel_pmc_core:
 -  convert to DEFINE_SHOW_ATTRIBUTE
 -  Decode Snoop / Non Snoop LTR
 -  Fix LTR IGNORE Max offset
 -  Show Latency Tolerance info

intel_telemetry:
 -  convert to DEFINE_SHOW_ATTRIBUTE

mlx-platform:
 -  Convert to use SPDX identifier
 -  Allow mlxreg-io driver activation for new systems
 -  Fix LED configuration
 -  Fix tachometer registers
 -  Rename new systems product names
 -  Add definitions for new registers

thinkpad_acpi:
 -  Cleanup quirks macros
 -  Change the keymap for Favorites hotkey

touchscreen_dmi:
 -  Add info for the Mediacom Flexbook Edge 11

----------------------------------------------------------------
Andy Shevchenko (17):
      platform/x86: intel_cht_int33fe: Remove duplicate NULL check
      platform/x86: intel_cht_int33fe: Accept errors of i2c_acpi_new_device()
      platform/x86: i2c-multi-instantiate: Accept errors of i2c_acpi_new_device()
      platform/x86: i2c-multi-instantiate: Defer probe when no adapter found
      i2c: acpi: Return error pointers from i2c_acpi_new_device()
      platform/x86: intel_cht_int33fe: Get rid of obsolete conditional
      platform/x86: i2c-multi-instantiate: Get rid of obsolete conditional
      i2c: acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
      i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
      platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
      platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
      platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
      platform/x86: i2c-multi-instantiate: Allow to have same slaves
      ACPI / scan: Create platform device for INT3515 ACPI nodes
      iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper
      platform/x86: intel_ips: Remove never happen condition
      platform/x86: intel_ips: Convert to use DEFINE_SHOW_ATTRIBUTE macro

Gustavo A. R. Silva (1):
      platform/x86: dell-laptop: Mark expected switch fall-throughs

Hans de Goede (1):
      platform/x86: touchscreen_dmi: Add info for the Mediacom Flexbook Edge 11

Jouke Witteveen (1):
      platform/x86: thinkpad_acpi: Cleanup quirks macros

João Paulo Rechi Vita (3):
      platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey
      platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
      platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes

Loic WEI YU NENG (1):
      platform/x86: ideapad-laptop: Add Yoga 2 13 to no_hw_rfkill list

Rajneesh Bhardwaj (3):
      platform/x86: intel_pmc_core: Show Latency Tolerance info
      platform/x86: intel_pmc_core: Fix LTR IGNORE Max offset
      platform/x86: intel_pmc_core: Decode Snoop / Non Snoop LTR

Thomas Meyer (1):
      platform/x86: intel_ips: NULL check before some freeing functions is not needed

Vadim Pasternak (7):
      platform/x86: mlx-platform: Add definitions for new registers
      platform/x86: mlx-platform: Rename new systems product names
      platform/x86: mlx-platform: Fix tachometer registers
      platform/x86: mlx-platform: Fix LED configuration
      platform/x86: mlx-platform: Allow mlxreg-io driver activation for new systems
      Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
      platform/x86: mlx-platform: Convert to use SPDX identifier

Ville Syrjälä (2):
      platform/x86: Add the VLV ISP PCI ID to atomisp2_pm
      platform/x86: Fix config space access for intel_atomisp2_pm

Yangtao Li (2):
      platform/x86: intel_pmc_core: convert to DEFINE_SHOW_ATTRIBUTE
      platform/x86: intel_telemetry: convert to DEFINE_SHOW_ATTRIBUTE

YueHaibing (1):
      platform/x86: intel_ips: remove unnecessary checks in ips_debugfs_init

Zhang Xianwei (1):
      platform/x86: thinkpad_acpi: Change the keymap for Favorites hotkey

 Documentation/ABI/stable/sysfs-driver-mlxreg-io |  41 +++++-
 drivers/acpi/scan.c                             |   1 +
 drivers/i2c/i2c-core-acpi.c                     |  64 ++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c      |  16 +--
 drivers/platform/x86/asus-nb-wmi.c              |   3 +-
 drivers/platform/x86/asus-wmi.c                 |   3 +-
 drivers/platform/x86/dell-laptop.c              |   2 +
 drivers/platform/x86/i2c-multi-instantiate.c    |  97 ++++++++++---
 drivers/platform/x86/ideapad-laptop.c           |   7 +
 drivers/platform/x86/intel_atomisp2_pm.c        |  69 ++++++---
 drivers/platform/x86/intel_cht_int33fe.c        |  20 +--
 drivers/platform/x86/intel_ips.c                |  83 +++--------
 drivers/platform/x86/intel_pmc_core.c           | 180 ++++++++++++++++++------
 drivers/platform/x86/intel_pmc_core.h           |  68 +++++++--
 drivers/platform/x86/intel_telemetry_debugfs.c  |  42 +-----
 drivers/platform/x86/mlx-platform.c             | 177 +++++++++++++++++------
 drivers/platform/x86/thinkpad_acpi.c            |  47 ++-----
 drivers/platform/x86/touchscreen_dmi.c          |   8 ++
 drivers/usb/typec/tps6598x.c                    |   8 +-
 include/linux/acpi.h                            |  11 ++
 20 files changed, 637 insertions(+), 310 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


