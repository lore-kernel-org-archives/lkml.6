Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713595-1523399046-2-18108500697482478514
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523399044; b=UpnV4QaYCwHPVOhWZ8Ga40qSKEKHNYthX9sfY4HNLEQri34Mxu
    ngzYvsDuRkCxbs9Z7e3pUJhjEGtDKXOsEwh4ACEXk4rsESPQQs6FeuEAr7kxV0Cj
    cXdkModHIhL5Srfc6t/LFfYppMPd2ljlFMbT+8iv85CSvBOj4fwnjRMV8qywezHs
    KrTvTp0VoofVPFVP21gVOnLGugAAyJePuayhUvHHsyRgCy6op7pu4NI0lX5F7qje
    KeFk+BltPc71FrPU9RdlxeT4QnUb0PnqqR3feMLJLRroqI+MuHFBepxIafnHrPfe
    l7N6R3HtSSJTLejNKHZeKNY/EAvBvTNpZjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523399044; bh=i3oW3rnwSHSq6/jPGl/w4Jho80/e05
    toA0mDLMACruA=; b=GXthsyZbUcOJnjciuuIzYP9h06RoLM83HdQvp1yhIzjB5+
    0WCs4cKa63MmM13UenvcWtd1fGS4s5Wwu69HelkDhxCkfJf2URolv6RcTiiVp7kB
    ztxtT0u2r7hN4krGOj1aRpZIboT+Q0C3beR/LzyT+HAkvSowB6j0ogQ0dwimYVyx
    pN1eSifwYKlntEHSS+Ugn8KEb1nPGlSP7wZScW++qRBRuSs+Vfayw6IKuhvFDMp1
    PaUHp0EF9S82x5ejearvu1wT20NruFXSMsYuc0o59xB/r/aDo4rd/NJC+wZSDHuo
    AvrSC5d/nDRajHF0gguNSB3/VKDavERU2y7+slvw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEhuSLQPIwc2zHus7sJb+Zfrlou4sAIINUaFopjhKOWyBhg3szyjiQ1VVdQxpocpXwxMBhTkiuwNbQEOWAJ8eQtu3LGMmAhHOGCLbQUgeQdOKzuRZaKU
    /Vg5LgFqFM+rBWkgDb0AzxDFOdskRSFpSEkh1lHF7oeEPlRJ8Ml2kqABz7SGlUKEZWmZRHt0i9mzMJfuboEZdbK7jyXB4q1As/FyWrVDtYIiTRllRznwecLd
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QQrbzgpHJRgA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=LD2kUS3hAAAA:8 a=pGLkceISAAAA:8
    a=1XWaLZrsAAAA:8 a=DfNHnWVPAAAA:8 a=20KFwNOVAAAA:8 a=-COPsrLyAAAA:8
    a=_jlGtV7tAAAA:8 a=TTtSi5-BYFtH4PrphYsA:9 a=GfkqneHAJkLkhWAM:21
    a=L4fJcFoKG2_HoFtl:21 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=FTB9xuwByZgvWSGbqjUc:22 a=rjTVMONInIDnV1a_A2c_:22 a=ksTjKdeKf_QrTKGjYr5L:22
    a=nlm17XC03S6CtCLSeiRr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeDJWYD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:24:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDJWYC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:24:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.16 00/18] 4.16.2-stable review
Date: Wed, 11 Apr 2018 00:23:35 +0200
Message-Id: <20180410212758.564682823@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.2-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.2-rc1
X-KernelTest-Deadline: 2018-04-12T21:27+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.16.2 release.
There are 18 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Apr 12 21:27:41 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.2-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.2-rc1

Dirk van der Merwe <dirk.vandermerwe@netronome.com>
    nfp: use full 40 bits of the NSP buffer address

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: fix a missing idr_remove() in u32_delete_key()

Eric Dumazet <edumazet@google.com>
    vti6: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ip6_tunnel: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ip6_gre: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ipv6: sit: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    ip_tunnel: better validate user provided tunnel names

Eric Dumazet <edumazet@google.com>
    net: fool proof dev_valid_name()

Hangbin Liu <liuhangbin@gmail.com>
    vlan: also check phy_driver ts_info for vlan's real device

Kai-Heng Feng <kai.heng.feng@canonical.com>
    sky2: Increase D3 delay to sky2 stops working after suspend

Eric Dumazet <edumazet@google.com>
    sctp: sctp_sockaddr_af must check minimal addr length for AF_INET6

Eric Dumazet <edumazet@google.com>
    sctp: do not leak kernel memory to user space

Eric Dumazet <edumazet@google.com>
    pptp: remove a buggy dst release in pptp_connect()

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix NULL dereference in the error path of tcf_bpf_init()

Jeff Barnhill <0xeffeff@gmail.com>
    net/ipv6: Increment OUTxxx counters after netfilter hook

Andrew Lunn <andrew@lunn.ch>
    net: dsa: Discard frames from unused ports

Miguel Fadon Perlines <mfadon@teldat.com>
    arp: fix arp_filter on l3slave devices

Guenter Roeck <linux@roeck-us.net>
    sparc64: Oracle DAX driver depends on SPARC64


-------------

Diffstat:

 Makefile                                             |  4 ++--
 drivers/net/ethernet/marvell/sky2.c                  |  2 +-
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c |  9 +++++----
 drivers/net/ppp/pptp.c                               |  1 -
 drivers/sbus/char/Kconfig                            |  3 ++-
 net/8021q/vlan_dev.c                                 |  6 +++++-
 net/core/dev.c                                       |  2 +-
 net/dsa/dsa_priv.h                                   |  8 +++++++-
 net/ipv4/arp.c                                       |  2 +-
 net/ipv4/ip_tunnel.c                                 | 11 ++++++-----
 net/ipv6/ip6_gre.c                                   |  8 +++++---
 net/ipv6/ip6_output.c                                |  7 +++++--
 net/ipv6/ip6_tunnel.c                                | 11 +++++++----
 net/ipv6/ip6_vti.c                                   |  7 +++++--
 net/ipv6/sit.c                                       |  8 +++++---
 net/sched/act_bpf.c                                  | 12 ++++++++----
 net/sched/cls_u32.c                                  |  1 +
 net/sctp/ipv6.c                                      |  4 +++-
 net/sctp/socket.c                                    | 13 ++++++++-----
 19 files changed, 77 insertions(+), 42 deletions(-)
