Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523474073-2-9727256583933481670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523474072; b=ZFxQ1dRMoMYi6Qo4InwMI8GhD3oY5bsfUL5gAQ3RKLFEuGuC6a
    ykaQZ7OidakN6twRrAERUW5clzeY+y4l71GNZWjgpkLyXyWTY3Mw4hu4zuuPUDPc
    DQVM+7Fh5860TF+jdQf9Ei7JeujYZaaDERhLKhH5tvrvNAk8shd+e5VQwPnRPABw
    HmkWWtOMjOGyIa2cWXGzJeBIPMc1EcqjCPcTcL0qGNcYhgU7SXis34dAnhdAsw8S
    QdzxGpzFoWnRd6FnpzBFiKXYbUAA/TljPFgpPMPHiyL1batQvUzQuHWwytykqIdE
    KG2RnRozULXK7pIeCGqyvWdylW50i8MU6nCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523474072; bh=zJYEN1buSqMgGnkRQuEsJVcs42v32m
    N+iiuN/q5munk=; b=ANUqZBYVhMaiBj33bd3yLomFKyWd57MEF/37lCT/tUHy9C
    9aECwYBdcDEgg1cH2ZjiiYoUTrhuqQhUWem+zd8IufGZ98rHJfYHISvZowc9Gftz
    BEIxSIIE6UzgcKW7OQIVtDijfyKWPLX89RtMnEodhe3edlnNiyFYGAhAr6Dc1v1r
    y5rjypy4nhMYikbRkVx+LzPtbAuL137pibZkTaZTgldh3t53IwCbM9vJPhkfi3LH
    qJGn7Rvr8EQRWTw1lTWlO52pHIQbUrFJ3tPlShIKUad/NwWBnCAVqhvoVzOr+CdO
    CHglGIMosnQp6/aUklf47J4L1SGoANbiG6iz8qEw==
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
X-CM-Envelope: MS4wfCu4RNOYX9BuA3P/52VisRdQdG2kneoxFpWFgNef+LrO67vRMho6feelgweC/2E5WwCvcGWK/Gv5lnp5+NN2y13LM1m3sVsuRJaJxsCjdLgK+vBtcPnR
    aWjG5ddw108XqSi42yTpgENvhLbDWOc3Fy41vGdv6WVd1KwLtugz05GeETXnoL/beA9sSrvSbXX249b9zFy8QVoAme1OrX3Lg4GQ1cR/hsmEgIJcTKNqUoZN
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CDq0vqnqAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=ceBOlClKuZrOhC7ioUIA:9 a=QEXdDO2ut3YA:10 a=Xn7iXEen_xUG9zZOO_Hb:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757022AbeDKTOP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:14:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935081AbeDKTFo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:05:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 253/310] vxlan: dont migrate permanent fdb entries during learn
Date: Wed, 11 Apr 2018 20:36:32 +0200
Message-Id: <20180411183633.315624530@linuxfoundation.org>
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

From: Roopa Prabhu <roopa@cumulusnetworks.com>


[ Upstream commit e0090a9e979de5202c7d16c635dea2f005221073 ]

This patch fixes vxlan_snoop to not move permanent fdb entries
on learn events. This is consistent with the bridge fdb
handling of permanent entries.

Fixes: 26a41ae60438 ("vxlan: only migrate dynamic FDB entries")
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -930,7 +930,7 @@ static bool vxlan_snoop(struct net_devic
 			return false;
 
 		/* Don't migrate static entries, drop packets */
-		if (f->state & NUD_NOARP)
+		if (f->state & (NUD_PERMANENT | NUD_NOARP))
 			return true;
 
 		if (net_ratelimit())
