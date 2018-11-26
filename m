Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C394C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340732148E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJehHO3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340732148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeKZVyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbeKZVyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:54:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26C7A20817;
        Mon, 26 Nov 2018 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230017;
        bh=V4plzG3hQXnc3ge22gzJbGCmkn2Gm8HeaafacBQ0qFs=;
        h=From:To:Cc:Subject:Date:From;
        b=BJehHO3T/kH/5CcxlCwuPaX8zOvVvnwh1snI0NHo10dE+32Dex3G0VaiAqbEogL9s
         ggx2QIXnFRAMvc0sSl4A+5GdoT5nIFCtBIRB8tJ6gkgPDss34v6vy6ziLJB4MeKM1L
         rDlc2rRwKjTR3P+ba0F1GyyZWtlz85sQYL1Ltj0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/62] 4.14.84-stable review
Date:   Mon, 26 Nov 2018 11:50:41 +0100
Message-Id: <20181126105050.592727680@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.84-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.84-rc1
X-KernelTest-Deadline: 2018-11-28T10:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.84 release.
There are 62 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Nov 28 10:50:20 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.84-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.84-rc1

Ilya Dryomov <idryomov@gmail.com>
    libceph: fall back to sendmsg for slab pages

Eric Biggers <ebiggers@google.com>
    HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges

Hans de Goede <hdegoede@redhat.com>
    ACPI / platform: Add SMB0001 HID to forbidden_id_list

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drivers/misc/sgi-gru: fix Spectre v1 vulnerability

Johan Hovold <johan@kernel.org>
    mtd: rawnand: atmel: fix OF child-node lookup

Mattias Jacobsson <2pi@mok.nu>
    USB: misc: appledisplay: add 20" Apple Cinema Display

Nathan Chancellor <natechancellor@gmail.com>
    misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data

Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
    usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB

Kai-Heng Feng <kai.heng.feng@canonical.com>
    USB: quirks: Add no-lpm quirk for Raydium touchscreens

Maarten Jacobs <maarten256@outlook.com>
    usb: cdc-acm: add entry for Hiro (Conexant) modem

Dan Carpenter <dan.carpenter@oracle.com>
    uio: Fix an Oops on load

Aaro Koskinen <aaro.koskinen@iki.fi>
    MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON USB driver

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: v4l: event: Add subscription to list before calling "add" operation

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/ldt: Unmap PTEs for the slot before freeing LDT pages

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/mm: Move LDT remap out of KASLR region on 5-level paging

Adrian Hunter <adrian.hunter@intel.com>
    perf test code-reading: Fix perf_env setup for PTI entry trampolines

Adrian Hunter <adrian.hunter@intel.com>
    perf machine: Workaround missing maps for x86 PTI entry trampolines

Adrian Hunter <adrian.hunter@intel.com>
    perf machine: Add nr_cpus_avail()

Adrian Hunter <adrian.hunter@intel.com>
    perf tools: Fix kernel_start for PTI on x86

Adrian Hunter <adrian.hunter@intel.com>
    perf machine: Add machine__is() to identify machine arch

Mika Westerberg <mika.westerberg@linux.intel.com>
    ACPI / watchdog: Prefer iTCO_wdt always when WDAT table uses RTC SRAM

YueHaibing <yuehaibing@huawei.com>
    SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer()

Minchan Kim <minchan@kernel.org>
    zram: close udev startup race condition as default groups

Thor Thayer <thor.thayer@linux.intel.com>
    net: stmmac: Fix RX packet size > 8191

Sagiv Ozeri <sagiv.ozeri@cavium.com>
    qed: Fix potential memory corruption

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix blocking/unlimited SPQ entries leak

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix memory/entry leak in qed_init_sp_request()

Jacob Keller <jacob.e.keller@intel.com>
    i40e: restore NETIF_F_GSO_IPXIP[46] to netdev features

Gustavo Romero <gromero@linux.vnet.ibm.com>
    perf tools: Fix undefined symbol scnprintf in libperf-jvmti.so

Valentin Schneider <valentin.schneider@arm.com>
    sched/core: Take the hotplug lock in sched_init_smp()

Vignesh R <vigneshr@ti.com>
    i2c: omap: Enable for ARCH_K3

Thomas Richter <tmricht@linux.ibm.com>
    s390/perf: Change CPUM_CF return code in event init function

Jeremy Linton <jeremy.linton@arm.com>
    lib/raid6: Fix arm64 test build

Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
    clk: fixed-factor: fix of_node_get-put imbalance

Inki Dae <inki.dae@samsung.com>
    Revert "drm/exynos/decon5433: implement frame counter"

Geert Uytterhoeven <geert@linux-m68k.org>
    hwmon: (ibmpowernv) Remove bogus __init annotations

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix HiperSockets sniffer

Taehee Yoo <ap420073@gmail.com>
    netfilter: xt_IDLETIMER: add sysfs filename checking routine

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
    netfilter: ipset: Correct rcu_dereference() call in ip_set_put_comment()

Justin M. Forbes <jforbes@fedoraproject.org>
    s390/mm: Fix ERROR: "__node_distance" undefined!

Eric Westbrook <eric@westbrook.io>
    netfilter: ipset: actually allow allowable CIDR 0 in hash:net,port,net

Stefano Brivio <sbrivio@redhat.com>
    netfilter: ipset: list:set: Decrease refcount synchronously on deletion and replace

Vasily Gorbik <gor@linux.ibm.com>
    s390/vdso: add missing FORCE to build targets

Nathan Chancellor <natechancellor@gmail.com>
    arm64: percpu: Initialize ret in the default case

Paul Gortmaker <paul.gortmaker@windriver.com>
    platform/x86: acerhdf: Add BIOS entry for Gateway LT31 v1.3307

Feng Tang <feng.tang@intel.com>
    x86/earlyprintk: Add a force option for pciserial device

Zubin Mithra <zsm@chromium.org>
    apparmor: Fix uninitialized value in aa_split_fqname

Marek Szyprowski <m.szyprowski@samsung.com>
    clk: samsung: exynos5420: Enable PERIS clocks for suspend

Chengguang Xu <cgxu519@gmx.com>
    fs/exofs: fix potential memory leak in mount option parsing

David Miller <davem@davemloft.net>
    perf symbols: Set PLT entry/header sizes properly on Sparc

Alan Tull <atull@kernel.org>
    clk: fixed-rate: fix of_node_get-put imbalance

Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
    platform/x86: intel_telemetry: report debugfs failure

Lee, Shawn C <shawn.c.lee@intel.com>
    drm/edid: Add 6 bpc quirk for BOE panel.

Richard Weinberger <richard@nod.at>
    um: Give start_idle_thread() a return code

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfsplus: prevent btree data loss on root split

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfs: prevent btree data loss on root split

Jann Horn <jannh@google.com>
    reiserfs: propagate errors from fill_with_dentries() properly

Radoslaw Tyl <radoslawx.tyl@intel.com>
    ixgbe: fix MAC anti-spoofing filter after VFLR

Keith Busch <keith.busch@intel.com>
    nvme-pci: fix conflicting p2p resource adds

Anders Roxell <anders.roxell@linaro.org>
    arm64: kprobe: make page to RO mode when allocate it

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: fix return value for cifs_listxattr

Colin Ian King <colin.king@canonical.com>
    cifs: don't dereference smb_file_target before null check


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt   |   6 +-
 Documentation/x86/x86_64/mm.txt                   |  10 +-
 Makefile                                          |   4 +-
 arch/arm64/include/asm/percpu.h                   |   3 +
 arch/arm64/kernel/probes/kprobes.c                |  27 +++--
 arch/mips/configs/cavium_octeon_defconfig         |   1 +
 arch/s390/kernel/perf_cpum_cf.c                   |   2 +-
 arch/s390/kernel/vdso32/Makefile                  |   6 +-
 arch/s390/kernel/vdso64/Makefile                  |   6 +-
 arch/s390/numa/numa.c                             |   1 +
 arch/um/os-Linux/skas/process.c                   |   5 +
 arch/x86/include/asm/page_64_types.h              |  12 ++-
 arch/x86/include/asm/pgtable_64_types.h           |   7 +-
 arch/x86/kernel/early_printk.c                    |  29 ++++--
 arch/x86/kernel/ldt.c                             |  49 ++++++---
 arch/x86/xen/mmu_pv.c                             |   6 +-
 drivers/acpi/acpi_platform.c                      |   1 +
 drivers/acpi/acpi_watchdog.c                      |  72 ++++++++-----
 drivers/block/zram/zram_drv.c                     |  26 ++---
 drivers/clk/clk-fixed-factor.c                    |   1 +
 drivers/clk/clk-fixed-rate.c                      |   1 +
 drivers/clk/samsung/clk-exynos5420.c              |   1 +
 drivers/gpu/drm/drm_edid.c                        |   3 +
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c     |   9 --
 drivers/gpu/drm/exynos/exynos_drm_crtc.c          |  11 --
 drivers/gpu/drm/exynos/exynos_drm_drv.h           |   1 -
 drivers/hid/uhid.c                                |  12 +++
 drivers/hwmon/ibmpowernv.c                        |   7 +-
 drivers/i2c/busses/Kconfig                        |   2 +-
 drivers/media/v4l2-core/v4l2-event.c              |  43 ++++----
 drivers/misc/atmel-ssc.c                          |   2 +-
 drivers/misc/sgi-gru/grukdump.c                   |   4 +
 drivers/mtd/nand/atmel/nand-controller.c          |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c       |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_sp.h          |   3 +
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c |  16 ++-
 drivers/net/ethernet/qlogic/qed/qed_spq.c         |  69 ++++++-------
 drivers/net/ethernet/stmicro/stmmac/common.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/descs_com.h   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c   |   2 +-
 drivers/nvme/host/pci.c                           |   5 +-
 drivers/platform/x86/acerhdf.c                    |   1 +
 drivers/platform/x86/intel_telemetry_debugfs.c    |   8 +-
 drivers/s390/net/qeth_l3_main.c                   |   8 +-
 drivers/uio/uio.c                                 |   7 +-
 drivers/usb/class/cdc-acm.c                       |   3 +
 drivers/usb/core/quirks.c                         |   8 ++
 drivers/usb/misc/appledisplay.c                   |   1 +
 fs/cifs/cifsfs.c                                  |   7 +-
 fs/cifs/smb2ops.c                                 |  11 +-
 fs/exofs/super.c                                  |   5 +-
 fs/hfs/brec.c                                     |   4 +
 fs/hfsplus/brec.c                                 |   4 +
 fs/reiserfs/xattr.c                               |   7 ++
 include/linux/netfilter/ipset/ip_set.h            |   2 +-
 include/linux/netfilter/ipset/ip_set_comment.h    |   4 +-
 kernel/sched/core.c                               |   5 +-
 lib/raid6/test/Makefile                           |   4 +-
 net/ceph/messenger.c                              |  12 ++-
 net/netfilter/ipset/ip_set_core.c                 |  23 ++---
 net/netfilter/ipset/ip_set_hash_netportnet.c      |   8 +-
 net/netfilter/ipset/ip_set_list_set.c             |  17 ++--
 net/netfilter/xt_IDLETIMER.c                      |  20 ++++
 net/sunrpc/xdr.c                                  |   2 +-
 security/apparmor/lib.c                           |   6 +-
 tools/perf/jvmti/jvmti_agent.c                    |  49 +++++++--
 tools/perf/tests/code-reading.c                   |   1 +
 tools/perf/util/env.c                             |  32 ++++++
 tools/perf/util/env.h                             |   4 +
 tools/perf/util/machine.c                         | 117 +++++++++++++++++++++-
 tools/perf/util/machine.h                         |   6 ++
 tools/perf/util/symbol-elf.c                      |  12 ++-
 tools/perf/util/symbol.c                          |  12 ++-
 75 files changed, 637 insertions(+), 262 deletions(-)


