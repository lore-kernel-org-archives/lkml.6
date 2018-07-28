Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F37C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B017F2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B017F2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeG1Huv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:50:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeG1Huv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:50:51 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 615F7825;
        Sat, 28 Jul 2018 06:25:32 +0000 (UTC)
Date:   Sat, 28 Jul 2018 08:25:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.117
Message-ID: <20180728062529.GA11780@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.117 kernel.

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

 Makefile                                              |    3=20
 arch/arc/include/asm/page.h                           |    2=20
 arch/arc/include/asm/pgtable.h                        |    2=20
 arch/arm/include/asm/uaccess.h                        |    2=20
 arch/x86/kernel/cpu/mcheck/mce.c                      |    3=20
 drivers/net/can/xilinx_can.c                          |   98 +++++++++++++=
-----
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    2=20
 drivers/ptp/ptp_chardev.c                             |    1=20
 drivers/usb/class/cdc-acm.c                           |    3=20
 drivers/usb/core/hub.c                                |    8 +
 drivers/usb/gadget/function/f_fs.c                    |    2=20
 fs/fat/inode.c                                        |   20 ++-
 include/linux/skbuff.h                                |   12 +-
 include/net/tcp.h                                     |    2=20
 net/core/rtnetlink.c                                  |    9 +
 net/core/skbuff.c                                     |    1=20
 net/ipv4/ip_output.c                                  |    2=20
 net/ipv4/sysctl_net_ipv4.c                            |    5=20
 net/ipv4/tcp_dctcp.c                                  |   50 ++-------
 net/ipv4/tcp_input.c                                  |   22 +++-
 net/ipv4/tcp_output.c                                 |   33 ++++--
 net/ipv6/ip6_output.c                                 |    2=20
 sound/core/rawmidi.c                                  |   20 ++-
 23 files changed, 198 insertions(+), 106 deletions(-)

Alexey Brodkin (1):
      ARC: Fix CONFIG_SWAP

Anssi Hannula (4):
      can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK
      can: xilinx_can: fix device dropping off bus on RX overrun
      can: xilinx_can: keep only 1-2 frames in TX FIFO to fix TX accounting
      can: xilinx_can: fix RX overflow interrupt not being enabled

Arnd Bergmann (2):
      ARM: fix put_user() for gcc-8
      turn off -Wattribute-alias

Bin Liu (1):
      usb: core: handle hub C_PORT_OVER_CURRENT condition

Dewet Thibaut (1):
      x86/MCE: Remove min interval polling limitation

Eric Dumazet (2):
      tcp: avoid collapses in tcp_prune_queue() if possible
      tcp: detect malicious patterns in tcp_collapse_ofo_queue()

Greg Kroah-Hartman (1):
      Linux 3.18.117

Gustavo A. R. Silva (1):
      ptp: fix missing break in switch

Jack Morgenstein (1):
      net/mlx4_core: Save the qpn from the input modifier in RST2INIT wrapp=
er

Jerry Zhang (1):
      usb: gadget: f_fs: Only return delayed status when len is 0

Lubomir Rintel (1):
      usb: cdc_acm: Add quirk for Castles VEGA3000

OGAWA Hirofumi (1):
      fat: fix memory allocation failure handling of match_strdup()

Paolo Abeni (1):
      ip: hash fragments consistently

Roopa Prabhu (1):
      rtnetlink: add rtnl_link_state check in rtnl_configure_link

Stefano Brivio (2):
      net: Don't copy pfmemalloc flag in __copy_skb_header()
      skbuff: Unconditionally copy pfmemalloc in __skb_clone()

Takashi Iwai (1):
      ALSA: rawmidi: Change resized buffers atomically

Tyler Hicks (1):
      ipv4: Return EINVAL when ping_group_range sysctl doesn't map to user =
ns

Vineet Gupta (1):
      ARC: mm: allow mprotect to make stack mappings executable

Yuchung Cheng (4):
      tcp: fix dctcp delayed ACK schedule
      tcp: helpers to send special DCTCP ack
      tcp: do not cancel delay-AcK on DCTCP special ACK
      tcp: do not delay ACK in DCTCP upon CE status change


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltcDFQACgkQONu9yGCS
aT4QmRAA2LaFP9pQ9aEkbDY2ogRwG8BEoDVRwWkpSxwuivisLwgD25eFUHKQg8+9
0vac1t1GwHDhI4iak9kTvABvFkremeA44B3hyf1x2pHJcfujpXw+n0zKLLxedQWF
VnppbNosKErT33CBFftBVkUQ4zeywDmT84btL+sBMQD6jmjc6uj5dut0HKJmZ07H
am7ZT4xLohxBTQ/CltOa1uKAjwrdsWaYtZJC1oQ8SYHAtpmA2TcLdCJh6o6k+3A1
0YUBq+KG5oaAdzl+hMzN5+HgUmayryxIsrWV+F/U2pUp94GmL/GuYzm6oriE3UU2
MKikWwTuhMDoLye658KKay+72H4XJY6FO/emP2dsbAd7UhO3TS61I12YHnDP4H/F
+zbG1lgQmTDCsPQstusX6sXTVn021h+e63b7FJ0AqMu3TAEiCeKWSJIDY5ycKk31
CRVhWowSM/ic2Th+QctzA3VqPf03pJK49yHPzSinnqpxGGNzBAPBXy92+t2jtKYn
fEi2Mc2RjYU8b4hyZyHwgCGP1Nd2QMAI400W7HosPfAEKBLRvnNhSvGLwsiMFMSu
yAGYp2tf8UoskVdZGRoEMqQ81ylX+rYgSF3uJKytgEokv8A2G9FwfxDtGxEbTvKO
Cjyv/+tqTT89fhGYsWuGFgHjz0T4+Lsyn6uBERvB5l1EI5i534U=
=EYoC
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
