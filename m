Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754369AbeDBLKR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 07:10:17 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:41433 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbeDBLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 07:10:11 -0400
X-Google-Smtp-Source: AIpwx4+CUIlIPCfnRf+OmiPAxR7/psVmhJ6JvIeVLK876haJXoLnMrUSt2sNvUfgxyblMHOqefZrvxtZtvmPMFzjxwQ=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Apr 2018 13:10:09 +0200
X-Google-Sender-Auth: OHB3ZzAgCwipjvE1uSM4hQjf7Fk
Message-ID: <CAJZ5v0jSdVxb9ZuXExRBitmq4uzhPMRMDaVLg0-opO+ite4cMA@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v4.17-rc1
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
 acpi-4.17-rc1

with top-most commit 49076b2c64a25d21d5d2870dc9caa4aa562b8609

 Merge branches 'acpi-osi', 'acpi-scan', 'acpi-tad', 'acpi-video' and
'acpi-misc'

on top of commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274

 Linux 4.16-rc7

to receive ACPI updates for 4.17-rc1.

These update the ACPICA code in the kernel to follow upstream
revision 20180313 which includes fixes related to the so-called
module-level AML (mostly "if" type of statements outside of any
methods) that should improve the handling of systems that load
alternative SSDTs depending on the current configuration, for
example, and event handling fixes related to disabling and enabling
GPEs on system startup and on suspend/resume.  Moreover, the ACPICA
license boilerplate is replaced with SPDX license IDs which alone
reduces the number of lines of ACPICA code in the kernel quite a bit.

Also added is a new driver for the generic ACPI Time and Alarm
Device (TAD).  At the moment it only handles the most basic
capabilities of the TAD, however.

In addition to that the ACPI battery driver is improved to handle
battery thresholds on ThinkPads, among other things, some bugs are
fixed, a new backlight quirk is added and some documentation is
updated.

Specifics:

 - Update the in-kernel ACPICA code to upstream revision 20180313
   including:
   * Module-level AML code handling fixes and simplifications (Bob
     Moore, Erik Schmauss).
   * Fixes and cleanups related to messaging (Bob Moore).
   * Events handling fixes related to disabling and enabling GPEs
     (Erik Schmauss).
   * Introduction of SPDX license identifiers and removal of license
     boilerplate in multiple files (Erik Schmauss).
   * Assorted fixes and cleanups (Bob Moore, Erik Schmauss, Hans
     de Goede, Seunghun Han).

 - Add new basic driver for the ACPI Time and Alarm Device (Rafael
   Wysocki).

 - Modify the ACPI battery driver to support battery thresholds on
   Lenovo ThinkPads (Ognjen Galic, Colin Ian King).

 - Avoid reporting battery capacity over 100 in the ACPI battery
   driver in some cases (Laszlo Toth).

 - Make the kernel recognize an OEM _OSI string from Dell to avoid
   power management issues with NVidia GPUs in Dell platforms (Alex
   Hung).

 - Make the PCI IRQ management code handle missing _PRS cleanly (Alex
   Hung).

 - Fix uevent notifications related to device hotplut (Lee, Chun-Yi).

 - Prevent the ACPI PAD driver from leaking memory (Lenny Szubowicz).

 - Update the ACPI CPPC library code to include subspace IDs in the
   kernel messages logged by it (George Cherian).

 - Add backlight quirk for Samsung 670Z5E (Hans de Goede).

 - Add the NFIT and HMAT tables to the list of ACPI tables that can
   be overridden via initrd (Dan Williams).

 - Fix and clean up some ACPI documentation and Kconfig help language
   (Aishwarya Pant, Randy Dunlap).

 - Replace license boilerplate with an SPDX license ID in the ACPI
   PMIC operation region handling code (Rajmohan Mani).

Thanks!


---------------

Aishwarya Pant (1):
      ACPI: sysfs: Update device object sysfs documentation

Alex Hung (2):
      ACPI / PCI: pci_link: Allow the absence of _PRS and change log level
      ACPI / OSI: Add OEM _OSI strings to disable NVidia RTD3

Bob Moore (11):
      ACPICA: Update error message, no functional change
      ACPICA: Update for some debug output. No functional change
      ACPICA: Revert "Fix for implicit result conversion for the
To____ functions"
      ACPICA: Add option to disable Package object name resolution errors
      ACPICA: Update version to 20180209
      ACPICA: Fix memory leak on unusual memory leak
      ACPICA: AML Debug Object: Don't ignore output of zero-length strings
      ACPICA: Change a compile-time option to a runtime option
      ACPICA: Rename a global for clarity, no functional change
      ACPICA: Cleanup/simplify module-level code support
      ACPICA: Update version to 20180313

Colin Ian King (1):
      ACPI: battery: make function __battery_hook_unregister() static

Dan Williams (1):
      ACPI: add NFIT and HMAT to the initrd override list

Erik Schmauss (8):
      ACPICA: Restructure ACPI table files
      ACPICA: Events: Stop unconditionally clearing ACPI IRQs during
suspend/resume
      ACPICA: Events: Add parallel GPE handling support to fix
potential redundant _Exx evaluations
      ACPICA: Events: Dispatch GPEs after enabling for the first time
      ACPICA: macros: fix ACPI_ERROR_NAMESPACE macro
      ACPICA: adding SPDX headers
      ACPICA: Events: add a return on failure from acpi_hw_register_read
      ACPICA: Integrate package handling with module-level code

George Cherian (1):
      ACPI / CPPC: Update all pr_(debug/err) messages to log the susbspace id

Hans de Goede (2):
      ACPICA: Remove calling of _STA from acpi_get_object_info()
      ACPI / video: Add quirk to force acpi-video backlight on Samsung 670Z5E

Laszlo Toth (1):
      ACPI: battery: do not export degraded capacity values over 100

Lee, Chun-Yi (1):
      ACPI / scan: Send change uevent with offine environmental data

Lenny Szubowicz (1):
      ACPI: acpi_pad: Fix memory leak in power saving threads

Ognjen Galic (4):
      battery: Add the battery hooking API
      power: add to_power_supply macro to the API
      thinkpad_acpi: Add support for battery thresholds
      ACPI: battery: Add the ThinkPad "Not Charging" quirk

Rafael J. Wysocki (2):
      Revert "ACPI: battery: Add the ThinkPad "Not Charging" quirk"
      ACPI: Add Time and Alarm Device (TAD) driver

Rajmohan Mani (1):
      ACPI / PMIC: Replace license boilerplate with SPDX license identifier

Randy Dunlap (1):
      ACPI / Kconfig: Update ACPI_PROCFS_POWER help text

Seunghun Han (1):
      ACPICA: acpi: acpica: fix acpi operand cache leak in nseval.c

---------------

 .mailmap                                           |    1 -
 Documentation/ABI/testing/sysfs-bus-acpi           |   37 +
 .../ABI/testing/sysfs-devices-platform-ACPI-TAD    |  113 ++
 Documentation/isdn/INTERFACE.CAPI                  |    2 +-
 Documentation/isdn/README                          |    4 +-
 Documentation/isdn/README.FAQ                      |    4 +-
 Documentation/isdn/README.gigaset                  |   16 +-
 MAINTAINERS                                        |   39 +-
 Makefile                                           |    6 +-
 arch/arm/Kconfig.debug                             |    1 -
 arch/arm/boot/deflate_xip_data.sh                  |    6 +-
 arch/arm/boot/dts/aspeed-g4.dtsi                   |    5 -
 arch/arm/boot/dts/aspeed-g5.dtsi                   |    5 -
 arch/arm/boot/dts/imx7d-sdb.dts                    |    2 +-
 arch/arm/boot/dts/rk3288.dtsi                      |    2 -
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |   63 +-
 arch/arm/include/asm/vdso.h                        |    2 +
 arch/arm/kernel/vdso.c                             |   12 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        |    4 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |    3 -
 arch/arm/plat-omap/dmtimer.c                       |    7 +-
 arch/arm/plat-omap/include/plat/sram.h             |   11 +-
 arch/arm/plat-omap/sram.c                          |   36 +-
 arch/arm/vfp/vfpmodule.c                           |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   16 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |    8 +-
 arch/powerpc/include/asm/book3s/64/mmu.h           |    3 -
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |    3 +
 arch/powerpc/include/asm/cputable.h                |    3 +-
 arch/powerpc/include/asm/mmu_context.h             |   18 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |    6 -
 arch/powerpc/kernel/exceptions-64s.S               |    2 +-
 arch/powerpc/kernel/irq.c                          |    8 -
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |    3 -
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |   11 -
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   35 +-
 arch/powerpc/mm/hash_native_64.c                   |   16 +-
 arch/powerpc/mm/mmu_context_book3s64.c             |    1 -
 arch/powerpc/mm/pgtable_64.c                       |    1 -
 arch/powerpc/mm/tlb-radix.c                        |  169 +-
 arch/x86/events/intel/ds.c                         |   25 +-
 arch/x86/include/asm/alternative.h                 |    4 +-
 arch/x86/include/asm/hw_irq.h                      |    1 -
 arch/x86/include/asm/uv/uv_mmrs.h                  |    2 +-
 arch/x86/kernel/idt.c                              |    3 -
 arch/x86/kernel/kvm.c                              |    4 +-
 arch/x86/kvm/vmx.c                                 |   10 +-
 arch/x86/platform/uv/tlb_uv.c                      |    2 +
 arch/x86/purgatory/Makefile                        |    2 +-
 drivers/acpi/Kconfig                               |   21 +-
 drivers/acpi/Makefile                              |    1 +
 drivers/acpi/ac.c                                  |    2 +-
 drivers/acpi/acpi_pad.c                            |    3 +
 drivers/acpi/acpi_tad.c                            |  473 +++++
 drivers/acpi/acpica/acapps.h                       |   38 +-
 drivers/acpi/acpica/accommon.h                     |   38 +-
 drivers/acpi/acpica/acconvert.h                    |   38 +-
 drivers/acpi/acpica/acdebug.h                      |   38 +-
 drivers/acpi/acpica/acdispat.h                     |   38 +-
 drivers/acpi/acpica/acevents.h                     |   56 +-
 drivers/acpi/acpica/acglobal.h                     |   38 +-
 drivers/acpi/acpica/achware.h                      |   38 +-
 drivers/acpi/acpica/acinterp.h                     |   38 +-
 drivers/acpi/acpica/aclocal.h                      |   38 +-
 drivers/acpi/acpica/acmacros.h                     |   42 +-
 drivers/acpi/acpica/acnamesp.h                     |   38 +-
 drivers/acpi/acpica/acobject.h                     |   38 +-
 drivers/acpi/acpica/acopcode.h                     |   52 +-
 drivers/acpi/acpica/acparser.h                     |   38 +-
 drivers/acpi/acpica/acpredef.h                     |   38 +-
 drivers/acpi/acpica/acresrc.h                      |   38 +-
 drivers/acpi/acpica/acstruct.h                     |   38 +-
 drivers/acpi/acpica/actables.h                     |   38 +-
 drivers/acpi/acpica/acutils.h                      |   38 +-
 drivers/acpi/acpica/amlcode.h                      |   58 +-
 drivers/acpi/acpica/amlresrc.h                     |   38 +-
 drivers/acpi/acpica/dbcmds.c                       |   38 +-
 drivers/acpi/acpica/dbconvert.c                    |   38 +-
 drivers/acpi/acpica/dbdisply.c                     |   43 +-
 drivers/acpi/acpica/dbexec.c                       |   38 +-
 drivers/acpi/acpica/dbfileio.c                     |   38 +-
 drivers/acpi/acpica/dbhistry.c                     |   40 +-
 drivers/acpi/acpica/dbinput.c                      |   38 +-
 drivers/acpi/acpica/dbmethod.c                     |   38 +-
 drivers/acpi/acpica/dbnames.c                      |   38 +-
 drivers/acpi/acpica/dbobject.c                     |   38 +-
 drivers/acpi/acpica/dbstats.c                      |   38 +-
 drivers/acpi/acpica/dbtest.c                       |   38 +-
 drivers/acpi/acpica/dbutils.c                      |   38 +-
 drivers/acpi/acpica/dbxface.c                      |   38 +-
 drivers/acpi/acpica/dsargs.c                       |   41 +-
 drivers/acpi/acpica/dscontrol.c                    |   38 +-
 drivers/acpi/acpica/dsdebug.c                      |   38 +-
 drivers/acpi/acpica/dsfield.c                      |   40 +-
 drivers/acpi/acpica/dsinit.c                       |   38 +-
 drivers/acpi/acpica/dsmethod.c                     |   40 +-
 drivers/acpi/acpica/dsmthdat.c                     |   38 +-
 drivers/acpi/acpica/dsobject.c                     |   38 +-
 drivers/acpi/acpica/dsopcode.c                     |   44 +-
 drivers/acpi/acpica/dspkginit.c                    |  204 +-
 drivers/acpi/acpica/dsutils.c                      |   38 +-
 drivers/acpi/acpica/dswexec.c                      |   44 +-
 drivers/acpi/acpica/dswload.c                      |   40 +-
 drivers/acpi/acpica/dswload2.c                     |   38 +-
 drivers/acpi/acpica/dswscope.c                     |   40 +-
 drivers/acpi/acpica/dswstate.c                     |   40 +-
 drivers/acpi/acpica/evevent.c                      |   47 +-
 drivers/acpi/acpica/evglock.c                      |   38 +-
 drivers/acpi/acpica/evgpe.c                        |  282 ++-
 drivers/acpi/acpica/evgpeblk.c                     |   62 +-
 drivers/acpi/acpica/evgpeinit.c                    |   38 +-
 drivers/acpi/acpica/evgpeutil.c                    |   38 +-
 drivers/acpi/acpica/evhandler.c                    |   38 +-
 drivers/acpi/acpica/evmisc.c                       |   38 +-
 drivers/acpi/acpica/evregion.c                     |   40 +-
 drivers/acpi/acpica/evrgnini.c                     |   45 +-
 drivers/acpi/acpica/evsci.c                        |   38 +-
 drivers/acpi/acpica/evxface.c                      |   49 +-
 drivers/acpi/acpica/evxfevnt.c                     |   40 +-
 drivers/acpi/acpica/evxfgpe.c                      |   61 +-
 drivers/acpi/acpica/evxfregn.c                     |   38 +-
 drivers/acpi/acpica/exconcat.c                     |   38 +-
 drivers/acpi/acpica/exconfig.c                     |   38 +-
 drivers/acpi/acpica/exconvrt.c                     |   39 +-
 drivers/acpi/acpica/excreate.c                     |   40 +-
 drivers/acpi/acpica/exdebug.c                      |   45 +-
 drivers/acpi/acpica/exdump.c                       |   38 +-
 drivers/acpi/acpica/exfield.c                      |   38 +-
 drivers/acpi/acpica/exfldio.c                      |   40 +-
 drivers/acpi/acpica/exmisc.c                       |   38 +-
 drivers/acpi/acpica/exmutex.c                      |   40 +-
 drivers/acpi/acpica/exnames.c                      |   45 +-
 drivers/acpi/acpica/exoparg1.c                     |   38 +-
 drivers/acpi/acpica/exoparg2.c                     |   38 +-
 drivers/acpi/acpica/exoparg3.c                     |   38 +-
 drivers/acpi/acpica/exoparg6.c                     |   38 +-
 drivers/acpi/acpica/exprep.c                       |   38 +-
 drivers/acpi/acpica/exregion.c                     |   40 +-
 drivers/acpi/acpica/exresnte.c                     |   38 +-
 drivers/acpi/acpica/exresolv.c                     |   38 +-
 drivers/acpi/acpica/exresop.c                      |   39 +-
 drivers/acpi/acpica/exstore.c                      |   38 +-
 drivers/acpi/acpica/exstoren.c                     |   38 +-
 drivers/acpi/acpica/exstorob.c                     |   38 +-
 drivers/acpi/acpica/exsystem.c                     |   40 +-
 drivers/acpi/acpica/extrace.c                      |   40 +-
 drivers/acpi/acpica/exutils.c                      |   40 +-
 drivers/acpi/acpica/hwacpi.c                       |   38 +-
 drivers/acpi/acpica/hwesleep.c                     |   40 +-
 drivers/acpi/acpica/hwgpe.c                        |   41 +-
 drivers/acpi/acpica/hwpci.c                        |   38 +-
 drivers/acpi/acpica/hwregs.c                       |   38 +-
 drivers/acpi/acpica/hwsleep.c                      |   49 +-
 drivers/acpi/acpica/hwtimer.c                      |   40 +-
 drivers/acpi/acpica/hwvalid.c                      |   38 +-
 drivers/acpi/acpica/hwxface.c                      |   40 +-
 drivers/acpi/acpica/hwxfsleep.c                    |   42 +-
 drivers/acpi/acpica/nsaccess.c                     |   38 +-
 drivers/acpi/acpica/nsalloc.c                      |   38 +-
 drivers/acpi/acpica/nsarguments.c                  |   38 +-
 drivers/acpi/acpica/nsconvert.c                    |   40 +-
 drivers/acpi/acpica/nsdump.c                       |   40 +-
 drivers/acpi/acpica/nsdumpdv.c                     |   43 +-
 drivers/acpi/acpica/nseval.c                       |   68 +-
 drivers/acpi/acpica/nsinit.c                       |   45 +-
 drivers/acpi/acpica/nsload.c                       |   62 +-
 drivers/acpi/acpica/nsnames.c                      |   41 +-
 drivers/acpi/acpica/nsobject.c                     |   38 +-
 drivers/acpi/acpica/nsparse.c                      |   74 +-
 drivers/acpi/acpica/nspredef.c                     |   38 +-
 drivers/acpi/acpica/nsprepkg.c                     |   38 +-
 drivers/acpi/acpica/nsrepair.c                     |   40 +-
 drivers/acpi/acpica/nsrepair2.c                    |   40 +-
 drivers/acpi/acpica/nssearch.c                     |   38 +-
 drivers/acpi/acpica/nsutils.c                      |   40 +-
 drivers/acpi/acpica/nswalk.c                       |   38 +-
 drivers/acpi/acpica/nsxfeval.c                     |   38 +-
 drivers/acpi/acpica/nsxfname.c                     |   59 +-
 drivers/acpi/acpica/nsxfobj.c                      |   38 +-
 drivers/acpi/acpica/psargs.c                       |   44 +-
 drivers/acpi/acpica/psloop.c                       |   66 +-
 drivers/acpi/acpica/psobject.c                     |   48 +-
 drivers/acpi/acpica/psopcode.c                     |   38 +-
 drivers/acpi/acpica/psopinfo.c                     |   38 +-
 drivers/acpi/acpica/psparse.c                      |   40 +-
 drivers/acpi/acpica/psscope.c                      |   40 +-
 drivers/acpi/acpica/pstree.c                       |   39 +-
 drivers/acpi/acpica/psutils.c                      |   40 +-
 drivers/acpi/acpica/pswalk.c                       |   38 +-
 drivers/acpi/acpica/psxface.c                      |   38 +-
 drivers/acpi/acpica/rsaddr.c                       |   38 +-
 drivers/acpi/acpica/rscalc.c                       |   38 +-
 drivers/acpi/acpica/rscreate.c                     |   38 +-
 drivers/acpi/acpica/rsdump.c                       |   38 +-
 drivers/acpi/acpica/rsdumpinfo.c                   |   38 +-
 drivers/acpi/acpica/rsinfo.c                       |   38 +-
 drivers/acpi/acpica/rsio.c                         |   38 +-
 drivers/acpi/acpica/rsirq.c                        |   38 +-
 drivers/acpi/acpica/rslist.c                       |   38 +-
 drivers/acpi/acpica/rsmemory.c                     |   38 +-
 drivers/acpi/acpica/rsmisc.c                       |   38 +-
 drivers/acpi/acpica/rsserial.c                     |   38 +-
 drivers/acpi/acpica/rsutils.c                      |   38 +-
 drivers/acpi/acpica/rsxface.c                      |   38 +-
 drivers/acpi/acpica/tbdata.c                       |   58 +-
 drivers/acpi/acpica/tbfadt.c                       |   40 +-
 drivers/acpi/acpica/tbfind.c                       |   38 +-
 drivers/acpi/acpica/tbinstal.c                     |   44 +-
 drivers/acpi/acpica/tbprint.c                      |   40 +-
 drivers/acpi/acpica/tbutils.c                      |   40 +-
 drivers/acpi/acpica/tbxface.c                      |   40 +-
 drivers/acpi/acpica/tbxfload.c                     |   51 +-
 drivers/acpi/acpica/tbxfroot.c                     |   38 +-
 drivers/acpi/acpica/utaddress.c                    |   38 +-
 drivers/acpi/acpica/utalloc.c                      |   38 +-
 drivers/acpi/acpica/utascii.c                      |   40 +-
 drivers/acpi/acpica/utbuffer.c                     |   38 +-
 drivers/acpi/acpica/utcache.c                      |   45 +-
 drivers/acpi/acpica/utcopy.c                       |   40 +-
 drivers/acpi/acpica/utdebug.c                      |   40 +-
 drivers/acpi/acpica/utdecode.c                     |   40 +-
 drivers/acpi/acpica/utdelete.c                     |   58 +-
 drivers/acpi/acpica/uterror.c                      |   38 +-
 drivers/acpi/acpica/uteval.c                       |   38 +-
 drivers/acpi/acpica/utexcep.c                      |   38 +-
 drivers/acpi/acpica/utglobal.c                     |   38 +-
 drivers/acpi/acpica/uthex.c                        |   40 +-
 drivers/acpi/acpica/utids.c                        |   38 +-
 drivers/acpi/acpica/utinit.c                       |   38 +-
 drivers/acpi/acpica/utlock.c                       |   40 +-
 drivers/acpi/acpica/utmath.c                       |   38 +-
 drivers/acpi/acpica/utmisc.c                       |   38 +-
 drivers/acpi/acpica/utmutex.c                      |   38 +-
 drivers/acpi/acpica/utnonansi.c                    |   38 +-
 drivers/acpi/acpica/utobject.c                     |   40 +-
 drivers/acpi/acpica/utosi.c                        |   40 +-
 drivers/acpi/acpica/utownerid.c                    |   38 +-
 drivers/acpi/acpica/utpredef.c                     |   40 +-
 drivers/acpi/acpica/utprint.c                      |   40 +-
 drivers/acpi/acpica/utresdecode.c                  |   38 +-
 drivers/acpi/acpica/utresrc.c                      |   38 +-
 drivers/acpi/acpica/utstate.c                      |   38 +-
 drivers/acpi/acpica/utstring.c                     |   38 +-
 drivers/acpi/acpica/utstrsuppt.c                   |   38 +-
 drivers/acpi/acpica/utstrtoul64.c                  |   38 +-
 drivers/acpi/acpica/uttrack.c                      |   40 +-
 drivers/acpi/acpica/utuuid.c                       |   38 +-
 drivers/acpi/acpica/utxface.c                      |   40 +-
 drivers/acpi/acpica/utxferror.c                    |   38 +-
 drivers/acpi/acpica/utxfinit.c                     |   86 +-
 drivers/acpi/acpica/utxfmutex.c                    |   38 +-
 drivers/acpi/battery.c                             |  174 +-
 drivers/acpi/battery.h                             |   11 -
 drivers/acpi/bus.c                                 |    6 +-
 drivers/acpi/cppc_acpi.c                           |   27 +-
 drivers/acpi/osi.c                                 |    9 +
 drivers/acpi/pci_link.c                            |    4 +-
 drivers/acpi/pmic/tps68470_pmic.c                  |   10 +-
 drivers/acpi/sbs.c                                 |    2 +-
 drivers/acpi/scan.c                                |    3 +-
 drivers/acpi/tables.c                              |    2 +-
 drivers/acpi/video_detect.c                        |    9 +
 drivers/atm/iphase.c                               |    2 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   20 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |    3 +-
 drivers/gpu/drm/tegra/dc.c                         |    6 +-
 drivers/i2c/busses/i2c-stm32f7.c                   |    5 -
 drivers/infiniband/core/addr.c                     |   25 -
 drivers/infiniband/core/device.c                   |    3 +-
 drivers/infiniband/core/ucma.c                     |   47 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |    2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   12 +-
 drivers/infiniband/hw/mlx5/mr.c                    |    3 -
 drivers/infiniband/hw/qedr/main.c                  |    3 +-
 drivers/infiniband/hw/qedr/verbs.c                 |   45 +-
 drivers/md/dm-mpath.c                              |    2 +-
 drivers/md/dm.c                                    |    8 +-
 drivers/mtd/chips/jedec_probe.c                    |    2 -
 drivers/mtd/nand/atmel/pmecc.c                     |    2 +-
 drivers/net/bonding/bond_main.c                    |   73 +-
 drivers/net/dsa/mt7530.c                           |    2 +-
 drivers/net/ethernet/marvell/mvneta.c              |    1 -
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c     |   72 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   33 +-
 drivers/net/ethernet/mellanox/mlx4/en_main.c       |    4 +-
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |    1 -
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   17 -
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   13 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   34 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   18 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |   78 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c       |    6 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |   20 +-
 drivers/net/ethernet/realtek/r8169.c               |    4 +-
 drivers/net/hyperv/rndis_filter.c                  |    2 +-
 drivers/net/team/team.c                            |   12 +-
 drivers/net/usb/lan78xx.c                          |   33 +-
 drivers/net/usb/qmi_wwan.c                         |    5 -
 drivers/net/vrf.c                                  |    5 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    5 -
 .../wireless/broadcom/brcm80211/brcmfmac/common.h  |    1 -
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   57 -
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      |   62 -
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |    1 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    5 -
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    4 -
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    3 -
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |   21 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   74 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   10 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   38 +-
 drivers/platform/x86/Kconfig                       |    1 +
 drivers/platform/x86/thinkpad_acpi.c               |  389 +++-
 drivers/power/supply/ds2780_battery.c              |    5 -
 drivers/power/supply/ds2781_battery.c              |    5 -
 drivers/power/supply/power_supply_core.c           |    2 +-
 drivers/scsi/hosts.c                               |    1 -
 drivers/scsi/hpsa.c                                |   73 +-
 drivers/scsi/hpsa.h                                |    1 -
 drivers/scsi/ibmvscsi/ibmvfc.c                     |    6 +-
 drivers/scsi/iscsi_tcp.c                           |    8 -
 drivers/scsi/megaraid/megaraid_sas.h               |    1 -
 drivers/scsi/megaraid/megaraid_sas_base.c          |   39 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |   12 +-
 drivers/scsi/sd.c                                  |    2 -
 drivers/scsi/virtio_scsi.c                         |  129 +-
 drivers/vhost/net.c                                |    4 +-
 drivers/vhost/vhost.c                              |   17 +-
 fs/ceph/file.c                                     |    9 +-
 include/acpi/acbuffer.h                            |   38 +-
 include/acpi/acconfig.h                            |   40 +-
 include/acpi/acexcep.h                             |   38 +-
 include/acpi/acnames.h                             |   38 +-
 include/acpi/acoutput.h                            |   38 +-
 include/acpi/acpi.h                                |   38 +-
 include/acpi/acpiosxf.h                            |   38 +-
 include/acpi/acpixf.h                              |   63 +-
 include/acpi/acrestyp.h                            |   38 +-
 include/acpi/actbl.h                               |   38 +-
 include/acpi/actbl1.h                              | 1668 ++++++++--------
 include/acpi/actbl2.h                              | 1990 +++++++++++---------
 include/acpi/actbl3.h                              | 1056 +++++------
 include/acpi/actypes.h                             |   61 +-
 include/acpi/acuuid.h                              |   38 +-
 include/acpi/battery.h                             |   21 +
 include/acpi/platform/acenv.h                      |   38 +-
 include/acpi/platform/acenvex.h                    |   38 +-
 include/acpi/platform/acgcc.h                      |   38 +-
 include/acpi/platform/acgccex.h                    |   38 +-
 include/acpi/platform/acintel.h                    |   38 +-
 include/acpi/platform/aclinux.h                    |   40 +-
 include/acpi/platform/aclinuxex.h                  |   38 +-
 include/linux/if_vlan.h                            |   15 +-
 include/linux/net_dim.h                            |    2 +-
 include/linux/power_supply.h                       |    2 +
 include/net/llc_conn.h                             |    2 +-
 include/net/netfilter/nf_tables.h                  |    4 -
 include/net/sch_generic.h                          |    1 -
 include/rdma/ib_addr.h                             |    2 -
 include/scsi/scsi_host.h                           |    3 -
 ipc/shm.c                                          |   12 -
 kernel/events/hw_breakpoint.c                      |   30 +-
 mm/kmemleak.c                                      |   12 +-
 mm/memcontrol.c                                    |    6 +-
 mm/page_owner.c                                    |    6 +-
 mm/slab.c                                          |    1 -
 mm/vmstat.c                                        |    2 -
 net/batman-adv/gateway_client.c                    |    5 +-
 net/batman-adv/multicast.c                         |    4 +-
 net/core/dev.c                                     |    2 +-
 net/core/skbuff.c                                  |    6 +-
 net/ipv4/ip_tunnel.c                               |   31 +-
 net/ipv4/ip_vti.c                                  |    2 +
 net/ipv4/netfilter/Makefile                        |    2 +-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c     |   14 +-
 net/ipv4/netfilter/nf_socket_ipv4.c                |    6 +-
 net/ipv4/syncookies.c                              |    2 -
 net/ipv4/tcp_input.c                               |    3 -
 net/ipv6/ip6_output.c                              |   13 +-
 net/ipv6/ip6_vti.c                                 |   36 +-
 net/ipv6/netfilter/nf_socket_ipv6.c                |    6 +-
 net/ipv6/route.c                                   |   16 +-
 net/ipv6/seg6_iptunnel.c                           |   16 +-
 net/ipv6/syncookies.c                              |    2 -
 net/llc/llc_c_ac.c                                 |   15 +-
 net/llc/llc_conn.c                                 |   32 +-
 net/netfilter/nf_tables_api.c                      |  106 +-
 net/netfilter/nft_set_hash.c                       |    2 +-
 net/netlink/af_netlink.c                           |    3 -
 net/sched/act_api.c                                |    4 +-
 net/sched/sch_generic.c                            |   17 +-
 net/smc/smc_clc.c                                  |    2 +-
 net/strparser/strparser.c                          |    4 +-
 net/xfrm/xfrm_input.c                              |    6 -
 net/xfrm/xfrm_output.c                             |    5 +-
 scripts/adjust_autoksyms.sh                        |    7 -
 scripts/package/builddeb                           |    2 +-
 scripts/package/mkspec                             |    2 +-
 sound/core/oss/pcm_oss.c                           |    4 +-
 sound/core/pcm_native.c                            |    2 +-
 sound/usb/quirks.c                                 |    1 -
 tools/bpf/bpftool/map.c                            |    2 +-
 tools/objtool/check.c                              |   11 -
 tools/power/acpi/common/cmfsize.c                  |   38 +-
 tools/power/acpi/common/getopt.c                   |   38 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   40 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |   40 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |   40 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |   40 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |   38 +-
 tools/power/acpi/tools/acpidump/apdump.c           |   40 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   38 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   38 +-
 417 files changed, 5389 insertions(+), 12584 deletions(-)
