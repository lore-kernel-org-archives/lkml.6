Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1758260-1527157672-2-8614390604105778005
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
    1527157671; b=jhw/nea5m0JZdUYoZjU8+IDhcB8L7k0s3YtfPnmZwGAwO2SacD
    nVKA2bJtF9rHfplvGCI1Yz6HxJwJH/vAbu6NOCHJevXUNiBcY3mXtBoMaWLKWzqZ
    hUZJ+AN5tEqrrdbVImS7wUYVFYxTWJOcuD9UqngrUiJo9SuS6+pKiEOTeXzC5laN
    wWh53pfCsrwkQKZ6CsgfzNuVnP8uifID3JUbVET1NMCntGG27dSCKinlKCVI4FrT
    g+hyspmJuLDpBsV2uGC06UTGBN5OShSJJJmyF776x55PNZ3Z1y9wvO03CZxvSupH
    ALMGhFuQD7esKzIHISNOQ/a3gByurJvab3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157671; bh=rmhwVvYWFfZVX9C7XdKkjuoZMJon6d
    Gh5BQorYm8Ovc=; b=ESwe7PkvujiDJ1A4NTOb/TVxZaJ9f8uVFjKgiPCWCiS5cQ
    G2wT6Jfi8Nrw4/5E3ipWZZUSNRMcu4swzHM0BNClGXt8ojr/lYpP+sUpZdUfdLKA
    DOb8JfgRZ9bumIZ2t88s4Wu9cQ4aJk2QgPgmV0KjR2HRk85a7mLlf8Q/qbT5qipJ
    30JfxUjI/fdc/pw0P7yRByJbc/yAWHUQtBfxaS/MehYGn9m3NSU2T5E0q3PIdSdE
    M8tccc+ceaQlj8hAVxYMMQGvnUtZxUDA2l8fY8lHDsciXv7CYBbAOZcxbF1ZOeTT
    tKG1X/LgaRpRikTsq9Bf2JGz0HYLTzxfLylrIp1Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=JsUNUHs1 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=JsUNUHs1 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNJNtNz3i9rj7cHvqkVqdZmNOscnNOKOXAwkxmkuRvhi8kB4IZddEYRlf0B7naRSKqYuawYebc3BtYUFGNx3NKOyqsx7laNfGxArOiHP+5ZFLzRElXNM
    XluvTUKHXaq5eLPXACdj4/8ea6NYmfKG+VtZupFPaWG+guV4EutHXRPKYY24aYZRG6iIo6jcggadi9LxvF3ikVuoCXQPJhw1uCuPx95qe9F15WB0bWpIh8i8
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=CbDCq_QkAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=NM5VfiKHdIAMy8CaKHMA:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030970AbeEXKBi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030712AbeEXKBe (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        William Tu <u9012063@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 026/161] net: ip6_gre: Split up ip6gre_newlink()
Date: Thu, 24 May 2018 11:37:31 +0200
Message-Id: <20180524093021.461588013@linuxfoundation.org>
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

[ Upstream commit 7fa38a7c852ec99e3a7fc375eb2c21c50c2e46b8 ]

Extract from ip6gre_newlink() a reusable function
ip6gre_newlink_common(). The ip6gre_tnl_link_config() call needs to be
made customizable for ERSPAN, thus reorder it with calls to
ip6_tnl_change_mtu() and dev_hold(), and extract the whole tail to the
caller, ip6gre_newlink(). Thus enable an ERSPAN-specific _newlink()
function without a lot of duplicity.

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: William Tu <u9012063@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1848,9 +1848,9 @@ static bool ip6gre_netlink_encap_parms(s
 	return ret;
 }
 
-static int ip6gre_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
+				 struct nlattr *tb[], struct nlattr *data[],
+				 struct netlink_ext_ack *extack)
 {
 	struct ip6_tnl *nt;
 	struct net *net = dev_net(dev);
@@ -1887,18 +1887,30 @@ static int ip6gre_newlink(struct net *sr
 	if (err)
 		goto out;
 
-	ip6gre_tnl_link_config(nt, !tb[IFLA_MTU]);
-
 	if (tb[IFLA_MTU])
 		ip6_tnl_change_mtu(dev, nla_get_u32(tb[IFLA_MTU]));
 
 	dev_hold(dev);
-	ip6gre_tunnel_link(ign, nt);
 
 out:
 	return err;
 }
 
+static int ip6gre_newlink(struct net *src_net, struct net_device *dev,
+			  struct nlattr *tb[], struct nlattr *data[],
+			  struct netlink_ext_ack *extack)
+{
+	int err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	struct ip6_tnl *nt = netdev_priv(dev);
+	struct net *net = dev_net(dev);
+
+	if (!err) {
+		ip6gre_tnl_link_config(nt, !tb[IFLA_MTU]);
+		ip6gre_tunnel_link(net_generic(net, ip6gre_net_id), nt);
+	}
+	return err;
+}
+
 static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 			     struct nlattr *data[],
 			     struct netlink_ext_ack *extack)
