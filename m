Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713595-1523400078-2-1710972630408000879
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
    1523400077; b=jbm0hKsv3dKzA2z3hbqFMQEuFC1lYlK/+fKkx64KMmrqzZjvAi
    LZX0OkzOJ60FGnbB0WJFLOpa9EcJ6qiGi8MfwxscV40VlfgfPhLtKPrLR2+izFj3
    hahau6aCJeNgL8uZSgNW+7mwszeGxdKwyUVGrjN3hsegNePDFJQyEtE2G3DIk1R/
    LKAJqnPBXbPYmOinI8FE8hziesx3y8jcrNDUVSt45OzXacHWL9Uras1QF7AR6ipA
    hexzQq1K08eocuYptguY6xRCJ32gZIzapziPhgMqmuO5dqrKNhn/MhpBI9IIJZNh
    2qSJ8OKdxmohR/a8rCH5QR4VfHbE2HM02rSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400077; bh=293TuL66H7nRjWKTA/nNS9gC/CvNMQ
    xoaMCDEt6l6b4=; b=ZdBEwUwPiCXvPU9YzqaPvYpifD8EK/BNQh0W0ebh8A6S7w
    ix7bHSvLJx/QpMPjjbADZHBJHZHsOjCfQgqA/JybU3VvFbPAcNMUBY4k8YcRCA9Q
    s+yiVzGEosWsLkeI+GnPB5DCbEom+GqbPrWgkN5nMK6HwdhQrKl64ZT6ZZUcDtem
    uOa/Jt3OzZjWwTcFUbVIACOZsEuO7LLVfABn2tq+Brnb0gmzrCrC/aKEXZb74Vtz
    T3ae60J/F/TAJQHGCNJvzkR5M2GqCsroUqyN94HfdvzUqobsiIapUdhkfjX/rKtY
    wrAF9ROtCwdBmvZUUTTbn1hdBCMWgRvC8YjDxPOw==
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
X-CM-Envelope: MS4wfOKAOd/9HdPZ8Icn22zOJjl9Yaq5ixR2EdFX+YUjxqCpHL0Jkig2oAq5E8E1lmWFQAI88Vne9+sq7G58rOmDN5YfBkvp0Lj0K7Xdjbauj04AtQW1B5/v
    sXz7xblJ3gmhBIg9qOWbGDP3NZy0sDgxGBLzY2JcyqZEL6oeQlE+Bc76b2GvLunF79zX/ZYPHCvX/m2qgY/GmEk0FAi7/gNUn2+Ol/6QpBJcWd7C7IktXRyj
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=CDq0vqnqAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=dG3OLzM3V4zPhyV1mVEA:9 a=QEXdDO2ut3YA:10
    a=Xn7iXEen_xUG9zZOO_Hb:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeDJWlB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:41:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932691AbeDJWkX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:40:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        David Ahern <dsa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 135/138] route: check sysctl_fib_multipath_use_neigh earlier than hash
Date: Wed, 11 Apr 2018 00:25:25 +0200
Message-Id: <20180410212917.938793265@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 6174a30df1b902e1fedbd728f5343937e83e64e6 ]

Prior to this patch, when one packet is hashed into path [1]
(hash <= nh_upper_bound) and it's neigh is dead, it will try
path [2]. However, if path [2]'s neigh is alive but it's
hash > nh_upper_bound, it will not return this alive path.
This packet will never be sent even if path [2] is alive.

 3.3.3.1/24:
  nexthop via 1.1.1.254 dev eth1 weight 1 <--[1] (dead neigh)
  nexthop via 2.2.2.254 dev eth2 weight 1 <--[2]

With sysctl_fib_multipath_use_neigh set is supposed to find an
available path respecting to the l3/l4 hash. But if there is
no available route with this hash, it should at least return
an alive route even with other hash.

This patch is to fix it by processing fib_multipath_use_neigh
earlier than the hash check, so that it will at least return
an alive route if there is when fib_multipath_use_neigh is
enabled. It's also compatible with before when there are alive
routes with the l3/l4 hash.

Fixes: a6db4494d218 ("net: ipv4: Consider failed nexthops in multipath routes")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: David Ahern <dsa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/fib_semantics.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1755,18 +1755,20 @@ void fib_select_multipath(struct fib_res
 	bool first = false;
 
 	for_nexthops(fi) {
+		if (net->ipv4.sysctl_fib_multipath_use_neigh) {
+			if (!fib_good_nh(nh))
+				continue;
+			if (!first) {
+				res->nh_sel = nhsel;
+				first = true;
+			}
+		}
+
 		if (hash > atomic_read(&nh->nh_upper_bound))
 			continue;
 
-		if (!net->ipv4.sysctl_fib_multipath_use_neigh ||
-		    fib_good_nh(nh)) {
-			res->nh_sel = nhsel;
-			return;
-		}
-		if (!first) {
-			res->nh_sel = nhsel;
-			first = true;
-		}
+		res->nh_sel = nhsel;
+		return;
 	} endfor_nexthops(fi);
 }
 #endif
