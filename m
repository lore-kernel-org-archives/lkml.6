Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-872240-1523536688-2-2328060182637741028
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523536688; b=dEQOVpvveeIoZDq9uDqTy89jvVx6xr31d/LrpzX0RgWsXIHgPK
    jKpnZqZUHJCVMY6aq5VBso2DJQx31C/SK1o72dBBsCJH6ga/oZ3nA5L3qNTcOVnh
    L/6k7S0Cbt88A6rzDMBImu1iZbtOtg0btgjNEzEjzc924Dsx6k0mcS43GuQute1h
    RKUA75CVTMT5XezGlAjBB5TAr7D27Vvf7nrzgD3xDH/rzE8aNYkIsOYZ61SdeOOx
    qFsJUemZFJTui1YfUrkihalvfPd6Rd/tkb00QoqRPSCjGqcF/1xI5udsjHwCQCvt
    84eCepSIhoLt6Pq8VBxwTvn4H8sQHR5sNVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523536688;
    bh=X7740dSahcpI6O3fkD7TqB18K/sKRPdnaZxE28dVc7g=; b=H3ABKlO39Jqx
    6m19JWN4JpLUnPmNyBXc0X6/169gkA1U4uzIRBKbIQaNW1Lute8lK28MXJ5XKgWG
    J7igcyJEKAxHFWOyyX+Dac08WOS5GMssFQ4axppDurumWxkzPGb86eRTxUmNK3d4
    wTUg/HUP8F03oXb6oXe+XVg+YmzUHlmg9Jl3LWvVY0ehSgC5pM/KI6+V/JlqLB2M
    uNqCLRj5ciHgHAl7cl4nxkR+4pq3FN0qp67OnXdrBgFATc72sq5iduYz0kKy2Cj7
    mel7ZX42Hj7yyhqrs+zTWo3TBZJPE07IYI9S4K3uc8btlaPdfQIPPfjwAz8yFxnC
    IBW9hJCB9A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNTEa7AWsB0t3sfY9YNZ8XLt6xQ7Zy9Fu+tcNpoE+nHLBixVUercq7HB+9qIl6ICiBpocTWu7Y8mK3LbeZag4DbnPiEPSk5obnIhvN/kFXpqWwnLl9EZ
    NWuaTa9xCVoD00juVgiCFD3WyLPAx1KIePYvrX2yjiVAiaUNpG1d0oihsI3wQJWUaeTWbcD+jJ4QfM82YxY/kw46YNgInM1gFMiFIpSqv0ZHiyezpFoCsce5
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=Mu3ZoM23mIDqnO9hSPcA:9 a=5dCYHp1yfUflJ9iw:21 a=0Fiywij4kcKRKX-n:21
    a=CjuIK1q_8ugA:10 a=b3OgmXbZjgwrhHgOhnIA:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeDLMg0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 08:36:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50660 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDLMgZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 08:36:25 -0400
Date: Thu, 12 Apr 2018 14:36:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.2
Message-ID: <20180412123616.GA21030@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.16.2 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.16.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 +-
 drivers/net/ethernet/marvell/sky2.c                  |    2 +-
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c |    9 +++++----
 drivers/net/ppp/pptp.c                               |    1 -
 drivers/sbus/char/Kconfig                            |    3 ++-
 net/8021q/vlan_dev.c                                 |    6 +++++-
 net/core/dev.c                                       |    2 +-
 net/dsa/dsa_priv.h                                   |    8 +++++++-
 net/ipv4/arp.c                                       |    2 +-
 net/ipv4/ip_tunnel.c                                 |   11 ++++++-----
 net/ipv6/ip6_gre.c                                   |    8 +++++---
 net/ipv6/ip6_output.c                                |    7 +++++--
 net/ipv6/ip6_tunnel.c                                |   11 +++++++----
 net/ipv6/ip6_vti.c                                   |    7 +++++--
 net/ipv6/sit.c                                       |    8 +++++---
 net/sched/act_bpf.c                                  |   12 ++++++++----
 net/sched/cls_u32.c                                  |    1 +
 net/sctp/ipv6.c                                      |    4 +++-
 net/sctp/socket.c                                    |   13 ++++++++-----
 19 files changed, 76 insertions(+), 41 deletions(-)

Andrew Lunn (1):
      net: dsa: Discard frames from unused ports

Cong Wang (1):
      net_sched: fix a missing idr_remove() in u32_delete_key()

Davide Caratti (1):
      net/sched: fix NULL dereference in the error path of tcf_bpf_init()

Dirk van der Merwe (1):
      nfp: use full 40 bits of the NSP buffer address

Eric Dumazet (9):
      pptp: remove a buggy dst release in pptp_connect()
      sctp: do not leak kernel memory to user space
      sctp: sctp_sockaddr_af must check minimal addr length for AF_INET6
      net: fool proof dev_valid_name()
      ip_tunnel: better validate user provided tunnel names
      ipv6: sit: better validate user provided tunnel names
      ip6_gre: better validate user provided tunnel names
      ip6_tunnel: better validate user provided tunnel names
      vti6: better validate user provided tunnel names

Greg Kroah-Hartman (1):
      Linux 4.16.2

Guenter Roeck (1):
      sparc64: Oracle DAX driver depends on SPARC64

Hangbin Liu (1):
      vlan: also check phy_driver ts_info for vlan's real device

Jeff Barnhill (1):
      net/ipv6: Increment OUTxxx counters after netfilter hook

Kai-Heng Feng (1):
      sky2: Increase D3 delay to sky2 stops working after suspend

Miguel Fadon Perlines (1):
      arp: fix arp_filter on l3slave devices


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrPUr0ACgkQONu9yGCS
aT7x6RAAttclu4634oNy/RRWHv1n9C3OPRYjS3Y0fVv+Kqv+u70dBYH6SfBvkONL
MZ/8O8wlBzX1falj7vTKLpZdt+OjS4HHEVTTe+0TD8jfcfivW4ECF64zriohJ6f/
e9B5qaa6Pv4kDZ5eTo258K90Ns4XYqUmAONJRklwHCmhc9SL/BMeP72yAdlQUq+2
UyNLWV+2dgKYckkhOPkdTcVs6YWHBSyQgKOvuxdDXyM8yXuB7Awjuryea06TcxIT
3xevS3Wg47EYPrFF/YJ+K6ia+zJM6D96FDSvXi1XEWb6QSzFeTebQOMTuPONnd/i
A6gHlOQQNw/q7xA/20iaa5tAdCyQlIEbqp/IpChpEUmsESTYkziB0uDLlhjjShO4
fsv8gXwPHMGoAXwMkCD45JG3cQauaGiOse+bEns0b/pBQZuqTKGygFE+fg7COGtU
Fc6OoAU9QP9rvnCWben+ckFXf2h4PUbhz3QIHI7RXSdsUtQoClj9kjuR35haGUun
YOUF6hkn9WFpr2mY0lVKq3h8Wc3lqmLlAbTNb1hvuilTewWVvd0gAGavig+QgZHT
sMNl8mRfCMKs2ZEEqIkjB9iza/iLgxHsxf+Rl4Q24CyaG9BvmtcHKY0eRnh143xb
Ci6LTKsVp7ZKYH5tzqjzCb65qqVnOpGatSPc4ogqDx2rr3UW34M=
=tlcD
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
