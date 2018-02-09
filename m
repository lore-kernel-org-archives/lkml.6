Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeBIKTy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:19:54 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33802 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeBIKTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:19:50 -0500
X-Google-Smtp-Source: AH8x2270ObYVZedg5wF46JxVc9zyuRu73jXZyPAU0gmxIX6r2sVVB7fui3sGE+EzYnj6Qz4/YjFa6CCIjBAjyprUqhk=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Feb 2018 11:19:49 +0100
X-Google-Sender-Auth: MFb0KBfamWP8X3g1r85T9sIuNmY
Message-ID: <CAJZ5v0jLu055qJLOjeRC=bMsXdd3QZDPj8Pd8RGpM4+mOs1C4A@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v4.16-rc1
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
 acpi-part2-4.16-rc1

with top-most commit d4abd46b7e7279a61a1aa76d1d1b16a990178e75

 Merge branches 'acpi-video', 'acpi-battery' and 'acpi-cppc'

on top of commit 1a9a126b5098160ca934a352617e9e65dbfa679d

 Merge tag 'acpi-4.16-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 4.16-rc1.

These are mostly fixes and cleanups, a few new quirks, a couple of
updates related to the handling of ACPI tables and ACPICA copyrights
refreshment.

Specifics:

 - Update the ACPICA kernel code to upstream revision 20180105 including:
   * Assorted fixes (Jung-uk Kim).
   * Support for X32 ABI compilation (Anuj Mittal).
   * Update of ACPICA copyrights to 2018 (Bob Moore).

 - Prepare for future modifications to avoid executing the _STA control
   method too early (Hans de Goede).

 - Make the processor performance control library code ignore _PPC
   notifications if they cannot be handled and fix up the C1 idle
   state definition when it is used as a fallback state (Chen Yu,
   Yazen Ghannam).

 - Make it possible to use the SPCR table on x86 and to replace the
   original IORT table with a new one from initrd (Prarit Bhargava,
   Shunyong Yang).

 - Add battery-related quirks for Asus UX360UA and UX410UAK and add
   quirks for table parsing on Dell XPS 9570 and Precision M5530
   (Kai Heng Feng).

 - Address static checker warnings in the CPPC code (Gustavo Silva).

 - Avoid printing a raw pointer to the kernel log in the smart
   battery driver (Greg Kroah-Hartman).

Thanks!


---------------

Anuj Mittal (1):
      ACPICA: Linux: add support for X32 ABI compilation

Bob Moore (2):
      ACPICA: All acpica: Update copyrights to 2018
      ACPICA: Update version to 20180105

Chen Yu (1):
      ACPI: processor_perflib: Do not send _PPC change notification if not ready

Greg Kroah-Hartman (1):
      ACPI: sbshc: remove raw pointer from printk() message

Gustavo A. R. Silva (2):
      ACPI / video: Use true for boolean value
      ACPI / CPPC: Use 64-bit arithmetic instead of 32-bit

Hans de Goede (4):
      ACPI: export acpi_bus_get_status_handle()
      PCI: acpiphp_ibm: prepare for acpi_get_object_info() no longer
returning status
      ACPI / bus: Do not call _STA on battery devices with unmet dependencies
      ACPI / scan: Use acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs

Jung-uk Kim (3):
      ACPICA: Avoid NULL pointer arithmetic
      ACPICA: Prefer ACPI_TO_POINTER() over ACPI_ADD_PTR()
      ACPICA: Add a missing pair of parentheses

Kai Heng Feng (2):
      ACPI / battery: Add quirk for Asus UX360UA and UX410UAK
      ACPI / bus: Parse tables as term_list for Dell XPS 9570 and
Precision M5530

Prarit Bhargava (1):
      ACPI: SPCR: Make SPCR available to x86

Shunyong Yang (1):
      ACPI / tables: Add IORT to injectable table list

Yazen Ghannam (1):
      ACPI / processor: Set default C1 idle state description

---------------

 Documentation/admin-guide/kernel-parameters.txt    |  9 +++--
 arch/arm64/kernel/acpi.c                           |  4 +-
 arch/x86/kernel/acpi/boot.c                        |  3 ++
 drivers/acpi/Kconfig                               |  7 +++-
 drivers/acpi/acpi_video.c                          |  2 +-
 drivers/acpi/acpica/acapps.h                       |  4 +-
 drivers/acpi/acpica/accommon.h                     |  2 +-
 drivers/acpi/acpica/acconvert.h                    |  2 +-
 drivers/acpi/acpica/acdebug.h                      |  2 +-
 drivers/acpi/acpica/acdispat.h                     |  2 +-
 drivers/acpi/acpica/acevents.h                     |  2 +-
 drivers/acpi/acpica/acglobal.h                     |  2 +-
 drivers/acpi/acpica/achware.h                      |  2 +-
 drivers/acpi/acpica/acinterp.h                     |  2 +-
 drivers/acpi/acpica/aclocal.h                      |  2 +-
 drivers/acpi/acpica/acmacros.h                     |  2 +-
 drivers/acpi/acpica/acnamesp.h                     |  2 +-
 drivers/acpi/acpica/acobject.h                     |  2 +-
 drivers/acpi/acpica/acopcode.h                     |  2 +-
 drivers/acpi/acpica/acparser.h                     |  2 +-
 drivers/acpi/acpica/acpredef.h                     |  2 +-
 drivers/acpi/acpica/acresrc.h                      |  2 +-
 drivers/acpi/acpica/acstruct.h                     |  2 +-
 drivers/acpi/acpica/actables.h                     |  2 +-
 drivers/acpi/acpica/acutils.h                      |  2 +-
 drivers/acpi/acpica/amlcode.h                      |  2 +-
 drivers/acpi/acpica/amlresrc.h                     |  2 +-
 drivers/acpi/acpica/dbcmds.c                       |  2 +-
 drivers/acpi/acpica/dbconvert.c                    |  2 +-
 drivers/acpi/acpica/dbdisply.c                     |  2 +-
 drivers/acpi/acpica/dbexec.c                       |  2 +-
 drivers/acpi/acpica/dbfileio.c                     |  2 +-
 drivers/acpi/acpica/dbhistry.c                     |  2 +-
 drivers/acpi/acpica/dbinput.c                      |  2 +-
 drivers/acpi/acpica/dbmethod.c                     |  2 +-
 drivers/acpi/acpica/dbnames.c                      |  2 +-
 drivers/acpi/acpica/dbobject.c                     |  2 +-
 drivers/acpi/acpica/dbstats.c                      |  2 +-
 drivers/acpi/acpica/dbtest.c                       |  2 +-
 drivers/acpi/acpica/dbutils.c                      |  2 +-
 drivers/acpi/acpica/dbxface.c                      |  2 +-
 drivers/acpi/acpica/dsargs.c                       |  2 +-
 drivers/acpi/acpica/dscontrol.c                    |  2 +-
 drivers/acpi/acpica/dsdebug.c                      |  2 +-
 drivers/acpi/acpica/dsfield.c                      |  2 +-
 drivers/acpi/acpica/dsinit.c                       |  2 +-
 drivers/acpi/acpica/dsmethod.c                     |  2 +-
 drivers/acpi/acpica/dsmthdat.c                     |  2 +-
 drivers/acpi/acpica/dsobject.c                     |  2 +-
 drivers/acpi/acpica/dsopcode.c                     |  2 +-
 drivers/acpi/acpica/dspkginit.c                    |  2 +-
 drivers/acpi/acpica/dsutils.c                      |  2 +-
 drivers/acpi/acpica/dswexec.c                      |  2 +-
 drivers/acpi/acpica/dswload.c                      |  2 +-
 drivers/acpi/acpica/dswload2.c                     |  2 +-
 drivers/acpi/acpica/dswscope.c                     |  2 +-
 drivers/acpi/acpica/dswstate.c                     |  2 +-
 drivers/acpi/acpica/evevent.c                      |  2 +-
 drivers/acpi/acpica/evglock.c                      |  2 +-
 drivers/acpi/acpica/evgpe.c                        |  2 +-
 drivers/acpi/acpica/evgpeblk.c                     |  2 +-
 drivers/acpi/acpica/evgpeinit.c                    |  2 +-
 drivers/acpi/acpica/evgpeutil.c                    |  2 +-
 drivers/acpi/acpica/evhandler.c                    |  2 +-
 drivers/acpi/acpica/evmisc.c                       |  2 +-
 drivers/acpi/acpica/evregion.c                     |  2 +-
 drivers/acpi/acpica/evrgnini.c                     |  2 +-
 drivers/acpi/acpica/evsci.c                        |  2 +-
 drivers/acpi/acpica/evxface.c                      |  2 +-
 drivers/acpi/acpica/evxfevnt.c                     |  2 +-
 drivers/acpi/acpica/evxfgpe.c                      |  2 +-
 drivers/acpi/acpica/evxfregn.c                     |  2 +-
 drivers/acpi/acpica/exconcat.c                     |  2 +-
 drivers/acpi/acpica/exconfig.c                     |  2 +-
 drivers/acpi/acpica/exconvrt.c                     |  2 +-
 drivers/acpi/acpica/excreate.c                     |  2 +-
 drivers/acpi/acpica/exdebug.c                      |  2 +-
 drivers/acpi/acpica/exdump.c                       |  2 +-
 drivers/acpi/acpica/exfield.c                      |  2 +-
 drivers/acpi/acpica/exfldio.c                      |  2 +-
 drivers/acpi/acpica/exmisc.c                       |  2 +-
 drivers/acpi/acpica/exmutex.c                      |  2 +-
 drivers/acpi/acpica/exnames.c                      |  2 +-
 drivers/acpi/acpica/exoparg1.c                     |  2 +-
 drivers/acpi/acpica/exoparg2.c                     |  2 +-
 drivers/acpi/acpica/exoparg3.c                     |  2 +-
 drivers/acpi/acpica/exoparg6.c                     |  2 +-
 drivers/acpi/acpica/exprep.c                       |  2 +-
 drivers/acpi/acpica/exregion.c                     |  2 +-
 drivers/acpi/acpica/exresnte.c                     |  2 +-
 drivers/acpi/acpica/exresolv.c                     |  2 +-
 drivers/acpi/acpica/exresop.c                      |  2 +-
 drivers/acpi/acpica/exstore.c                      |  2 +-
 drivers/acpi/acpica/exstoren.c                     |  2 +-
 drivers/acpi/acpica/exstorob.c                     |  2 +-
 drivers/acpi/acpica/exsystem.c                     |  2 +-
 drivers/acpi/acpica/extrace.c                      |  2 +-
 drivers/acpi/acpica/exutils.c                      |  2 +-
 drivers/acpi/acpica/hwacpi.c                       |  2 +-
 drivers/acpi/acpica/hwesleep.c                     |  2 +-
 drivers/acpi/acpica/hwgpe.c                        |  2 +-
 drivers/acpi/acpica/hwpci.c                        |  2 +-
 drivers/acpi/acpica/hwregs.c                       |  2 +-
 drivers/acpi/acpica/hwsleep.c                      |  2 +-
 drivers/acpi/acpica/hwtimer.c                      |  2 +-
 drivers/acpi/acpica/hwvalid.c                      |  2 +-
 drivers/acpi/acpica/hwxface.c                      |  2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |  2 +-
 drivers/acpi/acpica/nsaccess.c                     |  2 +-
 drivers/acpi/acpica/nsalloc.c                      |  2 +-
 drivers/acpi/acpica/nsarguments.c                  |  2 +-
 drivers/acpi/acpica/nsconvert.c                    |  2 +-
 drivers/acpi/acpica/nsdump.c                       |  2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |  2 +-
 drivers/acpi/acpica/nseval.c                       |  2 +-
 drivers/acpi/acpica/nsinit.c                       |  2 +-
 drivers/acpi/acpica/nsload.c                       |  2 +-
 drivers/acpi/acpica/nsnames.c                      |  2 +-
 drivers/acpi/acpica/nsobject.c                     |  2 +-
 drivers/acpi/acpica/nsparse.c                      |  2 +-
 drivers/acpi/acpica/nspredef.c                     |  2 +-
 drivers/acpi/acpica/nsprepkg.c                     |  2 +-
 drivers/acpi/acpica/nsrepair.c                     |  2 +-
 drivers/acpi/acpica/nsrepair2.c                    |  2 +-
 drivers/acpi/acpica/nssearch.c                     |  2 +-
 drivers/acpi/acpica/nsutils.c                      |  2 +-
 drivers/acpi/acpica/nswalk.c                       |  2 +-
 drivers/acpi/acpica/nsxfeval.c                     |  2 +-
 drivers/acpi/acpica/nsxfname.c                     |  2 +-
 drivers/acpi/acpica/nsxfobj.c                      |  2 +-
 drivers/acpi/acpica/psargs.c                       |  2 +-
 drivers/acpi/acpica/psloop.c                       |  2 +-
 drivers/acpi/acpica/psobject.c                     |  2 +-
 drivers/acpi/acpica/psopcode.c                     |  2 +-
 drivers/acpi/acpica/psopinfo.c                     |  2 +-
 drivers/acpi/acpica/psparse.c                      |  2 +-
 drivers/acpi/acpica/psscope.c                      |  2 +-
 drivers/acpi/acpica/pstree.c                       |  2 +-
 drivers/acpi/acpica/psutils.c                      |  2 +-
 drivers/acpi/acpica/pswalk.c                       |  2 +-
 drivers/acpi/acpica/psxface.c                      |  2 +-
 drivers/acpi/acpica/rsaddr.c                       |  2 +-
 drivers/acpi/acpica/rscalc.c                       |  2 +-
 drivers/acpi/acpica/rscreate.c                     |  2 +-
 drivers/acpi/acpica/rsdump.c                       |  2 +-
 drivers/acpi/acpica/rsdumpinfo.c                   |  2 +-
 drivers/acpi/acpica/rsinfo.c                       |  2 +-
 drivers/acpi/acpica/rsio.c                         |  2 +-
 drivers/acpi/acpica/rsirq.c                        |  2 +-
 drivers/acpi/acpica/rslist.c                       |  2 +-
 drivers/acpi/acpica/rsmemory.c                     |  2 +-
 drivers/acpi/acpica/rsmisc.c                       |  2 +-
 drivers/acpi/acpica/rsserial.c                     |  2 +-
 drivers/acpi/acpica/rsutils.c                      |  2 +-
 drivers/acpi/acpica/rsxface.c                      |  2 +-
 drivers/acpi/acpica/tbdata.c                       |  2 +-
 drivers/acpi/acpica/tbfadt.c                       |  2 +-
 drivers/acpi/acpica/tbfind.c                       |  2 +-
 drivers/acpi/acpica/tbinstal.c                     |  2 +-
 drivers/acpi/acpica/tbprint.c                      |  2 +-
 drivers/acpi/acpica/tbutils.c                      |  2 +-
 drivers/acpi/acpica/tbxface.c                      |  2 +-
 drivers/acpi/acpica/tbxfload.c                     |  2 +-
 drivers/acpi/acpica/tbxfroot.c                     |  2 +-
 drivers/acpi/acpica/utaddress.c                    |  2 +-
 drivers/acpi/acpica/utalloc.c                      |  2 +-
 drivers/acpi/acpica/utascii.c                      |  2 +-
 drivers/acpi/acpica/utbuffer.c                     |  2 +-
 drivers/acpi/acpica/utcache.c                      |  2 +-
 drivers/acpi/acpica/utcopy.c                       |  2 +-
 drivers/acpi/acpica/utdebug.c                      |  2 +-
 drivers/acpi/acpica/utdecode.c                     |  2 +-
 drivers/acpi/acpica/utdelete.c                     |  2 +-
 drivers/acpi/acpica/uterror.c                      |  2 +-
 drivers/acpi/acpica/uteval.c                       |  2 +-
 drivers/acpi/acpica/utexcep.c                      |  2 +-
 drivers/acpi/acpica/utglobal.c                     |  2 +-
 drivers/acpi/acpica/uthex.c                        |  2 +-
 drivers/acpi/acpica/utids.c                        |  2 +-
 drivers/acpi/acpica/utinit.c                       |  2 +-
 drivers/acpi/acpica/utlock.c                       |  2 +-
 drivers/acpi/acpica/utmath.c                       |  2 +-
 drivers/acpi/acpica/utmisc.c                       |  2 +-
 drivers/acpi/acpica/utmutex.c                      |  2 +-
 drivers/acpi/acpica/utnonansi.c                    |  2 +-
 drivers/acpi/acpica/utobject.c                     |  2 +-
 drivers/acpi/acpica/utosi.c                        |  2 +-
 drivers/acpi/acpica/utownerid.c                    |  2 +-
 drivers/acpi/acpica/utpredef.c                     |  2 +-
 drivers/acpi/acpica/utprint.c                      |  2 +-
 drivers/acpi/acpica/utresdecode.c                  |  2 +-
 drivers/acpi/acpica/utresrc.c                      |  2 +-
 drivers/acpi/acpica/utstate.c                      |  2 +-
 drivers/acpi/acpica/utstring.c                     |  2 +-
 drivers/acpi/acpica/utstrsuppt.c                   |  2 +-
 drivers/acpi/acpica/utstrtoul64.c                  |  2 +-
 drivers/acpi/acpica/uttrack.c                      |  2 +-
 drivers/acpi/acpica/utuuid.c                       |  2 +-
 drivers/acpi/acpica/utxface.c                      |  2 +-
 drivers/acpi/acpica/utxferror.c                    |  2 +-
 drivers/acpi/acpica/utxfinit.c                     |  2 +-
 drivers/acpi/acpica/utxfmutex.c                    |  2 +-
 drivers/acpi/battery.c                             | 16 ++++++++
 drivers/acpi/bus.c                                 | 45 ++++++++++++++++++----
 drivers/acpi/cppc_acpi.c                           |  2 +-
 drivers/acpi/processor_idle.c                      |  3 ++
 drivers/acpi/processor_perflib.c                   |  2 +-
 drivers/acpi/sbshc.c                               |  4 +-
 drivers/acpi/scan.c                                | 20 ++++++++--
 drivers/acpi/spcr.c                                | 29 +++++++-------
 drivers/acpi/tables.c                              |  3 +-
 drivers/pci/hotplug/acpiphp_ibm.c                  |  5 ++-
 drivers/tty/serial/earlycon.c                      | 15 +++-----
 include/acpi/acbuffer.h                            |  2 +-
 include/acpi/acconfig.h                            |  2 +-
 include/acpi/acexcep.h                             |  2 +-
 include/acpi/acnames.h                             |  2 +-
 include/acpi/acoutput.h                            |  2 +-
 include/acpi/acpi.h                                |  2 +-
 include/acpi/acpiosxf.h                            |  2 +-
 include/acpi/acpixf.h                              |  4 +-
 include/acpi/acrestyp.h                            |  2 +-
 include/acpi/actbl.h                               |  2 +-
 include/acpi/actbl1.h                              |  2 +-
 include/acpi/actbl2.h                              |  2 +-
 include/acpi/actbl3.h                              |  2 +-
 include/acpi/actypes.h                             | 12 +++---
 include/acpi/acuuid.h                              |  2 +-
 include/acpi/platform/acenv.h                      |  2 +-
 include/acpi/platform/acenvex.h                    |  2 +-
 include/acpi/platform/acgcc.h                      |  2 +-
 include/acpi/platform/acgccex.h                    |  2 +-
 include/acpi/platform/acintel.h                    |  2 +-
 include/acpi/platform/aclinux.h                    |  4 +-
 include/acpi/platform/aclinuxex.h                  |  2 +-
 include/linux/acpi.h                               |  7 +++-
 include/linux/serial_core.h                        |  4 +-
 tools/power/acpi/common/cmfsize.c                  |  2 +-
 tools/power/acpi/common/getopt.c                   |  2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |  2 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |  2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |  2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |  2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |  2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |  2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |  2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |  2 +-
 247 files changed, 366 insertions(+), 288 deletions(-)
