Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1758260-1527157616-2-13876281846579524336
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
    1527157615; b=FA5Evc1T3LGTQcHP+iB9XQS2XppcZcNbFG8J175Mh2V1vx1+/7
    dKrFV/FQXVFnoqwe4g3IlBSNVaPOKrP08dwoSAPYWAXy4Q/ebq5KlEYKPHaIbnC5
    abXa8JVP75QEyhXI1nLdQruwrt1E5piBzD5ii61rsM4N/s01URYyk7DCFgIsYDMW
    a/iO3nWxdcwOU+8PL70U62WmlT6R2BKBkAdOyNFBKAqYv/runN1jIOpf4fHvEMRU
    KIR9JTNwRwlvj7W8nechaEpRnKf6H9aE5nyFOvGRWV3DUGQpOYloc9rPv9J8zooM
    myrS3Th1Sn03xdN3wYrXw5nLqNbu8oismyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157615; bh=o4ub6j85cDyM41mm2HjLmlS4cU05QO
    0LCMbBr5sV0dM=; b=lxaYK7/VNCiVPqkBRl1XAyBjcEBHS9eY9tXygLDSL2ZRmZ
    Wwh0wt98Cst7STUNqNtCGzUGp81cW6eOWWD9qJdbvaWfR7tJqHHorNCL854iEUEi
    dhzmyn5/mDEr+QB4v44hCGhZXBL2Zu3MmqsSneQT9NrZdAQF88XCSNUopNA6oi5m
    Tlrpl/LOpzUyO2eMwssDuBmjPAn/w28dA3MVUhuE8KN3inzAWon3nqQ782XOdcIk
    O7uGIvAyO/RPbTQBwbQ1oBdv5MVawlsTBeNJBCGDvRxX4nh739ybxOrGjejWdJ+/
    BAackkcsTLoMerof6dKjBDLT1Q52QoTwae1YJGHQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1JTF3+hR x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=1JTF3+hR x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMHvOWpIu4EDqzA45rtpgdo8du4R+/dBVwrsnTUaFsVrYFc7Wuk+vAF9RIBzza0r5B2JBxeIeX880SvWsdJ5DLy/UXic0cR0DLD25QbR3NwD8l5tr4T5
    a7oBCYQR+0MrcJRapl2M7jG/M+VyCIgrcwF60rvYG329q4y6nz3kXVpXuK+K5l/Cse3GfSaskZ4giLkhkB2qeR5fT362ohv6XxLHuSj6+4IDNiQ7iAL2y+jS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=CbDCq_QkAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=PlS1MkiXnQEo6SutRHkA:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030989AbeEXKBm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030973AbeEXKBk (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        William Tu <u9012063@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 028/161] net: ip6_gre: Fix ip6erspan hlen calculation
Date: Thu, 24 May 2018 11:37:33 +0200
Message-Id: <20180524093021.685154993@linuxfoundation.org>
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

[ Upstream commit 2d665034f239412927b1e71329f20f001c92da09 ]

Even though ip6erspan_tap_init() sets up hlen and tun_hlen according to
what ERSPAN needs, it goes ahead to call ip6gre_tnl_link_config() which
overwrites these settings with GRE-specific ones.

Similarly for changelink callbacks, which are handled by
ip6gre_changelink() calls ip6gre_tnl_change() calls
ip6gre_tnl_link_config() as well.

The difference ends up being 12 vs. 20 bytes, and this is generally not
a problem, because a 12-byte request likely ends up allocating more and
the extra 8 bytes are thus available. However correct it is not.

So replace the newlink and changelink callbacks with an ERSPAN-specific
ones, reusing the newly-introduced _common() functions.

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: William Tu <u9012063@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 9 deletions(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -81,6 +81,7 @@ static int ip6gre_tunnel_init(struct net
 static void ip6gre_tunnel_setup(struct net_device *dev);
 static void ip6gre_tunnel_link(struct ip6gre_net *ign, struct ip6_tnl *t);
 static void ip6gre_tnl_link_config(struct ip6_tnl *t, int set_mtu);
+static void ip6erspan_tnl_link_config(struct ip6_tnl *t, int set_mtu);
 
 /* Tunnel hash table */
 
@@ -1746,6 +1747,19 @@ static const struct net_device_ops ip6gr
 	.ndo_get_iflink = ip6_tnl_get_iflink,
 };
 
+static int ip6erspan_calc_hlen(struct ip6_tnl *tunnel)
+{
+	int t_hlen;
+
+	tunnel->tun_hlen = 8;
+	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
+		       erspan_hdr_len(tunnel->parms.erspan_ver);
+
+	t_hlen = tunnel->hlen + sizeof(struct ipv6hdr);
+	tunnel->dev->hard_header_len = LL_MAX_HEADER + t_hlen;
+	return t_hlen;
+}
+
 static int ip6erspan_tap_init(struct net_device *dev)
 {
 	struct ip6_tnl *tunnel;
@@ -1769,12 +1783,7 @@ static int ip6erspan_tap_init(struct net
 		return ret;
 	}
 
-	tunnel->tun_hlen = 8;
-	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
-		       erspan_hdr_len(tunnel->parms.erspan_ver);
-	t_hlen = tunnel->hlen + sizeof(struct ipv6hdr);
-
-	dev->hard_header_len = LL_MAX_HEADER + t_hlen;
+	t_hlen = ip6erspan_calc_hlen(tunnel);
 	dev->mtu = ETH_DATA_LEN - t_hlen;
 	if (dev->type == ARPHRD_ETHER)
 		dev->mtu -= ETH_HLEN;
@@ -1783,7 +1792,7 @@ static int ip6erspan_tap_init(struct net
 
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	tunnel = netdev_priv(dev);
-	ip6gre_tnl_link_config(tunnel, 1);
+	ip6erspan_tnl_link_config(tunnel, 1);
 
 	return 0;
 }
@@ -2108,6 +2117,53 @@ static void ip6erspan_tap_setup(struct n
 	netif_keep_dst(dev);
 }
 
+static int ip6erspan_newlink(struct net *src_net, struct net_device *dev,
+			     struct nlattr *tb[], struct nlattr *data[],
+			     struct netlink_ext_ack *extack)
+{
+	int err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	struct ip6_tnl *nt = netdev_priv(dev);
+	struct net *net = dev_net(dev);
+
+	if (!err) {
+		ip6erspan_tnl_link_config(nt, !tb[IFLA_MTU]);
+		ip6gre_tunnel_link(net_generic(net, ip6gre_net_id), nt);
+	}
+	return err;
+}
+
+static void ip6erspan_tnl_link_config(struct ip6_tnl *t, int set_mtu)
+{
+	ip6gre_tnl_link_config_common(t);
+	ip6gre_tnl_link_config_route(t, set_mtu, ip6erspan_calc_hlen(t));
+}
+
+static int ip6erspan_tnl_change(struct ip6_tnl *t,
+				const struct __ip6_tnl_parm *p, int set_mtu)
+{
+	ip6gre_tnl_copy_tnl_parm(t, p);
+	ip6erspan_tnl_link_config(t, set_mtu);
+	return 0;
+}
+
+static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
+				struct nlattr *data[],
+				struct netlink_ext_ack *extack)
+{
+	struct ip6gre_net *ign = net_generic(dev_net(dev), ip6gre_net_id);
+	struct __ip6_tnl_parm p;
+	struct ip6_tnl *t;
+
+	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
+	if (IS_ERR(t))
+		return PTR_ERR(t);
+
+	ip6gre_tunnel_unlink(ign, t);
+	ip6erspan_tnl_change(t, &p, !tb[IFLA_MTU]);
+	ip6gre_tunnel_link(ign, t);
+	return 0;
+}
+
 static struct rtnl_link_ops ip6gre_link_ops __read_mostly = {
 	.kind		= "ip6gre",
 	.maxtype	= IFLA_GRE_MAX,
@@ -2144,8 +2200,8 @@ static struct rtnl_link_ops ip6erspan_ta
 	.priv_size	= sizeof(struct ip6_tnl),
 	.setup		= ip6erspan_tap_setup,
 	.validate	= ip6erspan_tap_validate,
-	.newlink	= ip6gre_newlink,
-	.changelink	= ip6gre_changelink,
+	.newlink	= ip6erspan_newlink,
+	.changelink	= ip6erspan_changelink,
 	.get_size	= ip6gre_get_size,
 	.fill_info	= ip6gre_fill_info,
 	.get_link_net	= ip6_tnl_get_link_net,
