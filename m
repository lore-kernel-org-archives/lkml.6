Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F05C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27B2218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999317;
	bh=+NrXu5cp9f1dYSaDs4/r05Z50RpfP1x9NOVmaVsTN5A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FECGit8EMd+aRBi8OhEEDhKxI5js3oOwdkcQ5P7WVx0MWRkOt+J9PPyG0eMUDojoT
	 TatNi1aH4OZ5qahUWreveZIspiAk3caWneHbKw+TQ1fD17zw8ml0SHnY4r6QEBtnqX
	 4E1LK6xWrxzlJMWJGtwV0+t3Mvf07kVCSSXFWx/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeL1MPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731789AbeL1MPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7671220866;
        Fri, 28 Dec 2018 12:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999313;
        bh=+NrXu5cp9f1dYSaDs4/r05Z50RpfP1x9NOVmaVsTN5A=;
        h=From:To:Cc:Subject:Date:From;
        b=cib5EsaKsIlLfdMNvhnFuid6MAvlIkjVRX7FwOxtLUe4uu9QlRO+HcP+O59IzYQJD
         0Y170tZRqhOsR85y/NfIEx7mhMssquYamaY1Nru83ecmr8zorrEKzSoXiBrMBQeyfQ
         Zx2QU1keVFyCS2E34pknCTX28JepyqRTL5VcczNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/46] 4.19.13-stable review
Date:   Fri, 28 Dec 2018 12:51:54 +0100
Message-Id: <20181228113124.971620049@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.13-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.13-rc1
X-KernelTest-Deadline: 2018-12-30T11:31+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.13 release.
There are 46 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Dec 30 11:30:49 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.13-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.13-rc1

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/ioctl: Fix Spectre v1 vulnerabilities

Ivan Delalande <colona@arista.com>
    proc/sysctl: don't return ENOMEM on lookup when a table is unregistering

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    Input: elantech - disable elan-i2c for P52 and P72

Roman Gushchin <guro@fb.com>
    mm: don't miss the last page because of round-off error

Oscar Salvador <osalvador@suse.de>
    mm, page_alloc: fix has_unmovable_pages for HugePages

Peter Xu <peterx@redhat.com>
    mm: thp: fix flags for pmd migration when split

Mikhail Zaslonko <zaslonko@linux.ibm.com>
    mm, memory_hotplug: initialize struct pages for the full memory section

Jacopo Mondi <jacopo+renesas@jmondi.org>
    media: ov5640: Fix set format regression

Ihab Zhaika <ihab.zhaika@intel.com>
    iwlwifi: add new cards for 9560, 9462, 9461 and killer series

Brian Norris <briannorris@chromium.org>
    Revert "mwifiex: restructure rx_reorder_tbl_lock usage"

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: mvm: don't send GEO_TX_POWER_LIMIT to old firmwares

Larry Finger <Larry.Finger@lwfinger.net>
    rtlwifi: Fix leak of skb when processing C2H_BT_INFO

Mathias Krause <minipli@googlemail.com>
    xfrm_user: fix freeing of xfrm states on acquire

Martin Schwidefsky <schwidefsky@de.ibm.com>
    mm: introduce mm_[p4d|pud|pmd]_folded

Martin Schwidefsky <schwidefsky@de.ibm.com>
    mm: make the __PAGETABLE_PxD_FOLDED defines non-empty

Martin Schwidefsky <schwidefsky@de.ibm.com>
    mm: add mm_pxd_folded checks to pgtable_bytes accounting functions

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
    panic: avoid deadlocks in re-entrant console drivers

Reinette Chatre <reinette.chatre@intel.com>
    x86/intel_rdt: Ensure a CPU remains online for the region's pseudo-locking sequence

Alistair Strachan <astrachan@google.com>
    x86/vdso: Pass --eh-frame-hdr to the linker

Dan Williams <dan.j.williams@intel.com>
    x86/mm: Fix decoy address handling vs 32-bit builds

Colin Ian King <colin.king@canonical.com>
    x86/mtrr: Don't copy uninitialized gentry fields back to userspace

Thomas Gleixner <tglx@linutronix.de>
    futex: Cure exit race

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels

Cfir Cohen <cfir@google.com>
    KVM: Fix UAF in nested posted interrupt processing

Eduardo Habkost <ehabkost@redhat.com>
    kvm: x86: Add AMD's EX_CFG to the list of ignored MSRs

Wanpeng Li <wanpengli@tencent.com>
    KVM: X86: Fix NULL deref in vcpu_scan_ioapic

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Fix division by zero bug

Hans de Goede <hdegoede@redhat.com>
    gpiolib-acpi: Only defer request_irq for GpioInt ACPI event handlers

Christophe Leroy <christophe.leroy@c-s.fr>
    gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Russell King <rmk+kernel@armlinux.org.uk>
    mmc: omap_hsmmc: fix DMA API warning

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: core: Allow BKOPS and CACHE ctrl even if no HPI support

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: core: Reset HPI enabled state during re-init and in case of errors

Jens Axboe <axboe@kernel.dk>
    scsi: sd: use mempool for discard special page

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: t10-pi: Return correct ref tag when queue has no integrity profile

Richard Weinberger <richard@nod.at>
    ubifs: Handle re-linking of inodes correctly while recovery

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Telit LN940 series

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Fibocom NL668 series

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Simcom SIM7500/SIM7600 (MBIM mode)

Tore Anderson <tore@fud.no>
    USB: serial: option: add HP lt4132

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add GosunCn ZTE WeLink ME3630

Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
    USB: xhci: fix 'broken_suspend' placement in struct xchi_hcd

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Don't prevent USB2 bus suspend in state check intended for USB3 only

Hui Peng <benquike@gmail.com>
    USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data

Christian Brauner <christian@brauner.io>
    Revert "vfs: Allow userns root to call mknod on owned filesystems."

Dave Chinner <dchinner@redhat.com>
    iomap: Revert "fs/iomap.c: get/put the page in iomap_page_create/release()"


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/include/asm/pgtable-2level.h              |   2 +-
 arch/m68k/include/asm/pgtable_mm.h                 |   4 +-
 arch/microblaze/include/asm/pgtable.h              |   2 +-
 arch/nds32/include/asm/pgtable.h                   |   2 +-
 arch/parisc/include/asm/pgtable.h                  |   2 +-
 arch/x86/entry/vdso/Makefile                       |   3 +-
 arch/x86/include/asm/msr-index.h                   |   1 +
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c        |   4 +
 arch/x86/kernel/cpu/mtrr/if.c                      |   2 +
 arch/x86/kvm/vmx.c                                 |   2 +
 arch/x86/kvm/x86.c                                 |   4 +-
 arch/x86/mm/pat.c                                  |  13 +-
 drivers/gpio/gpio-max7301.c                        |  12 +-
 drivers/gpio/gpiolib-acpi.c                        | 144 ++++++++++++---------
 drivers/gpu/drm/drm_ioctl.c                        |  10 +-
 drivers/hv/vmbus_drv.c                             |  20 +++
 drivers/input/mouse/elantech.c                     |  18 ++-
 drivers/media/i2c/ov5640.c                         |  17 ++-
 drivers/mmc/core/mmc.c                             |  24 ++--
 drivers/mmc/host/omap_hsmmc.c                      |  12 +-
 drivers/net/usb/hso.c                              |  18 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   9 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  50 +++++++
 drivers/net/wireless/marvell/mwifiex/11n.c         |   5 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |  96 +++++++-------
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c    |   3 -
 drivers/net/wireless/realtek/rtlwifi/base.c        |   1 +
 drivers/scsi/sd.c                                  |  23 +++-
 drivers/usb/host/xhci-hub.c                        |   3 +-
 drivers/usb/host/xhci.h                            |   4 +-
 drivers/usb/serial/option.c                        |  16 ++-
 fs/iomap.c                                         |   7 -
 fs/namei.c                                         |   3 +-
 fs/proc/proc_sysctl.c                              |  13 +-
 fs/ubifs/replay.c                                  |  37 ++++++
 include/asm-generic/4level-fixup.h                 |   2 +-
 include/asm-generic/5level-fixup.h                 |   2 +-
 include/asm-generic/pgtable-nop4d-hack.h           |   2 +-
 include/asm-generic/pgtable-nop4d.h                |   2 +-
 include/asm-generic/pgtable-nopmd.h                |   2 +-
 include/asm-generic/pgtable-nopud.h                |   2 +-
 include/asm-generic/pgtable.h                      |  16 +++
 include/linux/math64.h                             |   3 +
 include/linux/mm.h                                 |   8 ++
 include/linux/t10-pi.h                             |   9 +-
 include/net/xfrm.h                                 |   1 +
 kernel/futex.c                                     |  69 +++++++++-
 kernel/panic.c                                     |   6 +-
 kernel/time/posix-timers.c                         |   5 +-
 mm/huge_memory.c                                   |  20 +--
 mm/page_alloc.c                                    |  19 ++-
 mm/vmscan.c                                        |   6 +-
 net/xfrm/xfrm_state.c                              |   8 +-
 net/xfrm/xfrm_user.c                               |   4 +-
 55 files changed, 556 insertions(+), 220 deletions(-)


