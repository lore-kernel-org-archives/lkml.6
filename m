Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2068237-1522512947-2-13488323202040522029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522512947; b=QPBsKYxvwrYBySJg71TCXo0WLoDscmdptb8+ViEYwuyFokK0i+
    M+t6eTR/1G/76iWH+yxs0p84d4cPkEtC4MsuSusPI7kGDAobJuT6yvspjtlT1426
    TCDnyaiZpcR5+yRZu17oWq+uAD4OMIgJ8U2JZWWY0thbCRqeUBpmB1Wev2o1yC6o
    yueNP8d6MnlxGv/M7L32EJvdMkzfUxkdbq9xH9s3w1PNlAEFnGBKLiIeCIyhRTd3
    6gbOhyjZ+T25er/TxIz9zTsAK2M4ww/ilMhh6w6Jq72kdhcNN+4a46/dahXa8/ow
    axzPOb3zKnOI+xRHmSm9DCF3ejWRGEes7PfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1522512947;
    bh=Lu4P0rBcggtqQ+aFK8g4WCgzm+bUiuVE9MFf3UQ9bU4=; b=Kcdfybnfgr+O
    4LgEZqwraXIUrVSGhiohqsSdAlYWg5RABA6ChX+klw4hJyXCuy+SXKm39/o4E80P
    DnGzzVt+L4LCIS1RUeEMOCyHWbp7wveaUO+glx87d5ZvpjYzxQEI6yxaIcCYTYBv
    vEvyq27xg/kQdp2a56utTSIDOGLWpiO95+ihO4gCKGbNBnhizxVmC1gZNnAi8hKe
    ytGa0cGNJS2SZre0pfUfg0WJC4AyC9SDiY7Dt1mET/kUAWCPtm1JeQ5pF+R9aDb+
    vJuhYUoB2HBk/bFPzhdYbYak2EmtO1o4a6IZUHXLr+rdTXe8E8tqmhd8GJBX6SMY
    wFyOWAgZtQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGIjANFX1qZcW40qp3XcERI9y5ytjfd5UKYZlqWck7YBQuTwT8jlWFDPIx7dsUmOVJraUNa7JkuMVPImFH+FPms3So4mWicp1XrU2pv9ilWKTbKh/uK+
    NBXcfF7DBRXKu14d+Pyjtw+PcXP+1Lw/m9bWNCZiLRDQRsMvrsjYOnu5ec32UAdJV8g0H2ouh7nRFd26MsXlRDJdYFMCKiyakJbsaQ1dHsWUmFjpdyva6cPN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=0F7zqsvzCi70PHmevtQA:9 a=QEXdDO2ut3YA:10 a=ZM-zjvMLuogBmpmEOmkA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeCaQPo (ORCPT <rfc822;greg@kroah.com>);
        Sat, 31 Mar 2018 12:15:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38538 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeCaQPn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 31 Mar 2018 12:15:43 -0400
Date: Sat, 31 Mar 2018 18:15:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.15
Message-ID: <20180331161539.GA24760@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.15 kernel.

All users of the 4.15 kernel series must upgrade.

The updated 4.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.15.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                               |    2=20
 drivers/net/ethernet/arc/emac_rockchip.c               |    6=20
 drivers/net/ethernet/broadcom/bcmsysport.c             |   33 +--
 drivers/net/ethernet/broadcom/bcmsysport.h             |    2=20
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c         |    8=20
 drivers/net/ethernet/freescale/fec_main.c              |    2=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c |   12 -
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c            |   17 +
 drivers/net/ethernet/qlogic/qede/qede_main.c           |    4=20
 drivers/net/ethernet/ti/cpsw.c                         |    3=20
 drivers/net/macvlan.c                                  |    2=20
 drivers/net/phy/phy.c                                  |  173 ++++++++----=
-----
 drivers/net/phy/phy_device.c                           |   15 +
 drivers/net/ppp/ppp_generic.c                          |   26 +-
 drivers/net/team/team.c                                |    4=20
 drivers/s390/net/qeth_core_main.c                      |   21 +-
 drivers/s390/net/qeth_l2_main.c                        |    2=20
 drivers/s390/net/qeth_l3_main.c                        |    2=20
 drivers/soc/fsl/qbman/qman.c                           |   28 --
 fs/sysfs/symlink.c                                     |    1=20
 include/linux/cgroup-defs.h                            |    4=20
 include/linux/phy.h                                    |    1=20
 include/linux/rhashtable.h                             |    4=20
 include/net/sch_generic.h                              |   19 +
 lib/rhashtable.c                                       |    4=20
 lib/test_rhashtable.c                                  |  134 +++++++++++++
 net/core/dev.c                                         |   22 +-
 net/core/devlink.c                                     |   16 -
 net/core/skbuff.c                                      |    2=20
 net/dccp/proto.c                                       |    5=20
 net/dsa/legacy.c                                       |    2=20
 net/ieee802154/6lowpan/core.c                          |   12 -
 net/ipv4/inet_fragment.c                               |    3=20
 net/ipv4/ip_sockglue.c                                 |    6=20
 net/ipv4/tcp.c                                         |    1=20
 net/ipv4/tcp_timer.c                                   |    1=20
 net/ipv6/datagram.c                                    |   21 +-
 net/ipv6/ndisc.c                                       |    3=20
 net/ipv6/route.c                                       |   71 ++++--
 net/ipv6/seg6_iptunnel.c                               |    7=20
 net/iucv/af_iucv.c                                     |    4=20
 net/kcm/kcmsock.c                                      |   33 ++-
 net/l2tp/l2tp_core.c                                   |    8=20
 net/netlink/genetlink.c                                |    2=20
 net/openvswitch/meter.c                                |   12 -
 net/sched/act_tunnel_key.c                             |    1=20
 net/sched/sch_netem.c                                  |    2=20
 47 files changed, 500 insertions(+), 263 deletions(-)

Alexey Kodanev (2):
      sch_netem: fix skb leak in netem_enqueue()
      dccp: check sk for closed state in dccp_sendmsg()

Arkadi Sharshevsky (2):
      devlink: Remove redundant free on error path
      team: Fix double free in error path

Arvind Yadav (1):
      net/iucv: Free memory obtained by kzalloc

Brad Mouring (1):
      net: phy: Tell caller result of phy_change()

Camelia Groza (3):
      dpaa_eth: remove duplicate initialization
      dpaa_eth: increment the RX dropped counter when needed
      dpaa_eth: remove duplicate increment of the tx_errors counter

Christophe JAILLET (1):
      net: ethernet: arc: Fix a potential memory leak if an optional regula=
tor is deferred

David Ahern (1):
      net: Only honor ifindex in IP_PKTINFO if non-0

David Lebrun (2):
      ipv6: sr: fix NULL pointer dereference when setting encap source addr=
ess
      ipv6: sr: fix scheduling in RCU when creating seg6 lwtunnel state

Eric Dumazet (3):
      ieee802154: 6lowpan: fix possible NULL deref in lowpan_device_event()
      net: use skb_to_full_sk() in skb_update_prio()
      l2tp: do not accept arbitrary sockets

Florian Fainelli (3):
      net: dsa: Fix dsa_is_user_port() test inversion
      net: fec: Fix unbalanced PM runtime calls
      net: systemport: Rewrite __bcm_sysport_tx_reclaim()

Greg Kroah-Hartman (1):
      Linux 4.15.15

Grygorii Strashko (2):
      sysfs: symlink: export sysfs_create_link_nowarn()
      net: phy: relax error checking when creating sysfs link netdev->phydev

Guillaume Nault (1):
      ppp: avoid loop in xmit recursion detection code

Ido Schimmel (1):
      mlxsw: spectrum_buffers: Set a minimum quota for CPU port traffic

Julian Wiedmann (4):
      s390/qeth: free netdevice when removing a card
      s390/qeth: when thread completes, wake up all waiters
      s390/qeth: lock read device while queueing next buffer
      s390/qeth: on channel error, reject further cmd requests

Kirill Tkhai (1):
      net: Fix hlist corruptions in inet_evict_bucket()

Lorenzo Bianconi (1):
      ipv6: fix access to non-linear packet in ndisc_fill_redirect_hdr_opti=
on()

Madalin Bucur (2):
      soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
      dpaa_eth: fix error in dpaa_remove()

Michal Kalderon (3):
      qed: Fix MPA unalign flow in case header is split across two packets.
      qed: Fix non TCP packets should be dropped on iWARP ll2 connection
      qede: Fix qedr link update

Nicolas Dichtel (1):
      netlink: avoid a double skb free in genlmsg_mcast()

Paolo Abeni (1):
      net: ipv6: keep sk status consistent after datagram connect failure

Paul Blakey (2):
      rhashtable: Fix rhlist duplicates insertion
      test_rhashtable: add test case for rhltable with duplicate objects

Roman Mashak (1):
      net sched actions: return explicit error when tunnel_key mode is not =
specified

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (1):
      net: ethernet: ti: cpsw: add check for in-band mode setting with RGMI=
I PHY interface

Shannon Nelson (1):
      macvlan: filter out unsupported feature flags

Soheil Hassas Yeganeh (1):
      tcp: purge write queue upon aborting the connection

Stefano Brivio (2):
      ipv6: old_dport should be a __be16 in __ip6_datagram_connect()
      ipv6: Reflect MTU changes on PMTU of exceptions for MTU-less routes

Tom Herbert (1):
      kcm: lock lower socket in kcm_attach

Vinicius Costa Gomes (1):
      skbuff: Fix not waking applications when errors are enqueued

zhangliping (1):
      openvswitch: meter: fix the incorrect calculation of max delta_t


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlq/tCoACgkQONu9yGCS
aT46sRAApYRnPTx1+Am/E7lUImWfLXGlt7MXFQCR3M5IQ5XzvsWd3KpyDCnw57DJ
PcRP74IyunHYr13klXWPw2CK7hXEoVEftI205NxxAU7CpRzIBpV7nG2j3TE29gFn
jo34beCVPuJQne56rvN+u6ETOzM0HVw3mgsMl5AtC+oQ0d0/st/wWosmFVlA+4ro
rItEhkOkQDGFct0Qqhx6vrEEdVKc/a4p5v9J/UHrpuuXqbSEB6Zvw8nZ7TJFZQYt
FxauDBz+M3enOrtTbu7HhziN+xT+vIUxQL9GdUgfs+jn7vQJSrXNNoXD7ipng+2R
Hwktiv1wQ24jboytMPkTt7ndgi7+luRCSPwBg8dBalmv+Fem7jpw05YTPwXQaZtZ
4HRoxaqYr0MRQQRFxuOJmbo8QtoJwZxkt4Rl6l0pH8aof8ltwcTK6h+I8nfLQubs
MrYLV7CJXhwVZcyFb5H9+MuZswj8AxoLklc8Hc5/g6+GoF6creiegA+dVlSFDERQ
drZ8nHf15HEnN67OT7Z8wF5eSkD5M539Ayd/tHBUhza/yHwzn9acsBueaf7dwtgi
ewjICmDVY2pBP2D0nAzeWumluV8tF5U85sb1c2KI7/v8bDyipbff4xrMX6D6vK0b
pZNCPoq+DQDW+KrAL/sLN0llsXSQEDERbIyH7Nl3XID0ygWVc78=
=BPfl
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
