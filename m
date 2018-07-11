Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF59C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34E220C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34E220C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389360AbeGKPuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:50:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49602 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732665AbeGKPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:50:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 02534D40;
        Wed, 11 Jul 2018 15:45:01 +0000 (UTC)
Date:   Wed, 11 Jul 2018 17:44:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.115
Message-ID: <20180711154459.GA9699@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.115 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                 |    2=20
 arch/x86/lib/cmdline.c                   |   34 ++++++++---
 drivers/atm/zatm.c                       |    4 -
 drivers/hid/hid-debug.c                  |    8 ++
 drivers/hid/i2c-hid/i2c-hid.c            |    2=20
 drivers/md/dm-bufio.c                    |   15 ++++-
 drivers/media/i2c/cx25840/cx25840-core.c |   28 +++++++--
 drivers/mtd/chips/cfi_cmdset_0002.c      |   30 +++++++---
 drivers/mtd/nand/mxc_nand.c              |    5 +
 drivers/mtd/ubi/eba.c                    |   92 ++++++++++++++++++++++++++=
++++-
 drivers/net/ethernet/natsemi/sonic.c     |    2=20
 drivers/net/usb/qmi_wwan.c               |    1=20
 drivers/scsi/sg.c                        |   42 +++++++++++++-
 drivers/staging/android/ion/ion_heap.c   |    2=20
 drivers/tty/n_tty.c                      |   13 ++--
 fs/cifs/cifssmb.c                        |   10 ++-
 fs/cifs/smb2pdu.c                        |   18 ++++--
 fs/ext4/inline.c                         |    1=20
 fs/ext4/super.c                          |   62 +++++++++++++++++---
 net/bridge/netfilter/ebtables.c          |    3 -
 net/netfilter/nf_log.c                   |    9 ++-
 21 files changed, 317 insertions(+), 66 deletions(-)

Brad Love (1):
      media: cx25840: Use subdev host data for PLL override

Daniel Rosenberg (1):
      HID: debug: check length before copy_to_user()

Dave Hansen (1):
      x86/boot: Fix early command-line parsing when matching at end

Douglas Anderson (1):
      dm bufio: avoid sleeping while holding the dm_bufio lock

Finn Thain (1):
      net/sonic: Use dma_mapping_error()

Greg Kroah-Hartman (1):
      Linux 3.18.115

Ivan Bornyakov (1):
      atm: zatm: fix memcmp casting

Jann Horn (2):
      scsi: sg: mitigate read/write abuse
      netfilter: nf_log: don't hold nf_log_mutex during user access

Jason Andryuk (1):
      HID: i2c-hid: Fix "incomplete report" noise

Josh Hill (1):
      net: qmi_wwan: Add Netgear Aircard 779S

Laura Abbott (1):
      staging: android: ion: Return an ERR_PTR in ion_map_kernel

Martin Kaiser (1):
      mtd: rawnand: mxc: set spare area size register explicitly

Mikulas Patocka (1):
      dm bufio: drop the lock when doing GFP_NOIO allocation

Paolo Abeni (1):
      netfilter: ebtables: handle string from userspace with care

Paulo Alcantara (1):
      cifs: Fix infinite loop when using hard mount option

Richard Weinberger (1):
      ubi: fastmap: Correctly handle interrupted erasures in EBA

Tetsuo Handa (1):
      n_tty: Fix stall at n_tty_receive_char_special().

Theodore Ts'o (3):
      ext4: make sure bitmaps and the inode table don't overlap with bg des=
criptors
      ext4: clear i_data in ext4_inode_info when removing inline data
      ext4: add more mount time checks of the superblock

Tokunori Ikegami (3):
      mtd: cfi_cmdset_0002: Change definition naming to retry write operati=
on
      mtd: cfi_cmdset_0002: Change erase functions to retry for error
      mtd: cfi_cmdset_0002: Change erase functions to check chip good only


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltGJfcACgkQONu9yGCS
aT54GQ//bIAeF6kMsLZze29eFaUQVVvta3AxTW2EDA5gxCdcU8HQRuaVeCjWH61r
9V69OCjR7Iyh2Y8YTOnJlklqo4Pb9karTWhfv/J68vVRikIJvj8Sf5tS7cLLaVOE
WqrGP5Tn3by0oLczT4GDz2H9wtyDOphTCSJ9Lj0zS9oHYomA25yMTg9poXkF3Tpi
5ttIrnJX1r7QXR+rXf/a+5nxHhqxt2cYgNWWO1D2wMA+pOdHrQ5r+1mRELwM6Org
tsvhm2efqyNuQP0IwX0W2SxQgZClWisG8hzuldIWrUAReOpD2RNnaFj6EdhvYPUd
/txE4d0qzztM8YlrccY0DaIJwgewh/l1oYf0hoWKOvCdI3zs9LMlIVq5Pe56URXc
APgr3Rp0yxO+d2kg4EJKj0d38JHjkGNpKX3Zx8ZDW/GXy9o1YUidTbW0c3+FvPDS
XVfXHSUNXVHfooEDnsKaZWWrnwM0LUSm/KdJbsdVsLVTq/bXZpnF2uHS65lb+dgT
/dgYSH6aQL2dCYoZ4hw861AEE+tISZ+9xlHyVMS4jMbqJLa/ghgr6xUnkABrO5qF
Cx0QFhwMwtUPbHeitoUb193i8hAgHBkUZsf+BgPp5oHUii6a/PGEHa9UihmxFLos
KDkglOpQ4eOWY9Fgv6d3iAz4rw38ZXSE4o+2bP1B83+zWJxkDsg=
=WYfv
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
