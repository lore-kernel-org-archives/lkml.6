Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E08C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE21C20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE21C20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbeGKPuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:50:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732665AbeGKPuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:50:22 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C9CFBD40;
        Wed, 11 Jul 2018 15:45:24 +0000 (UTC)
Date:   Wed, 11 Jul 2018 17:45:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.140
Message-ID: <20180711154522.GA10573@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.140 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                         |    2=20
 arch/arm/boot/dts/imx6q.dtsi                     |    2=20
 arch/s390/kernel/entry.S                         |    4 -
 arch/x86/kernel/cpu/mcheck/mce.c                 |   51 ++++++++----
 arch/x86/kernel/kprobes/core.c                   |   42 +++++-----
 arch/x86/lib/cmdline.c                           |   34 ++++++--
 drivers/block/drbd/drbd_worker.c                 |    2=20
 drivers/hid/hid-debug.c                          |    8 +-
 drivers/hid/i2c-hid/i2c-hid.c                    |    2=20
 drivers/hid/usbhid/hiddev.c                      |   11 ++
 drivers/i2c/busses/i2c-rcar.c                    |    3=20
 drivers/md/dm-bufio.c                            |   31 ++++---
 drivers/media/i2c/cx25840/cx25840-core.c         |   28 +++++--
 drivers/mtd/chips/cfi_cmdset_0002.c              |   30 +++++--
 drivers/mtd/nand/mxc_nand.c                      |    5 +
 drivers/mtd/ubi/eba.c                            |   92 ++++++++++++++++++=
++++-
 drivers/net/wireless/ath/ath10k/htt_rx.c         |    5 -
 drivers/nvme/host/pci.c                          |    4 -
 drivers/scsi/sg.c                                |   42 ++++++++++
 drivers/staging/android/ion/ion_heap.c           |    2=20
 drivers/staging/comedi/drivers/quatech_daqp_cs.c |    2=20
 drivers/tty/n_tty.c                              |   55 ++++++++-----
 drivers/usb/class/cdc-acm.c                      |    3=20
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
---
 fs/jbd2/transaction.c                            |    9 ++
 kernel/trace/trace_functions_graph.c             |    5 +
 mm/hugetlb.c                                     |    1=20
 mm/page_alloc.c                                  |    2=20
 net/ipv4/fib_semantics.c                         |    2=20
 net/netfilter/nf_log.c                           |    9 +-
 net/netfilter/nf_tables_core.c                   |    3=20
 42 files changed, 512 insertions(+), 168 deletions(-)

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

Dave Hansen (1):
      x86/boot: Fix early command-line parsing when matching at end

Douglas Anderson (1):
      dm bufio: avoid sleeping while holding the dm_bufio lock

Greg Kroah-Hartman (1):
      Linux 4.4.140

Gustavo A. R. Silva (1):
      HID: hiddev: fix potential Spectre v1

Houston Yaroschoff (1):
      usb: cdc_acm: Add quirk for Uniden UBC125 scanner

Jann Horn (2):
      scsi: sg: mitigate read/write abuse
      netfilter: nf_log: don't hold nf_log_mutex during user access

Jason Andryuk (1):
      HID: i2c-hid: Fix "incomplete report" noise

Johan Hovold (1):
      USB: serial: cp210x: add CESINEL device ids

Jon Derrick (1):
      ext4: check superblock mapped prior to committing

Karoly Pados (1):
      USB: serial: cp210x: add Silicon Labs IDs for Windows Update

Keith Busch (1):
      nvme-pci: initialize queue memory before interrupts

Lars Ellenberg (1):
      drbd: fix access after free

Laura Abbott (1):
      staging: android: ion: Return an ERR_PTR in ion_map_kernel

Martin Kaiser (1):
      mtd: rawnand: mxc: set spare area size register explicitly

Masami Hiramatsu (1):
      kprobes/x86: Do not modify singlestep buffer while resuming

Mikulas Patocka (2):
      dm bufio: drop the lock when doing GFP_NOIO allocation
      dm bufio: don't take the lock in dm_bufio_shrink_count

Paulo Alcantara (1):
      cifs: Fix infinite loop when using hard mount option

Richard Weinberger (1):
      ubi: fastmap: Correctly handle interrupted erasures in EBA

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

Tony Luck (1):
      x86/mce: Fix incorrect "Machine check from unknown source" message

Vasanthakumar Thiagarajan (1):
      ath10k: fix rfc1042 header retrieval in QCA4019 with eth decap mode

Vlastimil Babka (1):
      mm, page_alloc: do not break __GFP_THISNODE by zonelist reset

Wolfram Sang (1):
      i2c: rcar: fix resume by always initializing registers before transfer

Yazen Ghannam (1):
      x86/mce: Detect local MCEs properly


--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltGJhEACgkQONu9yGCS
aT4vUg//RseDn3227NqEpErXmTPNqLB7DeABRZyD3utEinFsS+7vv60WMXC5+3jF
xDUiDvXHzYNvUZ3PxV1pqjC0vC2Jj54P8LF9/x9eOcqOTYuZtMbQlDs/Xpdpi5CQ
KTj01tsyxXW6Ps6YzvfYPGIHG23KWAxK5Yx+OlgPsZqb0+/UFHDzfL99C4BgnYdh
c4OBA7bLcy25CMNgrZ5ZAP5IZLnlMpoDhqdJzRFSMTn/pTBG1vp+2rVAJfuY/sOn
bI9uVLDymG+6Is9d2AtJkATAAAmEWiOjRDFEHRR72hatmQ1eXwa7oOjT3RmiNHAZ
cmbIhyJ1GNDsrVcky4SvHA86ayujWtxvWdNKjnRDCjUAc9kiY7Y++uku1HNENMGj
sEuaodKA/5yaEgNEligoTcW4XGhW4AvHx6lXsidR4MpYZYYTiNVXSulnwzZWZTEi
X3i48qWcMIbS4rDoUmxsx3xxNgQ/KtBPEgbAWW6SuWefmoEiGmtyvvmNjUJoVGz7
r43jKT1JlQ6ntXFNm2AaGRW8xvTc2nxGRp2S308F+WDIrhvcOjr4M7T5MSlH9h/i
vl8EXVYHT2iF2w5kRWuqxh3cH0E9/t1Wk22pdGJ/V02ZGkeiQwd2Vqio6C2FVuJQ
0C8Zi6L9BXVG1V8BP4Ogpim4CXlCxcmpIwArdrZDyY8xzVNEVLE=
=rW+C
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
