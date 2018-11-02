Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C542C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C64B20843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4zVtXvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C64B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbeKCD4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbeKCD4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:56:09 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 064632082D;
        Fri,  2 Nov 2018 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184473;
        bh=jkgQdGG7KNElIW2FKiFMt46Q/bBA3HfHOazwuE7Mq7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=R4zVtXvbJAWUC/Vwne8lT0BfsNcnNr0N1xOIseR9RVMdgJZ79kJza0N3ASlBkR4QM
         36r47vdb2vi+og7SvE+Mah1ry+jbaBl05HgzaPeG0iFPZGeV6eRZRV5AlNVIPFmBh/
         cUqQN2pUK1T+1gYJxBpJoHPUuX5Hm3wjEwFLr1uY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/143] 4.14.79-stable review
Date:   Fri,  2 Nov 2018 19:33:05 +0100
Message-Id: <20181102182857.064326086@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.79-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.79-rc1
X-KernelTest-Deadline: 2018-11-04T18:29+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.79 release.
There are 143 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Nov  4 18:27:59 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.79-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.79-rc1

Davide Caratti <dcaratti@redhat.com>
    net/sched: cls_api: add missing validation of netlink attributes

Florian Fainelli <f.fainelli@gmail.com>
    net: bcmgenet: Poll internal PHY for GENETv5

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: ipmr: fix unresolved entry dumps

Ido Schimmel <idosch@mellanox.com>
    rtnetlink: Disallow FDB configuration for non-Ethernet device

Eric Dumazet <edumazet@google.com>
    net/mlx5e: fix csum adjustments caused by RXFCS

Dimitris Michailidis <dmichail@google.com>
    net: fix pskb_trim_rcsum_slow() with odd trim offset

Cong Wang <xiyou.wangcong@gmail.com>
    net: drop skb on failure in ip_check_defrag()

Phil Sutter <phil@nwl.cc>
    net: sched: Fix for duplicate class dump

Huy Nguyen <huyn@mellanox.com>
    net/mlx5: Take only bit 24-26 of wqe.pftype_wq for page fault type

Jaime Caamaño Ruiz <jcaamano@suse.com>
    openvswitch: Fix push/pop ethernet validation

Stefano Brivio <sbrivio@redhat.com>
    ip6_tunnel: Fix encapsulation layout

Tobias Jungel <tobias.jungel@gmail.com>
    bonding: fix length of actor system

Wenwen Wang <wang6495@umn.edu>
    ethtool: fix a privilege escalation bug

Ake Koomsin <ake@igel.co.jp>
    virtio_net: avoid using netif_tx_disable() for serializing tx routine

Jason Wang <jasowang@redhat.com>
    vhost: Fix Spectre V1 vulnerability

Paolo Abeni <pabeni@redhat.com>
    udp6: fix encap return code for resubmitting

Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
    sctp: fix race on sctp_id2asoc

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix NAPI handling under high load

Sean Tranchetti <stranche@codeaurora.org>
    net: udp: fix handling of CHECKSUM_COMPLETE packets

Niklas Cassel <niklas.cassel@linaro.org>
    net: stmmac: Fix stmmac_mdio_reset() when building stmmac as modules

Wenwen Wang <wang6495@umn.edu>
    net: socket: fix a missing-check bug

Jakub Kicinski <jakub.kicinski@netronome.com>
    net: sched: gred: pass the right attribute to gred_change_table_def()

David Ahern <dsahern@gmail.com>
    net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs

Fugang Duan <fugang.duan@nxp.com>
    net: fec: don't dump RX FIFO register when not available

Cong Wang <xiyou.wangcong@gmail.com>
    llc: set SOCK_RCU_FREE in llc_sap_add_socket()

Stefano Brivio <sbrivio@redhat.com>
    ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers are called

Eric Dumazet <edumazet@google.com>
    ipv6: mcast: fix a use-after-free in inet6_mc_check

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: remove ipv6 zero address check in mcast queries

Hangbin Liu <liuhangbin@gmail.com>
    bridge: do not add port to router list when receives query with source 0.0.0.0

Colin Ian King <colin.king@canonical.com>
    drm/i915/gvt: fix memory leak of a cmd_entry struct on error exit path

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    perf tools: Disable parallelism for 'make clean'

Sasha Levin <sashal@kernel.org>
    Revert "netfilter: ipv6: nf_defrag: drop skb dst before queueing"

Takashi Iwai <tiwai@suse.de>
    ALSA: usx2y: Fix invalid stream URBs

Philipp Zabel <philipp.zabel@gmail.com>
    media: uvcvideo: Fix driver reference counting

Chris Paterson <chris.paterson2@renesas.com>
    ARM: dts: r8a7790: Correct critical CPU temperature

Peter Xu <peterx@redhat.com>
    kvm: x86: fix WARN due to uninitialized guest FPU state

Kimmo Rautkoski <ext-kimmo.rautkoski@vaisala.com>
    mtd: spi-nor: Add support for is25wp series chips

Christoph Paasch <cpaasch@apple.com>
    sch_netem: restore skb->dev after dequeuing from the rbtree

Khazhismel Kumykov <khazhy@google.com>
    fs/fat/fatent.c: add cond_resched() to fat_count_free_clusters()

Paolo Abeni <pabeni@redhat.com>
    selftests: rtnetlink.sh explicitly requires bash.

Arthur Kiyanovski <akiyano@amazon.com>
    net: ena: fix NULL dereference due to untimely napi initialization

Arthur Kiyanovski <akiyano@amazon.com>
    net: ena: fix warning in rmmod caused by double iounmap

David Howells <dhowells@redhat.com>
    rxrpc: Fix connection-level abort handling

David Howells <dhowells@redhat.com>
    rxrpc: Only take the rwind and mtu values from latest ACK

David Howells <dhowells@redhat.com>
    rxrpc: Don't check RXRPC_CALL_TX_LAST after calling rxrpc_rotate_tx_window()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf python: Use -Wno-redundant-decls to build with PYTHON=python3

Sascha Hauer <s.hauer@pengutronix.de>
    ARM: dts: imx53-qsb: disable 1.2GHz OPP

Paul Burton <paul.burton@mips.com>
    compiler.h: Allow arch-specific asm/compiler.h

Sandipan Das <sandipan@linux.ibm.com>
    perf tests: Fix indexing when invoking subtests

Daniel Mack <daniel@zonque.org>
    libertas: call into generic suspend code before turning off power

Masahiro Yamada <yamada.masahiro@socionext.com>
    kconfig: fix the rule of mainmenu_stmt symbol

Arnd Bergmann <arnd@arndb.de>
    net: stmmac: mark PM functions as __maybe_unused

Dan Carpenter <dan.carpenter@oracle.com>
    x86/paravirt: Fix some warning messages

Florian Fainelli <f.fainelli@gmail.com>
    net: phy: phylink: Don't release NULL GPIO

Qu Wenruo <wqu@suse.com>
    btrfs: quota: Set rescan progress to (u64)-1 if we hit last leaf

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: sd: Remember that READ CAPACITY(16) succeeded

Brian King <brking@linux.vnet.ibm.com>
    scsi: ibmvfc: Avoid unnecessary port relogin

Michael Neuling <mikey@neuling.org>
    selftests/powerpc: Add ptrace hw breakpoint test

Phil Reid <preid@electromag.com.au>
    iio: buffer: fix the function signature to match implementation

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: do not overwrite error code

Phil Elwell <phil@raspberrypi.org>
    lan78xx: Don't reset the interface on open

Paul Burton <paul.burton@mips.com>
    MIPS: Workaround GCC __builtin_unreachable reordering bug

John Keeping <john@metanate.com>
    mmc: dw_mmc-rockchip: correct property names in debug

Jason Gunthorpe <jgg@mellanox.com>
    IB/usnic: Update with bug fixes from core code

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen-netfront: Fix mismatched rtnl_unlock

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen-netfront: Update features after registering netdev

Winkler, Tomas <tomas.winkler@intel.com>
    tpm: tpm_crb: relinquish locality on error path.

John Fastabend <john.fastabend@gmail.com>
    bpf: sockmap, map_release does not hold refcnt for pinned maps

Nayna Jain <nayna@linux.vnet.ibm.com>
    tpm: move the delay_msec increment after sleep in tpm_transmit()

David S. Miller <davem@davemloft.net>
    sparc64: Fix regression in pmdp_invalidate().

KarimAllah Ahmed <karahmed@amazon.de>
    KVM: x86: Update the exit_qualification access bits while walking an address

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on other arches

Geert Uytterhoeven <geert@linux-m68k.org>
    cifs: Use ULL suffix for 64-bit constant

James Chapman <jchapman@katalix.com>
    l2tp: remove configurable payload offset

Marcel Ziswiler <marcel.ziswiler@toradex.com>
    ARM: tegra: Fix ULPI regression on Tegra20

Noa Osherovich <noaos@mellanox.com>
    IB/mlx5: Avoid passing an invalid QP type to firmware

Stefan Agner <stefan@agner.ch>
    kbuild: set no-integrated-as before incl. arch Makefile

Ben Hutchings <ben.hutchings@codethink.co.uk>
    scsi: qla2xxx: Avoid double completion of abort command

Shay Agroskin <shayag@mellanox.com>
    net/mlx5e: Refine ets validation function

Kevin Hao <haokexin@gmail.com>
    net: phy: Add general dummy stubs for MMD register access

Kevin Hao <haokexin@gmail.com>
    net: phy: realtek: Use the dummy stubs for MMD register access for rtl8211b

Milan Broz <gmazyland@gmail.com>
    dm integrity: fail early if required HMAC key is not available

Corentin Labbe <clabbe@baylibre.com>
    powerpc/pseries: Add empty update_numa_cpu_lookup_table() for NUMA=n

Israel Rukshin <israelr@mellanox.com>
    net/mlx5: Fix mlx5_get_vector_affinity function

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix error handling in adapter command callbacks

Doug Ledford <dledford@redhat.com>
    IB/rxe: put the pool on allocation failure

Alex Vesker <valex@mellanox.com>
    IB/ipoib: Fix lockdep issue found on ipoib_ib_dev_heavy_flush

Arnd Bergmann <arnd@arndb.de>
    scsi: aacraid: address UBSAN warning regression

Shuah Khan <shuah@kernel.org>
    usbip: vhci_hcd: update 'status' file header and format

Dan Williams <dan.j.williams@intel.com>
    tools/testing/nvdimm: unit test clear-error commands

Andy Lutomirski <luto@kernel.org>
    x86/power: Fix some ordering bugs in __restore_processor_context()

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: fix the ALIVE notification layout

Liad Kaufman <liad.kaufman@intel.com>
    iwlwifi: dbg: allow wrt collection before ALIVE

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: mvm: check for short GI only for OFDM

Larry Chen <lchen@suse.com>
    ocfs2: fix crash in ocfs2_duplicate_clusters_by_page()

Wenwen Wang <wang6495@umn.edu>
    yam: fix a missing-check bug

Wenwen Wang <wang6495@umn.edu>
    net: cxgb3_main: fix a missing-check bug

Davide Caratti <dcaratti@redhat.com>
    be2net: don't flip hw_features when VXLANs are added/deleted

Guenter Roeck <linux@roeck-us.net>
    locking/ww_mutex: Fix runtime warning in the WW mutex selftest

Sean Tranchetti <stranche@codeaurora.org>
    net: qualcomm: rmnet: Skip processing loopback packets

Maciej W. Rozycki <macro@linux-mips.org>
    declance: Fix continuation with the adapter identification message

Rickard x Andersson <rickaran@axis.com>
    net: fec: fix rare tx timeout

Natarajan, Janakarajan <Janakarajan.Natarajan@amd.com>
    perf/x86/amd/uncore: Set ThreadMask and SliceMask for L3 Cache perf events

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on SKX

Jiri Olsa <jolsa@redhat.com>
    perf/ring_buffer: Prevent concurent ring buffer access

Peter Zijlstra <peterz@infradead.org>
    perf/core: Fix perf_pmu_unregister() locking

Yu Zhao <yuzhao@google.com>
    cfg80211: fix use-after-free in reg_process_hint()

Florian Fainelli <f.fainelli@gmail.com>
    smsc95xx: Check for Wake-on-LAN modes

Florian Fainelli <f.fainelli@gmail.com>
    smsc75xx: Check for Wake-on-LAN modes

Florian Fainelli <f.fainelli@gmail.com>
    r8152: Check for supported Wake-on-LAN Modes

Florian Fainelli <f.fainelli@gmail.com>
    sr9800: Check for supported Wake-on-LAN modes

Florian Fainelli <f.fainelli@gmail.com>
    lan78xx: Check for supported Wake-on-LAN modes

Florian Fainelli <f.fainelli@gmail.com>
    ax88179_178a: Check for supported Wake-on-LAN modes

Florian Fainelli <f.fainelli@gmail.com>
    asix: Check for supported Wake-on-LAN modes

Masashi Honma <masashi.honma@gmail.com>
    nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds

Nathan Chancellor <natechancellor@gmail.com>
    qed: Avoid implicit enum conversion in qed_iwarp_parse_rx_pkt

Nathan Chancellor <natechancellor@gmail.com>
    qed: Avoid constant logical operation warning in qed_vf_pf_acquire

Nathan Chancellor <natechancellor@gmail.com>
    qed: Avoid implicit enum conversion in qed_roce_mode_to_flavor

Nathan Chancellor <natechancellor@gmail.com>
    qed: Fix mask parameter in qed_vf_prep_tunn_req_tlv

Nathan Chancellor <natechancellor@gmail.com>
    qed: Avoid implicit enum conversion in qed_set_tunn_cls_info

Lubomir Rintel <lkundrak@v3.sk>
    pxa168fb: prepare the clock

Matias Karhumaa <matias.karhumaa@gmail.com>
    Bluetooth: SMP: fix crash in unpairing

Martin Willi <martin@strongswan.org>
    mac80211_hwsim: do not omit multicast announce of first added radio

Masashi Honma <masashi.honma@gmail.com>
    nl80211: Fix possible Spectre-v1 for NL80211_TXRATE_HT

Zhao Qiang <qiang.zhao@nxp.com>
    soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()

Alexandre Belloni <alexandre.belloni@bootlin.com>
    soc: fsl: qbman: qman: avoid allocating from non existing gen_pool

Michal Simek <michal.simek@xilinx.com>
    net: macb: Clean 64b dma addresses if they are not detected

Florian Fainelli <f.fainelli@gmail.com>
    ARM: dts: BCM63xx: Fix incorrect interrupt specifiers

Steve Capper <steve.capper@arm.com>
    arm64: hugetlb: Fix handling of young ptes

David Ahern <dsahern@gmail.com>
    netfilter: bridge: Don't sabotage nf_hook calls from an l3mdev

Sean Tranchetti <stranche@codeaurora.org>
    xfrm: validate template mode

Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    ARM: 8799/1: mm: fix pci_ioremap_io() offset check

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Fix NULL pointer dereference when skb_dst_force clears the dst_entry.

Yuan-Chi Pang <fu3mo6goo@gmail.com>
    mac80211: fix TX status reporting for ieee80211s

Johannes Berg <johannes.berg@intel.com>
    mac80211: TDLS: fix skb queue/priority assignment

Jouni Malinen <jouni@codeaurora.org>
    cfg80211: Address some corner cases in scan result channel updating

Bob Copeland <me@bobcopeland.com>
    mac80211: fix pending queue hang due to TX_DROP

Andrei Otcheretianski <andrei.otcheretianski@intel.com>
    cfg80211: reg: Init wiphy_idx in regulatory_hint_core()

Andrei Otcheretianski <andrei.otcheretianski@intel.com>
    mac80211: Always report TX status

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    xfrm: reset crypto_done when iterating over multiple input xfrms

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    xfrm: reset transport header back to network header after all input transforms ahave been applied

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    xfrm6: call kfree_skb when skb is toobig

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Validate address prefix lengths in the xfrm selector.


-------------

Diffstat:

 Makefile                                           |   8 +-
 arch/Kconfig                                       |   8 +
 arch/arm/boot/dts/bcm63138.dtsi                    |  14 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |  11 +
 arch/arm/boot/dts/r8a7790.dtsi                     |   2 +-
 arch/arm/boot/dts/tegra20.dtsi                     |   2 +-
 arch/arm/mm/ioremap.c                              |   2 +-
 arch/arm64/mm/hugetlbpage.c                        |  12 +-
 arch/mips/Kconfig                                  |   1 +
 arch/mips/include/asm/compiler.h                   |  35 +++
 arch/powerpc/include/asm/topology.h                |   3 +
 arch/sparc/mm/tlb.c                                |  19 +-
 arch/x86/events/amd/uncore.c                       |  10 +
 arch/x86/events/intel/uncore_snbep.c               |  12 +-
 arch/x86/include/asm/perf_event.h                  |   8 +
 arch/x86/kernel/paravirt.c                         |   4 +-
 arch/x86/kvm/paging_tmpl.h                         |  11 +-
 arch/x86/kvm/x86.c                                 |   6 +-
 arch/x86/power/cpu.c                               |  21 +-
 drivers/char/tpm/tpm-interface.c                   |   3 +-
 drivers/char/tpm/tpm_crb.c                         |  10 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   1 +
 drivers/infiniband/hw/mlx5/main.c                  |   2 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   7 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |   2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |  40 ++-
 drivers/infiniband/hw/usnic/usnic_uiom.h           |   5 +-
 drivers/infiniband/sw/rxe/rxe_pool.c               |  16 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |   7 +-
 drivers/md/dm-integrity.c                          |   3 +
 drivers/media/usb/uvc/uvc_driver.c                 |  11 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |   4 +-
 drivers/mtd/spi-nor/spi-nor.c                      |   6 +
 drivers/net/bonding/bond_netlink.c                 |   3 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  18 +-
 drivers/net/ethernet/amd/declance.c                |  10 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   9 +-
 drivers/net/ethernet/cadence/macb_main.c           |   1 +
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |  17 +
 drivers/net/ethernet/cisco/enic/enic_main.c        |   9 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   5 +-
 drivers/net/ethernet/freescale/fec.h               |   4 +
 drivers/net/ethernet/freescale/fec_main.c          |  24 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  45 +--
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c        |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_roce.c         |  15 +-
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c  |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |   5 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_handlers.c   |   3 +
 drivers/net/ethernet/realtek/r8169.c               |   8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   4 +-
 drivers/net/hamradio/yam.c                         |   4 +
 drivers/net/phy/phy_device.c                       |  17 +
 drivers/net/phy/phylink.c                          |   2 +-
 drivers/net/phy/realtek.c                          |   2 +
 drivers/net/usb/asix_common.c                      |   3 +
 drivers/net/usb/ax88179_178a.c                     |   3 +
 drivers/net/usb/lan78xx.c                          |  21 +-
 drivers/net/usb/r8152.c                            |   3 +
 drivers/net/usb/smsc75xx.c                         |   3 +
 drivers/net/usb/smsc95xx.c                         |   3 +
 drivers/net/usb/sr9800.c                           |   3 +
 drivers/net/virtio_net.c                           |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   4 +-
 drivers/net/wireless/mac80211_hwsim.c              |   3 +-
 drivers/net/wireless/marvell/libertas/if_sdio.c    |   4 +
 drivers/net/xen-netfront.c                         |  11 +-
 drivers/s390/net/qeth_core_main.c                  |  85 +++--
 drivers/scsi/aacraid/commsup.c                     |   8 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                     |   6 +-
 drivers/scsi/qla2xxx/qla_init.c                    |   4 +-
 drivers/scsi/sd.c                                  |   2 +
 drivers/soc/fsl/qbman/qman.c                       |   3 +
 drivers/soc/fsl/qe/ucc.c                           |   2 +-
 drivers/usb/usbip/vhci_sysfs.c                     |  12 +-
 drivers/vhost/vhost.c                              |   2 +
 drivers/video/fbdev/pxa168fb.c                     |   6 +-
 fs/btrfs/qgroup.c                                  |   4 +-
 fs/cifs/inode.c                                    |   2 +-
 fs/fat/fatent.c                                    |   1 +
 fs/ocfs2/refcounttree.c                            |  16 +-
 include/linux/bpf.h                                |   2 +-
 include/linux/compiler_types.h                     |  12 +
 include/linux/iio/buffer-dma.h                     |   2 +-
 include/linux/mlx5/driver.h                        |  12 +-
 include/linux/phy.h                                |   4 +
 kernel/bpf/arraymap.c                              |   3 +-
 kernel/bpf/sockmap.c                               |   4 +-
 kernel/bpf/syscall.c                               |   4 +-
 kernel/events/core.c                               |  11 +-
 kernel/locking/test-ww_mutex.c                     |  10 +-
 lib/test_bpf.c                                     |   2 +-
 net/bluetooth/mgmt.c                               |   7 +-
 net/bluetooth/smp.c                                |  29 +-
 net/bluetooth/smp.h                                |   3 +-
 net/bridge/br_multicast.c                          |   9 +-
 net/bridge/br_netfilter_hooks.c                    |   3 +-
 net/core/datagram.c                                |   5 +-
 net/core/ethtool.c                                 |   8 +-
 net/core/rtnetlink.c                               |  10 +
 net/core/skbuff.c                                  |   5 +-
 net/ipv4/ip_fragment.c                             |  12 +-
 net/ipv4/ipmr.c                                    |   2 -
 net/ipv4/udp.c                                     |  20 +-
 net/ipv4/xfrm4_input.c                             |   1 +
 net/ipv4/xfrm4_mode_transport.c                    |   4 +-
 net/ipv6/addrconf.c                                |   6 +-
 net/ipv6/ip6_checksum.c                            |  20 +-
 net/ipv6/ip6_tunnel.c                              |   9 +-
 net/ipv6/mcast.c                                   |  16 +-
 net/ipv6/ndisc.c                                   |   3 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   2 -
 net/ipv6/udp.c                                     |   6 +-
 net/ipv6/xfrm6_input.c                             |   1 +
 net/ipv6/xfrm6_mode_transport.c                    |   4 +-
 net/ipv6/xfrm6_output.c                            |   2 +
 net/l2tp/l2tp_core.c                               |  14 +-
 net/l2tp/l2tp_core.h                               |   3 -
 net/l2tp/l2tp_debugfs.c                            |   4 +-
 net/l2tp/l2tp_netlink.c                            |   3 -
 net/llc/llc_conn.c                                 |   1 +
 net/mac80211/mesh.h                                |   3 +-
 net/mac80211/mesh_hwmp.c                           |   9 +-
 net/mac80211/status.c                              |  11 +-
 net/mac80211/tdls.c                                |   8 +-
 net/mac80211/tx.c                                  |   2 +-
 net/openvswitch/flow_netlink.c                     |   4 +-
 net/rxrpc/ar-internal.h                            |   4 +-
 net/rxrpc/call_accept.c                            |   4 +-
 net/rxrpc/conn_event.c                             |  26 +-
 net/rxrpc/input.c                                  |  54 ++--
 net/sched/cls_api.c                                |   7 +-
 net/sched/sch_api.c                                |   3 +-
 net/sched/sch_gred.c                               |   2 +-
 net/sched/sch_netem.c                              |   4 +
 net/sctp/socket.c                                  |   5 +-
 net/socket.c                                       |  11 +-
 net/wireless/nl80211.c                             |  20 +-
 net/wireless/reg.c                                 |   8 +-
 net/wireless/scan.c                                |  58 +++-
 net/xfrm/xfrm_input.c                              |   1 +
 net/xfrm/xfrm_output.c                             |   4 +
 net/xfrm/xfrm_policy.c                             |   4 +
 net/xfrm/xfrm_user.c                               |  15 +
 scripts/kconfig/zconf.y                            |   4 +-
 sound/usb/usx2y/usb_stream.c                       |  23 +-
 tools/perf/Makefile                                |   4 +-
 tools/perf/tests/builtin-test.c                    |   4 +-
 tools/perf/util/setup.py                           |   2 +-
 tools/testing/nvdimm/test/nfit.c                   |  18 ++
 tools/testing/selftests/net/rtnetlink.sh           |   2 +-
 tools/testing/selftests/powerpc/ptrace/.gitignore  |   1 +
 tools/testing/selftests/powerpc/ptrace/Makefile    |   2 +-
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c      | 342 +++++++++++++++++++++
 160 files changed, 1231 insertions(+), 495 deletions(-)


