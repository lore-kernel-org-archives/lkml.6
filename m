Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1111413-1524078566-2-8430517874698943399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524078564; b=rQLQd0E3sex7VakAbBGxx5dPZs+jZ1IgRt73RpE8YJ/q/n+2qW
    Gm9dzGlr5xR3rcjYVwCFocY1kUjcCqb7lPFK31wPbbn2dVyWtHWMW+KlxfP9iIX7
    nM7pZtpvT8AnM+W0qLeGcpzEcj3mYTUEsxDx/mPUyDdvf/hJhyFLgbwBcOhoO9sH
    T5frQhrdWyTckX7/a5/LQrPdnjbHMEZvlBzMzzBraD+8IsbOx0qiv5XFREOWEVY9
    jyg/GO2Z9DlyehAY2aBQXTVb6UGIrjXiXQpPC2zuNVUBcLzmJIpqmSHyRy2K6MaF
    /ejllHMBBI0yzbOSJMjTE8UT87ZUsoPRT6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524078564;
    bh=CIXHmcxC89BoheF5mnUcVQ0DsYKbwfefQpYxjwj1hK4=; b=WfB6KUeHUnHt
    MlBLUXeKvxL6cXfsYv4JRvj24P7yjyr2Lun1URQUI5jO2kZK1HQa79jsTIyJxVqd
    1yvagg4GQXpAwc4rhaNxSwSxoyXeL3x6/E2GyR5EbvM0Z3PYZZPLEhj8kRxF1+yt
    tLnLXFqnDJ2djBf9FfMHTwEPfMl52tGf0ASPMFmjIBjoZxo3cuovVY/aJ1g9xy/X
    x3KUdhP04mqA0s4vAOSfZMGByLj3PP0wzQZG1DVrYsDzjI+5//lyx/QtoNEBRHa/
    usqcmul63f8nYlOiZzLxQ+79hPvw/MR+yE6Fky035BElhmHyyynv5c2faFB3gpHI
    k1NVRKOuQQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=deneb.enyo.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=deneb.enyo.de header.result=pass header_org.domain=enyo.de header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=deneb.enyo.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=deneb.enyo.de header.result=pass header_org.domain=enyo.de header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMK+C8DHaoc4wxSUJi5SkOVIp6Z1pFgxZldkbEGd2K2NVQnoHI8D9wvhmOLEomj8Lr7Qc9Qi+b+tm7eMHSsbrXBDBMJA2yP/4+FWsHEIOOQAJfodwnFJ
    cV8ZeeLUbnqxmm7fGSDZasuBCRVsXtCSPrU6MLlDh0WFPBU+faJVkKPYAgGJIopKHnIF6QbI/7DwSczFLHtEm/nfSXpDlrmbhN0A6tCm8pOYiXHmNjlWOJyw
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=2JrL-qRpAAAA:8
    a=J1Y8HTJGAAAA:8 a=CCpqsmhAAAAA:8 a=VwQbUJbxAAAA:8 a=t_UD1IztM3YQhmpX3YcA:9
    a=x8gzFH9gYPwA:10 a=u-Ic724avHVFXizCq7cn:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=ul9cdbp4aOFLsgKbc677:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeDRTJV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 15:09:21 -0400
Received: from albireo.enyo.de ([5.158.152.32]:58754 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbeDRTJU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Apr 2018 15:09:20 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: linux-api@vger.kernel.org, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Tom Herbert <tom@herbertland.com>,
        mjw@fedoraproject.org
Subject: sendmmsg flags userspace ABI change in kernel 4.6
Date: Wed, 18 Apr 2018 21:03:55 +0200
Message-ID: <874lk8jq04.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since this commit:

commit 28a94d8fb35b3a75b802f368ae6f4a9f6b0d435a
Author: Tom Herbert <tom@herbertland.com>
Date:   Mon Mar 7 14:11:02 2016 -0800

    net: Allow MSG_EOR in each msghdr of sendmmsg

    This patch allows setting MSG_EOR in each individual msghdr passed
    in sendmmsg. This allows a sendmmsg to send multiple messages when
    using SOCK_SEQPACKET.

    Signed-off-by: Tom Herbert <tom@herbertland.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

the msg_flags argument in individual msghdr arguments is longer
completely ignored for SOCK_SEQPACKET sockets.  msg_flags was and is
still documented as ignored for sendmsg(2), so by analogy for
sendmmsg(2) as well.

It seems that valgrind does not know about this yet, and due to
limited use of SCTP, this userspace ABI change has not been noticed so
far.

What are the plans in this area?  Will other kinds of sockets start
using the msghdr flags for sending?

A fully backwards-compatibility way to achieve this would be to
specify that you have to pass a new flag to sendmmsg (MSG_PERHDR?), in
its flags argument, to activate the per-msghdr flags.

The glibc DNS stub resolver relies on the previously documented
behavior, and I wonder how widely we should backport the change:

  https://sourceware.org/bugzilla/show_bug.cgi?id=23037

If the MSG_PERHDR route will be taken, we can skip this work, and
valgrind can flag uninitialized bits in msg_flags only if MSG_PERHDR
is passed.  (I believe it would be difficult for valgrind to look at
the socket type to determine whether undefined bits need reporting.)
