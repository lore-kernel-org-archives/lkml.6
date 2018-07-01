Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C884C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166AE257EA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166AE257EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030496AbeGAR6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:58:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030421AbeGAQav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:30:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 07B8292B;
        Sun,  1 Jul 2018 16:30:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/157] 4.14.53-stable review
Date:   Sun,  1 Jul 2018 18:21:12 +0200
Message-Id: <20180701160852.287307684@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.53-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.53-rc1
X-KernelTest-Deadline: 2018-07-03T16:09+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.53 release.
There are 157 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Jul  3 16:08:21 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.53-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.53-rc1

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix use-after-free in xhci_free_virt_device

Mike Snitzer <snitzer@redhat.com>
    dm thin: handle running out of data space vs concurrent discard

Bart Van Assche <bart.vanassche@wdc.com>
    dm zoned: avoid triggering reclaim from inside dmz_map()

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/efi: Fix efi_call_phys_epilog() with CONFIG_X86_5LEVEL=y

Bart Van Assche <bart.vanassche@wdc.com>
    block: Fix cloning of requests with a special payload

Keith Busch <keith.busch@intel.com>
    block: Fix transfer when chunk sectors exceeds max

Mikulas Patocka <mpatocka@redhat.com>
    slub: fix failure when we delete and create a slab cache

Hui Wang <hui.wang@canonical.com>
    ALSA: hda/realtek - Fix the problem of two front mics on more machines

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Add a quirk for FSC ESPRIMO U9210

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Fix pop noise on Lenovo P50 & co

Takashi Iwai <tiwai@suse.de>
    ALSA: timer: Fix UBSAN warning at SNDRV_TIMER_IOCTL_NEXT_DEVICE ioctl

??? <kt.liao@emc.com.tw>
    Input: elantech - fix V4 report decoding for module with middle key

Aaron Ma <aaron.ma@canonical.com>
    Input: elantech - enable middle button of touchpads on ThinkPad P52

Ben Hutchings <ben.hutchings@codethink.co.uk>
    Input: elan_i2c_smbus - fix more potential stack buffer overflows

Enno Boland <gottox@voidlinux.eu>
    Input: xpad - fix GPD Win 2 controller name

Jan Kara <jack@suse.cz>
    udf: Detect incorrect directory size

Boris Ostrovsky <boris.ostrovsky@oracle.com>
    xen: Remove unnecessary BUG_ON from __unbind_from_irq()

Dan Williams <dan.j.williams@intel.com>
    mm: fix devmem_is_allowed() for sub-page System RAM intersections

Jia He <jia.he@hxt-semitech.com>
    mm/ksm.c: ignore STABLE_FLAG of rmap_item->address in rmap_walk_ksm()

Dongsheng Yang <dongsheng.yang@easystack.cn>
    rbd: flush rbd_dev->watch_dwork after watch is unregistered

Hans de Goede <hdegoede@redhat.com>
    pwm: lpss: platform: Save/restore the ctrl register over a suspend/resume

Alexandr Savca <alexandr.savca@saltedge.com>
    Input: elan_i2c - add ELAN0618 (Lenovo v330 15IKB) ACPI ID

Hans de Goede <hdegoede@redhat.com>
    ACPI / LPSS: Add missing prv_offset setting for byt/cht PWM devices

Kees Cook <keescook@chromium.org>
    video: uvesafb: Fix integer overflow in allocation

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Fix a typo in nfs41_sequence_process

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Revert commit 5f83d86cf531d ("NFSv4.x: Fix wraparound issues..")

Dave Wysochanski <dwysocha@redhat.com>
    NFSv4: Fix possible 1-byte stack overflow in nfs_idmap_read_and_verify_message

Scott Mayhew <smayhew@redhat.com>
    nfsd: restrict rd_maxcount to svc_max_payload in nfsd_encode_readdir

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: dvb_frontend: fix locking issues at dvb_frontend_get_event()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    media: cx231xx: Add support for AverMedia DVD EZMaker 7

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: v4l2-compat-ioctl32: prevent go past max size

Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
    media: vsp1: Release buffers for each video node

Kan Liang <kan.liang@intel.com>
    perf/x86/intel/uncore: Add event constraint for BDX PCU

Kan Liang <Kan.liang@intel.com>
    perf vendor events: Add Goldmont Plus V1 event file

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix packet decoding of CYC packets

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix "Unexpected indirect branch" error

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix MTC timing after overflow

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix decoding to accept CBR between FUP and corresponding TIP

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING

Adrian Hunter <adrian.hunter@intel.com>
    perf tools: Fix symbol and object code resolution for vdso32 and vdsox32

Sean Wang <sean.wang@mediatek.com>
    arm: dts: mt7623: fix invalid memory node being generated

Jarkko Nikula <jarkko.nikula@linux.intel.com>
    mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input clock

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    mfd: intel-lpss: Program REMAP register in PIO mode

Johan Hovold <johan@kernel.org>
    backlight: tps65217_bl: Fix Device Tree node lookup

Johan Hovold <johan@kernel.org>
    backlight: max8925_bl: Fix Device Tree node lookup

Johan Hovold <johan@kernel.org>
    backlight: as3711_bl: Fix Device Tree node lookup

Silvio Cesare <silvio.cesare@gmail.com>
    UBIFS: Fix potential integer overflow in allocation

Richard Weinberger <richard@nod.at>
    ubi: fastmap: Correctly handle interrupted erasures in EBA

Richard Weinberger <richard@nod.at>
    ubi: fastmap: Cancel work upon detach

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    rpmsg: smd: do not use mananged resources for endpoints and channels

NeilBrown <neilb@suse.com>
    md: fix two problems with setting the "re-add" device state.

Michael Trimarchi <michael@amarulasolutions.com>
    rtc: sun6i: Fix bit_idx value for clk_register_gate

Marcin Ziemianowicz <marcin@ziemianowicz.com>
    clk: at91: PLL recalc_rate() now using cached MUL and DIV values

Robert Elliott <elliott@hpe.com>
    linvdimm, pmem: Preserve read-only setting for pmem devices

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing REC trigger trace on enqueue without ERP thread

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing REC trigger trace for all objects in ERP_FAILED

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing REC trigger trace on terminate_rport_io for ERP_FAILED

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing REC trigger trace on terminate_rport_io early return

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix misleading REC trigger trace where erp_action setup failed

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing SCSI trace for retry of abort / scsi_eh TMF

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix missing SCSI trace for result of eh_host_reset_handler

Anil Gurumurthy <anil.gurumurthy@cavium.com>
    scsi: qla2xxx: Mask off Scope bits in retry delay

Himanshu Madhani <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix setting lower transfer speed if GPSC fails

Sinan Kaya <okaya@codeaurora.org>
    scsi: hpsa: disable device during shutdown

Dan Williams <dan.j.williams@intel.com>
    mm: fix __gup_device_huge vs unmap

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    iio: sca3000: Fix an error handling path in 'sca3000_probe()'

Alexandru Ardelean <alexandru.ardelean@analog.com>
    iio: adc: ad7791: remove sample freq sysfs attributes

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix return value on rename exchange failure

Maciej S. Szmigiero <mail@maciej.szmigiero.name>
    X.509: unpack RSA signatureValue field from BIT STRING

Yang Yingliang <yangyingliang@huawei.com>
    irqchip/gic-v3-its: Don't bind LPI to unavailable NUMA node

Geert Uytterhoeven <geert@linux-m68k.org>
    time: Make sure jiffies_to_msecs() preserves non-zero time periods

Huacai Chen <chenhc@lemote.com>
    MIPS: io: Add barrier after register read in inX()

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    cpufreq: intel_pstate: Fix scaling max/min limits with Turbo 3.0

Fabio Estevam <fabio.estevam@nxp.com>
    pinctrl: devicetree: Fix pctldev pointer overwrite

Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
    pinctrl: samsung: Correct EINTG banks order

Randy Dunlap <rdunlap@infradead.org>
    auxdisplay: fix broken menu

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed on resume

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI: Add ACS quirk for Intel 300 series

Alex Williamson <alex.williamson@redhat.com>
    PCI: Add ACS quirk for Intel 7th & 8th Gen mobile

Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
    PCI: hv: Make sure the bus domain is really unique

Tokunori Ikegami <ikegami@allied-telesis.co.jp>
    MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum

Joakim Tjernlund <joakim.tjernlund@infinera.com>
    mtd: cfi_cmdset_0002: Avoid walking all chips when unlocking.

Joakim Tjernlund <joakim.tjernlund@infinera.com>
    mtd: cfi_cmdset_0002: Fix unlocking requests crossing a chip boudary

Joakim Tjernlund <joakim.tjernlund@infinera.com>
    mtd: cfi_cmdset_0002: fix SEGV unlocking multiple chips

Joakim Tjernlund <joakim.tjernlund@infinera.com>
    mtd: cfi_cmdset_0002: Use right chip in do_ppb_xxlock()

Tokunori Ikegami <ikegami@allied-telesis.co.jp>
    mtd: cfi_cmdset_0002: Change write buffer to check correct value

Chuck Lever <chuck.lever@oracle.com>
    xprtrdma: Return -ENOBUFS when no pages are available

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx4: Discard unknown SQP work requests

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/hfi1: Fix user context tail allocation for DMA_RTAIL

Sebastian Sanchez <sebastian.sanchez@intel.com>
    IB/hfi1: Optimize kthread pointer locking when queuing CQ entries

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Reorder incorrect send context disable

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/hfi1: Fix fault injection init/exit issues

Max Gurtovoy <maxg@mellanox.com>
    IB/isert: fix T10-pi check mask setting

Alex Estrin <alex.estrin@intel.com>
    IB/isert: Fix for lib/dma_debug check_sync warning

Erez Shitrit <erezsh@mellanox.com>
    IB/mlx5: Fetch soft WQE's on fatal error state

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/core: Make testing MR flags for writability a static inline function

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Mark user MR as writable if actual virtual memory is writable

Alex Estrin <alex.estrin@intel.com>
    IB/{hfi1, qib}: Add handling of kernel restart

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/qib: Fix DMA api warning with debug kernel

Tadeusz Struk <tadeusz.struk@intel.com>
    tpm: fix race condition in tpm_common_write()

Tadeusz Struk <tadeusz.struk@intel.com>
    tpm: fix use after free in tpm2_load_context()

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    of: platform: stop accessing invalid dev in of_platform_device_destroy

Stefan M Schaeckeler <sschaeck@cisco.com>
    of: unittest: for strings, account for trailing \0 in property length field

Frank Rowand <frank.rowand@sony.com>
    of: overlay: validate offset from property fixups

Jerome Brunet <jbrunet@baylibre.com>
    ARM64: dts: meson: disable sd-uhs modes on the libretech-cc

Will Deacon <will.deacon@arm.com>
    arm64: mm: Ensure writes to swapper are ordered wrt subsequent cache maintenance

Will Deacon <will.deacon@arm.com>
    arm64: kpti: Use early_param for kpti= command-line option

Dave Martin <Dave.Martin@arm.com>
    arm64: Fix syscall restarting around signal suppressed by tracer

Dinh Nguyen <dinguyen@kernel.org>
    ARM: dts: socfpga: Fix NAND controller node compatible for Arria10

Marek Vasut <marex@denx.de>
    ARM: dts: socfpga: Fix NAND controller clock supply

Marek Vasut <marex@denx.de>
    ARM: dts: socfpga: Fix NAND controller node compatible

Thor Thayer <thor.thayer@linux.intel.com>
    ARM: dts: Fix SPI node for Arria10

David Rivshin <DRivshin@allworx.com>
    ARM: 8764/1: kgdb: fix NUMREGBYTES so that gdb_regs[] is the correct size

Vaibhav Jain <vaibhav@linux.ibm.com>
    cxl: Disable prefault_mode in Radix mode

Finley Xiao <finley.xiao@rock-chips.com>
    soc: rockchip: power-domain: Fix wrong value when power up pd with writemask

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/fadump: Unregister fadump on kexec down path.

Gautham R. Shenoy <ego@linux.vnet.ibm.com>
    cpuidle: powernv: Fix promotion from snooze if next state disabled

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
    powerpc/powernv/cpuidle: Init all present cpus for deep states

Haren Myneni <haren@us.ibm.com>
    powerpc/powernv: copy/paste - Mask SO bit in CR

Alexey Kardashevskiy <aik@ozlabs.ru>
    powerpc/powernv/ioda2: Remove redundant free of TCE pages

Michael Neuling <mikey@neuling.org>
    powerpc/ptrace: Fix enforcement of DAWR constraints

Anju T Sudhakar <anju@linux.vnet.ibm.com>
    powerpc/perf: Fix memory allocation for core-imc based on num_possible_cpus()

Michael Neuling <mikey@neuling.org>
    powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_DEBUGREG

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/mm/hash: Add missing isync prior to kernel stack SLB switch

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix control dir setup and teardown

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fuse: don't keep dead fuse_conn at fuse_fill_super().

Miklos Szeredi <mszeredi@redhat.com>
    fuse: atomic_o_trunc should truncate pagecache

Tejun Heo <tj@kernel.org>
    fuse: fix congested state leak on aborted connections

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    printk: fix possible reuse of va_list variable

Amit Pundir <amit.pundir@linaro.org>
    Bluetooth: hci_qca: Avoid missing rampatch failure with userspace fw loader

Corey Minyard <cminyard@mvista.com>
    ipmi:bt: Set the timeout before doing a capabilities check

Mikulas Patocka <mpatocka@redhat.com>
    branch-check: fix long->int truncation when profiling branches

Matthias Schiffer <mschiffer@universe-factory.net>
    mips: ftrace: fix static function graph tracing

Steven Rostedt (VMware) <rostedt@goodmis.org>
    ftrace/selftest: Have the reset_trigger code be a bit more careful

Geert Uytterhoeven <geert+renesas@glider.be>
    lib/vsprintf: Remove atomic-unsafe support for %pCr

Geert Uytterhoeven <geert+renesas@glider.be>
    clk: renesas: cpg-mssr: Stop using printk format %pCr

Geert Uytterhoeven <geert+renesas@glider.be>
    thermal: bcm2835: Stop using printk format %pCr

Alexander Sverdlin <alexander.sverdlin@gmail.com>
    ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup

Alexander Sverdlin <alexander.sverdlin@gmail.com>
    ASoC: cirrus: i2s: Fix LRCLK configuration

Paul Handrigan <Paul.Handrigan@cirrus.com>
    ASoC: cs35l35: Add use_single_rw to regmap config

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: dapm: delete dapm_kcontrol_data paths list before freeing it

Ingo Flaschberger <ingo.flaschberger@gmail.com>
    1wire: family module autoload fails because of upper/lower case mismatch.

Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
    usb: do not reset if a low-speed or full-speed device timed out

Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
    PM / OPP: Update voltage in case freq == old_freq

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM / core: Fix supplier device runtime PM usage counter imbalance

Ulf Hansson <ulf.hansson@linaro.org>
    PM / Domains: Fix error path during attach in genpd

Eric W. Biederman <ebiederm@xmission.com>
    signal/xtensa: Consistenly use SIGBUS in do_unaligned_user

Daniel Wagner <daniel.wagner@siemens.com>
    serial: sh-sci: Use spin_{try}lock_irqsave instead of open coding version

Finn Thain <fthain@telegraphics.com.au>
    m68k/mac: Fix SWIM memory resource end address

Michael Schmitz <schmitzmic@gmail.com>
    m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()

Siarhei Liakh <Siarhei.Liakh@concurrent-rt.com>
    x86: Call fixup_exception() before notify_die() in math_error()

Borislav Petkov <bp@suse.de>
    x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()

Tony Luck <tony.luck@intel.com>
    x86/mce: Fix incorrect "Machine check from unknown source" message

Tony Luck <tony.luck@intel.com>
    x86/mce: Check for alternate indication of machine check recovery on Skylake

Tony Luck <tony.luck@intel.com>
    x86/mce: Improve error message when kernel cannot recover

Juergen Gross <jgross@suse.com>
    x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths

Dan Williams <dan.j.williams@intel.com>
    x86/spectre_v1: Disable compiler optimizations over array_index_mask_nospec()


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-class-cxl          |    4 +-
 Documentation/printk-formats.txt                   |    3 +-
 Makefile                                           |    4 +-
 arch/arm/boot/dts/mt7623.dtsi                      |    3 +-
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      |    1 +
 arch/arm/boot/dts/mt7623n-rfb.dtsi                 |    1 +
 arch/arm/boot/dts/socfpga.dtsi                     |    4 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |    5 +-
 arch/arm/include/asm/kgdb.h                        |    2 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |    3 -
 arch/arm64/kernel/cpufeature.c                     |    2 +-
 arch/arm64/kernel/signal.c                         |    5 +-
 arch/arm64/mm/proc.S                               |    5 +-
 arch/m68k/mac/config.c                             |    2 +-
 arch/m68k/mm/kmap.c                                |    3 +-
 arch/mips/bcm47xx/setup.c                          |    6 +
 arch/mips/include/asm/io.h                         |    2 +
 arch/mips/include/asm/mipsregs.h                   |    3 +
 arch/mips/kernel/mcount.S                          |   27 +-
 arch/powerpc/kernel/entry_64.S                     |    1 +
 arch/powerpc/kernel/fadump.c                       |    3 +
 arch/powerpc/kernel/hw_breakpoint.c                |    4 +-
 arch/powerpc/kernel/ptrace.c                       |    1 +
 arch/powerpc/perf/imc-pmu.c                        |    4 +-
 arch/powerpc/platforms/powernv/copy-paste.h        |    3 +-
 arch/powerpc/platforms/powernv/idle.c              |    4 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |    1 -
 arch/x86/events/intel/uncore_snbep.c               |    8 +
 arch/x86/include/asm/barrier.h                     |    2 +-
 arch/x86/kernel/cpu/mcheck/mce-severity.c          |    5 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |   44 +-
 arch/x86/kernel/quirks.c                           |   11 +-
 arch/x86/kernel/traps.c                            |   14 +-
 arch/x86/mm/init.c                                 |    4 +-
 arch/x86/platform/efi/efi_64.c                     |    4 +-
 arch/x86/xen/smp_pv.c                              |    5 +
 arch/xtensa/kernel/traps.c                         |    2 +-
 block/blk-core.c                                   |    4 +
 crypto/asymmetric_keys/x509_cert_parser.c          |    9 +
 drivers/acpi/acpi_lpss.c                           |    2 +
 drivers/auxdisplay/Kconfig                         |   10 +-
 drivers/base/core.c                                |   15 +-
 drivers/base/power/domain.c                        |    3 +
 drivers/base/power/opp/core.c                      |    2 +-
 drivers/block/rbd.c                                |    2 +-
 drivers/bluetooth/hci_qca.c                        |    6 +
 drivers/char/ipmi/ipmi_bt_sm.c                     |    3 +-
 drivers/char/tpm/tpm-dev-common.c                  |   40 +-
 drivers/char/tpm/tpm-dev.h                         |    2 +-
 drivers/char/tpm/tpm2-space.c                      |    3 +-
 drivers/clk/at91/clk-pll.c                         |   13 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |    9 +-
 drivers/cpufreq/intel_pstate.c                     |   27 +-
 drivers/cpuidle/cpuidle-powernv.c                  |   32 +-
 drivers/iio/accel/sca3000.c                        |    9 +-
 drivers/iio/adc/ad7791.c                           |   49 -
 drivers/infiniband/core/umem.c                     |   11 +-
 drivers/infiniband/hw/hfi1/chip.c                  |    8 +-
 drivers/infiniband/hw/hfi1/debugfs.c               |    8 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |    4 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |    1 +
 drivers/infiniband/hw/hfi1/init.c                  |   22 +-
 drivers/infiniband/hw/hfi1/pio.c                   |   44 +-
 drivers/infiniband/hw/mlx4/mad.c                   |    1 -
 drivers/infiniband/hw/mlx4/mr.c                    |   50 +-
 drivers/infiniband/hw/mlx5/cq.c                    |   15 +-
 drivers/infiniband/hw/qib/qib.h                    |    4 +-
 drivers/infiniband/hw/qib/qib_file_ops.c           |   10 +-
 drivers/infiniband/hw/qib/qib_init.c               |   13 +
 drivers/infiniband/hw/qib/qib_user_pages.c         |   20 +-
 drivers/infiniband/sw/rdmavt/cq.c                  |   31 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |   28 +-
 drivers/input/joystick/xpad.c                      |    2 +-
 drivers/input/mouse/elan_i2c.h                     |    2 +
 drivers/input/mouse/elan_i2c_core.c                |    3 +-
 drivers/input/mouse/elan_i2c_smbus.c               |   10 +-
 drivers/input/mouse/elantech.c                     |   11 +-
 drivers/irqchip/irq-gic-v3-its.c                   |    9 +-
 drivers/md/dm-thin.c                               |   11 +-
 drivers/md/dm-zoned-target.c                       |    2 +-
 drivers/md/md.c                                    |    4 +-
 drivers/media/dvb-core/dvb_frontend.c              |   23 +-
 drivers/media/platform/vsp1/vsp1_video.c           |   21 +-
 drivers/media/usb/cx231xx/cx231xx-cards.c          |    3 +
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |    2 +-
 drivers/mfd/intel-lpss-pci.c                       |   25 +-
 drivers/mfd/intel-lpss.c                           |    4 +-
 drivers/misc/cxl/sysfs.c                           |   16 +-
 drivers/mtd/chips/cfi_cmdset_0002.c                |   21 +-
 drivers/mtd/ubi/build.c                            |    3 +
 drivers/mtd/ubi/eba.c                              |   90 +-
 drivers/mtd/ubi/wl.c                               |    4 +-
 drivers/nvdimm/bus.c                               |   14 +-
 drivers/of/platform.c                              |    5 +-
 drivers/of/resolver.c                              |    5 +
 drivers/of/unittest.c                              |    8 +-
 drivers/pci/host/pci-hyperv.c                      |   11 -
 drivers/pci/hotplug/pciehp.h                       |    2 +-
 drivers/pci/hotplug/pciehp_core.c                  |    2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |   13 +-
 drivers/pci/quirks.c                               |   20 +
 drivers/pinctrl/devicetree.c                       |    7 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c       |    4 +-
 drivers/pwm/pwm-lpss-platform.c                    |    5 +
 drivers/pwm/pwm-lpss.c                             |   30 +
 drivers/pwm/pwm-lpss.h                             |    2 +
 drivers/rpmsg/qcom_smd.c                           |   18 +-
 drivers/rtc/rtc-sun6i.c                            |    4 +-
 drivers/s390/scsi/zfcp_dbf.c                       |   40 +
 drivers/s390/scsi/zfcp_erp.c                       |  123 +-
 drivers/s390/scsi/zfcp_ext.h                       |    5 +
 drivers/s390/scsi/zfcp_scsi.c                      |   18 +-
 drivers/scsi/hpsa.c                                |   10 +-
 drivers/scsi/qla2xxx/qla_init.c                    |    3 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |    8 +-
 drivers/soc/rockchip/pm_domains.c                  |    2 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |    4 +-
 drivers/tty/serial/sh-sci.c                        |    8 +-
 drivers/usb/core/hub.c                             |    4 +-
 drivers/usb/host/xhci.c                            |    1 +
 drivers/video/backlight/as3711_bl.c                |   33 +-
 drivers/video/backlight/max8925_bl.c               |    4 +-
 drivers/video/backlight/tps65217_bl.c              |    4 +-
 drivers/video/fbdev/uvesafb.c                      |    3 +-
 drivers/w1/w1.c                                    |    2 +-
 drivers/xen/events/events_base.c                   |    2 -
 fs/btrfs/inode.c                                   |    4 +-
 fs/fuse/control.c                                  |   13 +-
 fs/fuse/dev.c                                      |    3 +-
 fs/fuse/dir.c                                      |   13 +-
 fs/fuse/inode.c                                    |    1 +
 fs/nfs/callback_proc.c                             |    7 +-
 fs/nfs/nfs4idmap.c                                 |    5 +-
 fs/nfs/nfs4proc.c                                  |    2 +-
 fs/nfsd/nfs4xdr.c                                  |    5 +-
 fs/ubifs/journal.c                                 |    5 +-
 fs/udf/directory.c                                 |    3 +
 include/linux/blkdev.h                             |    4 +-
 include/linux/compiler.h                           |    2 +-
 include/linux/slub_def.h                           |    4 +
 include/rdma/ib_verbs.h                            |   14 +
 include/rdma/rdma_vt.h                             |    2 +-
 kernel/printk/printk_safe.c                        |    5 +-
 kernel/time/time.c                                 |    6 +-
 lib/vsprintf.c                                     |    3 -
 mm/gup.c                                           |   36 +-
 mm/ksm.c                                           |   14 +-
 mm/slab_common.c                                   |    4 +
 mm/slub.c                                          |    7 +-
 net/sunrpc/xprtrdma/rpc_rdma.c                     |    2 +-
 sound/core/timer.c                                 |    2 +-
 sound/pci/hda/patch_realtek.c                      |   20 +-
 sound/soc/cirrus/edb93xx.c                         |    2 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |   26 +-
 sound/soc/cirrus/snappercl15.c                     |    2 +-
 sound/soc/codecs/cs35l35.c                         |    1 +
 sound/soc/soc-dapm.c                               |    2 +
 .../pmu-events/arch/x86/goldmontplus/cache.json    | 1453 ++++++++++++++++++++
 .../pmu-events/arch/x86/goldmontplus/frontend.json |   62 +
 .../pmu-events/arch/x86/goldmontplus/memory.json   |   38 +
 .../pmu-events/arch/x86/goldmontplus/other.json    |   98 ++
 .../pmu-events/arch/x86/goldmontplus/pipeline.json |  544 ++++++++
 .../arch/x86/goldmontplus/virtual-memory.json      |  218 +++
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    1 +
 tools/perf/util/dso.c                              |    2 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   23 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |    9 +
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |    2 +-
 tools/perf/util/intel-pt.c                         |    5 +
 tools/testing/selftests/ftrace/test.d/functions    |   21 +-
 170 files changed, 3595 insertions(+), 505 deletions(-)


