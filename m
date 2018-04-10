Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48qQPDkisyx6FsEUx/noQvPLnyi4MzIlVuCERgOMA7Q+n2EO+vbbJxTrUKaWDkNrZvzGr4n
ARC-Seal: i=1; a=rsa-sha256; t=1523399185; cv=none;
        d=google.com; s=arc-20160816;
        b=RMpexCDDRoa9gTHETo2h5r7Z+3hZc08I900R3Iu84FWyIjUKpsMd5qwW5PdApSVtE+
         wrHkD5+K+2/5uDwk6SD9PTxij8tbd756UbCmxEsvNUN+FnRm2okMzbWAir+eo5WewV90
         gWWM+24OFyrscXHmBbEYbtzOhpDo3ZBtvvYOJd2pepltWnun0Jy75TNtjCvaMwKJonYG
         DwDE5tGXSIYiatoQRh2GjotK96O2lTCt5tfsdoes/+OV/fWYSKXZ5x+tNN9f6qqEIVCI
         pOQmrxEPUfTjV8UKxwB+W1AOQmuFdJjZBsRmOYB05P58ywAfDjqnL0ONoFg20+fXJonx
         cYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b0Z8wihMxVpXkyDD0eybtUZH5u6mcqzwIZrIztuHAjg=;
        b=Ff7NgyJDHRjKrWjGc5i/GrWpp0MItWZOQpDHgHf+2f2CMmkzWnByjwQfAVgBcAkAEc
         BStgNPFMz+OVXsL32GPIMjecLOq3Y7HCZyNqiXfXWu5ZXoo1aM1ws9kBd7WW0wUyuJBJ
         u5sLgyYicpl6G6DZLPJrLZiitVvMz2OxW5QVNmExLjfwXXvsxQfvxhmif3ICWIqR9LTa
         kt7Lv0oMY70JR2c916a/utOjUJXriqJw+RerkNhqV1eNZotOXF3Wh4EDSkzgCmKY7XcU
         XIjB5MUMkl01G1HseEI/fvNOofRlpLi3kQPiPJLGdurrE65hdlziK29VIybyDNfZSi26
         xrTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.15 000/168] 4.15.17-stable review
Date: Wed, 11 Apr 2018 00:22:22 +0200
Message-Id: <20180410212800.144079021@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.17-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.17-rc1
X-KernelTest-Deadline: 2018-04-12T21:28+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399823724415231?=
X-GMAIL-MSGID: =?utf-8?q?1597399823724415231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.17 release.
There are 168 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Apr 12 21:27:22 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.17-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.17-rc1

Moshe Shemesh <moshe@mellanox.com>
    net/mlx4_core: Fix memory leak while delete slave's resources

Jason Wang <jasowang@redhat.com>
    vhost_net: add missing lock nesting notation

Xin Long <lucien.xin@gmail.com>
    team: move dev_mc_sync after master_upper_dev_link in team_port_add

Xin Long <lucien.xin@gmail.com>
    route: check sysctl_fib_multipath_use_neigh earlier than hash

Jason Wang <jasowang@redhat.com>
    vhost: validate log when IOTLB is enabled

Roi Dayan <roid@mellanox.com>
    net/mlx5e: Fix traffic being dropped on VF representor

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx4_en: Fix mixed PFC and Global pause user control requests

Dave Watson <davejwatson@fb.com>
    strparser: Fix sign of err codes

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix NULL dereference on the error path of tcf_skbmod_init()

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix NULL dereference in the error path of tunnel_key_init()

Shahar Klein <shahark@mellanox.com>
    net/mlx5e: Sync netdev vxlan ports at open

Jianbo Liu <jianbol@mellanox.com>
    net/mlx5e: Don't override vport admin link state in switchdev mode

David Lebrun <dlebrun@google.com>
    ipv6: sr: fix seg6 encap performances with TSO enabled

Dirk van der Merwe <dirk.vandermerwe@netronome.com>
    nfp: use full 40 bits of the NSP buffer address

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix NULL dereference in the error path of tcf_sample_init()

Jianbo Liu <jianbol@mellanox.com>
    net/mlx5e: Fix memory usage issues in offloading TC flows

Or Gerlitz <ogerlitz@mellanox.com>
    net/mlx5e: Avoid using the ipv6 stub in the TC offload neigh update path

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix NULL dereference in the error path of tcf_vlan_init()

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: fix a missing idr_remove() in u32_delete_key()

Tal Gilboa <talgi@mellanox.com>
    net/mlx5e: Set EQE based as default TX interrupt moderation mode

Eric Dumazet <edumazet@google.com>
    vti6: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ip6_tunnel: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ip6_gre: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ipv6: sit: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ip_tunnel: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    net: fool proof dev_valid_name()

Xin Long <lucien.xin@gmail.com>
    bonding: process the err returned by dev_set_allmulti properly in bond_enslave

Xin Long <lucien.xin@gmail.com>
    bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave

Xin Long <lucien.xin@gmail.com>
    bonding: fix the err path for dev hwaddr sync in bond_enslave

David Ahern <dsahern@gmail.com>
    vrf: Fix use after free and double free in vrf_finish_output

Hangbin Liu <liuhangbin@gmail.com>
    vlan: also check phy_driver ts_info for vlan's real device

Jason Wang <jasowang@redhat.com>
    vhost: correctly remove wait queue during poll failure

Kai-Heng Feng <kai.heng.feng@canonical.com>
    sky2: Increase D3 delay to sky2 stops working after suspend

Eric Dumazet <edumazet@google.com>
    sctp: sctp_sockaddr_af must check minimal addr length for AF_INET6

Eric Dumazet <edumazet@google.com>
    sctp: do not leak kernel memory to user space

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix setting driver_data after register_netdev

Eric Dumazet <edumazet@google.com>
    pptp: remove a buggy dst release in pptp_connect()

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix NULL dereference in the error path of tcf_bpf_init()

Craig Dillabaugh <cdillaba@mojatatu.com>
    net sched actions: fix dumping which requires several messages to user space

Moshe Shemesh <moshe@mellanox.com>
    net/mlx5e: Verify coalescing parameters in range

Alexander Potapenko <glider@google.com>
    netlink: make sure nladdr has correct size in netlink_connect()

Jeff Barnhill <0xeffeff@gmail.com>
    net/ipv6: Increment OUTxxx counters after netfilter hook

David Ahern <dsahern@gmail.com>
    net/ipv6: Fix route leaking between VRFs

Eric Dumazet <edumazet@google.com>
    net: fix possible out-of-bound read in skb_network_protocol()

Andrew Lunn <andrew@lunn.ch>
    net: dsa: Discard frames from unused ports

Raghuram Chary J <raghuramchary.jallipalli@microchip.com>
    lan78xx: Crash in lan78xx_writ_reg (Workqueue: events lan78xx_deferred_multicast_write)

Paolo Abeni <pabeni@redhat.com>
    ipv6: the entire IPv6 header chain must fit the first fragment

Miguel Fadon Perlines <mfadon@teldat.com>
    arp: fix arp_filter on l3slave devices

Borislav Petkov <bp@suse.de>
    x86/microcode: Fix CPU synchronization routine

Borislav Petkov <bp@suse.de>
    x86/microcode: Attempt late loading only when new microcode is present

Ashok Raj <ashok.raj@intel.com>
    x86/microcode: Synchronize late microcode loading

Borislav Petkov <bp@suse.de>
    x86/microcode: Request microcode on the BSP

Borislav Petkov <bp@suse.de>
    x86/microcode/intel: Look into the patch cache first

Ashok Raj <ashok.raj@intel.com>
    x86/microcode: Do not upload microcode if CPUs are offline

Ashok Raj <ashok.raj@intel.com>
    x86/microcode/intel: Writeback and invalidate caches before updating microcode

Ashok Raj <ashok.raj@intel.com>
    x86/microcode/intel: Check microcode revision before updating sibling threads

Borislav Petkov <bp@suse.de>
    x86/microcode: Get rid of struct apply_microcode_ctx

Borislav Petkov <bp@suse.de>
    x86/CPU: Check CPU feature bits after microcode upgrade

Borislav Petkov <bp@suse.de>
    x86/CPU: Add a microcode loader callback

Borislav Petkov <bp@suse.de>
    x86/microcode: Propagate return value from updating functions

Rodrigo Vivi <rodrigo.vivi@intel.com>
    drm/i915/cnp: Properly handle VBT ddc pin out of bounds.

Rodrigo Vivi <rodrigo.vivi@intel.com>
    drm/i915/cnp: Ignore VBT request for know invalid DDC pin.

Alexey Khoroshilov <khoroshilov@ispras.ru>
    thermal: int3400_thermal: fix error handling in int3400_thermal_probe()

Mike Christie <mchristi@redhat.com>
    tcmu: release blocks for partially setup cmds

Jiri Olsa <jolsa@kernel.org>
    perf tools: Fix copyfile_offset update of output offset

Arnd Bergmann <arnd@arndb.de>
    crypto: aes-generic - build with -Os on gcc-7+

Miquel Raynal <miquel.raynal@free-electrons.com>
    mtd: mtd_oobtest: Handle bitflips during reads

Hans de Goede <hdegoede@redhat.com>
    Input: goodix - disable IRQs while suspended

Nathan Fontenot <nfont@linux.vnet.ibm.com>
    ibmvnic: Don't handle RX interrupts when not up.

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    sdhci: Advertise 2.0v supply on SDIO host controller

Jiri Bohac <jbohac@suse.cz>
    x86/gart: Exclude GART aperture from vmcore

Wei Yongjun <weiyongjun1@huawei.com>
    gpio: thunderx: fix error return code in thunderx_gpio_probe()

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Fix rdma_cm path querying for RoCE

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: unload flag should be set after scsi_remove_host is called

Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
    scsi: megaraid_sas: Error handling for invalid ldcount provided by firmware in RAID map

Ulf Hansson <ulf.hansson@linaro.org>
    PM / domains: Don't skip driver's ->suspend|resume_noirq() callbacks

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4vf: Fix SGE FL buffer initialization logic for 64K pages

Yintian Tao <yttao@amd.com>
    drm/amd/powerplay: fix memory leakage when reload (v2)

Jacob Keller <jacob.e.keller@intel.com>
    i40evf: don't rely on netif_running() outside rtnl_lock()

Stefan Wahren <stefan.wahren@i2se.com>
    Bluetooth: hci_bcm: Make shutdown and device wake GPIO optional

Ronald Tschalär <ronald@innovation.ch>
    Bluetooth: hci_bcm: Validate IRQ before using it

Lukas Wunner <lukas@wunner.de>
    Bluetooth: hci_bcm: Mandate presence of shutdown and device wake GPIO

Stephen Hemminger <stephen@networkplumber.org>
    uio_hv_generic: check that host supports monitor page

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    EDAC, mv64x60: Fix an error handling path

Hans de Goede <hdegoede@redhat.com>
    serdev: Fix serdev_uevent failure on ACPI enumerated serdev-controllers

Paolo Valente <paolo.valente@linaro.org>
    block, bfq: put async queues for root bfq groups too

Tony Lindgren <tony@atomide.com>
    tty: n_gsm: Allow ADM response in addition to UA for control dlci

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix kernel oops in blk_mq_tag_idle()

Feras Daoud <ferasda@mellanox.com>
    net/mlx5e: IPoIB, Use correct timestamp in child receive flow

chenxiang <chenxiang66@hisilicon.com>
    scsi: libsas: initialize sas_phy status according to response of DISCOVER

Jason Yan <yanaijie@huawei.com>
    scsi: libsas: fix error when getting phy events

Jason Yan <yanaijie@huawei.com>
    scsi: libsas: fix memory leak in sas_smp_get_phy_events()

Gal Pressman <galp@mellanox.com>
    net: Fix netdev_WARN_ONCE macro

Jason Yan <yanaijie@huawei.com>
    scsi: libsas: Use dynamic alloced work to avoid sas event lost

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: segregate flash only volume write streams

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: stop writeback thread after detaching

Rui Hua <huarui.dev@gmail.com>
    bcache: ret IOERR when read meets metadata error

Fuyun Liang <liangfuyun1@huawei.com>
    net: hns3: fix for changing MTU

Jian Shen <shenjian15@huawei.com>
    net: hns3: Fix an error macro definition of HNS3_TQP_STAT

Jian Shen <shenjian15@huawei.com>
    net: hns3: Fix a loop index error of tqp statistics query

Jian Shen <shenjian15@huawei.com>
    net: hns3: Fix an error of total drop packet statistics

Daniel Jurgens <danielj@mellanox.com>
    net/mlx5: Fix race for multiple RoCE enable

Colin Ian King <colin.king@canonical.com>
    wl1251: check return from call to wl1251_acx_arp_ip_filter

Stanislaw Gruszka <sgruszka@redhat.com>
    rt2x00: do not pause queue unconditionally on error path

Hans de Goede <hdegoede@redhat.com>
    power: supply: axp288_charger: Properly stop work on probe-error / remove

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ASoC: Intel: sst: Fix the return value of 'sst_send_byte_stream_mrfld()'

NeilBrown <neilb@suse.com>
    staging: lustre: disable preempt while sampling processor id.

Jin Yao <yao.jin@linux.intel.com>
    perf report: Fix a no annotate browser displayed issue

Javier Martinez Canillas <javierm@redhat.com>
    tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented

James Smart <jsmart2021@gmail.com>
    nvme_fcloop: fix abort race condition

James Smart <jsmart2021@gmail.com>
    nvme_fcloop: disassocate local port structs

Hans de Goede <hdegoede@redhat.com>
    pinctrl: baytrail: Enable glitch filter for GPIOs used as interrupts

Christoph Hellwig <hch@lst.de>
    nvme-fabrics: don't check for non-NULL module in nvmf_register_transport

Roy Shterman <roys@lightbitslabs.com>
    nvme-fabrics: protect against module unload during create_ctrl

Robert Jarzmik <robert.jarzmik@free.fr>
    backlight: tdo24m: Fix the SPI CS between transfers

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix race between updating nr_hw_queues and switching io sched

Ming Lei <ming.lei@redhat.com>
    blk-mq: avoid to map CPU into stale hw queue

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/rdmavt: Allocate CQ memory on the correct node

Gautham R. Shenoy <ego@linux.vnet.ibm.com>
    powernv-cpufreq: Add helper to extract pstate from PMSR

Catalin Marinas <catalin.marinas@arm.com>
    arm64: asid: Do not replace active_asids if already 0

Linus Walleij <linus.walleij@linaro.org>
    gpio: label descriptors using the device name

Christian Lamparter <chunkeey@gmail.com>
    crypto: crypto4xx - perform aead icv check in the driver

Pieter \"PoroCYon\" Sluys <pcy@national.shitposting.agency>
    vfb: fix video mode and line_length being set when loaded

Peter Große <pegro@friiks.de>
    mac80211: Fix setting TX power on monitor interfaces

Geert Uytterhoeven <geert+renesas@glider.be>
    ACPI: EC: Fix debugfs_create_*() usage

Shanker Donthineni <shankerd@codeaurora.org>
    irqchip/gic-v3: Fix the driver probe() fail due to disabled GICC entry

Wei Yongjun <weiyongjun1@huawei.com>
    irqchip/ompic: fix return value check in ompic_of_init()

Chaitra P B <chaitra.basappa@broadcom.com>
    scsi: mpt3sas: Proper handling of set/clear of "ATA command pending" flag.

Rafael David Tinoco <rafael.tinoco@canonical.com>
    scsi: libiscsi: Allow sd_shutdown on bad transport

oulijun <oulijun@huawei.com>
    RDMA/hns: Update the usage of sr_max and rr_max field

Geert Uytterhoeven <geert+renesas@glider.be>
    spi: sh-msiof: Fix timeout failures for TX-only DMA transfers

Alex Estrin <alex.estrin@intel.com>
    IB/ipoib: Fix for notify send CQ failure messages

Archit Taneja <architt@codeaurora.org>
    drm/msm: Fix NULL deref in adreno_load_gpu

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: cht_bsw_rt5645: Analog Mic support

Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
    ASoC: Intel: Skylake: Disable clock gating during firmware and library download

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: videobuf2-core: don't go out of the buffer range

Jernej Škrabec <jernej.skrabec@siol.net>
    clk: sunxi-ng: a83t: Add M divider to TCON1 clock

Chao Yu <yuchao0@huawei.com>
    f2fs: fix lock dependency in between dio_rwsem & i_mmap_sem

Maciej Purski <m.purski@samsung.com>
    hwmon: (ina2xx) Make calibration register value fixed

Leon Romanovsky <leonro@mellanox.com>
    RDMA/cma: Mark end of CMA ID messages

Geert Uytterhoeven <geert@linux-m68k.org>
    thermal/drivers/hisi: Remove bogus const from function return type

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    selftests/net: fix bugs in address and port initialization

Nogah Frankel <nogahf@mellanox.com>
    net_sch: red: Fix the new offload indication

Vladimir Zapolskiy <vz@mleia.com>
    gpiolib: don't dereference a desc before validation

Gustavo A. R. Silva <garsilva@embeddedor.com>
    PM / devfreq: Fix potential NULL pointer dereference in governor_store

Jerome Brunet <jbrunet@baylibre.com>
    clk: divider: fix incorrect usage of container_of

Oleksij Rempel <o.rempel@pengutronix.de>
    watchdog: dw_wdt: add stop watchdog operation

NeilBrown <neilb@suse.com>
    VFS: close race between getcwd() and d_move()

Maor Gottlieb <maorg@mellanox.com>
    IB/mlx5: Report inner RSS capability

Moni Shoua <monis@mellanox.com>
    net/mlx4_en: Change default QoS settings

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Default lcd_only to true on Win8-ready and newer machines

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    rds; Reset rs->rs_bound_addr in rds_add_bound() failure path

Hangbin Liu <liuhangbin@gmail.com>
    l2tp: fix missing print session offset info

Fuyun Liang <liangfuyun1@huawei.com>
    net: hns3: add Asym Pause support to phy default features

Fuyun Liang <liangfuyun1@huawei.com>
    net: hns3: fix for getting auto-negotiation state in hclge_get_autoneg

Peng Li <lipeng321@huawei.com>
    net: hns3: free the ring_data structrue when change tqps

Mengting Zhang <zhangmengting@huawei.com>
    perf evsel: Enable ignore_missing_thread for pid option

Jiri Olsa <jolsa@kernel.org>
    perf evsel: Fix swap for samples with raw data

Masami Hiramatsu <mhiramat@kernel.org>
    perf probe: Add warning message if there is unexpected event name

Masami Hiramatsu <mhiramat@kernel.org>
    perf probe: Find versioned symbols from map

Yi Zeng <yizeng@asrmicro.com>
    thermal: power_allocator: fix one race condition issue for thermal_instances list

Tobias Brunner <tobias@strongswan.org>
    ipv6: Reinject IPv6 packets if IPsec policy matches after SNAT

Ioan Moldovan <ioan.moldovan1999@gmail.com>
    Bluetooth: Add a new 04ca:3015 QCA_ROME device

Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    ARM: dts: ls1021a: add "fsl,ls1021a-esdhc" compatible string to esdhc node

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    clk: meson: mpll: use 64-bit maths in params_from_rate

Tatyana Nikolova <tatyana.e.nikolova@intel.com>
    i40iw: Validate correct IRD/ORD connection parameters

Shiraz Saleem <shiraz.saleem@intel.com>
    i40iw: Correct Q1/XF object count equation

Shiraz Saleem <shiraz.saleem@intel.com>
    i40iw: Fix sequence number for the first partial FPDU


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/ls1021a.dtsi                     |   2 +-
 arch/arm64/mm/context.c                            |  19 ++-
 arch/x86/include/asm/microcode.h                   |  10 +-
 arch/x86/include/asm/processor.h                   |   1 +
 arch/x86/kernel/aperture_64.c                      |  46 +++++-
 arch/x86/kernel/cpu/common.c                       |  30 ++++
 arch/x86/kernel/cpu/microcode/amd.c                |  44 +++--
 arch/x86/kernel/cpu/microcode/core.c               | 181 ++++++++++++++++-----
 arch/x86/kernel/cpu/microcode/intel.c              |  62 +++++--
 arch/x86/xen/mmu_hvm.c                             |   2 +-
 block/bfq-cgroup.c                                 |   7 +-
 block/blk-mq.c                                     |  29 +++-
 crypto/Makefile                                    |   1 +
 drivers/acpi/acpi_video.c                          |  14 +-
 drivers/acpi/ec.c                                  |   2 +-
 drivers/acpi/ec_sys.c                              |   2 +-
 drivers/acpi/internal.h                            |   2 +-
 drivers/base/power/domain.c                        |  30 ++--
 drivers/bluetooth/btusb.c                          |   1 +
 drivers/bluetooth/hci_bcm.c                        |  25 ++-
 drivers/char/tpm/tpm-interface.c                   |  28 +++-
 drivers/char/tpm/tpm.h                             |   5 +
 drivers/clk/clk-divider.c                          |   7 +-
 drivers/clk/hisilicon/clkdivider-hi6220.c          |   2 +-
 drivers/clk/meson/clk-mpll.c                       |   2 +-
 drivers/clk/nxp/clk-lpc32xx.c                      |   2 +-
 drivers/clk/qcom/clk-regmap-divider.c              |   2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |   4 +-
 drivers/clk/sunxi-ng/ccu_div.c                     |   2 +-
 drivers/cpufreq/powernv-cpufreq.c                  |  37 +++--
 drivers/crypto/amcc/crypto4xx_alg.c                |   6 +-
 drivers/crypto/amcc/crypto4xx_core.c               |  54 +++---
 drivers/devfreq/devfreq.c                          |   3 +-
 drivers/edac/mv64x60_edac.c                        |   2 +-
 drivers/gpio/gpio-thunderx.c                       |   4 +-
 drivers/gpio/gpiolib.c                             |   6 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c |   6 +
 drivers/gpu/drm/i915/intel_bios.c                  |  12 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   7 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c         |   2 +-
 drivers/hwmon/ina2xx.c                             |  87 +++++-----
 drivers/infiniband/core/cma.c                      |   1 +
 drivers/infiniband/core/ucma.c                     |   7 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  27 +--
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |   5 +-
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c           |   6 +-
 drivers/infiniband/hw/i40iw/i40iw_d.h              |   1 +
 drivers/infiniband/hw/i40iw/i40iw_puda.c           |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   3 +-
 drivers/infiniband/sw/rdmavt/cq.c                  |  10 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |  10 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |   2 +-
 drivers/input/touchscreen/goodix.c                 |   8 +-
 drivers/irqchip/irq-gic-v3.c                       |  11 ++
 drivers/irqchip/irq-ompic.c                        |   4 +-
 drivers/md/bcache/alloc.c                          |  19 ++-
 drivers/md/bcache/request.c                        |  22 +++
 drivers/md/bcache/super.c                          |   6 +
 drivers/media/v4l2-core/videobuf2-core.c           |   4 +
 drivers/mmc/host/sdhci-pci-core.c                  |   2 +
 drivers/mmc/host/sdhci.c                           |   7 +
 drivers/mtd/tests/oobtest.c                        |  21 +++
 drivers/net/bonding/bond_main.c                    |  73 +++++----
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c         |  23 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   4 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |   1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c |  17 +-
 .../ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c  |  13 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   6 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  20 ++-
 drivers/net/ethernet/marvell/sky2.c                |   2 +-
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c     |  77 +++++----
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |  33 ++--
 drivers/net/ethernet/mellanox/mlx4/en_main.c       |   4 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   7 +
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |   1 +
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  17 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  26 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  18 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  33 +++-
 .../net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c   |   9 +-
 drivers/net/ethernet/realtek/r8169.c               |   4 +-
 drivers/net/ppp/pptp.c                             |   1 -
 drivers/net/team/team.c                            |  12 +-
 drivers/net/usb/lan78xx.c                          |  23 ++-
 drivers/net/vrf.c                                  |   5 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |  22 ++-
 drivers/net/wireless/ti/wl1251/main.c              |   3 +-
 drivers/nvme/host/fabrics.c                        |  15 +-
 drivers/nvme/host/fabrics.h                        |   2 +
 drivers/nvme/host/fc.c                             |   1 +
 drivers/nvme/host/rdma.c                           |   1 +
 drivers/nvme/target/fcloop.c                       |  47 ++++--
 drivers/nvme/target/loop.c                         |   1 +
 drivers/pinctrl/intel/pinctrl-baytrail.c           |   6 +
 drivers/power/supply/axp288_charger.c              |  13 ++
 drivers/rtc/rtc-ac100.c                            |   6 +-
 drivers/scsi/libiscsi.c                            |  24 ++-
 drivers/scsi/libsas/sas_event.c                    |  74 +++++++--
 drivers/scsi/libsas/sas_expander.c                 |   4 +-
 drivers/scsi/libsas/sas_init.c                     |  27 ++-
 drivers/scsi/libsas/sas_internal.h                 |   6 +
 drivers/scsi/libsas/sas_phy.c                      |  44 +----
 drivers/scsi/libsas/sas_port.c                     |  18 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |   2 +-
 drivers/scsi/megaraid/megaraid_sas_fp.c            |  16 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |  28 ++--
 drivers/spi/spi-sh-msiof.c                         |  12 +-
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   |  13 +-
 drivers/target/target_core_user.c                  |   7 +
 drivers/thermal/hisi_thermal.c                     |   2 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |  10 +-
 drivers/thermal/power_allocator.c                  |   2 +
 drivers/tty/n_gsm.c                                |  17 +-
 drivers/tty/serdev/core.c                          |   5 +
 drivers/uio/uio_hv_generic.c                       |   7 +
 drivers/vhost/net.c                                |   4 +-
 drivers/vhost/vhost.c                              |  17 +-
 drivers/video/backlight/corgi_lcd.c                |   2 +-
 drivers/video/backlight/tdo24m.c                   |   2 +-
 drivers/video/backlight/tosa_lcd.c                 |   2 +-
 drivers/video/fbdev/vfb.c                          |  17 ++
 drivers/watchdog/dw_wdt.c                          |  18 +-
 fs/dcache.c                                        |  23 ++-
 fs/f2fs/file.c                                     |  20 +--
 include/linux/clk-provider.h                       |   2 +-
 include/linux/mlx5/driver.h                        |   2 +-
 include/linux/netdevice.h                          |   4 +-
 include/scsi/libsas.h                              |  17 +-
 include/uapi/rdma/mlx5-abi.h                       |   2 +-
 net/8021q/vlan_dev.c                               |   6 +-
 net/core/dev.c                                     |   4 +-
 net/dsa/dsa_priv.h                                 |   8 +-
 net/ipv4/arp.c                                     |   2 +-
 net/ipv4/fib_semantics.c                           |  20 ++-
 net/ipv4/ip_tunnel.c                               |  11 +-
 net/ipv6/ip6_gre.c                                 |   8 +-
 net/ipv6/ip6_output.c                              |  28 +++-
 net/ipv6/ip6_tunnel.c                              |  11 +-
 net/ipv6/ip6_vti.c                                 |   7 +-
 net/ipv6/route.c                                   |   3 +
 net/ipv6/seg6_iptunnel.c                           |  16 +-
 net/ipv6/sit.c                                     |   8 +-
 net/l2tp/l2tp_netlink.c                            |   2 +
 net/mac80211/cfg.c                                 |  28 +++-
 net/mac80211/driver-ops.h                          |   3 +-
 net/netlink/af_netlink.c                           |   3 +
 net/rds/bind.c                                     |   1 +
 net/sched/act_api.c                                |   4 +-
 net/sched/act_bpf.c                                |  12 +-
 net/sched/act_sample.c                             |   3 +-
 net/sched/act_skbmod.c                             |   3 +-
 net/sched/act_tunnel_key.c                         |   9 +-
 net/sched/act_vlan.c                               |   3 +-
 net/sched/cls_u32.c                                |   1 +
 net/sched/sch_red.c                                |  26 +--
 net/sctp/ipv6.c                                    |   4 +-
 net/sctp/socket.c                                  |  13 +-
 net/strparser/strparser.c                          |   4 +-
 sound/soc/intel/atom/sst/sst_stream.c              |   2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |   7 +
 sound/soc/intel/skylake/skl-messages.c             |   4 +
 sound/soc/intel/skylake/skl-pcm.c                  |   4 +
 tools/perf/arch/powerpc/util/sym-handling.c        |   8 +
 tools/perf/builtin-record.c                        |   4 +-
 tools/perf/builtin-report.c                        |  18 +-
 tools/perf/util/evsel.c                            |  67 +++++++-
 tools/perf/util/probe-event.c                      |  28 +++-
 tools/perf/util/python-ext-sources                 |   1 +
 tools/perf/util/symbol.c                           |   5 +
 tools/perf/util/symbol.h                           |   1 +
 tools/perf/util/util.c                             |   2 +-
 tools/testing/selftests/net/msg_zerocopy.c         |  21 ++-
 177 files changed, 1711 insertions(+), 705 deletions(-)
