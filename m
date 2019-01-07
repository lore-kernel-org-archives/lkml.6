Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF508C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2A22183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865193;
	bh=gvSwTx8YC++xXv+gqwodACRwNEHZazWq3qgGxdxerJc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MkGsJyhtNrhAuzulceJASQ+7uwYd5dPEBhY16vXHq4a4JtUQfZX85jJcwQL+pubQn
	 QDnuYw6rhsxE7HhbGICWVb6ejNeOWGofOJxKE8SAxPVAQpfZG55G/kyyb17ZRvCB8g
	 7mvzUTG4fM/LZW/dlKN5xIGKHZhd8oLqoMeCT55s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfAGMqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:46:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfAGMqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:46:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D32D20449;
        Mon,  7 Jan 2019 12:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865189;
        bh=gvSwTx8YC++xXv+gqwodACRwNEHZazWq3qgGxdxerJc=;
        h=From:To:Cc:Subject:Date:From;
        b=RYVSBt8usMP2hD0sYV5KoWjTv+jPvmwD/NNz8HLWOkZZuqe5oc4m3Tb++3TeDx3Zo
         aGirBt589daaQzCSIqSBEndmjKmw1k5QCNc8MJL2OBE228vuKe8YChlxhx/JmCiwOR
         UEwvzK0q3KnG/1knkxcBd/K/SiOcfK2C+dxM3Y/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 000/170] 4.19.14-stable review
Date:   Mon,  7 Jan 2019 13:30:27 +0100
Message-Id: <20190107104452.953560660@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.14-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.14-rc1
X-KernelTest-Deadline: 2019-01-09T10:45+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.14 release.
There are 170 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.14-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.14-rc1

Tomas Winkler <tomas.winkler@intel.com>
    tpm: tpm_i2c_nuvoton: use correct command duration for TPM 2.x

Tomas Winkler <tomas.winkler@intel.com>
    tpm: tpm_try_transmit() refactor error flow.

Will Deacon <will.deacon@arm.com>
    arm64: compat: Avoid sending SIGILL for unallocated syscall numbers

Robin Murphy <robin.murphy@arm.com>
    iommu/arm-smmu-v3: Fix big-endian CMD_SYNC writes

Gustavo A. R. Silva <gustavo@embeddedor.com>
    KVM: arm/arm64: vgic: Fix off-by-one bug in vgic_get_irq()

Christoffer Dall <christoffer.dall@arm.com>
    KVM: arm/arm64: vgic-v2: Set active_source to 0 when restoring state

Marc Zyngier <marc.zyngier@arm.com>
    KVM: arm/arm64: vgic: Cap SPIs to the VM-defined maximum

Julien Thierry <julien.thierry@arm.com>
    KVM: arm/arm64: vgic: Do not cond_resched_lock() with IRQs disabled

Maciej W. Rozycki <macro@linux-mips.org>
    rtc: m41t80: Correct alarm month range with RTC reads

Sylwester Nawrocki <s.nawrocki@samsung.com>
    ARM: dts: exynos: Specify I2S assigned clocks in proper node

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: vgic: Force VM halt when changing the active state of GICv3 PPIs/SGIs

Will Deacon <will.deacon@arm.com>
    arm64: KVM: Avoid setting the upper 32 bits of VTCR_EL2 to 1

Paul Aurich <paul@darkrain42.org>
    smb3: fix large reads on encrypted connections

Georgy A Bystrenin <gkot@altlinux.org>
    CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock problem

Huacai Chen <chenhc@lemote.com>
    MIPS: Fix a R10000_LLSC_WAR logic in atomic.h

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

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tools lib traceevent: Fix processing of dereferenced args in bprintk events

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: v4l2-tpg: array index could become negative

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vb2: check memory model for VIDIOC_CREATE_BUFS

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: free bitmap_cap when updating std/timings/etc.

Luca Ceresoli <luca@lucaceresoli.net>
    media: imx274: fix stack corruption in imx274_read_reg

Sean Young <sean@mess.org>
    media: rc: cec devices do not have a lirc chardev

Hans Verkuil <hverkuil@xs4all.nl>
    media: cec-pin: fix broken tx_ignore_nack_until_eom error injection

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: cec: keep track of outstanding transmits

Nava kishore Manne <nava.manne@xilinx.com>
    serial: uartps: Fix interrupt mask issue to handle the RX interrupts properly

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: sanity check of xattr entry size

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    f2fs: fix validation of the block count in sanity_check_raw_super

Pan Bian <bianpan2016@163.com>
    f2fs: read page index before freeing

Dan Williams <dan.j.williams@intel.com>
    dax: Use non-exclusive wait in wait_entry_unlocked()

Matthew Wilcox <willy@infradead.org>
    dax: Don't access a freed inode

Breno Leitao <leitao@debian.org>
    powerpc/tm: Unset MSR[TS] if not recheckpointing

Breno Leitao <leitao@debian.org>
    powerpc/tm: Set MSR[TS] just prior to recheckpoint

Lyude Paul <lyude@redhat.com>
    brcmfmac: Fix out of bounds memory access during fw load

Stijn Tintel <stijn@linux-ipv6.be>
    brcmfmac: fix roamoff=1 modparam

Filipe Manana <fdmanana@suse.com>
    Btrfs: send, fix race with transaction commits that create snapshots

Josef Bacik <jbacik@fb.com>
    btrfs: run delayed items before dropping the snapshot

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix fsync of files with multiple hard links in new directories

Lu Fengqi <lufq.fnst@cn.fujitsu.com>
    btrfs: skip file_extent generation check for free_space_inode in run_delalloc_nocow

Anand Jain <anand.jain@oracle.com>
    btrfs: dev-replace: go back to suspend state if another EXCL_OP is running

Anand Jain <anand.jain@oracle.com>
    btrfs: dev-replace: go back to suspended state if target device is missing

Macpaul Lin <macpaul.lin@mediatek.com>
    cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.

Tejun Heo <tj@kernel.org>
    cgroup: fix CSS_TASK_ITER_PROCS

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
    crypto: cfb - fix decryption

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
    crypto: testmgr - add AES-CFB tests

Atul Gupta <atul.gupta@chelsio.com>
    crypto: chcr - small packet Tx stalls the queue

Wenwen Wang <wang6495@umn.edu>
    crypto: cavium/nitrox - fix a DMA pool free failure

Jernej Skrabec <jernej.skrabec@siol.net>
    clk: sunxi-ng: Use u64 for calculation of NM rate

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
    ext4: avoid declaring fs inconsistent due to invalid file handles

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

Greg Kurz <groug@kaod.org>
    ocxl: Fix endiannes bug in read_afu_name()

Greg Kurz <groug@kaod.org>
    ocxl: Fix endiannes bug in ocxl_link_update_pe()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf env: Also consider env->arch == NULL as local operation

Ben Hutchings <ben@decadent.org.uk>
    perf pmu: Suppress potential format-truncation warning

Adrian Hunter <adrian.hunter@intel.com>
    perf script: Use fallbacks for branch stacks

Adrian Hunter <adrian.hunter@intel.com>
    perf tools: Use fallback for sample_addr_correlates_sym() cases

Adrian Hunter <adrian.hunter@intel.com>
    perf thread: Add fallback functions for cases where cpumode is insufficient

Adrian Hunter <adrian.hunter@intel.com>
    perf machine: Record if a arch has a single user/kernel address space

Alexey Brodkin <alexey.brodkin@synopsys.com>
    clocksource/drivers/arc_timer: Utilize generic sched_clock

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    DRM: UDL: get rid of useless vblank initialization

Eric Anholt <eric@anholt.net>
    drm/v3d: Skip debugfs dumping GCA on platforms without GCA.

Miquel Raynal <miquel.raynal@bootlin.com>
    platform-msi: Free descriptors in platform_msi_domain_free()

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: nVMX: Free the VMREAD/VMWRITE bitmaps if alloc_kvm_area() fails

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Make VHE Stage-2 TLB invalidation operations non-interruptible

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup

Dan Williams <dan.j.williams@intel.com>
    x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()

Michal Hocko <mhocko@suse.com>
    x86/speculation/l1tf: Drop the swap storage limit restriction when l1tf=off

Patrick Dreyer <Patrick@Dreyer.name>
    Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G

Sanjeev Chugh <sanjeev_chugh@mentor.com>
    Input: atmel_mxt_ts - don't try to free unallocated kernel memory

Sebastian Ott <sebott@linux.ibm.com>
    s390/pci: fix sleeping in atomic during hotplug

Hans de Goede <hdegoede@redhat.com>
    ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromebook Gnawty

Hans de Goede <hdegoede@redhat.com>
    ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromebook Clapper

Colin Ian King <colin.king@canonical.com>
    staging: wilc1000: fix missing read_write setting when reading data

Malcolm Priestley <tvboxspy@gmail.com>
    media: dvb-usb-v2: Fix incorrect use of transfer_flags URB_FREE_BUFFER

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: roles: Add a description for the class to Kconfig

Stephan Gerhold <stephan@gerhold.net>
    Revert "usb: dwc3: pci: Use devm functions to get the phy GPIOs"

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    usb: dwc2: disable power_down on Amlogic devices

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66597_endpoint_disable()

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Fibocom NL678 series

Scott Chen <scott@labau.com.tw>
    USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Terin Stock <terin@terinstock.com>
    usb: dwc2: host: use hrtimer for NAK retries

Sameer Pujar <spujar@nvidia.com>
    ALSA: hda/tegra: clear pending irq handlers

Jian-Hong Pan <jian-hong@endlessm.com>
    ALSA: hda/realtek: Enable the headset mic auto detection for ASUS laptops

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: use the same print format for 'without_header' tracepoints

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: fix wrong assignment for 'out_packet_without_header' tracepoint

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: fix wrong handling payload_length as payload_quadlet

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: fireface: fix for state to fetch PCM frames

Wandrille RONCE <w@ndrille.fr>
    ALSA: hda/realtek: Enable audio jacks of ASUS UX391UA with ALC294

Mantas Mikulėnas <grawity@gmail.com>
    ALSA: hda: add mute LED support for HP EliteBook 840 G4

Boris Brezillon <boris.brezillon@bootlin.com>
    mtd: rawnand: omap2: Pass the parent of pdev to dma_request_chan()

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: marvell: prevent timeouts on a loaded machine

Arnd Bergmann <arnd@arndb.de>
    mtd: atmel-quadspi: disallow building on ebsa110

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Fix spectre_v2 mitigations reporting

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

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix WoL device wakeup enable

Davide Caratti <dcaratti@redhat.com>
    net: Use __kernel_clockid_t in uapi net_stamp.h

Marcin Wojtas <mw@semihalf.com>
    net: mvneta: fix operation for 64K PAGE_SIZE

Tariq Toukan <tariqt@mellanox.com>
    net/mlx5e: RX, Fix wrong early return in receive queue poll

Mikhael Goikhman <migo@mellanox.com>
    net/mlx5e: Remove unused UDP GSO remaining counter

Shalom Toledo <shalomt@mellanox.com>
    mlxsw: core: Increase timeout during firmware flash process

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Fix command number mismatch between driver and the mfw

Antoine Tenart <antoine.tenart@bootlin.com>
    net: mvpp2: fix the phylink mode validation

Moshe Shemesh <moshe@mellanox.com>
    net/mlx5e: RX, Verify MPWQE stride size is in range

Tal Gilboa <talgi@mellanox.com>
    net/mlx5e: Cancel DIM work on close SQ

Allan W. Nielsen <allan.nielsen@microchip.com>
    mscc: Configured MAC entries should be locked.

Stefano Brivio <sbrivio@redhat.com>
    ipv6: route: Fix return value of ip6_neigh_lookup() on neigh_create() error

Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
    nfp: flower: ensure TCP flags can be placed in IPv6 frame

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    net/ipv6: Fix a test against 'ipv6_find_idev()' return value

Herbert Xu <herbert@gondor.apana.org.au>
    ipv6: frags: Fix bogus skb->sk in reassembled packets

Alaa Hleihel <alaa@mellanox.com>
    net/mlx5e: Remove the false indication of software timestamping support

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: check group dests after tipc_wait_for_cond()

Yuval Avnery <yuvalav@mellanox.com>
    net/mlx5: Typo fix in del_sw_hw_rule

Juergen Gross <jgross@suse.com>
    xen/netfront: tolerate frags with no data

Jorgen Hansen <jhansen@vmware.com>
    VSOCK: Send reset control packet when socket is partially bound

Jason Wang <jasowang@redhat.com>
    vhost: make sure used idx is seen before log in vhost_add_used_n()

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: use lock_sock() in tipc_sk_reinit()

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: fix a double kfree_skb()

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: fix a double free in tipc_enable_bearer()

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: compare remote and local protocols in tipc_udp_enable()

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: check tsk->group in tipc_wait_for_cond()

Eric Dumazet <edumazet@google.com>
    tcp: fix a race in inet_diag_dump_icsk()

Deepa Dinamani <deepa.kernel@gmail.com>
    sock: Make sock->sk_stamp thread-safe

Xin Long <lucien.xin@gmail.com>
    sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event

Jörgen Storvist <jorgen.storvist@gmail.com>
    qmi_wwan: Add support for Fibocom NL678 series

Jörgen Storvist <jorgen.storvist@gmail.com>
    qmi_wwan: Added support for Telit LN940 series

Jörgen Storvist <jorgen.storvist@gmail.com>
    qmi_wwan: Added support for Fibocom NL668 series

Cong Wang <xiyou.wangcong@gmail.com>
    ptr_ring: wrap back ->producer in __ptr_ring_swap_queue()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    phonet: af_phonet: Fix Spectre v1 vulnerability

Willem de Bruijn <willemb@google.com>
    packet: validate address length if non-zero

Willem de Bruijn <willemb@google.com>
    packet: validate address length

Cong Wang <xiyou.wangcong@gmail.com>
    net/wan: fix a double free in x25_asy_open_tty()

Ganesh Goudar <ganeshgr@chelsio.com>
    net/tls: allocate tls context using GFP_ATOMIC

Dan Carpenter <dan.carpenter@oracle.com>
    net: stmmac: Fix an error code in probe()

Myungho Jung <mhjungk@gmail.com>
    net/smc: fix TCP fallback socket release

Cong Wang <xiyou.wangcong@gmail.com>
    netrom: fix locking in nr_find_socket()

Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
    net: phy: Fix the issue that netif always links up after resuming

Antoine Tenart <antoine.tenart@bootlin.com>
    net: mvpp2: 10G modes aren't supported on all ports

Claudiu Beznea <claudiu.beznea@microchip.com>
    net: macb: restart tx after tx used bit read

Michal Kubecek <mkubecek@suse.cz>
    net: ipv4: do not handle duplicate fragments as overlapping

Eric Dumazet <edumazet@google.com>
    net/hamradio/6pack: use mod_timer() to rearm timers

Gustavo A. R. Silva <gustavo@embeddedor.com>
    net: core: Fix Spectre v1 vulnerability

Eric Dumazet <edumazet@google.com>
    net: clear skb->tstamp in forwarding paths

Eric Dumazet <edumazet@google.com>
    isdn: fix kernel-infoleak in capi_unlocked_ioctl

Willem de Bruijn <willemb@google.com>
    ip: validate header length on virtual device xmit

Eric Dumazet <edumazet@google.com>
    ipv6: tunnels: fix two use-after-free

Cong Wang <xiyou.wangcong@gmail.com>
    ipv6: explicitly initialize udp6_addr in udp_sock_create6()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ipv4: Fix potential Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ip6mr: Fix potential Spectre v1 vulnerability

Willem de Bruijn <willemb@google.com>
    ieee802154: lowpan_header_create check must check daddr

Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
    ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    gro_cell: add napi_disable in gro_cells_destroy

Cong Wang <xiyou.wangcong@gmail.com>
    ax25: fix a use-after-free in ax25_fillin_cb()


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |  3 +
 Documentation/admin-guide/l1tf.rst                 |  6 +-
 Makefile                                           |  4 +-
 arch/arc/Kconfig                                   |  1 +
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  |  9 ++-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         |  9 ++-
 arch/arm64/include/asm/kvm_arm.h                   |  2 +-
 arch/arm64/include/asm/unistd.h                    |  5 +-
 arch/arm64/kernel/sys_compat.c                     |  4 +-
 arch/arm64/kvm/hyp/tlb.c                           | 35 ++++++---
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |  7 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |  3 +-
 arch/mips/include/asm/atomic.h                     |  2 +-
 arch/mips/include/asm/cpu-info.h                   |  2 +-
 arch/mips/include/asm/mach-generic/mmzone.h        |  2 +
 arch/mips/include/asm/mach-loongson64/mmzone.h     |  1 +
 arch/mips/include/asm/mmu.h                        |  2 +-
 arch/mips/include/asm/mmu_context.h                | 10 ++-
 arch/mips/include/asm/mmzone.h                     |  8 +++
 arch/mips/include/asm/pgtable-64.h                 |  5 ++
 arch/mips/include/asm/r4kcache.h                   | 22 ++++++
 arch/mips/kernel/vdso.c                            |  4 +-
 arch/mips/math-emu/dsemul.c                        | 38 +++++-----
 arch/mips/mm/c-r3k.c                               |  2 +-
 arch/mips/mm/c-r4k.c                               | 44 ++++++++++--
 arch/powerpc/kernel/security.c                     |  2 +-
 arch/powerpc/kernel/signal_32.c                    | 38 ++++++++--
 arch/powerpc/kernel/signal_64.c                    | 64 ++++++++++++-----
 arch/s390/pci/pci_clp.c                            |  2 +-
 arch/x86/include/asm/kvm_host.h                    |  2 +-
 arch/x86/kernel/cpu/bugs.c                         |  3 +-
 arch/x86/kvm/vmx.c                                 |  7 +-
 arch/x86/mm/init.c                                 |  2 +-
 arch/x86/mm/init_64.c                              |  6 --
 crypto/cfb.c                                       |  2 +-
 crypto/tcrypt.c                                    |  5 ++
 crypto/testmgr.c                                   |  7 ++
 crypto/testmgr.h                                   | 76 ++++++++++++++++++++
 drivers/base/platform-msi.c                        |  6 +-
 drivers/char/tpm/tpm-interface.c                   | 15 ++--
 drivers/char/tpm/tpm_i2c_nuvoton.c                 | 11 +--
 drivers/clk/rockchip/clk-rk3188.c                  |  2 +-
 drivers/clk/sunxi-ng/ccu_nm.c                      | 18 ++++-
 drivers/clocksource/Kconfig                        |  1 +
 drivers/clocksource/arc_timer.c                    | 22 ++++++
 drivers/crypto/cavium/nitrox/nitrox_algs.c         | 12 ++--
 drivers/crypto/cavium/nitrox/nitrox_lib.c          | 22 ++++--
 drivers/crypto/cavium/nitrox/nitrox_req.h          |  7 ++
 drivers/crypto/chelsio/chcr_ipsec.c                |  5 +-
 drivers/gpu/drm/udl/udl_main.c                     |  7 +-
 drivers/gpu/drm/v3d/v3d_debugfs.c                  | 11 +--
 drivers/infiniband/hw/hfi1/verbs.c                 |  2 +
 drivers/input/mouse/elan_i2c_core.c                |  1 +
 drivers/input/touchscreen/atmel_mxt_ts.c           |  4 +-
 drivers/iommu/arm-smmu-v3.c                        |  8 ++-
 drivers/isdn/capi/kcapi.c                          |  4 +-
 drivers/media/cec/cec-adap.c                       | 27 ++++---
 drivers/media/cec/cec-pin.c                        |  5 +-
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c      |  2 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |  3 +
 drivers/media/i2c/imx274.c                         |  7 +-
 drivers/media/platform/vivid/vivid-vid-cap.c       |  2 +
 drivers/media/rc/rc-main.c                         |  6 +-
 drivers/media/usb/dvb-usb-v2/usb_urb.c             |  5 +-
 drivers/misc/ocxl/config.c                         |  2 +-
 drivers/misc/ocxl/link.c                           |  2 +-
 drivers/mtd/nand/raw/marvell_nand.c                | 17 ++++-
 drivers/mtd/nand/raw/omap2.c                       |  2 +-
 drivers/mtd/spi-nor/Kconfig                        |  2 +-
 drivers/net/ethernet/cadence/macb_main.c           | 21 +++++-
 drivers/net/ethernet/ibm/ibmveth.c                 |  6 +-
 drivers/net/ethernet/marvell/mvneta.c              |  6 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    | 16 +++--
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 11 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  6 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 10 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  2 -
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |  2 -
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         | 19 ++++-
 drivers/net/ethernet/mellanox/mlxsw/core.h         |  3 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  7 +-
 drivers/net/ethernet/mscc/ocelot.c                 |  2 +-
 .../net/ethernet/netronome/nfp/flower/offload.c    | 28 ++++++--
 drivers/net/ethernet/qlogic/qed/qed_hsi.h          |  3 +-
 drivers/net/ethernet/realtek/r8169.c               |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  1 +
 drivers/net/hamradio/6pack.c                       | 16 ++---
 drivers/net/phy/phy_device.c                       |  7 +-
 drivers/net/usb/qmi_wwan.c                         |  3 +
 drivers/net/wan/x25_asy.c                          |  2 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 11 ++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |  2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |  2 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c         |  8 ++-
 drivers/net/xen-netfront.c                         |  2 +-
 drivers/rtc/rtc-m41t80.c                           |  2 +-
 drivers/spi/spi-bcm2835.c                          | 14 ++--
 drivers/staging/wilc1000/wilc_sdio.c               |  1 +
 drivers/tty/serial/xilinx_uartps.c                 |  4 +-
 drivers/usb/Kconfig                                |  4 --
 drivers/usb/class/cdc-acm.c                        | 10 +++
 drivers/usb/class/cdc-acm.h                        |  1 +
 drivers/usb/common/Makefile                        |  1 -
 drivers/usb/dwc2/hcd.h                             |  2 +-
 drivers/usb/dwc2/hcd_queue.c                       | 19 +++--
 drivers/usb/dwc2/params.c                          |  1 +
 drivers/usb/dwc3/dwc3-pci.c                        |  8 +--
 drivers/usb/host/r8a66597-hcd.c                    |  5 +-
 drivers/usb/roles/Kconfig                          | 13 ++++
 drivers/usb/roles/Makefile                         |  4 +-
 drivers/usb/{common/roles.c => roles/class.c}      |  0
 drivers/usb/serial/option.c                        |  4 ++
 drivers/usb/serial/pl2303.c                        |  5 ++
 drivers/usb/serial/pl2303.h                        |  5 ++
 drivers/vhost/vhost.c                              |  2 +
 fs/btrfs/btrfs_inode.h                             |  6 ++
 fs/btrfs/ctree.c                                   | 29 ++++++--
 fs/btrfs/dev-replace.c                             |  6 ++
 fs/btrfs/extent-tree.c                             |  4 ++
 fs/btrfs/inode.c                                   | 20 +++++-
 fs/btrfs/tree-log.c                                | 16 +++++
 fs/cifs/smb2maperror.c                             |  4 +-
 fs/cifs/smb2ops.c                                  |  4 +-
 fs/dax.c                                           | 69 ++++++++----------
 fs/ext4/ext4.h                                     | 17 ++++-
 fs/ext4/ialloc.c                                   |  2 +-
 fs/ext4/inline.c                                   |  5 +-
 fs/ext4/inode.c                                    | 63 +++++++++++-----
 fs/ext4/ioctl.c                                    |  2 +-
 fs/ext4/migrate.c                                  | 36 +++++-----
 fs/ext4/namei.c                                    |  4 +-
 fs/ext4/resize.c                                   | 79 ++++++++++----------
 fs/ext4/super.c                                    | 55 ++++++++++----
 fs/ext4/xattr.c                                    | 83 +++++++++++-----------
 fs/f2fs/node.c                                     |  4 +-
 fs/f2fs/super.c                                    |  6 +-
 fs/f2fs/xattr.c                                    | 18 +++--
 include/linux/msi.h                                |  2 +
 include/linux/ptr_ring.h                           |  2 +
 include/media/cec.h                                |  1 +
 include/net/ip_tunnels.h                           | 20 ++++++
 include/net/sock.h                                 | 38 +++++++++-
 include/trace/events/ext4.h                        | 20 ++++++
 include/uapi/linux/net_tstamp.h                    |  4 +-
 kernel/cgroup/cgroup.c                             | 29 ++++----
 net/ax25/af_ax25.c                                 | 11 ++-
 net/ax25/ax25_dev.c                                |  2 +
 net/compat.c                                       | 15 ++--
 net/core/filter.c                                  |  2 +
 net/core/gro_cells.c                               |  1 +
 net/core/sock.c                                    | 15 ++--
 net/ieee802154/6lowpan/tx.c                        |  3 +
 net/ipv4/inet_diag.c                               |  4 +-
 net/ipv4/ip_forward.c                              |  1 +
 net/ipv4/ip_fragment.c                             | 18 +++--
 net/ipv4/ip_gre.c                                  |  9 +++
 net/ipv4/ip_tunnel.c                               |  9 ---
 net/ipv4/ip_vti.c                                  | 12 +++-
 net/ipv4/ipmr.c                                    |  4 ++
 net/ipv6/addrconf.c                                |  4 +-
 net/ipv6/ip6_gre.c                                 | 10 ++-
 net/ipv6/ip6_output.c                              |  1 +
 net/ipv6/ip6_tunnel.c                              | 11 ++-
 net/ipv6/ip6_udp_tunnel.c                          |  3 +-
 net/ipv6/ip6_vti.c                                 |  9 +--
 net/ipv6/ip6mr.c                                   | 21 ++++--
 net/ipv6/reassembly.c                              |  1 +
 net/ipv6/route.c                                   |  4 +-
 net/ipv6/sit.c                                     |  3 +
 net/netrom/af_netrom.c                             | 15 ++--
 net/packet/af_packet.c                             |  8 ++-
 net/phonet/af_phonet.c                             |  3 +
 net/sctp/ipv6.c                                    |  1 +
 net/smc/af_smc.c                                   | 14 +++-
 net/smc/smc.h                                      |  4 ++
 net/sunrpc/svcsock.c                               |  2 +-
 net/tipc/bearer.c                                  |  1 -
 net/tipc/socket.c                                  | 40 ++++++-----
 net/tipc/udp_media.c                               |  9 ++-
 net/tls/tls_main.c                                 |  2 +-
 net/vmw_vsock/vmci_transport.c                     | 67 ++++++++++++-----
 sound/core/pcm.c                                   |  2 +
 sound/firewire/amdtp-stream-trace.h                |  4 +-
 sound/firewire/amdtp-stream.c                      |  4 +-
 sound/firewire/fireface/ff-protocol-ff400.c        |  2 +-
 sound/pci/emu10k1/emufx.c                          |  5 ++
 sound/pci/hda/hda_tegra.c                          |  2 +
 sound/pci/hda/patch_conexant.c                     |  1 +
 sound/pci/hda/patch_realtek.c                      |  3 +-
 sound/pci/rme9652/hdsp.c                           | 10 +--
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       | 14 ++++
 sound/synth/emux/emux_hwdep.c                      |  7 +-
 tools/lib/traceevent/event-parse.c                 |  1 +
 tools/perf/arch/common.c                           | 10 +++
 tools/perf/arch/common.h                           |  1 +
 tools/perf/builtin-script.c                        | 12 ++--
 tools/perf/util/env.c                              |  2 +-
 tools/perf/util/event.c                            | 29 +++++++-
 tools/perf/util/machine.c                          | 27 +++++++
 tools/perf/util/machine.h                          |  3 +
 tools/perf/util/pmu.c                              |  8 +--
 .../util/scripting-engines/trace-event-python.c    | 16 ++---
 tools/perf/util/session.c                          |  4 ++
 tools/perf/util/thread.h                           |  4 ++
 virt/kvm/arm/vgic/vgic-mmio.c                      | 44 ++++++------
 virt/kvm/arm/vgic/vgic.c                           |  6 +-
 207 files changed, 1553 insertions(+), 648 deletions(-)


