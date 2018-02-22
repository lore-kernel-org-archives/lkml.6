Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488377-1519314965-3-15349550445084438383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519314965; b=Wm9HIumvn7zcQeNHh+Q3IfHQv+Aa7MFbAxq/DoMaiQ0tO/Q
    +o6TbWjvdGZo5hzxUEdv3SpiMXTAQhyBqfpZpMIkWzpr4yuTqmaLJcJd2OxA7SH5
    xRskJst9DMI1hflNfeBDM8AUFQwNRwOG5oUQKbr4TtVESWt68Fg2SjfargiRxTMg
    nUSjv1XdlZvo/SE5dVLt/wAZ9TX/yWT/XR3YkoEM+9TLNz+GNDEXS72YsMzr/fmV
    4kY3BJtaHvzWAkzo+0ru7zBg4aeyqFreM2NAOyQFzs/fZdtW1TPNHFBgvYbDSbRJ
    ovuLw7HnqZXW8BuEbOvAW50IUIf0dfXZmx2wYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519314965; bh=ocGgBYeNqdUxJxjgr05frWYWbW
    fTIEDAnhgmcCtDfxg=; b=FJUkgJu+rs66H38vT/PCN3DAgpPPzmodaENQYHQwKx
    ifpv5XxfTCetMllqlNq0du+Z9bhkxuDGSTtA3oSZxpRoNzcCunn1RtsR22hKyetk
    2Y3DY4dIKc0bm+OXdheW9U9czzYdSiYISNINcCM4MK2BKyNoaj8DNwoanCVnzbXV
    iy6T8FeKoMzxVeWN+zVQdIeONNvPfPfAYynui3PMAnpR0IkbCX7+CAPwA7VgVezL
    a3Dv91vRgUT073+6iJ7nsjCzM0/HY989R2xCHpFO5ZZzceA5auEQMuMmBUIvGmLD
    o9+WvBd/yWiFO1nOGiNQG3vCOizpawjGktkl+QnvjHJg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933002AbeBVP4C (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 10:56:02 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56989 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933001AbeBVP4B (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 10:56:01 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Martin Sebor <msebor@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        WANG Cong <xiyou.wangcong@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Craig Gallek <kraig@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6 sit: work around bogus gcc-8 -Wrestrict warning
Date: Thu, 22 Feb 2018 16:55:34 +0100
Message-Id: <20180222155546.1747665-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:M8MVWfIicySQgoVUzu8cEuhR+hO9Q7VirmWjKHNEU4J74FhycuE
 t4g0us61p/wrPXGsQ2/cX1hBAW38P167jcYbx8nbQiD5ivyOVugDcX1aco4r0P9GFsZCxYz
 EMpHQVyRK6PlbaJMowDlRlEqQS/1R9CX/qGO9bodlEP9GNUhrVQhK6Ie7zLEtR4dlRDMEzw
 hCpLhXB6VU9p4caJnJFhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sA40HkS2yWM=:KGJ7CgKZCPvOWw1hqI0tD5
 SeicW1Wp2ssaB52zpXFkoW8X2JUHJnA/52a+pWbaweM7ocSQts5oG3gyHwT3qXXtS2E+LTYFl
 gapm2Bl7Njn37uTuIpD2b0nY7d10p5ti0vrqEfJlMeFxdRJ/wLPYJ/O2jr1I5JrnDWI6yITEr
 G8DVLWxPzrNEmwtGxA7wCYffy49UCxeNt0pRXvH7UcnHSlmd8lYTCvx6xPPA4xP6rhKO8eYpW
 0uMTS+qseMy6w1HNt2rT010cO47x80mD3D1SevlzSPizN7K0PBCEbjmaz9Egy1Cc0RKxbndvA
 j52+0tmF4ZzKLy6j8H161RwFLt1nY8RcTIZyoPZJHjRmiFn7S/9aRjM5aGnEVdkIC+veCXNTi
 vmqLv/Doh7e3+Vqh1QoBrpVon7QpHIIyJI6zlQheRvJGk4NVxhAlWLlwPoXfCC0jWyOM7v/9o
 o0fdsHOC7HEJk6RyWIg7hTL/KTnJ3X6Oc8g6FXmeul965opVzj3rBj0aoj3wIaaZ9ybzE1lUr
 7jQGQuveZpG5Bq25sx2lO4SB0nQ2MAgl0Me16dmsuw3cCVnAme7v7126Deq3PrwmlB/8hDUGS
 4l4oq7czdGgJfmDwHJliSAzSAxyyLJIfmhxVamYp8QcXAMx9NoRzZ37nnd9oIU+QTCP8JlfOC
 yjXxrIGWEvYhMoGDzUgGe6O1Uo05I/gkbdssyyu5W3Qlpco2AQ7wPo80cWPDcI7F6T7L2BNnK
 ICZt4sfpWkuz1qeSRtsdhWQylE8MkCrLqVMLag==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

gcc-8 has a new warning that detects overlapping input and output arguments
in memcpy(). It triggers for sit_init_net() calling ipip6_tunnel_clone_6rd(),
which is actually correct:

net/ipv6/sit.c: In function 'sit_init_net':
net/ipv6/sit.c:192:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

The problem here is that the logic detecting the memcpy() arguments finds them
to be the same, but the conditional that tests for the input and output of
ipip6_tunnel_clone_6rd() to be identical is not a compile-time constant.

We know that netdev_priv(t->dev) is the same as t for a tunnel device,
and comparing "dev" directly here lets the compiler figure out as well
that 'dev == sitn->fb_tunnel_dev' when called from sit_init_net(), so
it no longer warns.

This code is old, so Cc stable to make sure that we don't get the warning
for older kernels built with new gcc.

Cc: stable@vger.kernel.org
Cc: Martin Sebor <msebor@gmail.com>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83456
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/ipv6/sit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 3873d3877135..3a1775a62973 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -182,7 +182,7 @@ static void ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_net *sitn)
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel *t = netdev_priv(dev);
 
-	if (t->dev == sitn->fb_tunnel_dev) {
+	if (dev == sitn->fb_tunnel_dev) {
 		ipv6_addr_set(&t->ip6rd.prefix, htonl(0x20020000), 0, 0, 0);
 		t->ip6rd.relay_prefix = 0;
 		t->ip6rd.prefixlen = 16;
-- 
2.9.0
