Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeFDL3a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:29:30 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:38261 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeFDL32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:29:28 -0400
X-Google-Smtp-Source: ADUXVKL5UI4CJx/Q87+UndDGLNetWeLGh4kFI38gSONeJpG1uFUF8cLAoJO9Xr/Mma+vFE66dABQnnqMcHcldklrQDA=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Jun 2018 13:29:27 +0200
X-Google-Sender-Auth: fl-iqbSUbz93WLGI0ie5HKRrjXI
Message-ID: <CAJZ5v0i4-=8c5nBHyBhfyUKa8Bu3fhz8SE6dGRNDOurgvnc44Q@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v4.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.18-rc1

with top-most commit 2448d1399bac5b49c2664f96e223e42d2b88c022

 Merge branches 'acpi-soc' and 'acpi-tables'

on top of commit 771c577c23bac90597c685971d7297ea00f99d11

 Linux 4.17-rc6

to receive the first batch of ACPI updates for 4.18-rc1.

These update the ACPICA code in the kernel to the 20180508 upstream
revision and make it support the RT patch, add CPPC v3 support to the
ACPI CPPC library, add a WDAT-based watchdog quirk to prevent clashes
with the RTC, add quirks to the ACPI AC and battery drivers, and
update the ACPI SoC drivers.

Specifics:

 - Update the ACPICA code in the kernel to the 20180508 upstream
   revision including:
   * iASL -tc option enhancement (Bob Moore).
   * Debugger improvements (Bob Moore).
   * Support for tables larger than 1 MB in acpidump/acpixtract
     (Bob Moore).
   * Minor fixes and cleanups (Colin Ian King, Toomas Soome).

 - Make the ACPICA code in the kernel support the RT patch (Sebastian
   Andrzej Siewior, Steven Rostedt).

 - Add a kmemleak annotation to the ACPICA code (Larry Finger).

 - Add CPPC v3 support to the ACPI CPPC library and fix two issues
   related to CPPC (Prashanth Prakash, Al Stone).

 - Add an ACPI WDAT-based watchdog quirk to prefer iTCO_wdt on
   systems where WDAT clashes with the RTC SRAM (Mika Westerberg).

 - Add some quirks to the ACPI AC and battery drivers (Carlo Caione,
   Hans de Goede).

 - Update the ACPI SoC drivers for Intel (LPSS) and AMD (APD)
   platforms (Akshu Agrawal, Hans de Goede).

 - Fix up some assorted minor issues (Al Stone, Laszlo Toth,
   Mathieu Malaterre).

Thanks!


---------------

Akshu Agrawal (2):
      clk: x86: Add ST oscout platform clock
      ACPI: APD: Add AMD misc clock handler support

Al Stone (2):
      ACPI / tables: improve comments regarding acpi_parse_entries_array()
      mailbox: PCC: erroneous error message when parsing ACPI PCCT

Bob Moore (7):
      ACPICA: iASL: Enhance the -tc option (create AML hex file in C)
      ACPICA: Improve error messages for the namespace root node
      ACPICA: Debugger: Add Package support for "test objects" command
      ACPICA: Debugger: Removed direct support for EC address space in
"Test Objects"
      ACPICA: Update version to 20180427
      ACPICA: acpidump/acpixtract: Support for tables larger than 1MB
      ACPICA: Update version to 20180508

Carlo Caione (2):
      ACPI / battery: Add quirk to avoid checking for PMIC with native driver
      ACPI / AC: Add quirk to avoid checking for PMIC with native driver

Colin Ian King (2):
      ACPICA: Tables: Fix spelling mistake in comment
      ACPICA: Fix potential infinite loop in acpi_rs_dump_byte_list

Hans de Goede (5):
      ACPI / AC: Remove initializer for unused ident dmi_system_id
      ACPI / battery: Remove initializer for unused ident dmi_system_id
      ACPI / battery: Add handling for devices which wrongly report
discharging state
      ACPI / battery: Ignore AC state in handle_discharging on systems
where it is broken
      ACPI / LPSS: Only call pwm_add_table() for Bay Trail PWM if PMIC HRV is 2

Larry Finger (1):
      ACPICA: Mark acpi_ut_create_internal_object_dbg() memory
allocations as non-leaks

Laszlo Toth (1):
      ACPI: add missing newline to printk

Mathieu Malaterre (1):
      ACPI: Add missing prototype_for arch_post_acpi_subsys_init()

Mika Westerberg (1):
      ACPI / watchdog: Prefer iTCO_wdt always when WDAT table uses RTC SRAM

Prashanth Prakash (4):
      ACPI / CPPC: Add support for CPPC v3
      ACPI / CPPC: Check for valid PCC subspace only if PCC is used
      cpufreq / CPPC: Support for CPPC v3
      ACPI / CPPC: Document CPPC sysfs interface
      ACPI / CPPC: Fix invalid PCC channel status errors

Sebastian Andrzej Siewior (1):
      ACPICA: provide abstraction for raw_spinlock_t

Steven Rostedt (1):
      ACPICA: Convert acpi_gbl_hardware lock back to an acpi_raw_spinlock

Toomas Soome (1):
      ACPICA: vsnprintf: this statement may fall through

---------------

 Documentation/acpi/cppc_sysfs.txt    |  69 +++++++++++++++
 drivers/acpi/ac.c                    |  48 ++++++++---
 drivers/acpi/acpi_apd.c              |  47 +++++++++++
 drivers/acpi/acpi_lpss.c             |   6 +-
 drivers/acpi/acpi_watchdog.c         |  72 ++++++++++------
 drivers/acpi/acpica/acapps.h         |   2 +
 drivers/acpi/acpica/acglobal.h       |   2 +-
 drivers/acpi/acpica/dbnames.c        |  12 ++-
 drivers/acpi/acpica/dbtest.c         |  59 ++++++++++++-
 drivers/acpi/acpica/dswscope.c       |   8 +-
 drivers/acpi/acpica/hwregs.c         |   4 +-
 drivers/acpi/acpica/hwxface.c        |   4 +-
 drivers/acpi/acpica/rsdump.c         |   2 +-
 drivers/acpi/acpica/tbinstal.c       |   2 +-
 drivers/acpi/acpica/utbuffer.c       |   4 +-
 drivers/acpi/acpica/utmutex.c        |   4 +-
 drivers/acpi/acpica/utobject.c       |   2 +
 drivers/acpi/acpica/utprint.c        |   1 +
 drivers/acpi/acpica/utstring.c       |   2 +-
 drivers/acpi/battery.c               |  81 +++++++++++++++---
 drivers/acpi/cppc_acpi.c             | 159 +++++++++++++++++++++++------------
 drivers/acpi/reboot.c                |   4 +-
 drivers/acpi/tables.c                |   9 +-
 drivers/clk/x86/Makefile             |   3 +-
 drivers/clk/x86/clk-st.c             |  77 +++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c       |  80 +++++++++++++++---
 drivers/mailbox/pcc.c                |  81 +++++++++---------
 include/acpi/acnames.h               |   7 +-
 include/acpi/acpiosxf.h              |  21 +++++
 include/acpi/acpixf.h                |   2 +-
 include/acpi/actypes.h               |   4 +
 include/acpi/cppc_acpi.h             |  14 ++-
 include/acpi/platform/aclinux.h      |   5 ++
 include/acpi/platform/aclinuxex.h    |  30 +++++++
 include/linux/acpi.h                 |   1 +
 include/linux/platform_data/clk-st.h |  17 ++++
 36 files changed, 751 insertions(+), 194 deletions(-)
