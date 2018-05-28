Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939604AbeE1PAN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034272AbeE1K0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:26:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 000/329] 4.9.104-stable review
Date: Mon, 28 May 2018 11:58:49 +0200
Message-Id: <20180528100241.796630982@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.104-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.104-rc1
X-KernelTest-Deadline: 2018-05-30T10:03+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.104 release.
There are 329 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May 30 10:00:51 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.104-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.104-rc1

Randy Dunlap <rdunlap@infradead.org>
    kdb: make "mdr" command repeat

Bjorn Andersson <bjorn.andersson@linaro.org>
    pinctrl: msm: Use dynamic GPIO numbering

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    regulator: of: Add a missing 'of_node_put()' in an error handling path of 'of_regulator_match()'

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    ARM: dts: porter: Fix HDMI output routing

Aapo Vienamo <aapo@tuxera.com>
    ARM: dts: imx7d: cl-som-imx7: fix pinctrl_enet

Charles Keepax <ckeepax@opensource.cirrus.com>
    regmap: Correct comparison in regmap_cached

Richard Haines <richard_c_haines@btinternet.com>
    netlabel: If PF_INET6, check sk_buff ip header version

Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
    selftests/net: fixes psock_fanout eBPF test case

Jiri Olsa <jolsa@redhat.com>
    perf report: Fix memory corruption in --branch-history mode --branch-history

Jiri Olsa <jolsa@kernel.org>
    perf tests: Use arch__compare_symbol_names to compare symbols

Baoquan He <bhe@redhat.com>
    x86/apic: Set up through-local-APIC mode on the boot CPU if 'noapic' specified

Ørjan Eide <orjan.eide@arm.com>
    drm/rockchip: Respect page offset for PRIME mmap calls

Joe Perches <joe@perches.com>
    MIPS: Octeon: Fix logging messages with spurious periods after newlines

Takeshi Kihara <takeshi.kihara.df@renesas.com>
    pinctrl: sh-pfc: r8a7796: Fix MOD_SEL register pin assignment for SSI pins group

Tejun Heo <tj@kernel.org>
    rcu: Call touch_nmi_watchdog() while printing stall warnings

Richard Guy Briggs <rgb@redhat.com>
    audit: return on memory error to avoid null pointer dereference

Stefan Wahren <stefan.wahren@i2se.com>
    ARM: dts: bcm283x: Fix probing of bcm2835-i2s

Jan Kara <jack@suse.cz>
    udf: Provide saner default for invalid uid / gid

Thomas Vincent-Cross <me@tvc.id.au>
    PCI: Add function 1 DMA alias quirk for Marvell 88SE9220

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: Reorder cpufreq_online() error code path

Niklas Cassel <niklas.cassel@axis.com>
    net: stmmac: ensure that the MSS desc is the last desc to set the own bit

Niklas Cassel <niklas.cassel@axis.com>
    net: stmmac: ensure that the device has released ownership before reading data

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    dmaengine: qcom: bam_dma: get num-channels and num-ees from dt

lionel.debieve@st.com <lionel.debieve@st.com>
    hwrng: stm32 - add reset during probe

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: enable rq before updating rq descriptors

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    dmaengine: rcar-dmac: Check the done lists in rcar_dmac_chan_get_residue()

Qi Hou <qi.hou@windriver.com>
    dmaengine: pl330: fix a race condition in case of threaded irqs

Takashi Iwai <tiwai@suse.de>
    ALSA: vmaster: Propagate slave error

Ivan Gorinov <ivan.gorinov@intel.com>
    x86/devicetree: Fix device IRQ settings in DT

Ivan Gorinov <ivan.gorinov@intel.com>
    x86/devicetree: Initialize device tree before using it

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix fallocate chunk size

Bjorn Andersson <bjorn.andersson@linaro.org>
    soc: qcom: wcnss_ctrl: Fix increment in NV upload

Ilia Lin <ilialin@codeaurora.org>
    arm64: dts: qcom: Fix SPI5 config on MSM8996

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel: Fix event update for auto-reload

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel: Fix large period handling on Broadwell CPUs

Maurizio Lombardi <mlombard@redhat.com>
    cdrom: do not call check_disk_change() inside cdrom_open()

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel: Properly save/restore the PMU state in the NMI handler

Guenter Roeck <linux@roeck-us.net>
    hwmon: (pmbus/adm1275) Accept negative page register values

Guenter Roeck <linux@roeck-us.net>
    hwmon: (pmbus/max8688) Accept negative page register values

Eric Anholt <eric@anholt.net>
    drm/panel: simple: Fix the bus format for the Ontat panel

Peter Zijlstra <peterz@infradead.org>
    perf/core: Fix perf_output_read_group()

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to check extent cache in f2fs_drop_extent_tree

Mathieu Malaterre <malat@debian.org>
    powerpc: Add missing prototype for arch_irq_work_raise()

Kamlakant Patel <kamlakant.patel@cavium.com>
    ipmi_ssif: Fix kernel panic at msg_done_handler

Rafael J. Wysocki <rjw@rjwysocki.net>
    PCI: Restore config space on runtime resume despite being unbound

Mathias Kresin <dev@kresin.me>
    MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset

Christophe Jaillet <christophe.jaillet@wanadoo.fr>
    spi: bcm-qspi: fIX some error handling paths

Christophe Jaillet <christophe.jaillet@wanadoo.fr>
    regulator: gpio: Fix some error handling paths in 'gpio_regulator_probe()'

Parav Pandit <parav@mellanox.com>
    IB/core: Honor port_num while resolving GID for IB link layer

Thomas Richter <tmricht@linux.vnet.ibm.com>
    perf stat: Fix core dump when flag T is used

Yisheng Xie <xieyisheng1@huawei.com>
    perf top: Fix top.call-graph config option reading

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: lapic: stop advertising DIRECTED_EOI when in-kernel IOAPIC is in use

Gregory CLEMENT <gregory.clement@bootlin.com>
    i2c: mv64xxx: Apply errata delay only in standard mode

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4: Fix queue free path of ULD drivers

Seunghun Han <kkamagui@gmail.com>
    ACPICA: acpi: acpica: fix acpi operand cache leak in nseval.c

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: Events: add a return on failure from acpi_hw_register_read

Coly Li <colyli@suse.de>
    bcache: quit dc->writeback_thread when BCACHE_DEV_DETACHING is set

Michael Schmitz <schmitzmic@gmail.com>
    zorro: Set up z->dev.dma_mask for the DMA API

Chunyu Hu <chuhu@redhat.com>
    cpufreq: cppc_cpufreq: Fix cppc_cpufreq_init() failure path

Philipp Puschmann <pp@emlix.com>
    arm: dts: socfpga: fix GIC PPI warning

Jay Vosburgh <jay.vosburgh@canonical.com>
    virtio-net: Fix operstate for virtio when no VIRTIO_NET_F_STATUS

Petr Vorel <pvorel@suse.cz>
    ima: Fallback to the builtin hash algorithm

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4: Setup FW queues before registering netdev

Karthikeyan Periyasamy <periyasa@codeaurora.org>
    ath10k: Fix kernel panic while using worker (ath10k_sta_rc_update_wk)

Leon Romanovsky <leonro@mellanox.com>
    net/mlx5: Protect from command bit overflow

Michael Ellerman <mpe@ellerman.id.au>
    selftests: Print the test we're running to /dev/kmsg

Frank Asseg <frank.asseg@objecthunter.net>
    tools/thermal: tmon: fix for segfault

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/perf: Fix kernel address leak via sampling registers

Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
    powerpc/perf: Prevent kernel address leak to userspace via BHRB buffer

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775) Fix writing pwmX_mode

Helge Deller <deller@gmx.de>
    parisc/pci: Switch LBA PCI bus from Hard Fail to Soft Fail mode

Greg Ungerer <gerg@linux-m68k.org>
    m68k: set dma and coherent masks for platform FEC ethernets

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mpic: Check if cpu_possible() in mpic_physmask()

Lenny Szubowicz <lszubowi@redhat.com>
    ACPI: acpi_pad: Fix memory leak in power saving threads

Aaro Koskinen <aaro.koskinen@iki.fi>
    drivers: macintosh: rack-meter: really fix bogus memsets

Dan Carpenter <dan.carpenter@oracle.com>
    xen/acpi: off by one in read_acpi_id()

David Howells <dhowells@redhat.com>
    rxrpc: Don't treat call aborts as conn aborts

David Howells <dhowells@redhat.com>
    rxrpc: Fix Tx ring annotation after initial Tx failure

Jeff Mahoney <jeffm@suse.com>
    btrfs: fix lockdep splat in btrfs_alloc_subvolume_writers

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix copy_items() return value when logging an inode

Qu Wenruo <wqu@suse.com>
    btrfs: tests/qgroup: Fix wrong tree backref level

Florian Fainelli <f.fainelli@gmail.com>
    net: bgmac: Fix endian access in bgmac_dma_tx_ring_free()

David S. Miller <davem@davemloft.net>
    sparc64: Make atomic_xchg() an inline function rather than a macro.

David Howells <dhowells@redhat.com>
    fscache: Fix hanging wait on page discarded by writeback

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: VMX: raise internal error for exception during invalid protected mode state

Davidlohr Bueso <dave@stgolabs.net>
    sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP warning

Jun Piao <piaojun@huawei.com>
    ocfs2/dlm: don't handle migrate lockres if already in shutdown

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix possible softlock on single core machines

Liu Bo <bo.liu@linux.alibaba.com>
    Btrfs: fix NULL pointer dereference in log_dir_items

Liu Bo <bo.liu@linux.alibaba.com>
    Btrfs: bail out on error during replay_dir_deletes

Huang Ying <ying.huang@intel.com>
    mm: fix races between address_space dereference and free in page_evicatable

Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
    mm/ksm: fix interaction with THP

Esben Haabendal <eha@deif.com>
    dp83640: Ensure against premature access to PHY registers after reset

Shunyong Yang <shunyong.yang@hxt-semitech.com>
    cpufreq: CPPC: Initialize shared perf capabilities of CPUs

Carlos Maiolino <cmaiolino@redhat.com>
    Force log to disk before reading the AGF during a fstrim

Jens Axboe <axboe@kernel.dk>
    sr: get/drop reference to device in revalidate and check_events

Tom Abraham <tabraham@suse.com>
    swap: divide-by-zero when zero length swap file on ssd

Danilo Krummrich <danilokrummrich@dk-develop.de>
    fs/proc/proc_sysctl.c: fix potential page fault while unregistering sysctl table

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm: Do not forbid _PAGE_RW before init for __ro_after_init

Joerg Roedel <joro@8bytes.org>
    x86/pgtable: Don't set huge PUD/PMD on non-leaf entries

Johannes Thumshirn <jthumshirn@suse.de>
    nvme: don't send keep-alives to the discovery controller

Rich Felker <dalias@libc.org>
    sh: fix debug trap failure to process signals before return to user

Yelena Krivosheev <yelena@marvell.com>
    net: mvneta: fix enable of all initialized RXQs

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    net: Fix untag for vlan packets without ethernet header

Vinayak Menon <vinmenon@codeaurora.org>
    mm/kmemleak.c: wait for scan completion before disabling free

Jan Kiszka <jan.kiszka@siemens.com>
    builddeb: Fix header package regarding dtc source links

Cong Wang <xiyou.wangcong@gmail.com>
    llc: properly handle dev_queue_xmit() return value

Stephane Eranian <eranian@google.com>
    perf/x86/intel: Fix linear IP of PEBS real_ip on Haswell and later CPUs

Pawel Dembicki <paweldembicki@gmail.com>
    net: qmi_wwan: add BroadMobi BM806U 2020:2033

Jinbum Park <jinb.park7@gmail.com>
    ARM: 8748/1: mm: Define vdso_start, vdso_end as array

Linus Lüssing <linus.luessing@c0d3.blue>
    batman-adv: fix packet loss for broadcasted DHCP packets to a server

Linus Lüssing <linus.luessing@c0d3.blue>
    batman-adv: fix multicast-via-unicast transmission with AP isolation

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add a testcase for probepoint

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add a testcase for string type with kprobe_event

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add probe event argument syntax testcase

David Rientjes <rientjes@google.com>
    mm, thp: do not cause memcg oom for thp

Yisheng Xie <xieyisheng1@huawei.com>
    mm/mempolicy.c: avoid use uninitialized preferred_node

Dan Carpenter <dan.carpenter@oracle.com>
    macsec: missing dev_put() on error in macsec_newlink()

Kalderon, Michal <Michal.Kalderon@cavium.com>
    RDMA/qedr: Fix rc initialization on CNQ allocation failure

Kalderon, Michal <Michal.Kalderon@cavium.com>
    RDMA/qedr: fix QP's ack timeout configuration

Chien Tin Tung <chien.tin.tung@intel.com>
    RDMA/ucma: Correct option size check using optlen

Nicolas Pitre <nicolas.pitre@linaro.org>
    kbuild: make scripts/adjust_autoksyms.sh robust against timestamp races

Stefan Wahren <stefan.wahren@i2se.com>
    brcmfmac: Fix check for ISO3166 code

Song Liu <songliubraving@fb.com>
    perf/cgroup: Fix child event counting bug

Stefano Brivio <sbrivio@redhat.com>
    vti4: Don't override MTU passed on link creation via IFLA_MTU

Stefano Brivio <sbrivio@redhat.com>
    vti4: Don't count header length twice on tunnel setup

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix skbuff rcsum on packet reroute

Matthias Schiffer <mschiffer@universe-factory.net>
    batman-adv: fix header size check in batadv_dbg_arp()

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    net: Fix vlan untag for bridge and vlan_dev with reorder_hdr off

Rob Herring <robh@kernel.org>
    microblaze: switch to NO_BOOTMEM

Lucas Stach <l.stach@pengutronix.de>
    drm/imx: move arming of the vblank event to atomic_flush

Cathy Zhou <Cathy.Zhou@Oracle.COM>
    sunvnet: does not support GSO for sctp

Sabrina Dubroca <sd@queasysnail.net>
    ipv4: lock mtu in fnhe when received PMTU < net.ipv4.route.min_pmtu

Arvind Yadav <arvind.yadav.cs@gmail.com>
    workqueue: use put_device() instead of kfree()

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Check valid VNIC ID in bnxt_hwrm_vnic_set_tpa().

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: fix erroneous reject of last rule

Gregory CLEMENT <gregory.clement@bootlin.com>
    dmaengine: mv_xor_v2: Fix clock resource by adding a register clock

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery

Arvind Yadav <arvind.yadav.cs@gmail.com>
    xen: xenbus: use put_device() instead of kfree()

Parav Pandit <parav@mellanox.com>
    IB/core: Fix possible crash to access NULL netdev

Jeremy Linton <jeremy.linton@arm.com>
    net: smsc911x: Fix unload crash when link is up

Hemanth Puranik <hpuranik@codeaurora.org>
    net: qcom/emac: Use proper free methods during TX

Denis Kirjanov <kda@linux-powerpc.org>
    fsl/fman: avoid sleeping in atomic context while adding an address

Peter Malone <peter.malone@gmail.com>
    fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().

Dan Carpenter <dan.carpenter@oracle.com>
    IB/mlx5: Fix an error code in __mlx5_ib_modify_qp()

Jack M <jackm@dev.mellanox.co.il>
    IB/mlx4: Include GID type when deleting GIDs from HW table under RoCE

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Fix corruption of RoCEv2 IPv4 GIDs

Kalderon, Michal <Michal.Kalderon@cavium.com>
    RDMA/qedr: Fix iWARP write and send with immediate

Kalderon, Michal <Michal.Kalderon@cavium.com>
    RDMA/qedr: Fix kernel panic when running fio over NFSoRDMA

Davidlohr Bueso <dave@stgolabs.net>
    ia64/err-inject: Use get_user_pages_fast()

Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
    e1000e: allocate ring descriptors with dma_zalloc_coherent

Benjamin Poirier <bpoirier@suse.com>
    e1000e: Fix check_for_link return value with autoneg off

Linus Lüssing <linus.luessing@c0d3.blue>
    batman-adv: Fix multicast packet loss with a single WANT_ALL_IPV4/6 flag

Jayachandran C <jnair@caviumnetworks.com>
    watchdog: sbsa: use 32-bit read for WCV

Igor Pylypiv <igor.pylypiv@gmail.com>
    watchdog: f71808e_wdt: Fix magic close handling

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: mvm: fix TX of CCMP 256

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Fix VRMA initialization with 2MB or 1GB memory backing

Michael Ellerman <mpe@ellerman.id.au>
    selftests/powerpc: Skip the subpage_prot tests if the syscall is unavailable

Filipe Manana <fdmanana@suse.com>
    Btrfs: send, fix issuing write op when processing hole in no data mode

Giulio Benetti <giulio.benetti@micronovasrl.com>
    drm/sun4i: Fix dclk_set_phase

Roger Pau Monne <roger.pau@citrix.com>
    xen/pirq: fix error path cleanup when binding MSIs

Max Gurtovoy <maxg@mellanox.com>
    nvmet: fix PSDT field check in command format

Joey Pabalinas <joeypabalinas@gmail.com>
    net/tcp/illinois: replace broken algorithm reference link

Claudiu Manoil <claudiu.manoil@nxp.com>
    gianfar: Fix Rx byte accounting for ndev stats

Guenter Roeck <linux@roeck-us.net>
    powerpc/boot: Fix random libfdt related build errors

Florian Fainelli <f.fainelli@gmail.com>
    ARM: dts: NSP: Fix amount of RAM on BCM958625HR

Xin Long <lucien.xin@gmail.com>
    sit: fix IFLA_MTU ignored on NEWLINK

Xin Long <lucien.xin@gmail.com>
    ip6_tunnel: fix IFLA_MTU ignored on NEWLINK

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix kcrashes with fio in RAID5 backend dev

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    dmaengine: rcar-dmac: fix max_chunk_size for R-Car Gen3

Dave Airlie <airlied@redhat.com>
    virtio-gpu: fix ioctl and expose the fixed status to userspace.

Eric Dumazet <edumazet@google.com>
    r8152: fix tx packets accounting

Ramon Fried <rfried@codeaurora.org>
    qrtr: add MODULE_ALIAS macro to smd

David S. Miller <davem@davemloft.net>
    ARM: orion5x: Revert commit 4904dbda41c8.

Chengguang Xu <cgxu519@icloud.com>
    ceph: fix dentry leak when failing to init debugfs

Colin Ian King <colin.king@canonical.com>
    clocksource/drivers/fsl_ftm_timer: Fix error return checking

Jianchao Wang <jianchao.w.wang@oracle.com>
    nvme-pci: Fix nvme queue cleanup if IRQ setup fails

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix netlink dumping of BLA backbones

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix netlink dumping of BLA claims

Sven Eckelmann <sven.eckelmann@openmesh.com>
    batman-adv: Ignore invalid batadv_v_gw during netlink send

Sven Eckelmann <sven.eckelmann@openmesh.com>
    batman-adv: Ignore invalid batadv_iv_gw during netlink send

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: convert BUG_ONs to WARN_ONs

Matthias Schiffer <mschiffer@universe-factory.net>
    batman-adv: invalidate checksum on fragment reassembly

Matthias Schiffer <mschiffer@universe-factory.net>
    batman-adv: fix packet checksum in receive path

Yufen Yu <yuyufen@huawei.com>
    md/raid1: fix NULL pointer dereference

BingJing Chang <bingjingc@synology.com>
    md: fix a potential deadlock of raid5/raid10 reshape

Will Deacon <will.deacon@arm.com>
    fs: dcache: Use READ_ONCE when accessing i_dir_seq

Will Deacon <will.deacon@arm.com>
    fs: dcache: Avoid livelock between d_alloc_parallel and __d_add

Sebastian Ott <sebott@linux.vnet.ibm.com>
    kvm: fix warning for CONFIG_HAVE_KVM_EVENTFD builds

Alexey Kodanev <alexey.kodanev@oracle.com>
    macvlan: fix use-after-free in macvlan_common_newlink()

Pratyush Anand <panand@redhat.com>
    arm64: fix unwind_frame() for filtered out fn for function graph tracing

Felix Fietkau <nbd@nbd.name>
    mac80211: drop frames with unexpected DS bits from fast-rx to slow path

Samuel Neves <sneves@dei.uc.pt>
    x86/topology: Update the 'cpu cores' field in /proc/cpuinfo correctly across CPU hotplug operations

Andrea Parri <parri.andrea@gmail.com>
    locking/xchg/alpha: Fix xchg() and cmpxchg() memory ordering bugs

Randy Dunlap <rdunlap@infradead.org>
    integrity/security: fix digsig.c build error with header file

Johannes Berg <johannes.berg@intel.com>
    regulatory: add NUL to request alpha2

Eric Dumazet <edumazet@google.com>
    smsc75xx: fix smsc75xx_set_features()

Tony Lindgren <tony@atomide.com>
    ARM: OMAP: Fix dmtimer init for omap1

Eric Biggers <ebiggers@google.com>
    PKCS#7: fix direct verification of SignerInfo signature

Sebastian Ott <sebott@linux.vnet.ibm.com>
    s390/cio: clear timer when terminating driver I/O

Sebastian Ott <sebott@linux.vnet.ibm.com>
    s390/cio: fix return code after missing interrupt

Sebastian Ott <sebott@linux.vnet.ibm.com>
    s390/cio: fix ccw_device_start_timeout API

Mark Lord <mlord@pobox.com>
    powerpc/bpf/jit: Fix 32-bit JIT for seccomp_data access

David Rientjes <rientjes@google.com>
    kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE

Arnd Bergmann <arnd@arndb.de>
    md: raid5: avoid string overflow warning

Andrea Parri <parri.andrea@gmail.com>
    locking/xchg/alpha: Add unconditional memory barrier to cmpxchg()

Markus Elfring <elfring@users.sourceforge.net>
    drm/exynos: g2d: Delete an error message for a failed memory allocation in two functions

Wolfram Sang <wsa+renesas@sang-engineering.com>
    drm/exynos: fix comparison to bitshift when dealing with a mask

Arnd Bergmann <arnd@arndb.de>
    drm/exynos: g2d: use monotonic timestamps

Yufen Yu <yuyufen@huawei.com>
    md raid10: fix NULL deference in handle_write_completed()

Ilan Peer <ilan.peer@intel.com>
    mac80211: Do not disconnect on invalid operating class

Sara Sharon <sara.sharon@intel.com>
    mac80211: fix calling sleeping function in atomic context

Sara Sharon <sara.sharon@intel.com>
    mac80211: fix a possible leak of station stats

Felix Fietkau <nbd@nbd.name>
    mac80211: round IEEE80211_TX_STATUS_HEADROOM up to multiple of 4

David Howells <dhowells@redhat.com>
    rxrpc: Work around usercopy check

Kees Cook <keescook@chromium.org>
    NFC: llcp: Limit size of SDP URI

Naftali Goldstein <naftali.goldstein@intel.com>
    iwlwifi: mvm: always init rs with 20mhz bandwidth rates

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: mvm: fix security bug in PN checking

Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
    ibmvnic: Free RX socket buffer in case of adapter error

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: OMAP1: clock: Fix debugfs_create_*() usage

Tony Lindgren <tony@atomide.com>
    ARM: OMAP3: Fix prm wake interrupt for resume

Qi Hou <qi.hou@windriver.com>
    ARM: OMAP2+: timer: fix a kmemleak caused in omap_get_timer_dt

Anders Roxell <anders.roxell@linaro.org>
    selftests: memfd: add config fragment for fuse

Naresh Kamboju <naresh.kamboju@linaro.org>
    selftests: pstore: Adding config fragment CONFIG_PSTORE_RAM=m

Dong Bo <dongbo4@huawei.com>
    libata: Fix compile warning with ATA_DEBUG enabled

Jason Wang <jasowang@redhat.com>
    ptr_ring: prevent integer overflow when calculating size

Ulf Magnusson <ulfalizer@gmail.com>
    ARC: Fix malformed ARC_EMUL_UNALIGNED default

Mark Salter <msalter@redhat.com>
    irqchip/gic-v3: Change pr_debug message to pr_devel

Michael Kelley <mhkelley@outlook.com>
    cpumask: Make for_each_cpu_wrap() available on UP as well

Stephen Boyd <sboyd@codeaurora.org>
    irqchip/gic-v3: Ignore disabled ITS nodes

Will Deacon <will.deacon@arm.com>
    locking/qspinlock: Ensure node->count is updated before initialising node

Jia Zhang <zhang.jia@linux.alibaba.com>
    vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when dumping vsyscall user page

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix rlimit in reuseport net selftest

Jesper Dangaard Brouer <brouer@redhat.com>
    tools/libbpf: handle issues with bpf ELF objects containing .eh_frames

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: return attach error when no cache set exist

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix for data collapse after re-attaching an attached device

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix for allocator and register thread race

Coly Li <colyli@suse.de>
    bcache: properly set task state in bch_writeback_thread()

Arnd Bergmann <arnd@arndb.de>
    cifs: silence compiler warnings showing up with gcc-8.0.0

Alexey Dobriyan <adobriyan@gmail.com>
    proc: fix /proc/*/map_files lookup

Will Deacon <will.deacon@arm.com>
    arm64: spinlock: Fix theoretical trylock() A-B-A with LSE atomics

Guanglei Li <guanglei.li@oracle.com>
    RDS: IB: Fix null pointer issue

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen/grant-table: Use put_page instead of free_page

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen-netfront: Fix race between device setup and open

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS

James Hogan <jhogan@kernel.org>
    MIPS: generic: Fix machine compatible matching

Yonghong Song <yhs@fb.com>
    bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y

Hans de Goede <hdegoede@redhat.com>
    ACPI / scan: Use acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs

Chen Yu <yu.c.chen@intel.com>
    ACPI: processor_perflib: Do not send _PPC change notification if not ready

Jean Delvare <jdelvare@suse.de>
    firmware: dmi_scan: Fix handling of empty DMI strings

Arnd Bergmann <arnd@arndb.de>
    x86/power: Fix swsusp_arch_resume prototype

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    netfilter: ipv6: nf_defrag: Kill frag queue on RFC2460 failure

Karol Herbst <kherbst@redhat.com>
    drm/nouveau/pmu/fuc: don't use movw directly anymore

Alex Estrin <alex.estrin@intel.com>
    IB/ipoib: Fix for potential no-carrier state

Ed Swierk <eswierk@skyportsystems.com>
    openvswitch: Remove padding from packet before L3+ conntrack processing

shidao.ytt <shidao.ytt@alibaba-inc.com>
    mm/fadvise: discard partial page if endbyte is also EOF

Mel Gorman <mgorman@techsingularity.net>
    mm: pin address_space before dereferencing it while isolating an LRU page

Yang Shi <yang.s@alibaba-inc.com>
    mm: thp: use down_read_trylock() in khugepaged to avoid long block

Nitin Gupta <nitin.m.gupta@oracle.com>
    sparc64: update pmdp_invalidate() to return old pmd value

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    asm-generic: provide generic_pmdp_establish()

Yisheng Xie <xieyisheng1@huawei.com>
    mm/mempolicy: add nodes_empty check in SYSC_migrate_pages

Yisheng Xie <xieyisheng1@huawei.com>
    mm/mempolicy: fix the check of nodemask from user

piaojun <piaojun@huawei.com>
    ocfs2: return error when we attempt to access a dirty bh in jbd2

piaojun <piaojun@huawei.com>
    ocfs2/acl: use 'ip_xattr_sem' to protect getting extended attribute

piaojun <piaojun@huawei.com>
    ocfs2: return -EROFS to mount.ocfs2 if inode block is invalid

KarimAllah Ahmed <karahmed@amazon.de>
    kvm: Map PFN-type memory regions as writable (if possible)

Gustavo A. R. Silva <gustavo@embeddedor.com>
    tcp_nv: fix potential integer overflow in tcpnv_acked

Andy Spencer <aspencer@spacex.com>
    gianfar: prevent integer wrapping in the rx handler

Logan Gunthorpe <logang@deltatee.com>
    ntb_transport: Fix bug with max_mw_size parameter

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Avoid memory leak in case of XRCD dealloc failure

Michael Bringmann <mwb@linux.vnet.ibm.com>
    powerpc/numa: Ensure nodes initialized for hotplug

Michael Bringmann <mwb@linux.vnet.ibm.com>
    powerpc/numa: Use ibm,max-associativity-domains to discover possible nodes

Jake Daryll Obina <jake.obina@gmail.com>
    jffs2: Fix use-after-free bug in jffs2_iget()'s error handling path

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    device property: Define type of PROPERTY_ENRTY_*() macros

Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
    fm10k: fix "failed to kill vid" message for VF

Dan Carpenter <dan.carpenter@oracle.com>
    HID: roccat: prevent an out of bounds read in kovaplus_profile_activated()

Anand Jain <Anand.Jain@oracle.com>
    btrfs: fail mount when sb flag is not in BTRFS_SUPER_FLAG_SUPP

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix scrub to repair raid6 corruption

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix out of bounds access in btrfs_search_slot

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: set plug for fsync

Wei Yongjun <weiyongjun1@huawei.com>
    ipmi/powernv: Fix error return code in ipmi_powernv_probe()

weiyongjun (A) <weiyongjun1@huawei.com>
    mac80211_hwsim: fix possible memory leak in hwsim_new_radio_nl()

Ulf Magnusson <ulfalizer@gmail.com>
    kconfig: Fix expr_free() E_NOT leak

Ulf Magnusson <ulfalizer@gmail.com>
    kconfig: Fix automatic menu creation mem leak

Ulf Magnusson <ulfalizer@gmail.com>
    kconfig: Don't leak main menus during parsing

Guenter Roeck <linux@roeck-us.net>
    watchdog: sp5100_tco: Fix watchdog disable bit

Jan Chochol <jan@chochol.info>
    nfs: Do not convert nfs_idmap_cache_timeout to jiffies

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    net: stmmac: dwmac-meson8b: propagate rate changes to the parent clock

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    net: stmmac: dwmac-meson8b: fix setting the RGMII TX clock on Meson8b

mulhern <amulhern@redhat.com>
    dm thin: fix documentation relative to low water mark threshold

Peter Xu <peterx@redhat.com>
    iommu/vt-d: Use domain instead of cache fetching

Thomas Richter <tmricht@linux.vnet.ibm.com>
    perf record: Fix failed memory allocation for get_cpuid_str

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tools lib traceevent: Fix get_field_str() for dynamic strings

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf callchain: Fix attr.sample_max_stack setting

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tools lib traceevent: Simplify pointer print logic and fix %pF

Shiraz Saleem <shiraz.saleem@intel.com>
    i40iw: Zero-out consumer key on allocate stag for FMR

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: psmouse - fix Synaptics detection when protocol is disabled

Alex Williamson <alex.williamson@redhat.com>
    PCI: Add function 1 DMA alias quirk for Marvell 9128

Anna-Maria Gleixner <anna-maria@linutronix.de>
    tracing/hrtimer: Fix tracing bugs by taking all clock bases and modes into account

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    netfilter: ipv6: nf_defrag: Pass on packets to stack per RFC2460

Paolo Bonzini <pbonzini@redhat.com>
    kvm: x86: fix KVM_XEN_HVM_CONFIG ioctl

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Use IS_REACHABLE() for dependency on input

NeilBrown <neilb@suse.com>
    NFSv4: always set NFS_LOCK_LOST when a lock is lost.

Peter Zijlstra <peterz@infradead.org>
    x86/tsc: Allow TSC calibration without PIT

Hector Martin <marcan@marcan.st>
    firewire-ohci: work around oversized DMA reads on JMicron controllers

Jim Mattson <jmattson@google.com>
    kvm: x86: IA32_ARCH_CAPABILITIES is always supported

Wei Huang <wei@redhat.com>
    KVM: x86: Update cpuid properly when CR4.OSXAVE or CR4.PKE is changed

David Hildenbrand <david@redhat.com>
    KVM: s390: vsie: fix < 8k check for the itdba

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    KVM/VMX: Expose SSBD properly to guests

zhongjiang <zhongjiang@huawei.com>
    kernel/signal.c: avoid undefined behaviour in kill_something_info

Gustavo A. R. Silva <gustavo@embeddedor.com>
    kernel/sys.c: fix potential Spectre v1 issue

David Hildenbrand <david@redhat.com>
    kasan: fix memory hotplug during boot

Davidlohr Bueso <dave@stgolabs.net>
    ipc/shm: fix shmat() nil address after round-down when remapping

Davidlohr Bueso <dave@stgolabs.net>
    Revert "ipc/shm: Fix shmat mmap nil-page protection"

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Use after free race condition in send context error path

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix 32-bit VMW_PORT_HB_[IN|OUT] macros

Joe Jin <joe.jin@oracle.com>
    xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    libata: blacklist Micron 500IT SSD with MU01 firmware

Tejun Heo <tj@kernel.org>
    libata: Blacklist some Sandisk SSDs for NCQ

Corneliu Doban <corneliu.doban@broadcom.com>
    mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register

Srinath Mannam <srinath.mannam@broadcom.com>
    mmc: sdhci-iproc: remove hard coded mmc cap 1.8v

Al Viro <viro@zeniv.linux.org.uk>
    do d_instantiate/unlock_new_inode combinations safely

Ben Hutchings <ben.hutchings@codethink.co.uk>
    ALSA: timer: Fix pause event notification

Al Viro <viro@zeniv.linux.org.uk>
    aio: fix io_destroy(2) vs. lookup_ioctx() race

Al Viro <viro@zeniv.linux.org.uk>
    affs_lookup(): close a race with affs_remove_link()

Colin Ian King <colin.king@canonical.com>
    KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"

Maciej W. Rozycki <macro@mips.com>
    MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32 FGRs

Maciej W. Rozycki <macro@mips.com>
    MIPS: ptrace: Expose FIR register through FP regset

NeilBrown <neil@brown.name>
    MIPS: c-r4k: Fix data corruption related to cache coherence


-------------

Diffstat:

 Documentation/device-mapper/thin-provisioning.txt  |    8 +-
 .../devicetree/bindings/dma/mv-xor-v2.txt          |    6 +-
 Makefile                                           |    4 +-
 arch/alpha/include/asm/xchg.h                      |   30 +-
 arch/arc/Kconfig                                   |    1 -
 arch/arm/boot/dts/bcm283x.dtsi                     |    4 +-
 arch/arm/boot/dts/bcm958625hr.dts                  |    2 +-
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            |   52 +-
 arch/arm/boot/dts/r8a7791-porter.dts               |    2 +-
 arch/arm/boot/dts/socfpga.dtsi                     |    2 +-
 arch/arm/include/asm/vdso.h                        |    2 -
 arch/arm/kernel/vdso.c                             |   12 +-
 arch/arm/mach-omap1/clock.c                        |    6 +-
 arch/arm/mach-omap2/pm.c                           |    4 +-
 arch/arm/mach-omap2/timer.c                        |   19 +-
 arch/arm/mach-orion5x/Kconfig                      |    3 -
 arch/arm/mach-orion5x/dns323-setup.c               |   53 +-
 arch/arm/mach-orion5x/tsx09-common.c               |   49 +-
 arch/arm/plat-omap/dmtimer.c                       |    7 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |    4 +-
 arch/arm64/include/asm/spinlock.h                  |    4 +-
 arch/arm64/include/asm/stacktrace.h                |    2 +-
 arch/arm64/kernel/cpu_errata.c                     |    4 +-
 arch/arm64/kernel/stacktrace.c                     |    5 +
 arch/arm64/kernel/time.c                           |    2 +-
 arch/ia64/kernel/err_inject.c                      |    2 +-
 arch/m68k/coldfire/device.c                        |   12 +-
 arch/microblaze/Kconfig                            |    1 +
 arch/microblaze/mm/init.c                          |   56 +-
 arch/mips/cavium-octeon/octeon-irq.c               |   10 +-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |    2 +-
 arch/mips/include/asm/machine.h                    |    2 +-
 arch/mips/kernel/ptrace.c                          |   22 +-
 arch/mips/kernel/ptrace32.c                        |    4 +-
 arch/mips/kvm/mips.c                               |    2 +-
 arch/mips/mm/c-r4k.c                               |    9 +-
 arch/mips/txx9/rbtx4939/setup.c                    |    4 +-
 arch/powerpc/boot/Makefile                         |    3 +-
 arch/powerpc/include/asm/irq_work.h                |    1 +
 arch/powerpc/kvm/book3s_hv.c                       |   12 +-
 arch/powerpc/mm/numa.c                             |   78 +-
 arch/powerpc/net/bpf_jit_comp.c                    |    3 +
 arch/powerpc/perf/core-book3s.c                    |   25 +
 arch/powerpc/sysdev/mpic.c                         |    2 +-
 arch/s390/kvm/vsie.c                               |    2 +-
 arch/sh/kernel/entry-common.S                      |    2 +-
 arch/sparc/include/asm/atomic_64.h                 |    6 +-
 arch/sparc/include/asm/pgtable_64.h                |    2 +-
 arch/sparc/mm/tlb.c                                |   23 +-
 arch/x86/events/core.c                             |   15 +-
 arch/x86/events/intel/core.c                       |   12 +-
 arch/x86/events/intel/ds.c                         |  117 ++-
 arch/x86/events/perf_event.h                       |    2 +-
 arch/x86/include/asm/i8259.h                       |    5 +
 arch/x86/kernel/apic/apic.c                        |    2 +-
 arch/x86/kernel/devicetree.c                       |   21 +-
 arch/x86/kernel/smpboot.c                          |    1 +
 arch/x86/kernel/tsc.c                              |   18 +
 arch/x86/kvm/cpuid.c                               |    7 +-
 arch/x86/kvm/lapic.c                               |   10 +-
 arch/x86/kvm/vmx.c                                 |   20 +-
 arch/x86/kvm/x86.c                                 |   12 +-
 arch/x86/mm/init_64.c                              |    3 +-
 arch/x86/mm/pageattr.c                             |    6 +-
 arch/x86/mm/pgtable.c                              |    9 +
 arch/x86/power/hibernate_32.c                      |    2 +-
 arch/x86/power/hibernate_64.c                      |    2 +-
 crypto/asymmetric_keys/pkcs7_trust.c               |    1 +
 drivers/acpi/acpi_pad.c                            |    3 +
 drivers/acpi/acpica/evevent.c                      |    9 +-
 drivers/acpi/acpica/nseval.c                       |    8 +
 drivers/acpi/processor_perflib.c                   |    2 +-
 drivers/acpi/scan.c                                |   20 +-
 drivers/ata/libata-core.c                          |    6 +
 drivers/ata/libata-scsi.c                          |    2 +-
 drivers/base/regmap/regmap.c                       |    2 +-
 drivers/block/paride/pcd.c                         |    2 +
 drivers/cdrom/cdrom.c                              |    3 -
 drivers/cdrom/gdrom.c                              |    3 +
 drivers/char/hw_random/stm32-rng.c                 |    9 +
 drivers/char/ipmi/ipmi_powernv.c                   |    5 +-
 drivers/char/ipmi/ipmi_ssif.c                      |    4 +-
 drivers/clocksource/fsl_ftm_timer.c                |    2 +-
 drivers/cpufreq/cppc_cpufreq.c                     |   23 +-
 drivers/cpufreq/cpufreq.c                          |    6 +-
 drivers/dma/mv_xor_v2.c                            |   25 +-
 drivers/dma/pl330.c                                |    6 +-
 drivers/dma/qcom/bam_dma.c                         |   27 +-
 drivers/dma/sh/rcar-dmac.c                         |   11 +-
 drivers/firewire/ohci.c                            |    8 +-
 drivers/firmware/dmi_scan.c                        |   22 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   12 +-
 drivers/gpu/drm/exynos/regs-fimc.h                 |    2 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c                   |    5 +
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gf100.fuc3.h   |  746 +++++++--------
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gk208.fuc5.h   |  802 ++++++++--------
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gt215.fuc3.h   | 1006 ++++++++++----------
 .../gpu/drm/nouveau/nvkm/subdev/pmu/fuc/memx.fuc   |   30 +-
 drivers/gpu/drm/panel/panel-simple.c               |    2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |    7 +-
 drivers/gpu/drm/sun4i/sun4i_dotclock.c             |    5 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |   17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h                |   25 +-
 drivers/hid/hid-roccat-kovaplus.c                  |    2 +
 drivers/hwmon/nct6775.c                            |   10 +-
 drivers/hwmon/pmbus/adm1275.c                      |    4 +-
 drivers/hwmon/pmbus/max8688.c                      |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |    8 +-
 drivers/ide/ide-cd.c                               |    2 +
 drivers/infiniband/core/multicast.c                |   26 +-
 drivers/infiniband/core/sa_query.c                 |    7 +-
 drivers/infiniband/core/ucma.c                     |    2 +-
 drivers/infiniband/hw/hfi1/chip.c                  |    4 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |    1 +
 drivers/infiniband/hw/mlx4/main.c                  |   11 +-
 drivers/infiniband/hw/mlx5/qp.c                    |    9 +-
 drivers/infiniband/hw/qedr/main.c                  |    3 +-
 drivers/infiniband/hw/qedr/verbs.c                 |   38 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |    3 +
 drivers/input/mouse/psmouse-base.c                 |   34 +-
 drivers/iommu/intel-iommu.c                        |    3 +-
 drivers/irqchip/irq-gic-v3-its-pci-msi.c           |    2 +
 drivers/irqchip/irq-gic-v3-its-platform-msi.c      |    2 +
 drivers/irqchip/irq-gic-v3-its.c                   |    2 +
 drivers/irqchip/irq-gic-v3.c                       |    2 +-
 drivers/macintosh/rack-meter.c                     |    4 +-
 drivers/md/bcache/alloc.c                          |    4 +-
 drivers/md/bcache/bcache.h                         |    2 +-
 drivers/md/bcache/btree.c                          |    9 +-
 drivers/md/bcache/request.c                        |    2 +-
 drivers/md/bcache/super.c                          |   23 +-
 drivers/md/bcache/sysfs.c                          |   11 +-
 drivers/md/bcache/writeback.c                      |   27 +-
 drivers/md/md.c                                    |   13 +
 drivers/md/raid1.c                                 |   11 +
 drivers/md/raid10.c                                |   14 +-
 drivers/md/raid5.c                                 |   15 +-
 drivers/mmc/host/sdhci-iproc.c                     |   31 +-
 drivers/net/ethernet/broadcom/bgmac.c              |    3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    3 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   11 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c     |    1 +
 drivers/net/ethernet/cisco/enic/enic_main.c        |   10 +-
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |    2 +-
 drivers/net/ethernet/freescale/gianfar.c           |   16 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |    1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |    2 +-
 drivers/net/ethernet/intel/e1000e/mac.c            |    2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    4 +-
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c    |   14 +-
 drivers/net/ethernet/marvell/mvneta.c              |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |    2 +-
 drivers/net/ethernet/qualcomm/emac/emac-mac.c      |   23 +-
 drivers/net/ethernet/smsc/smsc911x.c               |    4 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |    6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   14 +-
 drivers/net/ethernet/sun/sunvnet.c                 |    2 +-
 drivers/net/macsec.c                               |    5 +-
 drivers/net/macvlan.c                              |    2 +-
 drivers/net/phy/dp83640.c                          |   18 +
 drivers/net/usb/qmi_wwan.c                         |    1 +
 drivers/net/usb/r8152.c                            |    2 +-
 drivers/net/usb/smsc75xx.c                         |    7 +-
 drivers/net/virtio_net.c                           |    2 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   10 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    4 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |   28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   39 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    7 +-
 drivers/net/wireless/mac80211_hwsim.c              |    4 +-
 drivers/net/xen-netfront.c                         |   46 +-
 drivers/ntb/ntb_transport.c                        |    3 +
 drivers/nvme/host/fabrics.c                        |    4 +-
 drivers/nvme/host/pci.c                            |    5 +-
 drivers/nvme/target/core.c                         |    9 +-
 drivers/parisc/lba_pci.c                           |   20 +-
 drivers/pci/pci-driver.c                           |   17 +-
 drivers/pci/quirks.c                               |    5 +
 drivers/pinctrl/qcom/pinctrl-msm.c                 |    2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |   40 +-
 drivers/regulator/gpio-regulator.c                 |   16 +-
 drivers/regulator/of_regulator.c                   |    1 +
 drivers/s390/cio/device_fsm.c                      |    7 +-
 drivers/s390/cio/device_ops.c                      |   72 +-
 drivers/s390/cio/io_sch.h                          |    1 +
 drivers/scsi/sr.c                                  |   21 +-
 drivers/soc/qcom/wcnss_ctrl.c                      |    2 +-
 drivers/spi/spi-bcm-qspi.c                         |    4 +-
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |    2 +
 drivers/video/fbdev/sbuslib.c                      |    4 +-
 drivers/watchdog/f71808e_wdt.c                     |    3 +-
 drivers/watchdog/sbsa_gwdt.c                       |    3 +-
 drivers/watchdog/sp5100_tco.h                      |    2 +-
 drivers/xen/events/events_base.c                   |    4 +-
 drivers/xen/grant-table.c                          |    4 +-
 drivers/xen/swiotlb-xen.c                          |    2 +-
 drivers/xen/xen-acpi-processor.c                   |    6 +-
 drivers/xen/xenbus/xenbus_probe.c                  |    5 +-
 drivers/zorro/zorro.c                              |   12 +
 fs/affs/namei.c                                    |   10 +-
 fs/aio.c                                           |    4 +-
 fs/btrfs/ctree.c                                   |   12 +-
 fs/btrfs/disk-io.c                                 |    8 +-
 fs/btrfs/extent-tree.c                             |    1 +
 fs/btrfs/file.c                                    |    9 +
 fs/btrfs/inode.c                                   |   16 +-
 fs/btrfs/raid56.c                                  |   18 +-
 fs/btrfs/send.c                                    |    3 +
 fs/btrfs/tests/qgroup-tests.c                      |    2 +-
 fs/btrfs/tree-log.c                                |   12 +-
 fs/btrfs/volumes.c                                 |    9 +-
 fs/ceph/super.c                                    |   16 +-
 fs/cifs/cifssmb.c                                  |    4 +-
 fs/dcache.c                                        |   32 +-
 fs/ecryptfs/inode.c                                |    3 +-
 fs/ext2/namei.c                                    |    6 +-
 fs/ext4/namei.c                                    |    6 +-
 fs/f2fs/extent_cache.c                             |    3 +
 fs/f2fs/namei.c                                    |   12 +-
 fs/fscache/page.c                                  |   13 +-
 fs/gfs2/file.c                                     |    5 +-
 fs/gfs2/quota.h                                    |    2 +
 fs/jffs2/dir.c                                     |   12 +-
 fs/jffs2/fs.c                                      |    1 -
 fs/jfs/namei.c                                     |   12 +-
 fs/nfs/nfs4proc.c                                  |   12 +-
 fs/nfs/nfs4state.c                                 |    5 +-
 fs/nfs/nfs4sysctl.c                                |    2 +-
 fs/nilfs2/namei.c                                  |    6 +-
 fs/ocfs2/acl.c                                     |    6 +
 fs/ocfs2/dlm/dlmdomain.c                           |   14 -
 fs/ocfs2/dlm/dlmdomain.h                           |   25 +-
 fs/ocfs2/dlm/dlmrecovery.c                         |    9 +
 fs/ocfs2/journal.c                                 |   23 +-
 fs/ocfs2/super.c                                   |    5 +-
 fs/ocfs2/xattr.c                                   |    2 +
 fs/orangefs/namei.c                                |    9 +-
 fs/proc/base.c                                     |   29 +-
 fs/proc/kcore.c                                    |    4 +
 fs/proc/proc_sysctl.c                              |    3 +
 fs/reiserfs/namei.c                                |   12 +-
 fs/udf/namei.c                                     |    6 +-
 fs/udf/super.c                                     |    5 +-
 fs/ufs/namei.c                                     |    6 +-
 fs/xfs/xfs_discard.c                               |   14 +-
 include/asm-generic/pgtable.h                      |   15 +
 include/linux/cpumask.h                            |    2 +
 include/linux/dcache.h                             |    1 +
 include/linux/kcore.h                              |    1 +
 include/linux/kvm_host.h                           |    3 +-
 include/linux/property.h                           |   10 +-
 include/linux/ptr_ring.h                           |    2 +-
 include/linux/suspend.h                            |    2 +
 include/net/ip.h                                   |   11 +-
 include/net/ip_fib.h                               |    1 +
 include/net/llc_conn.h                             |    2 +-
 include/net/mac80211.h                             |    2 +-
 include/net/regulatory.h                           |    2 +-
 include/net/route.h                                |    3 +-
 include/trace/events/timer.h                       |   20 +-
 include/uapi/drm/virtgpu_drm.h                     |    1 +
 include/uapi/linux/if_ether.h                      |    1 +
 ipc/shm.c                                          |   19 +-
 kernel/audit.c                                     |    2 +
 kernel/debug/kdb/kdb_main.c                        |   27 +-
 kernel/events/core.c                               |   24 +-
 kernel/locking/qspinlock.c                         |    8 +
 kernel/power/power.h                               |    3 -
 kernel/rcu/tree_plugin.h                           |   14 +-
 kernel/relay.c                                     |    2 +-
 kernel/sched/rt.c                                  |    2 +
 kernel/signal.c                                    |    4 +
 kernel/sys.c                                       |    1 +
 kernel/workqueue.c                                 |    2 +-
 lib/test_bpf.c                                     |   31 +-
 mm/fadvise.c                                       |   10 +-
 mm/huge_memory.c                                   |    5 +-
 mm/kasan/kasan.c                                   |    2 +-
 mm/khugepaged.c                                    |   20 +-
 mm/kmemleak.c                                      |   12 +-
 mm/ksm.c                                           |   28 +
 mm/mempolicy.c                                     |   36 +-
 mm/swapfile.c                                      |    4 +
 mm/vmscan.c                                        |   22 +-
 net/batman-adv/bat_iv_ogm.c                        |    2 +-
 net/batman-adv/bat_v.c                             |    2 +-
 net/batman-adv/bridge_loop_avoidance.c             |   22 +-
 net/batman-adv/distributed-arp-table.c             |    2 +-
 net/batman-adv/fragmentation.c                     |    3 +-
 net/batman-adv/gateway_client.c                    |    3 +
 net/batman-adv/multicast.c                         |    8 +-
 net/batman-adv/routing.c                           |   15 +-
 net/batman-adv/soft-interface.c                    |    8 +-
 net/bridge/netfilter/ebtables.c                    |   33 +-
 net/core/skbuff.c                                  |    9 +-
 net/ipv4/ip_vti.c                                  |    2 -
 net/ipv4/route.c                                   |   26 +-
 net/ipv4/tcp_illinois.c                            |    2 +-
 net/ipv4/tcp_nv.c                                  |    2 +-
 net/ipv4/xfrm4_policy.c                            |    1 +
 net/ipv6/ip6_tunnel.c                              |   12 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   16 +-
 net/ipv6/sit.c                                     |    7 +
 net/llc/llc_c_ac.c                                 |   15 +-
 net/llc/llc_conn.c                                 |   32 +-
 net/mac80211/rx.c                                  |    2 +-
 net/mac80211/spectmgmt.c                           |    7 +-
 net/mac80211/sta_info.c                            |    3 +-
 net/netlabel/netlabel_unlabeled.c                  |   10 +
 net/nfc/llcp_commands.c                            |    4 +
 net/nfc/netlink.c                                  |    3 +-
 net/openvswitch/conntrack.c                        |   34 +
 net/qrtr/smd.c                                     |    1 +
 net/rds/ib.c                                       |    3 +-
 net/rxrpc/input.c                                  |   15 +-
 net/rxrpc/recvmsg.c                                |    5 +-
 net/rxrpc/sendmsg.c                                |    4 +-
 scripts/adjust_autoksyms.sh                        |    7 +
 scripts/kconfig/expr.c                             |    2 +-
 scripts/kconfig/menu.c                             |    1 +
 scripts/kconfig/zconf.y                            |   33 +-
 scripts/package/builddeb                           |    2 +-
 security/integrity/digsig.c                        |    1 +
 security/integrity/ima/ima_crypto.c                |    2 +
 security/integrity/ima/ima_main.c                  |   13 +
 sound/core/timer.c                                 |    4 +-
 sound/core/vmaster.c                               |    5 +-
 sound/pci/hda/Kconfig                              |    1 -
 sound/pci/hda/patch_realtek.c                      |    5 +
 tools/lib/bpf/libbpf.c                             |   26 +
 tools/lib/traceevent/event-parse.c                 |   17 +-
 tools/lib/traceevent/parse-filter.c                |   10 +-
 tools/perf/arch/x86/util/header.c                  |    2 +-
 tools/perf/builtin-stat.c                          |    9 +-
 tools/perf/builtin-top.c                           |    6 +-
 tools/perf/tests/vmlinux-kallsyms.c                |    2 +-
 tools/perf/util/evsel.c                            |    8 +-
 tools/perf/util/hist.c                             |    4 +-
 tools/perf/util/hist.h                             |    1 -
 tools/testing/selftests/Makefile                   |    1 +
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   46 +
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |   97 ++
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |   43 +
 tools/testing/selftests/memfd/config               |    1 +
 tools/testing/selftests/net/psock_fanout.c         |    3 +-
 tools/testing/selftests/net/reuseport_bpf.c        |   21 +-
 tools/testing/selftests/powerpc/mm/subpage_prot.c  |   14 +
 tools/testing/selftests/pstore/config              |    1 +
 tools/thermal/tmon/sysfs.c                         |   12 +-
 tools/thermal/tmon/tmon.c                          |    1 -
 virt/kvm/kvm_main.c                                |    7 +-
 352 files changed, 3835 insertions(+), 2292 deletions(-)
