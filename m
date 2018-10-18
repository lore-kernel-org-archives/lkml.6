Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1F1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611BD208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZuIkgna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611BD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeJRRD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbeJRRD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:03:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73E52208E4;
        Thu, 18 Oct 2018 09:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539853435;
        bh=3P8RdLaRufDxzIAnhcE2GcQ9BbT2vhd9yybd6OUiGmQ=;
        h=Date:From:To:Cc:Subject:From;
        b=nZuIkgna+TrG29tOThqK1FDNe4IuFWnxKrG+FFKiYFBdkMLWqbjytdWtjL1kRdSVq
         R0Hcb1rAElL2FRHIW7VRSWqoOEQ+Zxe1VGOSk15HEVvXjyWRcE3sBMMuEtJezPdVeF
         5mLNlLDbFbiy/ElLANHL0RYpSNonMjp9UH4XjY/8=
Date:   Thu, 18 Oct 2018 11:03:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.134
Message-ID: <20181018090352.GA26653@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.134 kernel.

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

 Documentation/devicetree/bindings/net/macb.txt        |    1=20
 Documentation/networking/ip-sysctl.txt                |   13=20
 Makefile                                              |    2=20
 arch/arm/boot/dts/sama5d3_emac.dtsi                   |    2=20
 arch/x86/include/uapi/asm/kvm.h                       |    1=20
 arch/x86/kvm/lapic.c                                  |   22=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c     |    2=20
 drivers/i2c/busses/i2c-scmi.c                         |    1=20
 drivers/mfd/omap-usb-host.c                           |   11=20
 drivers/net/bonding/bond_main.c                       |   43 -
 drivers/net/dsa/bcm_sf2.c                             |   12=20
 drivers/net/ethernet/broadcom/bcmsysport.c            |   22=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c             |   13=20
 drivers/net/ethernet/cadence/macb.c                   |    8=20
 drivers/net/ethernet/hisilicon/hns/hnae.c             |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c         |   30=20
 drivers/net/ethernet/marvell/mvpp2.c                  |   10=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h           |    8=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h   |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h        |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c        |   12=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |    5=20
 drivers/net/team/team.c                               |    5=20
 drivers/net/usb/qmi_wwan.c                            |    1=20
 drivers/net/usb/smsc75xx.c                            |    1=20
 drivers/scsi/qla2xxx/qla_target.h                     |    4=20
 drivers/target/iscsi/iscsi_target.c                   |   22=20
 drivers/usb/host/xhci-hub.c                           |   18=20
 drivers/video/fbdev/aty/atyfb.h                       |    3=20
 drivers/video/fbdev/aty/atyfb_base.c                  |    7=20
 drivers/video/fbdev/aty/mach64_ct.c                   |   10=20
 fs/ext4/xattr.c                                       |    2=20
 include/linux/netdevice.h                             |    7=20
 include/linux/rhashtable.h                            |    4=20
 include/linux/skbuff.h                                |   34 -
 include/net/bonding.h                                 |    7=20
 include/net/inet_frag.h                               |  133 +---
 include/net/inet_sock.h                               |    6=20
 include/net/ip.h                                      |    1=20
 include/net/ip_fib.h                                  |    1=20
 include/net/ipv6.h                                    |   26=20
 include/uapi/linux/snmp.h                             |    1=20
 lib/rhashtable.c                                      |    5=20
 mm/vmstat.c                                           |    1=20
 net/core/dev.c                                        |   28=20
 net/core/rtnetlink.c                                  |    6=20
 net/core/skbuff.c                                     |   31=20
 net/dccp/input.c                                      |    4=20
 net/dccp/ipv4.c                                       |    4=20
 net/ieee802154/6lowpan/6lowpan_i.h                    |   26=20
 net/ieee802154/6lowpan/reassembly.c                   |  148 ++--
 net/ipv4/fib_frontend.c                               |   12=20
 net/ipv4/fib_semantics.c                              |   50 +
 net/ipv4/inet_connection_sock.c                       |    5=20
 net/ipv4/inet_fragment.c                              |  379 ++---------
 net/ipv4/ip_fragment.c                                |  573 +++++++++----=
-----
 net/ipv4/ip_sockglue.c                                |    3=20
 net/ipv4/ip_tunnel.c                                  |    9=20
 net/ipv4/proc.c                                       |    7=20
 net/ipv4/tcp_input.c                                  |   37 -
 net/ipv4/tcp_ipv4.c                                   |    4=20
 net/ipv6/addrconf.c                                   |    4=20
 net/ipv6/ip6_tunnel.c                                 |   13=20
 net/ipv6/netfilter/nf_conntrack_reasm.c               |  100 +--
 net/ipv6/proc.c                                       |    5=20
 net/ipv6/raw.c                                        |   29=20
 net/ipv6/reassembly.c                                 |  212 +++---
 net/netlabel/netlabel_unlabeled.c                     |    3=20
 sound/hda/hdac_controller.c                           |    8=20
 sound/soc/codecs/sigmadsp.c                           |    3=20
 sound/soc/codecs/wm8804-i2c.c                         |   15=20
 tools/perf/scripts/python/export-to-postgresql.py     |    9=20
 tools/testing/selftests/efivarfs/config               |    1=20
 tools/testing/selftests/memory-hotplug/config         |    1=20
 75 files changed, 1134 insertions(+), 1123 deletions(-)

Adrian Hunter (1):
      perf script python: Fix export-to-postgresql.py occasional failure

Amber Lin (1):
      drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7

Dan Carpenter (2):
      scsi: qla2xxx: Fix an endian bug in fcpcmd_is_corrupted()
      ipv4: frags: precedence bug in ip_expire()

Daniel Rosenberg (1):
      ext4: Fix error code in ext4_xattr_set_entry()

Danny Smith (1):
      ASoC: sigmadsp: safeload should not have lower byte limit

Edgar Cherkasov (1):
      i2c: i2c-scmi: fix for i2c_smbus_write_block_data

Eric Dumazet (25):
      ipv4: fix use-after-free in ip_cmsg_recv_dstaddr()
      rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096
      tcp/dccp: fix lockdep issue when SYN is backlogged
      inet: make sure to grab rcu_read_lock before using ireq->ireq_opt
      inet: frags: change inet_frags_init_net() return value
      inet: frags: add a pointer to struct netns_frags
      inet: frags: refactor ipfrag_init()
      inet: frags: refactor ipv6_frag_init()
      inet: frags: refactor lowpan_net_frag_init()
      ipv6: export ip6 fragments sysctl to unprivileged users
      rhashtable: add schedule points
      inet: frags: use rhashtables for reassembly units
      inet: frags: remove some helpers
      inet: frags: get rif of inet_frag_evicting()
      inet: frags: remove inet_frag_maybe_warn_overflow()
      inet: frags: break the 2GB limit for frags storage
      inet: frags: do not clone skb in ip_expire()
      ipv6: frags: rewrite ip6_expire_frag_queue()
      rhashtable: reorganize struct rhashtable layout
      inet: frags: reorganize struct netns_frags
      inet: frags: get rid of ipfrag_skb_cb/FRAG_CB
      inet: frags: fix ip6frag_low_thresh boundary
      net: speed up skb_rbtree_purge()
      net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends
      net: add rb_to_skb() and other rb tree helpers

Florian Fainelli (3):
      net: dsa: bcm_sf2: Call setup during switch resume
      net: dsa: bcm_sf2: Fix unbind ordering
      net: systemport: Fix wake-up interrupt race during resume

Florian Westphal (1):
      ipv6: defrag: drop non-last frags smaller than min mtu

Giacinto Cifelli (1):
      qmi_wwan: Added support for Gemalto's Cinterion ALASxx WWAN interface

Greg Kroah-Hartman (1):
      Linux 4.9.134

Ido Schimmel (1):
      team: Forbid enslaving team device to itself

Jann Horn (1):
      mm/vmstat.c: fix outdated vmstat_text

Jeff Barnhill (1):
      net/ipv6: Display all addresses in output of /proc/net/if_inet6

Jongsung Kim (1):
      stmmac: fix valid numbers of unicast filter entries

Laura Abbott (1):
      scsi: iscsi: target: Don't use stack buffer for scatterlist

Lei Yang (2):
      selftests/efivarfs: add required kernel configs
      selftests: memory-hotplug: add required configs

Mahesh Bandewar (1):
      bonding: avoid possible dead-lock

Mathias Nyman (1):
      xhci: Don't print a warning when setting link state for disabled ports

Maxime Chevallier (1):
      net: mvpp2: Extract the correct ethtype from the skb for tx csum offl=
oad

Michael Chan (1):
      bnxt_en: Fix TX timeout during netpoll.

Mikulas Patocka (1):
      mach64: detect the dot clock divider correctly on sparc

Nicolas Ferre (2):
      net: macb: disable scatter-gather for macb on sama5d3
      ARM: dts: at91: add new compatibility string for macb on sama5d3

Paolo Abeni (2):
      ip6_tunnel: be careful when accessing the inner header
      ip_tunnel: be careful when accessing the inner header

Peter Oskolkov (5):
      ip: discard IPv4 datagrams with overlapping segments.
      net: modify skb_rbtree_purge to return the truesize of all purged skb=
s.
      ip: use rb trees for IP frag queue.
      ip: add helpers to process in-order fragments faster.
      ip: process in-order fragments efficiently

Pierre-Louis Bossart (1):
      ASoC: wm8804: Add ACPI support

Sabrina Dubroca (1):
      net: ipv4: update fnhe_pmtu when first hop's MTU changes

Sean Tranchetti (1):
      netlabel: check for IPV4MASK in addrinfo_get

Shahed Shaikh (1):
      qlcnic: fix Tx descriptor corruption on 82xx devices

Taehee Yoo (1):
      ip: frags: fix crash in ip_do_fragment()

Tony Lindgren (1):
      mfd: omap-usb-host: Fix dts probe of children

Vitaly Kuznetsov (1):
      x86/kvm/lapic: always disable MMIO interface in x2APIC mode

Wei Wang (1):
      ipv6: take rcu lock in rawv6_send_hdrinc()

Yu Zhao (2):
      sound: enable interrupt after dma buffer initialization
      net/usb: cancel pending work when unbinding smsc75xx

Yunsheng Lin (1):
      net: hns: fix for unmapping problem when SMMU is on


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvITHYACgkQONu9yGCS
aT6ObhAAtHPi4Mgn3MgyWW0ZDyyedVqmvo9DOtrdo4firfjPllRgY/Yt/RuSCSMZ
BN2zQVx6jxwbpas26xYzOKmcsDFI8bnkGVGFlFINVmEfnAmLXP7hD+5nv35/+HZR
N3awrI84upU5l4UkMcqMKeaPd2RzXNR1y3ejCLu9t4Ooiq9884qQxOFpym2G83OK
4Am0uV9xjnCg39g9UWdVuPH3yxGw6cn+s1p1F6/lj1yNzOdIAgcFYjXjPWPneF4Q
51OLXgGoO3Roy2ZnK7Bs+1K6uQtQg0yjMw01UfAZjHq+x78cUb40YNiC22AAQTuE
8L4VqZc1M6N9QOlGns+WGrWs8OK/sy0z2j9gTUkwTsdX+6vgRpoN7CMHu2rmLSzr
uh5QiWFcviL08oGV7NeqTQpZqiaQ+GbMM/Gs/D8l36wOCEU/nPkIqE5oQbAuR7cQ
y/paK18fLI+BVmumKnMxs6i3VxTX7BXYPDKRT0VPEqXcws5XgJybUHsoMQLMuNuR
h7J6ahOd/Nl9JaVPFVQlbl6mM/qo/To8+eCXQ7SZKDCt2nBpsKXV1TZdQll99I/3
4A+5P8667fX/Im2huwtr0Jyr4ZKCteLQf9JJfEysnkhTDmMKyZ7cKSC4GMaMhI3Q
nutWdvrhlczLAPcVEk+zH4KOPPBcOyknQY0Bnsz+NR+2aohHRYY=
=0IDa
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
