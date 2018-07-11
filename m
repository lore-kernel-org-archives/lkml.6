Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258FFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12CF20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12CF20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbeGKPvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:51:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732344AbeGKPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:51:14 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6BB3ED3B;
        Wed, 11 Jul 2018 15:46:17 +0000 (UTC)
Date:   Wed, 11 Jul 2018 17:46:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.112
Message-ID: <20180711154615.GA12556@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.112 kernel.

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
 arch/arm/boot/dts/imx6q.dtsi                     |    2=20
 arch/s390/kernel/entry.S                         |    4 -
 arch/x86/kernel/cpu/common.c                     |    7 +
 arch/x86/kernel/kprobes/core.c                   |   42 +++++------
 arch/x86/xen/smp.c                               |    5 +
 drivers/base/power/opp/core.c                    |    2=20
 drivers/block/drbd/drbd_worker.c                 |    2=20
 drivers/gpu/drm/udl/udl_fb.c                     |    5 +
 drivers/gpu/drm/udl/udl_transfer.c               |   11 +-
 drivers/hid/hid-debug.c                          |    8 +-
 drivers/hid/i2c-hid/i2c-hid.c                    |    2=20
 drivers/hid/usbhid/hiddev.c                      |   11 ++
 drivers/i2c/busses/i2c-rcar.c                    |    4 -
 drivers/infiniband/hw/hfi1/chip.c                |    8 +-
 drivers/infiniband/hw/hfi1/file_ops.c            |    2=20
 drivers/infiniband/hw/hfi1/init.c                |    9 +-
 drivers/md/dm-bufio.c                            |   31 ++++----
 drivers/media/i2c/cx25840/cx25840-core.c         |   28 +++++--
 drivers/mtd/chips/cfi_cmdset_0002.c              |   30 +++++---
 drivers/mtd/nand/mxc_nand.c                      |    5 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c   |    6 -
 drivers/net/phy/micrel.c                         |   17 ----
 drivers/scsi/sg.c                                |   42 ++++++++++-
 drivers/staging/android/ion/ion_heap.c           |    2=20
 drivers/staging/comedi/drivers/quatech_daqp_cs.c |    2=20
 drivers/tty/n_tty.c                              |   55 ++++++++------
 drivers/tty/vt/vt.c                              |    4 -
 drivers/usb/class/cdc-acm.c                      |    3=20
 drivers/usb/dwc2/hcd_queue.c                     |    2=20
 drivers/usb/serial/cp210x.c                      |   14 +++
 fs/cifs/cifssmb.c                                |   10 ++
 fs/cifs/smb2pdu.c                                |   18 +++-
 fs/ext4/balloc.c                                 |   21 +++--
 fs/ext4/ext4.h                                   |    5 -
 fs/ext4/ext4_extents.h                           |    1=20
 fs/ext4/extents.c                                |    6 +
 fs/ext4/ialloc.c                                 |   14 +++
 fs/ext4/inline.c                                 |    1=20
 fs/ext4/inode.c                                  |    7 +
 fs/ext4/mballoc.c                                |    6 +
 fs/ext4/super.c                                  |   86 ++++++++++++++++++=
+----
 fs/jbd2/transaction.c                            |    9 ++
 kernel/trace/trace_functions_graph.c             |    5 +
 mm/hugetlb.c                                     |    1=20
 mm/page_alloc.c                                  |    1=20
 net/ipv4/fib_semantics.c                         |    2=20
 net/ipv6/sit.c                                   |    1=20
 net/netfilter/nf_log.c                           |    9 +-
 net/netfilter/nf_tables_core.c                   |    3=20
 scripts/Kbuild.include                           |    5 -
 tools/build/Build.include                        |    5 -
 tools/objtool/Makefile                           |    2=20
 tools/scripts/Makefile.include                   |    2=20
 54 files changed, 407 insertions(+), 180 deletions(-)

Alexander Potapenko (1):
      vt: prevent leaking uninitialized data to userspace via /dev/vcs*

Andy Lutomirski (1):
      x86/cpu: Re-apply forced caps every time CPU caps are re-read

Ben Hutchings (1):
      ipv4: Fix error return value in fib_convert_metrics()

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

David S. Miller (1):
      Revert "sit: reload iphdr in ipip6_rcv"

Douglas Anderson (1):
      dm bufio: avoid sleeping while holding the dm_bufio lock

Greg Kroah-Hartman (1):
      Linux 4.9.112

Grygorii Strashko (1):
      net: phy: micrel: fix crash when statistic requested for KSZ9031 phy

Gustavo A. R. Silva (1):
      HID: hiddev: fix potential Spectre v1

Houston Yaroschoff (1):
      usb: cdc_acm: Add quirk for Uniden UBC125 scanner

Ido Schimmel (1):
      mlxsw: spectrum: Forbid linking of VLAN devices to devices that have =
uppers

Jann Horn (2):
      scsi: sg: mitigate read/write abuse
      netfilter: nf_log: don't hold nf_log_mutex during user access

Jason Andryuk (1):
      HID: i2c-hid: Fix "incomplete report" noise

Johan Hovold (1):
      USB: serial: cp210x: add CESINEL device ids

Jon Derrick (1):
      ext4: check superblock mapped prior to committing

Juergen Gross (1):
      x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths

Karoly Pados (1):
      USB: serial: cp210x: add Silicon Labs IDs for Windows Update

Lars Ellenberg (1):
      drbd: fix access after free

Laura Abbott (1):
      staging: android: ion: Return an ERR_PTR in ion_map_kernel

Martin Kaiser (1):
      mtd: rawnand: mxc: set spare area size register explicitly

Masami Hiramatsu (1):
      kprobes/x86: Do not modify singlestep buffer while resuming

Mike Marciniszyn (1):
      IB/hfi1: Fix user context tail allocation for DMA_RTAIL

Mikulas Patocka (3):
      drm/udl: fix display corruption of the last line
      dm bufio: drop the lock when doing GFP_NOIO allocation
      dm bufio: don't take the lock in dm_bufio_shrink_count

Paulo Alcantara (1):
      cifs: Fix infinite loop when using hard mount option

Rasmus Villemoes (1):
      Kbuild: fix # escaping in .cmd files for future Make

Sean Nyekjaer (1):
      ARM: dts: imx6q: Use correct SDMA script for SPI5 core

Taehee Yoo (1):
      netfilter: nf_tables: use WARN_ON_ONCE instead of BUG_ON in nft_do_ch=
ain()

Tetsuo Handa (2):
      n_tty: Fix stall at n_tty_receive_char_special().
      n_tty: Access echo_* variables carefully.

Theodore Ts'o (9):
      jbd2: don't mark block as modified if the handle is out of credits
      ext4: make sure bitmaps and the inode table don't overlap with bg des=
criptors
      ext4: always check block group bounds in ext4_init_block_bitmap()
      ext4: only look at the bg_flags field if it is valid
      ext4: verify the depth of extent tree in ext4_find_extent()
      ext4: include the illegal physical block in the bad map ext4_error msg
      ext4: clear i_data in ext4_inode_info when removing inline data
      ext4: add more inode number paranoia checks
      ext4: add more mount time checks of the superblock

Tokunori Ikegami (3):
      mtd: cfi_cmdset_0002: Change definition naming to retry write operati=
on
      mtd: cfi_cmdset_0002: Change erase functions to retry for error
      mtd: cfi_cmdset_0002: Change erase functions to check chip good only

Vlastimil Babka (1):
      mm, page_alloc: do not break __GFP_THISNODE by zonelist reset

Waldemar Rymarkiewicz (1):
      PM / OPP: Update voltage in case freq =3D=3D old_freq

William Wu (1):
      usb: dwc2: fix the incorrect bitmaps for the ports of multi_tt hub

Wolfram Sang (1):
      i2c: rcar: fix resume by always initializing registers before transfer


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltGJkYACgkQONu9yGCS
aT6CuBAAoXWXU6Yu5RS3bUsU96uVfxVr3cTAFo5ZqfoktIg4CdRuJ96sqaaV3bq9
b8MqY7OWyF69t9KqbY6ofzsphxmjIURE9jeNiVuQl+WmZjPYX8qFnHho2M+3Igdt
LnOkMNpgRSRScXrszyXM1IFj3T5WCcOvIz4MOB3b4ihYYUDytoz7jyEL8MUD9zrX
0Y3wCiW0/iESypnApiM+GZr48FpJ8K94lKeNQBQpwqH5CAGDEv57/o96gHs5KelM
hV7T6IUMEjcxU+FZzurzV++vzU8aK4xPULEJRlxlibW4ZcjsVRfzhScSEy/UaE6X
pX7o3BFTE/TEoQ/6S4ezILoJXz+Gi04cVGBM04sHXa5wr5RIWzkI25xLJjIjXryJ
thryCpK0RTFqBJS0bLrKcVgUAKlt0KbM604nbHUwwu9Ukj1dzZTU2rPRWEwlon6s
nvyYAkdnkTEi4HU3JuV9XxjVwdMIyj9UQe+V3o8axggoc4oNLH6qGNGjjur3oFeY
K/RDLnjx/uijTwQuTH9Jo8j+TQ+hfw91z0mc02N6S7+XDj5ftQaoa5YEuKNW+gtx
S8L0OE8oWYxwyDX2eqOQzd5bYHeoR2vYW2sTqLYf7nCYVsMe5E1EkPWlRgrYTQVm
tavAuX2kxcAAtwBPthgccntR8FOAwPZZy2f8sb1nwumDujOw0OA=
=UehR
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
