Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155587-2-2078297362495445185
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155586; b=QkTiwDfK/NHPtdD1ZZVPN7sNF2Q0lbt/5pm/EZz8I9c629Y233
    XgsG8zHsdRnUi0nYrYbny6iSvQTRz8qKsAnWBxt3Q86jLeqfUP7UVf69+dNz3TBU
    Tm2d9y7efSaDg3gM8hk147VDytmyYRDOm1dCmuhZ867xGiHlZ9y75JSv9LZxctj6
    XeEQ8v7/B20BXUnLPCUpYmIgCVx1dyitrAqjSe8Q4rqS0fLoUimTdK/RlUx2LCaX
    txFZUO9L6MZ9UgNgaT7wYjaLrBoCOw/yzJluddKQdcUf8WKKIirV3DXNFArRIRS/
    zdZGSV4whCSG8l7NNuo3dDYrCGy2j4hKJ8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155586; bh=jKInOCiZGt2oo5FUGXhp0y3U4qwoVT
    QL2f/+WCwRjWA=; b=M9ftTrNuIdsIt9Z017y+jQvboxfsjW2lUyycoZgYjBHOVN
    3DZbF3bU0VpZci5p1SXWMzhXkMAzszXW3OF2faBqL1Vq8k8J8QUYI2Jdonn264ob
    1N7HoPnJD8RBlSqYCznqMiqV1CTkkpLuaV4wWHbVokFwUoA8Xgk2oaAYdbFBHdgM
    jOQFY8aNwIDLj0deb9AV4wF5dBWUtyWAmUIkqcBi3SykNJsFFRpOUWYp3FOgtcpP
    l1shM0olde1lP+FIawBdsnTUrC5QznHWSZr5QjQABkJ0lb2r4a++WKvuwICI69Hi
    SCKf50WyY0+h0nXtG54PTpKvuOQH13ENO/lG/+qw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=DGURxHzQ x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=DGURxHzQ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJiffTUVxdt6m/dBL8dkKnQQDe+BjfwQM47DfbA5xOLk3R8S0S68Q9BCnzph0CNjoOHsoCOaz+NqlATIYGIcxDW9rPDWaSFdxkv5MxgXtqjklWH4574Z
    cBRud/zXykqYD1ZhvDSkB1UbSbKk328Gg8dOgsnpYxkE05fT/JOp7yCLoUSGu1tBzSgST6SykViPCF1zWL+JHhqozLqtroRN70OhhE9BiuCKwzPMCXP4bufs
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=FDWzJhBSr47RAHrKXxYA:9
    a=2j97-PERoSpG-F8l:21 a=XfC4L9z_rsF2_Xuf:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967968AbeEXJxD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966810AbeEXJxA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 006/165] net: test tailroom before appending to linear skb
Date: Thu, 24 May 2018 11:36:52 +0200
Message-Id: <20180524093622.232282889@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 113f99c3358564a0647d444c2ae34e8b1abfd5b9 ]

Device features may change during transmission. In particular with
corking, a device may toggle scatter-gather in between allocating
and writing to an skb.

Do not unconditionally assume that !NETIF_F_SG at write time implies
that the same held at alloc time and thus the skb has sufficient
tailroom.

This issue predates git history.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_output.c  |    3 ++-
 net/ipv6/ip6_output.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1040,7 +1040,8 @@ alloc_new_skb:
 		if (copy > length)
 			copy = length;
 
-		if (!(rt->dst.dev->features&NETIF_F_SG)) {
+		if (!(rt->dst.dev->features&NETIF_F_SG) &&
+		    skb_tailroom(skb) >= copy) {
 			unsigned int off;
 
 			off = skb->len;
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1488,7 +1488,8 @@ alloc_new_skb:
 		if (copy > length)
 			copy = length;
 
-		if (!(rt->dst.dev->features&NETIF_F_SG)) {
+		if (!(rt->dst.dev->features&NETIF_F_SG) &&
+		    skb_tailroom(skb) >= copy) {
 			unsigned int off;
 
 			off = skb->len;
