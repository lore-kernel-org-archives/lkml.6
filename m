Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3608381-1526631862-2-17607123531603607479
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526631861; b=UUl8UGc5jhFSgVREIbJbtAddoNqQWy3H5Fz5UCWX0u0o2yMBAw
    /KSkTLWgpOjiZPyh1V1oIDTRrJ+STu0maHOoqsayvBnlosIU9fmgqs0MDWQ889eS
    +j0v7GgfIcrOZmpVwSXOwLlo2ceLz27QaO3YGpg55JmbaeZ7sAHoJp2DpH9j/CLm
    MibYYI1oemxC5T4pE7Mfq7mG7CNEUO4X9OwLHjgT8SOKQT66nw4+qd01KNUFz8JF
    TUKUA128QDGDGiktBCNfr1SKSB5gC1om87HqmBYrROn0OG00XKi9H0HMZHgCuSeU
    GXndRfdrJKuliTFbyvt/6VmNW8NPKKIBmbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526631861; bh=5mytDNm0n+HobZtZWmJKKleVFIcw5t
    H1sa5xWX2LV/I=; b=UyQZqt/nKMaUMKuDz5Fvh0qPT9vg6gw4EMwUgGm9kRn8fF
    c7dvbMXI1hrnBvRuzT1FPoM/Eyx+bWWIR7+kkV7CZxhdGwioYbk3QazPT38Yi2DL
    pCLusmu026tXpkgMS7es4uh7wD1LfBzLoxTt/ns8+oI2Ff7V+kP6zgxANlCHfk0n
    fxi5rRclP/yMHFWNe6xNINh+VhTqjlrKl0LpoD4b1QzygH3zKtDcXJWv+c5QaATY
    /RTpJy70oM1LUgQy+6D/Ml8MibNWF/yAWi4ZPMwtzKqdpuaCg0v+KyxupyJNQVEZ
    sIfWDK/vo2JYRdnsOrI1MzUjpTTZuwAZcm/lrqrw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tFD95QYV x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=tFD95QYV x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNBl3V5dWozMSRnCi5tHp34LKcMCceJaID23n7s7FxtA2ARWQxvGFQ1jGD2epx6WdOIkvh4ZBgrE1rKeH3IBawUZK6iNMPVr4o37LeVEMB9R4fLXgvXY
    kV8At0NopDeZgXoSMYH4iQ1AirW0Uk0RByJG3m6J5jB79gZ6UgkK1/8BfGHp0UMT95HC0uSMFnbso0VJaXjqmd9NRn25BWGKfp3Ett2eulIEJuHW7bJWjH7F
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=9-efGfXaAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=MLiVjpLBtXPEc2nvV38A:9
    a=QEXdDO2ut3YA:10 a=76mzCeYM3W7A2q4738_3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbeERIYB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 04:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753790AbeERIWo (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 04:22:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guillaume Nault <g.nault@alphalink.fr>
Subject: [PATCH 4.9 31/33] l2tp: revert "l2tp: fix missing print session offset info"
Date: Fri, 18 May 2018 10:16:10 +0200
Message-Id: <20180518081536.355813338@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Chapman <jchapman@katalix.com>

commit de3b58bc359a861d5132300f53f95e83f71954b3 upstream.

Revert commit 820da5357572 ("l2tp: fix missing print session offset
info").  The peer_offset parameter is removed.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/l2tp/l2tp_netlink.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -750,8 +750,6 @@ static int l2tp_nl_session_send(struct s
 
 	if ((session->ifname[0] &&
 	     nla_put_string(skb, L2TP_ATTR_IFNAME, session->ifname)) ||
-	    (session->offset &&
-	     nla_put_u16(skb, L2TP_ATTR_OFFSET, session->offset)) ||
 	    (session->cookie_len &&
 	     nla_put(skb, L2TP_ATTR_COOKIE, session->cookie_len,
 		     &session->cookie[0])) ||
