Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BB6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D862214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D862214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbeIXSbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:31:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732800AbeIXSbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:31:17 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 579EF1018;
        Mon, 24 Sep 2018 12:29:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.18 000/235] 4.18.10-stable review
Date:   Mon, 24 Sep 2018 13:49:46 +0200
Message-Id: <20180924113103.999624566@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.18.10-rc1
X-KernelTest-Deadline: 2018-09-26T11:31+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.18.10 release.
There are 235 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Sep 26 11:30:01 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.10-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.18.10-rc1

Brijesh Singh <brijesh.singh@amd.com>
    crypto: ccp - add timeout support in the SEV command

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

Jann Horn <jannh@google.com>
    IB/mlx5: fix uaccess beyond "count" in debugfs read/write handlers

Randy Dunlap <rdunlap@infradead.org>
    block/DAC960.c: fix defined but not used build warnings

Bart Van Assche <bart.vanassche@wdc.com>
    IB/nes: Fix a compiler warning

Ioana Radulescu <ruxandra.radulescu@nxp.com>
    staging: fsl-dpaa2/eth: Fix DMA mapping direction

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    dmaengine: sh: rcar-dmac: avoid to write CHCR.TE to 1 if TCR is set to 0

Harry Wentland <harry.wentland@amd.com>
    drm/amd/pp: Send khz clock values to DC for smu7/8

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: perf: Disable PMU while processing counter overflows

Dan Carpenter <dan.carpenter@oracle.com>
    drm/panel: type promotion bug in s6e8aa0_read_mtp_id()

Hans de Goede <hdegoede@redhat.com>
    ASoC: rt5651: Fix workqueue cancel vs irq free race on remove

John Stultz <john.stultz@linaro.org>
    selftest: timers: Tweak raw_skew to SKIP when ADJ_OFFSET/other clock adjustments are in progress

Sibi Sankar <sibis@codeaurora.org>
    remoteproc: qcom: q6v5-pil: fix modem hang on SDM845 after axis2 clk unvote

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix panic if driver unloaded when port is offline

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix NVME Target crash in defer rcv logic

Hannes Reinecke <hare@suse.de>
    scsi: libfc: fixup 'sleeping function called from invalid context'

Timo Wischer <twischer@de.adit-jv.com>
    ALSA: pcm: Fix snd_interval_refine first/last with open min/max

Li Zhijian <lizhijian@cn.fujitsu.com>
    selftests/android: initialize heap_type to avoid compiling warning

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    selftests: vDSO - fix to return KSFT_SKIP when test couldn't be run

Zhouyang Jia <jiazhouyang09@gmail.com>
    rtc: bq4802: add error handling for devm_ioremap

Wei Lu <wei.lu2@amd.com>
    drm/amdkfd: Fix error codes in kfd_get_process

Shaoyun Liu <Shaoyun.Liu@amd.com>
    drm/amdkfd: Fix kernel queue 64 bit doorbell offset calculation

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    rcu: Fix grace-period hangs due to race with CPU offline

Peter Rosin <peda@axentia.se>
    input: rohm_bu21023: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Peter Rosin <peda@axentia.se>
    mfd: 88pm860x-i2c: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Arnd Bergmann <arnd@arndb.de>
    rcutorture: Use monotonic timestamp for stall detection

Maxime Chevallier <maxime.chevallier@bootlin.com>
    net: mvpp2: make sure we use single queue mode on PPv2.1

Linus Walleij <linus.walleij@linaro.org>
    net: gemini: Allow multiple ports to instantiate

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: Mark gpio_suffixes array with __maybe_unused

Wei Yongjun <weiyongjun1@huawei.com>
    gpio: pxa: Fix potential NULL dereference

Tuomas Tynkkynen <tuomas@tuxera.com>
    staging: bcm2835-audio: Don't leak workqueue if open fails

Matias Bjørling <mb@lightnvm.io>
    lightnvm: pblk: enable line minor version detection

Hans Holmberg <hans.holmberg@cnexlabs.com>
    lightnvm: pblk: assume that chunks are closed on 1.2 devices

Dan Carpenter <dan.carpenter@oracle.com>
    ASoC: qdsp6: q6afe-dai: fix a range check in of_q6afe_parse_dai_data()

Eric Yang <Eric.Yang2@amd.com>
    drm/amd/display: support access ddc for mst branch

Dan Williams <dan.j.williams@intel.com>
    tools/testing/nvdimm: Fix support for emulating controller temperature

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: do checkpoint in kill_sb

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

Boris Pismenny <borisp@mellanox.com>
    tls: Fix zerocopy_from_iter iov handling

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

Alexander Sverdlin <alexander.sverdlin@nokia.com>
    serial: 8250: of: Correct of_platform_serial_setup() error handling

Bartosz Golaszewski <brgl@bgdev.pl>
    gpiolib: don't allow userspace to set values of input lines

Russell King <rmk+kernel@armlinux.org.uk>
    ASoC: hdmi-codec: fix routing

Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
    gpu: ipu-v3: csi: pass back mbus_code_to_bus_cfg error codes

Rick Farrington <ricardo.farrington@cavium.com>
    liquidio: fix hang when re-binding VF host drv after running DPDK VF driver

Nicholas Mc Guire <hofrat@osadl.org>
    ARM: hisi: check of_iomap and fix missing of_node_put

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns3: Fix return value error in hns3_reset_notify_down_enet

Nicholas Mc Guire <hofrat@osadl.org>
    ARM: hisi: fix error handling and missing of_node_put

Nicholas Mc Guire <hofrat@osadl.org>
    ARM: hisi: handle of_iomap and fix missing of_node_put

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns3: Fix for reset_level default assignment probelm

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns3: Reset net device with rtnl_lock

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/esrt: Only call efi_mem_reserve() for boot services memory

Andrea Parri <andrea.parri@amarulasolutions.com>
    sched/core: Use smp_mb() in wake_woken_function()

Ryder Lee <ryder.lee@mediatek.com>
    arm64: dts: mt7622: update a clock property for UART0

Tony Lindgren <tony@atomide.com>
    pinctrl: pinmux: Return selector to the pinctrl driver

Tony Lindgren <tony@atomide.com>
    pinctrl: rza1: Fix selector use for groups and functions

Sean Wang <sean.wang@mediatek.com>
    pinctrl: mt7622: Fix probe fail by misuse the selector

Mike Christie <mchristi@redhat.com>
    configfs: fix registered group removal

Paul Burton <paul.burton@mips.com>
    MIPS: loongson64: cs5536: Fix PCI_OHCI_INT_REG reads

Alexey Kardashevskiy <aik@ozlabs.ru>
    KVM: PPC: Book3S: Fix matching of hardware and emulated TCE tables

Arvind Yadav <arvind.yadav.cs@gmail.com>
    PM / devfreq: use put_device() instead of kfree()

Eric Biggers <ebiggers@google.com>
    security: check for kstrdup() failure in lsm_append()

Nicholas Mc Guire <hofrat@osadl.org>
    KVM: PPC: Book3S HV: Add of_node_put() in success path

Matthew Garrett <mjg59@google.com>
    evm: Don't deadlock if a crypto algorithm is unavailable

Philipp Puschmann <pp@emlix.com>
    Bluetooth: Use lock_sock_nested in bt_accept_enqueue

Alexandre Belloni <alexandre.belloni@bootlin.com>
    spi: dw: fix possible race condition

Roman Gushchin <guro@fb.com>
    bpf: fix rcu annotations in compute_effective_progs()

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

Johan Hovold <johan@kernel.org>
    mmc: meson-mx-sdio: fix OF child-node lookup

Johan Hovold <johan@kernel.org>
    of: add helper to lookup compatible child node

Trond Myklebust <trondmy@gmail.com>
    NFSv4.1 fix infinite loop on I/O.

Trond Myklebust <trondmy@gmail.com>
    NFSv4: Fix a tracepoint Oops in initiate_file_draining()

Boris Ostrovsky <boris.ostrovsky@oracle.com>
    x86/EISA: Don't probe EISA bus for Xen PV guests

Rob Herring <robh@kernel.org>
    of: fix phandle cache creation for DTs with no phandles

Adrian Hunter <adrian.hunter@intel.com>
    perf tools: Fix maps__find_symbol_by_name()

Yabin Cui <yabinc@google.com>
    perf/core: Force USER_DS when recording user stack data

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: ISS: don't allocate memory in platform_setup

Dan Carpenter <dan.carpenter@oracle.com>
    cifs: integer overflow in in SMB2_ioctl()

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

Mikulas Patocka <mpatocka@redhat.com>
    dm verity: fix crash on bufio buffer that was allocated with vmalloc

Tomas Winkler <tomas.winkler@intel.com>
    mei: bus: need to unlink client before freeing

Tomas Winkler <tomas.winkler@intel.com>
    mei: bus: fix hw module get/put balance

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: ignore not found client in the enumeration

Chunfeng Yun <chunfeng.yun@mediatek.com>
    usb: mtu3: fix error of xhci port id when enable U3 dual role

Chunfeng Yun <chunfeng.yun@mediatek.com>
    usb: xhci: fix interrupt transfer error happened on MTK platforms

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: Don't die twice if PCI xhci host is not responding in resume

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix use after free for URB cancellation on a reallocated endpoint

Gustavo A. R. Silva <gustavo@embeddedor.com>
    misc: hmc6352: fix potential Spectre v1

Bryant G. Ly <bryantly@linux.ibm.com>
    misc: ibmvsm: Fix wrong assignment of return code

K. Y. Srinivasan <kys@microsoft.com>
    Tools: hv: Fix a bug in the key delete code

Stephen Hemminger <stephen@networkplumber.org>
    vmbus: don't return values for uninitalized channels

Miklos Szeredi <mszeredi@redhat.com>
    ovl: fix oopses in ovl_fill_super() failure paths

Corey Minyard <cminyard@mvista.com>
    ipmi: Fix I2C client removal in the SSIF driver

Corey Minyard <cminyard@mvista.com>
    ipmi: Move BT capabilities detection to the detect call

Corey Minyard <cminyard@mvista.com>
    ipmi: Rework SMI registration failure

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

Alexandru Gagniuc <mr.nuke.me@gmail.com>
    PCI/AER: Honor "pcie_ports=native" even if HEST sets FIRMWARE_FIRST

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

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    iommu/ipmmu-vmsa: IMUCTRn.TTSEL needs a special usage on R-Car Gen3

Niklas Cassel <niklas.cassel@linaro.org>
    regulator: qcom_spmi: Fix warning Bad of_node_put()

Niklas Cassel <niklas.cassel@linaro.org>
    regulator: qcom_spmi: Use correct regmap when checking for error

Rex Zhu <rex.zhu@amd.com>
    drm/amd/pp: Set Max clock level to display by default

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

Bjorn Andersson <bjorn.andersson@linaro.org>
    soc: qcom: smem: Correct check for global partition

Bhushan Shah <bshah@kde.org>
    ARM: dts: qcom: msm8974-hammerhead: increase load on l20 for sdhci

Loic Poulain <loic.poulain@linaro.org>
    arm64: dts: qcom: db410c: Fix Bluetooth LED trigger

Vitaly Kuznetsov <vkuznets@redhat.com>
    xen-netfront: fix queue name setting

Jakub Kicinski <jakub.kicinski@netronome.com>
    nfp: avoid buffer leak when FW communication fails

Yue Wang <yuleopen@gmail.com>
    ALSA: usb-audio: Generic DSD detection for Thesycon-based implementations

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

Sandipan Das <sandipan@linux.ibm.com>
    perf script: Show correct offsets for DWARF-based unwinding

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: opal_put_chars partial write fix

Mark Rutland <mark.rutland@arm.com>
    KVM: arm/arm64: vgic: Fix possible spectre-v1 write in vgic_mmio_write_apr()

Sagi Grimberg <sagi@grimberg.me>
    nvme-rdma: unquiesce queues when deleting the controller

Sagi Grimberg <sagi@grimberg.me>
    nvmet: fix file discard return status

Sandipan Das <sandipan@linux.ibm.com>
    perf powerpc: Fix callchain ip filtering

Krzysztof Kozlowski <krzk@kernel.org>
    ARM: exynos: Clear global variable on init error path

Arnd Bergmann <arnd@arndb.de>
    omapfb: rename omap2 module to omap2fb.ko

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

Sandipan Das <sandipan@linux.ibm.com>
    perf tests: Fix record+probe_libc_inet_pton.sh to ensure cleanups

Sandipan Das <sandipan@linux.ibm.com>
    perf tests: Fix record+probe_libc_inet_pton.sh when event exists

Sandipan Das <sandipan@linux.ibm.com>
    perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64

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
    kbuild: do not update config when running install targets

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: add .DELETE_ON_ERROR special target

Rajan Vaja <rajan.vaja@xilinx.com>
    clk: clk-fixed-factor: Clear OF_POPULATED flag in case of failure

Mikko Perttunen <mperttunen@nvidia.com>
    clk: core: Potentially free connection id

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: pxrc - fix freeing URB on device teardown

Gregory CLEMENT <gregory.clement@bootlin.com>
    clk: mvebu: armada-37xx-periph: Fix wrong return value in get_parent

Nicholas Mc Guire <hofrat@osadl.org>
    clk: imx6sll: fix missing of_node_put()

Nicholas Mc Guire <hofrat@osadl.org>
    clk: imx6ul: fix missing of_node_put()

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Special-case rindex for gfs2_grow

Golan Ben Ami <golan.ben.ami@intel.com>
    iwlwifi: cancel the injective function between hw pointers to tfd entry index

Jakub Kicinski <jakub.kicinski@netronome.com>
    nfp: don't fail probe on pci_sriov_set_totalvfs() errors

YueHaibing <yuehaibing@huawei.com>
    amd-xgbe: use dma_mapping_error to check map errors

YueHaibing <yuehaibing@huawei.com>
    xfrm: fix 'passing zero to ERR_PTR()' warning

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Fix multiple definitions in AU0828_DEVICE() macro

Jeff Crukley <jcrukley@gmail.com>
    ALSA: usb-audio: Add support for Encore mDSD USB DAC

Takashi Iwai <tiwai@suse.de>
    ALSA: msnd: Fix the default sample sizes

Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
    iommu/io-pgtable-arm: Fix pgtable allocation in selftest

Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
    iommu/io-pgtable-arm-v7s: Abort allocation when table address overflows the PTE

Miao Zhong <zhongmiao@hisilicon.com>
    iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer register

Erich E. Hoover <ehoover@sweptlaser.com>
    usb: dwc3: change stream event enable bit back to 13

Tariq Toukan <tariqt@mellanox.com>
    net/mlx5: Use u16 for Work Queue buffer fragment size

Roi Dayan <roid@mellanox.com>
    net/mlx5: Fix possible deadlock from lockdep when adding fte to fg

Roi Dayan <roid@mellanox.com>
    net/mlx5: Fix not releasing read lock when adding flow rules

Vincent Whitchurch <vincent.whitchurch@axis.com>
    tcp: really ignore MSG_ZEROCOPY if no SO_ZEROCOPY

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    erspan: return PACKET_REJECT when the appropriate tunnel is not found

Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
    erspan: fix error handling for erspan tunnel

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx5: Fix debugfs cleanup in the device init/remove flow

Huy Nguyen <huyn@mellanox.com>
    net/mlx5: Check for error in mlx5_attach_interface

Vakul Garg <vakul.garg@nxp.com>
    net/tls: Set count of SG entries if sk_alloc_sg returns -ENOSPC

Raed Salem <raeds@mellanox.com>
    net/mlx5: E-Switch, Fix memory leak when creating switchdev mode FDB tables

Cong Wang <xiyou.wangcong@gmail.com>
    tipc: orphan sock in tipc_release()

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

 Makefile                                           |  31 ++++--
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |   2 +
 arch/arm/mach-exynos/suspend.c                     |   1 +
 arch/arm/mach-hisi/hotplug.c                       |  41 +++++---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |   2 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |   2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |   2 +
 arch/arm64/kernel/perf_event.c                     |  50 +++++-----
 arch/arm64/kernel/ptrace.c                         |  19 ++--
 arch/mips/ath79/setup.c                            |   1 +
 arch/mips/include/asm/mach-ath79/ath79.h           |   1 +
 arch/mips/jz4740/Platform                          |   2 +-
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c   |   2 +-
 arch/powerpc/kvm/book3s_64_vio.c                   |   5 +-
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
 drivers/block/DAC960.c                             |   9 +-
 drivers/char/ipmi/ipmi_bt_sm.c                     |  92 ++++++++---------
 drivers/char/ipmi/ipmi_msghandler.c                |  53 +++++-----
 drivers/char/ipmi/ipmi_si_intf.c                   |  17 +---
 drivers/char/ipmi/ipmi_ssif.c                      |  30 ++----
 drivers/clk/clk-fixed-factor.c                     |   9 +-
 drivers/clk/clk.c                                  |   3 +
 drivers/clk/imx/clk-imx6sll.c                      |   1 +
 drivers/clk/imx/clk-imx6ul.c                       |   1 +
 drivers/clk/mvebu/armada-37xx-periph.c             |   3 -
 drivers/clk/tegra/clk-bpmp.c                       |  12 ++-
 drivers/crypto/ccp/psp-dev.c                       |  46 ++++++++-
 drivers/crypto/sahara.c                            |   4 +-
 drivers/devfreq/devfreq.c                          |   4 +-
 drivers/dma/mv_xor_v2.c                            |   2 +
 drivers/dma/pl330.c                                |   5 +-
 drivers/dma/sh/rcar-dmac.c                         |   5 +-
 drivers/firmware/efi/arm-init.c                    |   1 -
 drivers/firmware/efi/arm-runtime.c                 |   4 +-
 drivers/firmware/efi/esrt.c                        |   3 +-
 drivers/gpio/gpio-pxa.c                            |   2 +
 drivers/gpio/gpiolib.c                             |  14 ++-
 drivers/gpio/gpiolib.h                             |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |   9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   4 +
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |   9 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |   8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c   |   6 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          |   4 +
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |  13 +++
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |   2 +-
 drivers/gpu/ipu-v3/ipu-csi.c                       |  20 +++-
 drivers/hv/vmbus_drv.c                             |   3 +
 drivers/hwtracing/coresight/coresight-etm4x.c      |  31 +++---
 drivers/hwtracing/coresight/coresight-tpiu.c       |   7 +-
 drivers/hwtracing/coresight/coresight.c            |   7 +-
 drivers/i2c/busses/i2c-aspeed.c                    |   4 +-
 drivers/infiniband/core/cma.c                      |  12 ++-
 drivers/infiniband/hw/mlx5/cong.c                  |   9 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  32 ++----
 drivers/infiniband/hw/nes/nes.h                    |   2 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               |   9 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   2 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   3 +-
 drivers/input/joystick/pxrc.c                      |  66 ++++++-------
 drivers/input/touchscreen/rohm_bu21023.c           |   4 +-
 drivers/iommu/arm-smmu-v3.c                        |   1 +
 drivers/iommu/io-pgtable-arm-v7s.c                 |   7 +-
 drivers/iommu/io-pgtable-arm.c                     |   3 +-
 drivers/iommu/ipmmu-vmsa.c                         |   8 ++
 drivers/lightnvm/pblk-init.c                       |   5 +-
 drivers/lightnvm/pblk-recovery.c                   |   5 +-
 drivers/md/dm-verity-target.c                      |  24 ++++-
 drivers/media/common/videobuf2/videobuf2-core.c    |   5 +
 drivers/media/i2c/ov5645.c                         |  13 +--
 drivers/media/pci/tw686x/tw686x-video.c            |  11 ++-
 drivers/mfd/88pm860x-i2c.c                         |   8 +-
 drivers/misc/hmc6352.c                             |   2 +
 drivers/misc/ibmvmc.c                              |   2 +-
 drivers/misc/mei/bus-fixup.c                       |   2 +-
 drivers/misc/mei/bus.c                             |  12 +--
 drivers/misc/mei/hbm.c                             |   9 +-
 drivers/mmc/host/meson-mx-sdio.c                   |   8 +-
 drivers/mmc/host/omap_hsmmc.c                      |   1 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |   6 ++
 drivers/mmc/host/sdhci-tegra.c                     |   3 +-
 drivers/mmc/host/sdhci.c                           |   9 +-
 drivers/mtd/maps/solutionengine.c                  |   6 +-
 drivers/mtd/mtdchar.c                              |  10 +-
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c          |   7 +-
 .../ethernet/cavium/liquidio/cn23xx_pf_device.c    |   3 +
 .../ethernet/cavium/liquidio/cn23xx_vf_device.c    |   3 +
 drivers/net/ethernet/cortina/gemini.c              |   5 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   8 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   5 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   6 ++
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |  15 ++-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  76 +++++++-------
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  12 ++-
 drivers/net/ethernet/mellanox/mlx5/core/wq.c       |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/wq.h       |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.c      |  20 ++--
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |  13 ++-
 drivers/net/ethernet/qualcomm/qca_7k.c             |  76 +++++++-------
 drivers/net/ethernet/qualcomm/qca_spi.c            | 110 +++++++++++----------
 drivers/net/ethernet/qualcomm/qca_spi.h            |   5 -
 drivers/net/wan/fsl_ucc_hdlc.c                     |   6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  12 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  11 ++-
 drivers/net/xen-netfront.c                         |  30 +++---
 drivers/nvme/host/rdma.c                           |   2 +
 drivers/nvme/target/io-cmd-file.c                  |  18 ++--
 drivers/of/base.c                                  |  28 ++++++
 drivers/parport/parport_sunbpp.c                   |   8 +-
 drivers/pci/pcie/aer.c                             |   6 ++
 drivers/pinctrl/mediatek/pinctrl-mt7622.c          |   4 +-
 drivers/pinctrl/pinctrl-rza1.c                     |  24 ++---
 drivers/pinctrl/pinmux.c                           |  16 ++-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  14 ++-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  32 ++++--
 drivers/platform/x86/toshiba_acpi.c                |   3 +-
 drivers/regulator/qcom_spmi-regulator.c            |  34 ++++---
 drivers/remoteproc/qcom_q6v5_pil.c                 |   1 -
 drivers/reset/reset-imx7.c                         |   2 +-
 drivers/rtc/rtc-bq4802.c                           |   4 +
 drivers/s390/net/qeth_core_main.c                  |   3 +-
 drivers/s390/net/qeth_core_sys.c                   |   1 +
 drivers/scsi/libfc/fc_disc.c                       |   7 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |   5 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                     |  12 ++-
 drivers/soc/qcom/smem.c                            |  10 +-
 drivers/spi/spi-dw.c                               |   3 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |   2 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |  16 +--
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |   7 +-
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |  11 ++-
 drivers/tty/serial/8250/8250_of.c                  |   2 +-
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
 drivers/usb/host/xhci-mem.c                        |   4 +
 drivers/usb/host/xhci.c                            |  30 ++++++
 drivers/usb/misc/uss720.c                          |   4 +-
 drivers/usb/misc/yurex.c                           |   5 +-
 drivers/usb/mtu3/mtu3_core.c                       |   6 +-
 drivers/usb/mtu3/mtu3_hw_regs.h                    |   1 +
 drivers/usb/serial/io_ti.h                         |   2 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |   2 +-
 drivers/usb/storage/scsiglue.c                     |   9 ++
 drivers/usb/storage/uas.c                          |  21 ++++
 drivers/usb/storage/unusual_devs.h                 |   7 ++
 drivers/video/fbdev/core/modedb.c                  |  41 +++++---
 drivers/video/fbdev/goldfishfb.c                   |   1 +
 drivers/video/fbdev/omap/omapfb_main.c             |   2 +-
 drivers/video/fbdev/omap2/omapfb/Makefile          |   4 +-
 drivers/video/fbdev/pxafb.c                        |   4 +-
 drivers/video/fbdev/via/viafbdev.c                 |   3 +-
 fs/binfmt_elf.c                                    |   2 +-
 fs/cifs/readdir.c                                  |  11 ++-
 fs/cifs/smb2pdu.c                                  |  29 +++---
 fs/configfs/dir.c                                  |  11 +++
 fs/f2fs/super.c                                    |  16 ++-
 fs/gfs2/bmap.c                                     |   2 +-
 fs/gfs2/rgrp.c                                     |   3 +-
 fs/namespace.c                                     |   7 +-
 fs/nfs/nfs4proc.c                                  |  10 +-
 fs/nfs/nfs4state.c                                 |   2 +
 fs/nfs/nfs4trace.h                                 |   2 +-
 fs/overlayfs/super.c                               |  26 ++---
 fs/pstore/ram_core.c                               |  17 +++-
 include/linux/crypto.h                             |   5 +
 include/linux/mlx5/driver.h                        |   4 +-
 include/linux/of.h                                 |   8 ++
 kernel/audit_watch.c                               |  12 ++-
 kernel/bpf/cgroup.c                                |   7 +-
 kernel/events/core.c                               |   4 +
 kernel/rcu/rcutorture.c                            |   5 +-
 kernel/rcu/tree.c                                  |   6 ++
 kernel/rcu/tree.h                                  |   4 +
 kernel/sched/fair.c                                |  10 +-
 kernel/sched/wait.c                                |  47 ++++-----
 net/bluetooth/af_bluetooth.c                       |   2 +-
 net/core/skbuff.c                                  |   3 -
 net/ipv4/ip_gre.c                                  |   5 +
 net/ipv4/tcp.c                                     |   2 +-
 net/mac80211/cfg.c                                 |   2 +-
 net/mac80211/key.c                                 |  24 +++--
 net/rds/bind.c                                     |   5 +-
 net/tipc/socket.c                                  |   1 +
 net/tls/tls_sw.c                                   |  14 ++-
 net/xfrm/xfrm_policy.c                             |   5 +-
 scripts/Kbuild.include                             |   3 +
 security/integrity/evm/evm_crypto.c                |   3 +-
 security/security.c                                |   2 +
 security/smack/smack_lsm.c                         |  14 ++-
 sound/core/pcm_lib.c                               |  14 ++-
 sound/isa/msnd/msnd_pinnacle.c                     |   4 +-
 sound/soc/codecs/hdmi-codec.c                      |  21 ++--
 sound/soc/codecs/rt5514.c                          |   8 +-
 sound/soc/codecs/rt5651.c                          |  22 +++--
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |   2 +-
 sound/usb/quirks-table.h                           |   3 +-
 sound/usb/quirks.c                                 |   2 +
 tools/hv/hv_kvp_daemon.c                           |   2 +-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |  10 +-
 tools/perf/tests/builtin-test.c                    |   2 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |  36 ++++++-
 tools/perf/util/comm.c                             |  16 ++-
 tools/perf/util/header.c                           |   2 +-
 tools/perf/util/machine.c                          |   9 +-
 tools/perf/util/map.c                              |  11 +++
 tools/perf/util/unwind-libdw.c                     |   2 +-
 tools/perf/util/unwind-libunwind-local.c           |   2 +-
 tools/testing/nvdimm/test/nfit.c                   |   3 +-
 .../testing/selftests/android/ion/ionapp_export.c  |   1 +
 tools/testing/selftests/timers/raw_skew.c          |   5 +
 tools/testing/selftests/vDSO/vdso_test.c           |   7 +-
 virt/kvm/arm/vgic/vgic-init.c                      |   4 +
 virt/kvm/arm/vgic/vgic-mmio-v2.c                   |   3 +
 238 files changed, 1599 insertions(+), 926 deletions(-)


