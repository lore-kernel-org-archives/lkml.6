Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C10DC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF9720833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSbFS7oY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF9720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeKCDqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:20 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 740312082D;
        Fri,  2 Nov 2018 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183887;
        bh=a988EuSZsFFFnUDpn0mpr1RuvuODOludLfS+UQXoqxg=;
        h=From:To:Cc:Subject:Date:From;
        b=HSbFS7oYr1OEGyUWxdEKktUVQUzRalY9/y0IyA1CtSGSqxBbwuJKK/fKGfIOEwWae
         rATT7Z0OeptAqXiGb6ClLl1sT+82rDIQWGSRGB0xPXvHc6Qab/7OBpOX2DTMUr5k/6
         k1BdP6QyfH/LGqjmr9OQYHBM/ATc+6GnvHWEKn6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.18 000/150] 4.18.17-stable review
Date:   Fri,  2 Nov 2018 19:32:42 +0100
Message-Id: <20181102182902.250560510@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.17-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.18.17-rc1
X-KernelTest-Deadline: 2018-11-04T18:29+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.18.17 release.
There are 150 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Nov  4 18:28:05 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.17-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.18.17-rc1

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: remove ipv6 zero address check in mcast queries

David S. Miller <davem@davemloft.net>
    sparc: Throttle perf events properly.

David S. Miller <davem@davemloft.net>
    sparc: Fix syscall fallback bugs in VDSO.

David S. Miller <davem@davemloft.net>
    sparc: Fix single-pcr perf event counter management.

David S. Miller <davem@davemloft.net>
    sparc64: Wire up compat getpeername and getsockname.

David S. Miller <davem@davemloft.net>
    sparc64: Set %l4 properly on trap return after handling signals.

David S. Miller <davem@davemloft.net>
    sparc64: Make proc_id signed.

David Miller <davem@redhat.com>
    sparc64: Make corrupted user stacks more debuggable.

David S. Miller <davem@davemloft.net>
    sparc64: Export __node_distance.

Shalom Toledo <shalomt@mellanox.com>
    mlxsw: core: Fix devlink unregister flow

Tariq Toukan <tariqt@mellanox.com>
    net/mlx5: WQ, fixes for fragmented WQ buffers API

Dimitris Michailidis <dmichail@google.com>
    net: fix pskb_trim_rcsum_slow() with odd trim offset

Cong Wang <xiyou.wangcong@gmail.com>
    net: drop skb on failure in ip_check_defrag()

Taehee Yoo <ap420073@gmail.com>
    net: bpfilter: use get_pid_task instead of pid_task

Petr Machata <petrm@mellanox.com>
    mlxsw: spectrum_switchdev: Don't ignore deletions of learned MACs

Karsten Graul <kgraul@linux.ibm.com>
    net/smc: fix smc_buf_unuse to use the lgr pointer

Talat Batheesh <talatb@mellanox.com>
    net/mlx5: Fix memory leak when setting fpga ipsec caps

Xin Long <lucien.xin@gmail.com>
    sctp: not free the new asoc when sctp_wait_for_connect returns err

Xin Long <lucien.xin@gmail.com>
    sctp: fix the data size calculation in sctp_data_size

David Ahern <dsahern@gmail.com>
    net/ipv6: Allow onlink routes to have a device mismatch if it is the default route

Davide Caratti <dcaratti@redhat.com>
    net/sched: cls_api: add missing validation of netlink attributes

Phil Sutter <phil@nwl.cc>
    net: sched: Fix for duplicate class dump

Florian Fainelli <f.fainelli@gmail.com>
    net: bcmgenet: Poll internal PHY for GENETv5

Huy Nguyen <huyn@mellanox.com>
    net/mlx5: Take only bit 24-26 of wqe.pftype_wq for page fault type

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: ipmr: fix unresolved entry dumps

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

Tung Nguyen <tung.q.nguyen@dektech.com.au>
    tipc: fix unsafe rcu locking when accessing publication list

Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
    sctp: fix race on sctp_id2asoc

Ido Schimmel <idosch@mellanox.com>
    rtnetlink: Disallow FDB configuration for non-Ethernet device

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

Eric Dumazet <edumazet@google.com>
    net/mlx5e: fix csum adjustments caused by RXFCS

David Ahern <dsahern@gmail.com>
    net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs

Fugang Duan <fugang.duan@nxp.com>
    net: fec: don't dump RX FIFO register when not available

Cong Wang <xiyou.wangcong@gmail.com>
    llc: set SOCK_RCU_FREE in llc_sap_add_socket()

Sabrina Dubroca <sd@queasysnail.net>
    ipv6: rate-limit probes for neighbourless routes

Stefano Brivio <sbrivio@redhat.com>
    ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers are called

Eric Dumazet <edumazet@google.com>
    ipv6: mcast: fix a use-after-free in inet6_mc_check

Hangbin Liu <liuhangbin@gmail.com>
    bridge: do not add port to router list when receives query with source 0.0.0.0

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    perf tools: Disable parallelism for 'make clean'

Sasha Levin <sashal@kernel.org>
    Revert "netfilter: ipv6: nf_defrag: drop skb dst before queueing"

Sasha Levin <sashal@kernel.org>
    Revert "mm: slowly shrink slabs with a relatively small number of objects"

Khazhismel Kumykov <khazhy@google.com>
    fs/fat/fatent.c: add cond_resched() to fat_count_free_clusters()

David Howells <dhowells@redhat.com>
    afs: Fix cell proc list

Peter Oberparleiter <oberpar@linux.ibm.com>
    vmlinux.lds.h: Fix linker warnings about orphan .LPBX sections

Peter Oberparleiter <oberpar@linux.ibm.com>
    vmlinux.lds.h: Fix incomplete .text.exit discards

Paolo Abeni <pabeni@redhat.com>
    selftests: udpgso_bench.sh explicitly requires bash

Paolo Abeni <pabeni@redhat.com>
    selftests: rtnetlink.sh explicitly requires bash.

Ka-Cheong Poon <ka-cheong.poon@oracle.com>
    rds: RDS (tcp) hangs on sendto() to unresponding address

Valentine Fatiev <Valentinef@mellanox.com>
    IB/mlx5: Unmap DMA addr from HCA before IOMMU

Stephen Boyd <swboyd@chromium.org>
    gpio: Assign gpio_irq_chip::parents to non-stack pointer

Arthur Kiyanovski <akiyano@amazon.com>
    net: ena: fix NULL dereference due to untimely napi initialization

Arthur Kiyanovski <akiyano@amazon.com>
    net: ena: fix rare bug when failed restart/resume is followed by driver removal

Arthur Kiyanovski <akiyano@amazon.com>
    net: ena: fix warning in rmmod caused by double iounmap

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: support CONFIG_KVM_AMD=y with CONFIG_CRYPTO_DEV_CCP_DD=m

David Howells <dhowells@redhat.com>
    rxrpc: Fix connection-level abort handling

David Howells <dhowells@redhat.com>
    rxrpc: Only take the rwind and mtu values from latest ACK

David Howells <dhowells@redhat.com>
    rxrpc: Carry call state out of locked section in rxrpc_rotate_tx_window()

David Howells <dhowells@redhat.com>
    rxrpc: Don't check RXRPC_CALL_TX_LAST after calling rxrpc_rotate_tx_window()

Milian Wolff <milian.wolff@kdab.com>
    perf record: Use unmapped IP for inline callchain cursors

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf python: Use -Wno-redundant-decls to build with PYTHON=python3

Sascha Hauer <s.hauer@pengutronix.de>
    ARM: dts: imx53-qsb: disable 1.2GHz OPP

Paul Burton <paul.burton@mips.com>
    compiler.h: Allow arch-specific asm/compiler.h

Hans de Goede <hdegoede@redhat.com>
    HID: i2c-hid: Remove RESEND_REPORT_DESCR quirk and its handling

Doron Roberts-Kedes <doronrk@fb.com>
    tls: Fix improper revert in zerocopy_from_iter

Milian Wolff <milian.wolff@kdab.com>
    perf report: Don't try to map ip to invalid map

Daniel Mack <daniel@zonque.org>
    libertas: call into generic suspend code before turning off power

Anders Roxell <anders.roxell@linaro.org>
    clk: mvebu: armada-37xx-periph: Remove unused var num_parents

Dan Carpenter <dan.carpenter@oracle.com>
    x86/paravirt: Fix some warning messages

Anshuman Khandual <anshuman.khandual@arm.com>
    mm/migrate.c: split only transparent huge pages when allocation fails

YueHaibing <yuehaibing@huawei.com>
    mm/gup_benchmark: fix unsigned comparison to zero in __gup_benchmark_ioctl

Larry Chen <lchen@suse.com>
    ocfs2: fix crash in ocfs2_duplicate_clusters_by_page()

Wenwen Wang <wang6495@umn.edu>
    yam: fix a missing-check bug

Wenwen Wang <wang6495@umn.edu>
    net: cxgb3_main: fix a missing-check bug

Srikar Dronamraju <srikar@linux.vnet.ibm.com>
    powerpc/numa: Skip onlining a offline node in kdump path

Davide Caratti <dcaratti@redhat.com>
    be2net: don't flip hw_features when VXLANs are added/deleted

Shirish S <shirish.s@amd.com>
    drm/amd/display: Signal hw_done() after waiting for flip_done()

Guenter Roeck <linux@roeck-us.net>
    locking/ww_mutex: Fix runtime warning in the WW mutex selftest

Guenter Roeck <linux@roeck-us.net>
    Revert "serial: 8250_dw: Fix runtime PM handling"

Atish Patra <atish.patra@wdc.com>
    RISCV: Fix end PFN for low memory

Maciej W. Rozycki <macro@linux-mips.org>
    declance: Fix continuation with the adapter identification message

Rickard x Andersson <rickaran@axis.com>
    net: fec: fix rare tx timeout

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Initialize after IOMMUs

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Do not handle ICM events after domain is stopped

Natarajan, Janakarajan <Janakarajan.Natarajan@amd.com>
    perf/x86/amd/uncore: Set ThreadMask and SliceMask for L3 Cache perf events

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on SKX

Jiri Olsa <jolsa@redhat.com>
    perf/ring_buffer: Prevent concurent ring buffer access

Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
    perf/x86/intel/uncore: Use boot_cpu_data.phys_proc_id instead of hardcorded physical package ID 0

Peter Zijlstra <peterz@infradead.org>
    perf/core: Fix perf_pmu_unregister() locking

Liran Alon <liran.alon@oracle.com>
    KVM: nVMX: Fix emulation of VM_ENTRY_LOAD_BNDCFGS

Liran Alon <liran.alon@oracle.com>
    KVM: x86: Do not use kvm_x86_ops->mpx_supported() directly

Liran Alon <liran.alon@oracle.com>
    KVM: nVMX: Do not expose MPX VMX controls when guest MPX disabled

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

Florian Westphal <fw@strlen.de>
    netfilter: avoid erronous array bounds warning

Taehee Yoo <ap420073@gmail.com>
    netfilter: nft_set_rbtree: add missing rb_erase() in GC routine

David Howells <dhowells@redhat.com>
    rxrpc: Fix error distribution

David Howells <dhowells@redhat.com>
    rxrpc: Fix transport sockopts to get IPv4 errors on an IPv6 socket

David Howells <dhowells@redhat.com>
    rxrpc: Fix RTT gathering

David Howells <dhowells@redhat.com>
    rxrpc: Fix checks as to whether we should set up a new call

Nilesh Javali <nilesh.javali@cavium.com>
    scsi: qedi: Initialize the stats mutex lock

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

Martin Willi <martin@strongswan.org>
    mac80211_hwsim: fix race in radio destruction from netlink notifier

Martin Willi <martin@strongswan.org>
    mac80211_hwsim: fix locking when iterating radios during ns exit

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

zhong jiang <zhongjiang@huawei.com>
    netfilter: conntrack: get rid of double sizeof

David Ahern <dsahern@gmail.com>
    netfilter: bridge: Don't sabotage nf_hook calls from an l3mdev

Hans Verkuil <hverkuil@xs4all.nl>
    drm/i2c: tda9950: set MAX_RETRIES for errors only

Colin Ian King <colin.king@canonical.com>
    drm/i2c: tda9950: fix timeout counter check

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

 Makefile                                           |  4 +-
 arch/Kconfig                                       |  8 ++
 arch/arm/boot/dts/bcm63138.dtsi                    | 14 ++--
 arch/arm/boot/dts/imx53-qsb-common.dtsi            | 11 +++
 arch/arm/kernel/vmlinux.lds.h                      |  2 +
 arch/arm/mm/ioremap.c                              |  2 +-
 arch/arm64/mm/hugetlbpage.c                        | 12 ++-
 arch/powerpc/mm/numa.c                             |  5 +-
 arch/riscv/kernel/setup.c                          |  2 +-
 arch/sparc/include/asm/cpudata_64.h                |  2 +-
 arch/sparc/include/asm/switch_to_64.h              |  3 +-
 arch/sparc/kernel/perf_event.c                     | 26 ++++++-
 arch/sparc/kernel/process_64.c                     | 25 ++++--
 arch/sparc/kernel/rtrap_64.S                       |  4 +-
 arch/sparc/kernel/signal32.c                       | 12 ++-
 arch/sparc/kernel/signal_64.c                      |  6 +-
 arch/sparc/kernel/systbls_64.S                     |  4 +-
 arch/sparc/mm/init_64.c                            |  1 +
 arch/sparc/vdso/vclock_gettime.c                   | 12 ++-
 arch/x86/events/amd/uncore.c                       | 10 +++
 arch/x86/events/intel/uncore_snbep.c               | 14 ++--
 arch/x86/include/asm/perf_event.h                  |  8 ++
 arch/x86/kernel/paravirt.c                         |  4 +-
 arch/x86/kvm/svm.c                                 |  6 +-
 arch/x86/kvm/vmx.c                                 | 39 ++++++++--
 arch/x86/kvm/x86.c                                 |  2 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |  1 -
 drivers/gpio/gpiolib.c                             |  3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 10 ++-
 drivers/gpu/drm/i2c/tda9950.c                      |  5 +-
 drivers/hid/hid-ids.h                              |  1 -
 drivers/hid/i2c-hid/i2c-hid.c                      | 18 +----
 drivers/infiniband/hw/mlx5/mr.c                    | 12 ++-
 drivers/net/bonding/bond_netlink.c                 |  3 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       | 22 +++---
 drivers/net/ethernet/amd/declance.c                | 10 ++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |  7 +-
 drivers/net/ethernet/cadence/macb_main.c           |  1 +
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    | 17 +++++
 drivers/net/ethernet/emulex/benet/be_main.c        |  5 +-
 drivers/net/ethernet/freescale/fec.h               |  4 +
 drivers/net/ethernet/freescale/fec_main.c          | 24 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 57 ++++----------
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    | 22 +++---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |  2 +-
 .../net/ethernet/mellanox/mlx5/core/fpga/ipsec.c   |  9 +--
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h  |  5 +-
 drivers/net/ethernet/mellanox/mlx5/core/wq.c       |  5 --
 drivers/net/ethernet/mellanox/mlx5/core/wq.h       | 11 ++-
 drivers/net/ethernet/mellanox/mlxsw/core.c         | 24 ++++--
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  2 -
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c        |  4 +-
 drivers/net/ethernet/qlogic/qed/qed_roce.c         | 15 +---
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c  |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |  5 +-
 drivers/net/ethernet/realtek/r8169.c               |  8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  2 +-
 drivers/net/hamradio/yam.c                         |  4 +
 drivers/net/usb/asix_common.c                      |  3 +
 drivers/net/usb/ax88179_178a.c                     |  3 +
 drivers/net/usb/lan78xx.c                          | 17 +----
 drivers/net/usb/r8152.c                            |  3 +
 drivers/net/usb/smsc75xx.c                         |  3 +
 drivers/net/usb/smsc95xx.c                         |  3 +
 drivers/net/usb/sr9800.c                           |  3 +
 drivers/net/virtio_net.c                           |  5 +-
 drivers/net/wireless/mac80211_hwsim.c              | 36 +++++----
 drivers/net/wireless/marvell/libertas/if_sdio.c    |  4 +
 drivers/scsi/qedi/qedi_main.c                      |  1 +
 drivers/soc/fsl/qbman/qman.c                       |  3 +
 drivers/soc/fsl/qe/ucc.c                           |  2 +-
 drivers/thunderbolt/icm.c                          | 49 +++++-------
 drivers/thunderbolt/nhi.c                          |  2 +-
 drivers/tty/serial/8250/8250_dw.c                  |  4 -
 drivers/vhost/vhost.c                              |  2 +
 drivers/video/fbdev/pxa168fb.c                     |  6 +-
 fs/afs/cell.c                                      | 17 ++++-
 fs/afs/dynroot.c                                   |  2 +-
 fs/afs/internal.h                                  |  4 +-
 fs/afs/main.c                                      |  2 +-
 fs/afs/proc.c                                      |  7 +-
 fs/fat/fatent.c                                    |  1 +
 fs/ocfs2/refcounttree.c                            | 16 +++-
 include/asm-generic/vmlinux.lds.h                  |  6 +-
 include/linux/compiler_types.h                     | 12 +++
 include/linux/gpio/driver.h                        |  7 ++
 include/linux/mlx5/driver.h                        |  8 ++
 include/linux/netfilter.h                          |  2 +
 include/net/ip6_fib.h                              |  4 +
 include/net/sctp/sm.h                              |  2 +-
 include/trace/events/rxrpc.h                       |  4 +-
 kernel/events/core.c                               | 11 +--
 kernel/locking/test-ww_mutex.c                     | 10 ++-
 mm/gup_benchmark.c                                 |  3 +-
 mm/migrate.c                                       |  2 +-
 mm/vmscan.c                                        | 11 ---
 net/bluetooth/mgmt.c                               |  7 +-
 net/bluetooth/smp.c                                | 29 ++++++-
 net/bluetooth/smp.h                                |  3 +-
 net/bpfilter/bpfilter_kern.c                       |  6 +-
 net/bridge/br_multicast.c                          |  9 ++-
 net/bridge/br_netfilter_hooks.c                    |  3 +-
 net/core/datagram.c                                |  5 +-
 net/core/ethtool.c                                 |  8 +-
 net/core/rtnetlink.c                               | 10 +++
 net/core/skbuff.c                                  |  5 +-
 net/ipv4/ip_fragment.c                             | 12 ++-
 net/ipv4/ipmr_base.c                               |  2 -
 net/ipv4/udp.c                                     | 20 ++++-
 net/ipv4/xfrm4_input.c                             |  1 +
 net/ipv4/xfrm4_mode_transport.c                    |  4 +-
 net/ipv6/addrconf.c                                |  6 +-
 net/ipv6/ip6_checksum.c                            | 20 ++++-
 net/ipv6/ip6_tunnel.c                              |  9 ++-
 net/ipv6/mcast.c                                   | 16 ++--
 net/ipv6/ndisc.c                                   |  3 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |  2 -
 net/ipv6/route.c                                   | 14 ++--
 net/ipv6/udp.c                                     |  6 +-
 net/ipv6/xfrm6_input.c                             |  1 +
 net/ipv6/xfrm6_mode_transport.c                    |  4 +-
 net/ipv6/xfrm6_output.c                            |  2 +
 net/llc/llc_conn.c                                 |  1 +
 net/mac80211/mesh.h                                |  3 +-
 net/mac80211/mesh_hwmp.c                           |  9 +--
 net/mac80211/status.c                              | 11 ++-
 net/mac80211/tdls.c                                |  8 +-
 net/mac80211/tx.c                                  |  2 +-
 net/netfilter/nf_conntrack_proto_tcp.c             |  4 +-
 net/netfilter/nft_set_rbtree.c                     | 28 +++----
 net/openvswitch/flow_netlink.c                     |  4 +-
 net/rds/send.c                                     | 13 +++-
 net/rxrpc/ar-internal.h                            | 19 +++--
 net/rxrpc/call_accept.c                            |  4 +-
 net/rxrpc/call_object.c                            |  2 +-
 net/rxrpc/conn_client.c                            |  4 +-
 net/rxrpc/conn_event.c                             | 26 ++++---
 net/rxrpc/conn_object.c                            |  4 +-
 net/rxrpc/input.c                                  | 88 ++++++++++++----------
 net/rxrpc/local_object.c                           | 32 +++++---
 net/rxrpc/output.c                                 | 31 ++++----
 net/rxrpc/peer_event.c                             | 46 +++--------
 net/rxrpc/peer_object.c                            | 17 -----
 net/sched/cls_api.c                                | 11 ++-
 net/sched/sch_api.c                                |  3 +-
 net/sched/sch_gred.c                               |  2 +-
 net/sctp/socket.c                                  |  9 ++-
 net/smc/smc_core.c                                 | 23 +++---
 net/socket.c                                       | 11 ++-
 net/tipc/name_distr.c                              |  4 +-
 net/tls/tls_sw.c                                   | 12 ++-
 net/wireless/nl80211.c                             | 20 +++--
 net/wireless/reg.c                                 |  8 +-
 net/wireless/scan.c                                | 58 +++++++++++---
 net/xfrm/xfrm_input.c                              |  1 +
 net/xfrm/xfrm_output.c                             |  4 +
 net/xfrm/xfrm_policy.c                             |  4 +
 net/xfrm/xfrm_user.c                               | 15 ++++
 tools/perf/Makefile                                |  4 +-
 tools/perf/util/machine.c                          |  8 +-
 tools/perf/util/setup.py                           |  2 +-
 tools/testing/selftests/net/fib-onlink-tests.sh    | 14 ++--
 tools/testing/selftests/net/rtnetlink.sh           |  2 +-
 tools/testing/selftests/net/udpgso_bench.sh        |  2 +-
 164 files changed, 977 insertions(+), 641 deletions(-)


