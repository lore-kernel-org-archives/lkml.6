Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeBFTyI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:54:08 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:41897 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753246AbeBFTyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:54:07 -0500
Date: Tue, 6 Feb 2018 11:54:04 -0800
From: Darren Hart <dvhart@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.16-1
Message-ID: <20180206195404.GA10912@fury>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.16-1

for you to fetch changes up to 8a0f5b6f33275eb0251e0e1b0716744f9d95415f:

  platform/x86: mlx-platform: Fix an ERR_PTR vs NULL issue (2018-02-06 07:42:38 -0800)

Thanks,

Darren Hart
VMware Open Source Technology Center

----------------------------------------------------------------
platform-drivers-x86 for v4.16-1

New model support added for Dell, Ideapad, Acer, Asus, Thinkpad, and GPD
laptops.  Improvements to the common intel-vbtn driver, including tablet
mode, rotate, and front button support. Intel CPU support added for
Cannonlake and platform support for Dollar Cove power button.

Overhaul of the mellanox platform driver, creating a new
platform/mellanox directory for the newly multi-architecture regmap
interface.

Significant Intel PMC update with CannonLake support, Coffeelake update,
CPUID enumeration, module support, new read64 API, refactoring and
cleanups.

Revert the apple-gmux iGP IO lock, addressing reported issues with
non-binary drivers, leaving Nvidia binary driver users to comment out
conflicting code.

Miscellaneous fixes and cleanups.

Previously merged during the 4.15-rc cycle:
- e20a8e771d platform/x86: dell-laptop: Fix keyboard max lighting for Dell Latitude E6410
- 9cd5cf3710 platform/x86: asus-wireless: send an EV_SYN/SYN_REPORT between state changes
- 91c73e8092 platform/x86: dell-wmi: check for kmalloc() errors
- 9a1a625918 platform/x86: wmi: Call acpi_wmi_init() later

The following is an automated git shortlog grouped by driver:

ACPI / LPIT:
 -  Export lpit_read_residency_count_address()

Input:
 -  add KEY_ROTATE_LOCK_TOGGLE

MAINTAINERS:
 -  Update tree for platform-drivers-x86

x86/cpu:
 -  Add Cannonlake to Intel family

acer-wireless:
 - Add Acer Wireless Radio Control driver

intel_chtdc_ti_pwrbtn:
 - Add support for Dollar Cove TI power button

GPD pocket fan:
 -  Add driver for GPD pocket custom fan controller
 -  Stop work on suspend
 -  Use a min-speed of 2 while charging
 -  Set speed to max on get_temp failure

apple-gmux:
 -  Revert: lock iGP IO to protect from vgaarb changes

alienware-wmi:
 -  lightbar LED support for Dell Inspiron 5675

asus-nb-wmi:
 -  Support ALS on the Zenbook UX430UQ

dell-laptop:
 -  Allocate buffer on heap rather than globally
 -  Add 2-in-1 devices to the DMI whitelist
 -  Filter out spurious keyboard backlight change events
 -  make some local functions static
 -  Use bool in struct quirk_entry for true/false fields

dell-smbios:
 -  Correct notation for filtering

dell-wmi:
 -  Add an event created by Dell Latitude 5495

Kconfig
 - have ACPI_CMPC use depends instead of select for INPUT

ideapad-laptop:
 -  Add Y720-15IKB to no_hw_rfkill
 -  add lenovo RESCUER R720-15IKBN to no_hw_rfkill_list
 -  Use __func__ instead of write_ec_cmd in pr_err
 -  Remove unnecessary else

intel-hid:
 -  add a DMI quirk to support Wacom MobileStudio Pro

intel-vbtn:
 -  Replace License by SDPX identifier
 -  Remove redundant inclusions
 -  Support tablet mode switch
 -  Simplify autorelease logic
 -  support panel front button
 -  support KEY_ROTATE_LOCK_TOGGLE
 -  Support separate press/release events
 -  support SW_TABLET_MODE

intel_int0002_vgpio:
 -  Remove IRQF_NO_THREAD irq flag

intel_pmc_core:
 -  Special case for Coffeelake
 -  Add CannonLake PCH support
 -  Read base address from LPIT
 -  Remove unused header file
 -  Convert to ICPU macro
 -  Substitute PCI with CPUID enumeration
 -  Refactor debugfs entries
 -  Update Kconfig
 -  Fix file permission warnings
 -  Change driver to a module
 -  Fix kernel doc for pmc_dev
 -  Remove unused variable
 -  Remove unused EXPORTED API

intel_pmc_ipc:
 -  Add read64 API

intel_telemetry:
 -  Remove redundancies
 -  Improve S0ix logs
 -  Fix suspend stats

mlx-platform:
 -  Fix an ERR_PTR vs NULL issue
 -  Add hotplug device unregister to error path
 -  fix module aliases
 -  Add IO access verification callbacks
 -  Document pdev_hotplug field
 -  Allow compilation for 32 bit arch

platform/mellanox:
 -  mlxreg-hotplug: Add check for negative adapter number
 -  mlxreg-hotplug: Enable building for ARM
 -  mlxreg-hotplug: Modify to use a regmap interface
 -  Group create/destroy with attribute functions
 -  Rename i2c bus to nr
 -  mlxreg-hotplug: Remove unused wait.h include
 -  Move Mellanox platform hotplug driver to platform/mellanox

pmc_atom:
 -  introduce DEFINE_SHOW_ATTRIBUTE() macro

samsung-laptop:
 -  Grammar s/are can/can/

silead_dmi:
 -  Add Teclast X3 Plus tablet support
 -  Add entry for newer BIOS for Trekstor Surftab 7.0
 -  Add entry for the Teclast X98 Plus II
 -  Add entry for the Trekstor Primebook C13
 -  Add entry for the Chuwi Vi8 tablet
 -  add entry for Chuwi Hi8 tablet
 -  Add support for the Onda oBook 20 Plus tablet
 -  Add touchscreen info for SurfTab twin 10.1

thinkpad_acpi:
 -  suppress warning about palm detection
 -  Accept flat mode for type 4 multi mode status

----------------------------------------------------------------
Alberto Ponces (1):
      platform/x86: silead_dmi: Add Teclast X3 Plus tablet support

Alex Hung (1):
      intel-hid: add a DMI quirk to support Wacom MobileStudio Pro

Alexander Abrosimov (1):
      platform/x86: dell-laptop: Add 2-in-1 devices to the DMI whitelist

Andy Shevchenko (3):
      platform/x86: pmc_atom: introduce DEFINE_SHOW_ATTRIBUTE() macro
      platform/x86: intel-vbtn: Remove redundant inclusions
      platform/x86: intel-vbtn: Replace License by SDPX identifier

Benjamin Berg (1):
      platform/x86: thinkpad_acpi: Accept flat mode for type 4 multi mode status

Bernhard Übelacker (1):
      platform/x86: silead_dmi: Add touchscreen info for SurfTab twin 10.1

Chakravarty, Souvik K (4):
      platform/x86: intel_pmc_ipc: Add read64 API
      platform/x86: intel_telemetry: Fix suspend stats
      platform/x86: intel_telemetry: Improve S0ix logs
      platform/x86: intel_telemetry: Remove redundancies

Chang Liu (1):
      platform/x86: alienware-wmi: lightbar LED support for Dell Inspiron 5675

Chris Chiu (1):
      platform/x86: Add Acer Wireless Radio Control driver

Dan Carpenter (2):
      platform/x86: dell-wmi: check for kmalloc() errors
      platform/x86: mlx-platform: Fix an ERR_PTR vs NULL issue

Darren Hart (VMware) (2):
      platform/x86: intel-vbtn: Simplify autorelease logic
      MAINTAINERS: Update tree for platform-drivers-x86

David Herrmann (1):
      platform/x86: thinkpad_acpi: suppress warning about palm detection

Geert Uytterhoeven (1):
      platform/x86: samsung-laptop: Grammar s/are can/can/

Hans de Goede (9):
      platform/x86: intel_int0002_vgpio: Remove IRQF_NO_THREAD irq flag
      platform/x86: silead_dmi: Add entry for the Chuwi Vi8 tablet
      platform/x86: Add driver for GPD pocket custom fan controller
      platform/x86: silead_dmi: Add entry for the Trekstor Primebook C13
      platform/x86: dell-laptop: Filter out spurious keyboard backlight change events
      platform/x86: silead_dmi: Add entry for newer BIOS for Trekstor Surftab 7.0
      platform/x86: GPD pocket fan: Set speed to max on get_temp failure
      platform/x86: GPD pocket fan: Use a min-speed of 2 while charging
      platform/x86: GPD pocket fan: Stop work on suspend

Ivan Vecera (1):
      platform/x86: mlx-platform: fix module aliases

Jiaxun Yang (3):
      platform/x86: ideapad-laptop: Remove unnecessary else
      platform/x86: ideapad-laptop: Use __func__ instead of write_ec_cmd in pr_err
      platform/x86: ideapad-laptop: add lenovo RESCUER R720-15IKBN to no_hw_rfkill_list

Kiernan Hager (1):
      platform/x86: asus-nb-wmi: Support ALS on the Zenbook UX430UQ

Lukas Wunner (1):
      Revert "apple-gmux: lock iGP IO to protect from vgaarb changes"

Marco Martin (1):
      platform/x86: intel-vbtn: Support tablet mode switch

Mario Limonciello (2):
      platform/x86: dell-smbios: Correct notation for filtering
      platform/x86: dell-laptop: Allocate buffer on heap rather than globally

Maruyama Shohei (1):
      platform/x86: silead_dmi: add entry for Chuwi Hi8 tablet

Nerijus Baliunas (1):
      platform/x86: silead_dmi: Add support for the Onda oBook 20 Plus tablet

Olle Liljenzin (1):
      platform/x86: ideapad-laptop: Add Y720-15IKB to no_hw_rfkill

Pali Rohár (2):
      platform/x86: dell-laptop: Fix keyboard max lighting for Dell Latitude E6410
      platform/x86: dell-laptop: Use bool in struct quirk_entry for true/false fields

Paul Cercueil (1):
      platform/x86: silead_dmi: Add entry for the Teclast X98 Plus II

Peter Hutterer (1):
      platform/x86: asus-wireless: send an EV_SYN/SYN_REPORT between state changes

Rafael J. Wysocki (1):
      platform/x86: wmi: Call acpi_wmi_init() later

Rajneesh Bhardwaj (11):
      platform/x86: intel_pmc_core: Remove unused EXPORTED API
      platform/x86: intel_pmc_core: Remove unused variable
      platform/x86: intel_pmc_core: Fix kernel doc for pmc_dev
      platform/x86: intel_pmc_core: Fix file permission warnings
      platform/x86: intel_pmc_core: Update Kconfig
      platform/x86: intel_pmc_core: Refactor debugfs entries
      platform/x86: intel_pmc_core: Convert to ICPU macro
      platform/x86: intel_pmc_core: Remove unused header file
      x86/cpu: Add Cannonlake to Intel family
      platform/x86: intel_pmc_core: Add CannonLake PCH support
      platform/x86: intel_pmc_core: Special case for Coffeelake

Randy Dunlap (1):
      platform/x86: have ACPI_CMPC use depends instead of select for INPUT

Shih-Yuan Lee (FourDollars) (1):
      platform/x86: dell-wmi: Add an event created by Dell Latitude 5495

Srinivas Pandruvada (4):
      platform/x86: intel_pmc_core: Change driver to a module
      platform/x86: intel_pmc_core: Substitute PCI with CPUID enumeration
      ACPI / LPIT: Export lpit_read_residency_count_address()
      platform/x86: intel_pmc_core: Read base address from LPIT

Stefan Brüns (5):
      platform/x86: intel-vbtn: support SW_TABLET_MODE
      platform/x86: intel-vbtn: Support separate press/release events
      Input: add KEY_ROTATE_LOCK_TOGGLE
      platform/x86: intel-vbtn: support KEY_ROTATE_LOCK_TOGGLE
      platform/x86: intel-vbtn: support panel front button

Takashi Iwai (1):
      platform/x86: Add support for Dollar Cove TI power button

Vadim Pasternak (11):
      platform/x86: Move Mellanox platform hotplug driver to platform/mellanox
      platform/mellanox: mlxreg-hotplug: Remove unused wait.h include
      platform/mellanox: Rename i2c bus to nr
      platform/mellanox: Group create/destroy with attribute functions
      platform/mellanox: mlxreg-hotplug: Modify to use a regmap interface
      platform/mellanox: mlxreg-hotplug: Enable building for ARM
      platform/x86: mlx-platform: Allow compilation for 32 bit arch
      platform/x86: mlx-platform: Document pdev_hotplug field
      platform/x86: mlx-platform: Add IO access verification callbacks
      platform/mellanox: mlxreg-hotplug: Add check for negative adapter number
      platform/x86: mlx-platform: Add hotplug device unregister to error path

weiyongjun (A) (1):
      platform/x86: dell-laptop: make some local functions static

 .../ABI/testing/sysfs-driver-samsung-laptop        |   2 +-
 MAINTAINERS                                        |  15 +-
 arch/x86/include/asm/intel-family.h                |   6 +
 arch/x86/include/asm/intel_pmc_ipc.h               |   6 +
 arch/x86/include/asm/pmc_core.h                    |  27 -
 drivers/acpi/acpi_lpit.c                           |   1 +
 drivers/platform/Kconfig                           |   2 +
 drivers/platform/Makefile                          |   1 +
 drivers/platform/mellanox/Kconfig                  |  26 +
 drivers/platform/mellanox/Makefile                 |   6 +
 drivers/platform/mellanox/mlxreg-hotplug.c         | 638 +++++++++++++++++++++
 drivers/platform/x86/Kconfig                       |  56 +-
 drivers/platform/x86/Makefile                      |   4 +-
 drivers/platform/x86/acer-wireless.c               |  71 +++
 drivers/platform/x86/alienware-wmi.c               |  17 +
 drivers/platform/x86/apple-gmux.c                  |  48 +-
 drivers/platform/x86/asus-nb-wmi.c                 |  13 +-
 drivers/platform/x86/asus-wireless.c               |   1 +
 drivers/platform/x86/dell-laptop.c                 | 273 ++++++---
 drivers/platform/x86/dell-smbios.c                 |   8 +-
 drivers/platform/x86/dell-wmi.c                    |   5 +
 drivers/platform/x86/gpd-pocket-fan.c              | 216 +++++++
 drivers/platform/x86/ideapad-laptop.c              |  28 +-
 drivers/platform/x86/intel-hid.c                   |  41 +-
 drivers/platform/x86/intel-vbtn.c                  |  65 ++-
 drivers/platform/x86/intel_chtdc_ti_pwrbtn.c       |  93 +++
 drivers/platform/x86/intel_int0002_vgpio.c         |   2 +-
 drivers/platform/x86/intel_pmc_core.c              | 280 +++++----
 drivers/platform/x86/intel_pmc_core.h              |  29 +-
 drivers/platform/x86/intel_pmc_ipc.c               |  33 +-
 drivers/platform/x86/intel_telemetry_debugfs.c     |  83 ++-
 drivers/platform/x86/mlx-platform.c                | 324 +++++++++--
 drivers/platform/x86/mlxcpld-hotplug.c             | 515 -----------------
 drivers/platform/x86/pmc_atom.c                    |  56 +-
 drivers/platform/x86/silead_dmi.c                  | 175 ++++++
 drivers/platform/x86/thinkpad_acpi.c               |  18 +-
 drivers/platform/x86/wmi.c                         |   2 +-
 include/linux/platform_data/mlxcpld-hotplug.h      |  99 ----
 include/linux/platform_data/mlxreg.h               | 144 +++++
 include/uapi/linux/input-event-codes.h             |   1 +
 40 files changed, 2320 insertions(+), 1110 deletions(-)
 delete mode 100644 arch/x86/include/asm/pmc_core.h
 create mode 100644 drivers/platform/mellanox/Kconfig
 create mode 100644 drivers/platform/mellanox/Makefile
 create mode 100644 drivers/platform/mellanox/mlxreg-hotplug.c
 create mode 100644 drivers/platform/x86/acer-wireless.c
 create mode 100644 drivers/platform/x86/gpd-pocket-fan.c
 create mode 100644 drivers/platform/x86/intel_chtdc_ti_pwrbtn.c
 delete mode 100644 drivers/platform/x86/mlxcpld-hotplug.c
 delete mode 100644 include/linux/platform_data/mlxcpld-hotplug.h
 create mode 100644 include/linux/platform_data/mlxreg.h

-- 
Darren Hart
VMware Open Source Technology Center
