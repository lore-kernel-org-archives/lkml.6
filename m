Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5207FC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C098219E8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C098219E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbeHFRPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:15:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeHFRPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:15:49 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7D075C8A;
        Mon,  6 Aug 2018 15:06:17 +0000 (UTC)
Date:   Mon, 6 Aug 2018 17:06:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.118
Message-ID: <20180806150614.GA12005@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.118 kernel.

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

 Makefile                                          |    2=20
 arch/x86/kvm/vmx.c                                |    7 +--
 drivers/crypto/padlock-aes.c                      |    8 ++-
 drivers/gpu/drm/vc4/vc4_plane.c                   |    3 +
 drivers/net/bonding/bond_main.c                   |   14 +++++-
 drivers/net/can/usb/ems_usb.c                     |    1=20
 drivers/net/ethernet/amazon/ena/ena_com.c         |    1=20
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c         |    4 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    2=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c  |   40 +++++++++++++++++-
 drivers/net/phy/mdio-mux-bcm-iproc.c              |    2=20
 drivers/net/usb/lan78xx.c                         |    2=20
 drivers/net/xen-netfront.c                        |    6 ++
 drivers/pinctrl/intel/pinctrl-intel.c             |    7 ++-
 drivers/scsi/sg.c                                 |    1=20
 drivers/virtio/virtio_balloon.c                   |    2=20
 fs/squashfs/block.c                               |    2=20
 fs/squashfs/fragment.c                            |   13 ++++-
 fs/squashfs/squashfs_fs_sb.h                      |    1=20
 fs/squashfs/super.c                               |    5 +-
 include/net/tcp.h                                 |    2=20
 kernel/sched/swait.c                              |    6 --
 net/dsa/slave.c                                   |    6 ++
 net/ipv4/fib_frontend.c                           |    4 -
 net/ipv4/inet_fragment.c                          |   10 ++--
 net/ipv4/ip_fragment.c                            |    5 ++
 net/ipv4/tcp_bbr.c                                |    4 +
 net/ipv4/tcp_dctcp.c                              |    4 -
 net/ipv4/tcp_input.c                              |   48 +++++++++++------=
-----
 net/netlink/af_netlink.c                          |    2=20
 net/socket.c                                      |    2=20
 31 files changed, 155 insertions(+), 61 deletions(-)

Andy Shevchenko (1):
      pinctrl: intel: Read back TX buffer state

Anton Vasilyev (2):
      net: mdio-mux: bcm-iproc: fix wrong getter and setter pair
      can: ems_usb: Fix memory leak on ems_usb_disconnect()

Boqun Feng (1):
      sched/wait: Remove the lockless swait_active() check in swake_up*()

Boris Brezillon (1):
      drm/vc4: Reset ->{x, y}_scaling[1] when dealing with uniplanar formats

Eric Dumazet (7):
      tcp: do not force quickack when receiving out-of-order packets
      tcp: add max_quickacks param to tcp_incr_quickack and tcp_enter_quick=
ack_mode
      tcp: do not aggressively quick ack after ECN events
      tcp: add one more quick ack after after ECN events
      bonding: avoid lockdep confusion in bond_get_stats()
      inet: frag: enforce memory limits earlier
      ipv4: frags: handle possible skb truesize change

Eugeniy Paltsev (1):
      NET: stmmac: align DMA stuff to largest cache line length

Florian Fainelli (1):
      net: dsa: Do not suspend/resume closed slave_dev

Gal Pressman (1):
      net: ena: Fix use of uninitialized DMA address bits field

Greg Kroah-Hartman (1):
      Linux 4.9.118

Herbert Xu (1):
      crypto: padlock-aes - Fix Nano workaround data corruption

Jeremy Cline (2):
      netlink: Fix spectre v1 gadget in netlink_create()
      net: socket: fix potential spectre v1 gadget in socketcall

Jiang Biao (1):
      virtio_balloon: fix another race between migration and ballooning

Jose Abreu (1):
      net: stmmac: Fix WoL for PCI-based setups

Linus Torvalds (2):
      squashfs: more metadata hardening
      squashfs: more metadata hardenings

Lorenzo Bianconi (1):
      ipv4: remove BUG_ON() from fib_compute_spec_dst

Neal Cardwell (1):
      tcp_bbr: fix bw probing to raise in-flight data for very small BDPs

Roman Kagan (1):
      kvm: x86: vmx: fix vpid leak

Stefan Wahren (1):
      net: lan78xx: fix rx handling before first packet is send

Tony Battersby (1):
      scsi: sg: fix minor memory leak in error path

Xiao Liang (1):
      xen-netfront: wait xenbus state change when load module manually

Yousuk Seung (1):
      tcp: refactor tcp_ecn_check_ce to remove sk type cast

tangpengpeng (1):
      net: fix amd-xgbe flow-control issue


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltoY+YACgkQONu9yGCS
aT4LLA//Z93hfvgQwj0S+X+dqaO4xYZd8wVNYtH4EH2q7WF+Yv/ubAb479+RQC8F
J8TEgoHTGspPUHtQQavCtSfmVVbpbTORMgWlrGA/4lAZCPWFDBmIBXOYT8FwUVmx
4TBCIHRBK0EM6InsacbldcxX8DFnbsx5+KpxEUiaLxzNSv2aoMDoy6D7Bd3G+lhk
RJv1ZirItHK+i8Uwdh/xWVI6cVhpHQ4KExTE6pZ3upHlTb36lpB4HLwxYmpRnUlb
39io3BWj6m5MpKcxYidvlpcTgKJkn/8A02/asI1ZlfnGuw2N27ICdhW62zvH/oeK
UdNgp/mFvP34Uu1gpUBlwkHcbs20BdrxC26E39cwz5pS901jy3UF3SU0pL1zL9Nh
cGmor1WkTblU4gYRA4CQ2WS+seBvTn9sP/sdlTgnTiIv9IOSNPlqkv/G6D+q3dQ8
WE4ZSlyosRXNZz9+U71jk9BcGP2H0ClMycGyd2uYU25eAE936fGg5r/lfBC8ETDN
79ZzoqxZjF3ubKl/qrLEaxmoK6rFZRXDiGf7UVpFVxHIIysQJZc02qSqcmELFgem
ji/1pBsWrKBoFPJSDIGhexOOPu5YZkvARi1jCxe4nNqHR3Wr+Eq8WRFb9Wtm9rT3
vde6sq5Jj/ATGuECJ2n98PainN/F7KMVCgMAMvq3qup/z3y+oeE=
=g1pl
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
