Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523021869-5-1198392412520914418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021869; b=fKVd9hxJyBBK6gtGXF5zGPOQZRpsWm16NlSR+VKves21ubyHDv
    eRE4PP7cfPH3GZxZf2PGEn2jDEHLXWoXfmgzUUOPcfVCfWwl5Q9TlgganifjsaZO
    QzT4jQrdvw2N2HzoCPa6r191OAkfop1TDzHb3nclr5nk6zq1ZmcZTMXiII3O7JLw
    PO1w2dTA6ujKQf95AugejKnjSC+6u5LOR4tqdZZ3tB/yaXZhAGNiJ7WLCYEex8ZM
    M1IPBkqe3JYUDB5ZGgXLQa3W7Ae2OxOzTrvIa4q7+e1ldqxcY5VaNB7Dv8IkN7TQ
    MSI371GxWFd8daaTKdDyPkHkmwUr9+GC1NmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021869; bh=2yFmVGB8rEVxdqhOMLFGCEQ27fAvwj
    fjqfjpc8HQi/U=; b=l1gmhMOqojV+Nu/O7GudW9J9sQIzlkAq08HPpk4NZzL/Oa
    ULB9izdNfrzAgIJV0E0Eqiw5mkPVs4MUId4PByVaFvi+JPhF9QD2GC1j/UdFyxwJ
    GXgeQ2MeK2PKmanipYY+ndaLsrjs6f93HVXJQzQsTajT0h18YlXdWSyXzVAOtvc5
    xNAVKp6jRqAxZ8OtJIFzCzdbHxkFi4Xou56strYAwlr/6Hskple9lwKXyHa1E4DA
    UlGyno31cYgDLfbRxSXFIhQTy073fbOGnmQPxkM4EjJ+HajDJZGAQae5OAGIFhA+
    SIxkESee1kqPXAs9FF/rIRtJCf+HtKWWh3FktZpA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfLbuMIxS8rrOcB70FckqR7lcWS57X4zvdeoV9ORAg/NQtQm47rY0fF9mhwaLJSVVQP5FgGb30DkjK0cvP5cThEov+RZXcZ3v5wt657vVHULXVPmomCv3
    H3ukciqAiKqK2vCWrkxsPUBeu5cMGgUswLIMWijMD7jDkKgqJHGTjsVrWbAWOX0ay/C6Ql4IucvMl2MLkzAH1eSJTe2W5QDLPaL7Va26JwMxpJGopGktZSHY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=1EsaE_6oAAAA:8 a=yPCof4ZbAAAA:8 a=J1Y8HTJGAAAA:8
    a=20KFwNOVAAAA:8 a=oJyJ-stxlyHZbvzTRLgA:9 a=IlyE4C4KbsLB71Y_:21
    a=zWClK6shq2thlSCR:21 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=3ZumFrijQQ-2J9H5h8ct:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932305AbeDFNho (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:37:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33040 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932296AbeDFNhm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:37:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Petr Vorel <pvorel@suse.cz>,
        Alexey Kodanev <alexey.kodanev@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefano Brivio <sbrivio@redhat.com>
Subject: [PATCH 4.9 101/102] Revert "ip6_vti: adjust vti mtu according to mtu of lower device"
Date: Fri,  6 Apr 2018 15:24:22 +0200
Message-Id: <20180406084345.630242498@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 1139d77d8a7f9aa6b6ae0a1c902f94775dad2f52 which is
commit 53c81e95df1793933f87748d36070a721f6cb287 upstream.

Ben writes that there are a number of follow-on patches needed to fix
this up, but they get complex to backport, and some custom fixes are
needed, so let's just revert this and wait for a "real" set of patches
to resolve this to be submitted if it is really needed.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |   20 --------------------
 1 file changed, 20 deletions(-)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -625,7 +625,6 @@ static void vti6_link_config(struct ip6_
 {
 	struct net_device *dev = t->dev;
 	struct __ip6_tnl_parm *p = &t->parms;
-	struct net_device *tdev = NULL;
 
 	memcpy(dev->dev_addr, &p->laddr, sizeof(struct in6_addr));
 	memcpy(dev->broadcast, &p->raddr, sizeof(struct in6_addr));
@@ -638,25 +637,6 @@ static void vti6_link_config(struct ip6_
 		dev->flags |= IFF_POINTOPOINT;
 	else
 		dev->flags &= ~IFF_POINTOPOINT;
-
-	if (p->flags & IP6_TNL_F_CAP_XMIT) {
-		int strict = (ipv6_addr_type(&p->raddr) &
-			      (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL));
-		struct rt6_info *rt = rt6_lookup(t->net,
-						 &p->raddr, &p->laddr,
-						 p->link, strict);
-
-		if (rt)
-			tdev = rt->dst.dev;
-		ip6_rt_put(rt);
-	}
-
-	if (!tdev && p->link)
-		tdev = __dev_get_by_index(t->net, p->link);
-
-	if (tdev)
-		dev->mtu = max_t(int, tdev->mtu - dev->hard_header_len,
-				 IPV6_MIN_MTU);
 }
 
 /**
