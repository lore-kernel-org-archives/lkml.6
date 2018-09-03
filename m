Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA777C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6492077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6492077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeICVzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:55:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47704 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeICVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:55:01 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0AA23D16;
        Mon,  3 Sep 2018 17:33:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.18 000/123] 4.18.6-stable review
Date:   Mon,  3 Sep 2018 18:55:44 +0200
Message-Id: <20180903165719.499675257@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.6-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.18.6-rc1
X-KernelTest-Deadline: 2018-09-05T16:57+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.18.6 release.
There are 123 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Sep  5 16:56:53 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.6-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.18.6-rc1

Arnd Bergmann <arnd@arndb.de>
    x86: kvm: avoid unused variable warning

Jann Horn <jannh@google.com>
    x86/dumpstack: Don't dump kernel memory based on usermode RIP

Scott Bauer <scott.bauer@intel.com>
    cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status

Vincent Whitchurch <vincent.whitchurch@axis.com>
    watchdog: Mark watchdog touch functions as notrace

H. Nikolaus Schaller <hns@goldelico.com>
    power: generic-adc-battery: check for duplicate properties copied from iio channels

H. Nikolaus Schaller <hns@goldelico.com>
    power: generic-adc-battery: fix out-of-bounds write when copying channel properties

Dan Carpenter <dan.carpenter@oracle.com>
    PM / clk: signedness bug in of_pm_clk_add_clks()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    clk: npcm7xx: fix memory allocation

Alberto Panizzo <alberto@amarulasolutions.com>
    clk: rockchip: fix clk_i2sout parent selection bits on rk3399

Abhishek Sahu <absahu@codeaurora.org>
    mtd: rawnand: qcom: wait for desc completion in all BAM channels

Daniel Mack <daniel@zonque.org>
    mtd: rawnand: marvell: add suspend and resume hooks

Boris Brezillon <boris.brezillon@bootlin.com>
    mtd: rawnand: fsmc: Stop using chip->read_buf()

Boris Brezillon <boris.brezillon@bootlin.com>
    mtd: rawnand: hynix: Use ->exec_op() in hynix_nand_reg_write_op()

Mike Christie <mchristi@redhat.com>
    iscsi target: fix session creation failure handling

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: core: Avoid that SCSI device removal through sysfs triggers a deadlock

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: sysfs: Introduce sysfs_{un,}break_active_protection()

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: mpt3sas: Fix _transport_smp_handler() error path

Sreekanth Reddy <sreekanth.reddy@broadcom.com>
    scsi: mpt3sas: Fix calltrace observed while running IO & reset

Tomas Winkler <tomas.winkler@intel.com>
    tpm: separate cmd_ready/go_idle from runtime_pm

Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
    tpm: Return the actual size when receiving an unsupported command

Paul Burton <paul.burton@mips.com>
    MIPS: lib: Provide MIPS64r6 __multi3() for GCC < 7

Huacai Chen <chenhc@lemote.com>
    MIPS: Change definition of cpu_relax() for Loongson-3

Paul Burton <paul.burton@mips.com>
    MIPS: Always use -march=<arch>, not -<arch> shortcuts

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: memset.S: Fix byte_fixup for MIPSr6

Maciej W. Rozycki <macro@mips.com>
    MIPS: Correct the 64-bit DSP accumulator register size

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Make list and blacklist root user read only

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/arm: Fix %p uses in error messages

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Replace %p with other pointer types

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Show blacklist addresses as same as kallsyms does

Philipp Rudo <prudo@linux.ibm.com>
    s390/purgatory: Add missing FORCE to Makefile targets

Philipp Rudo <prudo@linux.ibm.com>
    s390/purgatory: Fix crash with expoline enabled

Sebastian Ott <sebott@linux.ibm.com>
    s390/pci: fix out of bounds access during irq setup

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/numa: move initial setup of node_to_cpumask_map

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qdio: reset old sbal_state flags

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: fix br_r1_trampoline for machines without exrl

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/lib: use expoline for all bcr instructions

Gerald Schaefer <gerald.schaefer@de.ibm.com>
    s390/mm: fix addressing exception after suspend/resume

Ben Hutchings <ben@decadent.org.uk>
    x86: Allow generating user-space headers without a compiler

Jann Horn <jannh@google.com>
    x86/entry/64: Wipe KASAN stack shadow before rewind_stack_do_exit()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    hwmon: (nct6775) Fix potential Spectre v1

Andi Kleen <ak@linux.intel.com>
    x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+

Andi Kleen <ak@linux.intel.com>
    x86/spectre: Add missing family 6 check to microcode check

Nick Desaulniers <ndesaulniers@google.com>
    x86/irqflags: Mark native_restore_fl extern inline

Andy Lutomirski <luto@kernel.org>
    x86/nmi: Fix NMI uaccess race against CR3 switching

Samuel Neves <sneves@dei.uc.pt>
    x86/vdso: Fix lsl operand order

Himanshu Madhani <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix stalled relogin

Dan Carpenter <dan.carpenter@oracle.com>
    pinctrl: freescale: off by one in imx1_pinconf_group_dbg_show()

Johan Hovold <johan@kernel.org>
    soc: qcom: rmtfs-mem: fix memleak in probe error paths

Ajit Pandey <ajit.pandey@cirrus.com>
    ASoC: wm_adsp: Correct DSP pointer for preloader control

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ASoC: sirf: Fix potential NULL pointer dereference

Takashi Iwai <tiwai@suse.de>
    ASoC: zte: Fix incorrect PCM format bit usages

Jerome Brunet <jbrunet@baylibre.com>
    ASoC: dpcm: don't merge format from invalid codec dai

Michael Buesch <m@bues.ch>
    b43/leds: Ensure NUL-termination of LED name string

Michael Buesch <m@bues.ch>
    b43legacy/leds: Ensure NUL-termination of LED name string

Mikulas Patocka <mpatocka@redhat.com>
    udl-kms: avoid division

Mikulas Patocka <mpatocka@redhat.com>
    udl-kms: fix crash due to uninitialized memory

Mikulas Patocka <mpatocka@redhat.com>
    udl-kms: handle allocation failure

Mikulas Patocka <mpatocka@redhat.com>
    udl-kms: change down_interruptible to down

Bart Van Assche <bart.vanassche@wdc.com>
    lib/vsprintf: Do not handle %pO[^F] as %px

Kirill Tkhai <ktkhai@virtuozzo.com>
    fuse: Add missed unlock_page() to fuse_readpages_fill()

Miklos Szeredi <mszeredi@redhat.com>
    fuse: Fix oops at process_init_reply()

Miklos Szeredi <mszeredi@redhat.com>
    fuse: umount should wait for all requests

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix unlocked access to processing queue

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix double request_end()

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix initial parallel dirops

Andrey Ryabinin <aryabinin@virtuozzo.com>
    fuse: Don't access pipe->buffers without pipe_lock()

Thomas Gleixner <tglx@xxxxxxxxxxxxx>
    KVM: x86: SVM: Call x86_spec_ctrl_set_guest/host() with interrupts disabled

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: ensure all MSRs can always be KVM_GET/SET_MSR'd

Rian Hunter <rian@alum.mit.edu>
    x86/process: Re-export start_thread()

Andy Lutomirski <luto@kernel.org>
    x86/vdso: Fix vDSO build if a retpoline is emitted

Vlastimil Babka <vbabka@suse.cz>
    x86/speculation/l1tf: Suggest what to do on systems with too much RAM

Vlastimil Babka <vbabka@suse.cz>
    x86/speculation/l1tf: Fix off-by-one error when warning that system has too much RAM

Vlastimil Babka <vbabka@suse.cz>
    x86/speculation/l1tf: Fix overflow in l1tf_pfn_limit() on 32bit

Peter Zijlstra <peterz@infradead.org>
    mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE

Takashi Iwai <tiwai@suse.de>
    platform/x86: ideapad-laptop: Apply no_hw_rfkill to Y20-15IKBM, too

Kees Cook <keescook@chromium.org>
    platform/x86: wmi: Do not mix pages and kmalloc

Paulo Zanoni <paulo.r.zanoni@intel.com>
    x86/gpu: reserve ICL's graphics stolen memory

Michal Wnukowski <wnukowski@google.com>
    nvme-pci: add a memory barrier to nvme_dbbuf_update_and_check_event

Wang Shilong <wshilong@ddn.com>
    ext4: fix race when setting the bitmap corrupted flag

Eric Sandeen <sandeen@redhat.com>
    ext4: reset error code in ext4_find_entry in fallback

Arnd Bergmann <arnd@arndb.de>
    ext4: sysfs: print ext4_super_block fields as little-endian

Wang Shilong <wshilong@ddn.com>
    ext4: use ext4_warning() for sb_getblk failure

Theodore Ts'o <tytso@mit.edu>
    ext4: check for NUL characters in extended attribute's name

Prasad Sodagudi <psodagud@codeaurora.org>
    stop_machine: Atomically queue and wake stopper threads

Peter Zijlstra <peterz@infradead.org>
    stop_machine: Reflow cpu_stop_queue_two_works()

Thomas Richter <tmricht@linux.ibm.com>
    perf kvm: Fix subcommands on s390

Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
    s390/kvm: fix deadlock when killed by oom

Punit Agrawal <punit.agrawal@arm.com>
    KVM: arm/arm64: Skip updating PTE entry if no change

Punit Agrawal <punit.agrawal@arm.com>
    KVM: arm/arm64: Skip updating PMD entry if no change

Christoffer Dall <christoffer.dall@arm.com>
    KVM: arm/arm64: Fix lost IRQs from emulated physcial timer when blocked

Christoffer Dall <christoffer.dall@arm.com>
    KVM: arm/arm64: Fix potential loss of ptimer interrupts

Huibin Hong <huibin.hong@rock-chips.com>
    arm64: dts: rockchip: corrected uart1 clock-names for rk3328

Greg Hackmann <ghackmann@android.com>
    arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: Handle mismatched cache type

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: Fix mismatched cache line size detection

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/arm64: Fix %p uses in error messages

Petr Mladek <pmladek@suse.com>
    printk/nmi: Prevent deadlock when accessing the main log buffer in NMI

Petr Mladek <pmladek@suse.com>
    printk: Create helper function to queue deferred console handling

Petr Mladek <pmladek@suse.com>
    printk: Split the code for storing a message into the log buffer

Vivek Gautam <vivek.gautam@codeaurora.org>
    iommu/arm-smmu: Error out only if not enough context interrupts

Charles Keepax <ckeepax@opensource.cirrus.com>
    regulator: arizona-ldo1: Use correct device to get enable GPIO

Daniel Borkmann <daniel@iogearbox.net>
    bpf, arm32: fix stack var offset in jit

Michael Larabel <michael@phoronix.com>
    hwmon: (k10temp) 27C Offset needed for Threadripper2

Filipe Manana <fdmanana@suse.com>
    Btrfs: send, fix incorrect file layout after hole punching beyond eof

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix send failure when root has deleted files still open

Josef Bacik <jbacik@fb.com>
    Btrfs: fix btrfs_write_inode vs delayed iput deadlock

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix mount failure after fsync due to hard link recreation

Josef Bacik <josef@toxicpanda.com>
    btrfs: don't leak ret from do_chunk_alloc

Ethan Lien <ethanlien@synology.com>
    btrfs: use correct compare function of dirty_metadata_bytes

Steve French <stfrench@microsoft.com>
    smb3: fill in statfs fsid and correct namelen

Steve French <stfrench@microsoft.com>
    smb3: don't request leases in symlink creation and query

Steve French <stfrench@microsoft.com>
    smb3: Do not send SMB3 SET_INFO if nothing changed

Steve French <stfrench@microsoft.com>
    smb3: enumerating snapshots was leaving part of the data off end

Nicholas Mc Guire <hofrat@osadl.org>
    cifs: check kmalloc before use

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: use a refcount to protect open/closing the cached file handle

Steve French <stfrench@microsoft.com>
    cifs: add missing debug entries for kconfig options

Aurelien Aptel <aaptel@suse.com>
    CIFS: fix uninitialized ptr deref in smb2 signing

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: add missing support for ACLs in SMB 3.11

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: don't update offset in write

Chuck Lever <chuck.lever@oracle.com>
    xprtrdma: Fix disconnect regression

Jason Yan <yanaijie@huawei.com>
    scsi: libsas: dynamically allocate and free ata host

Ben Hutchings <ben@decadent.org.uk>
    scripts/kernel-doc: Escape all literal braces in regexes

Valdis Kletnieks <valdis.kletnieks@vt.edu>
    PATCH scripts/kernel-doc


-------------

Diffstat:

 Makefile                                       |   8 +-
 arch/Kconfig                                   |   3 +
 arch/arm/net/bpf_jit_32.c                      |   2 +-
 arch/arm/probes/kprobes/core.c                 |   4 +-
 arch/arm/probes/kprobes/test-core.c            |   1 -
 arch/arm64/boot/dts/rockchip/rk3328.dtsi       |   2 +-
 arch/arm64/include/asm/cache.h                 |   4 +
 arch/arm64/include/asm/cpucaps.h               |   3 +-
 arch/arm64/kernel/cpu_errata.c                 |  23 +++-
 arch/arm64/kernel/cpufeature.c                 |   2 +-
 arch/arm64/kernel/probes/kprobes.c             |   2 +-
 arch/arm64/mm/init.c                           |   6 +-
 arch/mips/Makefile                             |  12 +-
 arch/mips/include/asm/processor.h              |  15 ++-
 arch/mips/kernel/ptrace.c                      |   2 +-
 arch/mips/kernel/ptrace32.c                    |   2 +-
 arch/mips/lib/memset.S                         |   3 +-
 arch/mips/lib/multi3.c                         |   6 +-
 arch/s390/include/asm/qdio.h                   |   1 -
 arch/s390/lib/mem.S                            |  16 ++-
 arch/s390/mm/fault.c                           |   2 +
 arch/s390/mm/page-states.c                     |   2 +-
 arch/s390/net/bpf_jit_comp.c                   |   2 -
 arch/s390/numa/numa.c                          |  16 +--
 arch/s390/pci/pci.c                            |   2 +
 arch/s390/purgatory/Makefile                   |   7 +-
 arch/x86/Kconfig                               |   1 +
 arch/x86/Makefile                              |  11 +-
 arch/x86/entry/vdso/Makefile                   |   6 +-
 arch/x86/events/core.c                         |   2 +-
 arch/x86/include/asm/irqflags.h                |   3 +-
 arch/x86/include/asm/processor.h               |   6 +-
 arch/x86/include/asm/stacktrace.h              |   2 +-
 arch/x86/include/asm/tlbflush.h                |  40 +++++++
 arch/x86/include/asm/vgtod.h                   |   2 +-
 arch/x86/kernel/cpu/bugs.c                     |  50 ++++++++-
 arch/x86/kernel/cpu/common.c                   |   1 +
 arch/x86/kernel/cpu/intel.c                    |   3 +
 arch/x86/kernel/dumpstack.c                    |  25 ++++-
 arch/x86/kernel/early-quirks.c                 |  18 +++
 arch/x86/kernel/process_64.c                   |   1 +
 arch/x86/kvm/hyperv.c                          |  27 +++--
 arch/x86/kvm/hyperv.h                          |   2 +-
 arch/x86/kvm/svm.c                             |   8 +-
 arch/x86/kvm/x86.c                             |  19 ++--
 arch/x86/lib/usercopy.c                        |   5 +
 arch/x86/mm/fault.c                            |   2 +-
 arch/x86/mm/init.c                             |   4 +-
 arch/x86/mm/mmap.c                             |   2 +-
 arch/x86/mm/tlb.c                              |   7 ++
 drivers/ata/libata-core.c                      |   3 +
 drivers/ata/libata.h                           |   2 -
 drivers/base/power/clock_ops.c                 |   2 +-
 drivers/cdrom/cdrom.c                          |   2 +-
 drivers/char/tpm/tpm-interface.c               |  53 +++++++--
 drivers/char/tpm/tpm.h                         |  12 +-
 drivers/char/tpm/tpm2-space.c                  |  16 ++-
 drivers/char/tpm/tpm_crb.c                     | 101 +++++------------
 drivers/clk/clk-npcm7xx.c                      |   4 +-
 drivers/clk/rockchip/clk-rk3399.c              |   2 +-
 drivers/gpu/drm/udl/udl_drv.h                  |   2 +-
 drivers/gpu/drm/udl/udl_fb.c                   |  17 +--
 drivers/gpu/drm/udl/udl_main.c                 |  35 +++---
 drivers/gpu/drm/udl/udl_transfer.c             |  39 +++----
 drivers/hwmon/k10temp.c                        |   2 +
 drivers/hwmon/nct6775.c                        |   2 +
 drivers/iommu/arm-smmu.c                       |  16 ++-
 drivers/misc/mei/main.c                        |   1 -
 drivers/mtd/nand/raw/fsmc_nand.c               |   2 +-
 drivers/mtd/nand/raw/marvell_nand.c            |  73 +++++++++++--
 drivers/mtd/nand/raw/nand_hynix.c              |  10 ++
 drivers/mtd/nand/raw/qcom_nandc.c              |  53 ++++++++-
 drivers/net/wireless/broadcom/b43/leds.c       |   2 +-
 drivers/net/wireless/broadcom/b43legacy/leds.c |   2 +-
 drivers/nvme/host/pci.c                        |   8 ++
 drivers/pinctrl/freescale/pinctrl-imx1-core.c  |   2 +-
 drivers/platform/x86/ideapad-laptop.c          |   4 +-
 drivers/platform/x86/wmi.c                     |   9 +-
 drivers/power/supply/generic-adc-battery.c     |  25 +++--
 drivers/regulator/arizona-ldo1.c               |  27 ++++-
 drivers/s390/cio/qdio_main.c                   |   5 +-
 drivers/scsi/libsas/sas_ata.c                  |  40 ++++---
 drivers/scsi/libsas/sas_discover.c             |   2 +
 drivers/scsi/mpt3sas/mpt3sas_base.c            |   1 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c           |   2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c       |   5 +-
 drivers/scsi/qla2xxx/qla_init.c                |   2 +-
 drivers/scsi/qla2xxx/qla_iocb.c                |   1 +
 drivers/scsi/scsi_sysfs.c                      |  20 +++-
 drivers/soc/qcom/rmtfs_mem.c                   |   3 +-
 drivers/target/iscsi/iscsi_target_login.c      |  35 +++---
 fs/btrfs/disk-io.c                             |  10 +-
 fs/btrfs/extent-tree.c                         |   2 +-
 fs/btrfs/inode.c                               |  26 -----
 fs/btrfs/send.c                                | 146 +++++++++++++++++++++++--
 fs/btrfs/super.c                               |   1 -
 fs/btrfs/tree-log.c                            |  66 +++++++++++
 fs/cifs/cifs_debug.c                           |  30 +++--
 fs/cifs/cifsfs.c                               |  18 +--
 fs/cifs/cifsglob.h                             |   1 +
 fs/cifs/inode.c                                |   2 +
 fs/cifs/link.c                                 |   4 +-
 fs/cifs/sess.c                                 |   6 +
 fs/cifs/smb2inode.c                            |   6 +-
 fs/cifs/smb2ops.c                              |  72 ++++++++++--
 fs/cifs/smb2pdu.c                              |   8 ++
 fs/cifs/smb2pdu.h                              |  11 ++
 fs/cifs/smb2proto.h                            |   1 +
 fs/cifs/smb2transport.c                        |   5 +-
 fs/ext4/balloc.c                               |   6 +-
 fs/ext4/ialloc.c                               |   6 +-
 fs/ext4/namei.c                                |   1 +
 fs/ext4/super.c                                |  22 ++--
 fs/ext4/sysfs.c                                |  13 ++-
 fs/ext4/xattr.c                                |   2 +
 fs/fuse/dev.c                                  |  39 +++++--
 fs/fuse/dir.c                                  |  10 +-
 fs/fuse/file.c                                 |   1 +
 fs/fuse/fuse_i.h                               |   5 +-
 fs/fuse/inode.c                                |  37 ++++---
 fs/sysfs/file.c                                |  44 ++++++++
 include/drm/i915_drm.h                         |   4 +-
 include/linux/libata.h                         |   2 +
 include/linux/printk.h                         |   4 +
 include/linux/sysfs.h                          |  14 +++
 include/linux/tpm.h                            |   2 +
 include/scsi/libsas.h                          |   2 +-
 kernel/kprobes.c                               |  38 ++++---
 kernel/printk/internal.h                       |   9 +-
 kernel/printk/printk.c                         |  57 ++++++----
 kernel/printk/printk_safe.c                    |  58 ++++++----
 kernel/stop_machine.c                          |  43 +++++---
 kernel/trace/trace.c                           |   4 +-
 kernel/watchdog.c                              |   4 +-
 kernel/watchdog_hld.c                          |   2 +-
 kernel/workqueue.c                             |   2 +-
 lib/nmi_backtrace.c                            |   3 -
 lib/vsprintf.c                                 |   1 +
 mm/memory.c                                    |  18 +++
 net/sunrpc/xprtrdma/verbs.c                    |   5 +-
 scripts/kernel-doc                             |  20 ++--
 sound/soc/codecs/wm_adsp.c                     |   8 +-
 sound/soc/sirf/sirf-usp.c                      |   7 +-
 sound/soc/soc-pcm.c                            |   8 ++
 sound/soc/zte/zx-tdm.c                         |   4 +-
 tools/perf/arch/s390/util/kvm-stat.c           |   2 +-
 virt/kvm/arm/arch_timer.c                      |  15 ++-
 virt/kvm/arm/mmu.c                             |  42 +++++--
 148 files changed, 1438 insertions(+), 580 deletions(-)


