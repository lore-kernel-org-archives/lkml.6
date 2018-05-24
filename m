Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757396-1527157656-2-9004519299762065108
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
    1527157655; b=aZsPjuQqeTnNUIBMKC39XlDO9OuvAvbQRYV1mXJDR9Nzhu6npH
    OGluxmzflizduSMiZp4hXxodlZ0JeCOEV1khFXHYS1XgJU23GYQANc40M6JqXZlH
    moBtrHO4TSdM2IoQkvNKpNb1mlwnlA8grfetEasg1X9W61HxhKYICw0hZ2760P9/
    1+iKStPjVzZJ4NS15T+w5QjPzCHUogbeALz158qtrdEzDb0XrIpetxtt21A6zJkV
    L6sd22mPx9EXdzLHlPv/f1ilrbcWo13RfuJHgjoA9IJD2XAxX6DBWBQ0tpNQTWvO
    SpIhPuawq2laNdYwu4we84ycSafycs7UOdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157655; bh=sPJgzC3rNTBDGte5u8L052v1MV4Tmh
    dBhGmZ/ci7pTE=; b=c6heBjbN+TOt2b3mpssClOzXXaxUDoMZ6XLd/d9oDLdlhk
    3pzlXJLS8ObLRROlgMYlMN2uYUIShLpwmRGQVuaRFFiRlHk/Vggojb7+MorJreij
    uBqn34d167Yv4ipWQtC5u6907BnMT4JuhDb7Jm85WknWRIImzBCu9Pk5EfBRSedN
    JVaqqhoKKvDlviAO1wXtT2jL+guo1wgkCDtEY8sLjFTRdkHjuEo2x2KdFyjY26b/
    IYrfSC8ecb7AQf/PCRg2ipHlkRow6l3PXzNwjGCHQRd/dp7TvPj3mboCdAATF0RL
    lr7dtUudg4TQtcjPj/jP9aXucnXeePVN8ZCVxAQg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=pBIxFz2j x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=pBIxFz2j x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfN+hle8dPb/zsacIJSlFnju7VmNQkxRq7YCGq3R5IB2h4Fg/i0a7kA0a9SeCvOHt1fCK8Hjaa97mevtOML1myOj9CmnRhYPfNUJIHdPb/bfqAE2XIg1u
    +N3hME7sJskoFcCzzjEteBAXy5C7+uHhLCK5DYkEOlvZSof5X0YjBu2MvgJmNGzRXtXZ5gd+9EijNZhRFdnTv46oIGJa4y+CSXrpjA2b3ADg4UEvNcuuQqee
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=SZ_oCpO2-ZeADMDyh-oA:9
    a=wxbXCU_eelTm65xV:21 a=1TtWVpXjlE_bo9Eq:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031085AbeEXK0y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030987AbeEXKBm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Tu <u9012063@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 029/161] net: ip6_gre: fix tunnel metadata device sharing.
Date: Thu, 24 May 2018 11:37:34 +0200
Message-Id: <20180524093021.835258404@linuxfoundation.org>
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

From: William Tu <u9012063@gmail.com>

[ Upstream commit b80d0b93b991e551a32157e0d9d38fc5bc9348a7 ]

Currently ip6gre and ip6erspan share single metadata mode device,
using 'collect_md_tun'.  Thus, when doing:
  ip link add dev ip6gre11 type ip6gretap external
  ip link add dev ip6erspan12 type ip6erspan external
  RTNETLINK answers: File exists
simply fails due to the 2nd tries to create the same collect_md_tun.

The patch fixes it by adding a separate collect md tunnel device
for the ip6erspan, 'collect_md_tun_erspan'.  As a result, a couple
of places need to refactor/split up in order to distinguish ip6gre
and ip6erspan.

First, move the collect_md check at ip6gre_tunnel_{unlink,link} and
create separate function {ip6gre,ip6ersapn}_tunnel_{link_md,unlink_md}.
Then before link/unlink, make sure the link_md/unlink_md is called.
Finally, a separate ndo_uninit is created for ip6erspan.  Tested it
using the samples/bpf/test_tunnel_bpf.sh.

Fixes: ef7baf5e083c ("ip6_gre: add ip6 erspan collect_md mode")
Signed-off-by: William Tu <u9012063@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |  101 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 79 insertions(+), 22 deletions(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -71,6 +71,7 @@ struct ip6gre_net {
 	struct ip6_tnl __rcu *tunnels[4][IP6_GRE_HASH_SIZE];
 
 	struct ip6_tnl __rcu *collect_md_tun;
+	struct ip6_tnl __rcu *collect_md_tun_erspan;
 	struct net_device *fb_tunnel_dev;
 };
 
@@ -233,7 +234,12 @@ static struct ip6_tnl *ip6gre_tunnel_loo
 	if (cand)
 		return cand;
 
-	t = rcu_dereference(ign->collect_md_tun);
+	if (gre_proto == htons(ETH_P_ERSPAN) ||
+	    gre_proto == htons(ETH_P_ERSPAN2))
+		t = rcu_dereference(ign->collect_md_tun_erspan);
+	else
+		t = rcu_dereference(ign->collect_md_tun);
+
 	if (t && t->dev->flags & IFF_UP)
 		return t;
 
@@ -262,6 +268,31 @@ static struct ip6_tnl __rcu **__ip6gre_b
 	return &ign->tunnels[prio][h];
 }
 
+static void ip6gre_tunnel_link_md(struct ip6gre_net *ign, struct ip6_tnl *t)
+{
+	if (t->parms.collect_md)
+		rcu_assign_pointer(ign->collect_md_tun, t);
+}
+
+static void ip6erspan_tunnel_link_md(struct ip6gre_net *ign, struct ip6_tnl *t)
+{
+	if (t->parms.collect_md)
+		rcu_assign_pointer(ign->collect_md_tun_erspan, t);
+}
+
+static void ip6gre_tunnel_unlink_md(struct ip6gre_net *ign, struct ip6_tnl *t)
+{
+	if (t->parms.collect_md)
+		rcu_assign_pointer(ign->collect_md_tun, NULL);
+}
+
+static void ip6erspan_tunnel_unlink_md(struct ip6gre_net *ign,
+				       struct ip6_tnl *t)
+{
+	if (t->parms.collect_md)
+		rcu_assign_pointer(ign->collect_md_tun_erspan, NULL);
+}
+
 static inline struct ip6_tnl __rcu **ip6gre_bucket(struct ip6gre_net *ign,
 		const struct ip6_tnl *t)
 {
@@ -272,9 +303,6 @@ static void ip6gre_tunnel_link(struct ip
 {
 	struct ip6_tnl __rcu **tp = ip6gre_bucket(ign, t);
 
-	if (t->parms.collect_md)
-		rcu_assign_pointer(ign->collect_md_tun, t);
-
 	rcu_assign_pointer(t->next, rtnl_dereference(*tp));
 	rcu_assign_pointer(*tp, t);
 }
@@ -284,9 +312,6 @@ static void ip6gre_tunnel_unlink(struct
 	struct ip6_tnl __rcu **tp;
 	struct ip6_tnl *iter;
 
-	if (t->parms.collect_md)
-		rcu_assign_pointer(ign->collect_md_tun, NULL);
-
 	for (tp = ip6gre_bucket(ign, t);
 	     (iter = rtnl_dereference(*tp)) != NULL;
 	     tp = &iter->next) {
@@ -375,11 +400,23 @@ failed_free:
 	return NULL;
 }
 
+static void ip6erspan_tunnel_uninit(struct net_device *dev)
+{
+	struct ip6_tnl *t = netdev_priv(dev);
+	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
+
+	ip6erspan_tunnel_unlink_md(ign, t);
+	ip6gre_tunnel_unlink(ign, t);
+	dst_cache_reset(&t->dst_cache);
+	dev_put(dev);
+}
+
 static void ip6gre_tunnel_uninit(struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 
+	ip6gre_tunnel_unlink_md(ign, t);
 	ip6gre_tunnel_unlink(ign, t);
 	dst_cache_reset(&t->dst_cache);
 	dev_put(dev);
@@ -1799,7 +1836,7 @@ static int ip6erspan_tap_init(struct net
 
 static const struct net_device_ops ip6erspan_netdev_ops = {
 	.ndo_init =		ip6erspan_tap_init,
-	.ndo_uninit =		ip6gre_tunnel_uninit,
+	.ndo_uninit =		ip6erspan_tunnel_uninit,
 	.ndo_start_xmit =	ip6erspan_tunnel_xmit,
 	.ndo_set_mac_address =	eth_mac_addr,
 	.ndo_validate_addr =	eth_validate_addr,
@@ -1862,8 +1899,6 @@ static int ip6gre_newlink_common(struct
 				 struct netlink_ext_ack *extack)
 {
 	struct ip6_tnl *nt;
-	struct net *net = dev_net(dev);
-	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
 	struct ip_tunnel_encap ipencap;
 	int err;
 
@@ -1876,16 +1911,6 @@ static int ip6gre_newlink_common(struct
 			return err;
 	}
 
-	ip6gre_netlink_parms(data, &nt->parms);
-
-	if (nt->parms.collect_md) {
-		if (rtnl_dereference(ign->collect_md_tun))
-			return -EEXIST;
-	} else {
-		if (ip6gre_tunnel_find(net, &nt->parms, dev->type))
-			return -EEXIST;
-	}
-
 	if (dev->type == ARPHRD_ETHER && !tb[IFLA_ADDRESS])
 		eth_hw_addr_random(dev);
 
@@ -1909,12 +1934,26 @@ static int ip6gre_newlink(struct net *sr
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
-	int err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
 	struct ip6_tnl *nt = netdev_priv(dev);
 	struct net *net = dev_net(dev);
+	struct ip6gre_net *ign;
+	int err;
+
+	ip6gre_netlink_parms(data, &nt->parms);
+	ign = net_generic(net, ip6gre_net_id);
+
+	if (nt->parms.collect_md) {
+		if (rtnl_dereference(ign->collect_md_tun))
+			return -EEXIST;
+	} else {
+		if (ip6gre_tunnel_find(net, &nt->parms, dev->type))
+			return -EEXIST;
+	}
 
+	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
 	if (!err) {
 		ip6gre_tnl_link_config(nt, !tb[IFLA_MTU]);
+		ip6gre_tunnel_link_md(ign, nt);
 		ip6gre_tunnel_link(net_generic(net, ip6gre_net_id), nt);
 	}
 	return err;
@@ -1966,8 +2005,10 @@ static int ip6gre_changelink(struct net_
 	if (IS_ERR(t))
 		return PTR_ERR(t);
 
+	ip6gre_tunnel_unlink_md(ign, t);
 	ip6gre_tunnel_unlink(ign, t);
 	ip6gre_tnl_change(t, &p, !tb[IFLA_MTU]);
+	ip6gre_tunnel_link_md(ign, t);
 	ip6gre_tunnel_link(ign, t);
 	return 0;
 }
@@ -2121,12 +2162,26 @@ static int ip6erspan_newlink(struct net
 			     struct nlattr *tb[], struct nlattr *data[],
 			     struct netlink_ext_ack *extack)
 {
-	int err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
 	struct ip6_tnl *nt = netdev_priv(dev);
 	struct net *net = dev_net(dev);
+	struct ip6gre_net *ign;
+	int err;
+
+	ip6gre_netlink_parms(data, &nt->parms);
+	ign = net_generic(net, ip6gre_net_id);
+
+	if (nt->parms.collect_md) {
+		if (rtnl_dereference(ign->collect_md_tun_erspan))
+			return -EEXIST;
+	} else {
+		if (ip6gre_tunnel_find(net, &nt->parms, dev->type))
+			return -EEXIST;
+	}
 
+	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
 	if (!err) {
 		ip6erspan_tnl_link_config(nt, !tb[IFLA_MTU]);
+		ip6erspan_tunnel_link_md(ign, nt);
 		ip6gre_tunnel_link(net_generic(net, ip6gre_net_id), nt);
 	}
 	return err;
@@ -2158,8 +2213,10 @@ static int ip6erspan_changelink(struct n
 	if (IS_ERR(t))
 		return PTR_ERR(t);
 
+	ip6gre_tunnel_unlink_md(ign, t);
 	ip6gre_tunnel_unlink(ign, t);
 	ip6erspan_tnl_change(t, &p, !tb[IFLA_MTU]);
+	ip6erspan_tunnel_link_md(ign, t);
 	ip6gre_tunnel_link(ign, t);
 	return 0;
 }
