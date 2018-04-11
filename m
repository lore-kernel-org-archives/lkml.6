Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523480093-2-10870305874282826999
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523480093; b=aS86TJMfsk2U0AV4ui3sFaf1lIV7PsvF6YN4ZXN0aJmtON9K82
    7ZCZO5Aof2QgO+InqNL0tv4AkBSmm/mtGriKR4c8h7Lxp8x6dO7UFFyEpyL63ZFk
    LjAUmR/F0cwIcCvPru2jUJ7AQ5VfdZeQ98j9sf9cWlLQ31FsM8q2F9unpyegGG6p
    WHvSWXkVKXQJB1DqC5aXINvM4LXf3PPZbXgOaEe4s1+Z1HeMFf1H3Kk5W3FPe/T6
    RCPxnDElBoFi7NuBSieiIqgfrvg9yppna+hkuKoNNcQidTuLyUUY3OsDpgOmcLDV
    mIdlP1qWn+V1Va6/lybE/jeH+CrrAMJm47/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480093; bh=OTw8g0f7f8NleD8/nglhc6QAXVpkp7
    yLJWzA1FQ7mA0=; b=rf0eQBECoQLoVk+43TO43Sf29IM/ccoZ9ArcUhspkTX2MB
    d/+TtatHVnHOXrOzZs6nnTFYiLgOiGDo/t+ufnd5/xxi+1uLgJRp1A6QQ3BjIuM7
    CnxwcnAbSTuE3bwKTQpKkx6XAGgBCG+Vy4K3+8eHtzKefQWDmXJeF6gTy905oBLP
    59GZZmLMYzi+FPvWfVwdQ3c6RywHm6d/aXWpU81sfInCTP4nr+O2nRr+22699TH7
    NW2mI8HVp5X4sHiy6n+Z5M9Eslf7+V1FZov3ae0yMCgaHExrtOODhYvh5cDNtwwG
    iE7jXRVfe6JzSa9DUZZ35jthiyeNdoysi1qpDKAw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfKiE3xUfpELSTDYQFh4OW4oT95kKDxqgQZrYgjgoQbTdbtfsg6Z/Z6cjYJ+AU02BQ03w5YvYw6yxPXf5Sp32vfAKKXTu2MtAzP4p72hYaXnA7RcgwdFo
    bmtq2gsHn6XTlPNyubqVFHQimQnUANPj5He4VQ26jVt2TgpP9Pzg1Q9wGFpm+Xm+ope1dR7alj95+mzVclR9Q9SOrECt+Q3cPIKds90Dt6fADBW1KiKnLcVx
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=XnLS8o09v7U2Rlm7CLcA:9 a=G-6vgdAR1nUUrvkI:21
    a=A1Xbmg0M1upB5TVp:21 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932270AbeDKSo5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:44:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932269AbeDKSo4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mahesh Bandewar <maheshb@google.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 036/190] ipv6: avoid dad-failures for addresses with NODAD
Date: Wed, 11 Apr 2018 20:34:42 +0200
Message-Id: <20180411183552.283081443@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Bandewar <maheshb@google.com>


[ Upstream commit 66eb9f86e50547ec2a8ff7a75997066a74ef584b ]

Every address gets added with TENTATIVE flag even for the addresses with
IFA_F_NODAD flag and dad-work is scheduled for them. During this DAD process
we realize it's an address with NODAD and complete the process without
sending any probe. However the TENTATIVE flags stays on the
address for sometime enough to cause misinterpretation when we receive a NS.
While processing NS, if the address has TENTATIVE flag, we mark it DADFAILED
and endup with an address that was originally configured as NODAD with
DADFAILED.

We can't avoid scheduling dad_work for addresses with NODAD but we can
avoid adding TENTATIVE flag to avoid this racy situation.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -957,7 +957,10 @@ ipv6_add_addr(struct inet6_dev *idev, co
 	INIT_HLIST_NODE(&ifa->addr_lst);
 	ifa->scope = scope;
 	ifa->prefix_len = pfxlen;
-	ifa->flags = flags | IFA_F_TENTATIVE;
+	ifa->flags = flags;
+	/* No need to add the TENTATIVE flag for addresses with NODAD */
+	if (!(flags & IFA_F_NODAD))
+		ifa->flags |= IFA_F_TENTATIVE;
 	ifa->valid_lft = valid_lft;
 	ifa->prefered_lft = prefered_lft;
 	ifa->cstamp = ifa->tstamp = jiffies;
