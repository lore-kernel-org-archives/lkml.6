Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0613C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EF021479
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xKLLdXf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EF021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbeJQBK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeJQBK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:10:28 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2812089E;
        Tue, 16 Oct 2018 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710343;
        bh=bhR6TOyvC3qh6kImyHm5MRe8jpFV36uaB6V1Cgzbzq4=;
        h=From:To:Cc:Subject:Date:From;
        b=xKLLdXf4aUHekQfso9RJz7bQXRrIJuwBFGNxhSh5L5ljpHg7v7/6uWVaV41YEe35G
         n7mqZp1Lj6xQu/KkCyXbHC1yrXKLKDTF7K/Sg0hKKND4WPNxjmTyp0xGf9CuoW7r41
         LQGet2m7VwfbCM2q7nLLA1OdzmIEqqLrm+Ykxop4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/109] 4.14.77-stable review
Date:   Tue, 16 Oct 2018 19:04:28 +0200
Message-Id: <20181016170524.530541524@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.77-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.77-rc1
X-KernelTest-Deadline: 2018-10-18T17:05+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.77 release.
There are 109 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Oct 18 17:04:58 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.77-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.77-rc1

Jiri Olsa <jolsa@kernel.org>
    perf tools: Fix snprint warnings for gcc 8

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v1: mitigate user accesses

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v1: use get_user() for __get_user()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: use __inttype() in get_user()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: oabi-compat: copy semops using __copy_from_user()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: vfp: use __copy_from_user() when restoring VFP state

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: signal: copy registers using __copy_from_user()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v1: fix syscall entry

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v1: add array_index_mask_nospec() implementation

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v1: add speculation barrier (csdb) macros

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: KVM: report support for SMCCC_ARCH_WORKAROUND_1

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: KVM: invalidate icache on guest exit for Brahma B15

Marc Zyngier <marc.zyngier@arm.com>
    ARM: KVM: invalidate icache on guest exit for Cortex-A15

Marc Zyngier <marc.zyngier@arm.com>
    ARM: KVM: invalidate BTB on guest exit for Cortex-A12/A17

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: warn about incorrect context switching functions

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: add firmware based hardening

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: harden user aborts in kernel space

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: add Cortex A8 and A15 validation of the IBE bit

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: harden branch predictor on context switches

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre: add Kconfig symbol for CPUs vulnerable to Spectre

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: bugs: add support for per-processor bug checking

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: bugs: hook processor bug checking into SMP and suspend paths

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: bugs: prepare processor bug infrastructure

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: add more CPU part numbers for Cortex and Brahma B15 CPUs

Roman Gushchin <guro@fb.com>
    mm: don't show nr_indirectly_reclaimable in /proc/vmstat

Roman Gushchin <guro@fb.com>
    mm: treat indirectly reclaimable memory as free in overcommit logic

Roman Gushchin <guro@fb.com>
    dcache: account external names as indirectly reclaimable memory

Roman Gushchin <guro@fb.com>
    mm: treat indirectly reclaimable memory as available in MemAvailable

Roman Gushchin <guro@fb.com>
    mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Don't print a warning when setting link state for disabled ports

Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
    i2c: i2c-scmi: fix for i2c_smbus_write_block_data

Jan Kara <jack@suse.cz>
    mm: Preserve _PAGE_DEVMAP across mprotect() calls

Jérôme Glisse <jglisse@redhat.com>
    mm/thp: fix call to mmu_notifier in set_pmd_migration_entry() v2

Will Deacon <will.deacon@arm.com>
    arm64: perf: Reject stand-alone CHAIN events for PMUv3

Marco Felsch <m.felsch@pengutronix.de>
    pinctrl: mcp23s08: fix irq and irqchip setup order

Chris Boot <bootc@bootc.net>
    mmc: block: avoid multiblock reads for the last sector in SPI mode

Tejun Heo <tj@kernel.org>
    cgroup: Fix dom_cgrp propagation when enabling threaded mode

Damien Le Moal <damien.lemoal@wdc.com>
    dm linear: fix linear_end_io conditional definition

Mike Snitzer <snitzer@redhat.com>
    dm linear: eliminate linear_end_io call if CONFIG_DM_ZONED disabled

Damien Le Moal <damien.lemoal@wdc.com>
    dm: fix report zone remapping to account for partition offset

Shenghui Wang <shhuiw@foxmail.com>
    dm cache: destroy migration_cache if cache target registration failed

Eric Farman <farman@linux.ibm.com>
    s390/cio: Fix how vfio-ccw checks pinned pages

Adrian Hunter <adrian.hunter@intel.com>
    perf script python: Fix export-to-sqlite.py sample columns

Adrian Hunter <adrian.hunter@intel.com>
    perf script python: Fix export-to-postgresql.py occasional failure

Mike Rapoport <rppt@linux.vnet.ibm.com>
    percpu: stop leaking bitmap metadata blocks

Mikulas Patocka <mpatocka@redhat.com>
    mach64: detect the dot clock divider correctly on sparc

Paul Burton <paul.burton@mips.com>
    MIPS: VDSO: Always map near top of user memory

Jann Horn <jannh@google.com>
    mm/vmstat.c: fix outdated vmstat_text

Amber Lin <Amber.Lin@amd.com>
    drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/kvm/lapic: always disable MMIO interface in x2APIC mode

Hans de Goede <hdegoede@redhat.com>
    clk: x86: Stop marking clocks as CLK_IS_CRITICAL

Hans de Goede <hdegoede@redhat.com>
    clk: x86: add "ether_clk" alias for Bay Trail / Cherry Trail

Stephen Hemminger <stephen@networkplumber.org>
    PCI: hv: support reporting serial number as slot information

Nicolas Ferre <nicolas.ferre@microchip.com>
    ARM: dts: at91: add new compatibility string for macb on sama5d3

Nicolas Ferre <nicolas.ferre@microchip.com>
    net: macb: disable scatter-gather for macb on sama5d3

Jongsung Kim <neidhard.kim@lge.com>
    stmmac: fix valid numbers of unicast filter entries

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: fix schedule in RCU context

Yu Zhao <yuzhao@google.com>
    sound: don't call skl_init_chip() to reset intel skl soc

Yu Zhao <yuzhao@google.com>
    sound: enable interrupt after dma buffer initialization

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: qla2xxx: Fix an endian bug in fcpcmd_is_corrupted()

Laura Abbott <labbott@redhat.com>
    scsi: iscsi: target: Don't use stack buffer for scatterlist

Tony Lindgren <tony@atomide.com>
    mfd: omap-usb-host: Fix dts probe of children

Hermes Zhang <chenhuiz@axis.com>
    Bluetooth: hci_ldisc: Free rw_semaphore on close

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: don't fallback to PIO mode when -EPROBE_DEFER

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: adg: care clock-frequency size

Lei Yang <Lei.Yang@windriver.com>
    selftests: memory-hotplug: add required configs

Lei Yang <Lei.Yang@windriver.com>
    selftests/efivarfs: add required kernel configs

Danny Smith <danny.smith@axis.com>
    ASoC: sigmadsp: safeload should not have lower byte limit

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: wm8804: Add ACPI support

Oder Chiou <oder_chiou@realtek.com>
    ASoC: rt5514: Fix the issue of the delay volume applied again

Eric Dumazet <edumazet@google.com>
    inet: make sure to grab rcu_read_lock before using ireq->ireq_opt

Eric Dumazet <edumazet@google.com>
    tcp/dccp: fix lockdep issue when SYN is backlogged

Maciej Żenczykowski <maze@google.com>
    net-ethtool: ETHTOOL_GUFO did not and should not require CAP_NET_ADMIN

Davide Caratti <dcaratti@redhat.com>
    bnxt_en: don't try to offload VLAN 'modify' action

Jakub Kicinski <jakub.kicinski@netronome.com>
    nfp: avoid soft lockups under control message storm

Mahesh Bandewar <maheshb@google.com>
    bonding: fix warning message

Mahesh Bandewar <maheshb@google.com>
    bonding: pass link-local packets to bonding master also.

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx5: E-Switch, Fix out of bound access when setting vport rate

Friedemann Gerold <f.gerold@b-c-s.de>
    net: aquantia: memory corruption on jumbo frames

Jianbo Liu <jianbol@mellanox.com>
    net/mlx5e: Set vlan masks for all offloaded TC rules

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: bcm_sf2: Fix unbind ordering

Jianfeng Tan <jianfeng.tan@linux.alibaba.com>
    net/packet: fix packet drop as of virtio gso

Jose Abreu <Jose.Abreu@synopsys.com>
    net: stmmac: Fixup the tail addr setting in xmit path

Jiri Kosina <jkosina@suse.cz>
    udp: Unbreak modules that rely on external __skb_recv_udp() availability

Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>
    tipc: fix flow control accounting for implicit connect

Ido Schimmel <idosch@mellanox.com>
    team: Forbid enslaving team device to itself

Xin Long <lucien.xin@gmail.com>
    sctp: update dst pmtu with the correct daddr

Eric Dumazet <edumazet@google.com>
    rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096

Mauricio Faria de Oliveira <mfo@canonical.com>
    rtnetlink: fix rtnl_fdb_dump() for ndmsg header

Giacinto Cifelli <gciofono@gmail.com>
    qmi_wwan: Added support for Gemalto's Cinterion ALASxx WWAN interface

Shahed Shaikh <shahed.shaikh@cavium.com>
    qlcnic: fix Tx descriptor corruption on 82xx devices

Yu Zhao <yuzhao@google.com>
    net/usb: cancel pending work when unbinding smsc75xx

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Fix wake-up interrupt race during resume

David Ahern <dsahern@gmail.com>
    net: sched: Add policy validation for tc attributes

Antoine Tenart <antoine.tenart@bootlin.com>
    net: mvpp2: fix a txq_done race condition

Maxime Chevallier <maxime.chevallier@bootlin.com>
    net: mvpp2: Extract the correct ethtype from the skb for tx csum offload

Sean Tranchetti <stranche@codeaurora.org>
    netlabel: check for IPV4MASK in addrinfo_get

Jeff Barnhill <0xeffeff@gmail.com>
    net/ipv6: Display all addresses in output of /proc/net/if_inet6

Sabrina Dubroca <sd@queasysnail.net>
    net: ipv4: update fnhe_pmtu when first hop's MTU changes

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns: fix for unmapping problem when SMMU is on

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: bcm_sf2: Call setup during switch resume

Wei Wang <weiwan@google.com>
    ipv6: take rcu lock in rawv6_send_hdrinc()

Eric Dumazet <edumazet@google.com>
    ipv4: fix use-after-free in ip_cmsg_recv_dstaddr()

Paolo Abeni <pabeni@redhat.com>
    ip_tunnel: be careful when accessing the inner header

Paolo Abeni <pabeni@redhat.com>
    ip6_tunnel: be careful when accessing the inner header

Mahesh Bandewar <maheshb@google.com>
    bonding: avoid possible dead-lock

Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
    bnxt_en: free hwrm resources, if driver probe fails.

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Fix TX timeout during netpoll.


-------------

Diffstat:

 Documentation/devicetree/bindings/net/macb.txt     |   1 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/sama5d3_emac.dtsi                |   2 +-
 arch/arm/include/asm/assembler.h                   |  12 ++
 arch/arm/include/asm/barrier.h                     |  32 ++++
 arch/arm/include/asm/bugs.h                        |   6 +-
 arch/arm/include/asm/cp15.h                        |   3 +
 arch/arm/include/asm/cputype.h                     |   8 +
 arch/arm/include/asm/kvm_asm.h                     |   2 -
 arch/arm/include/asm/kvm_host.h                    |  14 +-
 arch/arm/include/asm/kvm_mmu.h                     |  23 ++-
 arch/arm/include/asm/proc-fns.h                    |   4 +
 arch/arm/include/asm/system_misc.h                 |  15 ++
 arch/arm/include/asm/thread_info.h                 |   4 +-
 arch/arm/include/asm/uaccess.h                     |  26 ++-
 arch/arm/kernel/Makefile                           |   1 +
 arch/arm/kernel/bugs.c                             |  18 +++
 arch/arm/kernel/entry-common.S                     |  18 +--
 arch/arm/kernel/entry-header.S                     |  25 +++
 arch/arm/kernel/signal.c                           |  58 +++----
 arch/arm/kernel/smp.c                              |   4 +
 arch/arm/kernel/suspend.c                          |   2 +
 arch/arm/kernel/sys_oabi-compat.c                  |   8 +-
 arch/arm/kvm/hyp/hyp-entry.S                       | 112 ++++++++++++-
 arch/arm/lib/copy_from_user.S                      |   9 ++
 arch/arm/mm/Kconfig                                |  23 +++
 arch/arm/mm/Makefile                               |   2 +-
 arch/arm/mm/fault.c                                |   3 +
 arch/arm/mm/proc-macros.S                          |   3 +-
 arch/arm/mm/proc-v7-2level.S                       |   6 -
 arch/arm/mm/proc-v7-bugs.c                         | 174 +++++++++++++++++++++
 arch/arm/mm/proc-v7.S                              | 154 ++++++++++++++----
 arch/arm/vfp/vfpmodule.c                           |  17 +-
 arch/arm64/kernel/perf_event.c                     |   7 +
 arch/mips/include/asm/processor.h                  |  10 +-
 arch/mips/kernel/process.c                         |  25 +++
 arch/mips/kernel/vdso.c                            |  18 ++-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   4 +-
 arch/x86/include/asm/pgtable_types.h               |   2 +-
 arch/x86/include/uapi/asm/kvm.h                    |   1 +
 arch/x86/kvm/lapic.c                               |  22 ++-
 drivers/bluetooth/hci_ldisc.c                      |   2 +
 drivers/clk/x86/clk-pmc-atom.c                     |  18 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   2 +-
 drivers/i2c/busses/i2c-scmi.c                      |   1 +
 drivers/md/dm-cache-target.c                       |   5 +-
 drivers/md/dm-flakey.c                             |   2 +
 drivers/md/dm-linear.c                             |   8 +-
 drivers/md/dm.c                                    |  27 +++-
 drivers/mfd/omap-usb-host.c                        |  11 +-
 drivers/mmc/core/block.c                           |  10 ++
 drivers/net/bonding/bond_main.c                    |  65 ++++----
 drivers/net/dsa/bcm_sf2.c                          |  12 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  32 ++--
 drivers/net/ethernet/broadcom/bcmsysport.c         |  22 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  23 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |  20 ++-
 drivers/net/ethernet/cadence/macb_main.c           |   8 +
 drivers/net/ethernet/hisilicon/hns/hnae.c          |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  30 ++--
 drivers/net/ethernet/marvell/mvpp2.c               |  20 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   4 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |  17 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |   8 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h    |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h     |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |  12 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   8 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   5 +-
 drivers/net/hyperv/netvsc_drv.c                    |   9 +-
 drivers/net/team/team.c                            |   5 +
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/smsc75xx.c                         |   1 +
 drivers/pci/host/pci-hyperv.c                      |  37 +++++
 drivers/perf/arm_pmu.c                             |   8 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |  13 +-
 drivers/s390/cio/vfio_ccw_cp.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_target.h                  |   4 +-
 drivers/target/iscsi/iscsi_target.c                |  22 ++-
 drivers/usb/host/xhci-hub.c                        |  18 +--
 drivers/video/fbdev/aty/atyfb.h                    |   3 +-
 drivers/video/fbdev/aty/atyfb_base.c               |   7 +-
 drivers/video/fbdev/aty/mach64_ct.c                |  10 +-
 fs/dcache.c                                        |  38 +++--
 include/linux/cgroup-defs.h                        |   1 +
 include/linux/mmzone.h                             |   1 +
 include/linux/netdevice.h                          |   7 +
 include/linux/perf/arm_pmu.h                       |   1 +
 include/linux/virtio_net.h                         |  18 +++
 include/net/bonding.h                              |   7 +-
 include/net/inet_sock.h                            |   6 -
 include/net/ip_fib.h                               |   1 +
 include/sound/hdaudio.h                            |   1 +
 kernel/cgroup/cgroup.c                             |  25 +--
 mm/huge_memory.c                                   |   6 -
 mm/page_alloc.c                                    |   7 +
 mm/percpu.c                                        |   1 +
 mm/util.c                                          |   7 +
 mm/vmstat.c                                        |   6 +-
 net/core/dev.c                                     |  28 +++-
 net/core/ethtool.c                                 |   1 +
 net/core/rtnetlink.c                               |  35 +++--
 net/dccp/input.c                                   |   4 +-
 net/dccp/ipv4.c                                    |   4 +-
 net/ipv4/fib_frontend.c                            |  12 +-
 net/ipv4/fib_semantics.c                           |  50 ++++++
 net/ipv4/inet_connection_sock.c                    |   5 +-
 net/ipv4/ip_sockglue.c                             |   3 +-
 net/ipv4/ip_tunnel.c                               |   9 ++
 net/ipv4/tcp_input.c                               |   4 +-
 net/ipv4/tcp_ipv4.c                                |   4 +-
 net/ipv4/udp.c                                     |   2 +-
 net/ipv6/addrconf.c                                |   4 +-
 net/ipv6/ip6_tunnel.c                              |  13 +-
 net/ipv6/raw.c                                     |  29 ++--
 net/netlabel/netlabel_unlabeled.c                  |   3 +-
 net/packet/af_packet.c                             |  11 +-
 net/sched/sch_api.c                                |  22 ++-
 net/sctp/transport.c                               |  12 +-
 net/tipc/socket.c                                  |   4 +-
 sound/hda/hdac_controller.c                        |  15 +-
 sound/soc/codecs/rt5514.c                          |   8 +-
 sound/soc/codecs/sigmadsp.c                        |   3 +-
 sound/soc/codecs/wm8804-i2c.c                      |  15 +-
 sound/soc/intel/skylake/skl.c                      |   2 +-
 sound/soc/sh/rcar/adg.c                            |   5 +
 sound/soc/sh/rcar/core.c                           |  10 +-
 sound/soc/sh/rcar/dma.c                            |   4 +
 tools/perf/builtin-script.c                        |  22 +--
 tools/perf/scripts/python/export-to-postgresql.py  |   9 ++
 tools/perf/scripts/python/export-to-sqlite.py      |   6 +-
 tools/perf/tests/attr.c                            |   4 +-
 tools/perf/tests/mem.c                             |   2 +-
 tools/perf/tests/pmu.c                             |   2 +-
 tools/perf/util/cgroup.c                           |   2 +-
 tools/perf/util/parse-events.c                     |   4 +-
 tools/perf/util/pmu.c                              |   2 +-
 tools/testing/selftests/efivarfs/config            |   1 +
 tools/testing/selftests/memory-hotplug/config      |   1 +
 141 files changed, 1489 insertions(+), 428 deletions(-)


