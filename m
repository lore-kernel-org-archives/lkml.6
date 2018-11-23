Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB5BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C0A20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pkhwdu37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C0A20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502448AbeKWS3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502434AbeKWS3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:29:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA3F520685;
        Fri, 23 Nov 2018 07:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542959204;
        bh=lkmTIACJWOEitNlVTQ3iUvbczswidszbW1McyARDoUA=;
        h=Date:From:To:Cc:Subject:From;
        b=Pkhwdu37w+t1ZrBfz9JK6g7ASYJU2ISSgAF6oix/UL03qxduA4LnmAEHjWvV/+Ys1
         06i5uHcU0gFYJM+ywCR5yto2B/xQI9EOMpJZCdHHTLzMeeREBkIiI/qTrW25L4Twcx
         IRX6e4neprCitLltSSL/M6lMsFTy5fe5dWQvj/sM=
Date:   Fri, 23 Nov 2018 08:46:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.4
Message-ID: <20181123074642.GA11972@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.4 kernel.

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
 arch/x86/kernel/cpu/bugs.c                               |   57 +---------=
--
 drivers/net/dsa/microchip/ksz_common.c                   |   10 +-
 drivers/net/dsa/mv88e6xxx/global1.c                      |    2=20
 drivers/net/ethernet/broadcom/bcmsysport.c               |   15 +--
 drivers/net/ethernet/broadcom/genet/bcmgenet.c           |   13 +-
 drivers/net/ethernet/broadcom/tg3.c                      |   18 +++-
 drivers/net/ethernet/ibm/ibmvnic.c                       |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/en.h             |    1=20
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c        |    4=20
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c |    4=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |   37 ++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c    |   26 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c       |    3=20
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h       |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c          |   67 +++++++---=
-----
 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c     |   10 +-
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c    |    2=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c           |    1=20
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c          |    6 -
 drivers/net/phy/mdio-gpio.c                              |   10 +-
 drivers/net/phy/realtek.c                                |    2=20
 drivers/net/tun.c                                        |    6 +
 drivers/net/usb/smsc95xx.c                               |    9 ++
 include/net/sctp/sctp.h                                  |   12 ++
 include/uapi/linux/sctp.h                                |    3=20
 kernel/cpu.c                                             |   11 --
 net/core/dev.c                                           |    4=20
 net/core/flow_dissector.c                                |    4=20
 net/ipv4/inet_fragment.c                                 |   29 +++---
 net/ipv4/ip_tunnel_core.c                                |    2=20
 net/ipv4/tcp_input.c                                     |    1=20
 net/ipv6/route.c                                         |   14 +--
 net/l2tp/l2tp_core.c                                     |    9 --
 net/rxrpc/ar-internal.h                                  |    1=20
 net/rxrpc/call_event.c                                   |   18 +++-
 net/rxrpc/output.c                                       |   35 ++++++-
 net/sched/act_pedit.c                                    |    3=20
 net/sched/cls_flower.c                                   |   14 ++-
 net/sctp/output.c                                        |    3=20
 net/sctp/outqueue.c                                      |    2=20
 net/sctp/socket.c                                        |   26 +----
 net/sctp/stream.c                                        |    1=20
 net/tipc/discover.c                                      |   19 ++--
 net/tipc/link.c                                          |   11 +-
 net/tipc/net.c                                           |   45 ++++++++--
 net/tipc/net.h                                           |    2=20
 net/tipc/socket.c                                        |   15 ++-
 49 files changed, 355 insertions(+), 244 deletions(-)

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix clearing of stats counters

David Ahern (1):
      ipv6: Fix PMTU updates for UDP/raw sockets in presence of VRF

David Howells (1):
      rxrpc: Fix lockup due to no error backoff after ack transmit error

Davide Caratti (1):
      net/sched: act_pedit: fix memory leak when IDR allocation fails

Denis Drozdov (1):
      net/mlx5e: IPoIB, Reset QP after channels are closed

Doug Berger (1):
      net: bcmgenet: protect stop from timeout

Eric Dumazet (2):
      net-gro: reset skb->pkt_type in napi_reuse_skb()
      inet: frags: better deal with smp races

Florian Fainelli (1):
      net: systemport: Protect stop from timeout

Frieder Schrempf (1):
      usbnet: smsc95xx: disable carrier check while suspending

Greg Kroah-Hartman (2):
      Revert "x86/speculation: Enable cross-hyperthread spectre v2 STIBP mi=
tigation"
      Linux 4.19.4

Holger Hoffst=C3=A4tte (1):
      net: phy: realtek: fix RTL8201F sysfs name

Jakub Kicinski (1):
      net: sched: cls_flower: validate nested enc_opts_policy to avoid warn=
ing

Jon Maloy (3):
      tipc: don't assume linear buffer when reading ancillary data
      tipc: fix lockdep warning when reinitilaizing sockets
      tipc: fix link re-establish failure

Martin Schiller (1):
      net: phy: mdio-gpio: Fix working over slow can_sleep GPIOs

Matthew Cover (1):
      tuntap: fix multiqueue rx

Micha=C5=82 Miros=C5=82aw (1):
      ibmvnic: fix accelerated VLAN handling

Moshe Shemesh (1):
      net/mlx5e: RX, verify received packet size in Linear Striding RQ

Or Gerlitz (3):
      net/mlx5e: Don't match on vlan non-existence if ethertype is wildcard=
ed
      net/mlx5e: Claim TC hw offloads support only under a proper build con=
fig
      net/mlx5e: Always use the match level enum when parsing TC rule match

Raed Salem (1):
      net/mlx5: IPSec, Fix the SA context hash key

Sabrina Dubroca (1):
      ip_tunnel: don't force DF when MTU is locked

Shalom Toledo (1):
      mlxsw: spectrum: Fix IP2ME CPU policer configuration

Shay Agroskin (1):
      net/mlx5e: Removed unnecessary warnings in FEC caps query

Siva Reddy Kallam (1):
      tg3: Add PHY reset for 5717/5719/5720 in change ring and flow control=
 paths

Stefan Wahren (1):
      net: smsc95xx: Fix MTU range

Stephen Mallon (1):
      tcp: Fix SOF_TIMESTAMPING_RX_HARDWARE to use the latest timestamp dur=
ing TCP coalescing

Subash Abhinov Kasiviswanathan (1):
      net: qualcomm: rmnet: Fix incorrect assignment of real_dev

Tristram Ha (1):
      net: dsa: microchip: initialize mutex before use

Valentine Fatiev (1):
      net/mlx5e: Fix selftest for small MTUs

Xin Long (7):
      ipv6: fix a dst leak when removing its exception
      sctp: not allow to set asoc prsctp_enable by sockopt
      Revert "sctp: remove sctp_transport_pmtu_check"
      l2tp: fix a sock refcnt leak in l2tp_tunnel_register
      sctp: define SCTP_SS_DEFAULT for Stream schedulers
      sctp: fix strchange_flags name for Stream Change Event
      sctp: not increase stream's incnt before sending addstrm_in request

Yuval Avnery (1):
      net/mlx5e: Adjust to max number of channles when re-attaching

=EB=B0=B0=EC=84=9D=EC=A7=84 (1):
      flow_dissector: do not dissect l4 ports for fragments


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlv3sF8ACgkQONu9yGCS
aT58phAAoQRtMN4B6WWKspqWk2Zpwy69FLGpqrNkIx+vfZwiAifgw1HUSahKeDmX
IxJ+5yRDkaoKlMEQMPELoTyeaZG1AS4aB7Eh24u3t/t0ZAKd8eXSmzOFdB7657OX
RqmgCNM9he3ZqUkvR6VsS7y50n7LLQQYg4n2N6GcGZfI3sQtuWjL29QYpTZgj5yo
njGSvM6EeT/o+vyn0QPxVUmqObSLHQE4SYcU5Wz52ZeRi4OHJzgaI2bLJC4F2HNz
MDYib/IMg4t46WRuEwnBlNNDp3Thy1lfxv2AGZKrxzTMMqZcEbg76tlcmlYM5U/M
7SdvIHnluGGsn+jOAa9rxkoyhcqQMTjHrGm5EM3r40ES4vD2pDPYxAOLVoPoDKCg
/pfWcMPiOsB3lLsxvCCiTtE162ENqABqDdOIYB1GzUpE3348ulJAK5odXBwZU62X
JzPeqZ2GIHD7rcn3EBB8VIDuOhg5I+Vs19+osZwaeA7SzezTSyRJXHk8ChK0vD9f
wRYZC0dAAymJF6eQPoQ5w7ooIk10K/6+fEHTt8seGaa2wIWTuq/XF1m8CEWR8ie8
yyUEmtJJRdYRULHf9ff1CtUZqkFIwl9/y4VDZj5Lx2utbLSpolbOKCZW5MQx6nPh
hpfn0IqCl2ZrC8kEBXsE2Tj7/DIoiqz6Y4o9ZCBityJhCSqtRQQ=
=yVxL
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
