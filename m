Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 172F7C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDBA208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq0TuZse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDBA208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933193AbeFLJe4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754182AbeFLJex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:34:53 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3EFE208B0;
        Tue, 12 Jun 2018 09:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528796093;
        bh=Xc6hydTOJxhRSpiRjKFTfRltWuOuO6hgaL7sBo3Oogw=;
        h=Date:From:To:Cc:Subject:From;
        b=Yq0TuZseGEWFey+DJwnm9LDxPWXuZ5zGmpefqBH3wJYiEt0WB0ldf1Vk8TX01Zi8j
         vtEo50598qudzb5IirxH7/vZmWzvmI535n+OlQgjG9Wa1UIkkrCFNsQJvef2Ovf915
         MYM5baARXXOZ1KCDpgokeNrtwXv3snm9a/iAJdu8=
Date:   Tue, 12 Jun 2018 11:34:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.49
Message-ID: <20180612093431.GA18376@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.49 kernel.

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

 Documentation/networking/netdev-FAQ.txt          |    9 +
 Makefile                                         |    2=20
 drivers/gpu/drm/drm_file.c                       |    1=20
 drivers/isdn/hardware/eicon/diva.c               |   22 ++-
 drivers/isdn/hardware/eicon/diva.h               |    5=20
 drivers/isdn/hardware/eicon/divasmain.c          |   18 +--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c |    2=20
 drivers/net/ethernet/cisco/enic/enic_main.c      |    8 -
 drivers/net/ethernet/emulex/benet/be_main.c      |    4=20
 drivers/net/ethernet/mellanox/mlx4/qp.c          |    4=20
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c  |   42 +++++++
 drivers/net/ethernet/qlogic/qed/qed_cxt.c        |    2=20
 drivers/net/phy/bcm-cygnus.c                     |    6 -
 drivers/net/phy/bcm-phy-lib.c                    |    2=20
 drivers/net/phy/bcm-phy-lib.h                    |    7 +
 drivers/net/phy/bcm7xxx.c                        |    4=20
 drivers/net/team/team.c                          |    3=20
 drivers/net/tun.c                                |   15 +-
 drivers/net/usb/cdc_mbim.c                       |    2=20
 drivers/net/virtio_net.c                         |   19 +--
 drivers/pci/host/pci-hyperv.c                    |   46 ++++++--
 drivers/scsi/sd_zbc.c                            |  128 +++++++++++++-----=
-----
 drivers/vhost/vhost.c                            |    3=20
 fs/btrfs/disk-io.c                               |    3=20
 include/net/ipv6.h                               |    5=20
 include/uapi/linux/btrfs_tree.h                  |    1=20
 mm/mmap.c                                        |   32 +++++
 net/core/flow_dissector.c                        |    2=20
 net/core/net-sysfs.c                             |    6 -
 net/core/rtnetlink.c                             |    8 -
 net/dccp/proto.c                                 |    2=20
 net/ipv4/fib_frontend.c                          |    1=20
 net/ipv4/fib_semantics.c                         |    4=20
 net/ipv4/ip_sockglue.c                           |    2=20
 net/ipv4/ipmr.c                                  |    7 +
 net/ipv6/ip6_output.c                            |    3=20
 net/ipv6/ip6_tunnel.c                            |   11 +
 net/ipv6/ip6mr.c                                 |    3=20
 net/ipv6/ndisc.c                                 |    6 +
 net/ipv6/route.c                                 |    2=20
 net/ipv6/seg6_iptunnel.c                         |    4=20
 net/ipv6/sit.c                                   |    5=20
 net/kcm/kcmsock.c                                |    2=20
 net/packet/af_packet.c                           |    4=20
 net/sched/cls_flower.c                           |    2=20
 net/sctp/transport.c                             |    2=20
 scripts/kconfig/confdata.c                       |    2=20
 47 files changed, 329 insertions(+), 144 deletions(-)

Alexander Duyck (1):
      net-sysfs: Fix memory leak in XPS configuration

Alexey Kodanev (1):
      dccp: don't free ccid2_hc_tx_sock struct in dccp_disconnect()

Anand Jain (1):
      btrfs: define SUPER_FLAG_METADUMP_V2

Bart Van Assche (1):
      scsi: sd_zbc: Avoid that resetting a zone fails sporadically

Cong Wang (1):
      netdev-FAQ: clarify DaveM's position for stable backports

Damien Le Moal (1):
      scsi: sd_zbc: Fix potential memory leak

Dan Carpenter (1):
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
      Linux 4.14.49

Jack Morgenstein (1):
      net/mlx4: Fix irq-unsafe spinlock usage

Jason Wang (4):
      vhost: synchronize IOTLB message with dev cleanup
      virtio-net: correctly transmit XDP buff after linearizing
      virtio-net: correctly check num_buf during err path
      virtio-net: fix leaking page for gso packet during mergeable XDP

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

Nicolas Dichtel (1):
      ip6_tunnel: remove magic mtu value 0xFFF8

Paul Blakey (1):
      cls_flower: Fix incorrect idr release when failing to modify rule

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


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsfk6QACgkQONu9yGCS
aT5f2A/+P2OKRbOQKf1P1bsoN3kCenpvdsPqnPnI8pdI6BHmCgDwJF70A3ZQN+GT
sHPiIBlDD3D4xtfDi4tOBbW2kxIQTTB/MlkpL1PV192DC3NjVyaUCgQLTZMZhwpJ
M770XORh++TKcKMjs1cJIqt9ovdsD8fUqVW39onp0FEEyc8ZLgYgxIT2TJdbSlNL
CRc+n+rXjVtG5V7nNSuOc69aHTdsJMtQXKfhD8S3Vm4JJwdv/RP6Lq+UE+HngPBu
OjmyfbNfdkUjCrT7ZeLwss74zEBsRwJq8hKM2wg+ckrfXjw9LwWk0h3WA8vtcBK8
lJ7+wegcBMrLnQvtsQmyrIUIpm/uir+aDL1LIe4YzjK06Gy8vT3jJb0ZDon20Z7x
gj2o6t7Zgy/+OJXFr2AO5fjmILdUWmbkFbvJ0uxeRgg5m4Mq8q0CUVT6/ojVcGFn
fhEI7fjpkQWDHLwxGLnqBQBg/hjw9bB1SY+byKNbcXHdrknfH+tGNLQBUoSRi4D+
YTV2VL+PoRqjnf8b/1AkMSz8FYza3Kq4UXySK8rVc7GzbvMX7G23Kakg4SpOaKWq
wcLzaILnmwBGbs6cYpXCftaoNrT9LCuyhE4x3iPkldRB6EkDHWcdna0aHpS3qUfi
rFU77KPQOE2dIy6NMTWj4ODknNRcX93qFTfEYLBJn+tyKVqEzhM=
=m9oJ
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
