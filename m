Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5EB21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeKI4wwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5EB21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404477AbeKTDV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403835AbeKTDV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:21:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 832CE208E3;
        Mon, 19 Nov 2018 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646631;
        bh=X8FD2SAbHIG6+j+tc5cenoAIjldrEauFyLy4ISlIXic=;
        h=From:To:Cc:Subject:Date:From;
        b=aeKI4wwuIt+4dsyKGBZuDff+bn88vmx2qn+VtVRupf22erOBV1W3+uUQ9Rsb7U9KV
         5A9X1Jok/GC2zwTNnufRWWERxugL11y8Jroci3mysS4UtkAhWHJdDVa9qvOV/Waspo
         GhUoODbpM+S9sLjvt7wiqjd8CEO7jXtkEsvw77SA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/160] 4.4.164-stable review
Date:   Mon, 19 Nov 2018 17:27:19 +0100
Message-Id: <20181119162630.031306128@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.164-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.164-rc1
X-KernelTest-Deadline: 2018-11-21T16:26+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.164 release.
There are 160 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Nov 21 16:25:20 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.164-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.164-rc1

Clint Taylor <clinton.a.taylor@intel.com>
    drm/i915/hdmi: Add HDMI 2.0 audio clock recovery N values

Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
    drm/dp_mst: Check if primary mstb is null

Marc Zyngier <marc.zyngier@arm.com>
    drm/rockchip: Allow driver to be shutdown on reboot/kexec

Mike Kravetz <mike.kravetz@oracle.com>
    mm: migration: fix migration of huge PMD shared pages

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!

Guenter Roeck <linux@roeck-us.net>
    configfs: replace strncpy with memcpy

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix leaked notify reply

Maciej W. Rozycki <macro@linux-mips.org>
    rtc: hctosys: Add missing range error reporting

Frank Sorenson <sorenson@redhat.com>
    sunrpc: correct the computation for page_ptr when truncating

Eric W. Biederman <ebiederm@xmission.com>
    mount: Prevent MNT_DETACH from disconnecting locked mounts

Eric W. Biederman <ebiederm@xmission.com>
    mount: Don't allow copying MNT_UNBINDABLE|MNT_LOCKED mounts

Eric W. Biederman <ebiederm@xmission.com>
    mount: Retest MNT_LOCKED in do_umount

Vasily Averin <vvs@virtuozzo.com>
    ext4: fix buffer leak in __ext4_read_dirblock() on error path

Vasily Averin <vvs@virtuozzo.com>
    ext4: fix buffer leak in ext4_xattr_move_to_block() on error path

Vasily Averin <vvs@virtuozzo.com>
    ext4: release bs.bh before re-using in ext4_xattr_block_find()

Theodore Ts'o <tytso@mit.edu>
    ext4: fix possible leak of sbi->s_group_desc_leak in error path

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid possible double brelse() in add_new_gdb() on error path

Vasily Averin <vvs@virtuozzo.com>
    ext4: fix missing cleanup if ext4_alloc_flex_bg_array() fails while resizing

Vasily Averin <vvs@virtuozzo.com>
    ext4: avoid buffer leak in ext4_orphan_add() after prior errors

Vasily Averin <vvs@virtuozzo.com>
    ext4: fix possible inode leak in the retry loop of ext4_resize_fs()

Vasily Averin <vvs@virtuozzo.com>
    ext4: avoid potential extra brelse in setup_new_flex_group_blocks()

Vasily Averin <vvs@virtuozzo.com>
    ext4: add missing brelse() add_new_gdb_meta_bg()'s error path

Vasily Averin <vvs@virtuozzo.com>
    ext4: add missing brelse() in set_flexbg_block_bitmap()'s error path

Vasily Averin <vvs@virtuozzo.com>
    ext4: add missing brelse() update_backups()'s error path

Michael Kelley <mikelley@microsoft.com>
    clockevents/drivers/i8253: Add support for PIT shutdown quirk

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix data corruption due to cloning of eof block

H. Peter Anvin (Intel) <hpa@zytor.com>
    arch/alpha, termios: implement BOTHER, IBSHIFT and termios2

H. Peter Anvin <hpa@zytor.com>
    termios, tty/tty_baudrate.c: fix buffer overrun

Arnd Bergmann <arnd@arndb.de>
    mtd: docg3: don't set conflicting BCH_CONST_PARAMS option

Andrea Arcangeli <aarcange@redhat.com>
    mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings

Changwei Ge <ge.changwei@h3c.com>
    ocfs2: fix a misuse a of brelse after failing ocfs2_check_dir_entry

Greg Edwards <gedwards@ddn.com>
    vhost/scsi: truncate T10 PI iov_iter to prot_bytes

Mikulas Patocka <mpatocka@redhat.com>
    mach64: fix image corruption due to reading accelerator registers

Mikulas Patocka <mpatocka@redhat.com>
    mach64: fix display corruption on big endian machines

Ilya Dryomov <idryomov@gmail.com>
    libceph: bump CEPH_MSG_MAX_DATA_LEN

Krzysztof Kozlowski <krzk@kernel.org>
    clk: s2mps11: Fix matching when built as module and DT node contains compatible

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix boot parameters address translation

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: make sure bFLT stack is 16 byte aligned

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: add NOTES section to the linker script

Huacai Chen <chenhc@lemote.com>
    MIPS: Loongson-3: Fix BRIDGE irq delivery problem

Huacai Chen <chenhc@lemote.com>
    MIPS: Loongson-3: Fix CPU UART irq delivery problem

Kees Cook <keescook@chromium.org>
    bna: ethtool: Avoid reading past end of buffer

Vincenzo Maffione <v.maffione@gmail.com>
    e1000: fix race condition between e1000_down() and e1000_watchdog

Colin Ian King <colin.king@canonical.com>
    e1000: avoid null pointer dereference on invalid stat type

Michal Hocko <mhocko@suse.com>
    mm: do not bug_on on incorrect length in __mm_populate()

Oscar Salvador <osalvador@suse.de>
    fs, elf: make sure to page align bss in load_elf_library

Kees Cook <keescook@chromium.org>
    mm: refuse wrapped vm_brk requests

Kees Cook <keescook@chromium.org>
    binfmt_elf: fix calculations for bss padding

Michal Hocko <mhocko@suse.com>
    mm, elf: handle vm_brk error

Miklos Szeredi <mszeredi@redhat.com>
    fuse: set FR_SENT while locked

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix blocked_waitq wakeup

Kirill Tkhai <ktkhai@virtuozzo.com>
    fuse: Fix use-after-free in fuse_dev_do_write()

Kirill Tkhai <ktkhai@virtuozzo.com>
    fuse: Fix use-after-free in fuse_dev_do_read()

Himanshu Madhani <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix incorrect port speed being set for FC adapters

Young_X <YangX92@hotmail.com>
    cdrom: fix improper type cast, which can leat to information leak.

Dominique Martinet <dominique.martinet@cea.fr>
    9p: clear dangling pointers in p9stat_free

Dominique Martinet <dominique.martinet@cea.fr>
    9p locks: fix glock.client_id leak in do_lock

Marco Felsch <m.felsch@pengutronix.de>
    media: tvp5150: fix width alignment during set_selection()

Phil Elwell <phil@raspberrypi.org>
    sc16is7xx: Fix for multi-channel stall

Joel Stanley <joel@jms.id.au>
    powerpc/boot: Ensure _zimage_start is a weak symbol

Dengcheng Zhu <dzhu@wavecomp.com>
    MIPS: kexec: Mark CPU offline before disabling local IRQ

Nicholas Mc Guire <hofrat@osadl.org>
    media: pci: cx23885: handle adding to list failure

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/omap: fix memory barrier bug in DMM driver

Daniel Axtens <dja@axtens.net>
    powerpc/nohash: fix undefined behaviour when testing page size support

Miles Chen <miles.chen@mediatek.com>
    tty: check name length in tty_find_polling_driver()

Shaohua Li <shli@fb.com>
    MD: fix invalid stored role for a disk - try2

Josef Bacik <jbacik@fb.com>
    btrfs: set max_extent_size properly

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix null pointer dereference on compressed write path error

Qu Wenruo <wqu@suse.com>
    btrfs: qgroup: Dirty all qgroups before rescan

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix wrong dentries after fsync of file that got its parent replaced

Josef Bacik <josef@toxicpanda.com>
    btrfs: make sure we create all new block groups

Josef Bacik <jbacik@fb.com>
    btrfs: reset max_extent_size on clear in a bitmap

Josef Bacik <josef@toxicpanda.com>
    btrfs: wait on caching when putting the bg cache

Jeff Mahoney <jeffm@suse.com>
    btrfs: don't attempt to trim devices that don't support it

Jeff Mahoney <jeffm@suse.com>
    btrfs: iterate all devices during trim, instead of fs_devices::alloc_list

Qu Wenruo <wqu@suse.com>
    btrfs: locking: Add extra check in btrfs_init_new_buffer() to avoid deadlock

Qu Wenruo <wqu@suse.com>
    btrfs: Handle owner mismatch gracefully when walking up tree

Johan Hovold <johan@kernel.org>
    soc/tegra: pmc: Fix child-node lookup

Thor Thayer <thor.thayer@linux.intel.com>
    arm64: dts: stratix10: Correct System Manager register size

Nicolas Pitre <nicolas.pitre@linaro.org>
    Cramfs: fix abad comparison when wrap-arounds occur

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid running out of journal credits when appending to an inline file

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: em28xx: make v4l2-compliance happier by starting sequence on zero

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: em28xx: fix input name for Terratec AV 350

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: em28xx: use a default format if TRY_FMT fails

Juergen Gross <jgross@suse.com>
    xen: fix xen_qlock_wait()

He Zhe <zhe.he@windriver.com>
    kgdboc: Passing ekgdboc to command line causes panic

Maciej W. Rozycki <macro@linux-mips.org>
    TC: Set DMA masks for devices

Aaro Koskinen <aaro.koskinen@iki.fi>
    MIPS: OCTEON: fix out of bounds array access on CN68XX

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/msi: Fix compile error on mpc83xx

Wenwen Wang <wang6495@umn.edu>
    dm ioctl: harden copy_params()'s copy_from_user() from malicious users

Amir Goldstein <amir73il@gmail.com>
    lockd: fix access beyond unterminated strings in prints

Trond Myklebust <trondmy@gmail.com>
    nfsd: Fix an Oops in free_session()

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Fix the r/wsize checking

Lukas Wunner <lukas@wunner.de>
    genirq: Fix race on spurious interrupt detection

He Zhe <zhe.he@windriver.com>
    printk: Fix panic caused by passing log_buf_len to command line

Steve French <stfrench@microsoft.com>
    smb3: on kerberos mount if server doesn't specify auth type use krb5

Steve French <stfrench@microsoft.com>
    smb3: do not attempt cifs operation in smb3 query info error path

Steve French <stfrench@microsoft.com>
    smb3: allow stats which track session and share reconnects to be reset

Andreas Kemnade <andreas@kemnade.info>
    w1: omap-hdq: fix missing bus unregister at removal

Eugen Hristev <eugen.hristev@microchip.com>
    iio: adc: at91: fix wrong channel number in triggered buffer mode

Eugen Hristev <eugen.hristev@microchip.com>
    iio: adc: at91: fix acking DRDY irq on simple conversions

Arnd Bergmann <arnd@arndb.de>
    kbuild: fix kernel/bounds.c 'W=1' warning

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: dirty pages as they are added to pagecache

Eric Biggers <ebiggers@google.com>
    ima: fix showing large 'violations' or 'runtime_measurements_count'

Ondrej Mosnacek <omosnace@redhat.com>
    crypto: lrw - Fix out-of bounds access on counter overflow

Eric W. Biederman <ebiederm@xmission.com>
    signal/GenWQE: Fix sending of SIGKILL

Bin Meng <bmeng.cn@gmail.com>
    PCI: Add Device IDs for Intel GPU "spurious interrupt" quirk

Breno Leitao <leitao@debian.org>
    HID: hiddev: fix potential Spectre v1

Lukas Czerner <lczerner@redhat.com>
    ext4: initialize retries variable in ext4_da_write_inline_data_begin()

Al Viro <viro@zeniv.linux.org.uk>
    gfs2_meta: ->mount() can get NULL dev_name

Jan Kara <jack@suse.cz>
    jbd2: fix use after free in jbd2_log_do_checkpoint()

Alexander Duyck <alexander.h.duyck@linux.intel.com>
    libnvdimm: Hold reference on parent while scheduling async init

Stefan Nuernberger <snu@amazon.com>
    net/ipv4: defensive cipso option parsing

Juergen Gross <jgross@suse.com>
    xen: make xen_qlock_wait() nestable

Juergen Gross <jgross@suse.com>
    xen: fix race in xen_qlock_wait()

Dr. Greg Wettstein <greg@wind.enjellic.com>
    tpm: Restore functionality to xen vtpm driver.

Joe Jin <joe.jin@oracle.com>
    xen-swiotlb: use actually allocated size on check physical continuous

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Check the non-cached stream buffers more explicitly

Paul Cercueil <paul@crapouillou.net>
    dmaengine: dma-jz4780: Return error if not probed from DT

Eric W. Biederman <ebiederm@xmission.com>
    signal: Always deliver the kernel's SIGKILL and SIGSTOP to a pid namespace init

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Correct soft lockup when running mds diagnostics

Alexandre Belloni <alexandre.belloni@bootlin.com>
    uio: ensure class is registered before devices

Waiman Long <longman@redhat.com>
    driver/dma/ioat: Call del_timer_sync() without holding prep_lock

Loic Poulain <loic.poulain@linaro.org>
    usb: chipidea: Prevent unbalanced IRQ disable

Shaohua Li <shli@fb.com>
    MD: fix invalid stored role for a disk

Theodore Ts'o <tytso@mit.edu>
    ext4: fix argument checking in EXT4_IOC_MOVE_EXT

Javier Martinez Canillas <javierm@redhat.com>
    tpm: suppress transmit cmd error logs when TPM 1.2 is disabled/deactivated

Wenwen Wang <wang6495@umn.edu>
    scsi: megaraid_sas: fix a missing-check bug

Finn Thain <fthain@telegraphics.com.au>
    scsi: esp_scsi: Track residual for PIO transfers

Martin Willi <martin@strongswan.org>
    ath10k: schedule hardware restart if WMI command times out

Douglas Anderson <dianders@chromium.org>
    pinctrl: ssbi-gpio: Fix pm8xxx_pin_config_get() to be compliant

Douglas Anderson <dianders@chromium.org>
    pinctrl: spmi-mpp: Fix pmic_mpp_config_get() to be compliant

Stephen Boyd <swboyd@chromium.org>
    pinctrl: qcom: spmi-mpp: Fix drive strength setting

Hans de Goede <hdegoede@redhat.com>
    ACPI / LPSS: Add alternative ACPI HIDs for Cherry Trail DMA controllers

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Return error if we fail to reuse kprobe instead of BUG_ON()

YueHaibing <yuehaibing@huawei.com>
    pinctrl: qcom: spmi-mpp: Fix err handling of pmic_mpp_set_mux

Ben Hutchings <ben@decadent.org.uk>
    x86: boot: Fix EFI stub alignment

Christian Hewitt <christianshewitt@gmail.com>
    Bluetooth: btbcm: Add entry for BCM4335C0 UART bluetooth

Yu Zhao <yuzhao@google.com>
    mmc: sdhci-pci-o2micro: Add quirk for O2 Micro dev 0x8620 rev 0x01

Sanskriti Sharma <sansharm@redhat.com>
    perf tools: Cleanup trace-event-info 'tdata' leak

Sanskriti Sharma <sansharm@redhat.com>
    perf tools: Free temporary 'sys' string in read_event_files()

Serhey Popovych <serhe.popovych@gmail.com>
    tun: Consistently configure generic netdev params via rtnetlink

Omar Sandoval <osandov@fb.com>
    swim: fix cleanup on setup error

Omar Sandoval <osandov@fb.com>
    ataflop: fix error handling during setup

Waiman Long <longman@redhat.com>
    locking/lockdep: Fix debug_locks off performance problem

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add synthetic event syntax testcase

Nathan Chancellor <natechancellor@gmail.com>
    net: qla3xxx: Remove overflowing shift statement

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    x86/fpu: Remove second definition of fpu in __fpu__restore_sig()

David S. Miller <davem@davemloft.net>
    sparc: Fix single-pcr perf event counter management.

Daniel Wagner <daniel.wagner@siemens.com>
    x86/kconfig: Fall back to ticket spinlocks

He Zhe <zhe.he@windriver.com>
    x86/corruption-check: Fix panic in memory_corruption_check() when boot option without value is provided

Alex Stanoev <alex@astanoev.com>
    ALSA: ca0106: Disable IZD on SB0570 DAC to fix audio pops

Jeremy Cline <jcline@redhat.com>
    ALSA: hda - Add mic quirk for the Lenovo G50-30 (17aa:3905)

Helge Deller <deller@gmx.de>
    parisc: Fix map_pages() to not overwrite existing pte entries

John David Anglin <dave.anglin@bell.net>
    parisc: Fix address in HPMC IVA

Jan Glauber <jglauber@cavium.com>
    ipmi: Fix timer race with module unload

Maciej S. Szmigiero <mail@maciej.szmigiero.name>
    pcmcia: Implement CLKRUN protocol disabling for Ricoh bridges

Hou Tao <houtao1@huawei.com>
    jffs2: free jffs2_sb_info through jffs2_kill_sb()

Dmitry Bazhenov <bazhenov.dn@gmail.com>
    hwmon: (pmbus) Fix page count auto-detection.

Tang Junhui <tang.junhui.linux@gmail.com>
    bcache: fix miss key refill->end in writeback


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/alpha/include/asm/termios.h                   |  8 ++-
 arch/alpha/include/uapi/asm/ioctls.h               |  5 ++
 arch/alpha/include/uapi/asm/termbits.h             | 17 +++++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |  2 +-
 arch/mips/include/asm/mach-loongson64/irq.h        |  2 +-
 arch/mips/kernel/crash.c                           |  3 +
 arch/mips/kernel/machine_kexec.c                   |  3 +
 arch/mips/loongson64/loongson-3/irq.c              | 56 ++-------------
 arch/parisc/kernel/entry.S                         |  2 +-
 arch/parisc/kernel/traps.c                         |  3 +-
 arch/parisc/mm/init.c                              |  8 +--
 arch/powerpc/boot/crt0.S                           |  4 +-
 arch/powerpc/include/asm/mpic.h                    |  7 ++
 arch/powerpc/mm/tlb_nohash.c                       |  3 +
 arch/sparc/kernel/perf_event.c                     | 17 +++--
 arch/x86/Kconfig                                   |  1 -
 arch/x86/boot/tools/build.c                        |  7 ++
 arch/x86/kernel/check.c                            | 15 ++++
 arch/x86/kernel/fpu/signal.c                       |  1 -
 arch/x86/xen/spinlock.c                            | 35 ++++------
 arch/xtensa/boot/Makefile                          |  2 +-
 arch/xtensa/include/asm/processor.h                |  6 +-
 arch/xtensa/kernel/head.S                          |  7 +-
 arch/xtensa/kernel/vmlinux.lds.S                   |  1 +
 crypto/lrw.c                                       |  7 +-
 drivers/acpi/acpi_lpss.c                           |  2 +
 drivers/block/ataflop.c                            | 25 ++++---
 drivers/block/swim.c                               | 13 +++-
 drivers/bluetooth/btbcm.c                          |  1 +
 drivers/cdrom/cdrom.c                              |  2 +-
 drivers/char/ipmi/ipmi_ssif.c                      | 10 +--
 drivers/char/tpm/tpm-interface.c                   |  3 +-
 drivers/char/tpm/xen-tpmfront.c                    |  2 +-
 drivers/clk/clk-s2mps11.c                          | 30 ++++++++
 drivers/clocksource/i8253.c                        | 14 +++-
 drivers/dma/dma-jz4780.c                           |  5 ++
 drivers/dma/ioat/init.c                            |  9 ++-
 drivers/gpu/drm/drm_dp_mst_topology.c              |  3 +
 drivers/gpu/drm/i915/intel_audio.c                 | 17 +++++
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           | 11 +++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |  6 ++
 drivers/hid/usbhid/hiddev.c                        | 18 +++--
 drivers/hwmon/pmbus/pmbus.c                        |  2 +
 drivers/hwmon/pmbus/pmbus_core.c                   |  5 +-
 drivers/iio/adc/at91_adc.c                         |  6 +-
 drivers/md/bcache/btree.c                          |  2 +-
 drivers/md/dm-ioctl.c                              | 18 ++---
 drivers/md/raid1.c                                 |  1 +
 drivers/md/raid10.c                                |  1 +
 drivers/media/i2c/tvp5150.c                        | 14 ++--
 drivers/media/pci/cx23885/altera-ci.c              | 10 +++
 drivers/media/usb/em28xx/em28xx-cards.c            |  4 +-
 drivers/media/usb/em28xx/em28xx-video.c            |  8 ++-
 drivers/misc/genwqe/card_base.h                    |  2 +-
 drivers/misc/genwqe/card_dev.c                     |  9 +--
 drivers/mmc/host/sdhci-pci-o2micro.c               |  3 +
 drivers/mtd/devices/Kconfig                        |  2 +-
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |  4 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |  9 ++-
 drivers/net/ethernet/intel/e1000/e1000_main.c      | 11 ++-
 drivers/net/ethernet/qlogic/qla3xxx.c              |  2 -
 drivers/net/tun.c                                  |  2 +
 drivers/net/wireless/ath/ath10k/wmi.c              |  6 ++
 drivers/nvdimm/bus.c                               |  4 ++
 drivers/pci/quirks.c                               |  4 ++
 drivers/pcmcia/ricoh.h                             | 35 ++++++++++
 drivers/pcmcia/yenta_socket.c                      |  3 +-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            | 27 +++++---
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           | 28 ++++++--
 drivers/rtc/hctosys.c                              |  4 +-
 drivers/scsi/esp_scsi.c                            |  1 +
 drivers/scsi/esp_scsi.h                            |  2 +
 drivers/scsi/lpfc/lpfc_sli.c                       |  7 ++
 drivers/scsi/mac_esp.c                             |  2 +
 drivers/scsi/megaraid/megaraid_sas_base.c          |  3 +
 drivers/scsi/qla2xxx/qla_mbx.c                     |  5 +-
 drivers/soc/tegra/pmc.c                            |  2 +-
 drivers/tc/tc.c                                    |  8 ++-
 drivers/tty/serial/kgdboc.c                        |  5 ++
 drivers/tty/serial/sc16is7xx.c                     | 19 +++--
 drivers/tty/tty_io.c                               |  2 +-
 drivers/tty/tty_ioctl.c                            |  4 +-
 drivers/uio/uio.c                                  |  9 +++
 drivers/usb/chipidea/otg.h                         |  3 +-
 drivers/vhost/scsi.c                               |  4 +-
 drivers/video/fbdev/aty/mach64_accel.c             | 28 ++++----
 drivers/w1/masters/omap_hdq.c                      |  2 +
 drivers/xen/swiotlb-xen.c                          |  6 ++
 fs/9p/vfs_file.c                                   | 16 ++++-
 fs/binfmt_elf.c                                    | 46 +++++++------
 fs/btrfs/extent-tree.c                             | 48 ++++++++++---
 fs/btrfs/free-space-cache.c                        | 32 ++++++---
 fs/btrfs/inode.c                                   |  1 +
 fs/btrfs/ioctl.c                                   | 12 +++-
 fs/btrfs/qgroup.c                                  |  1 +
 fs/btrfs/relocation.c                              |  2 +-
 fs/btrfs/tree-log.c                                | 30 +++++++-
 fs/cifs/cifs_debug.c                               |  3 +
 fs/cifs/cifs_spnego.c                              |  6 +-
 fs/cifs/inode.c                                    | 10 ++-
 fs/configfs/symlink.c                              |  2 +-
 fs/cramfs/inode.c                                  |  3 +-
 fs/ext4/ext4.h                                     |  3 -
 fs/ext4/inline.c                                   | 40 +----------
 fs/ext4/move_extent.c                              |  8 ++-
 fs/ext4/namei.c                                    |  5 +-
 fs/ext4/resize.c                                   | 28 ++++----
 fs/ext4/super.c                                    | 16 ++---
 fs/ext4/xattr.c                                    | 22 ++----
 fs/fuse/dev.c                                      | 29 ++++++--
 fs/gfs2/ops_fstype.c                               |  3 +
 fs/jbd2/checkpoint.c                               |  4 +-
 fs/jffs2/super.c                                   |  4 +-
 fs/lockd/host.c                                    |  2 +-
 fs/namespace.c                                     | 22 ++++--
 fs/nfs/nfs4client.c                                | 16 +++--
 fs/ocfs2/dir.c                                     |  3 +-
 include/linux/ceph/libceph.h                       |  8 ++-
 include/linux/hugetlb.h                            | 14 ++++
 include/linux/i8253.h                              |  1 +
 include/linux/mm.h                                 |  6 ++
 include/linux/tc.h                                 |  1 +
 kernel/bounds.c                                    |  4 +-
 kernel/irq/manage.c                                |  8 ++-
 kernel/kprobes.c                                   | 27 ++++++--
 kernel/locking/lockdep.c                           |  4 +-
 kernel/printk/printk.c                             |  7 +-
 kernel/signal.c                                    |  2 +-
 lib/debug_locks.c                                  |  2 +-
 mm/gup.c                                           |  2 -
 mm/hugetlb.c                                       | 66 ++++++++++++++++--
 mm/mempolicy.c                                     | 32 ++++++++-
 mm/mmap.c                                          | 13 ++--
 mm/rmap.c                                          | 56 +++++++++++++++
 net/9p/protocol.c                                  |  5 ++
 net/ipv4/cipso_ipv4.c                              | 11 +--
 net/sunrpc/svc_xprt.c                              |  2 +-
 net/sunrpc/xdr.c                                   |  5 +-
 security/integrity/ima/ima_fs.c                    |  6 +-
 sound/pci/ca0106/ca0106.h                          |  2 +-
 sound/pci/hda/hda_controller.h                     |  1 +
 sound/pci/hda/hda_intel.c                          | 11 ++-
 sound/pci/hda/patch_conexant.c                     |  1 +
 tools/perf/util/trace-event-info.c                 |  2 +
 tools/perf/util/trace-event-read.c                 |  5 +-
 .../inter-event/trigger-synthetic-event-syntax.tc  | 80 ++++++++++++++++++++++
 148 files changed, 1115 insertions(+), 423 deletions(-)


