Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473962-2-8920887159118656018
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
    1523473962; b=RhWmsD17om0xrd3yp85kj9K7Bq7p6m5wQSA4AfTbIFkzWSMAR0
    Tdtz5VXFQ11pd+BPVYi10c04rAGYZ7AGNwW2aM9/Z47TjOibODLzoGQOsOXyhza+
    OwCpOfi7tQQ9veZplvIxWJ/f8xDZqX0/2R1DJlbSIuPh6L90YimwaQ3Llnsq1Ugv
    HBGETMxw81TCmkYy7i2lYpYdpslgjHQMRJucyBXOALil1WkY/9PGxo5ZVBw/1dC/
    D2hkWMZLaHXd3/EG8mGLwZSiroZ/oqfO/t+z8GEbPTKdZZ0e4Lt0Rc1fhl0L/KaL
    xde8nLJw+e3xRSdMj+P7ZQ0ZYvpXLmxhdrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473962; bh=xwmL6vHVHFmd37gDfHirJGTgECpz2D
    UZo5BrS5j4+hE=; b=sp/ZGneq7FqnCx4g3NqGy0tCx/iKk+gMYW3YriPgCRvQFt
    qoig08/I4X3lS5Wz/lvIqqVjpHTDo6fWyISdoEd7iNKP/0daKUkOyZIUt9qePy/x
    qAaJ7hojzMTvcBCEJW/2oHpBFWRYRkMuss7dc7ETBBRnYefff+5y9Y7rUEUPB2I8
    T42lmPLOC8lDUzxGJptAae2YjSHGu14dnn9ON367pyyQYU2plzvjShbBaIT6djeS
    77beJfkM6/LYvk2tos6NZEgebw6ps3IxkFxDxQU8i7suCG+sFFl/fnM4yOGWXQFQ
    optxCmv745X6hU1emmbKNV/Q8dO1V3c1X2HYef8Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfH+jLCFS/zG8rAsun6Nisy52gYN+LldxTyADndYVFHg7si2oqlMlyt11ZLMhGXptgBl/QW3jApvacylws6EZ6WEMRs1mXieaYnqK47OX3cP6BeLwLv86
    ANX/xqz80Hh6JmtUKjn/3D7T1dKbvEFg1H6nEVVSAi1cddJ2fuTwyG8IQ1vpNG+QDfaodDU6ZzjkVkZHuCRGAa9UsBhEYTSbiBfp2t4TXyXM8398BIGq8Zqs
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=ns78XzXtQwmIs28envIA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935156AbeDKTGN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:06:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934218AbeDKTGM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 297/310] ip6_tunnel: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 20:37:16 +0200
Message-Id: <20180411183635.350334793@linuxfoundation.org>
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


[ Upstream commit db7a65e3ab78e5b1c4b17c0870ebee35a4ee3257 ]

Use valid_name() to make sure user does not provide illegal
device name.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -298,13 +298,16 @@ static struct ip6_tnl *ip6_tnl_create(st
 	struct net_device *dev;
 	struct ip6_tnl *t;
 	char name[IFNAMSIZ];
-	int err = -ENOMEM;
+	int err = -E2BIG;
 
-	if (p->name[0])
+	if (p->name[0]) {
+		if (!dev_valid_name(p->name))
+			goto failed;
 		strlcpy(name, p->name, IFNAMSIZ);
-	else
+	} else {
 		sprintf(name, "ip6tnl%%d");
-
+	}
+	err = -ENOMEM;
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN,
 			   ip6_tnl_dev_setup);
 	if (!dev)
