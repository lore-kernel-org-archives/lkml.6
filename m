Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48fvrEJBvwjLtbrfXoIniDnAPVOh4XZPHeqpBy+GAlzV0lA4EfI+A41zujtqECDE33mjdHS
ARC-Seal: i=1; a=rsa-sha256; t=1523472843; cv=none;
        d=google.com; s=arc-20160816;
        b=NA9j78EwUPfyfnBt0xq3AATzcnwvxvzX5eBDXEOtg1GDXV7pKGqAQz+gUwffI33Myp
         /SXKuRV+oalt5NgcCSXZv1nQtwoZCtQyIEqttgubX2LRV1f0nj2899Fe0xjSZ5+wV76U
         ptjU80erM2DLwxL3K/baytlt6xsJlmo6woziZzDNVCNYX1gUa53fHu4IWsgaHFY2t0Ow
         RGafu+PZIYdDp34LKV+UvUX7c6H6y/OeaTbgZIgr99zPzTFpzqej3dURX0QfRwzs7243
         ZTaJysfuhZnhKMEkH4HBJNFQ2/wgx1kQ2rDHCY5aK7VSLJYclnc1MsHH7XgY2mP1cU0S
         DUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qokepVt01lEbBd0vymREJtRBYPlHQt2vo0y3CM9mITM=;
        b=sWiHNJ4w3FcGOMger3lf/rYP4bxaZYR88+a1H45cmvH9RHc0JqEmA6tWloOpecAeKj
         /4LU9cb25Npihoom8RTANoHPBZ9JNkh+6g5RWgkcsxv4iLm9A9bSHZiLWLd+QS1FDrIH
         3JtZcBnl4E01dFUwEpbIauJY4luZHfNZPa7z8gtT+mCuWq9KmHD2MwsYXwdHxcOYloQh
         O2sQ2WWxTTPvYf4Tp1bGAuVCKTMOUQvVjdlXgtBd5Xk/h+YRSJOB9rKHo+iOJjO07pU8
         i/a4aOynEg2bVwy8i6719zT3dwkO44gl511OAljCqKwjCAncU3xU0BL6wB9Jo5nJnkzS
         /eHg==
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
Subject: [PATCH 4.9 000/310] 4.9.94-stable review
Date: Wed, 11 Apr 2018 20:32:19 +0200
Message-Id: <20180411183622.305902791@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.94-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.94-rc1
X-KernelTest-Deadline: 2018-04-13T18:36+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477060823737120?=
X-GMAIL-MSGID: =?utf-8?q?1597477060823737120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.94 release.
There are 310 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Apr 13 18:35:00 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.94-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.94-rc1

David Ahern <dsahern@gmail.com>
    vrf: Fix use after free and double free in vrf_finish_output

Craig Dillabaugh <cdillaba@mojatatu.com>
    net sched actions: fix dumping which requires several messages to user space

Dave Watson <davejwatson@fb.com>
    strparser: Fix sign of err codes

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

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx4_en: Fix mixed PFC and Global pause user control requests

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix NULL dereference on the error path of tcf_skbmod_init()

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix NULL dereference in the error path of tunnel_key_init()

Shahar Klein <shahark@mellanox.com>
    net/mlx5e: Sync netdev vxlan ports at open

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

Alexander Potapenko <glider@google.com>
    netlink: make sure nladdr has correct size in netlink_connect()

Jeff Barnhill <0xeffeff@gmail.com>
    net/ipv6: Increment OUTxxx counters after netfilter hook

David Ahern <dsahern@gmail.com>
    net/ipv6: Fix route leaking between VRFs

Eric Dumazet <edumazet@google.com>
    net: fix possible out-of-bound read in skb_network_protocol()

Paolo Abeni <pabeni@redhat.com>
    ipv6: the entire IPv6 header chain must fit the first fragment

Miguel Fadon Perlines <mfadon@teldat.com>
    arp: fix arp_filter on l3slave devices

Alexandre Belloni <alexandre.belloni@free-electrons.com>
    clk: at91: fix clk-generated compilation

Theodore Ts'o <tytso@mit.edu>
    random: use lockless method of accessing and updating f->reg_idx

Nathan Chancellor <natechancellor@gmail.com>
    virtio_net: check return value of skb_to_sgvec in one more location

Jason A. Donenfeld <Jason@zx2c4.com>
    virtio_net: check return value of skb_to_sgvec always

Jason A. Donenfeld <Jason@zx2c4.com>
    rxrpc: check return value of skb_to_sgvec always

Jason A. Donenfeld <Jason@zx2c4.com>
    ipsec: check return value of skb_to_sgvec always

Jiri Olsa <jolsa@kernel.org>
    perf tools: Fix copyfile_offset update of output offset

Miquel Raynal <miquel.raynal@free-electrons.com>
    mtd: mtd_oobtest: Handle bitflips during reads

Hans de Goede <hdegoede@redhat.com>
    Input: goodix - disable IRQs while suspended

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    sdhci: Advertise 2.0v supply on SDIO host controller

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4vf: Fix SGE FL buffer initialization logic for 64K pages

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    EDAC, mv64x60: Fix an error handling path

Tony Lindgren <tony@atomide.com>
    tty: n_gsm: Allow ADM response in addition to UA for control dlci

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix kernel oops in blk_mq_tag_idle()

chenxiang <chenxiang66@hisilicon.com>
    scsi: libsas: initialize sas_phy status according to response of DISCOVER

Jason Yan <yanaijie@huawei.com>
    scsi: libsas: fix error when getting phy events

Jason Yan <yanaijie@huawei.com>
    scsi: libsas: fix memory leak in sas_smp_get_phy_events()

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: segregate flash only volume write streams

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: stop writeback thread after detaching

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/vc4: Fix resource leak in 'vc4_get_hang_state_ioctl()' in error handling path

Mickaël Salaün <mic@digikod.net>
    selftests: kselftest_harness: Fix compile warning

Karicheri, Muralidharan <m-karicheri2@ti.com>
    hsr: fix incorrect warning

Roopa Prabhu <roopa@cumulusnetworks.com>
    vxlan: dont migrate permanent fdb entries during learn

Stefan Haberland <sth@linux.vnet.ibm.com>
    s390/dasd: fix hanging safe offline

Bob Moore <robert.moore@intel.com>
    ACPICA: Disassembler: Abort on an invalid/unknown AML opcode

Lv Zheng <lv.zheng@intel.com>
    ACPICA: Events: Add runtime stub support for event APIs

Lv Zheng <lv.zheng@intel.com>
    ACPICA: OSL: Add support to exclude stdarg.h

Christophe Jaillet <christophe.jaillet@wanadoo.fr>
    cpuidle: dt: Add missing 'of_node_put()'

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Send HCI Set Event Mask Page 2 command only when needed

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    clk: meson: meson8b: add compatibles for Meson8 and Meson8m2

Netanel Belgazal <netanel@amazon.com>
    net: ena: disable admin msix while working in polling mode

Netanel Belgazal <netanel@amazon.com>
    net: ena: add missing unmap bars on device removal

Netanel Belgazal <netanel@amazon.com>
    net: ena: add missing return when ena_com_get_io_handlers() fails

Netanel Belgazal <netanel@amazon.com>
    net: ena: fix race condition between submit and completion admin command

Netanel Belgazal <netanel@amazon.com>
    net: ena: fix rare uncompleted admin command false alarm

Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
    iio: magnetometer: st_magn_spi: fix spi_device_id table

Jag Raman <jag.raman@oracle.com>
    sparc64: ldc abort during vds iso boot

Fabio Estevam <fabio.estevam@nxp.com>
    net: fec: Add a fec_enet_clear_ethtool_stats() stub for CONFIG_M5272

Xin Long <lucien.xin@gmail.com>
    sctp: fix recursive locking warning in sctp_do_peeloff

Mintz, Yuval <Yuval.Mintz@cavium.com>
    bnx2x: Allow vfs to disable txvlan offload

Tero Kristo <t-kristo@ti.com>
    crypto: omap-sham - fix closing of hash with separate finalize call

Tero Kristo <t-kristo@ti.com>
    crypto: omap-sham - buffer handling fixes for hashing later

Girish Moodalbail <girish.moodalbail@oracle.com>
    geneve: add missing rx stats accounting

Mario Molitor <mario_molitor@web.de>
    stmmac: fix ptp header for GMAC3 hw timestamp

Robin Murphy <robin.murphy@arm.com>
    coresight: tmc: Configure DMA mask appropriately

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: Fix reference count for software sources

Heiner Kallweit <hkallweit1@gmail.com>
    pinctrl: meson-gxbb: remove non-existing pin GPIOX_22

Dan Carpenter <dan.carpenter@oracle.com>
    X.509: Fix error code in x509_cert_parse()

Arnd Bergmann <arnd@arndb.de>
    xen: avoid type warning in xchg_xen_ulong

Willem de Bruijn <willemb@google.com>
    skbuff: only inherit relevant tx_flags

Namhyung Kim <namhyung@kernel.org>
    perf tests: Decompress kernel module before objdump

Namhyung Kim <namhyung@kernel.org>
    perf tools: Decompress kernel module when reading DSO data

Christian Lamparter <chunkeey@googlemail.com>
    net: emac: fix reset timeout with AR8035 phy

James Wang <jnwang@suse.com>
    Fix loop device flush before configure v3

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: armadillo800eva: Split LCD mux and gpio

Marcin Nowakowski <marcin.nowakowski@imgtec.com>
    MIPS: kprobes: flush_insn_slot should flush only if probe initialised

Marcin Nowakowski <marcin.nowakowski@imgtec.com>
    MIPS: mm: adjust PKMAP location

Marcin Nowakowski <marcin.nowakowski@imgtec.com>
    MIPS: mm: fixed mappings: correct initialisation

Daniel Bristot de Oliveira <bristot@redhat.com>
    sched/deadline: Use the revised wakeup rule for suspending constrained dl tasks

Peter Zijlstra <peterz@infradead.org>
    perf/core: Correct event creation with PERF_FORMAT_GROUP

Chris Wilson <chris@chris-wilson.co.uk>
    e1000e: Undo e1000e_pm_freeze if __e1000_shutdown fails

Jim Mattson <jmattson@google.com>
    KVM: nVMX: Update vmcs12->guest_linear_address on nested VM-exit

Ming Lei <ming.lei@redhat.com>
    nvme: fix hang in remove path

Rakesh Pandit <rakesh@tuxera.com>
    nvme-pci: fix multiple ctrl removal scheduling

Leonard Crestez <leonard.crestez@nxp.com>
    ARM: imx: Add MXC_CPU_IMX6ULL and cpu_is_imx6ull

Russell King <rmk+kernel@armlinux.org.uk>
    net: phy: avoid genphy_aneg_done() for PHYs without clause 22 support

A Sun <as1033x@comcast.net>
    mceusb: sporadic RX truncation corruption fix

Pan Bian <bianpan2016@163.com>
    cx25840: fix unchecked return values

Dan Carpenter <dan.carpenter@oracle.com>
    cxl: Unlock on error in probe

Jacob Keller <jacob.e.keller@intel.com>
    igb: fix race condition with PTP_TX_IN_PROGRESS bits

Jacob Keller <jacob.e.keller@intel.com>
    e1000e: fix race condition around skb_tstamp_tx()

Christian Lamparter <chunkeey@googlemail.com>
    ARM: dts: qcom: ipq4019: fix i2c_0 node

Robert Jarzmik <robert.jarzmik@free.fr>
    tags: honor COMPILED_SOURCE with apart output directory

Luca Coelho <luciano.coelho@intel.com>
    iwlwifi: fix min API version for 7265D, 3168, 8000 and 8265

Luca Coelho <luciano.coelho@intel.com>
    iwlwifi: pcie: only use d0i3 in suspend/resume if system_pm is set to d0i3

Johannes Berg <johannes.berg@intel.com>
    iwlwifi: tt: move ucode_loaded check under mutex

Haim Dreyfuss <haim.dreyfuss@intel.com>
    iwlwifi: mvm: Fix command queue number on d0i3 flow

Maciej S. Szmigiero <mail@maciej.szmigiero.name>
    watchdog: f71808e_wdt: Add F71868 support

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: mvm: fix firmware debug restart recording

Milian Wolff <milian.wolff@kdab.com>
    perf report: Ensure the perf DSO mapping matches what libdw sees

Namhyung Kim <namhyung@kernel.org>
    perf header: Set proper module name when build-id event found

Ido Shamay <idos@mellanox.com>
    net/mlx4: Check if Granular QoS per VF has been enabled before updating QP qos_vport

Talat Batheesh <talatb@mellanox.com>
    net/mlx4: Fix the check in attaching steering rules

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    sit: reload iphdr in ipip6_rcv

Jason A. Donenfeld <Jason@zx2c4.com>
    macsec: check return value of skb_to_sgvec always

Jason A. Donenfeld <Jason@zx2c4.com>
    skbuff: return -EMSGSIZE in skb_to_sgvec to prevent overflow

Liam McBirnie <mcbirnie.l@gmail.com>
    ip6_tunnel: fix traffic class routing for tunnels

Dmitry Monakhov <dmonakhov@openvz.org>
    bio-integrity: Do not allocate integrity context for bio w/o data

Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    Fix serial console on SNI RM400 machines

Ganesh Goudar <ganeshgr@chelsio.com>
    cxgb4: fix incorrect cim_la output for T6

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/8xx: fix mpc8xx_get_irq() return on no irq

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/omap: fix tiled buffer stride calculations

Steven L. Roberts <robers97@gmail.com>
    RDMA/hfi1: fix array termination by appending NULL to attr array

Raju Rangoju <rajur@chelsio.com>
    RDMA/iw_cxgb4: Avoid touch after free error in ARP failure handlers

Leonard Crestez <leonard.crestez@nxp.com>
    net: phy: micrel: Restore led_mode and clk_sel on resume

Jia-Ju Bai <baijiaju1990@163.com>
    mISDN: Fix a sleep-in-atomic bug

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: kernel: restrict /dev/mem read() calls to linear region

Jia-Ju Bai <baijiaju1990@163.com>
    qlcnic: Fix a sleep-in-atomic bug in qlcnic_82xx_hw_write_wx_2M and qlcnic_82xx_hw_read_wx_2M

Jiri Olsa <jolsa@kernel.org>
    perf trace: Add mmap alias for s390

Anilkumar Kolli <akolli@qti.qualcomm.com>
    ath10k: add BMI parameters to fix calibration from DT/pre-cal

Dan Carpenter <dan.carpenter@oracle.com>
    drm/amdkfd: NULL dereference involving create_process()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/spufs: Fix coredump of SPU contexts

Bryan O'Donoghue <pure.logic@nexus-software.ie>
    clk: Fix __set_clk_rates error print-string

Sudeep Holla <sudeep.holla@arm.com>
    clk: scpi: fix return type of __scpi_dvfs_round_rate

Roman Pen <roman.penyaev@profitbricks.com>
    KVM: SVM: do not zero out segment attributes if segment is unusable or not present

Masahiro Yamada <yamada.masahiro@socionext.com>
    mtd: nand: check ecc->total sanity in nand_scan_tail

Boris Brezillon <boris.brezillon@free-electrons.com>
    mtd: nand: gpmi: Fix gpmi_nand_init() error path

Maxime Ripard <maxime.ripard@free-electrons.com>
    dt-bindings: display: sun4i: Add allwinner,tcon-channel property

Maxime Ripard <maxime.ripard@free-electrons.com>
    drm/sun4i: Ignore the generic connectors for components

Alexandre Belloni <alexandre.belloni@free-electrons.com>
    clk: at91: fix clk-generated parenting

Gustavo A. R. Silva <garsilva@embeddedor.com>
    net: freescale: fix potential null pointer dereference

NeilBrown <neilb@suse.com>
    SUNRPC: ensure correct error is reported by xs_tcp_setup_socket()

Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
    rtc: interface: Validate alarm-time before handling rollover

Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
    rtc: opal: Handle disabled TPO in opal_get_tpo_time()

Jesse Brandeburg <jesse.brandeburg@intel.com>
    i40evf: fix merge error in older patch

Gary Bisson <gary.bisson@boundarydevices.com>
    rtc: m41t80: fix SQW dividers override when setting a date

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4: Fix netdev_features flag

Arjun Vynipadath <arjun@chelsio.com>
    cxgb4: FW upgrade fixes

Arnd Bergmann <arnd@arndb.de>
    net/mlx5: avoid build warning for uniprocessor

Will Deacon <will.deacon@arm.com>
    arm64: futex: Fix undefined behaviour with FUTEX_OP_OPARG_SHIFT usage

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    backlight: Report error on failure

Arvind Yadav <arvind.yadav.cs@gmail.com>
    dmaengine: imx-sdma: Handle return value of clk_prepare_enable

Ivan Mikhaylov <ivan@de.ibm.com>
    powerpc/[booke|4xx]: Don't clobber TCR[WP] when setting TCR[DIE]

Miklos Szeredi <mszeredi@redhat.com>
    ovl: filter trusted xattr for non-admin

Hans de Goede <hdegoede@redhat.com>
    HID: i2c: Call acpi_device_fix_up_power for ACPI-enumerated devices

Florian Westphal <fw@strlen.de>
    netfilter: conntrack: don't call iter for non-confirmed conntracks

Sai Praneeth <sai.praneeth.prakhya@intel.com>
    x86/efi: Disable runtime services on kexec kernel if booted with efi=old_map

Firo Yang <firogm@gmail.com>
    hdlcdrv: Fix divide by zero in hdlcdrv_ioctl

Colin Ian King <colin.king@canonical.com>
    wl1251: check return from call to wl1251_acx_arp_ip_filter

Stanislaw Gruszka <sgruszka@redhat.com>
    rt2x00: do not pause queue unconditionally on error path

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ASoC: Intel: sst: Fix the return value of 'sst_send_byte_stream_mrfld()'

Hans de Goede <hdegoede@redhat.com>
    pinctrl: baytrail: Enable glitch filter for GPIOs used as interrupts

Robert Jarzmik <robert.jarzmik@free.fr>
    backlight: tdo24m: Fix the SPI CS between transfers

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix race between updating nr_hw_queues and switching io sched

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/rdmavt: Allocate CQ memory on the correct node

Linus Walleij <linus.walleij@linaro.org>
    gpio: label descriptors using the device name

Pieter \"PoroCYon\" Sluys <pcy@national.shitposting.agency>
    vfb: fix video mode and line_length being set when loaded

Peter Große <pegro@friiks.de>
    mac80211: Fix setting TX power on monitor interfaces

Geert Uytterhoeven <geert+renesas@glider.be>
    ACPI: EC: Fix debugfs_create_*() usage

Shanker Donthineni <shankerd@codeaurora.org>
    irqchip/gic-v3: Fix the driver probe() fail due to disabled GICC entry

Chaitra P B <chaitra.basappa@broadcom.com>
    scsi: mpt3sas: Proper handling of set/clear of "ATA command pending" flag.

Rafael David Tinoco <rafael.tinoco@canonical.com>
    scsi: libiscsi: Allow sd_shutdown on bad transport

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: cht_bsw_rt5645: Analog Mic support

Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
    ASoC: Intel: Skylake: Disable clock gating during firmware and library download

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: videobuf2-core: don't go out of the buffer range

Maciej Purski <m.purski@samsung.com>
    hwmon: (ina2xx) Make calibration register value fixed

Gustavo A. R. Silva <garsilva@embeddedor.com>
    PM / devfreq: Fix potential NULL pointer dereference in governor_store

NeilBrown <neilb@suse.com>
    VFS: close race between getcwd() and d_move()

Moni Shoua <monis@mellanox.com>
    net/mlx4_en: Change default QoS settings

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Default lcd_only to true on Win8-ready and newer machines

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    rds; Reset rs->rs_bound_addr in rds_add_bound() failure path

Hangbin Liu <liuhangbin@gmail.com>
    l2tp: fix missing print session offset info

Masami Hiramatsu <mhiramat@kernel.org>
    perf probe: Add warning message if there is unexpected event name

Yi Zeng <yizeng@asrmicro.com>
    thermal: power_allocator: fix one race condition issue for thermal_instances list

Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    ARM: dts: ls1021a: add "fsl,ls1021a-esdhc" compatible string to esdhc node

Shiraz Saleem <shiraz.saleem@intel.com>
    i40iw: Correct Q1/XF object count equation

Shiraz Saleem <shiraz.saleem@intel.com>
    i40iw: Fix sequence number for the first partial FPDU

Jordan Crouse <jcrouse@codeaurora.org>
    drm/msm: Take the mutex before calling msm_gem_new_impl

linzhang <xiaolou4617@gmail.com>
    net: llc: add lock_sock in llc_ui_bind to avoid a race condition

Jan H. Schönherr <jschoenh@amazon.de>
    KVM: nVMX: Fix handling of lmsw instruction

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: X86: Fix preempt the preemption timer cancel

Christoph Hellwig <hch@lst.de>
    PCI/msi: fix the pci_alloc_irq_vectors_affinity stub

Thomas Gleixner <tglx@linutronix.de>
    cpuhotplug: Link lock stacks for hotplug callbacks

Nithin Sujir <nsujir@tintri.com>
    bonding: Don't update slave->link until ready to commit

KT Liao <kt.liao@emc.com.tw>
    Input: elan_i2c - clear INT before resetting controller

Roman Kapl <roman.kapl@sysgo.com>
    net: move somaxconn init from sysctl code

Eric Dumazet <edumazet@google.com>
    tcp: better validation of received ack sequences

Timmy Li <lixiaoping3@huawei.com>
    ARM64: PCI: Fix struct acpi_pci_root_ops allocation failure path

Eryu Guan <eguan@redhat.com>
    ext4: fix off-by-one on max nr_pages in ext4_find_unwritten_pgoff()

Michael Schmitz <schmitzmic@gmail.com>
    fix race in drivers/char/random.c:get_reg()

Maurizio Lombardi <mlombard@redhat.com>
    scsi: bnx2fc: fix race condition in bnx2fc_get_host_stats()

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: SSI PIO adjust to 24bit mode

Dan Carpenter <dan.carpenter@oracle.com>
    pNFS/flexfiles: missing error code in ff_layout_alloc_lseg()

Liping Zhang <zlpnobody@gmail.com>
    netfilter: ctnetlink: fix incorrect nf_ct_put during hash resize

Milian Wolff <milian.wolff@kdab.com>
    perf report: Fix off-by-one for non-activation frames

Dan Carpenter <dan.carpenter@oracle.com>
    libceph: NULL deref on crush_decode() error path

Lin Zhang <xiaolou4617@gmail.com>
    net: ieee802154: fix net_device reference release too early

Jesper Dangaard Brouer <brouer@redhat.com>
    mlx5: fix bug reading rss_hash_type from CQE

Dan Carpenter <dan.carpenter@oracle.com>
    block: fix an error code in add_partition()

Stephen Smalley <sds@tycho.nsa.gov>
    selinux: do not check open permission on sockets

Tariq Toukan <tariqt@mellanox.com>
    net/mlx5: Tolerate irq_set_affinity_hint() failures

Hans de Goede <hdegoede@redhat.com>
    gpio: crystalcove: Do not write regular gpio registers for virtual GPIOs

Vlastimil Babka <vbabka@suse.cz>
    sched/numa: Use down_read_trylock() for the mmap_sem

Dan Carpenter <dan.carpenter@oracle.com>
    perf/core: Fix error handling in perf_event_alloc()

Tin Huynh <tnhuynh@apm.com>
    leds: pca955x: Correct I2C Functionality

Holger Brunck <holger.brunck@keymile.com>
    net/wan/fsl_ucc_hdlc: fix muram allocation error

Kees Cook <keescook@chromium.org>
    ray_cs: Avoid reading past end of buffer

Suman Anna <s-anna@ti.com>
    ARM: davinci: da8xx: Create DSP device only when assigned memory

Guoqing Jiang <gqjiang@suse.com>
    md-cluster: fix potential lock issue in add_new_disk

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    ext4: handle the rest of ext4_mb_load_buddy() ENOMEM errors

Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
    iio: light: rpr0521 poweroff for probe fails

Nikita Yushchenko <nikita.yoush@cogentembedded.com>
    iio: hi8435: cleanup reset gpio

Nikita Yushchenko <nikita.yoush@cogentembedded.com>
    iio: hi8435: avoid garbage event at first enable

Stefan Agner <stefan@agner.ch>
    ASoC: simple-card: fix mic jack initialization

Antony Antony <antony@phenome.org>
    xfrm: fix state migration copy replay sequence numbers

Michael Ellerman <mpe@ellerman.id.au>
    selftests/powerpc: Fix TM resched DSCR test with some compilers

Colin Ian King <colin.king@canonical.com>
    ath5k: fix memory leak on buf on failed eeprom read

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix virt_addr_valid() etc. on 64-bit hash

Varun Prakash <varun@chelsio.com>
    scsi: csiostor: fix use after free in csio_hw_use_fwconfig()

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum: Avoid possible NULL pointer dereference

Geert Uytterhoeven <geert+renesas@glider.be>
    sh_eth: Use platform device for printing before register_netdev()

Holger Brunck <holger.brunck@keymile.com>
    fsl/qe: add bit description for SYNL register for GUMR

Holger Brunck <holger.brunck@keymile.com>
    net/wan/fsl_ucc_hdlc: fix incorrect memory allocation

Holger Brunck <holger.brunck@keymile.com>
    net/wan/fsl_ucc_hdlc: fix unitialized variable warnings

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: sh-sci: Fix race condition causing garbage during shutdown

Vignesh R <vigneshr@ti.com>
    serial: 8250: omap: Disable DMA for console UART

Alan Stern <stern@rowland.harvard.edu>
    USB: ene_usb6250: fix SCSI residue overwriting

linzhang <xiaolou4617@gmail.com>
    net: x25: fix one potential use-after-free issue

Alan Stern <stern@rowland.harvard.edu>
    USB: ene_usb6250: fix first command execution

Petr Cvek <petr.cvek@tul.cz>
    pxa_camera: fix module remove codepath for v4l2 clock

Jisheng Zhang <jszhang@marvell.com>
    usb: chipidea: properly handle host or gadget initialization failure

Sugar Zhang <sugar.zhang@rock-chips.com>
    ARM: dts: rockchip: fix rk322x i2s1 pinctrl error

Ihar Hrachyshka <ihrachys@redhat.com>
    arp: honour gratuitous ARP _replies_

Ihar Hrachyshka <ihrachys@redhat.com>
    neighbour: update neigh timestamps iff update is effective

Suman Anna <s-anna@ti.com>
    uio: fix incorrect memory leak cleanup

Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>
    ipmr: vrf: Find VIFs using the actual device

Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    ata: libahci: properly propagate return value of platform_get_irq()

Colin Ian King <colin.king@canonical.com>
    btrfs: fix incorrect error return ret being passed to mapping_set_error

Pan Bian <bianpan2016@163.com>
    usb: dwc3: keystone: check return value

James Morse <james.morse@arm.com>
    KVM: arm64: Restore host physical timer access on hyp_panic()

James Morse <james.morse@arm.com>
    KVM: arm: Restore banked registers and physical timer access on hyp_panic()

Anup Patel <anup.patel@broadcom.com>
    async_tx: Fix DMA_PREP_FENCE usage in do_async_gen_syndrome()

Mahesh Bandewar <maheshb@google.com>
    ipv6: avoid dad-failures for addresses with NODAD

Julia Lawall <julia.lawall@lip6.fr>
    mdio: mux: fix device_node_continue.cocci warnings

Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
    arm64: perf: Ignore exclude_hv when kernel is running in HYP

Peter Rosin <peda@axentia.se>
    i2c: mux: reg: put away the parent i2c adapter on probe failure

Fabio Estevam <fabio.estevam@nxp.com>
    ARM: dts: imx6qdl-wandboard: Fix audio channel swap

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/modules: If mprofile-kernel is enabled add it to vermagic

Peter Zijlstra <peterz@infradead.org>
    x86/tsc: Provide 'tsc=unstable' boot parameter

Geert Uytterhoeven <geert+renesas@glider.be>
    clk: renesas: rcar-gen2: Fix PLL0 on R-Car V2H and E2

Andrea della Porta <sfaragnaus@gmail.com>
    staging: wlan-ng: prism2mgmt.c: fixed a double endian conversion before calling hfa384x_drvr_setconfig16, also fixes relative sparse warning

Fabio Estevam <fabio.estevam@nxp.com>
    ARM: dts: imx53-qsrb: Pulldown PMIC IRQ pin

Nicholas Mc Guire <der.herr@hofr.at>
    iio: pressure: zpa2326: report interrupted case as failure

Dan Carpenter <dan.carpenter@oracle.com>
    PowerCap: Fix an error code in powercap_register_zone()

Doug Berger <opendmb@gmail.com>
    bus: brcmstb_gisb: correct support for 64-bit address output

Doug Berger <opendmb@gmail.com>
    bus: brcmstb_gisb: Use register offsets with writes too

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    SMB2: Fix share type handling

Reza Arbab <arbab@linux.vnet.ibm.com>
    mm, vmstat: Remove spurious WARN() during zoneinfo print

Neil Horman <nhorman@tuxdriver.com>
    vmxnet3: ensure that adapter is in proper state during force_close

MaJun <majun258@huawei.com>
    irqchip/mbigen: Fix the clear register offset calculation

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S PR: Check copy_to/from_user return values

KT Liao <kt.liao@emc.com.tw>
    Input: elantech - force relative mode on a certain module

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: elan_i2c - check if device is there before really probing

Jon Mason <jon.mason@broadcom.com>
    mdio: mux: Correct mdio_mux_init error path issues

Colin Ian King <colin.king@canonical.com>
    netxen_nic: set rcode to the return status from the call to netxen_issue_cmd

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Fix alignment issues in rx path

Wen Xiong <wenxiong@linux.vnet.ibm.com>
    blk-mq: NVMe 512B/4K+T10 DIF/DIX format returns I/O error on dd with split op

Will Deacon <will.deacon@arm.com>
    perf/callchain: Force USER_DS when invoking perf_callchain_user()

Rabin Vincent <rabinv@axis.com>
    CIFS: silence lockdep splat in cifs_relock_file()

Trond Myklebust <trond.myklebust@primarydata.com>
    NFSv4.1: Work around a Linux server bug...

Ram Amrani <Ram.Amrani@cavium.com>
    qed: Correct doorbell configuration for !4Kb pages

Talat Batheesh <talatb@mellanox.com>
    net/mlx4_en: Avoid adding steering rules with invalid ring

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390: move _text symbol to address higher than zero

Kirill Tkhai <ktkhai@virtuozzo.com>
    pidns: disable pid allocation if pid_ns_prepare_proc() is failed in alloc_pid()

Dan Carpenter <dan.carpenter@oracle.com>
    drivers/misc/vmw_vmci/vmci_queue_pair.c: fix a couple integer overflow tests

J. Bruce Fields <bfields@redhat.com>
    lockd: fix lockd shutdown race

Grygorii Strashko <grygorii.strashko@ti.com>
    net: ethernet: ti: cpsw: adjust cpsw fifos depth for fullduplex flow control

Jim Baxter <jim_baxter@mentor.com>
    net: cdc_ncm: Fix TX zero padding

Dan Carpenter <dan.carpenter@oracle.com>
    ipmi_ssif: unlock on allocation failure

Rabin Vincent <rabinv@axis.com>
    ubi: fastmap: Fix slab corruption

Kees Cook <keescook@chromium.org>
    qlge: Avoid reading past end of buffer

Kees Cook <keescook@chromium.org>
    bna: Avoid reading past end of buffer

Luca Coelho <luciano.coelho@intel.com>
    mac80211: bail out from prep_connection() if a reconfig is ongoing

Steffen Klassert <steffen.klassert@secunet.com>
    af_key: Fix slab-out-of-bounds in pfkey_compile_policy.

Bart Van Assche <bart.vanassche@sandisk.com>
    IB/srpt: Avoid that aborting a command triggers a kernel warning

Bart Van Assche <bart.vanassche@sandisk.com>
    IB/srpt: Fix abort handling

Kees Cook <keescook@chromium.org>
    x86/boot: Declare error() as noreturn

Trond Myklebust <trond.myklebust@primarydata.com>
    NFSv4.1: RECLAIM_COMPLETE must handle NFS4ERR_CONN_NOT_BOUND_TO_SESSION

Amir Goldstein <amir73il@gmail.com>
    ovl: persistent inode numbers for upper hardlinks

Matthias Kaehlcke <mka@chromium.org>
    x86/mm/kaslr: Use the _ASM_MUL macro for multiplication to work around Clang incompatibility

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/asm: Don't use RBP as a temporary register in csum_partial_copy_generic()

Pan Bian <bianpan2016@163.com>
    rtc: snvs: fix an incorrect check of return value

Julia Cartwright <julia@ni.com>
    md/raid5: make use of spin_lock_irq over local_irq_disable + spin_lock

Johannes Berg <johannes.berg@intel.com>
    cfg80211: make RATE_INFO_BW_20 the default

sudarsana.kalluru@cavium.com <sudarsana.kalluru@cavium.com>
    qed: Fix overriding of supported autoneg value.


-------------

Diffstat:

 .../bindings/clock/amlogic,meson8b-clkc.txt        | 11 ++-
 .../bindings/display/sunxi/sun4i-drm.txt           | 11 ++-
 Makefile                                           |  4 +-
 arch/arm/boot/dts/imx53-qsrb.dts                   |  2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  1 +
 arch/arm/boot/dts/ls1021a.dtsi                     |  2 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |  4 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |  2 +
 arch/arm/boot/dts/rk322x.dtsi                      |  6 +-
 arch/arm/include/asm/xen/events.h                  |  2 +-
 arch/arm/kvm/hyp/switch.c                          |  2 +
 arch/arm/mach-davinci/devices-da8xx.c              | 10 +++
 arch/arm/mach-imx/cpu.c                            |  3 +
 arch/arm/mach-imx/mxc.h                            |  6 ++
 arch/arm64/include/asm/futex.h                     |  8 +-
 arch/arm64/kernel/pci.c                            |  4 +-
 arch/arm64/kernel/perf_event.c                     | 23 +++--
 arch/arm64/kvm/hyp/switch.c                        |  1 +
 arch/arm64/mm/mmap.c                               | 19 +++--
 arch/mips/include/asm/kprobes.h                    |  3 +-
 arch/mips/include/asm/pgtable-32.h                 |  7 +-
 arch/mips/mm/pgtable-32.c                          |  6 +-
 arch/powerpc/include/asm/module.h                  |  4 +
 arch/powerpc/include/asm/page.h                    | 12 +++
 arch/powerpc/kernel/time.c                         | 14 +++-
 arch/powerpc/kvm/book3s_pr_papr.c                  | 34 ++++++--
 arch/powerpc/platforms/cell/spufs/coredump.c       |  2 +
 arch/powerpc/sysdev/mpc8xx_pic.c                   |  2 +-
 arch/s390/kernel/vmlinux.lds.S                     |  8 +-
 arch/sparc/kernel/ldc.c                            |  7 +-
 arch/x86/boot/compressed/error.h                   |  4 +-
 arch/x86/include/asm/asm.h                         |  1 +
 arch/x86/kernel/tsc.c                              |  2 +
 arch/x86/kvm/lapic.c                               |  2 +
 arch/x86/kvm/svm.c                                 | 24 +++---
 arch/x86/kvm/vmx.c                                 | 10 ++-
 arch/x86/lib/csum-copy_64.S                        | 12 +--
 arch/x86/lib/kaslr.c                               |  3 +-
 arch/x86/platform/efi/efi.c                        |  6 +-
 block/bio-integrity.c                              |  3 +
 block/blk-mq.c                                     | 11 ++-
 block/partition-generic.c                          |  4 +-
 crypto/asymmetric_keys/x509_cert_parser.c          |  1 +
 crypto/async_tx/async_pq.c                         |  5 +-
 drivers/acpi/acpi_video.c                          | 14 +++-
 drivers/acpi/acpica/evxfevnt.c                     | 18 ++++
 drivers/acpi/acpica/psobject.c                     | 14 ++++
 drivers/acpi/ec.c                                  |  2 +-
 drivers/acpi/ec_sys.c                              |  2 +-
 drivers/acpi/internal.h                            |  2 +-
 drivers/ata/libahci_platform.c                     |  5 +-
 drivers/block/loop.c                               |  3 +
 drivers/bus/brcmstb_gisb.c                         | 42 +++++-----
 drivers/char/ipmi/ipmi_ssif.c                      |  2 +
 drivers/char/random.c                              | 10 ++-
 drivers/clk/at91/clk-generated.c                   |  4 +-
 drivers/clk/clk-conf.c                             |  2 +-
 drivers/clk/clk-scpi.c                             |  6 +-
 drivers/clk/meson/Kconfig                          |  6 +-
 drivers/clk/meson/meson8b.c                        |  5 +-
 drivers/clk/renesas/clk-rcar-gen2.c                | 23 ++++-
 drivers/cpuidle/dt_idle_states.c                   |  4 +-
 drivers/crypto/omap-sham.c                         | 31 ++++---
 drivers/devfreq/devfreq.c                          |  3 +-
 drivers/dma/imx-sdma.c                             | 23 +++--
 drivers/edac/mv64x60_edac.c                        |  2 +-
 drivers/gpio/gpio-crystalcove.c                    | 54 ++++++++----
 drivers/gpio/gpiolib.c                             |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  3 +-
 drivers/gpu/drm/msm/msm_gem.c                      |  6 ++
 drivers/gpu/drm/omapdrm/omap_gem.c                 |  4 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  | 12 +++
 drivers/gpu/drm/vc4/vc4_gem.c                      | 13 +--
 drivers/hid/i2c-hid/i2c-hid.c                      | 13 +++
 drivers/hwmon/ina2xx.c                             | 87 +++++++++++--------
 drivers/hwtracing/coresight/coresight-tmc.c        |  7 ++
 drivers/hwtracing/coresight/coresight.c            | 15 +++-
 drivers/i2c/muxes/i2c-mux-reg.c                    | 17 ++--
 drivers/iio/adc/hi8435.c                           | 27 ++++--
 drivers/iio/light/rpr0521.c                        | 17 +++-
 drivers/iio/magnetometer/st_magn_spi.c             |  2 -
 drivers/iio/pressure/zpa2326.c                     | 18 ++--
 drivers/infiniband/hw/cxgb4/cm.c                   |  6 +-
 drivers/infiniband/hw/hfi1/sysfs.c                 |  3 +-
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c           |  6 +-
 drivers/infiniband/hw/i40iw/i40iw_d.h              |  1 +
 drivers/infiniband/hw/i40iw/i40iw_puda.c           |  2 +-
 drivers/infiniband/sw/rdmavt/cq.c                  | 10 ++-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  9 +-
 drivers/input/mouse/elan_i2c_core.c                |  7 ++
 drivers/input/mouse/elan_i2c_i2c.c                 |  9 +-
 drivers/input/mouse/elantech.c                     | 11 +++
 drivers/input/touchscreen/goodix.c                 |  8 +-
 drivers/irqchip/irq-gic-v3.c                       | 11 +++
 drivers/irqchip/irq-mbigen.c                       |  5 +-
 drivers/isdn/mISDN/stack.c                         |  2 +-
 drivers/leds/leds-pca955x.c                        |  2 +-
 drivers/md/bcache/alloc.c                          | 19 +++--
 drivers/md/bcache/super.c                          |  6 ++
 drivers/md/md-cluster.c                            |  4 +-
 drivers/md/raid5.c                                 | 17 ++--
 drivers/media/i2c/cx25840/cx25840-core.c           | 36 ++++----
 drivers/media/platform/pxa_camera.c                | 14 +++-
 drivers/media/rc/mceusb.c                          |  9 +-
 drivers/media/v4l2-core/videobuf2-core.c           |  4 +
 drivers/misc/cxl/flash.c                           |  8 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            | 10 ++-
 drivers/mmc/host/sdhci-pci-core.c                  |  2 +
 drivers/mmc/host/sdhci.c                           |  7 ++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             | 10 ++-
 drivers/mtd/nand/nand_base.c                       |  5 ++
 drivers/mtd/tests/oobtest.c                        | 21 +++++
 drivers/mtd/ubi/fastmap.c                          | 33 +++++++-
 drivers/net/bonding/bond_main.c                    | 84 ++++++++++---------
 drivers/net/ethernet/amazon/ena/ena_com.c          | 35 ++++----
 drivers/net/ethernet/amazon/ena/ena_netdev.c       | 17 +++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    | 19 ++++-
 drivers/net/ethernet/brocade/bna/bfa_ioc.c         |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    | 11 +++
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         | 32 ++++++-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c         | 23 +++--
 drivers/net/ethernet/freescale/fec_main.c          |  4 +
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |  9 +-
 drivers/net/ethernet/ibm/emac/core.c               | 26 +++++-
 drivers/net/ethernet/intel/e1000e/netdev.c         | 17 +++-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  1 +
 drivers/net/ethernet/intel/igb/igb_ptp.c           | 12 ++-
 drivers/net/ethernet/marvell/sky2.c                |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c     | 77 ++++++++++-------
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    | 33 ++++----
 drivers/net/ethernet/mellanox/mlx4/en_main.c       |  4 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |  7 ++
 drivers/net/ethernet/mellanox/mlx4/mcg.c           | 15 +++-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |  1 +
 drivers/net/ethernet/mellanox/mlx4/qp.c            | 19 +++++
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  | 17 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 10 +--
 drivers/net/ethernet/mellanox/mlx5/core/main.c     | 14 +---
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  6 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_ctx.c    |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |  5 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c         |  6 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.h          |  1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c     |  2 +-
 drivers/net/ethernet/qlogic/qlge/qlge_dbg.c        |  4 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            | 10 ++-
 drivers/net/ethernet/realtek/r8169.c               |  4 +-
 drivers/net/ethernet/renesas/sh_eth.c              |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 15 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h   |  3 +-
 drivers/net/ethernet/ti/cpsw.c                     | 16 ++++
 drivers/net/geneve.c                               | 36 +++++---
 drivers/net/hamradio/hdlcdrv.c                     |  2 +
 drivers/net/macsec.c                               | 13 ++-
 drivers/net/phy/mdio-mux.c                         | 11 +--
 drivers/net/phy/micrel.c                           | 42 ++++++----
 drivers/net/phy/phy.c                              |  6 ++
 drivers/net/ppp/pptp.c                             |  1 -
 drivers/net/team/team.c                            | 12 ++-
 drivers/net/usb/cdc_ncm.c                          | 11 ++-
 drivers/net/virtio_net.c                           | 16 +++-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  5 ++
 drivers/net/vrf.c                                  |  8 +-
 drivers/net/vxlan.c                                |  2 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     | 18 ++--
 drivers/net/wireless/ath/ath10k/bmi.h              |  2 +
 drivers/net/wireless/ath/ath10k/core.c             | 16 +++-
 drivers/net/wireless/ath/ath5k/debug.c             |  5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-7000.c      |  4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-8000.c      |  4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c    | 12 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       | 32 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |  8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  6 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     | 22 +++--
 drivers/net/wireless/ray_cs.c                      |  7 +-
 drivers/net/wireless/ti/wl1251/main.c              |  3 +-
 drivers/nvme/host/core.c                           |  4 +
 drivers/nvme/host/pci.c                            | 13 ++-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |  6 ++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c         |  1 -
 drivers/powercap/powercap_sys.c                    |  1 +
 drivers/rtc/interface.c                            |  9 +-
 drivers/rtc/rtc-m41t80.c                           | 12 +++
 drivers/rtc/rtc-opal.c                             | 10 +++
 drivers/rtc/rtc-snvs.c                             |  2 +-
 drivers/s390/block/dasd.c                          |  8 +-
 drivers/scsi/bnx2fc/bnx2fc.h                       |  1 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  | 10 ++-
 drivers/scsi/csiostor/csio_hw.c                    |  5 +-
 drivers/scsi/libiscsi.c                            | 24 +++++-
 drivers/scsi/libsas/sas_expander.c                 |  4 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               | 28 ++++---
 drivers/staging/wlan-ng/prism2mgmt.c               |  2 +-
 drivers/thermal/power_allocator.c                  |  2 +
 drivers/tty/n_gsm.c                                | 17 +++-
 drivers/tty/serial/8250/8250_omap.c                |  4 +
 drivers/tty/serial/sccnxp.c                        | 15 ++--
 drivers/tty/serial/sh-sci.c                        | 16 +++-
 drivers/uio/uio.c                                  |  8 +-
 drivers/usb/chipidea/core.c                        | 29 +++++--
 drivers/usb/dwc3/dwc3-keystone.c                   |  4 +
 drivers/usb/storage/ene_ub6250.c                   | 11 ++-
 drivers/vhost/net.c                                |  4 +-
 drivers/vhost/vhost.c                              | 17 ++--
 drivers/video/backlight/backlight.c                | 15 ++--
 drivers/video/backlight/corgi_lcd.c                |  2 +-
 drivers/video/backlight/tdo24m.c                   |  2 +-
 drivers/video/backlight/tosa_lcd.c                 |  2 +-
 drivers/video/fbdev/vfb.c                          | 17 ++++
 drivers/watchdog/Kconfig                           |  7 +-
 drivers/watchdog/f71808e_wdt.c                     | 27 ++++--
 fs/btrfs/extent_io.c                               |  2 +-
 fs/cifs/file.c                                     |  2 +-
 fs/cifs/smb2pdu.c                                  | 14 ++--
 fs/dcache.c                                        | 23 +++--
 fs/ext4/file.c                                     |  2 +-
 fs/ext4/mballoc.c                                  | 23 +++--
 fs/lockd/svc.c                                     |  6 +-
 fs/nfs/flexfilelayout/flexfilelayout.c             |  1 +
 fs/nfs/nfs4proc.c                                  | 13 ++-
 fs/nfs/nfs4state.c                                 | 10 ++-
 fs/overlayfs/dir.c                                 |  3 +
 fs/overlayfs/inode.c                               | 12 ++-
 include/acpi/platform/acgcc.h                      | 10 +++
 include/acpi/platform/acintel.h                    |  2 +
 include/linux/mlx4/qp.h                            |  1 +
 include/linux/mlx5/device.h                        | 10 ++-
 include/linux/pci.h                                |  6 +-
 include/linux/sched.h                              |  1 +
 include/linux/skbuff.h                             |  8 +-
 include/net/cfg80211.h                             |  2 +-
 include/net/x25.h                                  |  4 +-
 include/soc/fsl/qe/qe.h                            |  4 +
 kernel/cpu.c                                       | 13 +++
 kernel/events/callchain.c                          |  6 ++
 kernel/events/core.c                               | 19 +++--
 kernel/pid.c                                       |  4 +-
 kernel/sched/core.c                                |  2 +
 kernel/sched/deadline.c                            | 98 +++++++++++++++++++---
 kernel/sched/fair.c                                |  3 +-
 mm/vmstat.c                                        |  2 -
 net/8021q/vlan_dev.c                               |  6 +-
 net/bluetooth/hci_core.c                           | 17 +++-
 net/ceph/osdmap.c                                  |  1 +
 net/core/dev.c                                     |  4 +-
 net/core/neighbour.c                               | 14 +++-
 net/core/net_namespace.c                           | 19 +++++
 net/core/skbuff.c                                  | 75 +++++++++++------
 net/core/sysctl_net_core.c                         |  2 -
 net/hsr/hsr_forward.c                              |  3 +-
 net/hsr/hsr_framereg.c                             |  9 +-
 net/hsr/hsr_framereg.h                             |  2 +-
 net/ieee802154/socket.c                            |  8 +-
 net/ipv4/ah4.c                                     |  8 +-
 net/ipv4/arp.c                                     | 18 +++-
 net/ipv4/esp4.c                                    | 13 +--
 net/ipv4/fib_semantics.c                           | 20 +++--
 net/ipv4/ip_tunnel.c                               | 11 +--
 net/ipv4/ipmr.c                                    | 18 +++-
 net/ipv4/tcp_input.c                               | 24 +++---
 net/ipv6/addrconf.c                                |  5 +-
 net/ipv6/ah6.c                                     |  8 +-
 net/ipv6/esp6.c                                    | 12 ++-
 net/ipv6/ip6_gre.c                                 |  8 +-
 net/ipv6/ip6_output.c                              | 20 +++--
 net/ipv6/ip6_tunnel.c                              | 14 +++-
 net/ipv6/ip6_vti.c                                 |  7 +-
 net/ipv6/route.c                                   |  3 +
 net/ipv6/sit.c                                     |  9 +-
 net/key/af_key.c                                   |  2 +-
 net/l2tp/l2tp_netlink.c                            |  2 +
 net/llc/af_llc.c                                   |  3 +
 net/mac80211/cfg.c                                 | 28 ++++++-
 net/mac80211/driver-ops.h                          |  3 +-
 net/mac80211/mlme.c                                |  4 +
 net/netfilter/nf_conntrack_core.c                  | 39 ++++++---
 net/netfilter/nf_conntrack_netlink.c               |  7 +-
 net/netlink/af_netlink.c                           |  3 +
 net/rds/bind.c                                     |  1 +
 net/rxrpc/rxkad.c                                  | 19 +++--
 net/sched/act_api.c                                |  4 +-
 net/sched/act_bpf.c                                | 12 ++-
 net/sched/act_skbmod.c                             |  3 +-
 net/sched/act_tunnel_key.c                         |  9 +-
 net/sctp/ipv6.c                                    |  4 +-
 net/sctp/socket.c                                  | 17 ++--
 net/strparser/strparser.c                          |  4 +-
 net/sunrpc/xprtsock.c                              |  7 +-
 net/x25/af_x25.c                                   | 24 ++++--
 net/x25/sysctl_net_x25.c                           |  5 +-
 net/xfrm/xfrm_state.c                              |  2 +
 scripts/tags.sh                                    |  1 +
 security/selinux/hooks.c                           | 10 ++-
 sound/soc/generic/simple-card.c                    |  2 +-
 sound/soc/intel/atom/sst/sst_stream.c              |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |  7 ++
 sound/soc/intel/skylake/skl-messages.c             |  4 +
 sound/soc/intel/skylake/skl-pcm.c                  |  4 +
 sound/soc/sh/rcar/ssi.c                            | 11 ++-
 tools/perf/builtin-trace.c                         |  4 +
 tools/perf/tests/code-reading.c                    | 20 ++++-
 tools/perf/util/dso.c                              | 16 ++++
 tools/perf/util/header.c                           | 12 ++-
 tools/perf/util/probe-event.c                      |  8 ++
 tools/perf/util/unwind-libdw.c                     | 14 +++-
 tools/perf/util/unwind-libunwind-local.c           | 11 +++
 tools/perf/util/util.c                             |  2 +-
 .../testing/selftests/powerpc/tm/tm-resched-dscr.c |  2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  2 +-
 312 files changed, 2424 insertions(+), 917 deletions(-)
