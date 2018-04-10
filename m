Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeDJRMb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:12:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:14199 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751504AbeDJRMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:12:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="190377924"
Date: Tue, 10 Apr 2018 20:12:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.17-1
Message-ID: <20180410171227.GA12596@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is first batch of Platform Drivers x86 for v4.17 cycle. Due to few
duplication the merge will have conflicts which would be resolved by
using `git merge -X no-renames ...` followed by choose of our version of
two failed one-liner hunks situated in one file.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit c8ba9db2a790c0fcf2f6c4cafd45ff3a0751800e:

  platform/x86: dell-laptop: Removed duplicates in DMI whitelist (2018-02-15 12:18:33 +0200)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.17-1

for you to fetch changes up to a986c75a7df027d2c649a8f087be9417372cbfb3:

  platform/x86: thinkpad_acpi: Add 2nd Fan Support for Thinkpad P50 (2018-04-03 11:06:04 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v4.17-1

Dell SMBIOS driver fixed against memory leaks.

The fujitsu-laptop driver is cleaned up and now supports hotkeys for
Lifebook U7x7 models. Besides that the typo introduced by one of
previous clean up series has been fixed.

Specific to x86-based laptops HID device now supports
KEY_ROTATE_LOCK_TOGGLE event which is emitted, for example,
by Wacom MobileStudio Pro 13.

Turbo MAX 3 technology is enabled for the rest of platforms that support
Hardware-P-States feature which have core priority described by
ACPI CPPC table.

Mellanox on x86 gets better support of I2C bus in use including support
of hotpluggable ones.

Silead touchscreen is enabled on two tablet models, i.e Yours Y8W81 and
I.T.Works TW701.

>From now on the second fan on Thinkpad P50 is supported.

The topstar-laptop driver is reworked to support new models, in
particular Topstar U931.

Some of the changes had been already applied during v4.16 cycle and thus
have a duplication here:

- 027d50ccd6a01c6ca8969b49e69f26d64a8f94b2 platform/x86: intel-vbtn: Only activate tablet mode switch on 2-in-1's
- 250b044e1a584887c06e6ba79446e523ffa3cc9c platform/x86: intel-vbtn: Reset wakeup capable flag on removal
- 356b57752c91cffb35356abe6647065bf0edcad1 platform/x86: intel-hid: Reset wakeup capable flag on removal
- 501f7e52de8a7b910154740958ce8d902258bf72 platform/x86: wmi: Fix misuse of vsprintf extension %pULL
- 98c76a3904261a7b7612821de8b99f0e3b41677c platform/x86: dell-smbios: Correct some style warnings
- ec34fe385984b447f62ef6763638874e6fbd1f43 platform/x86: dell-smbios: Rename dell-smbios source to dell-smbios-bae
- 41e36f2f85af758fd2f4be76112ebe649d07a801 platform/x86: dell-smbios: Link all dell-smbios-* modules together
- c715e4345581bdb475ae4fb378a243aee72579ba platform/x86: Allow for SMBIOS backend defaults
- cc69c88fbeb915447b87e5179378d899d1f61554 platform/x86: dell-smbios: Resolve dependency error on DCDBAS
- 4716007c23abeb0e42015786794539454aff487b platform/x86: dell-smbios: Resolve dependency error on ACPI_WMI
- 7129707ec2356ef9ef9cce469ad14eb37fbbe67e platform/x86: Fix dell driver init order

The following is an automated git shortlog grouped by driver:

dell-smbios:
 -  Fix memory leaks in build_tokens_sysfs()
 -  Fix dell driver init order
 -  Resolve dependency error on ACPI_WMI
 -  Resolve dependency error on DCDBAS
 -  Allow for SMBIOS backend defaults
 -  Link all dell-smbios-* modules together
 -  Rename dell-smbios source to dell-smbios-base
 -  Correct some style warnings

fujitsu-laptop:
 -  Support Lifebook U7x7 hotkeys
 -  Revert UNSUPPORTED_CMD back to an int
 -  Clean up constants
 -  Define constants for backlight power control
 -  Do not include linux/slab.h
 -  Clearly distinguish module parameters
 -  Simplify error paths
 -  Defer input device registration
 -  Unify local variable naming

GPD pocket fan:
 -  fix spelling mistake: "Mill-celcius" -> "millicelsius"

intel-hid:
 -  support KEY_ROTATE_LOCK_TOGGLE
 -  clean up and sort header files
 -  Reset wakeup capable flag on removal

intel_turbo_max_3:
 -  Remove restriction for HWP platforms

intel-vbtn:
 -  Reset wakeup capable flag on removal
 -  Only activate tablet mode switch on 2-in-1's

mlx-platform:
 -  Add physical bus number auto detection
 -  Add deffered bus functionality
 -  Use define for the channel numbers

platform/mellanox:
 -  mlxreg-hotplug: Change input for device create routine

silead_dmi:
 -  Add entry for the Yours Y8W81 tablet
 -  Add DMI match for the I.T.Works TW701 tablet

thinkpad_acpi:
 -  Add 2nd Fan Support for Thinkpad P50

topstar-laptop:
 -  replace licence text with SPDX tag
 -  update copyright and fix some comments
 -  add Topstar U931/RVP7 WLAN LED workaround
 -  add platform device
 -  split ACPI events and input handling
 -  use consistent naming scheme
 -  revert "convert to module_acpi_driver()"

wmi:
 -  Fix misuse of vsprintf extension %pULL
 -  Replace list_for_each() by list_for_each_entry()
 -  Replace kmalloc + sprintf() with kasprintf()

----------------------------------------------------------------
Alex Hung (2):
      intel-hid: clean up and sort header files
      intel-hid: support KEY_ROTATE_LOCK_TOGGLE

Alexander Kappner (1):
      platform/x86: thinkpad_acpi: Add 2nd Fan Support for Thinkpad P50

Andy Shevchenko (2):
      platform/x86: wmi: Replace kmalloc + sprintf() with kasprintf()
      platform/x86: wmi: Replace list_for_each() by list_for_each_entry()

Colin Ian King (1):
      platform/x86: GPD pocket fan: fix spelling mistake: "Mill-celcius" -> "millicelsius"

Dan Carpenter (1):
      platform/x86: dell-smbios: Fix memory leaks in build_tokens_sysfs()

Darren Hart (1):
      platform/x86: dell-smbios: Resolve dependency error on ACPI_WMI

Darren Hart (VMware) (3):
      platform/x86: Allow for SMBIOS backend defaults
      platform/x86: dell-smbios: Resolve dependency error on DCDBAS
      platform/x86: Fix dell driver init order

Guillaume Douézan-Grard (7):
      platform/x86: topstar-laptop: revert "convert to module_acpi_driver()"
      platform/x86: topstar-laptop: use consistent naming scheme
      platform/x86: topstar-laptop: split ACPI events and input handling
      platform/x86: topstar-laptop: add platform device
      platform/x86: topstar-laptop: add Topstar U931/RVP7 WLAN LED workaround
      platform/x86: topstar-laptop: update copyright and fix some comments
      platform/x86: topstar-laptop: replace licence text with SPDX tag

Hans de Goede (2):
      platform/x86: silead_dmi: Add DMI match for the I.T.Works TW701 tablet
      platform/x86: silead_dmi: Add entry for the Yours Y8W81 tablet

Jan-Marek Glogowski (1):
      platform/x86: fujitsu-laptop: Support Lifebook U7x7 hotkeys

Joe Perches (1):
      platform/x86: wmi: Fix misuse of vsprintf extension %pULL

Mario Limonciello (4):
      platform/x86: intel-vbtn: Only activate tablet mode switch on 2-in-1's
      platform/x86: dell-smbios: Correct some style warnings
      platform/x86: dell-smbios: Rename dell-smbios source to dell-smbios-base
      platform/x86: dell-smbios: Link all dell-smbios-* modules together

Michał Kępień (8):
      platform/x86: fujitsu-laptop: Unify local variable naming
      platform/x86: fujitsu-laptop: Defer input device registration
      platform/x86: fujitsu-laptop: Simplify error paths
      platform/x86: fujitsu-laptop: Clearly distinguish module parameters
      platform/x86: fujitsu-laptop: Do not include linux/slab.h
      platform/x86: fujitsu-laptop: Define constants for backlight power control
      platform/x86: fujitsu-laptop: Clean up constants
      platform/x86: fujitsu-laptop: Revert UNSUPPORTED_CMD back to an int

Rafael J. Wysocki (2):
      platform/x86: intel-vbtn: Reset wakeup capable flag on removal
      platform/x86: intel-hid: Reset wakeup capable flag on removal

Srinivas Pandruvada (1):
      platform/x86: intel_turbo_max_3: Remove restriction for HWP platforms

Vadim Pasternak (4):
      platform/x86: mlx-platform: Use define for the channel numbers
      platform/x86: mlx-platform: Add deffered bus functionality
      platform/mellanox: mlxreg-hotplug: Change input for device create routine
      platform/x86: mlx-platform: Add physical bus number auto detection

 drivers/firmware/dcdbas.c                          |   2 +-
 drivers/platform/mellanox/mlxreg-hotplug.c         |  31 +-
 drivers/platform/x86/Kconfig                       |  31 +-
 drivers/platform/x86/Makefile                      |   5 +-
 .../x86/{dell-smbios.c => dell-smbios-base.c}      |  35 +-
 drivers/platform/x86/dell-smbios-smm.c             |  18 +-
 drivers/platform/x86/dell-smbios-wmi.c             |  14 +-
 drivers/platform/x86/dell-smbios.h                 |  27 +-
 drivers/platform/x86/dell-wmi.c                    |   2 +-
 drivers/platform/x86/fujitsu-laptop.c              | 199 +++++------
 drivers/platform/x86/gpd-pocket-fan.c              |   4 +-
 drivers/platform/x86/intel-hid.c                   |  15 +-
 drivers/platform/x86/intel-vbtn.c                  |  47 ++-
 drivers/platform/x86/intel_turbo_max_3.c           |   3 -
 drivers/platform/x86/mlx-platform.c                |  68 +++-
 drivers/platform/x86/silead_dmi.c                  |  17 +
 drivers/platform/x86/thinkpad_acpi.c               |   8 +
 drivers/platform/x86/topstar-laptop.c              | 363 ++++++++++++++++-----
 drivers/platform/x86/wmi.c                         |  29 +-
 include/linux/platform_data/mlxreg.h               |   4 +
 20 files changed, 649 insertions(+), 273 deletions(-)
 rename drivers/platform/x86/{dell-smbios.c => dell-smbios-base.c} (95%)

-- 
With Best Regards,
Andy Shevchenko
