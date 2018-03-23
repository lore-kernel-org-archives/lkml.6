Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806906-2-8530292530940867753
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806905; b=hSmT7DzmCPtAu86SnEcx5zXiCBE9uVpeg0RM82Kfxss4Eqi
    +xQPp11lEr/qTmmQ6qJYozmIccfXX6R0Snpbxx3opGBkd6Lm0KraARqYjbEj0Qfq
    iRHn0sNKu4qyEBcPvgxRvldIkiWImFmJZgHXOSdy6nIKCVU4IG1oOyWrcRNvTEv4
    bkHgQjK8QsNQXTEETtJc2HG9gNJkiCtIweCSvOLiUv4DIcT6TzAR4iYqGhJt7QH4
    TGUk9NLlcaXTrL9/Sa3GYmzmk5lJEUXRgJlOfzcp4DGbU6eKG3JlH0VWEvhoREaA
    8hdtJv5I1EZrqPGIt8JKfFxJrfEneB/J5GqAxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806905; bh=gaJHehjNi+DfK8Y4X+kTGQfu3K
    Ood3hr24l510MvVgQ=; b=LwsP/FHwjvXNBQ7JFwXjOoSlvFocukY9U9tUzcBhCG
    H8f1Jt4KSvlZNKnzlWHz8e2qcq7HKxhmDkVdXX2kpa52g4gZTT2OrMGNpDS/v5SW
    kHqcK7DGIIwvs5d2NSRFil03YrP+KGO2IynBoWnAfh7cbcospkhyGcg+7PRlCEnJ
    HtIDFMqMCgYTXiHGVVrv1qln2JAbCLPbkCDcNEZAuG2TgvK+WNij85d9QTr84ROR
    QIZVuZ72Lp/UebTpQCJwoQTzS1AZHbLLzoQKp88npZ+IRnNMHdUvUXcpnzaEgyAe
    NwEuTa7vXfzI7uDPSnLPvpcfXXTgUNy1C1BEkp5Luecg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeCWJ6i (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:58:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeCWJ6g (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Alexey Kodanev <alexey.kodanev@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 61/84] ip6_vti: adjust vti mtu according to mtu of lower device
Date: Fri, 23 Mar 2018 10:54:15 +0100
Message-Id: <20180323095421.211833920@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>


[ Upstream commit 53c81e95df1793933f87748d36070a721f6cb287 ]

LTP/udp6_ipsec_vti tests fail when sending large UDP datagrams over
ip6_vti that require fragmentation and the underlying device has an
MTU smaller than 1500 plus some extra space for headers. This happens
because ip6_vti, by default, sets MTU to ETH_DATA_LEN and not updating
it depending on a destination address or link parameter. Further
attempts to send UDP packets may succeed because pmtu gets updated on
ICMPV6_PKT_TOOBIG in vti6_err().

In case the lower device has larger MTU size, e.g. 9000, ip6_vti works
but not using the possible maximum size, output packets have 1500 limit.

The above cases require manual MTU setup after ip6_vti creation. However
ip_vti already updates MTU based on lower device with ip_tunnel_bind_dev().

Here is the example when the lower device MTU is set to 9000:

  # ip a sh ltp_ns_veth2
      ltp_ns_veth2@if7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 ...
        inet 10.0.0.2/24 scope global ltp_ns_veth2
        inet6 fd00::2/64 scope global

  # ip li add vti6 type vti6 local fd00::2 remote fd00::1
  # ip li show vti6
      vti6@NONE: <POINTOPOINT,NOARP> mtu 1500 ...
        link/tunnel6 fd00::2 peer fd00::1

After the patch:
  # ip li add vti6 type vti6 local fd00::2 remote fd00::1
  # ip li show vti6
      vti6@NONE: <POINTOPOINT,NOARP> mtu 8832 ...
        link/tunnel6 fd00::2 peer fd00::1

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -626,6 +626,7 @@ static void vti6_link_config(struct ip6_
 {
 	struct net_device *dev = t->dev;
 	struct __ip6_tnl_parm *p = &t->parms;
+	struct net_device *tdev = NULL;
 
 	memcpy(dev->dev_addr, &p->laddr, sizeof(struct in6_addr));
 	memcpy(dev->broadcast, &p->raddr, sizeof(struct in6_addr));
@@ -638,6 +639,25 @@ static void vti6_link_config(struct ip6_
 		dev->flags |= IFF_POINTOPOINT;
 	else
 		dev->flags &= ~IFF_POINTOPOINT;
+
+	if (p->flags & IP6_TNL_F_CAP_XMIT) {
+		int strict = (ipv6_addr_type(&p->raddr) &
+			      (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL));
+		struct rt6_info *rt = rt6_lookup(t->net,
+						 &p->raddr, &p->laddr,
+						 p->link, strict);
+
+		if (rt)
+			tdev = rt->dst.dev;
+		ip6_rt_put(rt);
+	}
+
+	if (!tdev && p->link)
+		tdev = __dev_get_by_index(t->net, p->link);
+
+	if (tdev)
+		dev->mtu = max_t(int, tdev->mtu - dev->hard_header_len,
+				 IPV6_MIN_MTU);
 }
 
 /**
