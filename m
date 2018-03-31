Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2190098-1522513016-2-14085892503554183732
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522513016; b=AW5tEWcr53fS+9rtc8CMcFvz15cMu50LZc1eG8QPy/HMUgHAc2
    wNOezBf8D2J5j8lD4VKRShLflA/aACy2c8sus6R/0wHrv927PW3LYVmCl7ONvtt3
    rVpt61UpoZ+J2jLTtKJFpPXnmIssPEIwnDBwJ5cVwBtiPP/w5RKhhvmvAdUocZLx
    uSn4MX6cVJAzt+XXq/QLl+iPf5Kefs5/k24ZrRPoDVrMLeJk3zW12HBydQHBknLn
    TFHiB1xcmAqLNPIA/QOivrTAknn18bgB3Njht9sRL9WrfjTHHlFq9YWveBBOEpD9
    ChvoswoBBMBvyaWTPv0jk27lfPOnbC1K/tAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1522513016;
    bh=b6kCgXFOxb3PUVQhm6Eh9of97QpuoBWOFuf3PJvWkJg=; b=d/ATcu5TCoQK
    MoRwMZj+yZ2kBs7ielf/TiWSU5xpXFVHbm1u/vBZfWP7+SfcdFTVNJOqJhIv82uV
    i4LR+qpKwUSHiqQ/50gouc9GVnKpbpYR/TKodE3/1UJ6ToKW3sokfSCpFzKktEq/
    adQV/TDrbKcnhWabsLugrS+I+GURHlsh7wJAqS1omDiQwysHxKy/3U20QBO3ZUK1
    Av2p3cbb2FjIrHpHEW/5ZVCXLbRCirieD8BTI2d26A4KtbICtA/jJLMeNl53rLXU
    ONmN2KMf8kiYII6rlsZeGFjV1Z/aaaYEUSInDOJ/HQu8T5BvbED9i2dbRv3q0rGL
    E4kgTapHhg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJaTT0A35Y2S8ipCOmmQvZvy+CojsojdvEu+n1WNh/QUlnFQazIjqt+5z9I6z453qLH0KlCGt1ZbujIQTyZpE82VSU7IQJmOY4pZDXOHYJ3nZmilVqWW
    CXG9JtaU2P+5oTMzp0mYzlBbv4+lkYVRfNUi8EsKHNoFlkcFLpC7DtTIz7gEAk4gshJfzJVHFL0CefV7cdbeh0iVoD2FRTpnMcZUbPAl6s5mZFJyZw+oKDHo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=oiVWD607Nm8Nzq7NUBEA:9 a=QEXdDO2ut3YA:10 a=0x9cnyHKrBmE2bLminkA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbeCaQQb (ORCPT <rfc822;greg@kroah.com>);
        Sat, 31 Mar 2018 12:16:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38664 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbeCaQQ3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 31 Mar 2018 12:16:29 -0400
Date: Sat, 31 Mar 2018 18:16:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.92
Message-ID: <20180331161625.GA24993@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.92 kernel.

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

 Makefile                                      |    2 -
 drivers/net/ethernet/arc/emac_rockchip.c      |    6 +++-
 drivers/net/ethernet/broadcom/bcmsysport.c    |   33 +++++++++++----------=
-----
 drivers/net/ethernet/broadcom/bcmsysport.h    |    2 -
 drivers/net/ethernet/freescale/fec_main.c     |    2 +
 drivers/net/ethernet/hisilicon/hns/hns_enet.c |   22 +++++++----------
 drivers/net/ethernet/hisilicon/hns/hns_enet.h |    6 ++--
 drivers/net/ethernet/ti/cpsw.c                |    3 +-
 drivers/net/ppp/ppp_generic.c                 |   26 +++++++++++---------
 drivers/net/team/team.c                       |    4 +--
 drivers/s390/net/qeth_core_main.c             |   21 +++++++++++-----
 drivers/s390/net/qeth_l2_main.c               |    2 -
 drivers/s390/net/qeth_l3_main.c               |    2 -
 drivers/scsi/sg.c                             |    5 ++-
 drivers/soc/fsl/qbman/qman.c                  |   28 +++-------------------
 include/linux/cgroup-defs.h                   |    4 +--
 include/linux/rhashtable.h                    |    4 ++-
 include/net/sch_generic.h                     |   19 ++++++++++++++
 kernel/irq/manage.c                           |    4 ---
 lib/rhashtable.c                              |    4 ++-
 net/core/dev.c                                |   22 +++++++++++------
 net/core/skbuff.c                             |    2 -
 net/dccp/proto.c                              |    5 +++
 net/ieee802154/6lowpan/core.c                 |   12 ++++++---
 net/ipv4/inet_fragment.c                      |    3 ++
 net/ipv4/ip_sockglue.c                        |    6 +++-
 net/ipv6/ndisc.c                              |    3 +-
 net/iucv/af_iucv.c                            |    4 ++-
 net/kcm/kcmsock.c                             |   33 ++++++++++++++++++---=
-----
 net/l2tp/l2tp_core.c                          |    8 ++++--
 net/netlink/genetlink.c                       |    2 -
 net/sched/act_tunnel_key.c                    |    1=20
 net/sched/sch_netem.c                         |    2 -
 33 files changed, 180 insertions(+), 122 deletions(-)

Alexey Kodanev (2):
      sch_netem: fix skb leak in netem_enqueue()
      dccp: check sk for closed state in dccp_sendmsg()

Arkadi Sharshevsky (1):
      team: Fix double free in error path

Arvind Yadav (1):
      net/iucv: Free memory obtained by kzalloc

Christophe JAILLET (1):
      net: ethernet: arc: Fix a potential memory leak if an optional regula=
tor is deferred

David Ahern (1):
      net: Only honor ifindex in IP_PKTINFO if non-0

Eric Dumazet (3):
      ieee802154: 6lowpan: fix possible NULL deref in lowpan_device_event()
      net: use skb_to_full_sk() in skb_update_prio()
      l2tp: do not accept arbitrary sockets

Florian Fainelli (2):
      net: fec: Fix unbalanced PM runtime calls
      net: systemport: Rewrite __bcm_sysport_tx_reclaim()

Greg Kroah-Hartman (2):
      Revert "genirq: Use irqd_get_trigger_type to compare the trigger type=
 for shared IRQs"
      Linux 4.9.92

Guillaume Nault (1):
      ppp: avoid loop in xmit recursion detection code

Johannes Thumshirn (1):
      scsi: sg: don't return bogus Sg_requests

Julian Wiedmann (4):
      s390/qeth: free netdevice when removing a card
      s390/qeth: when thread completes, wake up all waiters
      s390/qeth: lock read device while queueing next buffer
      s390/qeth: on channel error, reject further cmd requests

Kirill Tkhai (1):
      net: Fix hlist corruptions in inet_evict_bucket()

Lorenzo Bianconi (1):
      ipv6: fix access to non-linear packet in ndisc_fill_redirect_hdr_opti=
on()

Madalin Bucur (1):
      soc/fsl/qbman: fix issue in qman_delete_cgr_safe()

Nicolas Dichtel (1):
      netlink: avoid a double skb free in genlmsg_mcast()

Paul Blakey (1):
      rhashtable: Fix rhlist duplicates insertion

Roman Mashak (1):
      net sched actions: return explicit error when tunnel_key mode is not =
specified

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (1):
      net: ethernet: ti: cpsw: add check for in-band mode setting with RGMI=
I PHY interface

Tom Herbert (1):
      kcm: lock lower socket in kcm_attach

Vinicius Costa Gomes (1):
      skbuff: Fix not waking applications when errors are enqueued

Yunsheng Lin (1):
      net: hns: Fix a skb used after free bug


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlq/tFgACgkQONu9yGCS
aT49XA/+PnI+JMOLAQzRTe/h659SnctlgdRGNua21TZVg8V+rxUry0guXOjNmbz6
NCQGYoKBq4V0jpVw3jqQ9seIql8w/Pdx5YXKBELkl0Dw5TmEfkeZcaQD0OmPQQZa
syA2PHpahKgTXOqA4Cm4szZo1rTPVmCGQZdNgyyU1lLw/wk4LMARRqKBXVOfhvZ8
3Ujtn5UBxQpnGSyQg79+urDEoeYsojpPrtJ3INJ+ofJuY30uPOm0j75BtVx6GDhG
lWid0XJrrR2pOj7lvEOBE5vCBe0D0gY0rTEtUiyCkRsQb7E6bk0TI7XJfGuabFmO
Qrb0RYIEtkjK7hjRJTsqCWtflFWt4GVeU+Zy8kI92xbgMGs0kteSx8hJALbpEOIP
+P0wxYz8NQvfzjEkaeg+ih6kflDGniK9zrnp5142DkUIN4uDbbMcxRmUMyjeCV+Q
40HT31M9WgPE2cuIXYtxjWjACg3GDc7cj5hxKqGutpSlGU0U4tJrFwIYecOhGcZR
en35wfMluKZZ5MvUI++hVARN4MAQABlX3mV5R0UNZuhJqZFam/3Eq6/hDvKUBF8f
A6yudbAkGSOhfxS9Pikkt4s+5bGqmuImCdYt+/P7zmTLoisnyPpQISGpb0ysEGVq
MtYWYhyXt8ie1PFOCucreifL7WODZRDzhpk9M+uconmsZBUa8E8=
=LN+/
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
