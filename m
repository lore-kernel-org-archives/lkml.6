Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519839031-2-7480459483456440253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839031; b=hnCjkWiapK3l8KkRPtjSFQy3Lj/uPzWYUktIEnuuC2yq7zM
    qKJBgmlcORipEUAA68ryrQKo0cis5BQUOiuC/7WQed2M8ddeucD2HXryddAH2OgW
    E6OQFZlfFZEnfJgRYzhIV9cxWue+QMmqpn6mM9+a4KQa9CKgdQmLMjgFSLHdCqw4
    gXkwHo1In2J10DCE74nbLjBTIm0AXi+HtMVpPlFvzUynXbeooBeBfT0Jjqhe3yWV
    78+NHGVmQI8TFSvvvoQyUz0G79LTf/FzkREZln7gXoZR/fcwJEP6IM9ghIgZakfs
    1+9fvpvvKCl24auf9rjPar6vEP+OSPznYDgQ82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839031; bh=eXfeKMY0bPLU8QpfnKr
    2S0JWAPMccAzbMQgetLoqbcY=; b=TE4Z6X1Ja5xzSGrycgAoNsKf05D6t4om2AM
    1y/ijl2VD2Xg+QqatZbWixwmkAlgsV9C1V7R5J9b9NsKH+RB4CnAI2vc//vOBu0p
    kr1CuRRnhDfeQOUYPY1UI0wJp2dC3EdTPPyazFqsVye6o8AtBibz6YvbvKUqv+el
    UkLgwmiz6Bex0UnXlgqKieQRnIX3MyJgIYyXFzWQnMS8NmRfvMmy0fX4qdu9yuKa
    E0RfCaQt2GXhcN1EyNZqa9eRb28VhJfbNsieB2Jg/+1v80uLDcjHU0f9wjeHo/lt
    NEcP5Yok5XYc5AJc9mkvtrTYAsJHDIJIbVXE6l3uZf9p+wjJcWw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933494AbeB1R3K (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:29:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33233 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932583AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Kevin Cernekee" <cernekee@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Andrew Lunn" <andrew@lunn.ch>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.831301160@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 113/140] net: igmp: Use correct source address on
 IGMPv3 reports
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Cernekee <cernekee@chromium.org>

commit a46182b00290839fa3fa159d54fd3237bd8669f0 upstream.

Closing a multicast socket after the final IPv4 address is deleted
from an interface can generate a membership report that uses the
source IP from a different interface.  The following test script, run
from an isolated netns, reproduces the issue:

    #!/bin/bash

    ip link add dummy0 type dummy
    ip link add dummy1 type dummy
    ip link set dummy0 up
    ip link set dummy1 up
    ip addr add 10.1.1.1/24 dev dummy0
    ip addr add 192.168.99.99/24 dev dummy1

    tcpdump -U -i dummy0 &
    socat EXEC:"sleep 2" \
        UDP4-DATAGRAM:239.101.1.68:8889,ip-add-membership=239.0.1.68:10.1.1.1 &

    sleep 1
    ip addr del 10.1.1.1/24 dev dummy0
    sleep 5
    kill %tcpdump

RFC 3376 specifies that the report must be sent with a valid IP source
address from the destination subnet, or from address 0.0.0.0.  Add an
extra check to make sure this is the case.

Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/igmp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -89,6 +89,7 @@
 #include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/times.h>
+#include <linux/byteorder/generic.h>
 
 #include <net/net_namespace.h>
 #include <net/arp.h>
@@ -299,6 +300,23 @@ igmp_scount(struct ip_mc_list *pmc, int
 	return scount;
 }
 
+/* source address selection per RFC 3376 section 4.2.13 */
+static __be32 igmpv3_get_srcaddr(struct net_device *dev,
+				 const struct flowi4 *fl4)
+{
+	struct in_device *in_dev = __in_dev_get_rcu(dev);
+
+	if (!in_dev)
+		return htonl(INADDR_ANY);
+
+	for_ifa(in_dev) {
+		if (inet_ifa_match(fl4->saddr, ifa))
+			return fl4->saddr;
+	} endfor_ifa(in_dev);
+
+	return htonl(INADDR_ANY);
+}
+
 static struct sk_buff *igmpv3_newpack(struct net_device *dev, unsigned int mtu)
 {
 	struct sk_buff *skb;
@@ -345,7 +363,7 @@ static struct sk_buff *igmpv3_newpack(st
 	pip->frag_off = htons(IP_DF);
 	pip->ttl      = 1;
 	pip->daddr    = fl4.daddr;
-	pip->saddr    = fl4.saddr;
+	pip->saddr    = igmpv3_get_srcaddr(dev, &fl4);
 	pip->protocol = IPPROTO_IGMP;
 	pip->tot_len  = 0;	/* filled in later */
 	ip_select_ident(skb, NULL);
