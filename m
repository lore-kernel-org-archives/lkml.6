Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A4720657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 03:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n858hPOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A4720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeKAMIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:08:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKAMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 08:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VMUYie31xPpvuhzKxdrysWBfWfJxqBcXDaI/Rlk1Gm4=; b=n858hPOkRz5Nl+fmPxxGq8JuEn
        FqGzOOe3zkKCEo8ZPF8r1V2VJMeJRea/NEiHtrvq5nlpK1siVBN8HGurwOAUWfl0MAbxJqWU8yb5m
        RzjwDo2xHcRNxN9J8PZ/UGtAjWuDG+z89STnz4bCHlYvXm7EISvBL6rNHZvg4JKTSj1ERWZ4BxWjJ
        SuvCsB9lUGiCpmroTC1PXA49iEwOS/N/xZ6S3Baa4mIHTqXAtfGVJsboZASRmIa1ash+XnQDCtoIH
        wrW8ix0fyBp7Nh6tFV2DgHa207Z9CZ31cfPtC808T3JJ0ITxkF63rmjcC/GbXFjCGqivLiV7jBA9A
        cZmhSacA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gI3K7-0005j4-LB; Thu, 01 Nov 2018 03:07:07 +0000
Date:   Wed, 31 Oct 2018 20:07:06 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.20-1
Message-ID: <20181101030706.GA9309@fedora.eng.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This tag has a few merge conflicts with some x86/cpu id changes. Stephen
Rothwell's merge in next/master is correct, and I have provided an
example here as well:

  git://git.infradead.org/linux-platform-drivers-x86.git pdx86-v4.20-1-merge

Thanks,

Darren Hart
VMware Open Source Technology Center

The following changes since commit ff0e9f26288d2daee4950f42b37a3d3d30d36ec1:

  platform/x86: alienware-wmi: Correct a memory leak (2018-09-10 13:45:43 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.20-1

for you to fetch changes up to 3b692c55e58d06ba9b17c66784cab5a95ba5be9b:

  HID: asus: only support backlight when it's not driven by WMI (2018-10-31 16:11:40 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v4.20-1

Move the Dell dcdbas and dell_rbu drivers into platform/drivers/x86 as
they are closely coupled with other drivers in this location.

Improve _init* usage for acerhdf and fix some usage issues with messages
and module parameters.

Simplify asus-wmi by calling ACPI/WMI methods directly, eliminating
workqueue overhead, eliminate double reporting of keyboard backlight.

Fix wake from USB failure on Bay Trail devices (intel_int0002_vgpio).

Notify intel_telemetry users when IPC1 device is not enabled.

Update various drivers with new laptop model IDs.

Update several intel drivers to use SPDX identifers and order headers
alphabetically.

The following is an automated git shortlog grouped by driver:

Add Intel AtomISP2 dummy / power-management driver:
 - Add Intel AtomISP2 dummy / power-management driver

lg-laptop:
 - Add LG Gram laptop special features driver

HID:
 -  asus: only support backlight when it's not driven by WMI

MAINTAINERS:
 -  intel_telemetry: Update maintainers info
 -  intel_pmc_core: Update MAINTAINERS
 -  Update maintainer for dcdbas and dell_rbu
 -  Use my infradead account exclusively for PDx86 work

acerhdf:
 -  restructure to allow large BIOS table be __initconst
 -  mark appropriate content with __init prefix
 -  Add BIOS entry for Gateway LT31 v1.3307
 -  Remove cut-and-paste trap from instructions
 -  Enable ability to list supported systems
 -  clarify modinfo messages for BIOS override

asus-wmi:
 -  export function for evaluating WMI methods
 -  Only notify kbd LED hw_change by fn-key pressed
 -  Simplify the keyboard brightness updating process

firmware:
 -  dcdbas: include linux/io.h
 -  dcdbas: Move dcdbas to drivers/platform/x86
 -  dell_rbu: Move dell_rbu to drivers/platform/x86
 -  dcdbas: Add support for WSMT ACPI table
 -  dell_rbu: Make payload memory uncachable

ideapad-laptop:
 -  Add Y530-15ICH to no_hw_rfkill
 -  Use __func__ instead of read_ec_cmd in pr_err

intel-hid:
 -  Convert to use SPDX identifier

intel-ips:
 -  Convert to use SPDX identifier

intel-rst:
 -  Convert to use SPDX identifier
 -  Sort headers alphabetically

intel-smartconnect:
 -  Convert to use SPDX identifier
 -  Sort headers alphabetically

intel-wmi-thunderbolt:
 -  Add dynamic debugging
 -  Convert to use SPDX identifier

intel_bxtwc_tmu:
 -  Convert to use SPDX identifier

intel_cht_int33fe:
 -  Convert to use SPDX identifier

intel_chtdc_ti_pwrbtn:
 -  Add SPDX identifier

intel_int0002_vgpio:
 -  Convert to use SPDX identifier
 -  Implement irq_set_wake
 -  Enable the driver on Bay Trail platforms

intel_menlow:
 -  Convert to use SPDX identifier
 -  Sort headers alphabetically

intel_mid_powerbtn:
 -  Convert to use SPDX identifier
 -  Remove unnecessary init.h inclusion
 -  Get rid of custom ICPU() macro

intel_mid_thermal:
 -  Convert to use SPDX identifier
 -  Sort headers alphabetically

intel_oaktrail:
 -  Convert to use SPDX identifier
 -  Sort headers alphabetically

intel_pmc:
 -  Convert to use SPDX identifier
 -  Sort headers alphabetically

intel_punit_ipc:
 -  Convert to use SPDX identifier
 -  Sort headers alphabetically

intel_scu_ipc:
 -  Convert to use SPDX identifier
 -  Sort headers alphabetically

intel_telemetry:
 -  Get rid of custom macro
 -  report debugfs failure
 -  Convert to use SPDX identifier

intel_turbo_max_3:
 -  Convert to use SPDX identifier
 -  Sort headers alphabetically

mlx-platform:
 -  Properly use mlxplat_mlxcpld_msn201x_items

touchscreen_dmi:
 -  Add min-x and min-y settings for various models
 -  Add info for the Onda V80 Plus v3 tablet
 -  Add info for the Trekstor Primetab T13B tablet
 -  Add info for the Trekstor Primebook C11 convertible

tracing:
 -  Trivia spelling fix containerof() -> container_of()

wmi:
 -  declare device_type structure as constant

----------------------------------------------------------------
Andy Shevchenko (32):
      tracing: Trivia spelling fix containerof() -> container_of()
      MAINTAINERS: Use my infradead account exclusively for PDx86 work
      platform/x86: intel_mid_powerbtn: Get rid of custom ICPU() macro
      platform/x86: intel_bxtwc_tmu: Convert to use SPDX identifier
      platform/x86: intel_cht_int33fe: Convert to use SPDX identifier
      platform/x86: intel_chtdc_ti_pwrbtn: Add SPDX identifier
      platform/x86: intel-hid: Convert to use SPDX identifier
      platform/x86: intel_int0002_vgpio: Convert to use SPDX identifier
      platform/x86: intel-ips: Convert to use SPDX identifier
      platform/x86: intel_menlow: Sort headers alphabetically
      platform/x86: intel_menlow: Convert to use SPDX identifier
      platform/x86: intel_mid_powerbtn: Remove unnecessary init.h inclusion
      platform/x86: intel_mid_powerbtn: Convert to use SPDX identifier
      platform/x86: intel_mid_thermal: Sort headers alphabetically
      platform/x86: intel_mid_thermal: Convert to use SPDX identifier
      platform/x86: intel_oaktrail: Sort headers alphabetically
      platform/x86: intel_oaktrail: Convert to use SPDX identifier
      platform/x86: intel_pmc: Sort headers alphabetically
      platform/x86: intel_pmc: Convert to use SPDX identifier
      platform/x86: intel_punit_ipc: Sort headers alphabetically
      platform/x86: intel_punit_ipc: Convert to use SPDX identifier
      platform/x86: intel-rst: Sort headers alphabetically
      platform/x86: intel-rst: Convert to use SPDX identifier
      platform/x86: intel_scu_ipc: Sort headers alphabetically
      platform/x86: intel_scu_ipc: Convert to use SPDX identifier
      platform/x86: intel-smartconnect: Sort headers alphabetically
      platform/x86: intel-smartconnect: Convert to use SPDX identifier
      platform/x86: intel_telemetry: Convert to use SPDX identifier
      platform/x86: intel_turbo_max_3: Sort headers alphabetically
      platform/x86: intel_turbo_max_3: Convert to use SPDX identifier
      platform/x86: intel-wmi-thunderbolt: Convert to use SPDX identifier
      platform/x86: intel_telemetry: Get rid of custom macro

Arnd Bergmann (1):
      firmware: dcdbas: include linux/io.h

Bhumika Goyal (1):
      platform/x86: wmi: declare device_type structure as constant

Daniel Drake (2):
      platform/x86: asus-wmi: export function for evaluating WMI methods
      HID: asus: only support backlight when it's not driven by WMI

David E. Box (1):
      MAINTAINERS: intel_telemetry: Update maintainers info

Hans de Goede (6):
      platform/x86: intel_int0002_vgpio: Enable the driver on Bay Trail platforms
      platform/x86: intel_int0002_vgpio: Implement irq_set_wake
      platform/x86: touchscreen_dmi: Add info for the Trekstor Primebook C11 convertible
      platform/x86: touchscreen_dmi: Add info for the Onda V80 Plus v3 tablet
      platform/x86: touchscreen_dmi: Add min-x and min-y settings for various models
      platform/x86: Add Intel AtomISP2 dummy / power-management driver

Jian-Hong Pan (2):
      platform/x86: asus-wmi: Simplify the keyboard brightness updating process
      platform/x86: asus-wmi: Only notify kbd LED hw_change by fn-key pressed

Marian Cepok (1):
      platform/x86: touchscreen_dmi: Add info for the Trekstor Primetab T13B tablet

Mario Limonciello (1):
      platform/x86: intel-wmi-thunderbolt: Add dynamic debugging

Matan Ziv-Av (1):
      platform/x86: Add LG Gram laptop special features driver

Misha Komarovskiy (1):
      platform/x86: ideapad: Add Y530-15ICH to no_hw_rfkill

Nathan Chancellor (1):
      platform/x86: mlx-platform: Properly use mlxplat_mlxcpld_msn201x_items

Paul Gortmaker (6):
      platform/x86: acerhdf: clarify modinfo messages for BIOS override
      platform/x86: acerhdf: Enable ability to list supported systems
      platform/x86: acerhdf: Remove cut-and-paste trap from instructions
      platform/x86: acerhdf: Add BIOS entry for Gateway LT31 v1.3307
      platform/x86: acerhdf: mark appropriate content with __init prefix
      platform/x86: acerhdf: restructure to allow large BIOS table be __initconst

Rajneesh Bhardwaj (2):
      MAINTAINERS: intel_pmc_core: Update MAINTAINERS
      platform/x86: intel_telemetry: report debugfs failure

Stuart Hayes (5):
      firmware: dell_rbu: Make payload memory uncachable
      firmware: dcdbas: Add support for WSMT ACPI table
      firmware: dell_rbu: Move dell_rbu to drivers/platform/x86
      firmware: dcdbas: Move dcdbas to drivers/platform/x86
      MAINTAINERS: Update maintainer for dcdbas and dell_rbu

Zhang Xianwei (1):
      platform/x86: ideapad-laptop: Use __func__ instead of read_ec_cmd in pr_err

 Documentation/ABI/testing/sysfs-platform-lg-laptop |  35 ++
 Documentation/laptops/lg-laptop.rst                |  81 +++
 MAINTAINERS                                        |  31 +-
 drivers/firmware/Kconfig                           |  28 -
 drivers/firmware/Makefile                          |   2 -
 drivers/hid/Kconfig                                |   1 +
 drivers/hid/hid-asus.c                             |  23 +-
 drivers/platform/x86/Kconfig                       |  59 +-
 drivers/platform/x86/Makefile                      |   4 +
 drivers/platform/x86/acerhdf.c                     |  68 +-
 drivers/platform/x86/asus-wmi.c                    | 119 +---
 drivers/{firmware => platform/x86}/dcdbas.c        | 125 +++-
 drivers/{firmware => platform/x86}/dcdbas.h        |  10 +
 drivers/platform/x86/dell-smbios-smm.c             |   2 +-
 drivers/{firmware => platform/x86}/dell_rbu.c      |   8 +
 drivers/platform/x86/ideapad-laptop.c              |   9 +-
 drivers/platform/x86/intel-hid.c                   |  12 +-
 drivers/platform/x86/intel-rst.c                   |  23 +-
 drivers/platform/x86/intel-smartconnect.c          |  22 +-
 drivers/platform/x86/intel-wmi-thunderbolt.c       |  18 +-
 drivers/platform/x86/intel_atomisp2_pm.c           | 119 ++++
 drivers/platform/x86/intel_bxtwc_tmu.c             |  13 +-
 drivers/platform/x86/intel_cht_int33fe.c           |   7 +-
 drivers/platform/x86/intel_chtdc_ti_pwrbtn.c       |   1 +
 drivers/platform/x86/intel_int0002_vgpio.c         |  29 +-
 drivers/platform/x86/intel_ips.c                   |  15 +-
 drivers/platform/x86/intel_ips.h                   |  13 +-
 drivers/platform/x86/intel_menlow.c                |  28 +-
 drivers/platform/x86/intel_mid_powerbtn.c          |  18 +-
 drivers/platform/x86/intel_mid_thermal.c           |  30 +-
 drivers/platform/x86/intel_oaktrail.c              |  32 +-
 drivers/platform/x86/intel_pmc_core.c              |  11 +-
 drivers/platform/x86/intel_pmc_core.h              |  11 +-
 drivers/platform/x86/intel_pmc_ipc.c               |  35 +-
 drivers/platform/x86/intel_punit_ipc.c             |  12 +-
 drivers/platform/x86/intel_scu_ipc.c               |  16 +-
 drivers/platform/x86/intel_scu_ipcutil.c           |  24 +-
 drivers/platform/x86/intel_telemetry_core.c        |  12 +-
 drivers/platform/x86/intel_telemetry_debugfs.c     |  27 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c      |  12 +-
 drivers/platform/x86/intel_turbo_max_3.c           |  18 +-
 drivers/platform/x86/lg-laptop.c                   | 700 +++++++++++++++++++++
 drivers/platform/x86/mlx-platform.c                |   2 +-
 drivers/platform/x86/touchscreen_dmi.c             | 107 +++-
 drivers/platform/x86/wmi.c                         |   6 +-
 include/linux/platform_data/x86/asus-wmi.h         | 101 +++
 kernel/trace/trace_printk.c                        |   2 +-
 47 files changed, 1587 insertions(+), 494 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-lg-laptop
 create mode 100644 Documentation/laptops/lg-laptop.rst
 rename drivers/{firmware => platform/x86}/dcdbas.c (82%)
 rename drivers/{firmware => platform/x86}/dcdbas.h (93%)
 rename drivers/{firmware => platform/x86}/dell_rbu.c (98%)
 create mode 100644 drivers/platform/x86/intel_atomisp2_pm.c
 create mode 100644 drivers/platform/x86/lg-laptop.c
 create mode 100644 include/linux/platform_data/x86/asus-wmi.h

-- 
Darren Hart
VMware Open Source Technology Center
