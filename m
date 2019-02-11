Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CEEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F68F222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894884;
	bh=UsA6IFE2AW3fSAJbfhqrVProGhHHl6QXU8my9iteyYY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SxLugVjIFJUMZ44K/6HFwekjcFbPnBikp1lW/RBH+qXgKPP3/fPjbL+qmtf5hOxFC
	 JudV+xkTHWdPfnhGDF0auroVXbyT1FNLraVh4mrM9y+pVxDPFnHZ4J19XIHzsrWp/O
	 qmlttj+dY74dq6yYqbdOOBOwelJ9O8VhSdmVSVis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfBKOVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:21:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbfBKOVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2034222AA;
        Mon, 11 Feb 2019 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894878;
        bh=UsA6IFE2AW3fSAJbfhqrVProGhHHl6QXU8my9iteyYY=;
        h=From:To:Cc:Subject:Date:From;
        b=XeWIpIRiK4Uh3jiQxFnO8xZmfpX9JL93h99CrBR3jP6TF0qnnFgWrTiR2DiF7NMRD
         2QIErKEZo4ackPh4EMwJsR7LE1wPfn5VFIC/H2z3xPBBB6RfqHmZUxP98sOcKGSkVu
         RE6rDxYgjASQKcTYKCHF15xZW+8S21Nzss9hMYnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.20 000/352] 4.20.8-stable review
Date:   Mon, 11 Feb 2019 15:13:47 +0100
Message-Id: <20190211141846.543045703@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.8-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.20.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.20.8-rc1
X-KernelTest-Deadline: 2019-02-13T14:19+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.20.8 release.
There are 352 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 13 14:17:03 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.8-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.20.8-rc1

Trond Myklebust <trondmy@gmail.com>
    nfsd: Fix error return values for nfsd4_clone_file_range()

Huacai Chen <chenhc@lemote.com>
    cacheinfo: Keep the old value if of_property_read_u32 fails

Chris Brandt <chris.brandt@renesas.com>
    serial: sh-sci: Do not free irqs that have already been freed

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_pci: Make PCI class test non fatal

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    serial: fix race between flush_to_ldisc and tty_open

Gustavo A. R. Silva <gustavo@embeddedor.com>
    perf tests evsel-tp-sched: Fix bitwise operator

Mark Rutland <mark.rutland@arm.com>
    perf/core: Don't WARN() for impossible ring-buffer sizes

Tony Luck <tony.luck@intel.com>
    x86/MCE: Initialize mce.bank in the case of a fatal error in mce_no_way_out()

Peter Zijlstra <peterz@infradead.org>
    perf/x86/intel: Delay memory deallocation until x86_pmu_dead_cpu()

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Add Node ID mask

Josh Poimboeuf <jpoimboe@redhat.com>
    cpu/hotplug: Fix "SMT disabled by BIOS" detection for KVM

Peter Shier <pshier@google.com>
    KVM: nVMX: unconditionally cancel preemption timer in free_nested (CVE-2019-7221)

Jann Horn <jannh@google.com>
    kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: work around leak of uninitialized stack contents (CVE-2019-7222)

James Bottomley <James.Bottomley@HansenPartnership.com>
    scsi: aic94xx: fix module loading

Vaibhav Jain <vaibhav@linux.ibm.com>
    scsi: cxlflash: Prevent deadlock when adapter probe fails

Damien Le Moal <damien.lemoal@wdc.com>
    scsi: sd_zbc: Fix zone information messages

Johan Hovold <johan@kernel.org>
    staging: speakup: fix tty-operation NULL derefs

Paul Elder <paul.elder@ideasonboard.com>
    usb: gadget: musb: fix short isoc packets with inventra dma

Gustavo A. R. Silva <gustavo@embeddedor.com>
    usb: gadget: udc: net2272: Fix bitwise and boolean operations

Tejas Joglekar <tejas.joglekar@synopsys.com>
    usb: dwc3: gadget: Handle 0 xfer length for OUT EP

Bin Liu <b-liu@ti.com>
    usb: phy: am335x: fix race condition in _probe

Jernej Skrabec <jernej.skrabec@siol.net>
    arm64: dts: allwinner: a64: Fix USB OTG regulator

Marc Zyngier <marc.zyngier@arm.com>
    irqchip/gic-v3-its: Plug allocation race for devices sharing a DevID

Thomas Gleixner <tglx@linutronix.de>
    futex: Handle early deadlock return correctly

Leonid Iziumtsev <leonid.iziumtsev@gmail.com>
    dmaengine: imx-dma: fix wrong callback invoke

Lukas Wunner <lukas@wunner.de>
    dmaengine: bcm2835: Fix abort of transactions

Lukas Wunner <lukas@wunner.de>
    dmaengine: bcm2835: Fix interrupt race on RT

Vladis Dronov <vdronov@redhat.com>
    HID: debug: fix the ring buffer implementation

Miklos Szeredi <mszeredi@redhat.com>
    cuse: fix ioctl

Miklos Szeredi <mszeredi@redhat.com>
    fuse: handle zero sized retrieve correctly

Miklos Szeredi <mszeredi@redhat.com>
    fuse: decrement NR_WRITEBACK_TEMP on the right page

Jann Horn <jannh@google.com>
    fuse: call pipe_buf_release() under pipe lock

Jeremy Soller <jeremy@system76.com>
    ALSA: hda/realtek - Headset microphone support for System76 darp5

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Use a common helper for hp pin reference

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fix lose hp_pins for disable auto mute

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Serialize codec registrations

Udo Eberhardt <udo.eberhardt@thesycon.de>
    ALSA: usb-audio: Add support for new T+A USB DAC

Charles Keepax <ckeepax@opensource.cirrus.com>
    ALSA: compress: Fix stop handling on compressed capture streams

Brian Foster <bfoster@redhat.com>
    xfs: eof trim writeback mapping as soon as it is cached

Cong Wang <xiyou.wangcong@gmail.com>
    net/mlx5e: Force CHECKSUM_UNNECESSARY for short ethernet frames

Guy Shattah <sguy@mellanox.com>
    net/mlx5e: Use the inner headers to determine tc/pedit offload limitation on decap flows

Arun Parameswaran <arun.parameswaran@broadcom.com>
    net: dsa: b53: Fix for failure when irq is not defined in dt

Petr Machata <petrm@mellanox.com>
    net: cls_flower: Remove filter from mask before freeing it

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Disable interrupts when allocating CP rings or NQs.

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Account for tx bytes and packets on sending xdp_frames

Dan Carpenter <dan.carpenter@oracle.com>
    skge: potential memory corruption in skge_get_regs()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    sctp: walk the list of asoc safely

Xin Long <lucien.xin@gmail.com>
    sctp: check and update stream->out_curr when allocating stream_out

Eric Dumazet <edumazet@google.com>
    rxrpc: bad unlock balance in rxrpc_recvmsg

Russell King <rmk+kernel@armlinux.org.uk>
    Revert "net: phy: marvell: avoid pause mode on SGMII-to-Copper for 88e151x"

Eric Dumazet <edumazet@google.com>
    rds: fix refcount bug in rds_sock_addref

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Fix WoL with password after deep sleep

Rundong Ge <rdong.ge@gmail.com>
    net: dsa: slave: Don't propagate flag changes on down slave interfaces

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Fix counting of ATU violations

Dan Carpenter <dan.carpenter@oracle.com>
    net: dsa: Fix NULL checking in dsa_slave_set_eee()

Marc Zyngier <marc.zyngier@arm.com>
    net: dsa: Fix lockdep false positive splat

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    net: dp83640: expire old TX-skb

Bart Van Assche <bvanassche@acm.org>
    lib/test_rhashtable: Make test_insert_dup() allocate its hash table dynamically

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: fix checksum validation for IPv6

Eric Dumazet <edumazet@google.com>
    dccp: fool proof ccid_hc_[rt]x_parse_options()

Eduardo Valentin <edubezval@gmail.com>
    thermal: hwmon: inline helpers when CONFIG_THERMAL_HWMON is not set

Chuck Lever <chuck.lever@oracle.com>
    xprtrdma: Don't wake pending tasks until disconnect is done

Du Changbin <changbin.du@gmail.com>
    scripts/gdb: fix lx-version string output

Anders Roxell <anders.roxell@linaro.org>
    kernel/kcov.c: mark write_comp_data() as notrace

Oleg Nesterov <oleg@redhat.com>
    exec: load_script: don't blindly truncate shebang string

Davidlohr Bueso <dave@stgolabs.net>
    fs/epoll: drop ovflist branch prediction

Liu, Chuansheng <chuansheng.liu@intel.com>
    kernel/hung_task.c: force console verbose before panic

Cheng Lin <cheng.lin130@zte.com.cn>
    proc/sysctl: fix return error for proc_doulongvec_minmax()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    kernel/hung_task.c: break RCU locks based on jiffies

Benjamin Gordon <bmgordon@google.com>
    fs/proc/base.c: use ns_capable instead of capable for timerslack_ns

Dave Martin <Dave.Martin@arm.com>
    arm64/sve: ptrace: Fix SVE_PT_REGS_OFFSET definition

Aditya Pakki <pakki001@umn.edu>
    HID: lenovo: Add checks to fix of_led_classdev_register

Bjorn Andersson <bjorn.andersson@linaro.org>
    thermal: generic-adc: Fix adc to temp interpolation

Finn Thain <fthain@telegraphics.com.au>
    block/swim3: Fix regression on PowerBook G3

Richard Zhu <hongxing.zhu@nxp.com>
    PCI: imx: Enable MSI from downstream components

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    thermal: tsens: qcom: do not create duplicate regmap debugfs entries

Douglas Anderson <dianders@chromium.org>
    kdb: Don't back trace on a cpu that didn't round up

Matthias Brugger <mbrugger@suse.com>
    thermal: bcm2835: enable hwmon explicitly

Finn Thain <fthain@telegraphics.com.au>
    block/swim3: Fix -EBUSY error when re-opening device after unmount

Scott Wood <oss@buserror.net>
    fsl/fman: Use GFP_ATOMIC in {memac,tgec}_add_hash_mac_address()

Wenwen Wang <wang6495@umn.edu>
    gdrom: fix a memory leak bug

Jia-Ju Bai <baijiaju1990@gmail.com>
    isdn: hisax: hfc_pci: Fix a possible concurrency use-after-free bug in HFCPCI_l1hw()

Minchan Kim <minchan@kernel.org>
    zram: fix lockdep warning of free block handling

Waiman Long <longman@redhat.com>
    mm/page_alloc.c: don't call kasan_free_pages() at deferred mem init

Larry Chen <lchen@suse.com>
    ocfs2: improve ocfs2 Makefile

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: don't clear bh uptodate for block read

Randy Dunlap <rdunlap@infradead.org>
    arch/sh/boards/mach-kfr2r09/setup.c: fix struct mtd_oob_ops build warning

Marc Zyngier <marc.zyngier@arm.com>
    scripts/decode_stacktrace: only strip base path when a prefix of the path

Jiri Olsa <jolsa@kernel.org>
    perf python: Do not force closing original perf descriptor in evlist.get_pollfd()

Ondrej Mosnacek <omosnace@redhat.com>
    cgroup: fix parsing empty mount option string

Sahitya Tummala <stummala@codeaurora.org>
    f2fs: fix sbi->extent_list corruption issue

Kangjie Lu <kjlu@umn.edu>
    niu: fix missing checks of niu_pci_eeprom_read

Anton Ivanov <anton.ivanov@cambridgegreys.com>
    um: Avoid marking pages with "changed protection"

Sahitya Tummala <stummala@codeaurora.org>
    f2fs: fix use-after-free issue when accessing sbi->stat_info

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: check ntwrk_buf_start for NULL before dereferencing it

Stefan Roese <sr@denx.de>
    MIPS: ralink: Select CONFIG_CPU_MIPSR2_IRQ_VI on MT7620/8

Nathan Chancellor <natechancellor@gmail.com>
    crypto: ux500 - Use proper enum in hash_set_dma_transfer

Nathan Chancellor <natechancellor@gmail.com>
    crypto: ux500 - Use proper enum in cryp_set_dma_transfer

Michael Ellerman <mpe@ellerman.id.au>
    seq_buf: Make seq_buf_puts() null-terminate the buffer

Kangjie Lu <kjlu@umn.edu>
    hwmon: (lm80) fix a missing check of bus read in lm80 probe

Kangjie Lu <kjlu@umn.edu>
    hwmon: (lm80) fix a missing check of the status of SMBus read

Stanislav Fomichev <sdf@google.com>
    perf build: Don't unconditionally link the libbfd feature test to -liberty and -lz

Chris Perl <cperl@janestreet.com>
    NFS: nfs_compare_mount_options always compare auth flavors.

Jim Mattson <jmattson@google.com>
    kvm: Change offset in kvm_write_guest_offset_cached to unsigned

Vitaly Kuznetsov <vkuznets@redhat.com>
    selftests: kvm: report failed stage when exit reason is unexpected

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/fadump: Do not allow hot-remove memory from fadump reserved area.

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: x86: svm: report MSR_IA32_MCG_EXT_CTL as unsupported

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    pinctrl: meson: meson8b: fix the GPIO function for the GPIOAO pins

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    pinctrl: meson: meson8: fix the GPIO function for the GPIOAO pins

John Fastabend <john.fastabend@gmail.com>
    bpf: sk_msg, fix socket data_ready events

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/mm: Fix reporting of kernel execute faults on the 8xx

John Fastabend <john.fastabend@gmail.com>
    bpf: sk_msg, zap ingress queue on psock down

Noralf Trønnes <noralf@tronnes.org>
    fbdev: fbcon: Fix unregister crash when more than one framebuffer

Lenny Szubowicz <lszubowi@redhat.com>
    ACPI/APEI: Clear GHES block_status before panic()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    igb: Fix an issue that PME is not enabled during runtime suspend

Young Xiao <YangX92@hotmail.com>
    ice: Do not enable NAPI on q_vectors that have no rings

Konstantin Khorenko <khorenko@virtuozzo.com>
    i40e: define proper net_device::neigh_priv_len

Peter Rosin <peda@axentia.se>
    fbdev: fbmem: behave better with small rotated displays and many CPUs

Guoqing Jiang <gqjiang@suse.com>
    md: fix raid10 hang issue caused by barrier

Alexey Khoroshilov <khoroshilov@ispras.ru>
    video: clps711x-fb: release disp device node in probe()

Wenjing Liu <Wenjing.Liu@amd.com>
    drm/amd/display: validate extended dongle caps

Zhi Chen <zhichen@codeaurora.org>
    ath10k: fix tx_stats memory leak

Karthikeyan Periyasamy <periyasa@codeaurora.org>
    ath10k: fix kernel panic due to use after free

Nathan Chancellor <natechancellor@gmail.com>
    drbd: Avoid Clang warning about pointless switch statment

Lars Ellenberg <lars.ellenberg@linbit.com>
    drbd: skip spurious timeout (ping-timeo) when failing promote

Lars Ellenberg <lars.ellenberg@linbit.com>
    drbd: disconnect, if the wrong UUIDs are attached on a connected peer

Roland Kammerer <roland.kammerer@linbit.com>
    drbd: narrow rcu_read_lock in drbd_sync_handshake

Miroslav Lichvar <mlichvar@redhat.com>
    mlx5: update timecounter at least twice per counter overflow

Alexey Kardashevskiy <aik@ozlabs.ru>
    powerpc/powernv/ioda: Allocate indirect TCE levels of cached userspace addresses on demand

Naftali Goldstein <naftali.goldstein@intel.com>
    iwlwifi: mvm: fix setting HE ppe FW config

Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
    powerpc/perf: Fix thresholding counter data for unknown type

Jian Shen <shenjian15@huawei.com>
    net: hns3: don't restore rules when flow director is disabled

Peng Li <lipeng321@huawei.com>
    net: hns3: fix the descriptor index when get rss type

Jian Shen <shenjian15@huawei.com>
    net: hns3: add max vector number check for pf

Jia-Ju Bai <baijiaju1990@gmail.com>
    cw1200: Fix concurrency use-after-free bugs in cw1200_hw_scan()

Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
    scsi: smartpqi: increase fw status register read timeout

Dave Carroll <david.carroll@microsemi.com>
    scsi: smartpqi: correct volume status

Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
    scsi: smartpqi: correct host serial num for ssa

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum: Properly cleanup LAG uppers when removing port from LAG

YueHaibing <yuehaibing@huawei.com>
    xfrm6_tunnel: Fix spi check in __xfrm6_tunnel_alloc_spi

Johannes Berg <johannes.berg@intel.com>
    mac80211: fix radiotap vendor presence bitmap handling

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/uaccess: fix warning/error with access_ok()

Eric Yang <Eric.Yang2@amd.com>
    drm/amd/display: fix YCbCr420 blank color

Chen-Yu Tsai <wens@csie.org>
    Bluetooth: hci_bcm: Handle deferred probing for the clock supply

Dale Zhao <dale.zhao@amd.com>
    drm/amd/display: Wait edp HPD to high in detect_sink

Paul Hsieh <paul.hsieh@amd.com>
    drm/amd/display: Add retry to read ddc_clock pin

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns3: fix incomplete uninitialization of IRQ in the hns3_nic_uninit_vector_data()

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns3: fix error handling int the hns3_get_vector_ring_chain

Dennis Zhou <dennis@kernel.org>
    percpu: convert spin_lock_irq to spin_lock_irqsave.

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf tools: Cast off_t to s64 to avoid warning on bionic libc

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf header: Fix up argument to ctime()

Bin Liu <b-liu@ti.com>
    usb: musb: dsps: fix runtime pm for peripheral mode

Bin Liu <b-liu@ti.com>
    usb: musb: dsps: fix otg state machine

Mark Rutland <mark.rutland@arm.com>
    arm64: KVM: Skip MMIO insn after emulation

Nicholas Mc Guire <hofrat@osadl.org>
    livepatch: check kzalloc return values

Ilan Peer <ilan.peer@intel.com>
    mac80211: Properly handle SKB with radiotap only

Nicholas Mc Guire <hofrat@osadl.org>
    pinctrl: rza1: Handle devm_kasprintf() failure cases

Doug Smythies <doug.smythies@gmail.com>
    tools/power/x86/intel_pstate_tracer: Fix non root execution for post processing a trace file

Michael Mueller <mimu@linux.ibm.com>
    KVM: s390: unregister debug feature on failing arch init

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Disable MSIX before re-reserving NQs/CMPL rings.

Fabrizio Castro <fabrizio.castro@bp.renesas.com>
    i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf probe: Fix unchecked usage of strncpy()

Ethan Lien <ethanlien@synology.com>
    btrfs: use tagged writepage to mitigate livelock of snapshot

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf header: Fix unchecked usage of strncpy()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf dso: Fix unchecked usage of strncpy()

Adrian Hunter <adrian.hunter@intel.com>
    perf test: Fix perf_event_attr test failure

Stephane Eranian <eranian@google.com>
    perf stat: Fix CSV mode column output for non-cgroup events

Beomho Seo <beomho.seo@samsung.com>
    tty: serial: samsung: Properly set flags in autoCTS mode

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: sh-sci: Resume PIO in sci_rx_interrupt() on DMA failure

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: sh-sci: Fix locking in sci_submit_rx()

David Sterba <dsterba@suse.com>
    btrfs: reada: reorder dev-replace locks before radix tree preload

Anand Jain <anand.jain@oracle.com>
    btrfs: harden agaist duplicate fsid on scanned devices

Fabrizio Castro <fabrizio.castro@bp.renesas.com>
    usb: renesas_usbhs: add support for RZ/G2E

Linus Walleij <linus.walleij@linaro.org>
    mmc: jz4740: Get CD/WP GPIOs from descriptors

Adrian Hunter <adrian.hunter@intel.com>
    mmc: sdhci-xenon: Fix timeout checks

Adrian Hunter <adrian.hunter@intel.com>
    mmc: sdhci-omap: Fix timeout checks

Adrian Hunter <adrian.hunter@intel.com>
    mmc: sdhci-of-esdhc: Fix timeout checks

Kai-Heng Feng <kai.heng.feng@canonical.com>
    memstick: Prevent memstick host from getting runtime suspended during card detection

Nicholas Mc Guire <hofrat@osadl.org>
    mmc: meson-mx-sdio: check devm_kasprintf for failure

Michal Suchanek <msuchanek@suse.de>
    mmc: bcm2835: reset host on timeout

Phil Elwell <phil@raspberrypi.org>
    mmc: bcm2835: Recover from MMC_SEND_EXT_CSD

Suraj Jitindar Singh <sjitindarsingh@gmail.com>
    KVM: PPC: Book3S: Only report KVM_CAP_SPAPR_TCE_VFIO on powernv machines

Quentin Monnet <quentin.monnet@netronome.com>
    tools: bpftool: fix -Wmissing declaration warnings

David Ahern <dsahern@gmail.com>
    ipv6: Fix handling of LLA with VRF and sockets bound to VRF

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to reorder set_page_dirty and wait_on_page_writeback

Jeffrey Hugo <jhugo@codeaurora.org>
    clk: qcom: Leave mmss noc on for 8998

Tom Murphy <murphyt7@tcd.ie>
    fix dma-buf/udmabuf selftest

Arnd Bergmann <arnd@arndb.de>
    ARM: mmp: fix timer_init calls

Fabio Estevam <festevam@gmail.com>
    ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M

Arnd Bergmann <arnd@arndb.de>
    ARM: pxa: avoid section mismatch warning

Stanislav Fomichev <sdf@google.com>
    selftests/bpf: use __bpf_constant_htons in test_prog.c

Joey Zhang <joey.zhang@microchip.com>
    switchtec: Fix SWITCHTEC_IOCTL_EVENT_IDX_ALL flags overwrite

Jan Kara <jack@suse.cz>
    udf: Fix BUG on corrupted inode

Nir Dotan <nird@mellanox.com>
    mlxsw: spectrum_acl: Limit priority value

Icenowy Zheng <icenowy@aosc.io>
    phy: sun4i-usb: add support for missing USB PHY index

Geert Uytterhoeven <geert@linux-m68k.org>
    lightnvm: Fix uninitialized return value in nvm_get_chunk_meta()

Adamski, Krzysztof (Nokia - PL/Wroclaw) <krzysztof.adamski@nokia.com>
    i2c-axxia: check for error conditions first

Hua Su <suhua.tanke@gmail.com>
    lightnvm: pblk: add lock protection to list operations

Hans Holmberg <hans.holmberg@cnexlabs.com>
    lightnvm: pblk: fix resubmission of overwritten write err lbas

Sean Paul <seanpaul@chromium.org>
    drm/msm: dpu: Only check flush register against pending flushes

Abhinav Kumar <abhinavk@codeaurora.org>
    drm/msm/dsi: fix dsi clock names in DSI 10nm PLL driver

Zhizhou Zhang <zhizhouzhang@asrmicro.com>
    tee: optee: avoid possible double list_del()

Viresh Kumar <viresh.kumar@linaro.org>
    OPP: Use opp_table->regulators to verify no regulator case

Yangtao Li <tiny.windzz@gmail.com>
    cpuidle: big.LITTLE: fix refcount leak

Vadim Pasternak <vadimp@mellanox.com>
    platform/x86: mlx-platform: Fix tachometer registers

Anson Huang <anson.huang@nxp.com>
    clk: imx6sl: ensure MMDC CH0 handshake is bypassed

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    sata_rcar: fix deferred probing

Will Deacon <will.deacon@arm.com>
    iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer

Vivek Gautam <vivek.gautam@codeaurora.org>
    iommu/arm-smmu: Add support for qcom,smmu-v2 variant

Zhen Lei <thunder.leizhen@huawei.com>
    iommu/arm-smmu-v3: Avoid memory corruption from Hisilicon MSI payloads

Tejas Joglekar <tejas.joglekar@synopsys.com>
    usb: dwc3: gadget: Disable CSP for stream OUT ep

Andrey Smirnov <andrew.smirnov@gmail.com>
    ARM: dts: imx51-zii-rdu1: Do not specify "power-gpio" for hpa1

Wolfram Sang <wsa+renesas@sang-engineering.com>
    watchdog: renesas_wdt: don't set divider while watchdog is running

Dan Carpenter <dan.carpenter@oracle.com>
    tracing: Have trace_stack nr_entries compare not be so subtle

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: Fix up the D-Link DIR-685 MTD partition info

Carlo Caione <ccaione@baylibre.com>
    arm64: dts: meson: Fix IRQ trigger type for macirq

Philipp Zabel <p.zabel@pengutronix.de>
    media: coda: fix H.264 deblocking filter controls

Jiong Wang <jiong.wang@netronome.com>
    mips: bpf: fix encoding bug for mm_srlv32_op

Russell King - ARM Linux <linux@armlinux.org.uk>
    ARM: dts: Fix OMAP4430 SDP Ethernet startup

Janusz Krzysztofik <jmkrzyszt@gmail.com>
    ARM: OMAP1: ams-delta: Fix audio permanently muted

Tomasz Figa <tfiga@chromium.org>
    media: v4l2-device: Link subdevices to their parent devices if available

Yu Zhao <yuzhao@google.com>
    iommu/amd: Fix amd_iommu=force_isolation

Nicholas Mc Guire <hofrat@osadl.org>
    pinctrl: sx150x: handle failure case of devm_kstrdup

Nicholas Mc Guire <hofrat@osadl.org>
    gpio: mt7621: pass mediatek_gpio_bank_probe() failure up the stack

Nicholas Mc Guire <hofrat@osadl.org>
    gpio: mt7621: report failure of devm_kasprintf()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    usb: dwc3: trace: add missing break statement to make compiler happy

Kaike Wan <kaike.wan@intel.com>
    IB/hfi1: Unreserve a reserved request when it is completed

Peter Rajnoha <prajnoha@redhat.com>
    kobject: return error code if writing /sys/.../uevent fails

Alexander Duyck <alexander.h.duyck@linux.intel.com>
    driver core: Move async_synchronize_full call

Oskari Lemmela <oskari@lemmela.net>
    arm64: dts: rockchip: fix rk3399-rockpro64 regulator gpios

Hoang Le <hoang.h.le@dektech.com.au>
    tipc: fix node keep alive interval calculation

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/powerplay: fix clock stretcher limits on polaris (v2)

Nicholas Mc Guire <hofrat@osadl.org>
    pinctrl: nuvoton: check for devm_kasprintf() failure

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: fix deauth TX when we disconnect

Luca Ceresoli <luca@lucaceresoli.net>
    media: imx274: select REGMAP_I2C

Chen-Yu Tsai <wens@csie.org>
    clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module clocks

Chunfeng Yun <chunfeng.yun@mediatek.com>
    usb: mtu3: fix the issue about SetFeature(U1/U2_Enable)

Bart Van Assche <bvanassche@acm.org>
    timekeeping: Use proper seqcount initializer

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: hub: delay hub autosuspend if USB3 port is still link training

Marek Szyprowski <m.szyprowski@samsung.com>
    usb: dwc2: Disable power down feature on Samsung SoCs

Eric Long <eric.long@spreadtrum.com>
    dmaengine: sprd: Support DMA link-list cyclic callback

Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
    usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: xtfpga.dtsi: fix dtc warnings about SPI

Zoran Markovic <zmarkovic@sierrawireless.com>
    smack: fix access permissions for keyring

Ville Syrjälä <ville.syrjala@linux.intel.com>
    platform/x86: Fix config space access for intel_atomisp2_pm

Alexey Khoroshilov <khoroshilov@ispras.ru>
    media: DaVinci-VPBE: fix error handling in vpbe_initialize()

Arnd Bergmann <arnd@arndb.de>
    media: i2c: TDA1997x: select CONFIG_HDMI

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    x86/fpu: Add might_fault() to user_insn()

Randy Dunlap <rdunlap@infradead.org>
    spi: fix spi-at91-usart.c build errors when PINCTRL is not set

Rob Herring <robh@kernel.org>
    ARM: dts: aspeed: add missing memory unit-address

Lubomir Rintel <lkundrak@v3.sk>
    ARM: mmp/mmp2: dt: enable the clock

Lubomir Rintel <lkundrak@v3.sk>
    ARM: dts: mmp2: fix TWSI2

Eric Anholt <eric@anholt.net>
    drm/v3d: Fix prime imports of buffers from other drivers.

Mark Rutland <mark.rutland@arm.com>
    arm64: ftrace: don't adjust the LR value

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mt76x0: dfs: fix IBI_R11 configuration on non-radar channels

Harald Freudenberger <freude@linux.ibm.com>
    s390/zcrypt: improve special ap message cmd handling

Arend van Spriel <arend.vanspriel@broadcom.com>
    firmware/efi: Add NULL pointer checks in efivars API functions

Thara Gopinath <thara.gopinath@linaro.org>
    thermal: Fix locking in cooling device sysfs update cur_state

Wei Wang <wvw@google.com>
    Thermal: do not clear passive state during system sleep

Will Deacon <will.deacon@arm.com>
    arm64: io: Ensure value passed to __iormb() is held in a 64-bit register

Nicholas Mc Guire <hofrat@osadl.org>
    perf: arm_spe: handle devm_kasprintf() failure

Sean Paul <seanpaul@chromium.org>
    drm: Clear state->acquire_ctx before leaving drm_atomic_helper_commit_duplicated_state()

J. Bruce Fields <bfields@redhat.com>
    nfsd4: fix crash on writing v4_end_grace before nfsd startup

Yangtao Li <tiny.windzz@gmail.com>
    soc: bcm: brcmstb: Don't leak device tree node reference

Young Xiao <YangX92@hotmail.com>
    sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN

YueHaibing <yuehaibing@huawei.com>
    net: aquantia: return 'err' if set MPI_DEINIT state fails

Will Deacon <will.deacon@arm.com>
    arm64: io: Ensure calls to delay routines are ordered against prior readX()

Simon Horman <horms+renesas@verge.net.au>
    i2c: sh_mobile: add support for r8a77990 (R-Car E3)

Tiezhu Yang <kernelpatch@126.com>
    f2fs: fix wrong return value of f2fs_acl_create

Sheng Yong <shengyong1@huawei.com>
    f2fs: fix race between write_checkpoint and write_begin

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: avoid build warn of fall_through

Yunlei He <heyunlei@huawei.com>
    f2fs: move dir data flush to write checkpoint process

Yunlong Song <yunlong.song@huawei.com>
    f2fs: avoid GC causing encrypted file corrupted

Michael Straube <straube.linux@gmail.com>
    staging: pi433: fix potential null dereference

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    ACPI: SPCR: Consider baud rate 0 as preconfigured state

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: adv*/tc358743/ths8200: fill in min width/height/pixelclock

Hans de Goede <hdegoede@redhat.com>
    iio: accel: kxcjk1013: Add KIOX010A ACPI Hardware-ID

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    iio: adc: meson-saradc: fix internal clock names

Nicholas Mc Guire <hofrat@osadl.org>
    iio: adc: meson-saradc: check for devm_kasprintf failure

Mathieu Malaterre <malat@debian.org>
    powerpc/32: Add .data..Lubsan_data*/.data..Lubsan_type* sections explicitly

Nathan Chancellor <natechancellor@gmail.com>
    dmaengine: xilinx_dma: Remove __aligned attribute on zynqmp_dma_desc_ll

YueHaibing <yuehaibing@huawei.com>
    ptp: Fix pass zero to ERR_PTR() in ptp_clock_register

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    clk: meson: meson8b: fix the width of the cpu_scale_div clock

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    clk: meson: meson8b: do not use cpu_div3 for cpu_scale_out_sel

Chen-Yu Tsai <wens@csie.org>
    ASoC: sunxi: sun50i-codec-analog: Add support for cpvdd regulator supply

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    drm: rcar-du: Fix external clock error checks

Parav Pandit <parav@mellanox.com>
    RDMA/core: Sync unregistration with netlink commands

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: fill in media_device bus_info

Babu Moger <Babu.Moger@amd.com>
    x86/resctrl: Fixup the user-visible strings

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix race when the managed cache is enabled

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix the definition of DBG_BUGON

Alexey Khoroshilov <khoroshilov@ispras.ru>
    media: mtk-vcodec: Release device nodes in mtk_vcodec_init_enc_pm()

Akinobu Mita <akinobu.mita@gmail.com>
    media: video-i2c: avoid accessing released memory area when removing driver

Sean Young <sean@mess.org>
    media: rc: ensure close() is called on rc_unregister_device

Yangtao Li <tiny.windzz@gmail.com>
    soc/tegra: Don't leak device tree node reference

Arnd Bergmann <arnd@arndb.de>
    scsi: cxgb4i: fix thermal configuration dependencies

Pu Wen <puwen@hygon.cn>
    perf tools: Add Hygon Dhyana support

Sami Tolvanen <samitolvanen@google.com>
    modpost: validate symbol names also in find_elf_symbol

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx5: EQ, Use the right place to store/read IRQ affinity hint

Stanislav Fomichev <sdf@google.com>
    bpf: libbpf: retry map creation without the name

Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
    drm/amd/display: calculate stream->phy_pix_clk before clock mapping

Murton Liu <murton.liu@amd.com>
    drm/amd/display: fix gamma not being applied correctly

Nathan Chancellor <natechancellor@gmail.com>
    ARM: OMAP2+: hwmod: Fix some section annotations

Damian Kos <dkos@cadence.com>
    drm/rockchip: fix for mailbox read size

Ben Dooks <ben.dooks@codethink.co.uk>
    usbnet: smsc95xx: fix rx packet alignment

Renato Lui Geh <renatogeh@gmail.com>
    staging: iio: ad7780: update voltage on read

Xiang Chen <chenxiang66@hisilicon.com>
    scsi: hisi_sas: change the time of SAS SSP connection

Alan Brady <alan.brady@intel.com>
    i40e: prevent overlapping tx_timeout recover

Mitch Williams <mitch.a.williams@intel.com>
    i40e: suppress bogus error message

Brian Norris <briannorris@chromium.org>
    platform/chrome: don't report EC_MKBP_EVENT_SENSOR_FIFO as wakeup

Arnd Bergmann <arnd@arndb.de>
    vbox: fix link error with 'gcc -Og'

Anatolij Gustschin <agust@denx.de>
    fpga: altera-cvp: fix 'bad IO access' on x86_64

Dexuan Cui <decui@microsoft.com>
    Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1

Andreas Puhm <puhm@oregano.at>
    fpga: altera-cvp: Fix registration for CvP incapable devices

Matheus Tavares <matheus.bernardino@usp.br>
    staging:iio:ad2s90: Make probe handle spi_setup failure

Naftali Goldstein <naftali.goldstein@intel.com>
    iwlwifi: fw: do not set sgi bits for HE connection

Ioana Ciornei <ioana.ciornei@nxp.com>
    dpaa2-ptp: defer probe when portal allocation failed

Paul Burton <paul.burton@mips.com>
    MIPS: Boston: Disable EG20T prefetch

Miroslav Lichvar <mlichvar@redhat.com>
    ptp: check gettime64 return code in PTP_SYS_OFFSET ioctl

Andy Duan <fugang.duan@nxp.com>
    serial: fsl_lpuart: clear parity enable bit when disable parity

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: ->x_scaling[1] should never be set to VC4_SCALING_NONE

Eric Biggers <ebiggers@google.com>
    crypto: aes_ti - disable interrupts while accessing S-box

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: utilize virtual MAC for Layer2 OSD devices

David Ahern <dsahern@gmail.com>
    bpftool: Improve handling of ENOENT on map dumps

Frank Rowand <frank.rowand@sony.com>
    powerpc/pseries: add of_node_put() in dlpar_detach_node()

Colin Ian King <colin.king@canonical.com>
    x86/PCI: Fix Broadcom CNB20LE unintended sign extension (redux)

Bob Peterson <rpeterso@redhat.com>
    dlm: Don't swamp the CPU with callbacks queued during recovery

Yi Wang <wang.yi59@zte.com.cn>
    clk: boston: fix possible memory leak in clk_boston_setup()

Yufen Wang <wangyufen@huawei.com>
    ARM: 8808/1: kexec:offline panic_smp_self_stop CPU

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix LOGO/PLOGI handling when triggerd by ABTS Timeout event

Suganath Prabu <suganath-prabu.subramani@broadcom.com>
    scsi: mpt3sas: Call sas_remove_host before removing the target devices

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Correct LCB RJT handling

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    ath9k: dynack: use authentication messages for 'late' ack

Brian Norris <briannorris@chromium.org>
    ath10k: assign 'n_cipher_suites' for WCN3990

Lior David <liord@codeaurora.org>
    wil6210: fix memory leak in wil_find_tx_bcast_2

Alexei Avshalom Lazar <ailizaro@codeaurora.org>
    wil6210: fix reset flow for Talyn-mb

Nickhu <nickhu@andestech.com>
    nds32: Fix gcc 8.0 compiler option incompatible.

Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
    drm/amd/display: Fix potential nullptr error

Steve Longerbeam <slongerbeam@gmail.com>
    gpu: ipu-v3: image-convert: Prevent race between run and unprepare

Long Li <longli@microsoft.com>
    genirq/affinity: Spread IRQs to all available NUMA nodes

Dan Carpenter <dan.carpenter@oracle.com>
    ath10k: fixup extended per sta tx statistics

Jernej Skrabec <jernej.skrabec@siol.net>
    drm/sun4i: Initialize registers in tcon-top driver

Muchun Song <smuchun@gmail.com>
    gpiolib: Fix possible use after free on label

Arnd Bergmann <arnd@arndb.de>
    ASoC: Intel: mrfld: fix uninitialized variable access

Jernej Skrabec <jernej.skrabec@siol.net>
    clk: sunxi-ng: h6: Set video PLLs limits

Lukas Wunner <lukas@wunner.de>
    pinctrl: bcm2835: Use raw spinlock for RT compatibility

Deepak Sharma <deepak.sharma@amd.com>
    drm/vgem: Fix vgem_init to get drm device available.

Slawomir Stepien <sst@poczta.fm>
    staging: iio: adc: ad7280a: handle error from __ad7280_read32()

Eric Anholt <eric@anholt.net>
    drm/v3d: Fix a use-after-free race accessing the scheduler's fences.

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/bufs: Fix Spectre v1 vulnerability


-------------

Diffstat:

 Makefile                                           |   4 +-
 .../boot/dts/aspeed-bmc-arm-centriq2400-rep.dts    |   2 +-
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts     |   2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts       |   3 +-
 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts  |   2 +-
 arch/arm/boot/dts/gemini-dlink-dir-685.dts         |  16 +--
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |  17 ++-
 arch/arm/boot/dts/mmp2.dtsi                        |   9 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |   1 +
 arch/arm/kernel/smp.c                              |  15 +++
 arch/arm/mach-mmp/common.h                         |   2 +-
 arch/arm/mach-mmp/mmp2.c                           |   2 +-
 arch/arm/mach-mmp/pxa168.c                         |   2 +-
 arch/arm/mach-mmp/pxa910.c                         |   2 +-
 arch/arm/mach-mmp/time.c                           |  32 +++--
 arch/arm/mach-omap1/board-ams-delta.c              |   6 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |   6 +-
 arch/arm/mach-pxa/cm-x300.c                        |   2 +-
 arch/arm/mach-pxa/littleton.c                      |   2 +-
 arch/arm/mach-pxa/zeus.c                           |   2 +-
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   2 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi  |   1 -
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts  |  20 +--
 arch/arm64/include/asm/io.h                        |  32 +++--
 arch/arm64/include/uapi/asm/ptrace.h               |   2 +-
 arch/arm64/kernel/entry-ftrace.S                   |   1 -
 arch/mips/boot/dts/img/boston.dts                  |   6 +
 arch/mips/include/asm/mach-jz4740/jz4740_mmc.h     |   2 -
 arch/mips/include/uapi/asm/inst.h                  |   2 +-
 arch/mips/jz4740/board-qi_lb60.c                   |  12 +-
 arch/mips/ralink/Kconfig                           |   1 +
 arch/nds32/mm/Makefile                             |   6 +-
 arch/powerpc/include/asm/fadump.h                  |   2 +-
 arch/powerpc/include/asm/uaccess.h                 |   2 +-
 arch/powerpc/kernel/fadump.c                       |  10 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |   4 +
 arch/powerpc/kvm/powerpc.c                         |   5 +-
 arch/powerpc/mm/fault.c                            |   4 +-
 arch/powerpc/perf/isa207-common.c                  |   7 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c      |   2 +-
 arch/powerpc/platforms/pseries/dlpar.c             |   2 +
 arch/powerpc/platforms/pseries/hotplug-memory.c    |   7 +-
 arch/s390/include/uapi/asm/zcrypt.h                |   4 +-
 arch/s390/kvm/kvm-s390.c                           |  17 ++-
 arch/sh/boards/mach-kfr2r09/setup.c                |   1 -
 arch/um/include/asm/pgtable.h                      |   9 +-
 arch/x86/events/intel/core.c                       |  16 ++-
 arch/x86/events/intel/uncore_snbep.c               |   4 +-
 arch/x86/include/asm/fpu/internal.h                |   3 +
 arch/x86/kernel/cpu/bugs.c                         |   2 +-
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c        |  22 ++--
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c        |  34 +++---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c           |  36 +++---
 arch/x86/kernel/cpu/mcheck/mce.c                   |   1 +
 arch/x86/kvm/svm.c                                 |   7 ++
 arch/x86/kvm/vmx.c                                 |   4 +-
 arch/x86/kvm/x86.c                                 |   7 ++
 arch/x86/pci/broadcom_bus.c                        |   4 +-
 arch/xtensa/boot/dts/xtfpga.dtsi                   |   2 +-
 crypto/Kconfig                                     |   3 +-
 crypto/aes_ti.c                                    |  18 +++
 drivers/acpi/apei/ghes.c                           |   2 +
 drivers/acpi/spcr.c                                |  11 ++
 drivers/ata/sata_rcar.c                            |   4 +-
 drivers/base/bus.c                                 |  12 +-
 drivers/base/cacheinfo.c                           |   6 +-
 drivers/base/core.c                                |   8 +-
 drivers/base/dd.c                                  |   6 +-
 drivers/block/drbd/drbd_nl.c                       |  15 +--
 drivers/block/drbd/drbd_receiver.c                 |  13 +-
 drivers/block/sunvdc.c                             |   5 +
 drivers/block/swim3.c                              |  13 +-
 drivers/block/zram/zram_drv.c                      |  38 +++---
 drivers/block/zram/zram_drv.h                      |   2 +-
 drivers/bluetooth/hci_bcm.c                        |   4 +
 drivers/cdrom/gdrom.c                              |   1 +
 drivers/clk/imgtec/clk-boston.c                    |  11 +-
 drivers/clk/imx/clk-imx6sl.c                       |   6 +
 drivers/clk/meson/meson8b.c                        |  16 ++-
 drivers/clk/qcom/gcc-msm8998.c                     |   6 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |   4 +
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |   6 +-
 drivers/cpuidle/cpuidle-big_little.c               |   7 +-
 drivers/crypto/ux500/cryp/cryp_core.c              |   4 +-
 drivers/crypto/ux500/hash/hash_core.c              |   2 +-
 drivers/dma/bcm2835-dma.c                          |  70 ++++-------
 drivers/dma/imx-dma.c                              |   8 +-
 drivers/dma/sprd-dma.c                             |  25 ++--
 drivers/dma/xilinx/zynqmp_dma.c                    |   2 +-
 drivers/firmware/efi/vars.c                        |  99 +++++++++++----
 drivers/fpga/altera-cvp.c                          |  15 ++-
 drivers/gpio/gpio-mt7621.c                         |  10 +-
 drivers/gpio/gpiolib.c                             |  25 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   6 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  26 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   2 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  11 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  12 +-
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |  17 ++-
 drivers/gpu/drm/drm_atomic_helper.c                |   8 +-
 drivers/gpu/drm/drm_bufs.c                         |   3 +
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |   2 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c         |   8 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |  14 ++-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              |   2 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c             |   7 ++
 drivers/gpu/drm/v3d/v3d_bo.c                       |   1 +
 drivers/gpu/drm/v3d/v3d_drv.h                      |   5 +
 drivers/gpu/drm/v3d/v3d_gem.c                      |   8 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |  12 +-
 drivers/gpu/drm/vgem/vgem_drv.c                    |  16 +--
 drivers/gpu/ipu-v3/ipu-image-convert.c             |  10 +-
 drivers/hid/hid-debug.c                            | 120 ++++++++----------
 drivers/hid/hid-lenovo.c                           |  10 +-
 drivers/hwmon/lm80.c                               |  26 ++--
 drivers/i2c/busses/i2c-axxia.c                     |  32 ++---
 drivers/i2c/busses/i2c-sh_mobile.c                 |   2 +
 drivers/iio/accel/kxcjk-1013.c                     |   1 +
 drivers/iio/adc/meson_saradc.c                     |  14 ++-
 drivers/infiniband/core/core_priv.h                |   1 +
 drivers/infiniband/core/device.c                   |  26 +++-
 drivers/infiniband/core/nldev.c                    |  20 +--
 drivers/infiniband/hw/hfi1/rc.c                    |   2 +
 drivers/iommu/amd_iommu.c                          |   9 +-
 drivers/iommu/arm-smmu-v3.c                        |  14 ++-
 drivers/iommu/arm-smmu.c                           |   3 +
 drivers/irqchip/irq-gic-v3-its.c                   |  32 ++++-
 drivers/isdn/hisax/hfc_pci.c                       |   2 +
 drivers/lightnvm/core.c                            |   2 +-
 drivers/lightnvm/pblk-core.c                       |  13 +-
 drivers/lightnvm/pblk-write.c                      |   8 +-
 drivers/md/raid10.c                                |   4 +
 drivers/media/i2c/Kconfig                          |   2 +
 drivers/media/i2c/ad9389b.c                        |   2 +-
 drivers/media/i2c/adv7511.c                        |   2 +-
 drivers/media/i2c/adv7604.c                        |   4 +-
 drivers/media/i2c/adv7842.c                        |   4 +-
 drivers/media/i2c/tc358743.c                       |   2 +-
 drivers/media/i2c/ths8200.c                        |   2 +-
 drivers/media/i2c/video-i2c.c                      |  11 +-
 drivers/media/platform/coda/coda-bit.c             |  19 ++-
 drivers/media/platform/coda/coda-common.c          |  15 ++-
 drivers/media/platform/coda/coda.h                 |   6 +-
 drivers/media/platform/coda/coda_regs.h            |   2 +-
 drivers/media/platform/davinci/vpbe.c              |   7 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  |  10 +-
 drivers/media/platform/vivid/vivid-core.c          |   2 +
 drivers/media/rc/rc-main.c                         |   2 +
 drivers/media/v4l2-core/v4l2-device.c              |   1 +
 drivers/memstick/core/memstick.c                   |   3 +
 drivers/mmc/host/bcm2835.c                         |  12 ++
 drivers/mmc/host/jz4740_mmc.c                      |  20 +--
 drivers/mmc/host/meson-mx-sdio.c                   |   6 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |  16 ++-
 drivers/mmc/host/sdhci-omap.c                      |  16 ++-
 drivers/mmc/host/sdhci-xenon-phy.c                 |  10 +-
 drivers/mmc/host/sdhci-xenon.c                     |  10 +-
 drivers/net/dsa/b53/b53_srab.c                     |   3 -
 drivers/net/dsa/mv88e6xxx/global1_atu.c            |  21 ++--
 .../aquantia/atlantic/hw_atl/hw_atl_utils.c        |   2 +
 drivers/net/ethernet/broadcom/bcmsysport.c         |  25 ++--
 drivers/net/ethernet/broadcom/bcmsysport.h         |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  27 +++--
 drivers/net/ethernet/cisco/enic/enic_main.c        |   3 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c   |   5 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |   2 +-
 drivers/net/ethernet/freescale/fman/fman_tgec.c    |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  30 +++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   4 +
 drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   8 ++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  16 ++-
 drivers/net/ethernet/intel/igb/igb_main.c          |   8 +-
 drivers/net/ethernet/marvell/skge.c                |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  13 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   9 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  14 ++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  23 ++++
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    |   5 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  27 +----
 drivers/net/ethernet/sun/niu.c                     |  10 +-
 drivers/net/phy/dp83640.c                          |  13 +-
 drivers/net/phy/marvell.c                          |  12 --
 drivers/net/usb/smsc95xx.c                         |   1 +
 drivers/net/virtio_net.c                           |  20 ++-
 drivers/net/wireless/ath/ath10k/core.c             |   1 +
 drivers/net/wireless/ath/ath10k/mac.c              |  28 +++--
 drivers/net/wireless/ath/ath9k/dynack.c            |   3 +-
 drivers/net/wireless/ath/wil6210/main.c            |  11 +-
 drivers/net/wireless/ath/wil6210/txrx.c            |   2 +
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |   4 +
 .../net/wireless/mediatek/mt76/mt76x2/pci_dfs.c    |   8 +-
 drivers/net/wireless/st/cw1200/scan.c              |  13 +-
 drivers/nvme/host/lightnvm.c                       |   3 +-
 drivers/opp/core.c                                 |  11 +-
 drivers/pci/controller/dwc/pci-imx6.c              |  10 ++
 drivers/pci/switch/switchtec.c                     |   3 +
 drivers/perf/arm_spe_pmu.c                         |   5 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |   7 ++
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |  16 +--
 drivers/pinctrl/meson/pinctrl-meson8.c             |   3 +
 drivers/pinctrl/meson/pinctrl-meson8b.c            |  13 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |   3 +
 drivers/pinctrl/pinctrl-rza1.c                     |   5 +
 drivers/pinctrl/pinctrl-sx150x.c                   |  11 +-
 drivers/platform/chrome/cros_ec_proto.c            |  18 ++-
 drivers/platform/x86/intel_atomisp2_pm.c           |  68 ++++++++---
 drivers/platform/x86/mlx-platform.c                |  12 +-
 drivers/ptp/ptp_chardev.c                          |   5 +-
 drivers/ptp/ptp_clock.c                            |   5 +-
 drivers/s390/crypto/zcrypt_error.h                 |   2 +
 drivers/s390/net/qeth_core.h                       |   1 -
 drivers/s390/net/qeth_core_main.c                  |  12 +-
 drivers/s390/net/qeth_core_mpc.h                   |  25 ++--
 drivers/s390/net/qeth_l2_main.c                    |  10 +-
 drivers/scsi/aic94xx/aic94xx_init.c                |   8 +-
 drivers/scsi/cxgbi/cxgb4i/Kconfig                  |   4 +-
 drivers/scsi/cxlflash/main.c                       |   2 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |   2 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  52 ++++----
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |   5 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |   2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c           |   7 +-
 drivers/scsi/sd_zbc.c                              |  12 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |   6 +
 drivers/scsi/smartpqi/smartpqi_sis.c               |   2 +-
 drivers/soc/bcm/brcmstb/common.c                   |   6 +-
 drivers/soc/tegra/common.c                         |   6 +-
 drivers/spi/spi-at91-usart.c                       |   1 +
 drivers/staging/erofs/internal.h                   |   3 +-
 drivers/staging/erofs/utils.c                      | 134 +++++++++++++++------
 drivers/staging/iio/adc/ad7280a.c                  |  17 ++-
 drivers/staging/iio/adc/ad7780.c                   |   6 +-
 drivers/staging/iio/resolver/ad2s90.c              |   7 +-
 drivers/staging/pi433/pi433_if.c                   |   4 +
 drivers/staging/speakup/spk_ttyio.c                |   6 +-
 drivers/tee/optee/supp.c                           |  13 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |  11 ++
 drivers/thermal/qcom/tsens-common.c                |  12 +-
 drivers/thermal/thermal-generic-adc.c              |  12 +-
 drivers/thermal/thermal_core.c                     |  12 +-
 drivers/thermal/thermal_hwmon.h                    |   4 +-
 drivers/thermal/thermal_sysfs.c                    |  11 +-
 drivers/tty/serial/8250/8250_pci.c                 |   9 +-
 drivers/tty/serial/fsl_lpuart.c                    |   4 +
 drivers/tty/serial/samsung.c                       |   3 +
 drivers/tty/serial/serial_core.c                   |   6 +
 drivers/tty/serial/sh-sci.c                        |  32 +++--
 drivers/usb/core/hub.c                             |  10 ++
 drivers/usb/dwc2/params.c                          |  10 +-
 drivers/usb/dwc3/gadget.c                          |  16 ++-
 drivers/usb/dwc3/trace.h                           |   2 +
 drivers/usb/gadget/udc/net2272.c                   |   2 +-
 drivers/usb/mtu3/mtu3_core.c                       |   4 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c                 |   8 +-
 drivers/usb/musb/musb_dsps.c                       |  21 +++-
 drivers/usb/musb/musb_gadget.c                     |  13 +-
 drivers/usb/musb/musbhsdma.c                       |  21 ++--
 drivers/usb/phy/phy-am335x.c                       |   5 +-
 drivers/usb/renesas_usbhs/common.c                 |   4 +
 drivers/video/fbdev/clps711x-fb.c                  |   5 +-
 drivers/video/fbdev/core/fbcon.c                   |   2 +-
 drivers/video/fbdev/core/fbmem.c                   |   8 +-
 drivers/virt/vboxguest/vboxguest_core.c            |   2 +-
 drivers/watchdog/renesas_wdt.c                     |   9 +-
 fs/binfmt_script.c                                 |  10 +-
 fs/btrfs/btrfs_inode.h                             |   1 +
 fs/btrfs/ctree.h                                   |   2 +-
 fs/btrfs/extent_io.c                               |  17 ++-
 fs/btrfs/inode.c                                   |  11 +-
 fs/btrfs/ioctl.c                                   |   2 +-
 fs/btrfs/reada.c                                   |  12 +-
 fs/btrfs/volumes.c                                 |  29 +++++
 fs/cifs/readdir.c                                  |   9 +-
 fs/dlm/ast.c                                       |  10 ++
 fs/eventpoll.c                                     |   2 +-
 fs/f2fs/acl.c                                      |  14 ++-
 fs/f2fs/checkpoint.c                               |   7 +-
 fs/f2fs/data.c                                     |  12 +-
 fs/f2fs/f2fs.h                                     |  12 +-
 fs/f2fs/file.c                                     |   3 +
 fs/f2fs/gc.c                                       |  15 ++-
 fs/f2fs/node.c                                     |   5 +-
 fs/f2fs/segment.c                                  |   3 +-
 fs/f2fs/shrinker.c                                 |   2 +-
 fs/f2fs/super.c                                    |  27 +++--
 fs/fuse/dev.c                                      |   4 +-
 fs/fuse/file.c                                     |   2 +-
 fs/fuse/inode.c                                    |   2 +-
 fs/nfs/super.c                                     |   3 +-
 fs/nfsd/nfsctl.c                                   |   2 +
 fs/nfsd/vfs.c                                      |   6 +-
 fs/ocfs2/Makefile                                  |   2 +-
 fs/ocfs2/buffer_head_io.c                          |   2 -
 fs/ocfs2/dlm/Makefile                              |   2 +-
 fs/ocfs2/dlmfs/Makefile                            |   2 +-
 fs/proc/base.c                                     |  12 +-
 fs/udf/inode.c                                     |   6 +
 fs/xfs/xfs_aops.c                                  |   2 +
 include/linux/cpu.h                                |   2 -
 include/linux/genl_magic_struct.h                  |   5 +-
 include/linux/gpio/consumer.h                      |   6 +-
 include/linux/hid-debug.h                          |   9 +-
 include/linux/kvm_host.h                           |   3 +-
 include/linux/mlx5/driver.h                        |   2 +-
 include/linux/skmsg.h                              |   8 ++
 include/rdma/ib_verbs.h                            |   8 +-
 include/sound/compress_driver.h                    |   6 +-
 include/sound/hda_codec.h                          |   1 +
 kernel/cgroup/cgroup.c                             |   2 +-
 kernel/cpu.c                                       |  33 +----
 kernel/debug/debug_core.c                          |   4 +
 kernel/debug/kdb/kdb_bt.c                          |  11 +-
 kernel/debug/kdb/kdb_debugger.c                    |   7 --
 kernel/events/ring_buffer.c                        |   3 +
 kernel/futex.c                                     |  28 +++--
 kernel/hung_task.c                                 |  20 ++-
 kernel/irq/affinity.c                              |   5 +-
 kernel/kcov.c                                      |   2 +-
 kernel/locking/rtmutex.c                           |  37 +++++-
 kernel/module.c                                    |   6 +-
 kernel/sched/fair.c                                |   1 +
 kernel/smp.c                                       |   2 -
 kernel/sysctl.c                                    |   2 +
 kernel/time/timekeeping.c                          |   4 +-
 kernel/trace/trace_stack.c                         |   2 +-
 lib/seq_buf.c                                      |   6 +-
 lib/test_rhashtable.c                              |  23 ++--
 mm/page_alloc.c                                    |  37 ++++--
 mm/percpu-km.c                                     |   5 +-
 net/core/skmsg.c                                   |   7 +-
 net/dccp/ccid.h                                    |   4 +-
 net/dsa/master.c                                   |   4 +
 net/dsa/slave.c                                    |  17 +--
 net/ipv4/tcp_bpf.c                                 |   2 +-
 net/ipv6/tcp_ipv6.c                                |   3 +-
 net/ipv6/xfrm6_tunnel.c                            |   3 +
 net/mac80211/rx.c                                  |  31 +++--
 net/mac80211/util.c                                |  49 +++++---
 net/rds/bind.c                                     |   6 +-
 net/rxrpc/recvmsg.c                                |   3 +-
 net/sched/cls_flower.c                             |   6 +-
 net/sctp/socket.c                                  |   4 +-
 net/sctp/stream.c                                  |  20 +++
 net/sunrpc/xprtrdma/backchannel.c                  |  13 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c         |   8 +-
 net/sunrpc/xprtrdma/transport.c                    |  17 +--
 net/sunrpc/xprtrdma/verbs.c                        |   1 -
 net/sunrpc/xprtrdma/xprt_rdma.h                    |   1 +
 net/tipc/node.c                                    |   6 +
 samples/livepatch/livepatch-shadow-fix1.c          |   5 +
 samples/livepatch/livepatch-shadow-mod.c           |   4 +
 scripts/decode_stacktrace.sh                       |   2 +-
 scripts/gdb/linux/proc.py                          |   2 +-
 scripts/mod/modpost.c                              |  50 ++++----
 security/smack/smack_lsm.c                         |  12 +-
 sound/pci/hda/hda_bind.c                           |   3 +-
 sound/pci/hda/hda_intel.c                          |   2 +
 sound/pci/hda/patch_realtek.c                      |  62 +++++-----
 sound/soc/fsl/Kconfig                              |   2 +-
 sound/soc/intel/atom/sst/sst_loader.c              |   8 +-
 sound/soc/sunxi/sun50i-codec-analog.c              |   2 +
 sound/usb/quirks.c                                 |   1 +
 tools/bpf/bpftool/common.c                         |   4 +-
 tools/bpf/bpftool/json_writer.c                    |   6 +-
 tools/bpf/bpftool/map.c                            |  18 ++-
 tools/bpf/bpftool/prog.c                           |   4 +-
 tools/bpf/bpftool/xlated_dumper.c                  |   7 +-
 tools/build/Makefile.feature                       |   4 +-
 tools/build/feature/Makefile                       |  10 +-
 tools/hv/hv_kvp_daemon.c                           |  15 ++-
 tools/lib/bpf/bpf.c                                |  11 +-
 tools/perf/Makefile.config                         |  44 +++----
 tools/perf/arch/x86/util/kvm-stat.c                |   2 +-
 tools/perf/tests/attr.py                           |   2 +-
 tools/perf/tests/evsel-tp-sched.c                  |   2 +-
 tools/perf/util/dso.c                              |   2 +-
 tools/perf/util/header.c                           |   6 +-
 tools/perf/util/probe-file.c                       |   2 +-
 tools/perf/util/python.c                           |   3 +-
 tools/perf/util/s390-cpumsf.c                      |   2 +-
 tools/perf/util/stat-display.c                     |  16 ++-
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |   4 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/bpf/test_progs.c           |   8 +-
 tools/testing/selftests/drivers/dma-buf/Makefile   |   2 +
 tools/testing/selftests/drivers/dma-buf/udmabuf.c  |  11 +-
 tools/testing/selftests/kvm/x86_64/evmcs_test.c    |   4 +-
 tools/testing/selftests/kvm/x86_64/state_test.c    |   4 +-
 virt/kvm/arm/mmio.c                                |  11 +-
 virt/kvm/kvm_main.c                                |   6 +-
 400 files changed, 2627 insertions(+), 1313 deletions(-)


