Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C668C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9222088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9222088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeG1Hvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:51:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36736 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeG1Hvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:51:35 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33835825;
        Sat, 28 Jul 2018 06:26:16 +0000 (UTC)
Date:   Sat, 28 Jul 2018 08:26:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.116
Message-ID: <20180728062613.GA11964@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.116 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                              |    3=20
 arch/mips/ath79/common.c                              |    2=20
 arch/mips/pci/pci.c                                   |    2=20
 drivers/base/dd.c                                     |    8=20
 drivers/net/can/xilinx_can.c                          |  392 +++++++++++++=
-----
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c     |    7=20
 drivers/net/ethernet/mellanox/mlx5/core/en_clock.c    |   12=20
 drivers/net/phy/phy.c                                 |    2=20
 drivers/usb/class/cdc-acm.c                           |    3=20
 drivers/usb/core/hub.c                                |    8=20
 drivers/usb/gadget/function/f_fs.c                    |    2=20
 fs/exec.c                                             |    7=20
 include/linux/sched.h                                 |    6=20
 include/linux/skbuff.h                                |    2=20
 include/net/tcp.h                                     |    2=20
 net/core/rtnetlink.c                                  |    9=20
 net/core/skbuff.c                                     |   10=20
 net/ipv4/igmp.c                                       |    3=20
 net/ipv4/ip_output.c                                  |    2=20
 net/ipv4/ip_sockglue.c                                |    7=20
 net/ipv4/tcp_dctcp.c                                  |   50 --
 net/ipv4/tcp_input.c                                  |   40 +
 net/ipv4/tcp_output.c                                 |   33 +
 net/ipv6/datagram.c                                   |    7=20
 net/ipv6/ip6_output.c                                 |    2=20
 net/ipv6/mcast.c                                      |    3=20
 27 files changed, 430 insertions(+), 196 deletions(-)

Anssi Hannula (7):
      can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK
      can: xilinx_can: fix power management handling
      can: xilinx_can: fix recovery from error states not being propagated
      can: xilinx_can: fix device dropping off bus on RX overrun
      can: xilinx_can: keep only 1-2 frames in TX FIFO to fix TX accounting
      can: xilinx_can: fix incorrect clear of non-processed interrupts
      can: xilinx_can: fix RX overflow interrupt not being enabled

Ariel Levkovich (1):
      net/mlx5: Adjust clock overflow work period

Arnd Bergmann (2):
      turn off -Wattribute-alias
      exec: avoid gcc-8 warning for get_task_comm

Bin Liu (1):
      usb: core: handle hub C_PORT_OVER_CURRENT condition

Eran Ben Elisha (2):
      net/mlx5e: Don't allow aRFS for encapsulated packets
      net/mlx5e: Fix quota counting in aRFS expire flow

Eric Dumazet (5):
      net: skb_segment() should not return NULL
      tcp: free batches of packets in tcp_prune_ofo_queue()
      tcp: avoid collapses in tcp_prune_queue() if possible
      tcp: detect malicious patterns in tcp_collapse_ofo_queue()
      tcp: call tcp_drop() from tcp_data_queue_ofo()

Felix Fietkau (1):
      MIPS: ath79: fix register address in ath79_ddr_wb_flush()

Greg Kroah-Hartman (1):
      Linux 4.9.116

Hangbin Liu (1):
      multicast: do not restore deleted record source filter mode to new one

Heiner Kallweit (1):
      net: phy: consider PHY_IGNORE_INTERRUPT in phy_start_aneg_priv

Jack Morgenstein (1):
      net/mlx4_core: Save the qpn from the input modifier in RST2INIT wrapp=
er

Jerry Zhang (1):
      usb: gadget: f_fs: Only return delayed status when len is 0

Lubomir Rintel (1):
      usb: cdc_acm: Add quirk for Castles VEGA3000

Paolo Abeni (1):
      ip: hash fragments consistently

Paul Burton (1):
      MIPS: Fix off-by-one in pci_resource_to_user()

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


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltcDIUACgkQONu9yGCS
aT7GYQ//aGUblgg5HZntdwDchzgadvwz5oTXF0ahDa8HgoCRDVnujm7Jh1XrVvhy
bGI2AMJqapmWOhmKduMthAooIim3Lzd7sHQRpR44FOHGawSNITHOkkKjzpW5KWLv
z0L9nbVCIPFHY33Yr2xY5s5krnu8TKKPiZ580h1GDcGxPDzWcLnM3XkBgenrO8RE
z9Or7EXyKpQaT1s0ttd81luj0e8FmJ6BaI6BWjAJvZXNROpih69LwkNTaG7y1bLE
YzFd61H0UAGOLK0WXiZKu3JDRSROf2DaIYFFM4OH5cEcFBDfxVA1H+hWZ049F1GK
jMbCA7UN7QOx+C4ui4Rx3HVr9gX2Hsbxky6IMkJsih736qresvSYBole2XhFtJHT
dYSNrpQ3DWXr0faNNtPz93B3Nz94UwxzlE+q+AglP83E/VR4FvboCJmIJNBJO7lQ
wR5ds2/vUpB1wh/+xjHV0+C8bPB0+FpQ9k8hjLd1GecZpIM8SWSUNtKHPHg4CzV1
h9VRbHLp9fjSM4cXjgoFs8XNWUXaTNxuslr+kDHS5W+RlX2Ox30wHlJ8jFYZ4gHR
unT1s6QyiH9j3pzqZv8okGs7OjkfL25OAVcW0ReCDeZRkpZuHogAmvhIXpLvuS37
AN8vf/TWKUJFXV3KP6GgU+pTaNaDBNKwMUQxvi19B85VtM9bDvM=
=JGBK
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
