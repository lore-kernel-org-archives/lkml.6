Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8CC5EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A51208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZegRmCI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A51208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933972AbeFLJgF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933156AbeFLJgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:36:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFD4208B0;
        Tue, 12 Jun 2018 09:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528796161;
        bh=hDDncODGNtlCUue0/QPzJxw8fBNcpczAz7/RKjHL5Zg=;
        h=Date:From:To:Cc:Subject:From;
        b=ZegRmCI2zHjMJkfi0H6BBcyiNIm3ctRP/IU/XmEo7QNBOopFp/DZYO+XtjyZjR4qD
         2Il6/+Zh0QWblBRsP6BsQgCc17pmIfQJyQQ76CUGC7WhyD83mpK/ueWp8g86UHiFHT
         aYOgAw8DbWPrelMug+rAQxu2kEpkyCxz6P7ql7w4=
Date:   Tue, 12 Jun 2018 11:35:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.1
Message-ID: <20180612093539.GA26677@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.1 kernel.

All users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/networking/netdev-FAQ.txt          |    9 ++++
 Makefile                                         |    2 -
 drivers/net/dsa/b53/b53_common.c                 |   15 +++++++
 drivers/net/dsa/b53/b53_priv.h                   |    2 +
 drivers/net/dsa/b53/b53_srab.c                   |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c |    2 -
 drivers/net/team/team.c                          |    3 +
 drivers/pci/host/pci-hyperv.c                    |   46 +++++++++++++++++-=
-----
 include/linux/mroute_base.h                      |   10 -----
 include/net/ipv6.h                               |    5 ++
 net/core/flow_dissector.c                        |    2 -
 net/core/rtnetlink.c                             |    8 ++--
 net/ipv4/fib_semantics.c                         |    4 ++
 net/ipv4/ipmr_base.c                             |    8 ++--
 net/ipv4/netfilter/nf_flow_table_ipv4.c          |    5 +-
 net/ipv6/ip6_output.c                            |    3 +
 net/ipv6/ip6mr.c                                 |   21 +++++++---
 net/ipv6/ndisc.c                                 |    6 +++
 net/ipv6/netfilter/nf_flow_table_ipv6.c          |    1=20
 net/ipv6/route.c                                 |    4 +-
 net/l2tp/l2tp_ppp.c                              |   35 ++++++++---------
 net/packet/af_packet.c                           |    2 -
 net/sctp/transport.c                             |    2 -
 23 files changed, 131 insertions(+), 68 deletions(-)

Arun Parameswaran (1):
      net: dsa: b53: Fix for brcm tag issue in Cygnus SoC

Cong Wang (1):
      netdev-FAQ: clarify DaveM's position for stable backports

Dan Carpenter (1):
      team: use netdev_features_t instead of u32

Dexuan Cui (1):
      PCI: hv: Do not wait forever on a device that has disappeared

Eric Dumazet (3):
      net: metrics: add proper netlink validation
      net/packet: refine check for priv area size
      rtnetlink: validate attributes in do_setlink()

Greg Kroah-Hartman (1):
      Linux 4.17.1

Guillaume Nault (1):
      l2tp: fix refcount leakage on PPPoL2TP sockets

Jason A. Donenfeld (1):
      netfilter: nf_flow_table: attach dst to skbs

Julia Lawall (1):
      bnx2x: use the right constant

Michal Kubecek (1):
      ipv6: omit traffic class when calculating flow hash

Sabrina Dubroca (2):
      ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succ=
eeds
      ipmr: fix error path when ipmr_new_table fails

Stephen Suryaputra (1):
      vrf: check the original netdevice for generating redirect

Xin Long (1):
      sctp: not allow transport timeout value less than HZ/5 for hb_timer


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsfk+oACgkQONu9yGCS
aT7NBhAAh0Wv3dMGpxHR6KU3iBByX1d4c7+gvC0Skf3L02aUgliaA4I3OdFJxE3/
+7MXOJT2teHJic8UjhMYN0pRHSpnWgf0NU3jHbSp/LUOIxl/lKWI5UQ4DX4861Sb
EwyCpjxO8wcOHA/seAL7tv5QAtVeB5TVYvTVe/x7eiSruT/bG9EOMLTjcAF4a9AN
9xEqKbwB1z51OibqB1FOvDGl5wTLwfkm8Sta5aL7SSub5W9rAhGNyW/eh0InjbiO
J6MsvNwGNgmnBX/lFC9ceRwWvuwMMOTEtbFF5WidmN4UDVDLipFRXij8OV/XbHFB
eggRqO3n7+6zFx+M8kJ9zmbxKVCWQxVmnOy5S7uNPaeYIxEBvX0e0k4Huu0fMGfK
wneU+E7vt0gGLS4tmJ7y98qH/N4OAe6RTEsdilE+yENN9duh0SxD9VK7kK3Qi5eT
uP0H0ka7O33BhC8lqPvgTolEK5Xnn+HN9JROuCOLMzbU5CVVbLqTuT5bKfcDlgy4
N+o7oB7lX4eAI4hvqX3DNdIfr7uI2FOWUL7fizdsPkEyYI7Bm5EKbI2cyf0gNO6O
EvDKHfXJf7jYzV0DCEfGCaI6gBuMEo8FEOmvOmt/Y7gAfq8SVkQJelHA2z6aCo41
wuRD3c+CWJAZcygFjMhkFxd5WIICWFUWETMZHBqHMRAv9lOMC6Q=
=dzJA
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
