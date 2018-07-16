Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B272ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046A0208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046A0208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeGPIBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:01:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeGPIBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:01:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E3C79CA5;
        Mon, 16 Jul 2018 07:35:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.17 00/67] 4.17.7-stable review
Date:   Mon, 16 Jul 2018 09:34:29 +0200
Message-Id: <20180716073443.294323458@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.17.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.17.7-rc1
X-KernelTest-Deadline: 2018-07-18T07:34+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.17.7 release.
There are 67 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jul 18 07:34:11 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.7-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.17.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.17.7-rc1

Baruch Siach <baruch@tkos.co.il>
    ARM: dts: armada-38x: use the new thermal binding

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: sanity check for total valid node blocks

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: sanity check on sit entry

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: avoid bug_on on corrupted inode

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: give message and set need_fsck given broken node id

Marc Orr <marcorr@google.com>
    kvm: vmx: Nested VM-entry prereqs for event inj.

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    loop: remember whether sysfs_create_group() was done

Leon Romanovsky <leon@kernel.org>
    RDMA/ucm: Mark UCM interface as BROKEN

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    PM / hibernate: Fix oops at snapshot_write()

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: fix inobt magic number check

Theodore Ts'o <tytso@mit.edu>
    loop: add recursion validation to LOOP_CHANGE_FD

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: initialise match/target check parameter struct

Dmitry Vyukov <dvyukov@google.com>
    crypto: don't optimize keccakf()

Eric Dumazet <edumazet@google.com>
    netfilter: nf_queue: augment nfqa_cfg_policy

Oleg Nesterov <oleg@redhat.com>
    uprobes/x86: Remove incorrect WARN_ON() in uprobe_init_insn()

Eric Biggers <ebiggers@google.com>
    crypto: x86/salsa20 - remove x86 salsa20 implementations

Tony Battersby <tonyb@cybernetics.com>
    bsg: fix bogus EINVAL on non-data commands

Juergen Gross <jgross@suse.com>
    xen: setup pv irq ops vector earlier

Juergen Gross <jgross@suse.com>
    xen: remove global bit from __default_kernel_pte_mask for pv guests

Steve Wise <swise@opengridcomputing.com>
    iw_cxgb4: correctly enforce the max reg_mr depth

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: recovery: if possible send STOP with recovery pulses

Jon Hunter <jonathanh@nvidia.com>
    i2c: tegra: Fix NACK error handling

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Fix incorrect mixing of ERR_PTR and NULL return values

Paul Menzel <pmenzel@molgen.mpg.de>
    tools build: fix # escaping in .cmd files for future Make

Yandong Zhao <yandong77520@gmail.com>
    arm64: neon: Fix function may_use_simd() return error status

Dan Williams <dan.j.williams@intel.com>
    acpi, nfit: Fix scrub idle detection

Randy Dunlap <rdunlap@infradead.org>
    kbuild: delete INSTALL_FW_PATH from kbuild documentation

Joel Fernandes (Google) <joel@joelfernandes.org>
    tracing: Reorder display of TGID to be after PID

Michal Hocko <mhocko@suse.com>
    mm: do not bug_on on incorrect length in __mm_populate()

Oscar Salvador <osalvador@suse.de>
    fs, elf: make sure to page align bss in load_elf_library

Philipp Rudo <prudo@linux.ibm.com>
    x86/purgatory: add missing FORCE to Makefile target

Vlastimil Babka <vbabka@suse.cz>
    fs/proc/task_mmu.c: fix Locked field in /proc/pid/smaps*

Christian Borntraeger <borntraeger@de.ibm.com>
    mm: do not drop unused pages when userfaultd is running

Chris Wilson <chris@chris-wilson.co.uk>
    ALSA: hda - Handle pm failure during hotplug

Hui Wang <hui.wang@canonical.com>
    ALSA: hda/realtek - two more lenovo models need fixup of MIC_LOCATION

Pavel Tatashin <pasha.tatashin@oracle.com>
    mm: zero unavailable pages before memmap init

Linus Torvalds <torvalds@linux-foundation.org>
    Fix up non-directory creation in SGID directories

Dan Carpenter <dan.carpenter@oracle.com>
    xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Nico Sneck <snecknico@gmail.com>
    usb: quirks: add delay quirks for Corsair Strafe

Johan Hovold <johan@kernel.org>
    USB: serial: mos7840: fix status-register error handling

Jann Horn <jannh@google.com>
    USB: yurex: fix out-of-bounds uaccess in read handler

Johan Hovold <johan@kernel.org>
    USB: serial: keyspan_pda: fix modem-status error handling

Olli Salonen <olli.salonen@iki.fi>
    USB: serial: cp210x: add another USB ID for Qivicon ZigBee stick

Dan Carpenter <dan.carpenter@oracle.com>
    USB: serial: ch341: fix type promotion bug in ch341_control_in()

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Notify userspace when boot_acl is changed

Hans de Goede <hdegoede@redhat.com>
    ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS

Mika Westerberg <mika.westerberg@linux.intel.com>
    ahci: Add Intel Ice Lake LP PCI ID

Nadav Amit <namit@vmware.com>
    vmw_balloon: fix inflation with batching

Jiri Olsa <jolsa@kernel.org>
    tracing/kprobe: Release kprobe print_fmt properly

Vignesh R <vigneshr@ti.com>
    mtd: spi-nor: cadence-quadspi: Fix direct mode write timeouts

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: discard messages from not connected client during power down.

Damien Le Moal <damien.lemoal@wdc.com>
    ata: Fix ZBC_OUT all bit handling

Damien Le Moal <damien.lemoal@wdc.com>
    ata: Fix ZBC_OUT command block check

Ping-Ke Shih <pkshih@realtek.com>
    staging: r8822be: Fix RTL8822be can't find any wireless AP

Murray McAllister <murray.mcallister@insomniasec.com>
    staging: rtl8723bs: Prevent an underflow in rtw_check_beacon_data().

Jann Horn <jannh@google.com>
    ibmasm: don't write out of bounds in read handler

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    mmc: renesas_sdhi_internal_dmac: Cannot clear the RX_IN_USE in abort

x00270170 <xiaqing17@hisilicon.com>
    mmc: dw_mmc: fix card threshold control configuration

Stefan Agner <stefan@agner.ch>
    mmc: sdhci-esdhc-imx: allow 1.8V modes without 100/200MHz pinctrl states

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPICA: Clear status of all events when entering S5

Lucas Stach <l.stach@pengutronix.de>
    drm/etnaviv: bring back progress check in job timeout handler

Fabio Estevam <fabio.estevam@nxp.com>
    drm/etnaviv: Fix driver unregistering

Fabio Estevam <fabio.estevam@nxp.com>
    drm/etnaviv: Check for platform_device_register_simple() failure

Paul Burton <paul.burton@mips.com>
    MIPS: Fix ioremap() RAM check

Paul Burton <paul.burton@mips.com>
    MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()

Paul Burton <paul.burton@mips.com>
    MIPS: Call dump_stack() from show_regs()

Daniel Borkmann <daniel@iogearbox.net>
    bpf: reject passing modified ctx to helper functions


-------------

Diffstat:

 Documentation/kbuild/kbuild.txt               |   9 -
 Makefile                                      |   4 +-
 arch/arm/boot/dts/armada-38x.dtsi             |   2 +-
 arch/arm64/include/asm/simd.h                 |  19 +-
 arch/mips/kernel/process.c                    |  43 +-
 arch/mips/kernel/traps.c                      |   1 +
 arch/mips/mm/ioremap.c                        |  37 +-
 arch/x86/crypto/Makefile                      |   4 -
 arch/x86/crypto/salsa20-i586-asm_32.S         | 938 --------------------------
 arch/x86/crypto/salsa20-x86_64-asm_64.S       | 805 ----------------------
 arch/x86/crypto/salsa20_glue.c                |  91 ---
 arch/x86/include/asm/vmx.h                    |   3 +
 arch/x86/kernel/uprobes.c                     |   2 +-
 arch/x86/kvm/vmx.c                            |  67 ++
 arch/x86/kvm/x86.h                            |   9 +
 arch/x86/purgatory/Makefile                   |   2 +-
 arch/x86/xen/enlighten_pv.c                   |  25 +-
 arch/x86/xen/irq.c                            |   4 +-
 block/bsg.c                                   |   2 -
 crypto/Kconfig                                |  28 -
 crypto/sha3_generic.c                         |   2 +-
 drivers/acpi/acpica/hwsleep.c                 |  15 +-
 drivers/acpi/nfit/core.c                      |  44 +-
 drivers/acpi/nfit/nfit.h                      |   1 +
 drivers/ata/ahci.c                            |  60 ++
 drivers/ata/libata-core.c                     |   3 +
 drivers/ata/libata-scsi.c                     |  18 +-
 drivers/block/loop.c                          |  79 ++-
 drivers/block/loop.h                          |   1 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c         |  24 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h         |   3 +
 drivers/gpu/drm/etnaviv/etnaviv_sched.c       |  24 +
 drivers/i2c/busses/i2c-tegra.c                |  17 +-
 drivers/i2c/i2c-core-base.c                   |  11 +-
 drivers/infiniband/Kconfig                    |  11 +
 drivers/infiniband/core/Makefile              |   4 +-
 drivers/infiniband/hw/cxgb4/mem.c             |   2 +-
 drivers/infiniband/hw/hfi1/rc.c               |   2 +-
 drivers/infiniband/hw/hfi1/uc.c               |   4 +-
 drivers/infiniband/hw/hfi1/ud.c               |   4 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.c      |   4 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.h      |   4 +-
 drivers/misc/ibmasm/ibmasmfs.c                |  27 +-
 drivers/misc/mei/interrupt.c                  |   5 +-
 drivers/misc/vmw_balloon.c                    |   4 +-
 drivers/mmc/host/dw_mmc.c                     |   7 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |   3 +-
 drivers/mmc/host/sdhci-esdhc-imx.c            |  21 +-
 drivers/mtd/spi-nor/cadence-quadspi.c         |   6 +-
 drivers/staging/rtl8723bs/core/rtw_ap.c       |   2 +-
 drivers/staging/rtlwifi/rtl8822be/hw.c        |   2 +-
 drivers/staging/rtlwifi/wifi.h                |   1 +
 drivers/thunderbolt/domain.c                  |   4 +
 drivers/usb/core/quirks.c                     |   4 +
 drivers/usb/host/xhci-mem.c                   |   2 +-
 drivers/usb/misc/yurex.c                      |  23 +-
 drivers/usb/serial/ch341.c                    |   2 +-
 drivers/usb/serial/cp210x.c                   |   1 +
 drivers/usb/serial/keyspan_pda.c              |   4 +-
 drivers/usb/serial/mos7840.c                  |   3 +
 fs/binfmt_elf.c                               |   5 +-
 fs/f2fs/f2fs.h                                |  13 +-
 fs/f2fs/inode.c                               |  33 +-
 fs/f2fs/node.c                                |  21 +-
 fs/f2fs/segment.c                             |  25 +
 fs/inode.c                                    |   6 +
 fs/proc/task_mmu.c                            |   3 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c              |   2 +-
 include/linux/libata.h                        |   1 +
 kernel/bpf/verifier.c                         |  48 +-
 kernel/power/user.c                           |   5 +
 kernel/trace/trace.c                          |   8 +-
 kernel/trace/trace_kprobe.c                   |   6 +-
 kernel/trace/trace_output.c                   |   5 +-
 mm/gup.c                                      |   2 -
 mm/mmap.c                                     |  29 +-
 mm/page_alloc.c                               |   4 +-
 mm/rmap.c                                     |   8 +-
 net/bridge/netfilter/ebtables.c               |   2 +
 net/ipv4/netfilter/ip_tables.c                |   1 +
 net/ipv6/netfilter/ip6_tables.c               |   1 +
 net/netfilter/nfnetlink_queue.c               |   3 +
 sound/pci/hda/patch_hdmi.c                    |  19 +-
 sound/pci/hda/patch_realtek.c                 |   6 +-
 tools/build/Build.include                     |   4 +-
 tools/testing/selftests/bpf/test_verifier.c   |  58 +-
 86 files changed, 702 insertions(+), 2169 deletions(-)


