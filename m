Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD6DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F79320C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F79320C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbeGKPvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:51:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbeGKPvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:51:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17F27D3B;
        Wed, 11 Jul 2018 15:46:41 +0000 (UTC)
Date:   Wed, 11 Jul 2018 17:46:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.55
Message-ID: <20180711154639.GA13393@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.55 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                         |    2=20
 arch/s390/kernel/entry.S                         |    4=20
 block/blk-lib.c                                  |  108 +++++++++++++++---=
-----
 drivers/block/drbd/drbd_worker.c                 |    2=20
 drivers/dax/super.c                              |   42 +++++---
 drivers/gpu/drm/drm_property.c                   |    6 -
 drivers/gpu/drm/udl/udl_fb.c                     |    5 -
 drivers/gpu/drm/udl/udl_transfer.c               |   11 +-
 drivers/hid/hid-debug.c                          |    8 +
 drivers/hid/i2c-hid/i2c-hid.c                    |    2=20
 drivers/hid/usbhid/hiddev.c                      |   11 ++
 drivers/md/dm-table.c                            |    9 +
 drivers/md/dm.c                                  |    6 -
 drivers/media/i2c/cx25840/cx25840-core.c         |   28 ++++-
 drivers/media/v4l2-core/videobuf2-core.c         |    9 +
 drivers/mtd/chips/cfi_cmdset_0002.c              |   30 ++++--
 drivers/mtd/nand/mxc_nand.c                      |    5 -
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   |    2=20
 drivers/scsi/sg.c                                |   42 ++++++++
 drivers/staging/comedi/drivers/quatech_daqp_cs.c |    2=20
 drivers/target/target_core_pr.c                  |   15 ++-
 drivers/vfio/vfio_iommu_type1.c                  |   16 +--
 fs/cifs/cifsglob.h                               |    1=20
 fs/cifs/cifsproto.h                              |    1=20
 fs/cifs/cifssmb.c                                |   10 +-
 fs/cifs/connect.c                                |    8 +
 fs/cifs/smb1ops.c                                |    1=20
 fs/cifs/smb2ops.c                                |    3=20
 fs/cifs/smb2pdu.c                                |   25 +++--
 fs/cifs/smb2transport.c                          |    1=20
 fs/cifs/transport.c                              |   18 +++
 fs/ext2/super.c                                  |    3=20
 fs/ext4/balloc.c                                 |   21 ++--
 fs/ext4/ext4.h                                   |    8 -
 fs/ext4/ext4_extents.h                           |    1=20
 fs/ext4/extents.c                                |    6 +
 fs/ext4/ialloc.c                                 |   14 ++
 fs/ext4/inline.c                                 |   39 --------
 fs/ext4/inode.c                                  |    7 -
 fs/ext4/mballoc.c                                |    6 -
 fs/ext4/super.c                                  |   89 +++++++++++++++---
 fs/ext4/xattr.c                                  |   40 +++-----
 fs/f2fs/file.c                                   |    9 +
 fs/jbd2/transaction.c                            |    9 +
 fs/userfaultfd.c                                 |   12 +-
 fs/xfs/xfs_ioctl.c                               |    3=20
 fs/xfs/xfs_iops.c                                |   30 +++++-
 fs/xfs/xfs_super.c                               |   10 +-
 include/linux/dax.h                              |   11 +-
 include/linux/mm.h                               |    1=20
 include/trace/events/sched.h                     |    4=20
 kernel/irq/irqdesc.c                             |    6 -
 kernel/trace/trace_functions_graph.c             |    5 -
 mm/hugetlb.c                                     |    1=20
 mm/memory-failure.c                              |   16 +++
 mm/vmstat.c                                      |    2=20
 net/netfilter/nf_log.c                           |    9 +
 scripts/Kbuild.include                           |    5 -
 tools/build/Build.include                        |    5 -
 tools/objtool/Makefile                           |    2=20
 tools/scripts/Makefile.include                   |    2=20
 61 files changed, 555 insertions(+), 254 deletions(-)

Brad Love (1):
      media: cx25840: Use subdev host data for PLL override

Cannon Matthews (1):
      mm: hugetlb: yield when prepping struct pages

Changbin Du (1):
      tracing: Fix missing return symbol in function_graph output

Christian Borntraeger (1):
      s390: Correct register corruption in critical section cleanup

Dan Carpenter (1):
      staging: comedi: quatech_daqp_cs: fix no-op loop daqp_ao_insn_write()

Daniel Rosenberg (1):
      HID: debug: check length before copy_to_user()

Darrick J. Wong (1):
      fs: allow per-device dax status checking for filesystems

Dave Jiang (1):
      dax: change bdev_dax_supported() to support boolean returns

David Disseldorp (1):
      scsi: target: Fix truncated PR-in ReadKeys response

Greg Kroah-Hartman (2):
      Revert "dpaa_eth: fix error in dpaa_remove()"
      Linux 4.14.55

Gustavo A. R. Silva (1):
      HID: hiddev: fix potential Spectre v1

Ilya Dryomov (2):
      block: factor out __blkdev_issue_zero_pages()
      block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()

Jaegeuk Kim (1):
      f2fs: truncate preallocated blocks in error case

Jann Horn (2):
      scsi: sg: mitigate read/write abuse
      netfilter: nf_log: don't hold nf_log_mutex during user access

Janosch Frank (1):
      userfaultfd: hugetlbfs: fix userfaultfd_huge_must_wait() pte access

Jason Andryuk (1):
      HID: i2c-hid: Fix "incomplete report" noise

Jason Gunthorpe (1):
      vfio: Use get_user_pages_longterm correctly

Jon Derrick (1):
      ext4: check superblock mapped prior to committing

Lars Ellenberg (1):
      drbd: fix access after free

Lars Persson (1):
      cifs: Fix use after free of a mid_q_entry

Martin Kaiser (1):
      mtd: rawnand: mxc: set spare area size register explicitly

Michel D=E4nzer (1):
      drm: Use kvzalloc for allocating blob property memory

Mike Snitzer (1):
      dm: set QUEUE_FLAG_DAX accordingly in dm_table_set_restrictions()

Mikulas Patocka (1):
      drm/udl: fix display corruption of the last line

Naoya Horiguchi (1):
      mm: hwpoison: disable memory error handling on 1GB hugepage

Paulo Alcantara (2):
      cifs: Fix memory leak in smb2_set_ea()
      cifs: Fix infinite loop when using hard mount option

Rakib Mullick (1):
      irq/core: Fix boot crash when the irqaffinity=3D boot parameter is pa=
ssed on CPUMASK_OFFSTACK=3Dy kernels(v1)

Rasmus Villemoes (1):
      Kbuild: fix # escaping in .cmd files for future Make

Ross Zwisler (2):
      dax: check for QUEUE_FLAG_DAX in bdev_dax_supported()
      dm: prevent DAX mounts if not supported

Sakari Ailus (1):
      media: vb2: core: Finish buffers at the end of the stream

Sebastian Andrzej Siewior (2):
      sched, tracing: Fix trace_sched_pi_setprio() for deboosting
      Revert mm/vmstat.c: fix vmstat_update() preemption BUG

Stefano Brivio (1):
      cifs: Fix slab-out-of-bounds in send_set_info() on SMB2 ACE setting

Theodore Ts'o (13):
      jbd2: don't mark block as modified if the handle is out of credits
      ext4: add corruption check in ext4_xattr_set_entry()
      ext4: always verify the magic number in xattr blocks
      ext4: make sure bitmaps and the inode table don't overlap with bg des=
criptors
      ext4: always check block group bounds in ext4_init_block_bitmap()
      ext4: only look at the bg_flags field if it is valid
      ext4: verify the depth of extent tree in ext4_find_extent()
      ext4: include the illegal physical block in the bad map ext4_error msg
      ext4: clear i_data in ext4_inode_info when removing inline data
      ext4: never move the system.data xattr out of the inode body
      ext4: avoid running out of journal credits when appending to an inlin=
e file
      ext4: add more inode number paranoia checks
      ext4: add more mount time checks of the superblock

Tokunori Ikegami (3):
      mtd: cfi_cmdset_0002: Change definition naming to retry write operati=
on
      mtd: cfi_cmdset_0002: Change erase functions to retry for error
      mtd: cfi_cmdset_0002: Change erase functions to check chip good only


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltGJl4ACgkQONu9yGCS
aT57LBAAhBFAzN+lTkEXvQbDJo/xL6UzymL0Vf1LP6vlEpNiKpid0Zs1ySnoyGip
wpI4WEeybvzMt2CM7vdjET9gS8l8essDbDKPBVudxvdrUue4Pxif6Qx11lI+nULD
qR8gfUziBwdsoo8zuZZxUF4yWQvibrIg4JCa4z+oDPcpBo5QXknE2XRMUXfr0T1S
POHFMCb5Ct3t+wrOrJiEb8EowKX6++Px3igNOU0i35uy6BzU8k+B8+7RpevIGxFw
bOFZDEHPoi9IyCo2XIvqZTnsLLsrbzVBsWr3vN06E2Ea89nm6A2HhQYpOHe7wvmo
MO9Xg+ad2k9gdlikrbvAbTaf6imJlCAlnOQZlS2UzeaD1PWDqcfF5WiNevuvieh7
37Jok2cnSFSV1liuHi6ZXVCAyE+bs2q1cb0LejawXCvMVgx+on5c4qopJSEBiSCa
QSdSdm1NaHODXljD6u02pxf3UqXf6VulGQcIOi7ey/n1WisF6fN1Flle8kVv/MN6
lzZIRiRimqh9lPSmvE0NkabXSMAIf5Y/nfSIIdnWVvA3YEtdDs+gKeB915y93/4C
ZzMAG+y3oNhLZzxQWIEtgTiUscWYgoWXfLDozzaSahcSt0BJY1JmAzcu/TSTtJkz
5ABqG0W0kdFHzUAdVv/keVhMWZRv+zMAstiZZnqCDyqf8p06ZiI=
=rFcI
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
