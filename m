Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473948-2-785964767223990472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473948; b=q3fefyNoaVHvQ3r0A97KzXhPoJuRMTRFARrS4cbD2aT/W50T6V
    nZi52AWzmsKyUanBJt8GBmT2Y9xeyVfvabqQt6NFxxVqRT/0JGcjaUnyBqm/+0j5
    JgUcBsp2tYW7MBa6v2TAmf+QnErSi7t7GwUQgvUYF0kMebjboBMZninH+qhU5Nnu
    c3YaaxpGXUvH3v2FPMvClfJmHN02t0gPQxhPVitxSACsjW2DPETQdH52clNQYsaU
    nhOQXtcK94zO4stB4KJsJKRIIDqolCeF8lS2jpFGCswY2KsfHWLCMr8TcNqFIqrq
    qvcq/NWN6+Dtscq2u+hkKVv4Qa6x02BVId7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473948; bh=gY4RmNMDzUcJ+Zq19KYX5iymprkS5N
    XIMK2qp6FScLE=; b=TcG9c5Os/lCa2RbxqIqT1mlV7KeDtIDtVo1FFaR5iTPbPz
    Q4R52Y6rQFRa2sTXx7UUGdN3zIS3jRd5hbCvToPjIWi+SHUMzvQaF7C69xXYWIxw
    nDbpu7pPsXIr7iOrWiqDgJbsZ0auzAmE2cn99/PDG7/XGcMZePqe8jYTtyMjC1qR
    ZqJe3RPYEf9zW2UFuyKQ6i/rrVNmP+tLH0r8AVyUqCf8a0QSHrBECzul+YkvdQrV
    AUkac7weebRpo2LDIE8zJt107Kipd2QIxJlv7TxYkOCNDXUHjsGDVNPCgSHP14XT
    HYFtrxXF1CaIPICHuCvB6nVmVctQOBVinemcFw+Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfNAnPOlfrmlp3tlyXHwzw/dfdE+ohySmX9M4craYE0TD/s26d5Y8jYEn7ldmOVIAHoKUc1xr2fjvAO9H+JFl3Lgv93Q6vl1mMA5rjKqBZxBKDmgDfriQ
    zzNcqw1zNUZ2maP0t616Ng3JtjU72d4JlSQKpbBDSboJjEVyBNfrjW2H/RNOAyTIGgMuNAcs7yuTNH2n7UBCf30DaQFZUsQX5EKpZS4kOqJf58Oz1bCWe6GD
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=7ZN4cI0QAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=nUoHyoXRlWenEC9CV-wA:9 a=QEXdDO2ut3YA:10 a=Dl0WHwQvj8hGZljrFLtM:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753711AbeDKTMM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:12:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935165AbeDKTGO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 298/310] vti6: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 20:37:17 +0200
Message-Id: <20180411183635.391684630@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 537b361fbcbcc3cd6fe2bb47069fd292b9256d16 ]

Use valid_name() to make sure user does not provide illegal
device name.

Fixes: ed1efb2aefbb ("ipv6: Add support for IPsec virtual tunnel interfaces")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -212,10 +212,13 @@ static struct ip6_tnl *vti6_tnl_create(s
 	char name[IFNAMSIZ];
 	int err;
 
-	if (p->name[0])
+	if (p->name[0]) {
+		if (!dev_valid_name(p->name))
+			goto failed;
 		strlcpy(name, p->name, IFNAMSIZ);
-	else
+	} else {
 		sprintf(name, "ip6_vti%%d");
+	}
 
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN, vti6_dev_setup);
 	if (!dev)
