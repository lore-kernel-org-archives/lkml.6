Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D416EC6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955732088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955732088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeG1HvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:51:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeG1HvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:51:14 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33060825;
        Sat, 28 Jul 2018 06:25:55 +0000 (UTC)
Date:   Sat, 28 Jul 2018 08:25:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.145
Message-ID: <20180728062552.GA11870@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.145 kernel.

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

 Makefile                                              |    3=20
 arch/arm/include/asm/uaccess.h                        |    2=20
 arch/mips/ath79/common.c                              |    2=20
 drivers/base/dd.c                                     |    8=20
 drivers/net/can/xilinx_can.c                          |  323 +++++++++++++=
+----
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    2=20
 drivers/usb/class/cdc-acm.c                           |    3=20
 drivers/usb/core/hub.c                                |    8=20
 drivers/usb/gadget/function/f_fs.c                    |    2=20
 include/net/tcp.h                                     |    2=20
 net/core/rtnetlink.c                                  |    9=20
 net/ipv4/ip_output.c                                  |    2=20
 net/ipv4/ip_sockglue.c                                |    7=20
 net/ipv4/tcp_dctcp.c                                  |   50 --
 net/ipv4/tcp_input.c                                  |   22 +
 net/ipv4/tcp_output.c                                 |   33 +
 net/ipv6/datagram.c                                   |    7=20
 net/ipv6/ip6_output.c                                 |    2=20
 18 files changed, 357 insertions(+), 130 deletions(-)

Anssi Hannula (6):
      can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK
      can: xilinx_can: fix recovery from error states not being propagated
      can: xilinx_can: fix device dropping off bus on RX overrun
      can: xilinx_can: keep only 1-2 frames in TX FIFO to fix TX accounting
      can: xilinx_can: fix incorrect clear of non-processed interrupts
      can: xilinx_can: fix RX overflow interrupt not being enabled

Arnd Bergmann (2):
      turn off -Wattribute-alias
      ARM: fix put_user() for gcc-8

Bin Liu (1):
      usb: core: handle hub C_PORT_OVER_CURRENT condition

Eric Dumazet (2):
      tcp: avoid collapses in tcp_prune_queue() if possible
      tcp: detect malicious patterns in tcp_collapse_ofo_queue()

Felix Fietkau (1):
      MIPS: ath79: fix register address in ath79_ddr_wb_flush()

Greg Kroah-Hartman (1):
      Linux 4.4.145

Jack Morgenstein (1):
      net/mlx4_core: Save the qpn from the input modifier in RST2INIT wrapp=
er

Jerry Zhang (1):
      usb: gadget: f_fs: Only return delayed status when len is 0

Lubomir Rintel (1):
      usb: cdc_acm: Add quirk for Castles VEGA3000

Paolo Abeni (1):
      ip: hash fragments consistently

Rafael J. Wysocki (1):
      driver core: Partially revert "driver core: correct device's shutdown=
 order"

Roopa Prabhu (1):
      rtnetlink: add rtnl_link_state check in rtnl_configure_link

Willem de Bruijn (1):
      ip: in cmsg IP(V6)_ORIGDSTADDR call pskb_may_pull

Yuchung Cheng (4):
      tcp: fix dctcp delayed ACK schedule
      tcp: helpers to send special DCTCP ack
      tcp: do not cancel delay-AcK on DCTCP special ACK
      tcp: do not delay ACK in DCTCP upon CE status change


--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltcDHAACgkQONu9yGCS
aT7L5Q//e3BccLSPjdBDE4aQ9/dRJXU6JpbksVgijyTrK4ikzmz9Y2ymzSeC7sQp
whJTNmo6Cgh9BWyF3VVUTIHf3ZV96Y9aFgbQNqQVnnPjQEBSYNoCrnp9lpgHATFP
F+zDu4479OdLeZ/F82BhktD5aG7VMPF6+qv3JMNodLyIdFrx0DyUbmLgSb8mtkpv
PNiE81WX6+z+FmQCULDKEEZqbRaLUqjc2Y5pK1zmsbqD7C5TSkOCVrCwjfF27Ip5
ND3rRqktju/s28Rve6pv4HprdNfqO1g0Ab8pGW6zjPs7PP8gtKV0JMehKV3BKFw7
6Bqe2jg6oaM8T38xhZqctyvFSLrVnzgjTWBB3LxJK0eaCvVUn+kAfI1YzOc//wCw
nKdE8Sz224BD2T2VASa/wG3h35RxyqQ5XvpUrG8W6grHkAcVNPrKnOGsluhQSTHI
dMykclBp+iZe+iyGvrq/tAzmFi+5JcEXl8tN3kvaDE2F9yCqlRDShVUXKBwI2TRe
n53clgNfUpDCvDUhMJcDc2/b8S0Kpqhebecd0ECo7jw/h+S0BU+RMmpBtZZP4is+
gfIfjO9B7ZcfTFJvtKhlCs0lc82Mwy8mtr2SKvFXw7ygT0cZofamEJ5Nu40N8uxG
hQJQ8ek+7vVEQgAF1aSyJJBbYPF37yXCz8cuTdaph7CPH/TtKNY=
=CxTA
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
