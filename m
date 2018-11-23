Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3373FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE5520685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip4s1Z6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE5520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502478AbeKWSaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502434AbeKWSaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:30:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9E820861;
        Fri, 23 Nov 2018 07:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542959221;
        bh=MnExdOfmSew9xofuXrVhtLP1LPcWfHDrT7+lSEVFvnA=;
        h=Date:From:To:Cc:Subject:From;
        b=Ip4s1Z6nRikgVKduWlntBUrnixlwLcT73spQOItchCz0TDDDXAsn/SqHdm5Y2C5DF
         G9RMIzuoSF4ow89fGvJSNn3Pj6xJNPcJFZBgLnqY+wbZJfu5yHmD8ugKjZZVHB65Ks
         aXxdVb7moS1BPvEKy8xvReWlrrF/hVAf2CUKeny8=
Date:   Fri, 23 Nov 2018 08:46:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.83
Message-ID: <20181123074659.GA12056@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.83 kernel.

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

 Makefile                                        |    2=20
 arch/arm/boot/dts/r8a7791.dtsi                  |    2=20
 arch/arm/boot/dts/r8a7793.dtsi                  |    2=20
 arch/x86/kernel/cpu/bugs.c                      |   57 ++-----------------=
-----
 drivers/net/dsa/microchip/ksz_common.c          |   10 ++--
 drivers/net/ethernet/broadcom/bcmsysport.c      |   15 ++----
 drivers/net/ethernet/broadcom/tg3.c             |   18 ++++++-
 drivers/net/ethernet/ibm/ibmvnic.c              |    2=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c  |    1=20
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c |    6 +-
 drivers/net/phy/mdio-gpio.c                     |   10 ++--
 drivers/net/tun.c                               |    6 ++
 drivers/net/usb/smsc95xx.c                      |    9 +++
 include/uapi/linux/sctp.h                       |    2=20
 kernel/cpu.c                                    |   11 ----
 net/core/dev.c                                  |    4 +
 net/core/flow_dissector.c                       |    4 -
 net/ipv4/inet_fragment.c                        |   28 ++++++-----
 net/ipv4/ip_tunnel_core.c                       |    2=20
 net/ipv6/route.c                                |    7 ++
 net/sctp/socket.c                               |   26 ++--------
 net/sctp/stream.c                               |    1=20
 22 files changed, 95 insertions(+), 130 deletions(-)

Chris Paterson (2):
      ARM: dts: r8a7791: Correct critical CPU temperature
      ARM: dts: r8a7793: Correct critical CPU temperature

David Ahern (1):
      ipv6: Fix PMTU updates for UDP/raw sockets in presence of VRF

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
      Linux 4.14.83

Martin Schiller (1):
      net: phy: mdio-gpio: Fix working over slow can_sleep GPIOs

Matthew Cover (1):
      tuntap: fix multiqueue rx

Micha=C5=82 Miros=C5=82aw (1):
      ibmvnic: fix accelerated VLAN handling

Sabrina Dubroca (1):
      ip_tunnel: don't force DF when MTU is locked

Shalom Toledo (1):
      mlxsw: spectrum: Fix IP2ME CPU policer configuration

Siva Reddy Kallam (1):
      tg3: Add PHY reset for 5717/5719/5720 in change ring and flow control=
 paths

Stefan Wahren (1):
      net: smsc95xx: Fix MTU range

Subash Abhinov Kasiviswanathan (1):
      net: qualcomm: rmnet: Fix incorrect assignment of real_dev

Tristram Ha (1):
      net: dsa: microchip: initialize mutex before use

Xin Long (3):
      sctp: not allow to set asoc prsctp_enable by sockopt
      sctp: fix strchange_flags name for Stream Change Event
      sctp: not increase stream's incnt before sending addstrm_in request

=EB=B0=B0=EC=84=9D=EC=A7=84 (1):
      flow_dissector: do not dissect l4 ports for fragments


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlv3sHMACgkQONu9yGCS
aT4ybhAA2FN4MjNaE761Exrjv7KzVkC+ZCarqxHm97513inQdbBE5iYT4pfRTb5u
9TdZRCVr60QOBFK6U+eOrR8tJ6NeAgBb0tZxuD6B0cwzcl9e11ODD8phhtwszHn7
Jypp0x0nuQm0HTGzEoo5cEBi6ketuA0g8BIEI3sMK+Qw/GKvphKta0h85u368alW
9l7mQHAupFiLnjgHLpKyWOjvihY/9EMhiBkzJK97eux67/sBFC2Cby+Z4W09O1BG
djyPONgfYPk1VUOOnYbCaqFFusr+cJ/9vIhgVWzgdc0ZANLTlxkiGWMq1R2ALOTS
C2P6nt5JG4jn/qyjkdQQJcQq00ARYBVoPGzJwnqlvH+mACn28X531MH5T/hx+aKt
/E4M9xzWHAq9vGGSIuSw1YjhIoFWzcf+CKwYjcE6bFmXGsp2xURz+5EI53dw6DOw
x1xBexzkZW7PkUKGNLaA+wW/KIk2Jxe6+l+Aqo0h/8vrE4p5FmcXul75b+FO1GMV
2OUwv7dBjHXi1BvUAHzYQQneACu1su4OGPwN5SBZbpn1iUCCCaVM/ytO1xEoxLOK
N9By/wyw8eyG1XLO5q2gefT+2MEbph75WonbSK0ruulGATygjJvoADCkCdmD8jqG
6JhyZVEsiUusT+RYLZa5I32sUsTVoePY45n/8Uf4ncSOttCZkUk=
=nPy+
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
