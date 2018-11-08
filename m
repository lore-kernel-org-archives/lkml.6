Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA376ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2E82146E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE1dgZA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2E82146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeKIHjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:39:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729706AbeKIHjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:39:46 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53B8208E3;
        Thu,  8 Nov 2018 22:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714535;
        bh=zqMjYrUAFU5DnUdQJl9q3muen/PmPT0b/Oyv5wCzaIU=;
        h=From:To:Cc:Subject:Date:From;
        b=hE1dgZA9zWCptbvk87LvGmzLcPD+JDse5ZpQgwbJSlg/wDGmwHEDqPOHLkujeTFSa
         jFFutoT4ql7/mDa215DqDVZsspm94zEpFu76M2Zw/n2spl2gRXjD1LY9ofvPe+Ps2d
         pa+HLxpn8PjEoGyg0cjGn2QfWoH/E7BgDWXxqcNU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 000/171] 4.9.136-stable review
Date:   Thu,  8 Nov 2018 13:49:30 -0800
Message-Id: <20181108215127.257643509@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.136-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.136-rc1
X-KernelTest-Deadline: 2018-11-10T21:51+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.136 release.
There are 171 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Nov 10 21:50:40 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.136-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.136-rc1

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Sanitize overrun handling

Christophe Leroy <christophe.leroy@c-s.fr>
    net: fs_enet: do not call phy_stop() in interrupts

Nathan Chancellor <natechancellor@gmail.com>
    x86/time: Correct the attribute on jiffies' definition

Peter Zijlstra <peterz@infradead.org>
    x86/percpu: Fix this_cpu_read()

Phil Auld <pauld@redhat.com>
    sched/fair: Fix throttle_list starvation with low CFS quota

Mikhail Nikiforov <jackxviichaos@gmail.com>
    Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM

Alan Stern <stern@rowland.harvard.edu>
    USB: fix the usbfs flag sanitization for control transfers

Gustavo A. R. Silva <gustavo@embeddedor.com>
    usb: gadget: storage: Fix Spectre v1 vulnerability

Tobias Herzog <t-herzog@gmx.de>
    cdc-acm: correct counting of UART states in serial state notification

Gustavo A. R. Silva <gustavo@embeddedor.com>
    IB/ucm: Fix Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    RDMA/ucma: Fix Spectre v1 vulnerability

Kai-Heng Feng <kai.heng.feng@canonical.com>
    drm/edid: Add 6 bpc quirk for BOE panel in HP Pavilion 15-n233sl

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ptp: fix Spectre v1 vulnerability

Al Viro <viro@zeniv.linux.org.uk>
    cachefiles: fix the race between cachefiles_bury_object() and rmdir(2)

Brian Foster <bfoster@redhat.com>
    xfs: truncate transaction does not modify the inobt

Linus Walleij <linus.walleij@linaro.org>
    gpio: mxs: Get rid of external API call

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    ahci: don't ignore result code of ahci_reset_controller()

Jia-Ju Bai <baijiaju1990@163.com>
    crypto: shash - Fix a sleep-in-atomic bug in shash_setkey_unaligned

Sasha Levin <sashal@kernel.org>
    Revert "x86/mm: Expand static page table for fixmap space"

Stefano Brivio <sbrivio@redhat.com>
    ip6_tunnel: Fix encapsulation layout

Ido Schimmel <idosch@mellanox.com>
    rtnetlink: Disallow FDB configuration for non-Ethernet device

Dimitris Michailidis <dmichail@google.com>
    net: fix pskb_trim_rcsum_slow() with odd trim offset

Cong Wang <xiyou.wangcong@gmail.com>
    net: drop skb on failure in ip_check_defrag()

Tobias Jungel <tobias.jungel@gmail.com>
    bonding: fix length of actor system

Wenwen Wang <wang6495@umn.edu>
    ethtool: fix a privilege escalation bug

Jason Wang <jasowang@redhat.com>
    vhost: Fix Spectre V1 vulnerability

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

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    perf tools: Disable parallelism for 'make clean'

Sasha Levin <sashal@kernel.org>
    Revert "netfilter: ipv6: nf_defrag: drop skb dst before queueing"

Kimmo Rautkoski <ext-kimmo.rautkoski@vaisala.com>
    mtd: spi-nor: Add support for is25wp series chips

Khazhismel Kumykov <khazhy@google.com>
    fs/fat/fatent.c: add cond_resched() to fat_count_free_clusters()

Arthur Kiyanovski <akiyano@amazon.com>
    net: ena: fix NULL dereference due to untimely napi initialization

David Howells <dhowells@redhat.com>
    rxrpc: Only take the rwind and mtu values from latest ACK

David Howells <dhowells@redhat.com>
    rxrpc: Don't check RXRPC_CALL_TX_LAST after calling rxrpc_rotate_tx_window()

Sascha Hauer <s.hauer@pengutronix.de>
    ARM: dts: imx53-qsb: disable 1.2GHz OPP

Sandipan Das <sandipan@linux.ibm.com>
    perf tests: Fix indexing when invoking subtests

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix USB3 NULL pointer dereference at logical disconnect.

Daniel Mack <daniel@zonque.org>
    libertas: call into generic suspend code before turning off power

Christophe Jaillet <christophe.jaillet@wanadoo.fr>
    IB/mlx4: Fix an error handling path in 'mlx4_ib_rereg_user_mr()'

Dan Carpenter <dan.carpenter@oracle.com>
    x86/paravirt: Fix some warning messages

Phil Reid <preid@electromag.com.au>
    iio: buffer: fix the function signature to match implementation

Daniel Verkamp <daniel.verkamp@intel.com>
    nvmet: fix space padding in serial number

Andreas Born <futur.andy@googlemail.com>
    bonding: ratelimit failed speed/duplex update warning

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: do not overwrite error code

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen-netfront: Fix mismatched rtnl_unlock

David S. Miller <davem@davemloft.net>
    sparc64: Fix regression in pmdp_invalidate().

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen-netfront: Update features after registering netdev

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on other arches

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Fix incorrect usage of IS_REACHABLE()

Jiri Slaby <jslaby@suse.cz>
    futex: futex_wake_op, do not fail on invalid op

Geert Uytterhoeven <geert@linux-m68k.org>
    cifs: Use ULL suffix for 64-bit constant

Jiri Olsa <jolsa@kernel.org>
    perf/core: Fix locking for children siblings group read

Sabrina Dubroca <sd@queasysnail.net>
    macsec: fix memory leaks when skb_to_sgvec fails

James Chapman <jchapman@katalix.com>
    l2tp: remove configurable payload offset

Geert Uytterhoeven <geert@linux-m68k.org>
    iio: pressure: zpa2326: Remove always-true check which confuses gcc

Arnd Bergmann <arnd@arndb.de>
    module: fix DEBUG_SET_MODULE_RONX typo

Ben Hutchings <ben.hutchings@codethink.co.uk>
    drm/msm: Fix possible null dereference on failure of get_pages()

Filipe Manana <fdmanana@suse.com>
    Btrfs: incremental send, fix invalid memory access

Alex Estrin <alex.estrin@intel.com>
    Revert "IB/ipoib: Update broadcast object if PKey value was changed in index 0"

Anjali Singhai Jain <anjali.singhai@intel.com>
    i40e: avoid NVM acquire deadlock during NVM update

Gabriel Krisman Bertazi <krisman@collabora.co.uk>
    drm: bochs: Don't remove uninitialized fbdev framebuffer

Ben Hutchings <ben.hutchings@codethink.co.uk>
    scsi: qla2xxx: Avoid double completion of abort command

Noa Osherovich <noaos@mellanox.com>
    IB/mlx5: Avoid passing an invalid QP type to firmware

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mm/frame_vector.c: release a semaphore in 'get_vaddr_frames()'

Josef Bacik <jbacik@fb.com>
    nbd: only set MSG_MORE when we have more to send

Doug Ledford <dledford@redhat.com>
    IB/rxe: put the pool on allocation failure

Alex Vesker <valex@mellanox.com>
    IB/ipoib: Fix lockdep issue found on ipoib_ib_dev_heavy_flush

Sabrina Dubroca <sd@queasysnail.net>
    ipv6: fix cleanup ordering for ip6_mr failure

Kalle Valo <kvalo@qca.qualcomm.com>
    ath10k: convert warning about non-existent OTP board id to debug message

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - No loopback on ALC299 codec

Xin Long <lucien.xin@gmail.com>
    sctp: use right member as the param of list_for_each_entry

Bjørn Mork <bjorn@mork.no>
    net: cdc_ncm: GetNtbFormat endian fix

Eric Ren <zren@suse.com>
    ocfs2: fix deadlock caused by recursive locking in xattr

Mintz, Yuval <Yuval.Mintz@cavium.com>
    qed: Warn PTT usage by wrong hw-function

Hans de Goede <hdegoede@redhat.com>
    iio: adc: Revert "axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL register modifications"

Dag Moxnes <dag.moxnes@oracle.com>
    rds: ib: Fix missing call to rds_ib_dev_put in rds_ib_setup_qp

Aditya Shankar <aditya.shankar@microchip.com>
    staging: wilc1000: Fix problem with wrong vif index

Michael S. Tsirkin <mst@redhat.com>
    ptr_ring: fix up after recent ptr_ring changes

Andrzej Pietrasiewicz <andrzej.p@samsung.com>
    clk: samsung: Fix m2m scaler clock on Exynos542x

Vignesh R <vigneshr@ti.com>
    usb: dwc3: omap: remove IRQ_NOAUTOEN used with shared irq

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: renesas_usbhs: gadget: fix unused-but-set-variable warning

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: renesas_usbhs: gadget: fix spin_lock_init() for &uep->lock

Moshe Shemesh <moshe@mellanox.com>
    net/mlx5: Fix health work queue spin lock to IRQ safe

Björn Töpel <bjorn.topel@intel.com>
    perf probe: Fix probe definition for inlined functions

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf evsel: Fix probing of precise_ip level for default cycles event

Gal Pressman <galp@mellanox.com>
    net/mlx5: Fix driver load error flow when firmware is stuck

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    ip6_tunnel: Correct tos value in collect_md mode

Talat Batheesh <talatb@mellanox.com>
    net/mlx5e: Fix fixpoint divide exception in mlx5e_am_stats_compare

Al Viro <viro@zeniv.linux.org.uk>
    ufs: we need to sync inode before freeing it

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: clear EXTENT_DEFRAG bits in finish_ordered_io

Colin Ian King <colin.king@canonical.com>
    net: stmmac: ensure jumbo_frm error return is correctly checked for -ve value

Eric Biggers <ebiggers@google.com>
    elevator: fix truncation of icq_cache_name

Marek Vasut <marex@denx.de>
    gpu: ipu-v3: Fix CSI selection for VDIC

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    ARM: 8677/1: boot/compressed: fix decompressor header layout for v7-M

Christian Sünkenberg <christian.suenkenberg@student.kit.edu>
    x86/cpu/cyrix: Add alternative Device ID of Geode GX1 SoC

Chopra, Manish <Manish.Chopra@cavium.com>
    qlcnic: Fix tunnel offload for 82xx adapters

Thor Thayer <thor.thayer@linux.intel.com>
    net: ethernet: stmmac: Fix altr_tse_pcs SGMII Initialization

Tejun Heo <tj@kernel.org>
    libata: fix error checking in in ata_parse_force_one()

Johannes Berg <johannes.berg@intel.com>
    mac80211: fix TX aggregation start/stop callback race

Jane Chu <jane.chu@oracle.com>
    arch/sparc: increase CONFIG_NODES_SHIFT on SPARC64 to 5

Shreyas NC <shreyas.nc@intel.com>
    ASoC: Intel: Skylake: Fix to parse consecutive string tkns in manifest

Jeremy Linton <lintonrjeremy@gmail.com>
    reset: hi6220: Set module license so that it can be loaded

Arvind Yadav <arvind.yadav.cs@gmail.com>
    ata: sata_rcar: Handle return value of clk_prepare_enable

Qu Wenruo <quwenruo@cn.fujitsu.com>
    btrfs: fiemap: Cache and merge fiemap extent before submit it to user

Phil Elwell <phil@raspberrypi.org>
    ARM: dts: bcm283x: Reserve first page for firmware

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    ath10k: fix NAPI enable/disable symmetry for AHB interface

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Don't use rtnl lock to protect link change logic in workqueue.

Ying Xue <ying.xue@windriver.com>
    tipc: fix a race condition of releasing subscriber object

Bob Peterson <rpeterso@redhat.com>
    tipc: Fix tipc_sk_reinit handling of -EAGAIN

Moshe Shemesh <moshe@mellanox.com>
    net/mlx5: Fix command completion after timeout access invalid structure

Zhao Qiang <qiang.zhao@nxp.com>
    net: phy: marvell: Limit 88m1101 autoneg errata to 88E1145 as well.

Max Gurtovoy <maxg@mellanox.com>
    nvme-pci: fix CMB sysfs file removal in reset path

Jia-Ju Bai <baijiaju1990@163.com>
    rxe: Fix a sleep-in-atomic bug in post_one_send

Dan Carpenter <dan.carpenter@oracle.com>
    orangefs: off by ones in xattr size checks

Noa Osherovich <noaos@mellanox.com>
    IB/core: Fix the validations of a multicast LID in attach or detach operations

Alaa Hleihel <alaa@mellanox.com>
    IB/ipoib: Do not warn if IPoIB debugfs doesn't exist

Lee, Chun-Yi <joeyli.kernel@gmail.com>
    platform/x86: acer-wmi: setup accelerometer when ACPI device was found

Xin Long <lucien.xin@gmail.com>
    ipv6: set rt6i_protocol properly in the route when it is installed

Bjorn Helgaas <bhelgaas@google.com>
    efi/fb: Correct PCI_STD_RESOURCE_END usage

Stefan Wahren <stefan.wahren@i2se.com>
    i2c: bcm2835: Avoid possible NULL ptr dereference

Dongdong Liu <liudongdong3@huawei.com>
    PCI: Disable MSI for HiSilicon Hip06/Hip07 only in Root Port mode

Prarit Bhargava <prarit@redhat.com>
    ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs

Christian Grönke <c.groenke@infodas.de>
    igb: Remove superfluous reset to PHY and page 0 selection

Sheng Yong <shengyong1@huawei.com>
    f2fs: fix multiple f2fs_add_link() having same name for inline dentry

Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
    scsi: aacraid: Fix typo in blink status

Matt Redfearn <matt.redfearn@imgtec.com>
    MIPS: Handle non word sized instructions when examining frame

Matt Redfearn <matt.redfearn@imgtec.com>
    MIPS: microMIPS: Fix decoding of swsp16 instruction

zhong jiang <zhongjiang@huawei.com>
    mm/memory_hotplug.c: fix overflow in test_pages_in_a_zone()

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
    perf symbols: Fix memory corruption because of zero length symbols

Wenwen Wang <wang6495@umn.edu>
    net: cxgb3_main: fix a missing-check bug

Maciej W. Rozycki <macro@linux-mips.org>
    declance: Fix continuation with the adapter identification message

Rickard x Andersson <rickaran@axis.com>
    net: fec: fix rare tx timeout

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on SKX

Jiri Olsa <jolsa@redhat.com>
    perf/ring_buffer: Prevent concurent ring buffer access

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

Nathan Chancellor <natechancellor@gmail.com>
    qed: Avoid constant logical operation warning in qed_vf_pf_acquire

Nathan Chancellor <natechancellor@gmail.com>
    qed: Avoid implicit enum conversion in qed_roce_mode_to_flavor

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

Sean Tranchetti <stranche@codeaurora.org>
    xfrm: validate template mode

Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    ARM: 8799/1: mm: fix pci_ioremap_io() offset check

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

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    xfrm6: call kfree_skb when skb is toobig

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Validate address prefix lengths in the xfrm selector.


-------------

Diffstat:

 Documentation/kernel-parameters.txt                |   1 -
 Makefile                                           |   4 +-
 arch/arm/boot/compressed/efi-header.S              |   4 +-
 arch/arm/boot/compressed/head.S                    |  17 +--
 arch/arm/boot/dts/bcm283x.dtsi                     |   5 +
 arch/arm/boot/dts/bcm63138.dtsi                    |  14 ++-
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |  11 ++
 arch/arm/mm/ioremap.c                              |   2 +-
 arch/mips/include/uapi/asm/inst.h                  |   2 +-
 arch/mips/kernel/process.c                         |  11 +-
 arch/sparc/Kconfig                                 |   8 +-
 arch/sparc/mm/tlb.c                                |  19 ++-
 arch/x86/events/intel/uncore_snbep.c               |  12 +-
 arch/x86/include/asm/fixmap.h                      |  10 --
 arch/x86/include/asm/percpu.h                      |   8 +-
 arch/x86/include/asm/pgtable_64.h                  |   3 +-
 arch/x86/kernel/cpu/cyrix.c                        |   1 +
 arch/x86/kernel/head_64.S                          |  16 +--
 arch/x86/kernel/paravirt.c                         |   4 +-
 arch/x86/kernel/time.c                             |   2 +-
 arch/x86/mm/pgtable.c                              |   9 --
 arch/x86/xen/mmu.c                                 |   8 +-
 crypto/shash.c                                     |   2 +-
 drivers/acpi/sysfs.c                               |  26 ++---
 drivers/ata/ahci.c                                 |   5 +-
 drivers/ata/libata-core.c                          |   2 +-
 drivers/ata/sata_rcar.c                            |  15 ++-
 drivers/block/nbd.c                                |   6 +-
 drivers/clk/samsung/clk-exynos5420.c               |   2 +-
 drivers/gpio/gpio-mxs.c                            |   4 +-
 drivers/gpu/drm/bochs/bochs_fbdev.c                |   9 +-
 drivers/gpu/drm/drm_edid.c                         |   3 +
 drivers/gpu/drm/msm/msm_gem.c                      |  20 ++--
 drivers/gpu/ipu-v3/ipu-common.c                    |  15 +--
 drivers/i2c/busses/i2c-bcm2835.c                   |   4 +-
 drivers/iio/adc/axp288_adc.c                       |  32 +++++-
 drivers/iio/pressure/zpa2326.c                     |  10 +-
 drivers/infiniband/core/ucm.c                      |   3 +
 drivers/infiniband/core/ucma.c                     |   3 +
 drivers/infiniband/core/verbs.c                    |  44 ++++++-
 drivers/infiniband/hw/mlx4/mr.c                    |   7 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   7 +-
 drivers/infiniband/sw/rxe/rxe_pool.c               |  16 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   9 +-
 drivers/infiniband/ulp/ipoib/ipoib_fs.c            |   2 -
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |  20 +---
 drivers/input/mouse/elan_i2c_core.c                |   1 +
 drivers/mtd/spi-nor/spi-nor.c                      |   6 +
 drivers/net/bonding/bond_main.c                    |   7 +-
 drivers/net/bonding/bond_netlink.c                 |   3 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   9 +-
 drivers/net/ethernet/amd/declance.c                |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  25 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   4 +
 drivers/net/ethernet/cadence/macb.c                |   1 +
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |  17 +++
 drivers/net/ethernet/cisco/enic/enic_main.c        |   9 +-
 drivers/net/ethernet/freescale/fec_main.c          |   8 +-
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |  16 ++-
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h   |   1 +
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  98 ++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   2 -
 drivers/net/ethernet/intel/igb/e1000_82575.c       |  12 --
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c |   6 +
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_hw.c           |   7 ++
 drivers/net/ethernet/qlogic/qed/qed_roce.c         |  15 +--
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |   1 -
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |  26 ++++-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   2 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |   2 +
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |   2 +
 drivers/net/ethernet/realtek/r8169.c               |   8 +-
 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c |   6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   2 +-
 drivers/net/macsec.c                               |   2 +
 drivers/net/phy/marvell.c                          |   2 +-
 drivers/net/usb/asix_common.c                      |   3 +
 drivers/net/usb/ax88179_178a.c                     |   3 +
 drivers/net/usb/cdc_ncm.c                          |   4 +-
 drivers/net/usb/lan78xx.c                          |  17 +--
 drivers/net/usb/r8152.c                            |   3 +
 drivers/net/usb/smsc75xx.c                         |   3 +
 drivers/net/usb/smsc95xx.c                         |   3 +
 drivers/net/usb/sr9800.c                           |   3 +
 drivers/net/wireless/ath/ath10k/ahb.c              |   2 +-
 drivers/net/wireless/ath/ath10k/core.c             |   3 +-
 drivers/net/wireless/mac80211_hwsim.c              |   3 +-
 drivers/net/wireless/marvell/libertas/if_sdio.c    |   4 +
 drivers/net/xen-netfront.c                         |  11 +-
 drivers/nvme/host/pci.c                            |  18 ++-
 drivers/nvme/target/admin-cmd.c                    |   1 +
 drivers/pci/quirks.c                               |   2 +-
 drivers/platform/x86/acer-wmi.c                    |   9 +-
 drivers/ptp/ptp_chardev.c                          |   4 +
 drivers/reset/hisilicon/hi6220_reset.c             |   2 +
 drivers/scsi/aacraid/src.c                         |   2 +-
 drivers/scsi/qla2xxx/qla_init.c                    |   4 +-
 drivers/soc/fsl/qbman/qman.c                       |   3 +
 drivers/soc/fsl/qe/ucc.c                           |   2 +-
 drivers/staging/wilc1000/linux_wlan.c              |   3 +-
 drivers/usb/class/cdc-acm.c                        |  14 +--
 drivers/usb/core/devio.c                           |   4 +-
 drivers/usb/dwc3/dwc3-omap.c                       |  18 ++-
 drivers/usb/gadget/function/f_mass_storage.c       |   3 +
 drivers/usb/host/xhci-hub.c                        |   2 +-
 drivers/usb/renesas_usbhs/mod_gadget.c             |   7 +-
 drivers/vhost/vhost.c                              |   2 +
 drivers/video/fbdev/efifb.c                        |   2 +-
 drivers/video/fbdev/pxa168fb.c                     |   6 +-
 fs/btrfs/extent_io.c                               | 124 +++++++++++++++++++-
 fs/btrfs/inode.c                                   |   2 +-
 fs/btrfs/send.c                                    |   7 +-
 fs/cachefiles/namei.c                              |   2 +-
 fs/cifs/inode.c                                    |   2 +-
 fs/f2fs/dir.c                                      |  13 +--
 fs/fat/fatent.c                                    |   1 +
 fs/ocfs2/dlmglue.c                                 |   4 +
 fs/ocfs2/xattr.c                                   |  23 ++--
 fs/orangefs/xattr.c                                |   6 +-
 fs/ufs/inode.c                                     |   1 +
 fs/xfs/libxfs/xfs_trans_resv.c                     |   9 +-
 include/linux/elevator.h                           |   2 +-
 include/linux/iio/buffer-dma.h                     |   2 +-
 include/linux/posix-timers.h                       |   4 +-
 init/main.c                                        |   2 +-
 kernel/events/core.c                               |   7 ++
 kernel/futex.c                                     |  12 +-
 kernel/sched/fair.c                                |  22 +++-
 kernel/sched/sched.h                               |   2 +
 kernel/time/posix-cpu-timers.c                     |   2 +-
 kernel/time/posix-timers.c                         |  29 +++--
 lib/test_bpf.c                                     |   2 +-
 mm/frame_vector.c                                  |   6 +-
 mm/memory_hotplug.c                                |   4 +-
 net/bluetooth/mgmt.c                               |   7 +-
 net/bluetooth/smp.c                                |  29 ++++-
 net/bluetooth/smp.h                                |   3 +-
 net/bridge/br_multicast.c                          |   9 +-
 net/core/datagram.c                                |   5 +-
 net/core/ethtool.c                                 |   8 +-
 net/core/rtnetlink.c                               |  10 ++
 net/core/skbuff.c                                  |   5 +-
 net/ipv4/ip_fragment.c                             |  12 +-
 net/ipv4/udp.c                                     |  20 +++-
 net/ipv6/addrconf.c                                |   6 +-
 net/ipv6/af_inet6.c                                |   6 +-
 net/ipv6/ip6_checksum.c                            |  20 +++-
 net/ipv6/ip6_tunnel.c                              |  14 +--
 net/ipv6/mcast.c                                   |  16 +--
 net/ipv6/ndisc.c                                   |   3 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   2 -
 net/ipv6/route.c                                   |  11 +-
 net/ipv6/xfrm6_output.c                            |   2 +
 net/l2tp/l2tp_core.c                               |  14 +--
 net/l2tp/l2tp_core.h                               |   3 -
 net/l2tp/l2tp_debugfs.c                            |   4 +-
 net/l2tp/l2tp_netlink.c                            |   3 -
 net/llc/llc_conn.c                                 |   1 +
 net/mac80211/agg-tx.c                              | 128 +++++++++------------
 net/mac80211/ht.c                                  |  16 ++-
 net/mac80211/ieee80211_i.h                         |  14 +--
 net/mac80211/iface.c                               |  11 +-
 net/mac80211/sta_info.h                            |   2 +
 net/mac80211/status.c                              |   7 +-
 net/mac80211/tdls.c                                |   8 +-
 net/mac80211/tx.c                                  |   2 +-
 net/rds/ib_cm.c                                    |   3 +-
 net/rxrpc/input.c                                  |  54 +++++----
 net/sched/sch_gred.c                               |   2 +-
 net/sctp/socket.c                                  |  11 +-
 net/socket.c                                       |  11 +-
 net/tipc/socket.c                                  |   6 +-
 net/tipc/subscr.c                                  |   2 +
 net/wireless/nl80211.c                             |   1 +
 net/wireless/reg.c                                 |   1 +
 net/wireless/scan.c                                |  58 ++++++++--
 net/xfrm/xfrm_user.c                               |  15 +++
 sound/pci/hda/patch_realtek.c                      |   5 +-
 sound/soc/intel/skylake/skl-topology.c             |   2 +-
 tools/perf/Makefile                                |   4 +-
 tools/perf/tests/builtin-test.c                    |   4 +-
 tools/perf/tests/task-exit.c                       |   2 +-
 tools/perf/util/annotate.c                         |  12 +-
 tools/perf/util/evsel.c                            |  12 ++
 tools/perf/util/probe-event.c                      |   2 +-
 tools/virtio/ringtest/ptr_ring.c                   |  29 ++++-
 191 files changed, 1177 insertions(+), 687 deletions(-)


