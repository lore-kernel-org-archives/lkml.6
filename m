Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797D1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F73821104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="peu9welK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F73821104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390822AbeKTDR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390498AbeKTDR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:17:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8641F208E3;
        Mon, 19 Nov 2018 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646423;
        bh=WBdngoEE2XLYeM0jWKswWZMqMLk3Fx4EOrKofxSSslo=;
        h=From:To:Cc:Subject:Date:From;
        b=peu9welKA2wAX7l8UFOvj6PWUKPw7LIb5LFo0h+kFQVTxLgyiy8geTzoLCpcUV3rY
         YWRc0ohqN5mAQ+oYoDdMewR73AWQKZ0iZUlFXHU7cq3dTWi6ZqOtARAoxqYOgwES2r
         hQtJ0Be+BRfR8cs8TQHo+smp4HspuN8kl/JV7DNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/83] 4.9.138-stable review
Date:   Mon, 19 Nov 2018 17:28:26 +0100
Message-Id: <20181119162612.046511542@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.138-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.138-rc1
X-KernelTest-Deadline: 2018-11-21T16:26+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.138 release.
There are 83 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Nov 21 16:25:13 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.138-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.138-rc1

Mark Rutland <mark.rutland@arm.com>
    KVM: arm64: Fix caching of host MDCR_EL2 value

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/execlists: Force write serialisation into context image vs execution

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

Arnd Bergmann <arnd@arndb.de>
    lib/ubsan.c: don't mark __ubsan_handle_builtin_unreachable as noreturn

Guenter Roeck <linux@roeck-us.net>
    configfs: replace strncpy with memcpy

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix leaked notify reply

Lukas Czerner <lczerner@redhat.com>
    fuse: fix use-after-free in fuse_direct_IO()

Maciej W. Rozycki <macro@linux-mips.org>
    rtc: hctosys: Add missing range error reporting

Scott Mayhew <smayhew@redhat.com>
    nfsd: COPY and CLONE operations require the saved filehandle to be set

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

Vasily Averin <vvs@virtuozzo.com>
    ext4: fix possible leak of s_journal_flag_rwsem in error path

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

Robbie Ko <robbieko@synology.com>
    Btrfs: fix cur_offset in the error case for nocow

H. Peter Anvin (Intel) <hpa@zytor.com>
    arch/alpha, termios: implement BOTHER, IBSHIFT and termios2

H. Peter Anvin <hpa@zytor.com>
    termios, tty/tty_baudrate.c: fix buffer overrun

John Garry <john.garry@huawei.com>
    of, numa: Validate some distance map rules

Arnd Bergmann <arnd@arndb.de>
    mtd: docg3: don't set conflicting BCH_CONST_PARAMS option

Vasily Khoruzhick <vasilykh@arista.com>
    netfilter: conntrack: fix calculation of next bucket number in early_drop

Andrea Arcangeli <aarcange@redhat.com>
    mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings

Changwei Ge <ge.changwei@h3c.com>
    ocfs2: fix a misuse a of brelse after failing ocfs2_check_dir_entry

Greg Edwards <gedwards@ddn.com>
    vhost/scsi: truncate T10 PI iov_iter to prot_bytes

Gustavo A. R. Silva <gustavo@embeddedor.com>
    reset: hisilicon: fix potential NULL pointer dereference

Mikulas Patocka <mpatocka@redhat.com>
    mach64: fix image corruption due to reading accelerator registers

Mikulas Patocka <mpatocka@redhat.com>
    mach64: fix display corruption on big endian machines

Yan, Zheng <zyan@redhat.com>
    Revert "ceph: fix dentry leak in splice_dentry()"

Ilya Dryomov <idryomov@gmail.com>
    libceph: bump CEPH_MSG_MAX_DATA_LEN

Enric Balletbo i Serra <enric.balletbo@collabora.com>
    clk: rockchip: Fix static checker warning in rockchip_ddrclk_get_parent call

Ronald Wahl <rwahl@gmx.de>
    clk: at91: Fix division by zero in PLL recalc_rate()

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

Helge Deller <deller@gmx.de>
    parisc: Fix exported address of os_hpmc handler

Helge Deller <deller@gmx.de>
    parisc: Fix HPMC handler by increasing size to multiple of 16 bytes

Helge Deller <deller@gmx.de>
    parisc: Align os_hpmc_size on word boundary

Kees Cook <keescook@chromium.org>
    bna: ethtool: Avoid reading past end of buffer

Vincenzo Maffione <v.maffione@gmail.com>
    e1000: fix race condition between e1000_down() and e1000_watchdog

Colin Ian King <colin.king@canonical.com>
    e1000: avoid null pointer dereference on invalid stat type

Michal Hocko <mhocko@suse.com>
    mm: do not bug_on on incorrect length in __mm_populate()

Miklos Szeredi <mszeredi@redhat.com>
    fuse: set FR_SENT while locked

Miklos Szeredi <mszeredi@redhat.com>
    fuse: fix blocked_waitq wakeup

Kirill Tkhai <ktkhai@virtuozzo.com>
    fuse: Fix use-after-free in fuse_dev_do_write()

Kirill Tkhai <ktkhai@virtuozzo.com>
    fuse: Fix use-after-free in fuse_dev_do_read()

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: shutdown chip if reset fail

Himanshu Madhani <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix incorrect port speed being set for FC adapters

Young_X <YangX92@hotmail.com>
    cdrom: fix improper type cast, which can leat to information leak.

Dominique Martinet <dominique.martinet@cea.fr>
    9p: clear dangling pointers in p9stat_free

Dominique Martinet <dominique.martinet@cea.fr>
    9p locks: fix glock.client_id leak in do_lock

Breno Leitao <leitao@debian.org>
    powerpc/selftests: Wait all threads to join

Marco Felsch <m.felsch@pengutronix.de>
    media: tvp5150: fix width alignment during set_selection()

Phil Elwell <phil@raspberrypi.org>
    sc16is7xx: Fix for multi-channel stall

Huacai Chen <chenhc@lemote.com>
    MIPS/PCI: Call pcie_bus_configure_settings() to set MPS/MRRS

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

Fabio Estevam <fabio.estevam@nxp.com>
    ARM: imx_v6_v7_defconfig: Select CONFIG_TMPFS_POSIX_ACL

Miles Chen <miles.chen@mediatek.com>
    tty: check name length in tty_find_polling_driver()

Sam Bobroff <sbobroff@linux.ibm.com>
    powerpc/eeh: Fix possible null deref in eeh_dump_dev_log()


-------------

Diffstat:

 Makefile                                         |  4 +-
 arch/alpha/include/asm/termios.h                 |  8 +++-
 arch/alpha/include/uapi/asm/ioctls.h             |  5 ++
 arch/alpha/include/uapi/asm/termbits.h           | 17 +++++++
 arch/arm/configs/imx_v6_v7_defconfig             |  1 +
 arch/arm/kvm/arm.c                               |  4 +-
 arch/mips/include/asm/mach-loongson64/irq.h      |  2 +-
 arch/mips/kernel/crash.c                         |  3 ++
 arch/mips/kernel/machine_kexec.c                 |  3 ++
 arch/mips/loongson64/loongson-3/irq.c            | 56 +++-------------------
 arch/mips/pci/pci-legacy.c                       |  4 ++
 arch/parisc/kernel/hpmc.S                        | 10 ++--
 arch/powerpc/boot/crt0.S                         |  4 +-
 arch/powerpc/kernel/eeh.c                        |  5 ++
 arch/powerpc/mm/tlb_nohash.c                     |  3 ++
 arch/xtensa/boot/Makefile                        |  2 +-
 arch/xtensa/include/asm/processor.h              |  6 ++-
 arch/xtensa/kernel/head.S                        |  7 ++-
 arch/xtensa/kernel/vmlinux.lds.S                 |  1 +
 drivers/cdrom/cdrom.c                            |  2 +-
 drivers/clk/at91/clk-pll.c                       |  3 ++
 drivers/clk/clk-s2mps11.c                        | 30 ++++++++++++
 drivers/clk/hisilicon/reset.c                    |  5 +-
 drivers/clk/rockchip/clk-ddr.c                   |  4 --
 drivers/clocksource/i8253.c                      | 14 +++++-
 drivers/gpu/drm/drm_dp_mst_topology.c            |  3 ++
 drivers/gpu/drm/i915/intel_audio.c               | 17 +++++++
 drivers/gpu/drm/i915/intel_lrc.c                 | 14 +++++-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c         | 11 +++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c      |  6 +++
 drivers/media/i2c/tvp5150.c                      | 14 ++++--
 drivers/media/pci/cx23885/altera-ci.c            | 10 ++++
 drivers/mtd/devices/Kconfig                      |  2 +-
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c  |  4 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c |  9 ++--
 drivers/net/ethernet/intel/e1000/e1000_main.c    | 11 ++++-
 drivers/of/of_numa.c                             |  9 +++-
 drivers/rtc/hctosys.c                            |  4 +-
 drivers/scsi/qla2xxx/qla_init.c                  |  2 +-
 drivers/scsi/qla2xxx/qla_mbx.c                   |  5 +-
 drivers/tty/serial/sc16is7xx.c                   | 19 +++++---
 drivers/tty/tty_io.c                             |  2 +-
 drivers/tty/tty_ioctl.c                          |  4 +-
 drivers/vhost/scsi.c                             |  4 +-
 drivers/video/fbdev/aty/mach64_accel.c           | 28 +++++------
 fs/9p/vfs_file.c                                 | 16 ++++++-
 fs/btrfs/inode.c                                 |  5 +-
 fs/btrfs/ioctl.c                                 | 12 ++++-
 fs/ceph/inode.c                                  |  8 +++-
 fs/configfs/symlink.c                            |  2 +-
 fs/ext4/namei.c                                  |  5 +-
 fs/ext4/resize.c                                 | 28 ++++++-----
 fs/ext4/super.c                                  | 17 +++----
 fs/ext4/xattr.c                                  |  4 ++
 fs/fuse/dev.c                                    | 29 +++++++++---
 fs/fuse/file.c                                   |  4 +-
 fs/namespace.c                                   | 22 +++++++--
 fs/nfsd/nfs4proc.c                               |  3 ++
 fs/ocfs2/dir.c                                   |  3 +-
 include/linux/ceph/libceph.h                     |  8 +++-
 include/linux/hugetlb.h                          | 14 ++++++
 include/linux/i8253.h                            |  1 +
 include/linux/mm.h                               |  6 +++
 lib/ubsan.c                                      |  3 +-
 mm/gup.c                                         |  2 -
 mm/hugetlb.c                                     | 60 +++++++++++++++++++++---
 mm/mempolicy.c                                   | 32 ++++++++++++-
 mm/mmap.c                                        | 19 ++++----
 mm/rmap.c                                        | 56 ++++++++++++++++++++++
 net/9p/protocol.c                                |  5 ++
 net/netfilter/nf_conntrack_core.c                | 13 +++--
 net/sunrpc/xdr.c                                 |  5 +-
 tools/testing/selftests/powerpc/tm/tm-tmspr.c    | 27 +++++++----
 73 files changed, 580 insertions(+), 210 deletions(-)


