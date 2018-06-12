Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 48188C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7993208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0rruDlUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7993208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933796AbeFLJfl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933631AbeFLJff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:35:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 955B6208B0;
        Tue, 12 Jun 2018 09:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528796135;
        bh=sqhIXrDYlWOSY+x8rnY9CiUWmwkq/lOn0WdCMP6dWns=;
        h=Date:From:To:Cc:Subject:From;
        b=0rruDlUVW81tJYKbQz0+TFD9MtHYy5txWJdENsfGNxe2Qy4s/NYv6fOZgvwM8eOEu
         E3RLEOREOTW6bFjwDJqToQBu1vlc41VKARj1cB8zWK1Sadla4oAGiZF5oJPsDOMMlY
         o+ku8tWbMMVWxznOKvw02Duuo1tqSPKsvndh1Ag8=
Date:   Tue, 12 Jun 2018 11:35:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.15
Message-ID: <20180612093513.GA23534@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.15 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.16.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/networking/netdev-FAQ.txt          |    9 ++++
 Makefile                                         |    2 -
 drivers/gpu/drm/drm_file.c                       |    1=20
 drivers/isdn/hardware/eicon/diva.c               |   22 +++++++----
 drivers/isdn/hardware/eicon/diva.h               |    5 +-
 drivers/isdn/hardware/eicon/divasmain.c          |   18 +++++----
 drivers/net/dsa/b53/b53_common.c                 |   15 +++++++
 drivers/net/dsa/b53/b53_priv.h                   |    2 +
 drivers/net/dsa/b53/b53_srab.c                   |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c |    2 -
 drivers/net/ethernet/cisco/enic/enic_main.c      |    8 ++--
 drivers/net/ethernet/emulex/benet/be_main.c      |    4 +-
 drivers/net/ethernet/mellanox/mlx4/qp.c          |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c  |   42 ++++++++++++++++++=
+++
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c   |    5 ++
 drivers/net/ethernet/qlogic/qed/qed_cxt.c        |    2 -
 drivers/net/ethernet/socionext/netsec.c          |    4 +-
 drivers/net/ethernet/ti/davinci_emac.c           |   22 ++++++-----
 drivers/net/phy/bcm-cygnus.c                     |    6 +--
 drivers/net/phy/bcm-phy-lib.c                    |    2 -
 drivers/net/phy/bcm-phy-lib.h                    |    7 +++
 drivers/net/phy/bcm7xxx.c                        |    4 +-
 drivers/net/team/team.c                          |    3 +
 drivers/net/tun.c                                |   15 ++++---
 drivers/net/usb/cdc_mbim.c                       |    2 -
 drivers/net/virtio_net.c                         |   21 +++++-----
 drivers/pci/host/pci-hyperv.c                    |   46 +++++++++++++++++-=
-----
 drivers/vhost/net.c                              |   37 ++++++++++++------
 drivers/vhost/vhost.c                            |    3 +
 include/net/ipv6.h                               |    5 ++
 mm/mmap.c                                        |   32 ++++++++++++++++
 net/core/flow_dissector.c                        |    2 -
 net/core/net-sysfs.c                             |    6 +--
 net/core/rtnetlink.c                             |    8 ++--
 net/dccp/proto.c                                 |    2 -
 net/ipv4/fib_frontend.c                          |    1=20
 net/ipv4/fib_semantics.c                         |    4 ++
 net/ipv4/ip_sockglue.c                           |    2 -
 net/ipv4/ip_tunnel.c                             |    8 ++--
 net/ipv4/ipmr.c                                  |    7 +++
 net/ipv4/netfilter/nf_flow_table_ipv4.c          |    5 +-
 net/ipv6/ip6_output.c                            |    3 +
 net/ipv6/ip6_tunnel.c                            |   11 ++++-
 net/ipv6/ip6mr.c                                 |    3 +
 net/ipv6/ndisc.c                                 |    6 +++
 net/ipv6/netfilter/nf_flow_table_ipv6.c          |    1=20
 net/ipv6/route.c                                 |    2 -
 net/ipv6/seg6_iptunnel.c                         |    4 +-
 net/ipv6/sit.c                                   |    5 +-
 net/kcm/kcmsock.c                                |    2 -
 net/l2tp/l2tp_ppp.c                              |   35 ++++++++---------
 net/packet/af_packet.c                           |    4 +-
 net/sched/cls_api.c                              |    2 -
 net/sched/cls_flower.c                           |    2 -
 net/sctp/transport.c                             |    2 -
 scripts/kconfig/confdata.c                       |    2 -
 56 files changed, 338 insertions(+), 145 deletions(-)

Alexander Duyck (1):
      net-sysfs: Fix memory leak in XPS configuration

Alexey Kodanev (1):
      dccp: don't free ccid2_hc_tx_sock struct in dccp_disconnect()

Ard Biesheuvel (1):
      net: netsec: reduce DMA mask to 40 bits

Arun Parameswaran (1):
      net: dsa: b53: Fix for brcm tag issue in Cygnus SoC

Cong Wang (1):
      netdev-FAQ: clarify DaveM's position for stable backports

Dan Carpenter (2):
      net: ethernet: davinci_emac: fix error handling in probe()
      team: use netdev_features_t instead of u32

Daniele Palmas (1):
      net: usb: cdc_mbim: add flag FLAG_SEND_ZLP

Dave Airlie (1):
      drm: set FMODE_UNSIGNED_OFFSET for drm files

Dexuan Cui (1):
      PCI: hv: Do not wait forever on a device that has disappeared

Eran Ben Elisha (1):
      net/mlx5e: When RXFCS is set, add FCS data into checksum calculation

Eric Dumazet (4):
      ipmr: properly check rhltable_init() return value
      net: metrics: add proper netlink validation
      net/packet: refine check for priv area size
      rtnetlink: validate attributes in do_setlink()

Florian Fainelli (2):
      net: phy: broadcom: Fix bcm_write_exp()
      net: phy: broadcom: Fix auxiliary control register reads

Govindarajulu Varadarajan (1):
      enic: set DMA mask to 47 bit

Greg Kroah-Hartman (1):
      Linux 4.16.15

Guillaume Nault (1):
      l2tp: fix refcount leakage on PPPoL2TP sockets

Jack Morgenstein (1):
      net/mlx4: Fix irq-unsafe spinlock usage

Jason A. Donenfeld (1):
      netfilter: nf_flow_table: attach dst to skbs

Jason Wang (6):
      vhost: synchronize IOTLB message with dev cleanup
      virtio-net: correctly transmit XDP buff after linearizing
      virtio-net: fix leaking page for gso packet during mergeable XDP
      virtio-net: correctly check num_buf during err path
      virtio-net: correctly redirect linearized packet
      vhost_net: flush batched heads before trying to busy polling

Julia Lawall (1):
      bnx2x: use the right constant

Kirill Tkhai (1):
      kcm: Fix use-after-free caused by clonned sockets

Linus Torvalds (2):
      mmap: introduce sane default mmap limits
      mmap: relax file size limit for regular files

Mathieu Xhonneux (1):
      ipv6: sr: fix memory OOB access in seg6_do_srh_encap/inline

Michal Kubecek (1):
      ipv6: omit traffic class when calculating flow hash

Nathan Chancellor (1):
      kconfig: Avoid format overflow warning from GCC 8.1

Nicolas Dichtel (2):
      ip6_tunnel: remove magic mtu value 0xFFF8
      ip_tunnel: restore binding to ifaces with a large mtu

Or Gerlitz (1):
      net : sched: cls_api: deal with egdev path only if needed

Paul Blakey (1):
      cls_flower: Fix incorrect idr release when failing to modify rule

Petr Machata (1):
      mlxsw: spectrum: Forbid creation of VLAN 1 over port/LAG

Roopa Prabhu (1):
      net: ipv4: add missing RTA_TABLE to rtm_ipv4_policy

Sabrina Dubroca (1):
      ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succ=
eeds

Shahed Shaikh (1):
      qed: Fix mask for physical address in ILT entry

Stephen Suryaputra (1):
      vrf: check the original netdevice for generating redirect

Suresh Reddy (1):
      be2net: Fix error detection logic for BE3

Toshiaki Makita (1):
      tun: Fix NULL pointer dereference in XDP redirect

Wenwen Wang (1):
      isdn: eicon: fix a missing-check bug

Willem de Bruijn (2):
      ipv4: remove warning in ip_recv_error
      packet: fix reserve calculation

Xin Long (1):
      sctp: not allow transport timeout value less than HZ/5 for hb_timer


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsfk9AACgkQONu9yGCS
aT76Hg/4iDxye/Zbp4C5OIiHu2ZmCu9o4UvspeeJLJNMEh4wD9/edntSuP+6Rbkj
zBxhhnkkbFFs+EJWYjAzxBA5RnbrTgAto2WppTSc4cfQQAm1IEbKDF/4E2uP8w+d
wV2Lzlb/s05d6f7B52fqikO8I4mdyOCCT7lvs6qWlf5MmsMEU7cQVyCwtR2JwaeC
JPRD62U/6G1zSWjy5P/uxx9Bn3mylWEUZ78khtjheKE1Xtl8qm0Ig0l9Qu+jQrTd
e4vVZ6Z9JRhQ81f5HfJRO2m2YFv3YF7V3/0twlbSKV7TTyN0UVnH5IdCS1pHuKOm
u+NkYtkAbYsg4EJn96eOFUTkINO3hpFNI20qtUuYGnJBvEc3+VFAIw6wf+jIMjOi
X/vmEOGgCzHaJluYSKXhGp27Vyr49+33gOg9DtSNW9ajSqeLtmhs8RCSzw9+pNlE
BHe4v3twhIQ2A899wNEzV2cYwZGdYaES0Lc58VVYE+8C6tz/M6Uhye76Z/d+pqs8
ThM1LsqpHbXBrvgPVM0jE/pGiBvrm5dkVfsqM2D2R0rSgEvLEKUdycNWVveUnSsG
qvgh1GJqT+klJcpH5AAjcASTg9NUbfj5CStFl0H8+2mS4uSoEBYRzRWVsr1FgRlh
AFHwFousQFAGiWbQaceDilqvESWVUGLwvN96Jz70ftz/bdtcsw==
=/BQO
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
