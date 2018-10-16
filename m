Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E21C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDE121476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt9xldEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDE121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeJQBDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeJQBDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1C32098A;
        Tue, 16 Oct 2018 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709931;
        bh=DS37p2yEFMvIt80HYHAnq0g+ZwzrcsNSu2G52UqXxLs=;
        h=From:To:Cc:Subject:Date:From;
        b=lt9xldEezi8iGxjKyb3VPQbK7odIZ2lHniLyuQPPReFqU8Zpbzl/B6BQ3A8qWQmDn
         eQ/pHHOPYcd7IOnuosdm9aAPyp/R7HJw1VxFgmo+Cn79YNNsv4MpF1tXb0js1eymi5
         qi1vixnuf3BsvlYVDj73+uhNA1LMeYFNBjN0eFPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.18 000/135] 4.18.15-stable review
Date:   Tue, 16 Oct 2018 19:03:50 +0200
Message-Id: <20181016170515.447235311@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.15-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.18.15-rc1
X-KernelTest-Deadline: 2018-10-18T17:05+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.18.15 release.
There are 135 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Oct 18 17:04:43 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.15-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.18.15-rc1

Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
    i2c: i2c-scmi: fix for i2c_smbus_write_block_data

Jan Kara <jack@suse.cz>
    mm: Preserve _PAGE_DEVMAP across mprotect() calls

Dan Williams <dan.j.williams@intel.com>
    filesystem-dax: Fix dax_layout_busy_page() livelock

Jérôme Glisse <jglisse@redhat.com>
    mm/thp: fix call to mmu_notifier in set_pmd_migration_entry() v2

Jann Horn <jannh@google.com>
    mm/mmap.c: don't clobber partially overlapping VMA with MAP_FIXED_NOREPLACE

Will Deacon <will.deacon@arm.com>
    arm64: perf: Reject stand-alone CHAIN events for PMUv3

Marco Felsch <m.felsch@pengutronix.de>
    pinctrl: mcp23s08: fix irq and irqchip setup order

Chris Boot <bootc@bootc.net>
    mmc: block: avoid multiblock reads for the last sector in SPI mode

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Grab runtime PM ref in nv50_mstc_detect()

Ramses Ramírez <ramzeto@gmail.com>
    Input: xpad - add support for Xbox1 PDP Camo series gamepad

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

Steven Rostedt (VMware) <rostedt@goodmis.org>
    vsprintf: Fix off-by-one bug in bstr_printf() processing dereferenced pointers

Mikulas Patocka <mpatocka@redhat.com>
    mach64: detect the dot clock divider correctly on sparc

Paul Burton <paul.burton@mips.com>
    MIPS: VDSO: Always map near top of user memory

Paul Burton <paul.burton@mips.com>
    MIPS: Fix CONFIG_CMDLINE handling

David Howells <dhowells@redhat.com>
    afs: Fix clearance of reply

David Howells <dhowells@redhat.com>
    afs: Fix afs_server struct leak

Jann Horn <jannh@google.com>
    mm/vmstat.c: fix outdated vmstat_text

Roman Gushchin <guro@fb.com>
    mm: slowly shrink slabs with a relatively small number of objects

Yong Zhao <Yong.Zhao@amd.com>
    drm/amdkfd: Fix ATS capablity was not reported correctly on some APUs

Yong Zhao <yong.zhao@amd.com>
    drm/amdkfd: Change the control stack MTYPE from UC to NC on GFX9

Amber Lin <Amber.Lin@amd.com>
    drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/kvm/lapic: always disable MMIO interface in x2APIC mode

Simon Detheridge <s@sd.ai>
    pinctrl: cannonlake: Fix gpio base for GPP-E

Hans de Goede <hdegoede@redhat.com>
    clk: x86: Stop marking clocks as CLK_IS_CRITICAL

Hans de Goede <hdegoede@redhat.com>
    clk: x86: add "ether_clk" alias for Bay Trail / Cherry Trail

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: pair VF based on serial number

Stephen Hemminger <stephen@networkplumber.org>
    PCI: hv: support reporting serial number as slot information

Nicolas Ferre <nicolas.ferre@microchip.com>
    ARM: dts: at91: add new compatibility string for macb on sama5d3

Nicolas Ferre <nicolas.ferre@microchip.com>
    net: macb: disable scatter-gather for macb on sama5d3

Corentin Labbe <clabbe@baylibre.com>
    net: ethernet: ti: add missing GENERIC_ALLOCATOR dependency

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775) Use different register to get fan RPM for fan7

Jongsung Kim <neidhard.kim@lge.com>
    stmmac: fix valid numbers of unicast filter entries

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775) Fix RPM output for fan7 on NCT6796D

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775) Fix virtual temperature sources for NCT6796D

Tushar Dave <tushar.n.dave@oracle.com>
    bpf: use __GFP_COMP while allocating page

Martin KaFai Lau <kafai@fb.com>
    bpf: btf: Fix end boundary calculation for type section

Yu Zhao <yuzhao@google.com>
    sound: don't call skl_init_chip() to reset intel skl soc

Yu Zhao <yuzhao@google.com>
    sound: enable interrupt after dma buffer initialization

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: qla2xxx: Fix an endian bug in fcpcmd_is_corrupted()

Laura Abbott <labbott@redhat.com>
    scsi: iscsi: target: Don't use stack buffer for scatterlist

Nicholas Piggin <npiggin@gmail.com>
    KVM: PPC: Book3S HV: Don't use compound_order to determine host mapping size

Tony Lindgren <tony@atomide.com>
    mfd: omap-usb-host: Fix dts probe of children

Hermes Zhang <chenhuiz@axis.com>
    Bluetooth: hci_ldisc: Free rw_semaphore on close

Matias Karhumaa <matias.karhumaa@gmail.com>
    Bluetooth: Use correct tfm to generate OOB data

Johan Hedberg <johan.hedberg@intel.com>
    Bluetooth: SMP: Fix trying to use non-existent local OOB data

zhong jiang <zhongjiang@huawei.com>
    drm/pl111: Make sure of_device_id tables are NULL terminated

Akshu Agrawal <akshu.agrawal@amd.com>
    ASoC: AMD: Ensure reset bit is cleared before configuring

Jay Kamat <jgkamat@fb.com>
    Add tests for memory.oom.group

Jay Kamat <jgkamat@fb.com>
    Fix cg_read_strcmp()

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775) Fix access to fan pulse registers

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: don't fallback to PIO mode when -EPROBE_DEFER

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: adg: care clock-frequency size

Lei Yang <Lei.Yang@windriver.com>
    selftests: memory-hotplug: add required configs

Lei Yang <Lei.Yang@windriver.com>
    selftests/efivarfs: add required kernel configs

Anders Roxell <anders.roxell@linaro.org>
    selftests: add headers_install to lib.mk

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: q6routing: initialize data correctly

Danny Smith <danny.smith@axis.com>
    ASoC: sigmadsp: safeload should not have lower byte limit

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: wm8804: Add ACPI support

Ryan Lee <ryans.lee@maximintegrated.com>
    ASoC: max98373: Added 10ms sleep after amp software reset

Thiago Jung Bauermann <bauerman@linux.ibm.com>
    selftests: kselftest: Remove outdated comment

Anders Roxell <anders.roxell@linaro.org>
    selftests: android: move config up a level

Oder Chiou <oder_chiou@realtek.com>
    ASoC: rt5514: Fix the issue of the delay volume applied again

Ryan Lee <ryans.lee@maximintegrated.com>
    ASoC: max98373: Added speaker FS gain cotnrol register to volatile.

Charles Keepax <ckeepax@opensource.cirrus.com>
    ASoC: dapm: Fix NULL pointer deference on CODEC to CODEC DAIs

Hangbin Liu <liuhangbin@gmail.com>
    vxlan: fill ttl inherit info

Maciej S. Szmigiero <mail@maciej.szmigiero.name>
    r8169: set RX_MULTI_EN bit in RxConfig for 8168F-family chips

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix network stalls due to missing bit TXCFG_AUTO_FIFO

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Fix shmem structure inconsistency between driver and the mfw.

Antoine Tenart <antoine.tenart@bootlin.com>
    net: mscc: fix the frame extraction into the skb

Mike Rapoport <rppt@linux.vnet.ibm.com>
    net/ipv6: stop leaking percpu memory in fib6 info

David Ahern <dsahern@gmail.com>
    net/ipv6: Remove extra call to ip6_convert_metrics for multipath case

Vasundhara Volam <vasundhara-v.volam@broadcom.com>
    bnxt_en: get the reduced max_irqs by the ones used by RDMA

Vasundhara Volam <vasundhara-v.volam@broadcom.com>
    bnxt_en: Fix enables field in HWRM_QUEUE_COS2BW_CFG request

Alaa Hleihel <alaa@mellanox.com>
    net/mlx5: Check for SQ and not RQ state when modifying hairpin SQ

Sabrina Dubroca <sd@queasysnail.net>
    net: ipv4: don't let PMTU updates increase route MTU

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Fix VNIC reservations on the PF.

David Ahern <dsahern@gmail.com>
    rtnetlink: Fail dump if target netnsid is invalid

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: b53: Keep CPU port as tagged in all VLANs

Eric Dumazet <edumazet@google.com>
    inet: make sure to grab rcu_read_lock before using ireq->ireq_opt

Eric Dumazet <edumazet@google.com>
    tcp/dccp: fix lockdep issue when SYN is backlogged

Russell King <rmk+kernel@armlinux.org.uk>
    sfp: fix oops with ethtool -m

Baruch Siach <baruch@tkos.co.il>
    net: phy: phylink: fix SFP interface autodetection

Maciej Żenczykowski <maze@google.com>
    net-ethtool: ETHTOOL_GUFO did not and should not require CAP_NET_ADMIN

Davide Caratti <dcaratti@redhat.com>
    bnxt_en: don't try to offload VLAN 'modify' action

Jakub Kicinski <jakub.kicinski@netronome.com>
    nfp: avoid soft lockups under control message storm

Jose Abreu <Jose.Abreu@synopsys.com>
    net: stmmac: Rework coalesce timer and fix multi-queue races

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

Eric Dumazet <edumazet@google.com>
    tun: napi flags belong to tfile

Eric Dumazet <edumazet@google.com>
    tun: initialize napi_mutex unconditionally

Eric Dumazet <edumazet@google.com>
    tun: remove unused parameters

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    net: qualcomm: rmnet: Fix incorrect allocation flag in receive path

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    net: qualcomm: rmnet: Fix incorrect allocation flag in transmit

Sean Tranchetti <stranche@codeaurora.org>
    net: qualcomm: rmnet: Skip processing loopback packets

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

Al Viro <viro@zeniv.linux.org.uk>
    net: sched: cls_u32: fix hnode refcounting

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
 Makefile                                           |  18 +-
 arch/arm/boot/dts/sama5d3_emac.dtsi                |   2 +-
 arch/arm64/kernel/perf_event.c                     |   7 +
 arch/mips/include/asm/processor.h                  |  10 +-
 arch/mips/kernel/process.c                         |  25 +++
 arch/mips/kernel/setup.c                           |  48 +++--
 arch/mips/kernel/vdso.c                            |  18 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   4 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |  91 ++++----
 arch/x86/include/asm/pgtable_types.h               |   2 +-
 arch/x86/include/uapi/asm/kvm.h                    |   1 +
 arch/x86/kvm/lapic.c                               |  22 +-
 drivers/bluetooth/hci_ldisc.c                      |   2 +
 drivers/clk/x86/clk-pmc-atom.c                     |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |  13 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  21 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  15 +-
 drivers/gpu/drm/pl111/pl111_vexpress.c             |   3 +-
 drivers/hwmon/nct6775.c                            |  70 ++++--
 drivers/i2c/busses/i2c-scmi.c                      |   1 +
 drivers/input/joystick/xpad.c                      |   3 +
 drivers/md/dm-cache-target.c                       |   5 +-
 drivers/md/dm-flakey.c                             |   2 +
 drivers/md/dm-linear.c                             |   8 +-
 drivers/md/dm.c                                    |  27 ++-
 drivers/mfd/omap-usb-host.c                        |  11 +-
 drivers/mmc/core/block.c                           |  10 +
 drivers/net/bonding/bond_main.c                    |  65 +++---
 drivers/net/dsa/b53/b53_common.c                   |   4 +-
 drivers/net/dsa/bcm_sf2.c                          |  14 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  32 +--
 drivers/net/ethernet/broadcom/bcmsysport.c         |  22 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  27 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c      |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |  20 +-
 drivers/net/ethernet/cadence/macb_main.c           |   8 +
 drivers/net/ethernet/hisilicon/hns/hnae.c          |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  30 ++-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  19 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/transobj.c |   2 +-
 drivers/net/ethernet/mscc/ocelot_board.c           |  12 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |  17 +-
 drivers/net/ethernet/qlogic/qed/qed_hsi.h          |   1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |   8 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h    |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h     |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |  12 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_handlers.c   |   7 +-
 drivers/net/ethernet/realtek/r8169.c               |  24 +--
 drivers/net/ethernet/stmicro/stmmac/common.h       |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 238 ++++++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   5 +-
 drivers/net/ethernet/ti/Kconfig                    |   1 +
 drivers/net/hyperv/netvsc.c                        |   3 +
 drivers/net/hyperv/netvsc_drv.c                    |  58 ++---
 drivers/net/phy/phylink.c                          |  48 +++--
 drivers/net/phy/sfp-bus.c                          |   4 +-
 drivers/net/team/team.c                            |   6 +
 drivers/net/tun.c                                  |  43 ++--
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/smsc75xx.c                         |   1 +
 drivers/net/vxlan.c                                |   3 +
 drivers/pci/controller/pci-hyperv.c                |  37 ++++
 drivers/perf/arm_pmu.c                             |   8 +-
 drivers/pinctrl/intel/pinctrl-cannonlake.c         |   2 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |  13 +-
 drivers/s390/cio/vfio_ccw_cp.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_target.h                  |   4 +-
 drivers/target/iscsi/iscsi_target.c                |  22 +-
 drivers/video/fbdev/aty/atyfb.h                    |   3 +-
 drivers/video/fbdev/aty/atyfb_base.c               |   7 +-
 drivers/video/fbdev/aty/mach64_ct.c                |  10 +-
 fs/afs/rxrpc.c                                     |   2 -
 fs/dax.c                                           |  13 +-
 include/linux/cgroup-defs.h                        |   1 +
 include/linux/netdevice.h                          |   7 +
 include/linux/perf/arm_pmu.h                       |   1 +
 include/linux/stmmac.h                             |   1 +
 include/linux/virtio_net.h                         |  18 ++
 include/net/bonding.h                              |   7 +-
 include/net/inet_sock.h                            |   6 -
 include/net/ip_fib.h                               |   1 +
 include/sound/hdaudio.h                            |   1 +
 include/sound/soc-dapm.h                           |   1 +
 kernel/bpf/btf.c                                   |   2 +-
 kernel/cgroup/cgroup.c                             |  25 ++-
 lib/vsprintf.c                                     |   2 +-
 mm/huge_memory.c                                   |   6 -
 mm/mmap.c                                          |   2 +-
 mm/percpu.c                                        |   1 +
 mm/vmscan.c                                        |  11 +
 mm/vmstat.c                                        |   1 -
 net/bluetooth/smp.c                                |  16 +-
 net/core/dev.c                                     |  28 ++-
 net/core/ethtool.c                                 |   1 +
 net/core/filter.c                                  |   3 +-
 net/core/rtnetlink.c                               |  41 ++--
 net/dccp/input.c                                   |   4 +-
 net/dccp/ipv4.c                                    |   4 +-
 net/ipv4/fib_frontend.c                            |  12 +-
 net/ipv4/fib_semantics.c                           |  50 +++++
 net/ipv4/inet_connection_sock.c                    |   5 +-
 net/ipv4/ip_sockglue.c                             |   3 +-
 net/ipv4/ip_tunnel.c                               |   9 +
 net/ipv4/route.c                                   |   7 +-
 net/ipv4/tcp_input.c                               |   4 +-
 net/ipv4/tcp_ipv4.c                                |   4 +-
 net/ipv4/udp.c                                     |   2 +-
 net/ipv6/addrconf.c                                |   4 +-
 net/ipv6/ip6_fib.c                                 |   2 +
 net/ipv6/ip6_tunnel.c                              |  13 +-
 net/ipv6/raw.c                                     |  29 ++-
 net/ipv6/route.c                                   |   5 -
 net/netlabel/netlabel_unlabeled.c                  |   3 +-
 net/packet/af_packet.c                             |  11 +-
 net/sched/cls_u32.c                                |  10 +-
 net/sched/sch_api.c                                |  24 ++-
 net/sctp/transport.c                               |  12 +-
 net/tipc/socket.c                                  |   4 +-
 scripts/subarch.include                            |  13 ++
 sound/hda/hdac_controller.c                        |  15 +-
 sound/soc/amd/acp-pcm-dma.c                        |  21 ++
 sound/soc/codecs/max98373.c                        |   3 +
 sound/soc/codecs/rt5514.c                          |   8 +-
 sound/soc/codecs/sigmadsp.c                        |   3 +-
 sound/soc/codecs/wm8804-i2c.c                      |  15 +-
 sound/soc/intel/skylake/skl.c                      |   2 +-
 sound/soc/qcom/qdsp6/q6routing.c                   |   4 +-
 sound/soc/sh/rcar/adg.c                            |   5 +
 sound/soc/sh/rcar/core.c                           |  10 +-
 sound/soc/sh/rcar/dma.c                            |   4 +
 sound/soc/soc-core.c                               |   4 +-
 sound/soc/soc-dapm.c                               |   4 +
 tools/perf/scripts/python/export-to-postgresql.py  |   9 +
 tools/perf/scripts/python/export-to-sqlite.py      |   6 +-
 tools/testing/selftests/android/Makefile           |   2 +-
 tools/testing/selftests/android/{ion => }/config   |   0
 tools/testing/selftests/android/ion/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c       |  38 +++-
 tools/testing/selftests/cgroup/cgroup_util.h       |   1 +
 tools/testing/selftests/cgroup/test_memcontrol.c   | 205 ++++++++++++++++++
 tools/testing/selftests/efivarfs/config            |   1 +
 tools/testing/selftests/futex/functional/Makefile  |   1 +
 tools/testing/selftests/gpio/Makefile              |   7 +-
 tools/testing/selftests/kselftest.h                |   1 -
 tools/testing/selftests/kvm/Makefile               |   7 +-
 tools/testing/selftests/lib.mk                     |  12 ++
 tools/testing/selftests/memory-hotplug/config      |   1 +
 tools/testing/selftests/net/Makefile               |   1 +
 .../selftests/networking/timestamping/Makefile     |   1 +
 tools/testing/selftests/vm/Makefile                |   4 -
 163 files changed, 1543 insertions(+), 647 deletions(-)


