Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B22CC10F07
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EC020684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550917435;
	bh=ayHCnGzOtNByR8pg+qIDILBZnYGcEjZbKCAutnifCQ0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Bi16WEgwxR1AtalNR5t5jf6uDqVbfHZkmm+o2SeW1O3IFI96iDntkEDSDFJ46xFhS
	 37JI32r1URe8YJyV44pojaM+ikctiP6ur1QjBprWA+j51UGBP54KqKY0ckoUTHNYXD
	 p7Ew4aMgTqYWGuTn8qq5ordAOxkFjmEJzNWQPhPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfBWKXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfBWKXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:23:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E17B20684;
        Sat, 23 Feb 2019 10:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550917432;
        bh=ayHCnGzOtNByR8pg+qIDILBZnYGcEjZbKCAutnifCQ0=;
        h=Date:From:To:Cc:Subject:From;
        b=lQ/H9g40aWHZs8QSvDzDwlzRGW17pq1+XZT8vasnbnROylehrnBwo21lDyi85X3hU
         OOs/umJmPR592WwaC9/GZbtqTVbp9kKfmZsVaT4uxpTBqp+C4RY2rm8+3icaDSn65I
         b7on90YoKdaeuviRyWS7O1PEe76Ppbn0OMaj/wYM=
Date:   Sat, 23 Feb 2019 11:23:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.12
Message-ID: <20190223102349.GA25451@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.12 kernel.

All users of the 4.20 kernel series must upgrade.

The updated 4.20.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.20.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                             |    2 -
 arch/arm64/include/asm/memory.h                      |   11 ++++++
 arch/arm64/kernel/setup.c                            |    1=20
 crypto/af_alg.c                                      |    4 +-
 drivers/firmware/efi/efi.c                           |    4 --
 drivers/firmware/efi/libstub/arm-stub.c              |    3 -
 drivers/hwmon/lm80.c                                 |    4 +-
 drivers/isdn/mISDN/timerdev.c                        |    2 -
 drivers/mmc/host/meson-gx-mmc.c                      |    3 +
 drivers/net/dsa/mv88e6xxx/chip.c                     |   28 ++++++++++++---
 drivers/net/ethernet/marvell/sky2.c                  |    2 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c       |   12 +++---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c   |    9 +++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c |   22 ++++++------
 drivers/net/ethernet/ti/netcp_core.c                 |    2 -
 drivers/net/phy/xilinx_gmii2rgmii.c                  |    5 ++
 drivers/net/vxlan.c                                  |   14 ++++++-
 drivers/pci/pci.c                                    |    3 +
 drivers/target/target_core_transport.c               |    2 -
 drivers/vhost/vhost.c                                |    2 -
 include/linux/efi.h                                  |    7 ---
 include/linux/memblock.h                             |    3 -
 include/linux/netdev_features.h                      |   24 ++++++++++++-
 include/net/ax25.h                                   |   12 ++++++
 include/net/inetpeer.h                               |    1=20
 mm/memblock.c                                        |   11 +++++-
 net/ax25/ax25_ip.c                                   |    4 +-
 net/ax25/ax25_route.c                                |   19 ++++------
 net/core/dev.c                                       |    4 +-
 net/core/skbuff.c                                    |    4 ++
 net/ipv4/inetpeer.c                                  |    1=20
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c          |    7 +++
 net/ipv4/route.c                                     |    7 ++-
 net/ipv4/tcp.c                                       |    2 -
 net/ipv4/tcp_ipv4.c                                  |    7 ++-
 net/ipv6/addrconf.c                                  |    3 +
 net/ipv6/ip6_gre.c                                   |   34 +++++++++++---=
-----
 net/packet/af_packet.c                               |    3 +
 net/vmw_vsock/vmci_transport.c                       |    4 ++
 net/x25/af_x25.c                                     |    6 +--
 40 files changed, 196 insertions(+), 102 deletions(-)

Alexander Duyck (1):
      net: Do not allocate page fragments that are not skb aligned

Alexandre Torgue (1):
      net: stmmac: handle endianness in dwmac4_get_timestamp

Ard Biesheuvel (2):
      arm64, mm, efi: Account for GICv3 LPI tables in static memblock reser=
ve table
      efi/arm: Revert "Defer persistent reservations until after paging_ini=
t()"

David S. Miller (1):
      net: Add header for usage of fls64()

Eric Dumazet (6):
      vxlan: test dev->flags & IFF_UP before calling netif_rx()
      tcp: clear icsk_backoff in tcp_write_queue_purge()
      tcp: tcp_v4_err() should be more careful
      net/x25: do not hold the cpu too long in x25_new_lci()
      mISDN: fix a race in dev_expire_timer()
      ax25: fix possible use-after-free

Greg Kroah-Hartman (1):
      Linux 4.20.12

Hauke Mehrtens (1):
      net: Fix for_each_netdev_feature on Big endian

Jann Horn (1):
      netfilter: nf_nat_snmp_basic: add missing length checks in ASN.1 cbs

Jason Wang (1):
      vhost: correctly check the return value of translate_desc() in log_us=
ed()

John David Anglin (1):
      dsa: mv88e6xxx: Ensure all pending interrupts are handled prior to ex=
it

Jose Abreu (1):
      net: stmmac: Fix a race in EEE enable callback

Kai-Heng Feng (1):
      sky2: Increase D3 delay again

Logan Gunthorpe (1):
      PCI: Fix __initdata issue with "pci=3Ddisable_acs_redir" parameter

Lorenzo Bianconi (2):
      net: ipv4: use a dedicated counter for icmp_v4 redirect packets
      net: ip6_gre: initialize erspan_ver just for erspan tunnels

Mao Wenan (1):
      net: crypto set sk to NULL when af_alg_release.

Martin Blumenstingl (1):
      mmc: meson-gx: fix interrupt name

Murali Karicheri (1):
      net: netcp: Fix ethss driver probe issue

Nicolas Dichtel (1):
      af_packet: fix raw sockets over 6in4 tunnel

Paolo Abeni (1):
      vsock: cope with memory allocation failure at socket creation time

Paul Kocialkowski (1):
      net: phy: xgmiitorgmii: Support generic PHY status read

Petr Machata (1):
      mlxsw: __mlxsw_sp_port_headroom_set(): Fix a use of local variable

Wei Yongjun (2):
      scsi: target/core: Use kmem_cache_free() instead of kfree()
      hwmon: (lm80) Fix missing unlock on error in set_fan_div()

Zhiqiang Liu (1):
      net: fix IPv6 prefix route residue


--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxxHzQACgkQONu9yGCS
aT7Fcw/9GzVPPVc7riB4lnXXizWieR+K5+awc4qXNcE5HYYDmXIXmL7wBkPEuiMm
6L2AgXwyNwaRBXKVY7NVHRAxFhIVqIvxT8ZlwasC5d/mqqLXyNpfwwfoROv5i9Hm
+EU/pSjFfnLFeoy8rLrKRU0dM1dh11zn8dRuDL0Ipm9+DSZjOYoCoJI/y7oGHTlB
PGfVMFAocOmzodVcbMStyAoF5gj6vNBwE6et2CvK0oMX2tvakh7TlVj4u34EI0sF
7sGqx/sgJYwoMAaxZVWN3RJ58pvJG5w3cGQJlCylWHsbawR44XSnJSILJjSaBqTj
uFYHx02/tgQpzUQNVIadbFhPe+XrkWiCgbrRRj2gCsug6mxK7kemWiKOV+nFFm6x
V3B+WZ0ZP/BVOf+2WHT4hsMtdKP3L1uM6OAO3YlxyX2l/1oTDYSec07IaxIW0auL
oe3O2fdQFgD6sDazoBAqRvzkTyc+eqBmqVKr66zH4DQAwSSX3EZrNRO8OdWw/Thb
Q4CtxQQYAJInd5jyeBgBZ33NxsXh4I82jnXdduM0qj4ncCz0dBP5/D+6+KyVgIQ1
mfJAT+bcguirABKh/iRSRlGRxiJTH6csyCzNYoD4Tool9xG5VuAwFqCf2xcrHaAR
kSjICv9I902lc5iaQ3gs8pDJjRu8Ek10PTDEPRUk4e/PBasBhxg=
=R4mO
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
