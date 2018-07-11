Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC5F20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC5F20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389464AbeGKPwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:52:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51736 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732412AbeGKPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:52:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B56B9D02;
        Wed, 11 Jul 2018 15:47:03 +0000 (UTC)
Date:   Wed, 11 Jul 2018 17:47:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.6
Message-ID: <20180711154700.GA14298@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.6 kernel.

All users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                         |    2=20
 arch/arm/boot/dts/am3517.dtsi                    |    4=20
 arch/arm/boot/dts/dra7.dtsi                      |    2=20
 arch/arm/boot/dts/imx51-zii-rdu1.dts             |    2=20
 arch/s390/kernel/entry.S                         |    4=20
 drivers/acpi/acpica/uterror.c                    |    6 -
 drivers/acpi/battery.c                           |    9 -
 drivers/block/drbd/drbd_worker.c                 |    2=20
 drivers/dax/super.c                              |   48 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |   46 +-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c         |  131 ++++++++++++++++++=
-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |    6 +
 drivers/gpu/drm/drm_property.c                   |    6 -
 drivers/gpu/drm/udl/udl_fb.c                     |    5=20
 drivers/gpu/drm/udl/udl_transfer.c               |   11 +
 drivers/hid/hid-core.c                           |    5=20
 drivers/hid/hid-debug.c                          |    8 +
 drivers/hid/i2c-hid/i2c-hid.c                    |    2=20
 drivers/hid/usbhid/hiddev.c                      |   11 +
 drivers/i2c/i2c-core-smbus.c                     |   12 +-
 drivers/md/dm-table.c                            |    7 -
 drivers/md/dm.c                                  |    3=20
 drivers/mtd/chips/cfi_cmdset_0002.c              |   30 +++--
 drivers/pci/pci-acpi.c                           |   12 ++
 drivers/scsi/aacraid/aachba.c                    |   15 +-
 drivers/scsi/sg.c                                |   42 +++++++
 drivers/staging/comedi/drivers/quatech_daqp_cs.c |    2=20
 drivers/target/target_core_pr.c                  |   15 +-
 drivers/vfio/vfio_iommu_type1.c                  |   16 +-
 fs/cifs/cifsglob.h                               |    1=20
 fs/cifs/cifsproto.h                              |    1=20
 fs/cifs/cifssmb.c                                |   10 +
 fs/cifs/connect.c                                |    8 +
 fs/cifs/smb1ops.c                                |    1=20
 fs/cifs/smb2ops.c                                |    3=20
 fs/cifs/smb2pdu.c                                |   25 ++--
 fs/cifs/smb2transport.c                          |    1=20
 fs/cifs/transport.c                              |   18 ++-
 fs/ext2/super.c                                  |    3=20
 fs/ext4/balloc.c                                 |   21 ++-
 fs/ext4/ext4.h                                   |    8 -
 fs/ext4/ext4_extents.h                           |    1=20
 fs/ext4/extents.c                                |    6 +
 fs/ext4/ialloc.c                                 |   14 ++
 fs/ext4/inline.c                                 |   39 ------
 fs/ext4/inode.c                                  |    7 -
 fs/ext4/mballoc.c                                |    6 -
 fs/ext4/super.c                                  |   89 +++++++++++++--
 fs/ext4/xattr.c                                  |   40 +++----
 fs/jbd2/transaction.c                            |    9 +
 fs/userfaultfd.c                                 |   12 +-
 fs/xfs/xfs_ioctl.c                               |    3=20
 fs/xfs/xfs_iops.c                                |   30 ++++-
 fs/xfs/xfs_super.c                               |   10 +
 include/linux/dax.h                              |   11 +
 include/linux/hid.h                              |    3=20
 kernel/trace/trace_events_hist.c                 |    2=20
 kernel/trace/trace_functions_graph.c             |    5=20
 mm/debug.c                                       |   18 ++-
 mm/hugetlb.c                                     |    1=20
 mm/vmstat.c                                      |    2=20
 net/netfilter/nf_log.c                           |    9 +
 62 files changed, 595 insertions(+), 286 deletions(-)

Adam Ford (1):
      ARM: dts: omap3: Fix am3517 mdio and emac clock references

Arnd Bergmann (1):
      tracing: Avoid string overflow

Benjamin Tissoires (1):
      HID: core: allow concurrent registration of drivers

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

Greg Kroah-Hartman (1):
      Linux 4.17.6

Gustavo A. R. Silva (1):
      HID: hiddev: fix potential Spectre v1

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

Jouke Witteveen (1):
      ACPI / battery: Safe unregistering of hooks

Lars Ellenberg (1):
      drbd: fix access after free

Lars Persson (1):
      cifs: Fix use after free of a mid_q_entry

Lyude Paul (3):
      drm/amdgpu: Make struct amdgpu_atif private to amdgpu_acpi.c
      drm/amdgpu: Add amdgpu_atpx_get_dhandle()
      drm/amdgpu: Dynamically probe for ATIF handle (v2)

Michel D=E4nzer (1):
      drm: Use kvzalloc for allocating blob property memory

Mikulas Patocka (1):
      drm/udl: fix display corruption of the last line

Nick Dyer (1):
      ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl

Paulo Alcantara (2):
      cifs: Fix memory leak in smb2_set_ea()
      cifs: Fix infinite loop when using hard mount option

Pavel Tatashin (1):
      mm: teach dump_page() to correctly output poisoned struct pages

Peter Rosin (1):
      i2c: smbus: kill memory leak on emulated and failed DMA SMBus xfers

Rafael J. Wysocki (2):
      PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM
      ACPICA: Drop leading newlines from error messages

Raghava Aditya Renukunta (1):
      scsi: aacraid: Fix PD performance regression over incorrect qd being =
set

Roger Quadros (1):
      ARM: dts: dra7: Disable metastability workaround for USB2

Ross Zwisler (2):
      dax: check for QUEUE_FLAG_DAX in bdev_dax_supported()
      dm: prevent DAX mounts if not supported

Sebastian Andrzej Siewior (1):
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

Wenwen Wang (1):
      i2c: core: smbus: fix a potential missing-check bug


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltGJnMACgkQONu9yGCS
aT5jlw//dkUQTSZ/74fJ5WqgOIUTkMCQykwMZKKqdVghXyanjaOno4zFbk+0JgS6
DlyCU6OTkjwgM3G/4E+sjMY5hIdQ8ILlRmN0SWZ3Uu0+Uk89R951vwpz44UyxFbc
rPSL+oSxSTnjDkQQORGjyhh5Qs5xeyJXzU+LvucTVqeFaWUPelltAs7zu4tfDObZ
dZjrZ5//yZa2zWsxZYFaruKLkaVBcnm74cP0hctNcJobIgbCAxP3wTkd2I/aVIZB
9DkBCeaXf23eSb99ajBB2i9lCpQVio82KRcWMeYPiuzwMcelooB5NEnfggMBf4ma
zKRgbUSLTRDUHQhZ+RgWZ30Sj1H5WHgoZi9ltUfnkv12HMrZAE+GNJ6QLcE6rIZH
PcO0K7fc/aZe0jMXh6K8VhQjJEYvqwIHhQ4Z1ux35DYzn7/z/CjPOcDbO/byc17f
l5HkTB//viOe9rkiWzW+k2TaGOQm9Z8zmIji0cixs9n8wCqDqZlwBQFL7Y50nmk3
NCbBO6iQARb+zY8IjMDLVAL62iaRRu5dRHQIrP9Fnfkf3tuTN47rERxm18U2Y89q
jmZosL8Hb9uXQcKdo8IClOC8LxHvbMYJRoB/zlZQRzqYn7i/0rokf2zacB5oN5NT
8OmzBUKz7c9Cow6UsU5+tw8C/ZPc+oaTQtd0Q9FUsaIJJ34T5wY=
=4qs4
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
