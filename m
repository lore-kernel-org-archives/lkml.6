Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B291C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB8A222B1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897508;
	bh=B5zJjjH8ErVNTC+9IYmBx9Nh+2s6zMtSDP6F6sPnlzo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OliqLNnK86ge84Lwq7KopWnUfe1YseIf/vtzI1s7bbnsnSEdwEW81vXuDyh1QhQCf
	 RT7s8XKcT3SBoZGm1eYKSmFbkNNMp7we5ns6lcR57lN/7ZDavfUKe3vmD1tWjj2DbY
	 pcIfhhtBgXTr2D8FhcKqHhiGpSuJXrCkg6idpzHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390925AbfBKPFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390877AbfBKPFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:05:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F79E222A7;
        Mon, 11 Feb 2019 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897502;
        bh=B5zJjjH8ErVNTC+9IYmBx9Nh+2s6zMtSDP6F6sPnlzo=;
        h=From:To:Cc:Subject:Date:From;
        b=GbxDDaWDmrrV91DxyD1kP6GTE7nc8IHLMgBPNcOKFTVPDQt+EZk3B9OZZQOfu1U7b
         mqFF312UWloF20qo8vBGpwjzoz9G4Jweg9NvPCFjF6c1j1JWwdvy27z1P88WtfMLiF
         J68t3kgPS+vVnyBkQYtEzYL6ZbbbvIRCRs32xr2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 000/137] 4.9.156-stable review
Date:   Mon, 11 Feb 2019 15:18:01 +0100
Message-Id: <20190211141811.964925535@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.156-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.156-rc1
X-KernelTest-Deadline: 2019-02-13T14:18+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.156 release.
There are 137 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 13 14:17:22 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.156-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.156-rc1

Andi Kleen <ak@linux.intel.com>
    perf: Add support for supplementary event registers

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/hfi1: Add limit test for RC/UC send via loopback

Scott Bauer <scott.bauer@intel.com>
    PCI: vmd: Free up IRQs on suspend path

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    oom, oom_reaper: do not enqueue same task twice

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

Peter Shier <pshier@google.com>
    KVM: nVMX: unconditionally cancel preemption timer in free_nested (CVE-2019-7221)

Jann Horn <jannh@google.com>
    kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: work around leak of uninitialized stack contents (CVE-2019-7222)

James Bottomley <James.Bottomley@HansenPartnership.com>
    scsi: aic94xx: fix module loading

Paul Elder <paul.elder@ideasonboard.com>
    usb: gadget: musb: fix short isoc packets with inventra dma

Gustavo A. R. Silva <gustavo@embeddedor.com>
    usb: gadget: udc: net2272: Fix bitwise and boolean operations

Bin Liu <b-liu@ti.com>
    usb: phy: am335x: fix race condition in _probe

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

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: fix checksum validation for IPv6

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

Eric Dumazet <edumazet@google.com>
    dccp: fool proof ccid_hc_[rt]x_parse_options()

Eduardo Valentin <edubezval@gmail.com>
    thermal: hwmon: inline helpers when CONFIG_THERMAL_HWMON is not set

Oleg Nesterov <oleg@redhat.com>
    exec: load_script: don't blindly truncate shebang string

Davidlohr Bueso <dave@stgolabs.net>
    fs/epoll: drop ovflist branch prediction

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

Finn Thain <fthain@telegraphics.com.au>
    block/swim3: Fix -EBUSY error when re-opening device after unmount

Scott Wood <oss@buserror.net>
    fsl/fman: Use GFP_ATOMIC in {memac,tgec}_add_hash_mac_address()

Wenwen Wang <wang6495@umn.edu>
    gdrom: fix a memory leak bug

Jia-Ju Bai <baijiaju1990@gmail.com>
    isdn: hisax: hfc_pci: Fix a possible concurrency use-after-free bug in HFCPCI_l1hw()

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: don't clear bh uptodate for block read

Marc Zyngier <marc.zyngier@arm.com>
    scripts/decode_stacktrace: only strip base path when a prefix of the path

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

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: x86: svm: report MSR_IA32_MCG_EXT_CTL as unsupported

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    pinctrl: meson: meson8b: fix the GPIO function for the GPIOAO pins

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    pinctrl: meson: meson8: fix the GPIO function for the GPIOAO pins

Noralf Trønnes <noralf@tronnes.org>
    fbdev: fbcon: Fix unregister crash when more than one framebuffer

Kai-Heng Feng <kai.heng.feng@canonical.com>
    igb: Fix an issue that PME is not enabled during runtime suspend

Konstantin Khorenko <khorenko@virtuozzo.com>
    i40e: define proper net_device::neigh_priv_len

Peter Rosin <peda@axentia.se>
    fbdev: fbmem: behave better with small rotated displays and many CPUs

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

Jia-Ju Bai <baijiaju1990@gmail.com>
    cw1200: Fix concurrency use-after-free bugs in cw1200_hw_scan()

Dave Carroll <david.carroll@microsemi.com>
    scsi: smartpqi: correct volume status

Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
    scsi: smartpqi: correct host serial num for ssa

Johan Hedberg <johan.hedberg@intel.com>
    Bluetooth: Fix unnecessary error message for HCI request completion

YueHaibing <yuehaibing@huawei.com>
    xfrm6_tunnel: Fix spi check in __xfrm6_tunnel_alloc_spi

Johannes Berg <johannes.berg@intel.com>
    mac80211: fix radiotap vendor presence bitmap handling

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/uaccess: fix warning/error with access_ok()

Mark Rutland <mark.rutland@arm.com>
    arm64: KVM: Skip MMIO insn after emulation

Michael Mueller <mimu@linux.ibm.com>
    KVM: s390: unregister debug feature on failing arch init

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf probe: Fix unchecked usage of strncpy()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf header: Fix unchecked usage of strncpy()

Beomho Seo <beomho.seo@samsung.com>
    tty: serial: samsung: Properly set flags in autoCTS mode

Kai-Heng Feng <kai.heng.feng@canonical.com>
    memstick: Prevent memstick host from getting runtime suspended during card detection

Arnd Bergmann <arnd@arndb.de>
    ARM: mmp: fix timer_init calls

Fabio Estevam <festevam@gmail.com>
    ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M

Arnd Bergmann <arnd@arndb.de>
    ARM: pxa: avoid section mismatch warning

Jan Kara <jack@suse.cz>
    udf: Fix BUG on corrupted inode

Adamski, Krzysztof (Nokia - PL/Wroclaw) <krzysztof.adamski@nokia.com>
    i2c-axxia: check for error conditions first

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

Dan Carpenter <dan.carpenter@oracle.com>
    tracing: Have trace_stack nr_entries compare not be so subtle

Jiong Wang <jiong.wang@netronome.com>
    mips: bpf: fix encoding bug for mm_srlv32_op

Russell King - ARM Linux <linux@armlinux.org.uk>
    ARM: dts: Fix OMAP4430 SDP Ethernet startup

Yu Zhao <yuzhao@google.com>
    iommu/amd: Fix amd_iommu=force_isolation

Chen-Yu Tsai <wens@csie.org>
    clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module clocks

Bart Van Assche <bvanassche@acm.org>
    timekeeping: Use proper seqcount initializer

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: hub: delay hub autosuspend if USB3 port is still link training

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

Arend van Spriel <arend.vanspriel@broadcom.com>
    firmware/efi: Add NULL pointer checks in efivars API functions

Wei Wang <wvw@google.com>
    Thermal: do not clear passive state during system sleep

J. Bruce Fields <bfields@redhat.com>
    nfsd4: fix crash on writing v4_end_grace before nfsd startup

Yangtao Li <tiny.windzz@gmail.com>
    soc: bcm: brcmstb: Don't leak device tree node reference

Young Xiao <YangX92@hotmail.com>
    sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN

Tiezhu Yang <kernelpatch@126.com>
    f2fs: fix wrong return value of f2fs_acl_create

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: avoid build warn of fall_through

Yunlei He <heyunlei@huawei.com>
    f2fs: move dir data flush to write checkpoint process

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: adv*/tc358743/ths8200: fill in min width/height/pixelclock

Hans de Goede <hdegoede@redhat.com>
    iio: accel: kxcjk1013: Add KIOX010A ACPI Hardware-ID

Nathan Chancellor <natechancellor@gmail.com>
    dmaengine: xilinx_dma: Remove __aligned attribute on zynqmp_dma_desc_ll

Alexey Khoroshilov <khoroshilov@ispras.ru>
    media: mtk-vcodec: Release device nodes in mtk_vcodec_init_enc_pm()

Yangtao Li <tiny.windzz@gmail.com>
    soc/tegra: Don't leak device tree node reference

Pu Wen <puwen@hygon.cn>
    perf tools: Add Hygon Dhyana support

Sami Tolvanen <samitolvanen@google.com>
    modpost: validate symbol names also in find_elf_symbol

Nathan Chancellor <natechancellor@gmail.com>
    ARM: OMAP2+: hwmod: Fix some section annotations

Renato Lui Geh <renatogeh@gmail.com>
    staging: iio: ad7780: update voltage on read

Matheus Tavares <matheus.bernardino@usp.br>
    staging:iio:ad2s90: Make probe handle spi_setup failure

Miroslav Lichvar <mlichvar@redhat.com>
    ptp: check gettime64 return code in PTP_SYS_OFFSET ioctl

Andy Duan <fugang.duan@nxp.com>
    serial: fsl_lpuart: clear parity enable bit when disable parity

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: ->x_scaling[1] should never be set to VC4_SCALING_NONE

Frank Rowand <frank.rowand@sony.com>
    powerpc/pseries: add of_node_put() in dlpar_detach_node()

Colin Ian King <colin.king@canonical.com>
    x86/PCI: Fix Broadcom CNB20LE unintended sign extension (redux)

Bob Peterson <rpeterso@redhat.com>
    dlm: Don't swamp the CPU with callbacks queued during recovery

Yufen Wang <wangyufen@huawei.com>
    ARM: 8808/1: kexec:offline panic_smp_self_stop CPU

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Correct LCB RJT handling

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    ath9k: dynack: use authentication messages for 'late' ack

Steve Longerbeam <slongerbeam@gmail.com>
    gpu: ipu-v3: image-convert: Prevent race between run and unprepare

Arnd Bergmann <arnd@arndb.de>
    ASoC: Intel: mrfld: fix uninitialized variable access

Slawomir Stepien <sst@poczta.fm>
    staging: iio: adc: ad7280a: handle error from __ad7280_read32()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/bufs: Fix Spectre v1 vulnerability


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/mmp2.dtsi                        |  9 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |  1 +
 arch/arm/kernel/smp.c                              | 15 ++++
 arch/arm/kvm/mmio.c                                | 11 +--
 arch/arm/mach-mmp/common.h                         |  2 +-
 arch/arm/mach-mmp/mmp2.c                           |  2 +-
 arch/arm/mach-mmp/pxa168.c                         |  2 +-
 arch/arm/mach-mmp/pxa910.c                         |  2 +-
 arch/arm/mach-mmp/time.c                           | 32 ++++---
 arch/arm/mach-omap2/omap_hwmod.c                   |  6 +-
 arch/arm/mach-pxa/cm-x300.c                        |  2 +-
 arch/arm/mach-pxa/littleton.c                      |  2 +-
 arch/arm/mach-pxa/zeus.c                           |  2 +-
 arch/arm64/kernel/entry-ftrace.S                   |  1 -
 arch/mips/include/uapi/asm/inst.h                  |  2 +-
 arch/mips/ralink/Kconfig                           |  1 +
 arch/powerpc/include/asm/uaccess.h                 |  2 +-
 arch/powerpc/platforms/pseries/dlpar.c             |  2 +
 arch/s390/kvm/kvm-s390.c                           | 17 +++-
 arch/um/include/asm/pgtable.h                      |  9 +-
 arch/x86/events/intel/core.c                       | 10 ++-
 arch/x86/events/intel/uncore_snbep.c               |  4 +-
 arch/x86/include/asm/fpu/internal.h                |  3 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |  1 +
 arch/x86/kvm/svm.c                                 |  7 ++
 arch/x86/kvm/vmx.c                                 |  1 +
 arch/x86/kvm/x86.c                                 |  7 ++
 arch/x86/pci/broadcom_bus.c                        |  4 +-
 drivers/ata/sata_rcar.c                            |  4 +-
 drivers/block/drbd/drbd_nl.c                       | 15 ++--
 drivers/block/drbd/drbd_receiver.c                 | 13 +--
 drivers/block/sunvdc.c                             |  5 ++
 drivers/block/swim3.c                              |  6 +-
 drivers/cdrom/gdrom.c                              |  1 +
 drivers/clk/imx/clk-imx6sl.c                       |  6 ++
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |  6 +-
 drivers/cpuidle/cpuidle-big_little.c               |  7 +-
 drivers/crypto/ux500/cryp/cryp_core.c              |  4 +-
 drivers/crypto/ux500/hash/hash_core.c              |  2 +-
 drivers/dma/bcm2835-dma.c                          | 70 ++++++---------
 drivers/dma/imx-dma.c                              |  8 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |  2 +-
 drivers/firmware/efi/vars.c                        | 99 +++++++++++++++++-----
 drivers/gpu/drm/drm_bufs.c                         |  3 +
 drivers/gpu/drm/vc4/vc4_plane.c                    | 12 +--
 drivers/gpu/ipu-v3/ipu-image-convert.c             | 10 ++-
 drivers/hid/hid-lenovo.c                           | 10 ++-
 drivers/hwmon/lm80.c                               | 26 ++++--
 drivers/i2c/busses/i2c-axxia.c                     | 32 +++----
 drivers/iio/accel/kxcjk-1013.c                     |  1 +
 drivers/infiniband/hw/hfi1/ruc.c                   |  7 +-
 drivers/infiniband/hw/qib/qib_ruc.c                |  7 +-
 drivers/iommu/amd_iommu.c                          |  9 +-
 drivers/iommu/arm-smmu-v3.c                        |  8 +-
 drivers/iommu/arm-smmu.c                           |  3 +
 drivers/isdn/hisax/hfc_pci.c                       |  2 +
 drivers/media/i2c/ad9389b.c                        |  2 +-
 drivers/media/i2c/adv7511.c                        |  2 +-
 drivers/media/i2c/adv7604.c                        |  4 +-
 drivers/media/i2c/adv7842.c                        |  4 +-
 drivers/media/i2c/tc358743.c                       |  2 +-
 drivers/media/i2c/ths8200.c                        |  2 +-
 drivers/media/platform/davinci/vpbe.c              |  7 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 10 ++-
 drivers/memstick/core/memstick.c                   |  3 +
 drivers/net/ethernet/broadcom/bcmsysport.c         | 25 +++---
 drivers/net/ethernet/broadcom/bcmsysport.h         |  2 +
 drivers/net/ethernet/cisco/enic/enic_main.c        |  2 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |  2 +-
 drivers/net/ethernet/freescale/fman/fman_tgec.c    |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  3 +
 drivers/net/ethernet/intel/igb/igb_main.c          |  8 +-
 drivers/net/ethernet/marvell/skge.c                |  6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 14 +++
 drivers/net/ethernet/sun/niu.c                     | 10 ++-
 drivers/net/phy/dp83640.c                          | 13 ++-
 drivers/net/wireless/ath/ath9k/dynack.c            |  3 +-
 drivers/net/wireless/st/cw1200/scan.c              | 13 ++-
 drivers/pci/host/vmd.c                             | 15 ++++
 drivers/pinctrl/meson/pinctrl-meson8.c             |  3 +
 drivers/pinctrl/meson/pinctrl-meson8b.c            | 13 +--
 drivers/ptp/ptp_chardev.c                          |  5 +-
 drivers/scsi/aic94xx/aic94xx_init.c                |  8 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  3 +
 drivers/scsi/smartpqi/smartpqi_init.c              |  6 ++
 drivers/soc/bcm/brcmstb/common.c                   |  6 +-
 drivers/soc/tegra/common.c                         |  6 +-
 drivers/staging/iio/adc/ad7280a.c                  | 17 +++-
 drivers/staging/iio/adc/ad7780.c                   |  6 +-
 drivers/staging/iio/resolver/ad2s90.c              |  7 +-
 drivers/thermal/thermal-generic-adc.c              | 12 ++-
 drivers/thermal/thermal_core.c                     | 12 ++-
 drivers/thermal/thermal_hwmon.h                    |  4 +-
 drivers/tty/serial/fsl_lpuart.c                    |  4 +
 drivers/tty/serial/samsung.c                       |  3 +
 drivers/tty/serial/serial_core.c                   |  6 ++
 drivers/usb/core/hub.c                             | 10 +++
 drivers/usb/gadget/udc/net2272.c                   |  2 +-
 drivers/usb/musb/musb_gadget.c                     | 13 +--
 drivers/usb/musb/musbhsdma.c                       | 21 ++---
 drivers/usb/phy/phy-am335x.c                       |  5 +-
 drivers/video/console/fbcon.c                      |  2 +-
 drivers/video/fbdev/clps711x-fb.c                  |  5 +-
 drivers/video/fbdev/core/fbmem.c                   |  8 +-
 fs/binfmt_script.c                                 | 10 ++-
 fs/cifs/readdir.c                                  |  9 +-
 fs/dlm/ast.c                                       | 10 +++
 fs/eventpoll.c                                     |  2 +-
 fs/f2fs/acl.c                                      | 14 +--
 fs/f2fs/f2fs.h                                     | 12 ++-
 fs/f2fs/file.c                                     |  3 +
 fs/f2fs/shrinker.c                                 |  2 +-
 fs/fuse/dev.c                                      |  4 +-
 fs/fuse/file.c                                     |  2 +-
 fs/nfs/super.c                                     |  3 +-
 fs/nfsd/nfsctl.c                                   |  2 +
 fs/ocfs2/buffer_head_io.c                          |  2 -
 fs/proc/base.c                                     | 12 ++-
 fs/udf/inode.c                                     |  6 ++
 include/linux/genl_magic_struct.h                  |  5 +-
 include/linux/sched.h                              |  1 +
 include/sound/compress_driver.h                    |  6 +-
 kernel/events/ring_buffer.c                        |  3 +
 kernel/hung_task.c                                 |  8 +-
 kernel/sysctl.c                                    |  2 +
 kernel/time/timekeeping.c                          |  4 +-
 kernel/trace/trace_stack.c                         |  2 +-
 lib/seq_buf.c                                      |  6 +-
 mm/oom_kill.c                                      |  4 +-
 net/bluetooth/hci_event.c                          |  6 ++
 net/dccp/ccid.h                                    |  4 +-
 net/dsa/slave.c                                    | 12 ++-
 net/ipv6/xfrm6_tunnel.c                            |  3 +
 net/mac80211/rx.c                                  |  5 +-
 net/rds/bind.c                                     |  6 +-
 net/rxrpc/recvmsg.c                                |  3 +-
 scripts/decode_stacktrace.sh                       |  2 +-
 scripts/mod/modpost.c                              | 50 +++++------
 security/smack/smack_lsm.c                         | 12 ++-
 sound/pci/hda/hda_bind.c                           |  3 +-
 sound/pci/hda/hda_codec.h                          |  1 +
 sound/pci/hda/hda_intel.c                          |  2 +
 sound/soc/fsl/Kconfig                              |  2 +-
 sound/soc/intel/atom/sst/sst_loader.c              |  8 +-
 tools/perf/arch/x86/util/kvm-stat.c                |  2 +-
 tools/perf/tests/evsel-tp-sched.c                  |  2 +-
 tools/perf/util/header.c                           |  2 +-
 tools/perf/util/probe-file.c                       |  2 +-
 virt/kvm/kvm_main.c                                |  3 +-
 150 files changed, 779 insertions(+), 367 deletions(-)


