Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76080ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCDF20875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCDF20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeGVOrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 10:47:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeGVOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 10:47:19 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A2C55AD8;
        Sun, 22 Jul 2018 13:50:33 +0000 (UTC)
Date:   Sun, 22 Jul 2018 15:50:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.116
Message-ID: <20180722135031.GA9318@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.116 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                      |    2=20
 drivers/block/loop.c                          |   79 ++++++++++++++-------=
-----
 drivers/block/loop.h                          |    1=20
 drivers/crypto/amcc/crypto4xx_core.c          |   23 +++----
 drivers/infiniband/Kconfig                    |   12 +++
 drivers/infiniband/core/Makefile              |    4 -
 drivers/misc/ibmasm/ibmasmfs.c                |   27 --------
 drivers/net/ethernet/broadcom/bcm63xx_enet.c  |   34 ++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |    8 +-
 drivers/net/ethernet/sun/sungem.c             |   22 +++----
 drivers/usb/core/quirks.c                     |    4 +
 drivers/usb/host/xhci-mem.c                   |    2=20
 drivers/usb/misc/yurex.c                      |   23 +------
 drivers/usb/serial/keyspan_pda.c              |    4 -
 drivers/usb/serial/mos7840.c                  |    3=20
 drivers/vhost/net.c                           |    3=20
 fs/inode.c                                    |    6 +
 kernel/power/user.c                           |    5 +
 net/bridge/netfilter/ebtables.c               |   15 ++++
 net/dccp/ccids/ccid3.c                        |   16 ++---
 net/dns_resolver/dns_key.c                    |   28 +++++----
 net/ipv4/netfilter/ip_tables.c                |    1=20
 net/ipv4/sysctl_net_ipv4.c                    |   18 ++++-
 net/ipv4/tcp_input.c                          |    9 ++
 net/ipv6/netfilter/ip6_tables.c               |    1=20
 net/nfc/llcp_commands.c                       |    9 +-
 net/rds/loop.c                                |    1=20
 net/rds/rds.h                                 |    5 +
 net/rds/recv.c                                |    5 +
 net/sched/sch_blackhole.c                     |    2=20
 30 files changed, 227 insertions(+), 145 deletions(-)

Alex Vesker (2):
      net/mlx5: Fix incorrect raw command length parsing
      net/mlx5: Fix command interface race in polling mode

Christian Lamparter (2):
      crypto: crypto4xx - remove bad list_del
      crypto: crypto4xx - fix crypto4xx_build_pdr, crypto4xx_build_sdr leak

Dan Carpenter (1):
      xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Eric Biggers (1):
      KEYS: DNS: fix parsing multiple options

Eric Dumazet (3):
      net: dccp: avoid crash in ccid3_hc_rx_send_feedback()
      net: dccp: switch rx_tstamp_last_feedback to monotonic clock
      net: sungem: fix rx checksum support

Florian Westphal (2):
      netfilter: x_tables: initialise match/target check parameter struct
      netfilter: ebtables: reject non-bridge targets

Greg Kroah-Hartman (1):
      Linux 3.18.116

Ilpo J=E4rvinen (1):
      tcp: prevent bogus FRTO undos with non-SACK flows

Jann Horn (2):
      ibmasm: don't write out of bounds in read handler
      USB: yurex: fix out-of-bounds uaccess in read handler

Jason Wang (1):
      vhost_net: validate sock before trying to put its fd

Johan Hovold (2):
      USB: serial: keyspan_pda: fix modem-status error handling
      USB: serial: mos7840: fix status-register error handling

Jonas Gorski (2):
      bcm63xx_enet: correct clock usage
      bcm63xx_enet: do not write to random DMA channel on BCM6345

Konstantin Khlebnikov (1):
      net_sched: blackhole: tell upper qdisc about dropped packets

Leon Romanovsky (1):
      RDMA/ucm: Mark UCM interface as BROKEN

Linus Torvalds (1):
      Fix up non-directory creation in SGID directories

Nico Sneck (1):
      usb: quirks: add delay quirks for Corsair Strafe

Santosh Shilimkar (1):
      rds: avoid unenecessary cong_update in loop transport

Tetsuo Handa (3):
      PM / hibernate: Fix oops at snapshot_write()
      loop: remember whether sysfs_create_group() was done
      net/nfc: Avoid stalls when nfc_alloc_send_skb() returned NULL.

Theodore Ts'o (1):
      loop: add recursion validation to LOOP_CHANGE_FD

Yuchung Cheng (1):
      tcp: fix Fast Open key endianness


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltUi6QACgkQONu9yGCS
aT7E7hAAx+k+SJcCGaU1BRMw2whjyCaQTbExCDZ4pX8ZGadmXGGVB1ergOn9++3M
LJs/5YR3pg81CWSBqhzrU0Gl2S4zrYSHU2jMxC29gGDoUzX0Yzj6ltudUCoEeP0K
GFd+66ay64xZneHwf7Mt0q6qdrmOQ72vpWR+y5zWotEfQktS0FQM88xqgcgwnohg
jvFr2zOoyobwKWTvyMyiBJjlazlYHweOfCz2m2kOTQ8wxjKBzL8ug5XW8VgGsfZi
cTgO6xh41B3SESJgbciJJUqKA40xCN4T8ostMlpwfHVLqGu2khed74t5ogrz7smb
lW9zfnd2xMlXM39+7cQ921NiR/A+8D8HLDO8UAjLL976p9dUakeFnEGQsZj452gO
5NizNkGQEMVM3Bdf5K8QGSDpwavt9i46Csdsp0LQmbENK07Ow7JiCMxVb6Qo5COE
gMQuib9c+ftb4TWvJ11DsTdH6mqbjPtvey18kILNGs+2eWbD8CdVzRXxU5P1Z3am
VeGu7eLQN9sfKr1H0upKPs1Rk6+R9RbLokmAmT4wzAbCwfQO2ihBya+zBpOelJMK
/N+T7P0yTqBECAwtkPF2yOYTck+7yPTzALdYpMO6wng4a8Uzgh7UANdfy/Ccdt21
RYahjtG/xJn+ZlqDJepjR+iGY6MEnIdSdWTgMJsF+CNUBKcSHSA=
=vxxj
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
