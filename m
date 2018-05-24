Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757396-1527157687-2-11284443761383627380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527157686; b=k2dled1ypGmNpVRLBjLyYQaiF/evAkqal8wWH/m3p5aMUBbf/8
    imjZs+C4BaakF0+f9voea7/ei53c/a79ePKERChNchYJ/vAnqGFoSNZgJ2zd/sgV
    gcRBQbM5cvuTdoqOjcK7KxnPLdjNcnIL6R7p/F7w55LjESE4RLJInNvym7fC2Yis
    l0/s08PkHna4ZgS5c0v/dHpM8Mu3MHxe3FEiG89u/IPMFZHdiLrBerA8cvGPZL/f
    D+E62EmkTG5MyUHwkIfkr3/rRAiiZiunsso5PZ25O3PUIppr/EXLGGuCe6rudiRv
    8eW3MN6z+3gSSsOAFE7OOqxkcwHOoZ/YKnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157686; bh=IRmLcBwxOVM0ALVcHjlqsUm66ZRFpj
    XcWMJ/TYUA4Nw=; b=a52tdH2IfhhofabAW1fNWCCFRowpbmSeEpVCZYez2BbqvZ
    ghRd6qie10su5zpjdcutQEHNL0FuNHKmcpkydvWOKX/KGxjcZje1Ix6OEyBJuSvO
    7SPMB7auW8J4/pUudJWEFG8Ba27ygcYvN4tP47frkJbxk+dGD/LxQZnLGL3F3lxN
    CTUGlqKWQxbQHcqrToIf7Fybx4rgfORd1wo+t4VInWahm7hYzWJKjAq8nBAl9HK+
    LxVHHyHKFAOYLjgzSH1LrUaOU/1gUzKMyqhwZ3drsr8VmZAvX72vvXtjNvPSF2P6
    Umt/lNOHb6Wo4kAZnGJuE/24Gqx+bbdUYzKoJPAg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=spyNbNuy x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=spyNbNuy x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEP+k7yprannoNHV2jENKJlK8BNWODLiKGS7ZvR+5VZAKTnerj+u5P3nDp6aOnGbW17N3oHEvivLFrlFs00CcSOqLzOFXCHaMQmfjWzf21y810Nt+Tnr
    +oJuJ1Abq97jWokeNBefjjfoKeCx/3W39yruifVrvidLF+nV7JqXdrlexDIYgIuXeb2fqUj4iIt3JytR5ppcm8EtAsv6ZBI6J2sNEbhA7tLzPWecUTUrbzWK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=CbDCq_QkAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=uueWhB6skMaSiZvcGVAA:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030987AbeEXK1y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030731AbeEXKBh (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        William Tu <u9012063@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 027/161] net: ip6_gre: Split up ip6gre_changelink()
Date: Thu, 24 May 2018 11:37:32 +0200
Message-Id: <20180524093021.579807394@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit c8632fc30bb03aa0c3bd7bcce85355a10feb8149 ]

Extract from ip6gre_changelink() a reusable function
ip6gre_changelink_common(). This will allow introduction of
ERSPAN-specific _changelink() function with not a lot of code
duplication.

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: William Tu <u9012063@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |   33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1911,37 +1911,52 @@ static int ip6gre_newlink(struct net *sr
 	return err;
 }
 
-static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
-			     struct nlattr *data[],
-			     struct netlink_ext_ack *extack)
+static struct ip6_tnl *
+ip6gre_changelink_common(struct net_device *dev, struct nlattr *tb[],
+			 struct nlattr *data[], struct __ip6_tnl_parm *p_p,
+			 struct netlink_ext_ack *extack)
 {
 	struct ip6_tnl *t, *nt = netdev_priv(dev);
 	struct net *net = nt->net;
 	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
-	struct __ip6_tnl_parm p;
 	struct ip_tunnel_encap ipencap;
 
 	if (dev == ign->fb_tunnel_dev)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	if (ip6gre_netlink_encap_parms(data, &ipencap)) {
 		int err = ip6_tnl_encap_setup(nt, &ipencap);
 
 		if (err < 0)
-			return err;
+			return ERR_PTR(err);
 	}
 
-	ip6gre_netlink_parms(data, &p);
+	ip6gre_netlink_parms(data, p_p);
 
-	t = ip6gre_tunnel_locate(net, &p, 0);
+	t = ip6gre_tunnel_locate(net, p_p, 0);
 
 	if (t) {
 		if (t->dev != dev)
-			return -EEXIST;
+			return ERR_PTR(-EEXIST);
 	} else {
 		t = nt;
 	}
 
+	return t;
+}
+
+static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
+			     struct nlattr *data[],
+			     struct netlink_ext_ack *extack)
+{
+	struct ip6gre_net *ign = net_generic(dev_net(dev), ip6gre_net_id);
+	struct __ip6_tnl_parm p;
+	struct ip6_tnl *t;
+
+	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
+	if (IS_ERR(t))
+		return PTR_ERR(t);
+
 	ip6gre_tunnel_unlink(ign, t);
 	ip6gre_tnl_change(t, &p, !tb[IFLA_MTU]);
 	ip6gre_tunnel_link(ign, t);
