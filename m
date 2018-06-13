Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7B2CCC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238BF208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg5iPoKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238BF208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935851AbeFMOxL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935183AbeFMOxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:53:09 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A8F208B3;
        Wed, 13 Jun 2018 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528901589;
        bh=gvmvNGYLpQNBxc/l+Ns8J5sEZLIG7O79eE1hecH/dPM=;
        h=Date:From:To:Cc:Subject:From;
        b=Xg5iPoKMP63hhmJSkAuItgNbXsZ00AGx4BHeNhou2gr+huHu198kqrclQcL9br47Q
         cDZnlCRTCtVcAFLXE4E5xkJInkBd9maopq58mVQQQdZ5X+UuX/K0QXCIZcR6LZAIfm
         qQjau+fxb7j+5Kk90l0diTomWgg1QDX5jIBIMMag=
Date:   Wed, 13 Jun 2018 16:52:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.137
Message-ID: <20180613145247.GA10487@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.137 kernel.

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

 Documentation/networking/netdev-FAQ.txt            |    9 +++++
 Makefile                                           |    2 -
 drivers/char/tpm/tpm-chip.c                        |   13 ++++++++
 drivers/char/tpm/tpm-interface.c                   |    7 ++++
 drivers/char/tpm/tpm.h                             |    1=20
 drivers/gpu/drm/drm_fops.c                         |    1=20
 drivers/isdn/hardware/eicon/diva.c                 |   22 +++++++++-----
 drivers/isdn/hardware/eicon/diva.h                 |    5 +--
 drivers/isdn/hardware/eicon/divasmain.c            |   18 +++++++----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c   |    2 -
 drivers/net/ethernet/cisco/enic/enic_main.c        |    8 ++---
 drivers/net/ethernet/mellanox/mlx4/qp.c            |    4 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |    2 -
 drivers/net/phy/bcm-cygnus.c                       |    6 +--
 drivers/net/phy/bcm-phy-lib.h                      |    7 ++++
 drivers/net/phy/bcm7xxx.c                          |    4 +-
 drivers/net/team/team.c                            |    3 +
 drivers/net/usb/cdc_mbim.c                         |    2 -
 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c |    2 -
 fs/xfs/xfs_log.c                                   |    7 ----
 mm/mmap.c                                          |   32 ++++++++++++++++=
+++++
 net/core/rtnetlink.c                               |    8 ++---
 net/dccp/proto.c                                   |    2 -
 net/ipv4/fib_semantics.c                           |    2 +
 net/ipv4/ip_sockglue.c                             |    2 -
 net/ipv6/ip6mr.c                                   |    3 +
 net/packet/af_packet.c                             |    4 +-
 scripts/kconfig/confdata.c                         |    2 -
 28 files changed, 128 insertions(+), 52 deletions(-)

Alexey Kodanev (1):
      dccp: don't free ccid2_hc_tx_sock struct in dccp_disconnect()

Amir Goldstein (1):
      xfs: fix incorrect log_flushed on fsync

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
      Linux 4.4.137

Jack Morgenstein (1):
      net/mlx4: Fix irq-unsafe spinlock usage

Julia Lawall (1):
      bnx2x: use the right constant

Linus Torvalds (2):
      mmap: introduce sane default mmap limits
      mmap: relax file size limit for regular files

Nathan Chancellor (1):
      kconfig: Avoid format overflow warning from GCC 8.1

Sabrina Dubroca (1):
      ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succ=
eeds

Shahed Shaikh (1):
      qed: Fix mask for physical address in ILT entry

Stefan Wahren (1):
      brcmfmac: Fix check for ISO3166 code

Wenwen Wang (1):
      isdn: eicon: fix a missing-check bug

Willem de Bruijn (2):
      ipv4: remove warning in ip_recv_error
      packet: fix reserve calculation


--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlshL78ACgkQONu9yGCS
aT6KQg/+Kq7f+NBRZ/+f+JOW/Uy5Zl090vQ7+NmdkNIUwG49BRk9uCN1JshITBwO
0mJI3E0glkeBAxh3vjxU7vLRulFjHqZXagArIJMGVdYi4ZxmTwcKU5iDuazSK8j4
JkmJNKMiAbfVXw9RDKDwHyztlx8oNe66ub6M0Qq1xx7KmF9ATakppQdcF4Qh1Bma
eBFkTUvwNxsF3+kgFqwV4OZ+H4XcukXsRv+o6Iq960NwXJoALYm9FCQLeaL2WIMA
SDJN5fyKqA/mqURLpUKaciOMF7sJd9f/ReNZrx6oNTU8QbKyUWjsrHp9GoIGKshq
PbkaC6dwqIXgT1ekoSDE650jf8u64GahFCugZNRpQ1UdO2md9ZtvH1k3amlNAV+O
CRUh2yabfwe5JTtFe/u6fMRKBZPMJnJo1f/RR09o4fnhANisHODwyLdLL3qNjt2Q
ChWVWB0peB0cdWFI7JupAuQKTDyiUErNqy3yljuuHPDkoNKZEm5xp4m64+ebzGYP
PLX0JVnj1RO/nc+S21HGTcHadcuIAFbKsuQWdu5Vagm0q6TvLPCeTOfbX3n+f70S
HspFAjf4yCrPZrT1QBtVxneJ3gNx2xlT94bVCCTAz8e2pWhCd3WNYSXJiu2CAmQu
eiVwjcXH+JppHngpKRQwO7gw/byJDlRAqcED4j8o/Zg30Ts7NLQ=
=orCZ
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
