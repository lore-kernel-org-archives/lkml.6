Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2928030-1526822509-2-16254224852930656322
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526822508; b=kmM3LO2JrHNGA9emVwMnw42g5dc9kcK1OmJ3TEdhemX5iM85kL
    xc1YP+fc+KoVAdjmWvpcbzdTfvYXpWG7AETFDqCFpd6bvzlmq632fMg57ui83+rD
    zn5VF/2/7INzpjRW/PSHT4bHNX/OEIN/WL2n8DntC6A254zf37qt6QKYsBHgWbxk
    qVinOjp4ZjEJn/tYV1/7kcyACma5+xavlVq7J3nti3hASVyC6VQMTjNIKE55g+ym
    Vm5/RRsndwYJGn0X4u2JnaC+nYsBHx23gloukP7L9vV9nMBgAhCaSy85G5y27IjM
    jueGnTfFy18mz7fGj9rogJNgDyUT8uEUz3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526822508;
    bh=NblH2kI4ptxoS0ET+9ZT7b7ZQtnqIQaJ/0NiIQwli4Y=; b=CVTGIVc+WFet
    uHTqFqCZrUi3nYLLJnXZbpQGjAlPptRgwUR3GIK1t+b1edeW9o0Ylwpalxn4DrGj
    jJGcWpng1t1FTdhTz1dGi3zrpnVZe/SJTrI0NS1XjxpW3/YOUb3i33XF7EkQEvww
    d6DN0z1EAYFmEM6yuVvn6LW9KZZ7JZGiwdgwvTKQX0KsQnjBDr2WUh0JTl0gDoEF
    y4Tx5JEo0iYxgtakq7wTykP7Pkk6MCJYvFQFWXBtCFqTA/RlPj6ae0xILS3KclJa
    tC/2SoBIaFnnmrUFj3Fj0JmWGiZuQsAkO7okioBWxmFyApRaB4itSA9LCxnrmtxz
    SYih+zo6sA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=kWgozCwu x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=kWgozCwu x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGzup7CSCRBk/3H7DxpS6FOH+wmq+VpEY9c1pf7ArwH1p8HKulmN+71xCJWoAZZUfPRN1KJKxQZJ6/lxUQKqlTJxiZyS6D3ueYREwuAXN6hrsXtBQO8h
    A1SFmmQcOYpG0LBnBhiVLtB6LXwMlvcVStBKZFNGWZsMwzoLG5rYecWHWY5cKYovXcdvlFjv3jGmqd8snWUJUA8y4oqvrYemPukx6MJfr55YhZzz7wS643nT
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=rCGKQLpQQFR4_5Fa5eAA:9 a=wPNLvfGTeEIA:10 a=SN2NjdZH3A3t9bL-aIoA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbeETNVc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 20 May 2018 09:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbeETNVa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 20 May 2018 09:21:30 -0400
Date: Sun, 20 May 2018 15:21:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.10
Message-ID: <20180520132112.GA7894@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.10 kernel.

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

 Makefile                                                 |    2=20
 drivers/infiniband/hw/mlx5/main.c                        |    2=20
 drivers/net/bonding/bond_alb.c                           |   15 +
 drivers/net/bonding/bond_main.c                          |    2=20
 drivers/net/ethernet/broadcom/bcmsysport.c               |   16 +-
 drivers/net/ethernet/broadcom/tg3.c                      |    9 -
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c          |   16 ++
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c           |    8 -
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h             |    7=20
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c       |    8 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c          |    7=20
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c          |   20 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c        |   11 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c        |   23 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c               |    4=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |   12 -
 drivers/net/ethernet/netronome/nfp/flower/action.c       |   10 +
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h         |    5=20
 drivers/net/ethernet/realtek/8139too.c                   |    2=20
 drivers/net/ethernet/realtek/r8169.c                     |    3=20
 drivers/net/ethernet/sun/niu.c                           |    5=20
 drivers/net/ethernet/ti/cpsw.c                           |    2=20
 drivers/net/hyperv/netvsc_drv.c                          |    3=20
 drivers/net/hyperv/rndis_filter.c                        |    2=20
 drivers/net/phy/sfp-bus.c                                |    2=20
 drivers/net/usb/qmi_wwan.c                               |   12 +
 drivers/scsi/aacraid/commsup.c                           |    8 -
 fs/proc/base.c                                           |    8 -
 include/linux/mlx5/driver.h                              |   12 -
 include/linux/mm.h                                       |    1=20
 include/net/bonding.h                                    |    1=20
 include/net/tls.h                                        |    1=20
 mm/gup.c                                                 |    3=20
 net/bridge/br_if.c                                       |    4=20
 net/compat.c                                             |    6=20
 net/dccp/ccids/ccid2.c                                   |   14 +
 net/dccp/timer.c                                         |    2=20
 net/ipv4/ping.c                                          |    7=20
 net/ipv4/route.c                                         |  119 ++++++----=
-----
 net/ipv4/tcp.c                                           |    5=20
 net/ipv4/tcp_bbr.c                                       |    4=20
 net/ipv4/udp.c                                           |   11 -
 net/ipv6/route.c                                         |    7=20
 net/ipv6/udp.c                                           |    4=20
 net/llc/af_llc.c                                         |    3=20
 net/nsh/nsh.c                                            |    4=20
 net/openvswitch/flow_netlink.c                           |    9 -
 net/rds/recv.c                                           |    1=20
 net/sched/act_skbmod.c                                   |    5=20
 net/sched/cls_api.c                                      |    2=20
 net/sched/sch_fq.c                                       |   37 +++-
 net/sctp/associola.c                                     |   30 +++
 net/sctp/inqueue.c                                       |    2=20
 net/sctp/ipv6.c                                          |    3=20
 net/sctp/sm_statefuns.c                                  |   88 +++++------
 net/sctp/stream.c                                        |    2=20
 net/sctp/ulpevent.c                                      |    1=20
 net/smc/af_smc.c                                         |   18 +-
 net/tipc/socket.c                                        |    3=20
 net/tls/tls_main.c                                       |    8 +
 60 files changed, 397 insertions(+), 244 deletions(-)

Adi Nissim (1):
      net/mlx5: E-Switch, Include VF RDMA stats in vport statistics

Andre Tomt (1):
      net/tls: Fix connection stall on partial tls record

Andrey Ignatov (1):
      ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg

Antoine Tenart (1):
      net: phy: sfp: fix the BR,min computation

Bj=F8rn Mork (1):
      qmi_wwan: do not steal interfaces from class drivers

Christophe JAILLET (2):
      net/mlx4_en: Fix an error handling path in 'mlx4_en_init_netdev()'
      mlxsw: core: Fix an error handling path in 'mlxsw_core_bus_device_reg=
ister()'

Dave Carroll (1):
      scsi: aacraid: Correct hba_send to include iu_type

Dave Watson (1):
      net/tls: Don't recursively call push_record during tls_write_space ca=
llbacks

Debabrata Banerjee (2):
      bonding: do not allow rlb updates to invalid mac
      bonding: send learning packets for vlans on slave

Eric Dumazet (8):
      dccp: fix tasklet usage
      llc: better deal with too small mtu
      net_sched: fq: take care of throttled flows before reuse
      rds: do not leak kernel memory to user land
      ipv6: fix uninit-value in ip6_multipath_l3_keys()
      nsh: fix infinite loop
      tcp: restore autocorking
      tipc: fix one byte leak in tipc_sk_set_orig_addr()

Florian Fainelli (1):
      net: systemport: Correclty disambiguate driver instances

Greg Kroah-Hartman (1):
      Linux 4.16.10

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: fix packet leaking in dual_mac mode

Hangbin Liu (2):
      bridge: check iface upper dev when setting master via ioctl
      ipv4: reset fnhe_mtu_locked after cache route flushed

Heiner Kallweit (1):
      r8169: fix powering up RTL8168h

Huy Nguyen (1):
      net/mlx5e: DCBNL fix min inline header size for dscp

Ido Schimmel (1):
      mlxsw: spectrum_switchdev: Do not remove mrouter port from MDB's port=
s list

Ingo Molnar (1):
      8139too: Use disable_irq_nosync() in rtl8139_poll_controller()

Israel Rukshin (1):
      net/mlx5: Fix mlx5_get_vector_affinity function

Jianbo Liu (1):
      net/mlx5e: Allow offloading ipv4 header re-write for icmp

Jiri Pirko (1):
      net: sched: fix error path in tcf_proto_create() when modules are not=
 configured

John Hurley (1):
      nfp: flower: set tunnel ttl value to net default

Julian Anastasov (1):
      ipv4: fix fnhe usage by non-cached routes

Lance Richardson (1):
      net: support compat 64-bit time in {s,g}etsockopt

Michael Chan (1):
      tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().

Mohammed Gamal (1):
      hv_netvsc: Fix net device attach on older Windows hosts

Moshe Shemesh (1):
      net/mlx4_en: Verify coalescing parameters are in range

Neal Cardwell (1):
      tcp_bbr: fix to zero idle_restart only upon S/ACKed data

Paolo Abeni (1):
      udp: fix SO_BINDTODEVICE

Rob Taglang (1):
      net: ethernet: sun: niu set correct packet size in skb

Roi Dayan (1):
      net/mlx5e: Err if asked to offload TC match on frag being first

Roman Mashak (1):
      net sched actions: fix refcnt leak in skbmod

Stefano Brivio (1):
      openvswitch: Don't swap table in nlattr_set() after OVS_ATTR_NESTED i=
s found

Stephen Hemminger (1):
      hv_netvsc: set master device

Talat Batheesh (1):
      net/mlx5: Avoid cleaning flow steering table twice during error flow

Tariq Toukan (1):
      net/mlx5e: TX, Use correct counter in dma_map error flow

Ursula Braun (2):
      net/smc: restrict non-blocking connect finish
      net/smc: keep clcsock reference in smc_tcp_listen_work()

Willy Tarreau (1):
      proc: do not access cmdline nor environ from file-backed areas

Xin Long (6):
      sctp: delay the authentication for the duplicated cookie-echo chunk
      sctp: fix the issue that the cookie-ack with auth can't get processed
      sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
      sctp: remove sctp_chunk_put from fail_mark err path in sctp_ulpevent_=
make_rcvmsg
      sctp: use the old asoc when making the cookie-ack chunk in dupcook_d
      sctp: clear the new asoc's stream outcnt in sctp_stream_update

Yuchung Cheng (1):
      tcp: ignore Fast Open on repair mode


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsBdkgACgkQONu9yGCS
aT4kPw//aMGhoCorfuec9E8tLjVrVNtNx9maSxbaXErKCsl7lRVyO9qIlTT2HCWw
eHCzUW8+WWGNc5RgD8UqMman2iVois0Nh9+h7A1P+kuC/c5UQAUHlZpBrLaj+q9Y
X0SV8Xnq62M5+KT0CpFuQDALpaEjOukHDrhEgkR06QTR61//s5MH+tBLP/ZGV13w
lhjmXy1Svdeza+za2ZSdh1qb7+0JbkaWBJsQsTkXr7y7f06rXa/O7A1hpXtKCGd+
PBRGcUBKihQnvUD+VyGXqytvDpQ2Ea4BLlSu/AyR0C7/KR5Cwp7TI4FSqVqHk5Zl
stdV9geoCY2tD4jVjVxwWe/eTVbqRNQeMChxEs61lrUEsij0nfswbXCctKR1hnqn
TMMTdUOL0mRqfBdY153SL10xF3z9hLEfb1tJEeiX2XxfB/Z5SCUyZUYj6oj5oPq1
1hqm9W4d7PD2RIu8J7CBJsgqYJ3Pjma6W7PjnQk3BtAVyWwvfSbbicjlVk181oCS
ACBswMTXidPkgS8Ad4DnjaqWC1GRpQw0vLb1MbplAh3VttzSiXa97QlLWZcS4CxC
4+C0ecRybXL6lH9CBRNb1oQ4jXXOem1dGPCqyv3x6/mDvJmy/hYXb2VCMRGcMEFX
nnRsAdmPHVTuTnAxXtUBmBFah1rCqyIXs32ZkEG2CfFZas9OHQI=
=NaL0
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
