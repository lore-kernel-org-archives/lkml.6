Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC3B222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896904;
	bh=UCySVumqCN2ISzHZ22elWaBrbuZ3pm20I0uNIRV1poo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uRXzakMbZnM7TSvQS77XwEYcHiov7b6MQz9M2Y4OMVBWIGlHeQSi454JWTg/jQEq1
	 gWKX6KH4JzIudDeldHzFZ6oKTtjSxtMFrDs1/Vbk+NNDp0UoE37a1FH+gb83uBIG6C
	 1HZbzj6jm/W5iChzg9/k0hLjorIECc5SiKwPH/0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbfBKOzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388888AbfBKOzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:55:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461AA20700;
        Mon, 11 Feb 2019 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896898;
        bh=UCySVumqCN2ISzHZ22elWaBrbuZ3pm20I0uNIRV1poo=;
        h=From:To:Cc:Subject:Date:From;
        b=G++XNHppW67ZweOWi8izPgl5rZKymhldTgU14Jaovee8fkWCjjnqQ8pSZMXNNAjoe
         R3h8uQdM5qS7fCFIwLBlFt/cfjPm1rEG228SGTUTZclEKTempqgglvKHfx3OOZvTbw
         Pp+WX2zQbiQobD3KChA7aUYvyNnMoJN6dkHzcddE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/205] 4.14.99-stable review
Date:   Mon, 11 Feb 2019 15:16:38 +0100
Message-Id: <20190211141827.214852402@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.99-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.99-rc1
X-KernelTest-Deadline: 2019-02-13T14:18+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.99 release.
There are 205 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 13 14:17:19 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.99-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.99-rc1

Peter Zijlstra <peterz@infradead.org>
    perf/x86/intel: Delay memory deallocation until x86_pmu_dead_cpu()

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/hfi1: Add limit test for RC/UC send via loopback

J. Bruce Fields <bfields@redhat.com>
    nfsd4: catch some false session retries

J. Bruce Fields <bfields@redhat.com>
    nfsd4: fix cached replies to solo SEQUENCE compounds

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

Miklos Szeredi <mszeredi@redhat.com>
    fuse: handle zero sized retrieve correctly

Miklos Szeredi <mszeredi@redhat.com>
    fuse: decrement NR_WRITEBACK_TEMP on the right page

Jann Horn <jannh@google.com>
    fuse: call pipe_buf_release() under pipe lock

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Serialize codec registrations

Charles Keepax <ckeepax@opensource.cirrus.com>
    ALSA: compress: Fix stop handling on compressed capture streams

Rundong Ge <rdong.ge@gmail.com>
    net: dsa: slave: Don't propagate flag changes on down slave interfaces

Cong Wang <xiyou.wangcong@gmail.com>
    net/mlx5e: Force CHECKSUM_UNNECESSARY for short ethernet frames

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Fix WoL with password after deep sleep

Eric Dumazet <edumazet@google.com>
    rds: fix refcount bug in rds_sock_addref

Dan Carpenter <dan.carpenter@oracle.com>
    skge: potential memory corruption in skge_get_regs()

Eric Dumazet <edumazet@google.com>
    rxrpc: bad unlock balance in rxrpc_recvmsg

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    net: dp83640: expire old TX-skb

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: fix checksum validation for IPv6

Eric Dumazet <edumazet@google.com>
    dccp: fool proof ccid_hc_[rt]x_parse_options()

Eduardo Valentin <edubezval@gmail.com>
    thermal: hwmon: inline helpers when CONFIG_THERMAL_HWMON is not set

Du Changbin <changbin.du@gmail.com>
    scripts/gdb: fix lx-version string output

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

Aditya Pakki <pakki001@umn.edu>
    HID: lenovo: Add checks to fix of_led_classdev_register

Bjorn Andersson <bjorn.andersson@linaro.org>
    thermal: generic-adc: Fix adc to temp interpolation

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

Larry Chen <lchen@suse.com>
    ocfs2: improve ocfs2 Makefile

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: don't clear bh uptodate for block read

Marc Zyngier <marc.zyngier@arm.com>
    scripts/decode_stacktrace: only strip base path when a prefix of the path

Ondrej Mosnacek <omosnace@redhat.com>
    cgroup: fix parsing empty mount option string

Sahitya Tummala <stummala@codeaurora.org>
    f2fs: fix sbi->extent_list corruption issue

Kangjie Lu <kjlu@umn.edu>
    niu: fix missing checks of niu_pci_eeprom_read

Anton Ivanov <anton.ivanov@cambridgegreys.com>
    um: Avoid marking pages with "changed protection"

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

Chris Perl <cperl@janestreet.com>
    NFS: nfs_compare_mount_options always compare auth flavors.

Jim Mattson <jmattson@google.com>
    kvm: Change offset in kvm_write_guest_offset_cached to unsigned

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/fadump: Do not allow hot-remove memory from fadump reserved area.

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: x86: svm: report MSR_IA32_MCG_EXT_CTL as unsupported

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    pinctrl: meson: meson8b: fix the GPIO function for the GPIOAO pins

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    pinctrl: meson: meson8: fix the GPIO function for the GPIOAO pins

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/mm: Fix reporting of kernel execute faults on the 8xx

Noralf Trønnes <noralf@tronnes.org>
    fbdev: fbcon: Fix unregister crash when more than one framebuffer

Lenny Szubowicz <lszubowi@redhat.com>
    ACPI/APEI: Clear GHES block_status before panic()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    igb: Fix an issue that PME is not enabled during runtime suspend

Konstantin Khorenko <khorenko@virtuozzo.com>
    i40e: define proper net_device::neigh_priv_len

Peter Rosin <peda@axentia.se>
    fbdev: fbmem: behave better with small rotated displays and many CPUs

Guoqing Jiang <gqjiang@suse.com>
    md: fix raid10 hang issue caused by barrier

Alexey Khoroshilov <khoroshilov@ispras.ru>
    video: clps711x-fb: release disp device node in probe()

Nathan Chancellor <natechancellor@gmail.com>
    drbd: Avoid Clang warning about pointless switch statment

Lars Ellenberg <lars.ellenberg@linbit.com>
    drbd: skip spurious timeout (ping-timeo) when failing promote

Lars Ellenberg <lars.ellenberg@linbit.com>
    drbd: disconnect, if the wrong UUIDs are attached on a connected peer

Roland Kammerer <roland.kammerer@linbit.com>
    drbd: narrow rcu_read_lock in drbd_sync_handshake

Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
    powerpc/perf: Fix thresholding counter data for unknown type

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

Johan Hedberg <johan.hedberg@intel.com>
    Bluetooth: Fix unnecessary error message for HCI request completion

YueHaibing <yuehaibing@huawei.com>
    xfrm6_tunnel: Fix spi check in __xfrm6_tunnel_alloc_spi

Johannes Berg <johannes.berg@intel.com>
    mac80211: fix radiotap vendor presence bitmap handling

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/uaccess: fix warning/error with access_ok()

Dennis Zhou <dennis@kernel.org>
    percpu: convert spin_lock_irq to spin_lock_irqsave.

Bin Liu <b-liu@ti.com>
    usb: musb: dsps: fix otg state machine

Mark Rutland <mark.rutland@arm.com>
    arm64: KVM: Skip MMIO insn after emulation

Michael Mueller <mimu@linux.ibm.com>
    KVM: s390: unregister debug feature on failing arch init

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf probe: Fix unchecked usage of strncpy()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf header: Fix unchecked usage of strncpy()

Adrian Hunter <adrian.hunter@intel.com>
    perf test: Fix perf_event_attr test failure

Beomho Seo <beomho.seo@samsung.com>
    tty: serial: samsung: Properly set flags in autoCTS mode

Adrian Hunter <adrian.hunter@intel.com>
    mmc: sdhci-xenon: Fix timeout checks

Adrian Hunter <adrian.hunter@intel.com>
    mmc: sdhci-of-esdhc: Fix timeout checks

Kai-Heng Feng <kai.heng.feng@canonical.com>
    memstick: Prevent memstick host from getting runtime suspended during card detection

Michal Suchanek <msuchanek@suse.de>
    mmc: bcm2835: reset host on timeout

Phil Elwell <phil@raspberrypi.org>
    mmc: bcm2835: Recover from MMC_SEND_EXT_CSD

Suraj Jitindar Singh <sjitindarsingh@gmail.com>
    KVM: PPC: Book3S: Only report KVM_CAP_SPAPR_TCE_VFIO on powernv machines

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

Icenowy Zheng <icenowy@aosc.io>
    phy: sun4i-usb: add support for missing USB PHY index

Adamski, Krzysztof (Nokia - PL/Wroclaw) <krzysztof.adamski@nokia.com>
    i2c-axxia: check for error conditions first

Viresh Kumar <viresh.kumar@linaro.org>
    OPP: Use opp_table->regulators to verify no regulator case

Yangtao Li <tiny.windzz@gmail.com>
    cpuidle: big.LITTLE: fix refcount leak

Anson Huang <anson.huang@nxp.com>
    clk: imx6sl: ensure MMDC CH0 handshake is bypassed

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    sata_rcar: fix deferred probing

Will Deacon <will.deacon@arm.com>
    iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer

Vivek Gautam <vivek.gautam@codeaurora.org>
    iommu/arm-smmu: Add support for qcom,smmu-v2 variant

Tejas Joglekar <tejas.joglekar@synopsys.com>
    usb: dwc3: gadget: Disable CSP for stream OUT ep

Wolfram Sang <wsa+renesas@sang-engineering.com>
    watchdog: renesas_wdt: don't set divider while watchdog is running

Dan Carpenter <dan.carpenter@oracle.com>
    tracing: Have trace_stack nr_entries compare not be so subtle

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: Fix up the D-Link DIR-685 MTD partition info

Philipp Zabel <p.zabel@pengutronix.de>
    media: coda: fix H.264 deblocking filter controls

Jiong Wang <jiong.wang@netronome.com>
    mips: bpf: fix encoding bug for mm_srlv32_op

Russell King - ARM Linux <linux@armlinux.org.uk>
    ARM: dts: Fix OMAP4430 SDP Ethernet startup

Yu Zhao <yuzhao@google.com>
    iommu/amd: Fix amd_iommu=force_isolation

Nicholas Mc Guire <hofrat@osadl.org>
    pinctrl: sx150x: handle failure case of devm_kstrdup

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    usb: dwc3: trace: add missing break statement to make compiler happy

Kaike Wan <kaike.wan@intel.com>
    IB/hfi1: Unreserve a reserved request when it is completed

Peter Rajnoha <prajnoha@redhat.com>
    kobject: return error code if writing /sys/.../uevent fails

Alexander Duyck <alexander.h.duyck@linux.intel.com>
    driver core: Move async_synchronize_full call

Chen-Yu Tsai <wens@csie.org>
    clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module clocks

Chunfeng Yun <chunfeng.yun@mediatek.com>
    usb: mtu3: fix the issue about SetFeature(U1/U2_Enable)

Bart Van Assche <bvanassche@acm.org>
    timekeeping: Use proper seqcount initializer

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: hub: delay hub autosuspend if USB3 port is still link training

Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
    usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()

Zoran Markovic <zmarkovic@sierrawireless.com>
    smack: fix access permissions for keyring

Alexey Khoroshilov <khoroshilov@ispras.ru>
    media: DaVinci-VPBE: fix error handling in vpbe_initialize()

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    x86/fpu: Add might_fault() to user_insn()

Lubomir Rintel <lkundrak@v3.sk>
    ARM: mmp/mmp2: dt: enable the clock

Lubomir Rintel <lkundrak@v3.sk>
    ARM: dts: mmp2: fix TWSI2

Mark Rutland <mark.rutland@arm.com>
    arm64: ftrace: don't adjust the LR value

Harald Freudenberger <freude@linux.ibm.com>
    s390/zcrypt: improve special ap message cmd handling

Arend van Spriel <arend.vanspriel@broadcom.com>
    firmware/efi: Add NULL pointer checks in efivars API functions

Wei Wang <wvw@google.com>
    Thermal: do not clear passive state during system sleep

Will Deacon <will.deacon@arm.com>
    arm64: io: Ensure value passed to __iormb() is held in a 64-bit register

Sean Paul <seanpaul@chromium.org>
    drm: Clear state->acquire_ctx before leaving drm_atomic_helper_commit_duplicated_state()

J. Bruce Fields <bfields@redhat.com>
    nfsd4: fix crash on writing v4_end_grace before nfsd startup

Yangtao Li <tiny.windzz@gmail.com>
    soc: bcm: brcmstb: Don't leak device tree node reference

Young Xiao <YangX92@hotmail.com>
    sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN

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

Nathan Chancellor <natechancellor@gmail.com>
    dmaengine: xilinx_dma: Remove __aligned attribute on zynqmp_dma_desc_ll

YueHaibing <yuehaibing@huawei.com>
    ptp: Fix pass zero to ERR_PTR() in ptp_clock_register

Alexey Khoroshilov <khoroshilov@ispras.ru>
    media: mtk-vcodec: Release device nodes in mtk_vcodec_init_enc_pm()

Yangtao Li <tiny.windzz@gmail.com>
    soc/tegra: Don't leak device tree node reference

Pu Wen <puwen@hygon.cn>
    perf tools: Add Hygon Dhyana support

Sami Tolvanen <samitolvanen@google.com>
    modpost: validate symbol names also in find_elf_symbol

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx5: EQ, Use the right place to store/read IRQ affinity hint

Nathan Chancellor <natechancellor@gmail.com>
    ARM: OMAP2+: hwmod: Fix some section annotations

Damian Kos <dkos@cadence.com>
    drm/rockchip: fix for mailbox read size

Ben Dooks <ben.dooks@codethink.co.uk>
    usbnet: smsc95xx: fix rx packet alignment

Renato Lui Geh <renatogeh@gmail.com>
    staging: iio: ad7780: update voltage on read

Brian Norris <briannorris@chromium.org>
    platform/chrome: don't report EC_MKBP_EVENT_SENSOR_FIFO as wakeup

Dexuan Cui <decui@microsoft.com>
    Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1

Andreas Puhm <puhm@oregano.at>
    fpga: altera-cvp: Fix registration for CvP incapable devices

Matheus Tavares <matheus.bernardino@usp.br>
    staging:iio:ad2s90: Make probe handle spi_setup failure

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

Steve Longerbeam <slongerbeam@gmail.com>
    gpu: ipu-v3: image-convert: Prevent race between run and unprepare

Arnd Bergmann <arnd@arndb.de>
    ASoC: Intel: mrfld: fix uninitialized variable access

Lukas Wunner <lukas@wunner.de>
    pinctrl: bcm2835: Use raw spinlock for RT compatibility

Deepak Sharma <deepak.sharma@amd.com>
    drm/vgem: Fix vgem_init to get drm device available.

Slawomir Stepien <sst@poczta.fm>
    staging: iio: adc: ad7280a: handle error from __ad7280_read32()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/bufs: Fix Spectre v1 vulnerability


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/gemini-dlink-dir-685.dts         | 16 ++--
 arch/arm/boot/dts/mmp2.dtsi                        |  9 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |  1 +
 arch/arm/kernel/smp.c                              | 15 ++++
 arch/arm/mach-mmp/common.h                         |  2 +-
 arch/arm/mach-mmp/mmp2.c                           |  2 +-
 arch/arm/mach-mmp/pxa168.c                         |  2 +-
 arch/arm/mach-mmp/pxa910.c                         |  2 +-
 arch/arm/mach-mmp/time.c                           | 32 ++++---
 arch/arm/mach-omap2/omap_hwmod.c                   |  6 +-
 arch/arm/mach-pxa/cm-x300.c                        |  2 +-
 arch/arm/mach-pxa/littleton.c                      |  2 +-
 arch/arm/mach-pxa/zeus.c                           |  2 +-
 arch/arm64/include/asm/io.h                        | 32 +++++--
 arch/arm64/kernel/entry-ftrace.S                   |  1 -
 arch/mips/boot/dts/img/boston.dts                  |  6 ++
 arch/mips/include/uapi/asm/inst.h                  |  2 +-
 arch/mips/ralink/Kconfig                           |  1 +
 arch/powerpc/include/asm/fadump.h                  |  2 +-
 arch/powerpc/include/asm/uaccess.h                 |  2 +-
 arch/powerpc/kernel/fadump.c                       | 10 ++-
 arch/powerpc/kvm/powerpc.c                         |  5 +-
 arch/powerpc/mm/fault.c                            |  4 +-
 arch/powerpc/perf/isa207-common.c                  |  7 +-
 arch/powerpc/platforms/pseries/dlpar.c             |  2 +
 arch/powerpc/platforms/pseries/hotplug-memory.c    |  7 +-
 arch/s390/include/uapi/asm/zcrypt.h                |  4 +-
 arch/s390/kvm/kvm-s390.c                           | 17 +++-
 arch/um/include/asm/pgtable.h                      |  9 +-
 arch/x86/events/intel/core.c                       | 10 ++-
 arch/x86/events/intel/uncore_snbep.c               |  4 +-
 arch/x86/include/asm/fpu/internal.h                |  3 +
 arch/x86/kernel/cpu/bugs.c                         |  2 +-
 arch/x86/kernel/cpu/mcheck/mce.c                   |  1 +
 arch/x86/kvm/svm.c                                 |  7 ++
 arch/x86/kvm/vmx.c                                 |  4 +-
 arch/x86/kvm/x86.c                                 |  7 ++
 arch/x86/pci/broadcom_bus.c                        |  4 +-
 crypto/Kconfig                                     |  3 +-
 crypto/aes_ti.c                                    | 18 ++++
 drivers/acpi/apei/ghes.c                           |  2 +
 drivers/acpi/spcr.c                                | 11 +++
 drivers/ata/sata_rcar.c                            |  4 +-
 drivers/base/bus.c                                 | 12 ++-
 drivers/base/core.c                                |  8 +-
 drivers/base/dd.c                                  |  6 +-
 drivers/base/power/opp/core.c                      | 11 ++-
 drivers/block/drbd/drbd_nl.c                       | 15 ++--
 drivers/block/drbd/drbd_receiver.c                 | 13 +--
 drivers/block/sunvdc.c                             |  5 ++
 drivers/block/swim3.c                              |  6 +-
 drivers/cdrom/gdrom.c                              |  1 +
 drivers/clk/imgtec/clk-boston.c                    | 11 ++-
 drivers/clk/imx/clk-imx6sl.c                       |  6 ++
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |  6 +-
 drivers/cpuidle/cpuidle-big_little.c               |  7 +-
 drivers/crypto/ux500/cryp/cryp_core.c              |  4 +-
 drivers/crypto/ux500/hash/hash_core.c              |  2 +-
 drivers/dma/bcm2835-dma.c                          | 70 ++++++---------
 drivers/dma/imx-dma.c                              |  8 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |  2 +-
 drivers/firmware/efi/vars.c                        | 99 +++++++++++++++++-----
 drivers/fpga/altera-cvp.c                          |  9 ++
 drivers/gpu/drm/drm_atomic_helper.c                |  8 +-
 drivers/gpu/drm/drm_bufs.c                         |  3 +
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              |  2 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    | 12 +--
 drivers/gpu/drm/vgem/vgem_drv.c                    | 16 ++--
 drivers/gpu/ipu-v3/ipu-image-convert.c             | 10 ++-
 drivers/hid/hid-lenovo.c                           | 10 ++-
 drivers/hwmon/lm80.c                               | 26 ++++--
 drivers/i2c/busses/i2c-axxia.c                     | 32 +++----
 drivers/i2c/busses/i2c-sh_mobile.c                 |  1 +
 drivers/iio/accel/kxcjk-1013.c                     |  1 +
 drivers/iio/adc/meson_saradc.c                     | 14 ++-
 drivers/infiniband/hw/hfi1/rc.c                    |  2 +
 drivers/infiniband/hw/hfi1/ruc.c                   |  7 +-
 drivers/infiniband/hw/qib/qib_ruc.c                |  7 +-
 drivers/iommu/amd_iommu.c                          |  9 +-
 drivers/iommu/arm-smmu-v3.c                        |  8 +-
 drivers/iommu/arm-smmu.c                           |  3 +
 drivers/irqchip/irq-gic-v3-its.c                   | 32 +++++--
 drivers/isdn/hisax/hfc_pci.c                       |  2 +
 drivers/md/raid10.c                                |  4 +
 drivers/media/i2c/ad9389b.c                        |  2 +-
 drivers/media/i2c/adv7511.c                        |  2 +-
 drivers/media/i2c/adv7604.c                        |  4 +-
 drivers/media/i2c/adv7842.c                        |  4 +-
 drivers/media/i2c/tc358743.c                       |  2 +-
 drivers/media/i2c/ths8200.c                        |  2 +-
 drivers/media/platform/coda/coda-bit.c             | 19 ++---
 drivers/media/platform/coda/coda-common.c          | 15 ++--
 drivers/media/platform/coda/coda.h                 |  6 +-
 drivers/media/platform/coda/coda_regs.h            |  2 +-
 drivers/media/platform/davinci/vpbe.c              |  7 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 10 ++-
 drivers/memstick/core/memstick.c                   |  3 +
 drivers/mmc/host/bcm2835.c                         | 12 +++
 drivers/mmc/host/sdhci-of-esdhc.c                  | 16 +++-
 drivers/mmc/host/sdhci-xenon-phy.c                 | 10 ++-
 drivers/mmc/host/sdhci-xenon.c                     | 10 ++-
 drivers/net/ethernet/broadcom/bcmsysport.c         | 25 +++---
 drivers/net/ethernet/broadcom/bcmsysport.h         |  2 +
 drivers/net/ethernet/cisco/enic/enic_main.c        |  3 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |  2 +-
 drivers/net/ethernet/freescale/fman/fman_tgec.c    |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  3 +
 drivers/net/ethernet/intel/igb/igb_main.c          |  8 +-
 drivers/net/ethernet/marvell/skge.c                |  6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 14 +++
 drivers/net/ethernet/mellanox/mlx5/core/main.c     | 14 +--
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     | 23 +++++
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 27 +-----
 drivers/net/ethernet/sun/niu.c                     | 10 ++-
 drivers/net/phy/dp83640.c                          | 13 ++-
 drivers/net/usb/smsc95xx.c                         |  1 +
 drivers/net/wireless/ath/ath9k/dynack.c            |  3 +-
 drivers/net/wireless/st/cw1200/scan.c              | 13 ++-
 drivers/pci/switch/switchtec.c                     |  3 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |  7 ++
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              | 16 ++--
 drivers/pinctrl/meson/pinctrl-meson8.c             |  3 +
 drivers/pinctrl/meson/pinctrl-meson8b.c            | 13 +--
 drivers/pinctrl/pinctrl-sx150x.c                   | 11 ++-
 drivers/platform/chrome/cros_ec_proto.c            | 18 +++-
 drivers/ptp/ptp_chardev.c                          |  5 +-
 drivers/ptp/ptp_clock.c                            |  5 +-
 drivers/s390/crypto/zcrypt_error.h                 |  2 +
 drivers/scsi/aic94xx/aic94xx_init.c                |  8 +-
 drivers/scsi/cxlflash/main.c                       |  2 +
 drivers/scsi/lpfc/lpfc_els.c                       | 52 ++++++------
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |  5 ++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c           |  7 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |  6 ++
 drivers/scsi/smartpqi/smartpqi_sis.c               |  2 +-
 drivers/soc/bcm/brcmstb/common.c                   |  6 +-
 drivers/soc/tegra/common.c                         |  6 +-
 drivers/staging/iio/adc/ad7280a.c                  | 17 +++-
 drivers/staging/iio/adc/ad7780.c                   |  6 +-
 drivers/staging/iio/resolver/ad2s90.c              |  7 +-
 drivers/staging/pi433/pi433_if.c                   |  4 +
 drivers/staging/speakup/spk_ttyio.c                |  6 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         | 11 +++
 drivers/thermal/thermal-generic-adc.c              | 12 ++-
 drivers/thermal/thermal_core.c                     | 12 ++-
 drivers/thermal/thermal_hwmon.h                    |  4 +-
 drivers/tty/serial/8250/8250_pci.c                 |  9 +-
 drivers/tty/serial/fsl_lpuart.c                    |  4 +
 drivers/tty/serial/samsung.c                       |  3 +
 drivers/tty/serial/serial_core.c                   |  6 ++
 drivers/usb/core/hub.c                             | 10 +++
 drivers/usb/dwc3/gadget.c                          | 16 ++--
 drivers/usb/dwc3/trace.h                           |  2 +
 drivers/usb/gadget/udc/net2272.c                   |  2 +-
 drivers/usb/mtu3/mtu3_core.c                       |  4 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c                 |  8 +-
 drivers/usb/musb/musb_dsps.c                       |  9 +-
 drivers/usb/musb/musb_gadget.c                     | 13 +--
 drivers/usb/musb/musbhsdma.c                       | 21 ++---
 drivers/usb/phy/phy-am335x.c                       |  5 +-
 drivers/video/fbdev/clps711x-fb.c                  |  5 +-
 drivers/video/fbdev/core/fbcon.c                   |  2 +-
 drivers/video/fbdev/core/fbmem.c                   |  8 +-
 drivers/watchdog/renesas_wdt.c                     |  9 +-
 fs/binfmt_script.c                                 | 10 ++-
 fs/cifs/readdir.c                                  |  9 +-
 fs/dlm/ast.c                                       | 10 +++
 fs/eventpoll.c                                     |  2 +-
 fs/f2fs/acl.c                                      | 14 +--
 fs/f2fs/data.c                                     | 12 ++-
 fs/f2fs/f2fs.h                                     | 12 ++-
 fs/f2fs/file.c                                     |  3 +
 fs/f2fs/shrinker.c                                 |  2 +-
 fs/fuse/dev.c                                      |  4 +-
 fs/fuse/file.c                                     |  2 +-
 fs/nfs/super.c                                     |  3 +-
 fs/nfsd/nfs4state.c                                | 57 +++++++++++--
 fs/nfsd/nfsctl.c                                   |  2 +
 fs/nfsd/state.h                                    |  2 +
 fs/nfsd/xdr4.h                                     | 13 ++-
 fs/ocfs2/Makefile                                  |  2 +-
 fs/ocfs2/buffer_head_io.c                          |  2 -
 fs/ocfs2/dlm/Makefile                              |  2 +-
 fs/ocfs2/dlmfs/Makefile                            |  2 +-
 fs/proc/base.c                                     | 12 ++-
 fs/udf/inode.c                                     |  6 ++
 include/linux/cpu.h                                |  2 -
 include/linux/genl_magic_struct.h                  |  5 +-
 include/linux/kvm_host.h                           |  3 +-
 include/linux/mlx5/driver.h                        |  2 +-
 include/sound/compress_driver.h                    |  6 +-
 kernel/cgroup/cgroup.c                             |  2 +-
 kernel/cpu.c                                       | 33 +-------
 kernel/debug/debug_core.c                          |  4 +
 kernel/debug/kdb/kdb_bt.c                          | 11 ++-
 kernel/debug/kdb/kdb_debugger.c                    |  7 --
 kernel/events/ring_buffer.c                        |  3 +
 kernel/futex.c                                     | 28 +++---
 kernel/hung_task.c                                 | 20 ++---
 kernel/locking/rtmutex.c                           | 37 ++++++--
 kernel/module.c                                    |  6 +-
 kernel/sched/fair.c                                |  1 +
 kernel/smp.c                                       |  2 -
 kernel/sysctl.c                                    |  2 +
 kernel/time/timekeeping.c                          |  4 +-
 kernel/trace/trace_stack.c                         |  2 +-
 lib/seq_buf.c                                      |  6 +-
 mm/percpu-km.c                                     |  5 +-
 net/bluetooth/hci_event.c                          |  6 ++
 net/dccp/ccid.h                                    |  4 +-
 net/dsa/slave.c                                    | 12 ++-
 net/ipv6/xfrm6_tunnel.c                            |  3 +
 net/mac80211/rx.c                                  |  5 +-
 net/rds/bind.c                                     |  6 +-
 net/rxrpc/recvmsg.c                                |  3 +-
 scripts/decode_stacktrace.sh                       |  2 +-
 scripts/gdb/linux/proc.py                          |  2 +-
 scripts/mod/modpost.c                              | 50 +++++------
 security/smack/smack_lsm.c                         | 12 ++-
 sound/pci/hda/hda_bind.c                           |  3 +-
 sound/pci/hda/hda_codec.h                          |  1 +
 sound/pci/hda/hda_intel.c                          |  2 +
 sound/soc/fsl/Kconfig                              |  2 +-
 sound/soc/intel/atom/sst/sst_loader.c              |  8 +-
 tools/hv/hv_kvp_daemon.c                           | 15 +++-
 tools/perf/arch/x86/util/kvm-stat.c                |  2 +-
 tools/perf/tests/attr.py                           |  2 +-
 tools/perf/tests/evsel-tp-sched.c                  |  2 +-
 tools/perf/util/header.c                           |  2 +-
 tools/perf/util/probe-file.c                       |  2 +-
 tools/testing/selftests/bpf/test_progs.c           |  8 +-
 virt/kvm/arm/mmio.c                                | 11 +--
 virt/kvm/kvm_main.c                                |  6 +-
 236 files changed, 1378 insertions(+), 656 deletions(-)


