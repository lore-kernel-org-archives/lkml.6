Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2195729-1522513072-2-17474906692294771512
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
    1522513071; b=ULFrLSaCJu/sv+1P+yyzTTupSy3+IDwCsJyaPulxqHPy8wz9Ks
    YgYJF7w8pleBKg2w96fVP+vncpBDczko6hZSMk1MdUnsKOeSTYALDJnB4Z0Jqnnv
    YE5JsMhIA02ZnsNeffJd8Y7uYeB8GX4i7HHF5oBjXkcNIdtoGvV/kpKK0No16mVG
    U9JksPJvrVc0vodq/uddnCymBW9lhHjW7QRKYzBkorLBjEIddMcQGX9ieeNeRMd7
    DXsqFwP/Em3HmEoLnGeUe7r6tcfK1NvF1ixs6O+xOGxnpXMzsfqE9aEVZ1MUCzbS
    7UrlbP17u1eRDhhiphvYk10yGImhH5ry6w1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1522513071;
    bh=KnYbHMQ92jm91Pyuy93Dfly43TxEP4F7ehymnh/lhuQ=; b=cI8Nzlztqdwa
    F2ieB1fPsgNdftK14NXlSKF/VWMCJ563X5M8j0pRglSWXekrDAr0zQKFGhMJJT0U
    kU906iFqJYQvPekc0FIy5qilZtY/EpDDqefvFVsrGeyPtncg66r7Dj3v3KW+XXbW
    jrKHiCQEdEVEujeqUNfhjEPeqtyjekeswBwe35jrjlQol5isFH3R41BNMNNQBVF5
    dkgxqfX0E7OnZdW12XRjK4gY7CJ7q2JB1xKI/1bvQyBxA8ObPTb4fTYpZG62/eUV
    NzqJaI8NZy7i0mKID80o2Fou6WXbB3U/XjkPWjz+v/kG4k/KDXUA2C2bbltw69N1
    ynvuE8cZsQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfISPkUML3W7Yk3Msc0ijht1TnhVAnuYO7/WIOJ/cUdTN/lUcuia6eD4LASWsFLPt3UB1PXfuYSimB3IaaFGLgBZ14+4YAOmQUEHjCty0sKnq5l5v5f7M
    j8b1p+d07z5E5aSunbljD7EF7lP1JQPqUqZes0oAEhgw2ID41qE7yF4hpRUvhoOTKll8yhfvZzW6vbQXaPW9hlQsfKhANKBftEdXXr1KVk1YQn7ZJsh36gVd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=L-xyX7bfv7Ov-87h-CMA:9 a=QEXdDO2ut3YA:10 a=Hw24iarM7AuQkZIYO_oA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbeCaQRZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 31 Mar 2018 12:17:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752660AbeCaQRY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 31 Mar 2018 12:17:24 -0400
Date: Sat, 31 Mar 2018 18:17:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.126
Message-ID: <20180331161720.GA25168@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.126 kernel.

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

 Makefile                                   |    2 -
 drivers/net/ethernet/arc/emac_rockchip.c   |    6 +++--
 drivers/net/ethernet/broadcom/bcmsysport.c |   33 +++++++++++++-----------=
-----
 drivers/net/ethernet/broadcom/bcmsysport.h |    2 -
 drivers/net/ethernet/freescale/fec_main.c  |    2 +
 drivers/net/ethernet/ti/cpsw.c             |    3 +-
 drivers/net/team/team.c                    |    4 +--
 drivers/s390/net/qeth_core_main.c          |   21 +++++++++++++-----
 drivers/s390/net/qeth_l2_main.c            |    2 -
 drivers/s390/net/qeth_l3_main.c            |    2 -
 drivers/scsi/sg.c                          |    5 ++--
 kernel/irq/manage.c                        |    4 ---
 net/core/skbuff.c                          |    2 -
 net/dccp/proto.c                           |    5 ++++
 net/ieee802154/6lowpan/core.c              |   12 +++++++---
 net/ipv4/inet_fragment.c                   |    3 ++
 net/ipv4/ip_sockglue.c                     |    6 +++--
 net/ipv6/ndisc.c                           |    3 +-
 net/iucv/af_iucv.c                         |    4 ++-
 net/l2tp/l2tp_core.c                       |    8 +++++--
 net/netlink/genetlink.c                    |    2 -
 21 files changed, 81 insertions(+), 50 deletions(-)

Alexey Kodanev (1):
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

Eric Dumazet (2):
      l2tp: do not accept arbitrary sockets
      ieee802154: 6lowpan: fix possible NULL deref in lowpan_device_event()

Florian Fainelli (2):
      net: fec: Fix unbalanced PM runtime calls
      net: systemport: Rewrite __bcm_sysport_tx_reclaim()

Greg Kroah-Hartman (2):
      Revert "genirq: Use irqd_get_trigger_type to compare the trigger type=
 for shared IRQs"
      Linux 4.4.126

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

Nicolas Dichtel (1):
      netlink: avoid a double skb free in genlmsg_mcast()

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (1):
      net: ethernet: ti: cpsw: add check for in-band mode setting with RGMI=
I PHY interface

Vinicius Costa Gomes (1):
      skbuff: Fix not waking applications when errors are enqueued


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlq/tJAACgkQONu9yGCS
aT7jcg//Z4xVS3T7pZNvVItEP5LlFyalPMpzkOHVvcjA3glS7b/lEh23MUXqfN/y
uXUyqyoLEvXGGu/cjtdhU5Pk2WRB61WfT71/McJx32Ic9rQEbjpbAYGOGmgrnIw8
PQOodp3G43x9hNYbcKSgjk7R8Bk+xeYmka2HggIVUiknMiuTt3OzXbaphjnNGBI5
hIj9BkSeOdxFZChpXmUiVcZzNMqGfvXdQGj2Sy6XVCNHBg/9V+b2486CFmR1b9fM
Q1iauHw5SQ8ELog88GFXiEaCEGfzjl7eW1atG3NmFFBEG2XK7GxiMdOHPatbuDNn
38ApGhJ0alWFe77NT+YF1t8XRBNYlkDiCMV8+YgedVizeAgqpE+ebCQGVHlHMRu0
QvRD1Qb4jWAttXrA9blAkql3TLFkZceqKflvQzrV4A0mgJ1uSc83f0KtotcW0p9P
zN5nsC26G2XRFw6pA/CeFH9pYwkvNU2PRV6s5kQOrGvs2LcAmfGI9EJnzHn/o4jX
nRuNciM3IZmLafXwVr5Pti1qhVRdtng78WTkHHY5+OIixOXd+RqzkdBGnEw3Whjd
xDEjPaSIS4RAqt1PSML2TbtFycruVGqbd+l037gTqBs+hK0m3dkJ5xG++i+YBrs5
VRyU51sxZngtFe1j5Ju4YfVjUIXJ2FEyxjjoSuKORjDeblg/WlA=
=ABi8
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
