Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4101FC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F119020882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762549;
	bh=zIcHcIdxJk4RKL2NHJ1C/oWeVu2Tub1VUR67V5BBUMs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GNak2b/WDRfbiH3Fo++LzZ02X/PrWoOoIIdqI6CcPt+32a6rAbe5xqGk6SGTd1enC
	 3GGphY3P4x/WGX1VDsgsSTypif7Anjo5JvZEB4oKJ5/D5I27RuSZgVqMLwNvi8BedV
	 dmSXa5nwaBwdp4b7aDPMUGAozoyWN7vyTmcwF1Ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfA2LtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731409AbfA2LtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:49:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431042083B;
        Tue, 29 Jan 2019 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762542;
        bh=zIcHcIdxJk4RKL2NHJ1C/oWeVu2Tub1VUR67V5BBUMs=;
        h=From:To:Cc:Subject:Date:From;
        b=EZhJotkSr27xlLmg1N+Zj+RJjRcMHbQOsBWEe/v+PjJQnosgr5pZZ950gVLZtbkAL
         Kzj82ccfd1lm1KcSebzIVxcc3nj4PP8llICZj/qhPzfLDIXR6M6PgxZObH7S0hebTD
         oWoSLT3MitrjCxsgdtkgET5k7AlwZCSVv/PbF27E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/68] 4.14.97-stable review
Date:   Tue, 29 Jan 2019 12:35:22 +0100
Message-Id: <20190129113131.751891514@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.97-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.97-rc1
X-KernelTest-Deadline: 2019-01-31T11:31+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.97 release.
There are 68 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jan 31 11:31:10 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.97-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.97-rc1

Anand Jain <anand.jain@oracle.com>
    btrfs: dev-replace: go back to suspended state if target device is missing

Jeff Mahoney <jeffm@suse.com>
    btrfs: fix error handling in btrfs_dev_replace_start

Pan Bian <bianpan2016@163.com>
    f2fs: read page index before freeing

Juergen Gross <jgross@suse.com>
    xen: Fix x86 sched_clock() interface for xen

Pavel Tatashin <pasha.tatashin@oracle.com>
    x86/xen/time: Output xen sched_clock time from 0

Joao Martins <joao.m.martins@oracle.com>
    x86/xen/time: setup vcpu 0 time info page

Joao Martins <joao.m.martins@oracle.com>
    x86/xen/time: set pvclock flags on xen_time_init()

Joao Martins <joao.m.martins@oracle.com>
    x86/pvclock: add setter for pvclock_pvti_cpu0_va

Joao Martins <joao.m.martins@oracle.com>
    ptp_kvm: probe for kvm guest availability

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix leaking USB3 shared_hcd at xhci removal

Jack Pham <jackp@codeaurora.org>
    usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup

Raju Rangoju <rajur@chelsio.com>
    nvmet-rdma: fix null dereference under heavy load

Israel Rukshin <israelr@mellanox.com>
    nvmet-rdma: Add unlikely for response allocated check

David Hildenbrand <david@redhat.com>
    s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Fix a 4.14 backport regression related to userspace/guest FPU

Jose Abreu <Jose.Abreu@synopsys.com>
    net: stmmac: Use correct values in TQS/RQS fields

Sasha Levin <sashal@kernel.org>
    Revert "seccomp: add a selftest for get_metadata"

Milian Wolff <milian.wolff@kdab.com>
    perf unwind: Take pgoff into account when reporting elf to libdwfl

Martin Vuille <jpmv27@aim.com>
    perf unwind: Unwind with libdw doesn't take symfs into account

Nicolas Pitre <nicolas.pitre@linaro.org>
    vt: invoke notifier on screen size change

Oliver Hartkopp <socketcan@hartkopp.net>
    can: bcm: check timer values before ktime conversion

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb by removing it

Marc Zyngier <marc.zyngier@arm.com>
    irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size

Thomas Gleixner <tglx@linutronix.de>
    posix-cpu-timers: Unbreak timer rearming

Daniel Drake <drake@endlessm.com>
    x86/kaslr: Fix incorrect i8254 outb() parameters

Dave Hansen <dave.hansen@linux.intel.com>
    x86/selftests/pkeys: Fork() to check for state being preserved

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys: Properly copy pkey state at fork()

Alexander Popov <alex.popov@linux.com>
    KVM: x86: Fix single-step debugging

Milan Broz <gmazyland@gmail.com>
    dm crypt: fix parsing of extended IV arguments

Joe Thornber <ejt@redhat.com>
    dm thin: fix passdown_double_checking_shared_status()

Dan Williams <dan.j.williams@intel.com>
    acpi/nfit: Fix command-supported detection

Dan Williams <dan.j.williams@intel.com>
    acpi/nfit: Block function zero DSMs

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: uinput - fix undefined behavior in uinput_validate_absinfo()

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    compiler.h: enable builtin overflow checkers and add fallback code

Tom Panfil <tom@steelseries.com>
    Input: xpad - add support for SteelSeries Stratus Duo

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not reconnect TCP session in add_credits()

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix credit calculation for encrypted reads with errors

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix credits calculations for reads with errors

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix possible hang during async MTU reads and writes

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Check for ring when getting debug info

Vitaly Kuznetsov <vkuznets@redhat.com>
    hv_balloon: avoid touching uninitialized struct page during tail onlining

Paul Fulghum <paulkf@microgate.com>
    tty/n_hdlc: fix __might_sleep warning

Samir Virmani <samir@embedur.com>
    uart: Fix crash in uart_write and uart_put_char

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: Handle problem if line discipline does not have receive_buf

Michael Straube <straube.linux@gmail.com>
    staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1

Gustavo A. R. Silva <gustavo@embeddedor.com>
    char/mwave: fix potential Spectre v1 vulnerability

Gerald Schaefer <gerald.schaefer@de.ibm.com>
    s390/smp: fix CPU hotplug deadlock with CPU rescan

Christian Borntraeger <borntraeger@de.ibm.com>
    s390/early: improve machine detection

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: perf: map generic branches to correct hardware condition

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: adjust memblock_reserve of kernel memory

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARCv2: lib: memeset: fix doing prefetchw outside of buffer

Anthony Wong <anthony.wong@canonical.com>
    ALSA: hda - Add mute LED support for HP ProBook 470 G5

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ASoC: rt5514-spi: Fix potential NULL pointer dereference

Kangjie Lu <kjlu@umn.edu>
    ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

Charles Yeh <charlesyeh522@gmail.com>
    USB: serial: pl2303: add new PID to support PL2303TB

Max Schulze <max.schulze@posteo.de>
    USB: serial: simple: add Motorola Tetra TPG2200 device id

Tomas Winkler <tomas.winkler@intel.com>
    mei: me: add denverton innovation engine device IDs

Vijay Viswanath <vviswana@codeaurora.org>
    mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS

Paolo Abeni <pabeni@redhat.com>
    ipfrag: really prevent allocation on netns exit

Willem de Bruijn <willemb@google.com>
    tcp: allow MSG_ZEROCOPY transmission also in CLOSE_WAIT state

Ido Schimmel <idosch@mellanox.com>
    net: ipv4: Fix memory leak in network namespace dismantle

Jason Wang <jasowang@redhat.com>
    vhost: log dirty page correctly

Ross Lagerwall <ross.lagerwall@citrix.com>
    openvswitch: Avoid OOB read when parsing flow nlattrs

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: refetch skb protocol for each filter

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    net: phy: mdio_bus: add missing device_del() in mdiobus_register() error handling

Ross Lagerwall <ross.lagerwall@citrix.com>
    net: Fix usage of pskb_trim_rcsum

Yunjian Wang <wangyunjian@huawei.com>
    net: bridge: Fix ethernet header pointer before check skb forwardable

Lendacky, Thomas <Thomas.Lendacky@amd.com>
    amd-xgbe: Fix mdio access for non-zero ports and clause 45 PHYs


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/arc/include/asm/perf_event.h                 |   3 +-
 arch/arc/lib/memset-archs.S                       |  40 ++++-
 arch/arc/mm/init.c                                |   3 +-
 arch/s390/kernel/early.c                          |   4 +-
 arch/s390/kernel/setup.c                          |   2 +
 arch/s390/kernel/smp.c                            |  12 +-
 arch/x86/entry/vdso/vma.c                         |   2 +-
 arch/x86/include/asm/mmu_context.h                |  18 ++
 arch/x86/include/asm/pvclock.h                    |  19 +-
 arch/x86/kernel/kvmclock.c                        |   7 +-
 arch/x86/kernel/pvclock.c                         |  14 ++
 arch/x86/kvm/x86.c                                |   9 +-
 arch/x86/lib/kaslr.c                              |   4 +-
 arch/x86/xen/suspend.c                            |   4 +
 arch/x86/xen/time.c                               | 118 ++++++++++++-
 arch/x86/xen/xen-ops.h                            |   2 +
 drivers/acpi/nfit/core.c                          |  61 +++++--
 drivers/char/mwave/mwavedd.c                      |   7 +
 drivers/hv/hv_balloon.c                           |  10 +-
 drivers/hv/ring_buffer.c                          |  31 ++--
 drivers/hv/vmbus_drv.c                            |  91 ++++++----
 drivers/input/joystick/xpad.c                     |   3 +
 drivers/input/misc/uinput.c                       |   5 +-
 drivers/irqchip/irq-gic-v3-its.c                  |  25 +--
 drivers/md/dm-crypt.c                             |  25 ++-
 drivers/md/dm-thin-metadata.c                     |   4 +-
 drivers/md/dm-thin-metadata.h                     |   2 +-
 drivers/md/dm-thin.c                              |  10 +-
 drivers/misc/mei/hw-me-regs.h                     |   2 +
 drivers/misc/mei/pci-me.c                         |   2 +
 drivers/mmc/host/Kconfig                          |   1 +
 drivers/net/can/dev.c                             |  27 ++-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h       |   2 -
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c          |  22 ++-
 drivers/net/ethernet/stmicro/stmmac/common.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  15 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  22 ++-
 drivers/net/phy/mdio_bus.c                        |   1 +
 drivers/net/ppp/pppoe.c                           |   1 +
 drivers/nvme/target/rdma.c                        |  17 +-
 drivers/ptp/ptp_kvm.c                             |   5 +-
 drivers/s390/char/sclp_config.c                   |   2 +
 drivers/staging/rtl8188eu/os_dep/usb_intf.c       |   1 +
 drivers/tty/n_hdlc.c                              |   1 +
 drivers/tty/serial/serial_core.c                  |  12 +-
 drivers/tty/tty_io.c                              |   3 +-
 drivers/tty/vt/vt.c                               |   1 +
 drivers/usb/dwc3/gadget.c                         |   2 +
 drivers/usb/host/xhci-mtk.c                       |   6 +-
 drivers/usb/host/xhci-pci.c                       |   1 +
 drivers/usb/host/xhci-plat.c                      |   6 +-
 drivers/usb/host/xhci-tegra.c                     |   1 +
 drivers/usb/host/xhci.c                           |   2 -
 drivers/usb/serial/pl2303.c                       |   1 +
 drivers/usb/serial/pl2303.h                       |   2 +
 drivers/usb/serial/usb-serial-simple.c            |   3 +-
 drivers/vhost/net.c                               |   3 +-
 drivers/vhost/vhost.c                             |  97 ++++++++--
 drivers/vhost/vhost.h                             |   3 +-
 drivers/xen/events/events_base.c                  |   2 +-
 fs/btrfs/dev-replace.c                            |   9 +-
 fs/cifs/cifssmb.c                                 |  35 ++--
 fs/cifs/connect.c                                 |  21 +++
 fs/cifs/smb2ops.c                                 |  62 ++++---
 fs/f2fs/node.c                                    |   4 +-
 include/linux/compiler-clang.h                    |  14 ++
 include/linux/compiler-gcc.h                      |   4 +
 include/linux/compiler-intel.h                    |   4 +
 include/linux/hyperv.h                            |   5 +-
 include/linux/overflow.h                          | 205 ++++++++++++++++++++++
 include/linux/skbuff.h                            |   1 +
 include/net/ip_fib.h                              |   2 +-
 include/xen/interface/vcpu.h                      |  42 +++++
 kernel/time/posix-cpu-timers.c                    |   1 +
 net/bridge/br_forward.c                           |   9 +-
 net/bridge/br_netfilter_ipv6.c                    |   1 +
 net/bridge/netfilter/nft_reject_bridge.c          |   1 +
 net/can/bcm.c                                     |  27 +++
 net/ipv4/fib_frontend.c                           |   4 +-
 net/ipv4/fib_trie.c                               |  15 +-
 net/ipv4/inet_fragment.c                          |   2 +-
 net/ipv4/ip_input.c                               |   1 +
 net/ipv4/tcp.c                                    |   2 +-
 net/openvswitch/flow_netlink.c                    |   2 +-
 net/sched/cls_api.c                               |   3 +-
 sound/pci/hda/patch_conexant.c                    |   1 +
 sound/soc/codecs/rt5514-spi.c                     |   2 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c      |   8 +-
 tools/perf/util/unwind-libdw.c                    |   4 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c     |  61 -------
 tools/testing/selftests/x86/protection_keys.c     |  41 +++--
 92 files changed, 1073 insertions(+), 328 deletions(-)


