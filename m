Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A545ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96905214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96905214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeIXSO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:14:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55118 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbeIXSO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:14:57 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33389108B;
        Mon, 24 Sep 2018 12:13:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/173] 4.14.72-stable review
Date:   Mon, 24 Sep 2018 13:50:34 +0200
Message-Id: <20180924113114.334025954@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.72-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.72-rc1
X-KernelTest-Deadline: 2018-09-26T11:31+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.72 release.
There are 173 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Sep 26 11:30:10 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.72-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.72-rc1

Benjamin Poirier <bpoirier@suse.com>
    e1000e: Fix check_for_link return value with autoneg off

Benjamin Poirier <bpoirier@suse.com>
    e1000e: Fix link check race condition

Benjamin Poirier <bpoirier@suse.com>
    Revert "e1000e: Separate signaling for link check/link up"

Benjamin Poirier <bpoirier@suse.com>
    e1000e: Avoid missed interrupts following ICR read

Benjamin Poirier <bpoirier@suse.com>
    e1000e: Fix queue interrupt re-raising in Other interrupt

Benjamin Poirier <bpoirier@suse.com>
    Partial revert "e1000e: Avoid receiver overrun interrupt bursts"

Benjamin Poirier <bpoirier@suse.com>
    e1000e: Remove Other from EIAC

David Ahern <dsahern@gmail.com>
    net/ipv6: prevent use after free in ip6_route_mpath_notify

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915: Apply the GTT write flush for all !llc machines

Jaechul Lee <jcsing.lee@samsung.com>
    ASoC: samsung: Fix invalid argument when devm_gpiod_get is called

Christophe Jaillet <christophe.jaillet@wanadoo.fr>
    ASoC: samsung: i2s: Fix error handling path in i2s_set_sysclk()

Michal Simek <michal.simek@xilinx.com>
    earlycon: Remove hardcoded port->uartclk initialization in of_setup_earlycon

Michal Simek <michal.simek@xilinx.com>
    earlycon: Initialize port->uartclk based on clock-frequency property

Dan Carpenter <dan.carpenter@oracle.com>
    mei: bus: type promotion bug in mei_nfc_if_version()

Mikko Perttunen <mperttunen@nvidia.com>
    clk: tegra: bpmp: Don't crash when a clock fails to register

Douglas Anderson <dianders@chromium.org>
    pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant

Douglas Anderson <dianders@chromium.org>
    pinctrl: msm: Fix msm_config_group_get() to be compliant

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: Respect error code of ->get_direction()

Ming Lei <ming.lei@redhat.com>
    blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()

Ming Lei <ming.lei@redhat.com>
    blk-mq: only attempt to merge bio if there is rq in sw queue

Bart Van Assche <bart.vanassche@wdc.com>
    IB/nes: Fix a compiler warning

Dan Carpenter <dan.carpenter@oracle.com>
    drm/panel: type promotion bug in s6e8aa0_read_mtp_id()

John Stultz <john.stultz@linaro.org>
    selftest: timers: Tweak raw_skew to SKIP when ADJ_OFFSET/other clock adjustments are in progress

Hannes Reinecke <hare@suse.de>
    scsi: libfc: fixup 'sleeping function called from invalid context'

Timo Wischer <twischer@de.adit-jv.com>
    ALSA: pcm: Fix snd_interval_refine first/last with open min/max

Zhouyang Jia <jiazhouyang09@gmail.com>
    rtc: bq4802: add error handling for devm_ioremap

Wei Lu <wei.lu2@amd.com>
    drm/amdkfd: Fix error codes in kfd_get_process

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    rcu: Fix grace-period hangs due to race with CPU offline

Peter Rosin <peda@axentia.se>
    input: rohm_bu21023: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Peter Rosin <peda@axentia.se>
    mfd: 88pm860x-i2c: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: Mark gpio_suffixes array with __maybe_unused

Wei Yongjun <weiyongjun1@huawei.com>
    gpio: pxa: Fix potential NULL dereference

Tuomas Tynkkynen <tuomas@tuxera.com>
    staging: bcm2835-audio: Don't leak workqueue if open fails

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: ETM: Add support for Arm Cortex-A73 and Cortex-A35

Robin Murphy <robin.murphy@arm.com>
    coresight: tpiu: Fix disabling timeouts

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: Handle errors in finding input/output ports

Quentin Perret <quentin.perret@arm.com>
    sched/fair: Fix util_avg of new tasks for asymmetric systems

Julia Lawall <Julia.Lawall@lip6.fr>
    parport: sunbpp: fix error return code

Thierry Reding <treding@nvidia.com>
    drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping

Karol Herbst <karolherbst@gmail.com>
    drm/nouveau/debugfs: Wake up GPU before doing any reclocking

Lyude Paul <lyude@redhat.com>
    drm/nouveau: Fix runtime PM leak in drm_open()

Stefan Agner <stefan@agner.ch>
    mmc: sdhci: do not try to use 3.3V signaling if not supported

Stefan Agner <stefan@agner.ch>
    mmc: tegra: prevent HS200 on Tegra 3

Laurentiu Tudor <laurentiu.tudor@nxp.com>
    mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips

Johan Hovold <johan@kernel.org>
    tty: fix termios input-speed encoding

Johan Hovold <johan@kernel.org>
    tty: fix termios input-speed encoding when using BOTHER

Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
    gpu: ipu-v3: csi: pass back mbus_code_to_bus_cfg error codes

Rick Farrington <ricardo.farrington@cavium.com>
    liquidio: fix hang when re-binding VF host drv after running DPDK VF driver

Nicholas Mc Guire <hofrat@osadl.org>
    ARM: hisi: check of_iomap and fix missing of_node_put

Nicholas Mc Guire <hofrat@osadl.org>
    ARM: hisi: fix error handling and missing of_node_put

Nicholas Mc Guire <hofrat@osadl.org>
    ARM: hisi: handle of_iomap and fix missing of_node_put

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/esrt: Only call efi_mem_reserve() for boot services memory

Andrea Parri <andrea.parri@amarulasolutions.com>
    sched/core: Use smp_mb() in wake_woken_function()

Tony Lindgren <tony@atomide.com>
    pinctrl: pinmux: Return selector to the pinctrl driver

Tony Lindgren <tony@atomide.com>
    pinctrl: rza1: Fix selector use for groups and functions

Mike Christie <mchristi@redhat.com>
    configfs: fix registered group removal

Paul Burton <paul.burton@mips.com>
    MIPS: loongson64: cs5536: Fix PCI_OHCI_INT_REG reads

Eric Biggers <ebiggers@google.com>
    security: check for kstrdup() failure in lsm_append()

Nicholas Mc Guire <hofrat@osadl.org>
    KVM: PPC: Book3S HV: Add of_node_put() in success path

Matthew Garrett <mjg59@google.com>
    evm: Don't deadlock if a crypto algorithm is unavailable

Philipp Puschmann <pp@emlix.com>
    Bluetooth: Use lock_sock_nested in bt_accept_enqueue

Miklos Szeredi <mszeredi@redhat.com>
    vfs: fix freeze protection in mnt_want_write_file() for overlayfs

Jann Horn <jannh@google.com>
    mtdchar: fix overflows in adjustment of `count`

Ronny Chevalier <ronny.chevalier@hp.com>
    audit: fix use-after-free in audit_add_watch

Viresh Kumar <viresh.kumar@linaro.org>
    arm64: dts: uniphier: Add missing cooling device properties for CPUs

Noa Osherovich <noaos@mellanox.com>
    net/mlx5: Add missing SET_DRIVER_VERSION command translation

Maciej W. Rozycki <macro@mips.com>
    binfmt_elf: Respect error return from `regset->active'

Trond Myklebust <trondmy@gmail.com>
    NFSv4.1 fix infinite loop on I/O.

Boris Ostrovsky <boris.ostrovsky@oracle.com>
    x86/EISA: Don't probe EISA bus for Xen PV guests

Yabin Cui <yabinc@google.com>
    perf/core: Force USER_DS when recording user stack data

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: ISS: don't allocate memory in platform_setup

Dan Carpenter <dan.carpenter@oracle.com>
    CIFS: fix wrapping bugs in num_entries()

Dan Carpenter <dan.carpenter@oracle.com>
    cifs: prevent integer overflow in nxt_dir_entry()

Oliver Neukum <oneukum@suse.com>
    Revert "cdc-acm: implement put_char() and flush_chars()"

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()

Ben Hutchings <ben.hutchings@codethink.co.uk>
    USB: yurex: Fix buffer over-read in yurex_write()

Johan Hovold <johan@kernel.org>
    USB: serial: ti_usb_3410_5052: fix array underflow in completion handler

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: misc: uss720: Fix two sleep-in-atomic-context bugs

Johan Hovold <johan@kernel.org>
    USB: serial: io_ti: fix array underflow in completion handler

Alan Stern <stern@rowland.harvard.edu>
    USB: net2280: Fix erroneous synchronization change

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: gadget: udc: renesas_usb3: fix maxpacket size of ep0

Maxence Duprès <xpros64@hotmail.fr>
    USB: add quirk for WORLDE Controller KS49 or Prodipe MIDI 49C USB controller

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_frame()

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: Avoid use-after-free by flushing endpoints early in usb_set_interface()

Oliver Neukum <oneukum@suse.com>
    usb: uas: add support for more quirk flags

Tim Anderson <tsa@biglakesoftware.com>
    USB: Add quirk to support DJI CineSSD

Tomas Winkler <tomas.winkler@intel.com>
    mei: bus: need to unlink client before freeing

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: ignore not found client in the enumeration

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: Don't die twice if PCI xhci host is not responding in resume

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix use after free for URB cancellation on a reallocated endpoint

Gustavo A. R. Silva <gustavo@embeddedor.com>
    misc: hmc6352: fix potential Spectre v1

K. Y. Srinivasan <kys@microsoft.com>
    Tools: hv: Fix a bug in the key delete code

Corey Minyard <cminyard@mvista.com>
    ipmi: Fix I2C client removal in the SSIF driver

Andreas Kemnade <andreas@kemnade.info>
    mmc: omap_hsmmc: fix wakeirq handling on removal

Ingo Franzki <ifranzki@linux.ibm.com>
    s390/crypto: Fix return code checking in cbc_paes_crypt()

Aaron Knister <aaron.s.knister@nasa.gov>
    IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handler

Juergen Gross <jgross@suse.com>
    xen/netfront: fix waiting for xenbus state change

Bin Yang <bin.yang@intel.com>
    pstore: Fix incorrect persistent ram buffer mapping

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Protect cma dev list with lock

Xiao Liang <xiliang@redhat.com>
    xen-netfront: fix warn message as irq device name has '/'

Joerg Roedel <jroedel@suse.de>
    x86/mm/pti: Add an overflow check to pti_clone_pmds()

Jiang Biao <jiang.biao2@zte.com.cn>
    x86/pti: Check the return value of pti_user_pagetable_walk_pmd()

Jiang Biao <jiang.biao2@zte.com.cn>
    x86/pti: Check the return value of pti_user_pagetable_walk_p4d()

Michael Müller <michael@fds-team.de>
    crypto: sharah - Unregister correct algorithms for SAHARA 3

Hanna Hawa <hannah@marvell.com>
    dmaengine: mv_xor_v2: kill the tasklets upon exit

Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
    i2c: aspeed: Fix initial values of master and slave state

Pingfan Liu <kernelfans@gmail.com>
    drivers/base: stop new probing during shutdown

Christoffer Dall <christoffer.dall@arm.com>
    KVM: arm/arm64: Fix vgic init race

Randy Dunlap <rdunlap@infradead.org>
    platform/x86: toshiba_acpi: Fix defined but not used build warnings

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: reset layer2 attribute on layer switch

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix race in used-buffer accounting

Bhushan Shah <bshah@kde.org>
    ARM: dts: qcom: msm8974-hammerhead: increase load on l20 for sdhci

Loic Poulain <loic.poulain@linaro.org>
    arm64: dts: qcom: db410c: Fix Bluetooth LED trigger

Vitaly Kuznetsov <vkuznets@redhat.com>
    xen-netfront: fix queue name setting

Jakub Kicinski <jakub.kicinski@netronome.com>
    nfp: avoid buffer leak when FW communication fails

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/arm: preserve early mapping of UEFI memory map longer for BGRT

Leonard Crestez <leonard.crestez@nxp.com>
    reset: imx7: Fix always writing bits as 0

Mark Rutland <mark.rutland@arm.com>
    arm64: fix possible spectre-v1 write in ptrace_hbp_set_event()

YueHaibing <yuehaibing@huawei.com>
    wan/fsl_ucc_hdlc: use IS_ERR_VALUE() to check return value of qe_muram_alloc

Piotr Sawicki <p.sawicki2@partner.samsung.com>
    Smack: Fix handling of IPv4 traffic received by PF_INET6 sockets

Manikanta Pubbisetty <mpubbise@codeaurora.org>
    mac80211: restrict delayed tailroom needed decrement

Paul Cercueil <paul@crapouillou.net>
    MIPS: jz4740: Bump zload address

Oder Chiou <oder_chiou@realtek.com>
    ASoC: rt5514: Fix the issue of the delay volume applied

Nicholas Mc Guire <hofrat@osadl.org>
    staging: bcm2835-camera: handle wait_for_completion_timeout return properly

Nicholas Mc Guire <hofrat@osadl.org>
    staging: bcm2835-camera: fix timeout handling in wait_for_completion_timeout

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: opal_put_chars partial write fix

Mark Rutland <mark.rutland@arm.com>
    KVM: arm/arm64: vgic: Fix possible spectre-v1 write in vgic_mmio_write_apr()

Sagi Grimberg <sagi@grimberg.me>
    nvme-rdma: unquiesce queues when deleting the controller

Sandipan Das <sandipan@linux.ibm.com>
    perf powerpc: Fix callchain ip filtering

Krzysztof Kozlowski <krzk@kernel.org>
    ARM: exynos: Clear global variable on init error path

Fredrik Noring <noring@nocrew.org>
    fbdev: Distinguish between interlaced and progressive modes

Daniel Mack <daniel@zonque.org>
    video: fbdev: pxafb: clear allocated memory for video modes

Sandipan Das <sandipan@linux.ibm.com>
    perf powerpc: Fix callchain ip filtering when return address is in a register

Randy Dunlap <rdunlap@infradead.org>
    fbdev/via: fix defined but not used warning

Anton Vasilyev <vasilyev@ispras.ru>
    video: goldfishfb: fix memory leak on driver remove

Jiri Olsa <jolsa@redhat.com>
    perf tools: Fix struct comm_str removal crash

Dan Carpenter <dan.carpenter@oracle.com>
    fbdev: omapfb: off by one in omapfb_register_client()

Jiri Olsa <jolsa@kernel.org>
    perf tools: Synthesize GROUP_DESC feature in pipe mode

Bob Peterson <rpeterso@redhat.com>
    gfs2: Don't reject a supposedly full bitmap if we have blocks reserved

Thomas Richter <tmricht@linux.ibm.com>
    perf test: Fix subtest number when showing results

Todor Tomov <todor.tomov@linaro.org>
    media: ov5645: Supported external clock is 24MHz

Randy Dunlap <rdunlap@infradead.org>
    mtd/maps: fix solutionengine.c printk format warnings

Wei Yongjun <weiyongjun1@huawei.com>
    IB/ipoib: Fix error return code in ipoib_dev_init()

Mike Snitzer <snitzer@redhat.com>
    block: allow max_discard_segments to be stacked

Zhu Yanjun <yanjun.zhu@oracle.com>
    IB/rxe: Drop QP0 silently

Hans Verkuil <hverkuil@xs4all.nl>
    media: videobuf2-core: check for q->error in vb2_core_qbuf()

Felix Fietkau <nbd@nbd.name>
    MIPS: ath79: fix system restart

John Keeping <john@metanate.com>
    dmaengine: pl330: fix irq race with terminate_all

Krzysztof Ha?asa <khalasa@piap.pl>
    media: tw686x: Fix oops on buffer alloc failure

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: add .DELETE_ON_ERROR special target

Rajan Vaja <rajan.vaja@xilinx.com>
    clk: clk-fixed-factor: Clear OF_POPULATED flag in case of failure

Mikko Perttunen <mperttunen@nvidia.com>
    clk: core: Potentially free connection id

Nicholas Mc Guire <hofrat@osadl.org>
    clk: imx6ul: fix missing of_node_put()

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Special-case rindex for gfs2_grow

YueHaibing <yuehaibing@huawei.com>
    amd-xgbe: use dma_mapping_error to check map errors

YueHaibing <yuehaibing@huawei.com>
    xfrm: fix 'passing zero to ERR_PTR()' warning

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Fix multiple definitions in AU0828_DEVICE() macro

Takashi Iwai <tiwai@suse.de>
    ALSA: msnd: Fix the default sample sizes

Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
    iommu/io-pgtable-arm-v7s: Abort allocation when table address overflows the PTE

Miao Zhong <zhongmiao@hisilicon.com>
    iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer register

Erich E. Hoover <ehoover@sweptlaser.com>
    usb: dwc3: change stream event enable bit back to 13

Takashi Iwai <tiwai@suse.de>
    hv/netvsc: Fix NULL dereference at single queue mode fallback

Vincent Whitchurch <vincent.whitchurch@axis.com>
    tcp: really ignore MSG_ZEROCOPY if no SO_ZEROCOPY

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    erspan: return PACKET_REJECT when the appropriate tunnel is not found

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    erspan: fix error handling for erspan tunnel

Vakul Garg <vakul.garg@nxp.com>
    net/tls: Set count of SG entries if sk_alloc_sg returns -ENOSPC

Raed Salem <raeds@mellanox.com>
    net/mlx5: E-Switch, Fix memory leak when creating switchdev mode FDB tables

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx5: Fix debugfs cleanup in the device init/remove flow

Huy Nguyen <huyn@mellanox.com>
    net/mlx5: Check for error in mlx5_attach_interface

Cong Wang <xiyou.wangcong@gmail.com>
    rds: fix two RCU related problems

Stefan Wahren <stefan.wahren@i2se.com>
    net: qca_spi: Fix race condition in spi transfers

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx5: Fix use-after-free in self-healing flow

Petr Oros <poros@redhat.com>
    be2net: Fix memory leak in be_cmd_get_profile_config()


-------------

Diffstat:

 Makefile                                           |   4 +-
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |   2 +
 arch/arm/mach-exynos/suspend.c                     |   1 +
 arch/arm/mach-hisi/hotplug.c                       |  41 +++++---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |   2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |   2 +
 arch/arm64/kernel/ptrace.c                         |  19 ++--
 arch/mips/ath79/setup.c                            |   1 +
 arch/mips/include/asm/mach-ath79/ath79.h           |   1 +
 arch/mips/jz4740/Platform                          |   2 +-
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c   |   2 +-
 arch/powerpc/kvm/book3s_hv.c                       |   2 +
 arch/powerpc/platforms/powernv/opal.c              |   2 +-
 arch/s390/crypto/paes_s390.c                       |   2 +-
 arch/x86/kernel/eisa.c                             |  10 +-
 arch/x86/mm/pti.c                                  |  25 ++++-
 arch/xtensa/platforms/iss/setup.c                  |  25 +++--
 block/blk-core.c                                   |   8 +-
 block/blk-mq-sched.c                               |   3 +-
 block/blk-settings.c                               |   2 +-
 crypto/api.c                                       |   2 +-
 drivers/base/core.c                                |   3 +
 drivers/char/ipmi/ipmi_ssif.c                      |  19 ++--
 drivers/clk/clk-fixed-factor.c                     |   9 +-
 drivers/clk/clk.c                                  |   3 +
 drivers/clk/imx/clk-imx6ul.c                       |   1 +
 drivers/clk/tegra/clk-bpmp.c                       |  12 ++-
 drivers/crypto/sahara.c                            |   4 +-
 drivers/dma/mv_xor_v2.c                            |   2 +
 drivers/dma/pl330.c                                |   5 +-
 drivers/firmware/efi/arm-init.c                    |   1 -
 drivers/firmware/efi/arm-runtime.c                 |   4 +-
 drivers/firmware/efi/esrt.c                        |   3 +-
 drivers/gpio/gpio-pxa.c                            |   2 +
 drivers/gpio/gpiolib.c                             |   6 ++
 drivers/gpio/gpiolib.h                             |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   2 +
 drivers/gpu/drm/i915/i915_gem.c                    |   4 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          |   4 +
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |  13 +++
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |   2 +-
 drivers/gpu/ipu-v3/ipu-csi.c                       |  20 +++-
 drivers/hwtracing/coresight/coresight-etm4x.c      |  31 +++---
 drivers/hwtracing/coresight/coresight-tpiu.c       |   7 +-
 drivers/hwtracing/coresight/coresight.c            |   7 +-
 drivers/i2c/busses/i2c-aspeed.c                    |   4 +-
 drivers/infiniband/core/cma.c                      |  12 ++-
 drivers/infiniband/hw/nes/nes.h                    |   2 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               |   9 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   2 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   3 +-
 drivers/input/touchscreen/rohm_bu21023.c           |   4 +-
 drivers/iommu/arm-smmu-v3.c                        |   1 +
 drivers/iommu/io-pgtable-arm-v7s.c                 |   7 +-
 drivers/media/i2c/ov5645.c                         |  13 +--
 drivers/media/pci/tw686x/tw686x-video.c            |  11 ++-
 drivers/media/v4l2-core/videobuf2-core.c           |   5 +
 drivers/mfd/88pm860x-i2c.c                         |   8 +-
 drivers/misc/hmc6352.c                             |   2 +
 drivers/misc/mei/bus-fixup.c                       |   2 +-
 drivers/misc/mei/bus.c                             |   9 +-
 drivers/misc/mei/hbm.c                             |   9 +-
 drivers/mmc/host/omap_hsmmc.c                      |   1 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |   6 ++
 drivers/mmc/host/sdhci-tegra.c                     |   3 +-
 drivers/mmc/host/sdhci.c                           |   9 +-
 drivers/mtd/maps/solutionengine.c                  |   6 +-
 drivers/mtd/mtdchar.c                              |  10 +-
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c          |   7 +-
 .../ethernet/cavium/liquidio/cn23xx_pf_device.c    |   3 +
 .../ethernet/cavium/liquidio/cn23xx_vf_device.c    |   3 +
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   2 +-
 drivers/net/ethernet/intel/e1000e/defines.h        |  21 +++-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  42 ++++----
 drivers/net/ethernet/intel/e1000e/mac.c            |  25 ++---
 drivers/net/ethernet/intel/e1000e/netdev.c         |  33 +++----
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |  15 ++-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  12 ++-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |  13 ++-
 drivers/net/ethernet/qualcomm/qca_7k.c             |  76 +++++++-------
 drivers/net/ethernet/qualcomm/qca_spi.c            | 110 +++++++++++----------
 drivers/net/ethernet/qualcomm/qca_spi.h            |   5 -
 drivers/net/hyperv/rndis_filter.c                  |   2 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |   6 +-
 drivers/net/xen-netfront.c                         |  30 +++---
 drivers/nvme/host/rdma.c                           |   2 +
 drivers/parport/parport_sunbpp.c                   |   8 +-
 drivers/pinctrl/pinctrl-rza1.c                     |  24 ++---
 drivers/pinctrl/pinmux.c                           |  16 ++-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  14 ++-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  32 ++++--
 drivers/platform/x86/toshiba_acpi.c                |   3 +-
 drivers/reset/reset-imx7.c                         |   2 +-
 drivers/rtc/rtc-bq4802.c                           |   4 +
 drivers/s390/net/qeth_core_main.c                  |   3 +-
 drivers/s390/net/qeth_core_sys.c                   |   1 +
 drivers/scsi/libfc/fc_disc.c                       |   7 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |  16 +--
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |   7 +-
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |  11 ++-
 drivers/tty/serial/earlycon.c                      |   5 +-
 drivers/tty/tty_baudrate.c                         |  13 ++-
 drivers/usb/class/cdc-acm.c                        |  73 --------------
 drivers/usb/class/cdc-acm.h                        |   1 -
 drivers/usb/class/cdc-wdm.c                        |   2 +-
 drivers/usb/core/hcd-pci.c                         |   2 -
 drivers/usb/core/message.c                         |  11 +++
 drivers/usb/core/quirks.c                          |   7 ++
 drivers/usb/dwc3/gadget.h                          |   2 +-
 drivers/usb/gadget/udc/net2280.c                   |  16 ++-
 drivers/usb/gadget/udc/renesas_usb3.c              |   5 +-
 drivers/usb/host/u132-hcd.c                        |   2 +-
 drivers/usb/host/xhci.c                            |  30 ++++++
 drivers/usb/misc/uss720.c                          |   4 +-
 drivers/usb/misc/yurex.c                           |   5 +-
 drivers/usb/serial/io_ti.h                         |   2 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |   2 +-
 drivers/usb/storage/scsiglue.c                     |   9 ++
 drivers/usb/storage/uas.c                          |  21 ++++
 drivers/usb/storage/unusual_devs.h                 |   7 ++
 drivers/video/fbdev/core/modedb.c                  |  41 +++++---
 drivers/video/fbdev/goldfishfb.c                   |   1 +
 drivers/video/fbdev/omap/omapfb_main.c             |   2 +-
 drivers/video/fbdev/pxafb.c                        |   4 +-
 drivers/video/fbdev/via/viafbdev.c                 |   3 +-
 fs/binfmt_elf.c                                    |   2 +-
 fs/cifs/readdir.c                                  |  11 ++-
 fs/cifs/smb2pdu.c                                  |  25 +++--
 fs/configfs/dir.c                                  |  11 +++
 fs/gfs2/bmap.c                                     |   2 +-
 fs/gfs2/rgrp.c                                     |   3 +-
 fs/namespace.c                                     |   7 +-
 fs/nfs/nfs4proc.c                                  |  10 +-
 fs/nfs/nfs4state.c                                 |   2 +
 fs/pstore/ram_core.c                               |  17 +++-
 include/linux/crypto.h                             |   5 +
 include/linux/mlx5/driver.h                        |   2 +-
 kernel/audit_watch.c                               |  12 ++-
 kernel/events/core.c                               |   4 +
 kernel/rcu/tree.c                                  |   6 ++
 kernel/rcu/tree.h                                  |   4 +
 kernel/sched/fair.c                                |  10 +-
 kernel/sched/wait.c                                |  47 ++++-----
 net/bluetooth/af_bluetooth.c                       |   2 +-
 net/core/skbuff.c                                  |   3 -
 net/ipv4/ip_gre.c                                  |   4 +
 net/ipv4/tcp.c                                     |   2 +-
 net/ipv6/route.c                                   |  13 ++-
 net/mac80211/cfg.c                                 |   2 +-
 net/mac80211/key.c                                 |  24 +++--
 net/rds/bind.c                                     |   5 +-
 net/tls/tls_sw.c                                   |   6 ++
 net/xfrm/xfrm_policy.c                             |   5 +-
 scripts/Kbuild.include                             |   3 +
 security/integrity/evm/evm_crypto.c                |   3 +-
 security/security.c                                |   2 +
 security/smack/smack_lsm.c                         |  14 ++-
 sound/core/pcm_lib.c                               |  14 ++-
 sound/isa/msnd/msnd_pinnacle.c                     |   4 +-
 sound/soc/codecs/rt5514.c                          |   8 +-
 sound/soc/samsung/i2s.c                            |   5 +-
 sound/soc/samsung/tm2_wm5110.c                     |   3 +-
 sound/usb/quirks-table.h                           |   3 +-
 tools/hv/hv_kvp_daemon.c                           |   2 +-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |  10 +-
 tools/perf/tests/builtin-test.c                    |   2 +-
 tools/perf/util/comm.c                             |  16 ++-
 tools/perf/util/header.c                           |   2 +-
 tools/testing/selftests/timers/raw_skew.c          |   5 +
 virt/kvm/arm/vgic/vgic-init.c                      |   4 +
 virt/kvm/arm/vgic/vgic-mmio-v2.c                   |   3 +
 175 files changed, 1043 insertions(+), 611 deletions(-)


