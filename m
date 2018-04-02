Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754322AbeDBKJJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:09:09 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46071 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754211AbeDBKJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:09:08 -0400
X-Google-Smtp-Source: AIpwx4+/CPjwI566gJUkMN1Pc+Xe4Rap0Detr0PnBvgCXm3Om/8uSPStAjbKRV2uRcPYCeDQR5ZNgQ==
Date: Mon, 2 Apr 2018 12:09:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/platform changes for v4.17
Message-ID: <20180402100904.m7khdm65j52ql2er@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-platform-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

   # HEAD: 47a9973d3ed8994589c845c8b1a293a475a549a9 x86/PCI: Fix a potential regression when using dmi_get_bios_year()

The main changes in this cycle were:

 - Add "Jailhouse" hypervisor support     (Jan Kiszka)

 - Update DeviceTree support              (Ivan Gorinov)

 - Improve DMI date handling              (Andy Shevchenko)


  out-of-topic modifications in x86-platform-for-linus:
  -------------------------------------------------------
  MAINTAINERS                        # e21c963c0fe3: MAINTAINERS: Add entry for J
  drivers/acpi/sleep.c               # 9c0a30b67bd9: ACPI/sleep: Simplify code by
  drivers/firmware/dmi_scan.c        # 3af345258617: firmware/dmi_scan: Uninline 
  drivers/pci/pci.c                  # ac95090a0440: pci: Simplify code by using 
  drivers/pci/probe.c                # 690f4304104f: PCI: Scan all functions when
  include/linux/dmi.h                # 3af345258617: firmware/dmi_scan: Uninline 
                                   # 492a1abd61e4: dmi: Introduce the dmi_get_b
  include/linux/hypervisor.h         # 63338a38db95: jailhouse: Provide detection

 Thanks,

	Ingo

------------------>
Andy Shevchenko (8):
      x86/platform/atom: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      x86/platform/quark: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      dmi: Introduce the dmi_get_bios_year() helper function
      x86/pci: Simplify code by using the new dmi_get_bios_year() helper
      ACPI/sleep: Simplify code by using the new dmi_get_bios_year() helper
      pci: Simplify code by using the new dmi_get_bios_year() helper
      firmware/dmi_scan: Uninline dmi_get_bios_year() helper
      x86/PCI: Fix a potential regression when using dmi_get_bios_year()

Ivan Gorinov (4):
      x86/devicetree: Initialize device tree before using it
      x86/devicetree: Fix device IRQ settings in DT
      of/Documentation: Specify local APIC ID in "reg"
      x86/devicetree: Use CPU description from Device Tree

Jan Kiszka (6):
      jailhouse: Provide detection for non-x86 systems
      PCI: Scan all functions when running over Jailhouse
      x86: Align x86_64 PCI_MMCONFIG with 32-bit variant
      x86: Consolidate PCI_MMCONFIG configs
      x86/jailhouse: Allow to use PCI_MMCONFIG without ACPI
      MAINTAINERS: Add entry for Jailhouse

Otavio Pontes (1):
      x86/jailhouse: Enable PCI mmconfig access in inmates


 Documentation/devicetree/bindings/jailhouse.txt  |  8 +++
 Documentation/devicetree/bindings/x86/ce4100.txt | 37 +++++++++----
 MAINTAINERS                                      |  7 +++
 arch/x86/Kconfig                                 | 12 +++--
 arch/x86/include/asm/jailhouse_para.h            |  2 +-
 arch/x86/include/asm/pci_x86.h                   |  2 +
 arch/x86/kernel/Makefile                         |  2 +-
 arch/x86/kernel/cpu/amd.c                        |  2 +-
 arch/x86/kernel/devicetree.c                     | 66 +++++++++++++++++-------
 arch/x86/kernel/jailhouse.c                      |  8 +++
 arch/x86/pci/acpi.c                              |  8 ++-
 arch/x86/pci/direct.c                            |  5 +-
 arch/x86/pci/legacy.c                            |  4 +-
 arch/x86/pci/mmconfig-shared.c                   | 13 ++---
 arch/x86/platform/atom/punit_atom_debug.c        | 17 ++----
 arch/x86/platform/intel-quark/imr.c              | 24 ++-------
 drivers/acpi/sleep.c                             |  4 +-
 drivers/firmware/dmi_scan.c                      | 20 +++++++
 drivers/pci/pci.c                                |  6 +--
 drivers/pci/probe.c                              | 22 ++++++--
 include/linux/dmi.h                              |  2 +
 include/linux/hypervisor.h                       | 17 +++++-
 22 files changed, 185 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/jailhouse.txt
