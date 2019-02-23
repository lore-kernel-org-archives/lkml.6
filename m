Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C91C10F07
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2AB20684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550917409;
	bh=EBgNUtrzJlkjdYrxQ0DzapsvERqDGiA9x2k4+YYKDO8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GNhh8TRqrSM3aBVNlYmcFL1ZgkLtdtj0bNsvK9EWkhJx6kF4k1VT2/RYFHcepkLoy
	 Ofn9QOp0MuEBjbYcrOsz5RiFZ14Wv0KYtvnESCHWkXJZ2fopFeVJ83G4oD/Ywr1vGr
	 g0gMS7mfzyqXKh6GQVtAQrMosRK7+3/Eq2+0eDYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfBWKX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfBWKX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:23:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B206420684;
        Sat, 23 Feb 2019 10:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550917406;
        bh=EBgNUtrzJlkjdYrxQ0DzapsvERqDGiA9x2k4+YYKDO8=;
        h=Date:From:To:Cc:Subject:From;
        b=SactKg/EvvldERnF1WwjXsEHgH10gbwR52swis9+iwHIMJutT7PCQbdKWe/54hS9n
         ctPdLU0dCTHpkqttibEpPEf6Xpi65ahJr6f1jl82yewgBRAPb8noi82JXe3puFtsgW
         md9SVdBm2T//K45WLElj4eUNno9A4tjTIT3JBjAA=
Date:   Sat, 23 Feb 2019 11:23:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.25
Message-ID: <20190223102323.GA23207@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.25 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
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
 drivers/mmc/host/meson-gx-mmc.c                      |    3 -
 drivers/net/dsa/mv88e6xxx/chip.c                     |   28 ++++++++--
 drivers/net/ethernet/marvell/sky2.c                  |    2=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c       |   12 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c   |    9 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c |   22 ++++----
 drivers/net/phy/xilinx_gmii2rgmii.c                  |    5 +
 drivers/net/vxlan.c                                  |   14 ++++-
 drivers/pci/pci.c                                    |    3 -
 drivers/target/target_core_transport.c               |    2=20
 drivers/vhost/vhost.c                                |    2=20
 include/linux/netdev_features.h                      |   24 ++++++++-
 include/net/ax25.h                                   |   12 ++++
 include/net/inetpeer.h                               |    1=20
 net/ax25/ax25_ip.c                                   |    4 -
 net/ax25/ax25_route.c                                |   19 +++----
 net/core/dev.c                                       |    4 -
 net/core/skbuff.c                                    |    4 +
 net/ipv4/inetpeer.c                                  |    1=20
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c          |    7 ++
 net/ipv4/route.c                                     |    7 +-
 net/ipv4/tcp.c                                       |    2=20
 net/ipv4/tcp_ipv4.c                                  |    7 +-
 net/ipv6/addrconf.c                                  |    3 -
 net/ipv6/ip6_gre.c                                   |   34 +++++++------
 net/packet/af_packet.c                               |    3 -
 net/sunrpc/auth_gss/gss_krb5_seqnum.c                |   49 ++++++++++++++=
-----
 net/vmw_vsock/vmci_transport.c                       |    4 +
 net/x25/af_x25.c                                     |    6 --
 33 files changed, 213 insertions(+), 92 deletions(-)

Alexander Duyck (1):
      net: Do not allocate page fragments that are not skb aligned

Alexandre Torgue (1):
      net: stmmac: handle endianness in dwmac4_get_timestamp

David S. Miller (1):
      net: Add header for usage of fls64()

Eric Dumazet (6):
      vxlan: test dev->flags & IFF_UP before calling netif_rx()
      tcp: clear icsk_backoff in tcp_write_queue_purge()
      tcp: tcp_v4_err() should be more careful
      net/x25: do not hold the cpu too long in x25_new_lci()
      mISDN: fix a race in dev_expire_timer()
      ax25: fix possible use-after-free

Greg Kroah-Hartman (1):
      Linux 4.19.25

Hauke Mehrtens (1):
      net: Fix for_each_netdev_feature on Big endian

Jann Horn (1):
      netfilter: nf_nat_snmp_basic: add missing length checks in ASN.1 cbs

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

Logan Gunthorpe (1):
      PCI: Fix __initdata issue with "pci=3Ddisable_acs_redir" parameter

Lorenzo Bianconi (2):
      net: ip6_gre: initialize erspan_ver just for erspan tunnels
      net: ipv4: use a dedicated counter for icmp_v4 redirect packets

Mao Wenan (1):
      net: crypto set sk to NULL when af_alg_release.

Martin Blumenstingl (1):
      mmc: meson-gx: fix interrupt name

Nicolas Dichtel (1):
      af_packet: fix raw sockets over 6in4 tunnel

Paolo Abeni (1):
      vsock: cope with memory allocation failure at socket creation time

Paul Kocialkowski (1):
      net: phy: xgmiitorgmii: Support generic PHY status read

Petr Machata (1):
      mlxsw: __mlxsw_sp_port_headroom_set(): Fix a use of local variable

Scott Mayhew (1):
      sunrpc: fix 4 more call sites that were using stack memory with a sca=
tterlist

Wei Yongjun (2):
      hwmon: (lm80) Fix missing unlock on error in set_fan_div()
      scsi: target/core: Use kmem_cache_free() instead of kfree()

Zhiqiang Liu (1):
      net: fix IPv6 prefix route residue


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxxHxsACgkQONu9yGCS
aT4TkhAAkgeq4sgnYc0tYhIQHh+xNjTvN9COGjimU/FKfsmRMb8dtI0W04vMBW24
zR1xyyZXF9jL0tMm2RACcxuPb7+q8uv+b/ageFGXdcrDw+kYvMxqhSP5YnViT26o
1qj14oEYKon2j9KTTsbT6usKSfuuL9ULNK87ixInfzMfvB4FUHAViqaB1/Tw82q4
Y94vx8BuRwpJ5xtfUht1KPFIpplE1QktexfZIFmgc2BqJhYw7pFanauuy5bfTgUJ
3b4HfVJ1xSES8WlUNvOb3Fuwp/TsAtPfPip5Pu1/m96pQIf1M1EgrbAlagvOGEaV
ntjF142q5UQ1edM1pW3AFevQFzgzX6NS5ql3tURVTfOR52hGUYUUBmhLu0ji2xfa
eQN5LTf24I/MH0QIa1cUle8ogIMyA2tvxjq8JiDYrRXCHWocsl7jDhL6+yiqGxRm
fR2gqVz9MwyrjL07yC8PIR2bId6yZcn+wQw8WaTZ8eowjJdMbc1+yZgV0pjHMhwJ
ajoL3LFF8Fb+UWx6TgfTWiks4tBgtYimJddOp7Dtwt0eXxEMhSdum6fXLKGbbIcE
NIZjZ/KX+HkHFoMayqReCtYYys+IAkGh7VXthrp5XEJNdPj5QfZ8wHkzqYJZV5Sm
4FqF7w/tEmW/wQdvoUYDGDSzseIrRW1RfcJBD0nMBBlC1R8apWs=
=Anml
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
