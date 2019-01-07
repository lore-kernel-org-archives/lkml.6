Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A8FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678C0217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865991;
	bh=WPF6IgA6fdBZPv+ZH6DoWK9z5OegY9Fjv05IXZFphik=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WeetRuHKQR6s0kQhCfCi7iuHdKXVDVnEO/DUxAjapTVxqZ9kwKG2TNiGMawed/vim
	 z4RZDhgkPRkvZs/w0YLWm6nakZgAT+CX5tFxRU6X5lf1czMi6rcSUQ9EEmeb6GetqM
	 cpz0G0QDtQPaDcG0/nz5JOG/YBKPdfvdbpWDK3sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfAGM7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730268AbfAGM7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:59:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B0E206BB;
        Mon,  7 Jan 2019 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865986;
        bh=WPF6IgA6fdBZPv+ZH6DoWK9z5OegY9Fjv05IXZFphik=;
        h=From:To:Cc:Subject:Date:From;
        b=rlULxRMBV2KtxINja7VbHfJlL7lX3WcO/o2wQlJWePuHHBuFLGEs3YJOFRJTFDdK7
         +Capwr+SuLu4pHZOkVilyy59FT1SDcdqMTdxbAZ7dzDGiQ98hvCYBT5+EbSMtS36iC
         8oqjtKBsSPoNYI5Mf6tVQrqCNgzFqsnH3XT6Qpb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/101] 4.14.92-stable review
Date:   Mon,  7 Jan 2019 13:31:48 +0100
Message-Id: <20190107105330.372621917@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.92-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.92-rc1
X-KernelTest-Deadline: 2019-01-09T10:53+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.92 release.
There are 101 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jan  9 10:53:00 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.92-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.92-rc1

Tomas Winkler <tomas.winkler@intel.com>
    tpm: tpm_i2c_nuvoton: use correct command duration for TPM 2.x

Tomas Winkler <tomas.winkler@intel.com>
    tpm: tpm_try_transmit() refactor error flow.

Maciej W. Rozycki <macro@linux-mips.org>
    rtc: m41t80: Correct alarm month range with RTC reads

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: vgic: Force VM halt when changing the active state of GICv3 PPIs/SGIs

Will Deacon <will.deacon@arm.com>
    arm64: KVM: Avoid setting the upper 32 bits of VTCR_EL2 to 1

Georgy A Bystrenin <gkot@altlinux.org>
    CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock problem

Aaro Koskinen <aaro.koskinen@iki.fi>
    MIPS: OCTEON: mark RGMII interface disabled on OCTEON III

Paul Burton <paul.burton@mips.com>
    MIPS: Expand MIPS32 ASIDs to 64 bits

Huacai Chen <chenhc@lemote.com>
    MIPS: Align kernel load address to 64KB

Huacai Chen <chenhc@lemote.com>
    MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()

Huacai Chen <chenhc@lemote.com>
    MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3

Paul Burton <paul.burton@mips.com>
    MIPS: math-emu: Write-protect delay slot emulation pages

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: v4l2-tpg: array index could become negative

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: free bitmap_cap when updating std/timings/etc.

Nava kishore Manne <nava.manne@xilinx.com>
    serial: uartps: Fix interrupt mask issue to handle the RX interrupts properly

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    f2fs: fix validation of the block count in sanity_check_raw_super

Florian Westphal <fw@strlen.de>
    netfilter: nf_conncount: don't skip eviction when age is negative

Florian Westphal <fw@strlen.de>
    netfilter: nf_conncount: fix garbage collection confirm race

Yi-Hung Wei <yihung.wei@gmail.com>
    netfilter: nf_conncount: Fix garbage collection with zones

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_conncount: expose connection list interface

Florian Westphal <fw@strlen.de>
    netfilter: xt_connlimit: don't store address in the conn nodes

Breno Leitao <leitao@debian.org>
    powerpc/tm: Set MSR[TS] just prior to recheckpoint

Josef Bacik <jbacik@fb.com>
    btrfs: run delayed items before dropping the snapshot

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix fsync of files with multiple hard links in new directories

Macpaul Lin <macpaul.lin@mediatek.com>
    cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.

Tejun Heo <tj@kernel.org>
    cgroup: fix CSS_TASK_ITER_PROCS

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
    crypto: testmgr - add AES-CFB tests

Wenwen Wang <wang6495@umn.edu>
    crypto: cavium/nitrox - fix a DMA pool free failure

Johan Jonker <jbx9999@hotmail.com>
    clk: rockchip: fix typo in rk3188 spdif_frac parent

Lukas Wunner <lukas@wunner.de>
    spi: bcm2835: Avoid finishing transfer prematurely in IRQ mode

Lukas Wunner <lukas@wunner.de>
    spi: bcm2835: Fix book-keeping of DMA termination

Lukas Wunner <lukas@wunner.de>
    spi: bcm2835: Fix race on DMA termination

Theodore Ts'o <tytso@mit.edu>
    ext4: check for shutdown and r/o file system in ext4_write_inode()

Theodore Ts'o <tytso@mit.edu>
    ext4: force inode writes when nfsd calls commit_metadata()

Theodore Ts'o <tytso@mit.edu>
    ext4: include terminating u32 in size of xattr entries when expanding inodes

ruippan (潘睿) <ruippan@tencent.com>
    ext4: fix EXT4_IOC_GROUP_ADD ioctl

Maurizio Lombardi <mlombard@redhat.com>
    ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()

Pan Bian <bianpan2016@163.com>
    ext4: fix possible use after free in ext4_quota_enable

Theodore Ts'o <tytso@mit.edu>
    ext4: add ext4_sb_bread() to disambiguate ENOMEM cases

Ben Hutchings <ben@decadent.org.uk>
    perf pmu: Suppress potential format-truncation warning

Miquel Raynal <miquel.raynal@bootlin.com>
    platform-msi: Free descriptors in platform_msi_domain_free()

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: nVMX: Free the VMREAD/VMWRITE bitmaps if alloc_kvm_area() fails

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup

Dan Williams <dan.j.williams@intel.com>
    x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()

Michal Hocko <mhocko@suse.com>
    x86/speculation/l1tf: Drop the swap storage limit restriction when l1tf=off

Patrick Dreyer <Patrick@Dreyer.name>
    Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G

Sebastian Ott <sebott@linux.ibm.com>
    s390/pci: fix sleeping in atomic during hotplug

Bjørn Mork <bjorn@mork.no>
    qmi_wwan: apply SET_DTR quirk to the SIMCOM shared device ID

Colin Ian King <colin.king@canonical.com>
    staging: wilc1000: fix missing read_write setting when reading data

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66597_endpoint_disable()

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Fibocom NL678 series

Scott Chen <scott@labau.com.tw>
    USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Sameer Pujar <spujar@nvidia.com>
    ALSA: hda/tegra: clear pending irq handlers

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: use the same print format for 'without_header' tracepoints

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: fix wrong assignment for 'out_packet_without_header' tracepoint

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: fix wrong handling payload_length as payload_quadlet

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: fireface: fix for state to fetch PCM frames

Mantas Mikulėnas <grawity@gmail.com>
    ALSA: hda: add mute LED support for HP EliteBook 840 G4

Arnd Bergmann <arnd@arndb.de>
    mtd: atmel-quadspi: disallow building on ebsa110

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: emux: Fix potential Spectre v1 vulnerabilities

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: pcm: Fix potential Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: emu10k1: Fix potential Spectre v1 vulnerabilities

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: rme9652: Fix potential Spectre v1 vulnerability

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Incorrect sizing of sge for PIO will OOPs

Deepa Dinamani <deepa.kernel@gmail.com>
    sock: Make sock->sk_stamp thread-safe

Myungho Jung <mhjungk@gmail.com>
    net/smc: fix TCP fallback socket release

Jörgen Storvist <jorgen.storvist@gmail.com>
    qmi_wwan: Add support for Fibocom NL678 series

Jörgen Storvist <jorgen.storvist@gmail.com>
    qmi_wwan: Added support for Fibocom NL668 series

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: compare remote and local protocols in tipc_udp_enable()

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: use lock_sock() in tipc_sk_reinit()

Alaa Hleihel <alaa@mellanox.com>
    net/mlx5e: Remove the false indication of software timestamping support

Shalom Toledo <shalomt@mellanox.com>
    mlxsw: core: Increase timeout during firmware flash process

Tariq Toukan <tariqt@mellanox.com>
    net/mlx5e: RX, Fix wrong early return in receive queue poll

Yuval Avnery <yuvalav@mellanox.com>
    net/mlx5: Typo fix in del_sw_hw_rule

Juergen Gross <jgross@suse.com>
    xen/netfront: tolerate frags with no data

Jorgen Hansen <jhansen@vmware.com>
    VSOCK: Send reset control packet when socket is partially bound

Jason Wang <jasowang@redhat.com>
    vhost: make sure used idx is seen before log in vhost_add_used_n()

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: fix a double kfree_skb()

Eric Dumazet <edumazet@google.com>
    tcp: fix a race in inet_diag_dump_icsk()

Xin Long <lucien.xin@gmail.com>
    sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event

Jörgen Storvist <jorgen.storvist@gmail.com>
    qmi_wwan: Added support for Telit LN940 series

Cong Wang <xiyou.wangcong@gmail.com>
    ptr_ring: wrap back ->producer in __ptr_ring_swap_queue()

Willem de Bruijn <willemb@google.com>
    packet: validate address length if non-zero

Willem de Bruijn <willemb@google.com>
    packet: validate address length

Cong Wang <xiyou.wangcong@gmail.com>
    net/wan: fix a double free in x25_asy_open_tty()

Cong Wang <xiyou.wangcong@gmail.com>
    netrom: fix locking in nr_find_socket()

Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
    net: phy: Fix the issue that netif always links up after resuming

Claudiu Beznea <claudiu.beznea@microchip.com>
    net: macb: restart tx after tx used bit read

Michal Kubecek <mkubecek@suse.cz>
    net: ipv4: do not handle duplicate fragments as overlapping

Eric Dumazet <edumazet@google.com>
    isdn: fix kernel-infoleak in capi_unlocked_ioctl

Eric Dumazet <edumazet@google.com>
    ipv6: tunnels: fix two use-after-free

Cong Wang <xiyou.wangcong@gmail.com>
    ipv6: explicitly initialize udp6_addr in udp_sock_create6()

Willem de Bruijn <willemb@google.com>
    ieee802154: lowpan_header_create check must check daddr

Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
    ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    gro_cell: add napi_disable in gro_cells_destroy

Cong Wang <xiyou.wangcong@gmail.com>
    ax25: fix a use-after-free in ax25_fillin_cb()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ip6mr: Fix potential Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ipv4: Fix potential Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    net: core: Fix Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    phonet: af_phonet: Fix Spectre v1 vulnerability


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |  3 +
 Documentation/admin-guide/l1tf.rst                 |  6 +-
 Makefile                                           |  4 +-
 arch/arm64/include/asm/kvm_arm.h                   |  2 +-
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |  7 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |  3 +-
 arch/mips/include/asm/cpu-info.h                   |  2 +-
 arch/mips/include/asm/mach-generic/mmzone.h        |  2 +
 arch/mips/include/asm/mach-loongson64/mmzone.h     |  1 +
 arch/mips/include/asm/mmu.h                        |  2 +-
 arch/mips/include/asm/mmu_context.h                | 10 +--
 arch/mips/include/asm/mmzone.h                     |  8 ++
 arch/mips/include/asm/pgtable-64.h                 |  5 ++
 arch/mips/include/asm/r4kcache.h                   | 22 +++++
 arch/mips/kernel/vdso.c                            |  4 +-
 arch/mips/math-emu/dsemul.c                        | 38 +++++----
 arch/mips/mm/c-r3k.c                               |  2 +-
 arch/mips/mm/c-r4k.c                               | 44 ++++++++--
 arch/powerpc/kernel/signal_32.c                    | 20 ++++-
 arch/powerpc/kernel/signal_64.c                    | 44 +++++++---
 arch/s390/pci/pci_clp.c                            |  2 +-
 arch/x86/include/asm/kvm_host.h                    |  2 +-
 arch/x86/kernel/cpu/bugs.c                         |  3 +-
 arch/x86/kvm/vmx.c                                 |  7 +-
 arch/x86/mm/init.c                                 |  2 +-
 arch/x86/mm/init_64.c                              |  6 --
 crypto/tcrypt.c                                    |  5 ++
 crypto/testmgr.c                                   |  7 ++
 crypto/testmgr.h                                   | 76 +++++++++++++++++
 drivers/base/platform-msi.c                        |  6 +-
 drivers/char/tpm/tpm-interface.c                   | 15 ++--
 drivers/char/tpm/tpm_i2c_nuvoton.c                 | 11 ++-
 drivers/clk/rockchip/clk-rk3188.c                  |  2 +-
 drivers/crypto/cavium/nitrox/nitrox_algs.c         | 12 +--
 drivers/crypto/cavium/nitrox/nitrox_lib.c          | 22 +++--
 drivers/crypto/cavium/nitrox/nitrox_req.h          |  7 ++
 drivers/infiniband/hw/hfi1/verbs.c                 |  2 +
 drivers/input/mouse/elan_i2c_core.c                |  1 +
 drivers/isdn/capi/kcapi.c                          |  4 +-
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c      |  2 +-
 drivers/media/platform/vivid/vivid-vid-cap.c       |  2 +
 drivers/mtd/spi-nor/Kconfig                        |  2 +-
 drivers/net/ethernet/cadence/macb_main.c           | 21 ++++-
 drivers/net/ethernet/ibm/ibmveth.c                 |  6 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 12 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 10 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         | 19 ++++-
 drivers/net/ethernet/mellanox/mlxsw/core.h         |  3 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  7 +-
 drivers/net/phy/phy_device.c                       |  7 +-
 drivers/net/usb/qmi_wwan.c                         |  5 +-
 drivers/net/wan/x25_asy.c                          |  2 +
 drivers/net/xen-netfront.c                         |  2 +-
 drivers/rtc/rtc-m41t80.c                           |  2 +-
 drivers/spi/spi-bcm2835.c                          | 14 ++-
 drivers/staging/wilc1000/wilc_sdio.c               |  1 +
 drivers/tty/serial/xilinx_uartps.c                 |  4 +-
 drivers/usb/class/cdc-acm.c                        | 10 +++
 drivers/usb/class/cdc-acm.h                        |  1 +
 drivers/usb/host/r8a66597-hcd.c                    |  5 +-
 drivers/usb/serial/option.c                        |  4 +
 drivers/usb/serial/pl2303.c                        |  5 ++
 drivers/usb/serial/pl2303.h                        |  5 ++
 drivers/vhost/vhost.c                              |  2 +
 fs/btrfs/btrfs_inode.h                             |  6 ++
 fs/btrfs/extent-tree.c                             |  4 +
 fs/btrfs/inode.c                                   | 17 ++++
 fs/btrfs/tree-log.c                                | 16 ++++
 fs/cifs/smb2maperror.c                             |  4 +-
 fs/ext4/ext4.h                                     |  2 +
 fs/ext4/inline.c                                   |  5 +-
 fs/ext4/inode.c                                    |  9 +-
 fs/ext4/migrate.c                                  | 36 ++++----
 fs/ext4/resize.c                                   | 74 ++++++++--------
 fs/ext4/super.c                                    | 36 +++++++-
 fs/ext4/xattr.c                                    | 78 ++++++++---------
 fs/f2fs/super.c                                    |  6 +-
 include/linux/msi.h                                |  2 +
 include/linux/ptr_ring.h                           |  2 +
 include/net/netfilter/nf_conntrack_count.h         | 15 ++++
 include/net/sock.h                                 | 38 ++++++++-
 include/trace/events/ext4.h                        | 20 +++++
 kernel/cgroup/cgroup.c                             | 29 ++++---
 net/ax25/af_ax25.c                                 | 11 ++-
 net/ax25/ax25_dev.c                                |  2 +
 net/compat.c                                       | 15 ++--
 net/core/filter.c                                  |  2 +
 net/core/gro_cells.c                               |  1 +
 net/core/sock.c                                    |  3 +
 net/ieee802154/6lowpan/tx.c                        |  3 +
 net/ipv4/inet_diag.c                               |  4 +-
 net/ipv4/ip_fragment.c                             | 18 ++--
 net/ipv4/ipmr.c                                    |  3 +
 net/ipv6/ip6_tunnel.c                              |  1 +
 net/ipv6/ip6_udp_tunnel.c                          |  3 +-
 net/ipv6/ip6_vti.c                                 |  1 +
 net/ipv6/ip6mr.c                                   |  4 +
 net/netfilter/xt_connlimit.c                       | 99 +++++++++++++++++-----
 net/netrom/af_netrom.c                             | 15 ++--
 net/packet/af_packet.c                             |  8 +-
 net/phonet/af_phonet.c                             |  3 +
 net/sctp/ipv6.c                                    |  1 +
 net/smc/af_smc.c                                   | 14 ++-
 net/smc/smc.h                                      |  4 +
 net/sunrpc/svcsock.c                               |  2 +-
 net/tipc/socket.c                                  |  8 +-
 net/tipc/udp_media.c                               |  9 +-
 net/vmw_vsock/vmci_transport.c                     | 67 +++++++++++----
 sound/core/pcm.c                                   |  2 +
 sound/firewire/amdtp-stream-trace.h                |  4 +-
 sound/firewire/amdtp-stream.c                      |  4 +-
 sound/firewire/fireface/ff-protocol-ff400.c        |  2 +-
 sound/pci/emu10k1/emufx.c                          |  5 ++
 sound/pci/hda/hda_tegra.c                          |  2 +
 sound/pci/hda/patch_conexant.c                     |  1 +
 sound/pci/rme9652/hdsp.c                           | 10 ++-
 sound/synth/emux/emux_hwdep.c                      |  7 +-
 tools/perf/util/pmu.c                              |  8 +-
 virt/kvm/arm/vgic/vgic-mmio.c                      |  6 +-
 120 files changed, 984 insertions(+), 343 deletions(-)


