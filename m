Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CC575C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794B8208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4pY+5OA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794B8208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935914AbeFMOxn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935680AbeFMOxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:53:41 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85026208B0;
        Wed, 13 Jun 2018 14:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528901621;
        bh=mtdCBirO/LyT8p4qkhHKOw/y11BUUo4E8SReCnMGQuM=;
        h=Date:From:To:Cc:Subject:From;
        b=q4pY+5OAipI6YL7+WPt1vEhKGTfNZj0jTfZCRywOLDpWQ7lqDKXueWqapoxqqgHx2
         YHf48RiBRKUUF0vMpjhDDvy7P6WVAgxnoaa5+FvwcvhIaTWW8clK0vGl5ulHcIvZE6
         WqFEBFOWBGXY4jT9zFZdYp6m2IpyrKea0Yg6e0jM=
Date:   Wed, 13 Jun 2018 16:53:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.108
Message-ID: <20180613145318.GA14208@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.108 kernel.

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

 Documentation/networking/netdev-FAQ.txt          |    9 ++++++
 Makefile                                         |    2 -
 arch/x86/kernel/vmlinux.lds.S                    |    2 -
 arch/x86/kvm/cpuid.h                             |    2 -
 drivers/char/tpm/tpm-chip.c                      |   13 +++++++++
 drivers/char/tpm/tpm-interface.c                 |    7 +++++
 drivers/char/tpm/tpm.h                           |    1=20
 drivers/gpu/drm/drm_fops.c                       |    1=20
 drivers/isdn/hardware/eicon/diva.c               |   22 ++++++++++-----
 drivers/isdn/hardware/eicon/diva.h               |    5 ++-
 drivers/isdn/hardware/eicon/divasmain.c          |   18 +++++++-----
 drivers/md/dm-bufio.c                            |   17 +++++-------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c |    2 -
 drivers/net/ethernet/cisco/enic/enic_main.c      |    8 ++---
 drivers/net/ethernet/mellanox/mlx4/qp.c          |    4 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c        |    2 -
 drivers/net/phy/bcm-cygnus.c                     |    6 ++--
 drivers/net/phy/bcm-phy-lib.h                    |    7 +++++
 drivers/net/phy/bcm7xxx.c                        |    4 +-
 drivers/net/team/team.c                          |    3 +-
 drivers/net/usb/cdc_mbim.c                       |    2 -
 drivers/vhost/vhost.c                            |    3 ++
 fs/btrfs/disk-io.c                               |    3 +-
 include/linux/compiler-gcc.h                     |    2 -
 include/uapi/linux/btrfs_tree.h                  |    1=20
 mm/mmap.c                                        |   32 ++++++++++++++++++=
+++++
 net/core/rtnetlink.c                             |    8 ++---
 net/dccp/proto.c                                 |    2 -
 net/ipv4/fib_semantics.c                         |    2 +
 net/ipv4/ip_sockglue.c                           |    2 -
 net/ipv6/ip6_output.c                            |    3 +-
 net/ipv6/ip6mr.c                                 |    3 +-
 net/ipv6/ndisc.c                                 |    6 ++++
 net/kcm/kcmsock.c                                |    2 -
 net/packet/af_packet.c                           |    4 +-
 net/sctp/transport.c                             |    2 -
 scripts/Makefile.build                           |    3 ++
 scripts/kconfig/confdata.c                       |    2 -
 38 files changed, 155 insertions(+), 62 deletions(-)

Alexey Kodanev (1):
      dccp: don't free ccid2_hc_tx_sock struct in dccp_disconnect()

Anand Jain (1):
      btrfs: define SUPER_FLAG_METADUMP_V2

Arnd Bergmann (1):
      dm bufio: avoid false-positive Wmaybe-uninitialized warning

Ben Hutchings (1):
      KVM: VMX: Expose SSBD properly to guests, 4.9 supplement

Chris Chiu (1):
      tpm: self test failure should not cause suspend to fail

Cong Wang (1):
      netdev-FAQ: clarify DaveM's position for stable backports

Dan Carpenter (1):
      team: use netdev_features_t instead of u32

Daniele Palmas (1):
      net: usb: cdc_mbim: add flag FLAG_SEND_ZLP

Dave Airlie (1):
      drm: set FMODE_UNSIGNED_OFFSET for drm files

Enric Balletbo i Serra (1):
      tpm: do not suspend/resume if power stays on

Eric Dumazet (3):
      net/packet: refine check for priv area size
      rtnetlink: validate attributes in do_setlink()
      net: metrics: add proper netlink validation

Florian Fainelli (1):
      net: phy: broadcom: Fix bcm_write_exp()

Govindarajulu Varadarajan (1):
      enic: set DMA mask to 47 bit

Greg Kroah-Hartman (1):
      Linux 4.9.108

Jack Morgenstein (1):
      net/mlx4: Fix irq-unsafe spinlock usage

Jason Wang (1):
      vhost: synchronize IOTLB message with dev cleanup

Josh Poimboeuf (1):
      objtool: Fix gcov check for older versions of GCC

Julia Lawall (1):
      bnx2x: use the right constant

Kirill Tkhai (1):
      kcm: Fix use-after-free caused by clonned sockets

Linus Torvalds (2):
      mmap: introduce sane default mmap limits
      mmap: relax file size limit for regular files

Nathan Chancellor (1):
      kconfig: Avoid format overflow warning from GCC 8.1

Philip M=FCller (1):
      complete e390f9a port for v4.9.106

Sabrina Dubroca (1):
      ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succ=
eeds

Shahed Shaikh (1):
      qed: Fix mask for physical address in ILT entry

Stephen Suryaputra (1):
      vrf: check the original netdevice for generating redirect

Wenwen Wang (1):
      isdn: eicon: fix a missing-check bug

Willem de Bruijn (2):
      ipv4: remove warning in ip_recv_error
      packet: fix reserve calculation

Xin Long (1):
      sctp: not allow transport timeout value less than HZ/5 for hb_timer


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlshL94ACgkQONu9yGCS
aT6/yBAAoGgFDLCHNJoCQWo+ATOHqLg5AJL+reXhPrIdzOSEoVsSqTeGNFuZsmG/
fFZHad7FgwSNR78iJDJE/evDu4s7Y+crStv0hG5l8YCZs3GWnfo+TcmEKHHLFW2K
b5YWD3DNYl0Zr2i3RVmI7bviDTnFUcWiGgE04TYUHO2sF59iAmYjdDEWboOi/D6A
vsDGj7mYYaomV/HFUcIr59mOTvtu2JU1FTF5pSJ/+kO96nk1QVl28b1INzz+OB4G
4YwWZjs0zhW9yheUv5gDRYIqgRQR3y0HiTnCN+dpvgZBTy+lYzIoaicBztV65NCu
xNZ27D0TY1x6CVyqodUPGKVDaZ/o+g0iuVms+tYrEwYgUNrGNOOdJ40z77QC/bhS
G4cBdlCDN/8Y15QpsqtZvU2YmWAUqxtsWuATu6zKOwPJ/R4Ln1Dk/p1SYHWALaWG
Ew5GpRt1cpiMS5MbIMnh+WBaHBHxvp49tSS9WwimXeFyc3CMUBhGFYEtbCYsVyTv
oXLk1iG9M72hXQVlnwLuD5Jnum5sSAyExhqhgVifVVgBGto6SPI+fqUNGmFUjA8q
wrE84M85ar359MBAZEa48uK5HTRbFQrv5UCZu2l2Mm1/1dW/iVBKyOshGXf8dMgJ
jVJR3tpRkYsZ47vvUGyFzpExaB3qvF240dtv2nkS05gICT1jxr4=
=ZTsL
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
