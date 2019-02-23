Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251CCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8A720684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550917374;
	bh=gkEobrhVQwNwhnEvBO/YGCpdZGPHpxiPpmcI8plSzeU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ZSk+x6uf8a0owuVwF/iFrryGklHAjo94Jpb9pIc7GZmz7NCvLwVRSk5i01AVng4oL
	 PROfAoc4Aag+x0u3J58cgnB0tgD1ncFGA4uZnGIdSh6TBb8oMfx7u66Lr7W9g0MK+N
	 +/jBrMBMYuHfziR/Cl8yNtpqEgZ2SC66Qci8RK9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfBWKWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:22:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfBWKWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:22:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF21D20684;
        Sat, 23 Feb 2019 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550917371;
        bh=gkEobrhVQwNwhnEvBO/YGCpdZGPHpxiPpmcI8plSzeU=;
        h=Date:From:To:Cc:Subject:From;
        b=HHKYUB8nEdMQqwpdO13Lgl0WVqgjRnWshD49aW//Fz5tMfclq2elyl/QvbnW5JlSq
         LGDbDWCJIuybBN87Krq1TBfmqmWuMCMCcWBqzo1ESKRNdYwmm4O8evIlXpYbuROiGL
         mmNl8jSpdVsCvegFcUy2ffGyqp/wCsPV9poqEHwM=
Date:   Sat, 23 Feb 2019 11:22:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.103
Message-ID: <20190223102248.GA20382@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.103 kernel.

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

 Makefile                                             |    2=20
 crypto/af_alg.c                                      |    4 +
 drivers/hwmon/lm80.c                                 |    4 +
 drivers/isdn/mISDN/timerdev.c                        |    2=20
 drivers/net/dsa/mv88e6xxx/chip.c                     |   28 ++++++++--
 drivers/net/ethernet/marvell/sky2.c                  |    2=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c       |   12 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c   |    9 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c |   22 ++++----
 drivers/net/phy/xilinx_gmii2rgmii.c                  |    5 +
 drivers/net/vxlan.c                                  |   14 ++++-
 drivers/vhost/vhost.c                                |    2=20
 include/linux/netdev_features.h                      |   24 ++++++++-
 include/net/ax25.h                                   |   12 ++++
 include/net/inetpeer.h                               |    1=20
 include/net/tcp.h                                    |    1=20
 net/ax25/ax25_ip.c                                   |    4 -
 net/ax25/ax25_route.c                                |   19 +++----
 net/core/dev.c                                       |    4 -
 net/core/skbuff.c                                    |    4 +
 net/ipv4/inetpeer.c                                  |    1=20
 net/ipv4/route.c                                     |    7 +-
 net/ipv4/tcp.c                                       |    1=20
 net/ipv4/tcp_ipv4.c                                  |    7 +-
 net/ipv6/addrconf.c                                  |    3 -
 net/sunrpc/auth_gss/gss_krb5_seqnum.c                |   49 ++++++++++++++=
-----
 net/vmw_vsock/vmci_transport.c                       |    4 +
 net/x25/af_x25.c                                     |    6 --
 28 files changed, 180 insertions(+), 73 deletions(-)

Alexander Duyck (1):
      net: Do not allocate page fragments that are not skb aligned

Alexandre Torgue (1):
      net: stmmac: handle endianness in dwmac4_get_timestamp

David S. Miller (1):
      net: Add header for usage of fls64()

Eric Dumazet (6):
      vxlan: test dev->flags & IFF_UP before calling netif_rx()
      tcp: tcp_v4_err() should be more careful
      tcp: clear icsk_backoff in tcp_write_queue_purge()
      net/x25: do not hold the cpu too long in x25_new_lci()
      mISDN: fix a race in dev_expire_timer()
      ax25: fix possible use-after-free

Greg Kroah-Hartman (1):
      Linux 4.14.103

Hauke Mehrtens (1):
      net: Fix for_each_netdev_feature on Big endian

Jason Wang (1):
      vhost: correctly check the return value of translate_desc() in log_us=
ed()

John David Anglin (1):
      dsa: mv88e6xxx: Ensure all pending interrupts are handled prior to ex=
it

Jose Abreu (1):
      net: stmmac: Fix a race in EEE enable callback

Kai-Heng Feng (1):
      sky2: Increase D3 delay again

Lorenzo Bianconi (1):
      net: ipv4: use a dedicated counter for icmp_v4 redirect packets

Mao Wenan (1):
      net: crypto set sk to NULL when af_alg_release.

Paolo Abeni (1):
      vsock: cope with memory allocation failure at socket creation time

Paul Kocialkowski (1):
      net: phy: xgmiitorgmii: Support generic PHY status read

Petr Machata (1):
      mlxsw: __mlxsw_sp_port_headroom_set(): Fix a use of local variable

Scott Mayhew (1):
      sunrpc: fix 4 more call sites that were using stack memory with a sca=
tterlist

Wei Yongjun (1):
      hwmon: (lm80) Fix missing unlock on error in set_fan_div()

Zhiqiang Liu (1):
      net: fix IPv6 prefix route residue


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxxHvgACgkQONu9yGCS
aT5zxw/+Phu7QwnB8uVFkdoBEVNvDmXsp4LYmzmu3aqrei0dOjcIcAW053D/5UVO
ksnTLsLYLgPig73rjoeMvI1f2zTpp+Ou6fC9lVwfmbfN5Ozgz6eq+YBqZb9Afj6O
HrsnPCcEoHt0qsfYcBYlgJQHnzfEs+uiDAP31TT8j7S00wtR3lwtK5cvjkWGBCbw
GGfnUTmPi4763wUhuJBL25rep78jnXMbyniZPT37ckDtoimOT/47MzrVvCC4KUsn
K6F10g9tyBowa8ZdELMDZCOoRiR2bVVlr0xJdvNJQ4u3EF0Nt0P59M2lWXJwYHCI
UZcIkWSmcF06Xt/poFe4H0l0ahIrs8ICm8726aqhwQR/N4aktDqFAg57MJpbKHTk
klePROyE9JHdkllugyk1jmNCbJhjXsGGEjJu8OCFBAgSn8evPxmfsUtWKLiJwX2I
rMCVVObHKK0Scf4WWxdfxSJz7sLIvANVmMghLvpm1qzZVXV0N5fK8ZfrNbGHDzK3
gVSoT9oxmg70l1pVs8zZ+2DPFuZsWSmvJDxOiCVyPeaG5Ixme5PM4A0f8A00FrDQ
owz0LIxwK0h19uCTnfx1uBeG74byUVt6ZUA7CSbkzqhq60IOgN9gCkH50UQadfXC
a2+SaazWNAEfvvLwgE5GVyJVVKKx8L7g6dxbfk9OHntZF/9oBCo=
=OwPe
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
