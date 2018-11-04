Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1CAC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDB0204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIQwKceB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDB0204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbeKDXyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:54:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbeKDXyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:54:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E73204FD;
        Sun,  4 Nov 2018 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541342337;
        bh=bgN1jrfXIxJsRMNIyEuPQZVE7xdPEuPTzVoXQdzYHr8=;
        h=Date:From:To:Cc:Subject:From;
        b=QIQwKceBZxmnOUlQCply7Lw488T92MtjC2NHKlqSjZMn2LnQaGeap326sxBKKI5tW
         dL8SAjtKEV5bEkEgsrBGe4sf+EvmfD0e9i0D2Xh+2MN0+9/JixB2S3MPPuLQRH00/y
         iqMOqouKLePZTb1cHivNBbr3rrIRpESsQ2bx/XX8=
Date:   Sun, 4 Nov 2018 15:38:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.1
Message-ID: <20181104143854.GA30505@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.1 kernel.

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

 Makefile                                                 |    2=20
 arch/sparc/include/asm/switch_to_64.h                    |    3 -
 arch/sparc/kernel/process_64.c                           |   25 ++++++--
 arch/sparc/kernel/rtrap_64.S                             |    1=20
 arch/sparc/kernel/signal32.c                             |   12 +++-
 arch/sparc/kernel/signal_64.c                            |    6 +-
 arch/sparc/kernel/systbls_64.S                           |    4 -
 arch/sparc/mm/init_64.c                                  |    1=20
 crypto/af_alg.c                                          |    2=20
 drivers/net/bonding/bond_netlink.c                       |    3 -
 drivers/net/ethernet/emulex/benet/be.h                   |    1=20
 drivers/net/ethernet/emulex/benet/be_main.c              |    6 --
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          |   45 +++-------=
-----
 drivers/net/ethernet/mellanox/mlxsw/core.c               |   24 +++++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |    2=20
 drivers/net/ethernet/realtek/r8169.c                     |    9 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c        |    2=20
 drivers/vhost/vhost.c                                    |    2=20
 include/net/sock.h                                       |   12 +++-
 net/atm/common.c                                         |    2=20
 net/bridge/br_multicast.c                                |    9 ++-
 net/caif/caif_socket.c                                   |    2=20
 net/core/datagram.c                                      |    7 +-
 net/core/dev.c                                           |    1=20
 net/core/rtnetlink.c                                     |   10 +++
 net/dccp/proto.c                                         |    2=20
 net/ipv4/ip_fragment.c                                   |   12 ++--
 net/ipv4/tcp.c                                           |    2=20
 net/ipv4/udp.c                                           |   20 ++++++
 net/ipv6/ip6_checksum.c                                  |   20 ++++++
 net/ipv6/ndisc.c                                         |    3 -
 net/ipv6/route.c                                         |    2=20
 net/iucv/af_iucv.c                                       |    2=20
 net/nfc/llcp_sock.c                                      |    2=20
 net/openvswitch/flow_netlink.c                           |    4 -
 net/rxrpc/af_rxrpc.c                                     |    2=20
 net/sched/sch_gred.c                                     |    2=20
 net/sctp/socket.c                                        |    8 +-
 net/smc/af_smc.c                                         |    2=20
 net/smc/smc_core.c                                       |   25 ++++----
 net/tipc/socket.c                                        |    2=20
 net/unix/af_unix.c                                       |    4 -
 tools/testing/selftests/net/fib-onlink-tests.sh          |   14 ++--
 43 files changed, 199 insertions(+), 122 deletions(-)

Cong Wang (1):
      net: drop skb on failure in ip_check_defrag()

David Ahern (1):
      net/ipv6: Allow onlink routes to have a device mismatch if it is the =
default route

David Miller (1):
      sparc64: Make corrupted user stacks more debuggable.

David S. Miller (3):
      net: Properly unlink GRO packets on overflow.
      sparc64: Export __node_distance.
      sparc64: Wire up compat getpeername and getsockname.

Eric Dumazet (1):
      net/mlx5e: fix csum adjustments caused by RXFCS

Greg Kroah-Hartman (1):
      Linux 4.19.1

Hangbin Liu (1):
      bridge: do not add port to router list when receives query with sourc=
e 0.0.0.0

Heiner Kallweit (1):
      r8169: fix broken Wake-on-LAN from S5 (poweroff)

Ido Schimmel (1):
      rtnetlink: Disallow FDB configuration for non-Ethernet device

Ivan Vecera (1):
      Revert "be2net: remove desc field from be_eq_obj"

Jaime Caama=F1o Ruiz (1):
      openvswitch: Fix push/pop ethernet validation

Jakub Kicinski (1):
      net: sched: gred: pass the right attribute to gred_change_table_def()

Jason Wang (1):
      vhost: Fix Spectre V1 vulnerability

Karsten Graul (2):
      Revert "net: simplify sock_poll_wait"
      net/smc: fix smc_buf_unuse to use the lgr pointer

Niklas Cassel (1):
      net: stmmac: Fix stmmac_mdio_reset() when building stmmac as modules

Nikolay Aleksandrov (1):
      net: bridge: remove ipv6 zero address check in mcast queries

Petr Machata (1):
      mlxsw: spectrum_switchdev: Don't ignore deletions of learned MACs

Sean Tranchetti (1):
      net: udp: fix handling of CHECKSUM_COMPLETE packets

Shalom Toledo (1):
      mlxsw: core: Fix devlink unregister flow

Stefano Brivio (1):
      ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers a=
re called

Tobias Jungel (1):
      bonding: fix length of actor system

Xin Long (1):
      sctp: check policy more carefully when getting pr status


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvfBHwACgkQONu9yGCS
aT4IkRAAv5WkGLy7A9NFdaC46Xkx+vF0ZGgCPfaJB2SqK7seAcyU3sZAivk6QMQK
mVlaJXlXj+P9mFj4uDEtECJBj/HwAeH2RKbpzmvJbATgLKYN6FmqpHxSrykYF0XV
Wvngy9U6RZ/qTaqnLKwqsr8LM4GyzP1NBjB2BGlslQZkZCeROy5o6SQTVnxVGQgr
0BGzXWATfBcqNnrqPdxoHNzdb5EfAaU0oeCt8FGM9eXwC2i+xOYMs2UlttafiDy5
y6T6DTv9YVNSk+VKnYUGz2h3uarcN5QmhxYtZ6eoIbvDCXrOKCT9sXObZHyC6Scf
pSHWqRRJofzh6KGNtzdbH2G04IKmYVlH49fTF4O9D/QoygqA8834OnL6Sr1JfJq0
Jfa90aNBk3acOHhTQOmakO1G1L7v7FhK+V1TBQHLC5EQtcYy2ecKR7eF2rZImopo
+rONyHqIPFQ+TJXvUGZg67A48qhgjJmLKXyTExVXcFwWbBGtBimTgc/7zsSRHS9T
6b3QjC7U/5V1hIfdR6VhjhJzuvbN5QBDgjdVDXROr/2TdO1ZJoHTbWs7DqAByGGe
tymY/ZGXddBDQdxwAo4YndstHuzk353PE+fC6/DKG8Q8akgZuFImT+ZBz+jPZ8y5
hGxcNYZoaARcdpQznuZoduqrEvk6AhpR+ruKoEx8jISj3Hpy/Ao=
=lKo9
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
