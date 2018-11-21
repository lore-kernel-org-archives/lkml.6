Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22182C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78952146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODf5Xuwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78952146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeKUVFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeKUVFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:05:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B53521104;
        Wed, 21 Nov 2018 10:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542796321;
        bh=X+LG0iOQmInU3bhRIs/sTIHNvQ31jWLJZGt+R3Gin98=;
        h=Date:From:To:Cc:Subject:From;
        b=ODf5Xuwcq8u/Ni+grlip0o1oQgah3IhZanoqsXzQqp4IUbd8UATrdbphekAjgsBV5
         G48ZO02uHI5j4yECjNW+uLrWbNLlerjWfyhsWW1cbd8oghZ4e24+0i+uzf5j9EMMy6
         SQoUdTaurb+ky6G8tzhsoQHxthXsyiCavGp87GZ0=
Date:   Wed, 21 Nov 2018 11:31:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.138
Message-ID: <20181121103159.GA9278@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.138 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                         |    2=20
 arch/alpha/include/asm/termios.h                 |    8 ++-
 arch/alpha/include/uapi/asm/ioctls.h             |    5 +
 arch/alpha/include/uapi/asm/termbits.h           |   17 ++++++
 arch/arm/configs/imx_v6_v7_defconfig             |    1=20
 arch/arm/kvm/arm.c                               |    4 -
 arch/mips/include/asm/mach-loongson64/irq.h      |    2=20
 arch/mips/kernel/crash.c                         |    3 +
 arch/mips/kernel/machine_kexec.c                 |    3 +
 arch/mips/loongson64/loongson-3/irq.c            |   56 ++----------------=
---
 arch/mips/pci/pci-legacy.c                       |    4 +
 arch/parisc/kernel/hpmc.S                        |   10 ++-
 arch/powerpc/boot/crt0.S                         |    4 +
 arch/powerpc/kernel/eeh.c                        |    5 +
 arch/powerpc/mm/tlb_nohash.c                     |    3 +
 arch/xtensa/boot/Makefile                        |    2=20
 arch/xtensa/include/asm/processor.h              |    6 +-
 arch/xtensa/kernel/head.S                        |    7 +-
 arch/xtensa/kernel/vmlinux.lds.S                 |    1=20
 drivers/cdrom/cdrom.c                            |    2=20
 drivers/clk/at91/clk-pll.c                       |    3 +
 drivers/clk/clk-s2mps11.c                        |   30 +++++++++++
 drivers/clk/hisilicon/reset.c                    |    5 -
 drivers/clk/rockchip/clk-ddr.c                   |    4 -
 drivers/clocksource/i8253.c                      |   14 ++++-
 drivers/gpu/drm/drm_dp_mst_topology.c            |    3 +
 drivers/gpu/drm/i915/intel_audio.c               |   17 ++++++
 drivers/gpu/drm/i915/intel_lrc.c                 |   14 ++++-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c         |   11 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c      |    6 ++
 drivers/media/i2c/tvp5150.c                      |   14 +++--
 drivers/media/pci/cx23885/altera-ci.c            |   10 +++
 drivers/mtd/devices/Kconfig                      |    2=20
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c  |    4 -
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c |    9 +--
 drivers/net/ethernet/intel/e1000/e1000_main.c    |   11 +++-
 drivers/of/of_numa.c                             |    9 ++-
 drivers/rtc/hctosys.c                            |    4 +
 drivers/scsi/qla2xxx/qla_init.c                  |    2=20
 drivers/scsi/qla2xxx/qla_mbx.c                   |    5 -
 drivers/tty/serial/sc16is7xx.c                   |   19 ++++---
 drivers/tty/tty_io.c                             |    2=20
 drivers/tty/tty_ioctl.c                          |    4 -
 drivers/vhost/scsi.c                             |    4 +
 drivers/video/fbdev/aty/mach64_accel.c           |   28 ++++------
 fs/9p/vfs_file.c                                 |   16 +++++-
 fs/btrfs/inode.c                                 |    5 -
 fs/btrfs/ioctl.c                                 |   12 +++-
 fs/ceph/inode.c                                  |    8 ++-
 fs/configfs/symlink.c                            |    2=20
 fs/ext4/namei.c                                  |    5 +
 fs/ext4/resize.c                                 |   28 ++++++----
 fs/ext4/super.c                                  |   17 +++---
 fs/ext4/xattr.c                                  |    4 +
 fs/fuse/dev.c                                    |   29 ++++++++---
 fs/fuse/file.c                                   |    4 +
 fs/namespace.c                                   |   22 ++++++--
 fs/nfsd/nfs4proc.c                               |    3 +
 fs/ocfs2/dir.c                                   |    3 -
 include/linux/ceph/libceph.h                     |    8 ++-
 include/linux/hugetlb.h                          |   14 +++++
 include/linux/i8253.h                            |    1=20
 include/linux/mm.h                               |    6 ++
 lib/ubsan.c                                      |    3 -
 mm/gup.c                                         |    2=20
 mm/hugetlb.c                                     |   60 ++++++++++++++++++=
++---
 mm/mempolicy.c                                   |   32 +++++++++++-
 mm/mmap.c                                        |   19 +++----
 mm/rmap.c                                        |   56 ++++++++++++++++++=
+++
 net/9p/protocol.c                                |    5 +
 net/netfilter/nf_conntrack_core.c                |   13 +++-
 net/sunrpc/xdr.c                                 |    5 -
 tools/testing/selftests/powerpc/tm/tm-tmspr.c    |   27 ++++++----
 73 files changed, 579 insertions(+), 209 deletions(-)

Andrea Arcangeli (1):
      mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings

Arnd Bergmann (2):
      mtd: docg3: don't set conflicting BCH_CONST_PARAMS option
      lib/ubsan.c: don't mark __ubsan_handle_builtin_unreachable as noreturn

Breno Leitao (1):
      powerpc/selftests: Wait all threads to join

Changwei Ge (1):
      ocfs2: fix a misuse a of brelse after failing ocfs2_check_dir_entry

Chris Wilson (1):
      drm/i915/execlists: Force write serialisation into context image vs e=
xecution

Clint Taylor (1):
      drm/i915/hdmi: Add HDMI 2.0 audio clock recovery N values

Colin Ian King (1):
      e1000: avoid null pointer dereference on invalid stat type

Daniel Axtens (1):
      powerpc/nohash: fix undefined behaviour when testing page size support

Dengcheng Zhu (1):
      MIPS: kexec: Mark CPU offline before disabling local IRQ

Dominique Martinet (2):
      9p locks: fix glock.client_id leak in do_lock
      9p: clear dangling pointers in p9stat_free

Enric Balletbo i Serra (1):
      clk: rockchip: Fix static checker warning in rockchip_ddrclk_get_pare=
nt call

Eric W. Biederman (3):
      mount: Retest MNT_LOCKED in do_umount
      mount: Don't allow copying MNT_UNBINDABLE|MNT_LOCKED mounts
      mount: Prevent MNT_DETACH from disconnecting locked mounts

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Select CONFIG_TMPFS_POSIX_ACL

Filipe Manana (1):
      Btrfs: fix data corruption due to cloning of eof block

Frank Sorenson (1):
      sunrpc: correct the computation for page_ptr when truncating

Greg Edwards (1):
      vhost/scsi: truncate T10 PI iov_iter to prot_bytes

Greg Kroah-Hartman (1):
      Linux 4.9.138

Guenter Roeck (1):
      configfs: replace strncpy with memcpy

Gustavo A. R. Silva (1):
      reset: hisilicon: fix potential NULL pointer dereference

H. Peter Anvin (1):
      termios, tty/tty_baudrate.c: fix buffer overrun

H. Peter Anvin (Intel) (1):
      arch/alpha, termios: implement BOTHER, IBSHIFT and termios2

Helge Deller (3):
      parisc: Align os_hpmc_size on word boundary
      parisc: Fix HPMC handler by increasing size to multiple of 16 bytes
      parisc: Fix exported address of os_hpmc handler

Himanshu Madhani (1):
      scsi: qla2xxx: Fix incorrect port speed being set for FC adapters

Huacai Chen (3):
      MIPS/PCI: Call pcie_bus_configure_settings() to set MPS/MRRS
      MIPS: Loongson-3: Fix CPU UART irq delivery problem
      MIPS: Loongson-3: Fix BRIDGE irq delivery problem

Ilya Dryomov (1):
      libceph: bump CEPH_MSG_MAX_DATA_LEN

Joel Stanley (1):
      powerpc/boot: Ensure _zimage_start is a weak symbol

John Garry (1):
      of, numa: Validate some distance map rules

Kees Cook (1):
      bna: ethtool: Avoid reading past end of buffer

Kirill Tkhai (2):
      fuse: Fix use-after-free in fuse_dev_do_read()
      fuse: Fix use-after-free in fuse_dev_do_write()

Krzysztof Kozlowski (1):
      clk: s2mps11: Fix matching when built as module and DT node contains =
compatible

Lukas Czerner (1):
      fuse: fix use-after-free in fuse_direct_IO()

Maciej W. Rozycki (1):
      rtc: hctosys: Add missing range error reporting

Marc Zyngier (1):
      drm/rockchip: Allow driver to be shutdown on reboot/kexec

Marco Felsch (1):
      media: tvp5150: fix width alignment during set_selection()

Mark Rutland (1):
      KVM: arm64: Fix caching of host MDCR_EL2 value

Max Filippov (3):
      xtensa: add NOTES section to the linker script
      xtensa: make sure bFLT stack is 16 byte aligned
      xtensa: fix boot parameters address translation

Michael Kelley (1):
      clockevents/drivers/i8253: Add support for PIT shutdown quirk

Michal Hocko (1):
      mm: do not bug_on on incorrect length in __mm_populate()

Mike Kravetz (2):
      hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!
      mm: migration: fix migration of huge PMD shared pages

Miklos Szeredi (3):
      fuse: fix blocked_waitq wakeup
      fuse: set FR_SENT while locked
      fuse: fix leaked notify reply

Mikulas Patocka (2):
      mach64: fix display corruption on big endian machines
      mach64: fix image corruption due to reading accelerator registers

Miles Chen (1):
      tty: check name length in tty_find_polling_driver()

Nicholas Mc Guire (1):
      media: pci: cx23885: handle adding to list failure

Phil Elwell (1):
      sc16is7xx: Fix for multi-channel stall

Quinn Tran (1):
      scsi: qla2xxx: shutdown chip if reset fail

Robbie Ko (1):
      Btrfs: fix cur_offset in the error case for nocow

Ronald Wahl (1):
      clk: at91: Fix division by zero in PLL recalc_rate()

Sam Bobroff (1):
      powerpc/eeh: Fix possible null deref in eeh_dump_dev_log()

Scott Mayhew (1):
      nfsd: COPY and CLONE operations require the saved filehandle to be set

Stanislav Lisovskiy (1):
      drm/dp_mst: Check if primary mstb is null

Theodore Ts'o (2):
      ext4: avoid possible double brelse() in add_new_gdb() on error path
      ext4: fix possible leak of sbi->s_group_desc_leak in error path

Tomi Valkeinen (1):
      drm/omap: fix memory barrier bug in DMM driver

Vasily Averin (11):
      ext4: add missing brelse() update_backups()'s error path
      ext4: add missing brelse() in set_flexbg_block_bitmap()'s error path
      ext4: add missing brelse() add_new_gdb_meta_bg()'s error path
      ext4: avoid potential extra brelse in setup_new_flex_group_blocks()
      ext4: fix possible inode leak in the retry loop of ext4_resize_fs()
      ext4: avoid buffer leak in ext4_orphan_add() after prior errors
      ext4: fix missing cleanup if ext4_alloc_flex_bg_array() fails while r=
esizing
      ext4: fix possible leak of s_journal_flag_rwsem in error path
      ext4: release bs.bh before re-using in ext4_xattr_block_find()
      ext4: fix buffer leak in ext4_xattr_move_to_block() on error path
      ext4: fix buffer leak in __ext4_read_dirblock() on error path

Vasily Khoruzhick (1):
      netfilter: conntrack: fix calculation of next bucket number in early_=
drop

Vincenzo Maffione (1):
      e1000: fix race condition between e1000_down() and e1000_watchdog

Yan, Zheng (1):
      Revert "ceph: fix dentry leak in splice_dentry()"

Young_X (1):
      cdrom: fix improper type cast, which can leat to information leak.


--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlv1NB8ACgkQONu9yGCS
aT6xxg//ZmgnfOWDdEq37/DZcZTq8BfBi7i/IduudMQlcTePSYB3zDrwuI7hk9wp
10/iDUdvvwCtYBtJ6EMeAkFaDvGiuGVu57XaWi+yNNxBSbAAo4wS6uk3w8nISp4k
Bfq8QOy46tJzldfRJsBQ5l2ZqKNOnEHxxXZ/2ifmd2pfSZsVklXyPTDUi6ujB7s0
/EBj1YmIFbUHmeCmdMlIfsStyWtAZ8I/sKZbolp4H420jiP6eafn5n+/lCJWd9M5
7c86zxG/2obN2GTic2N4NBiHNk/qYrwphiXhrsNQ04PsFLyyt31OZvD7HbbVFWTM
oYQeMePPDaewAwkpToUraby+5Rfa4nthoS+hmeD4yiT+TFEKgYswY9yeSlOixK2+
wVpaG0SnhkXetADFxGM4RiMRx71rlrDae5i3CT50PAzsdQ8pbDl+yQzJMshi91HF
paURtdUxyUr8MaBpBQMGwvYUDm64GqF1OkA8P0HWZKrNBC5Ipuo7Bx4QJk9OAMO9
B9OgG1cukbfidoThNtwrFxPFPAXf/d83eglFyKhQbBcc36wYc4dK/KPuWyFPmzn7
KUrn3+vYtq18Mhe3mMHR7Iym4nimitgX/qFXrvjzo8sYUpaZakuqOc4lsrGBRtC0
9ynf3rk4DSpVpApNIjb+BVSg/j2XnnMEJwLrlQhJR5YHSMrKvyQ=
=USCc
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
