Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481815-2-3217664199612723706
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
    1523481814; b=nzsJwjCAvNwKeeEVoew+DOKtpK+eA+YQyejwroPIHaH2f7x/Rq
    qJusNM+hIdeOI+bYEc54sAOxwU5cOTLThMJJvnT4XNhqmV4jIr7u3g2UriBeH1RB
    c+axfhD8ikLHy8efILvg9JbxTRQT8hgs7ug1KngeqlmI+MLHaSqwn3yNtFJWIDhl
    T1XC2419WSjOfS0xnUblSLn7dcJoIr/uptBhViQZWsaqBQCPpXGQVJpgJ4HfV1x7
    jyf51+TwJXODisIBFiXw1b/ozmNy36TPRuDDxhH9X/uljP3RmWoo1SSkAlhy3p5A
    ZZky1ERM2GwXJyPeQ01gSMfR/dCIFq6W0pfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481814; bh=QNE0LRhAaa2w+fRIgafW8QzXoIYY3z
    D2J2ZkbmW+B6Q=; b=aHVOng0LyBde2NPBOYapPZvrfRJyCU5AC5aoadMzB/VGBU
    vZGe/BT9HFzYkxk+qnCMGvvoNX2iK9LIAaWKftQbGMQpzlhZ1OOREwqFp+4a9BGW
    3DgMqRLBxBgFII89qzYqivB7Xg7UsC1ZbExW4oJkqnYgd1K/ME2bEy2TE64fzmc0
    M39ZX5zSqdAp7bguaLXKreBJPtv9M+Y5Iptl3jo8+ORFP5w7enPnq2G0AyRyLaMW
    l9W+UA2lltuY+REPJ2a5o7B69p1vq77jwJCb0AnV38Nk0dcscHXtxEEcEYTcodAr
    giEqmNO7Ajv0wSq6VGyB0egvG45J/cgiaNrGFGxw==
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
X-CM-Envelope: MS4wfC0bIYDuhcARD5JmZWOowwoljxYWFOclSZUvBuYBXqjQr8WsqNV7G5uBoPRHfpclITvSUGcqbNTffHaGp7CR92bc5qM1mR33pEUQx6dVyBP1rRTFbcff
    W+RID/UhikRCl5Rs5WADPiXN9/DPLs3lbCaF+QBdLqnRRfn7LHylH1MgswOEIhdDigA7vTHFUbbvlZ2JCBdjEZZjDYYyfdNVGJaFoDCP+xp6IkfU4/6l5uyi
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=NUbxAs7sSD6k2ad-um8A:9 a=62Qm8Ey8aUMBOaIT:21 a=21gJYK24BUSytGfG:21
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbeDKSit (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:38:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55530 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbeDKSir (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:38:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ihar Hrachyshka <ihrachys@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 027/121] neighbour: update neigh timestamps iff update is effective
Date: Wed, 11 Apr 2018 20:35:30 +0200
Message-Id: <20180411183457.758935136@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ihar Hrachyshka <ihrachys@redhat.com>


[ Upstream commit 77d7123342dcf6442341b67816321d71da8b2b16 ]

It's a common practice to send gratuitous ARPs after moving an
IP address to another device to speed up healing of a service. To
fulfill service availability constraints, the timing of network peers
updating their caches to point to a new location of an IP address can be
particularly important.

Sometimes neigh_update calls won't touch neither lladdr nor state, for
example if an update arrives in locktime interval. The neigh->updated
value is tested by the protocol specific neigh code, which in turn
will influence whether NEIGH_UPDATE_F_OVERRIDE gets set in the
call to neigh_update() or not. As a result, we may effectively ignore
the update request, bailing out of touching the neigh entry, except that
we still bump its timestamps inside neigh_update.

This may be a problem for updates arriving in quick succession. For
example, consider the following scenario:

A service is moved to another device with its IP address. The new device
sends three gratuitous ARP requests into the network with ~1 seconds
interval between them. Just before the first request arrives to one of
network peer nodes, its neigh entry for the IP address transitions from
STALE to DELAY.  This transition, among other things, updates
neigh->updated. Once the kernel receives the first gratuitous ARP, it
ignores it because its arrival time is inside the locktime interval. The
kernel still bumps neigh->updated. Then the second gratuitous ARP
request arrives, and it's also ignored because it's still in the (new)
locktime interval. Same happens for the third request. The node
eventually heals itself (after delay_first_probe_time seconds since the
initial transition to DELAY state), but it just wasted some time and
require a new ARP request/reply round trip. This unfortunate behaviour
both puts more load on the network, as well as reduces service
availability.

This patch changes neigh_update so that it bumps neigh->updated (as well
as neigh->confirmed) only once we are sure that either lladdr or entry
state will change). In the scenario described above, it means that the
second gratuitous ARP request will actually update the entry lladdr.

Ideally, we would update the neigh entry on the very first gratuitous
ARP request. The locktime mechanism is designed to ignore ARP updates in
a short timeframe after a previous ARP update was honoured by the kernel
layer. This would require tracking timestamps for state transitions
separately from timestamps when actual updates are received. This would
probably involve changes in neighbour struct. Therefore, the patch
doesn't tackle the issue of the first gratuitous APR ignored, leaving
it for a follow-up.

Signed-off-by: Ihar Hrachyshka <ihrachys@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/neighbour.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1147,10 +1147,6 @@ int neigh_update(struct neighbour *neigh
 		lladdr = neigh->ha;
 	}
 
-	if (new & NUD_CONNECTED)
-		neigh->confirmed = jiffies;
-	neigh->updated = jiffies;
-
 	/* If entry was valid and address is not changed,
 	   do not change entry state, if new one is STALE.
 	 */
@@ -1174,6 +1170,16 @@ int neigh_update(struct neighbour *neigh
 		}
 	}
 
+	/* Update timestamps only once we know we will make a change to the
+	 * neighbour entry. Otherwise we risk to move the locktime window with
+	 * noop updates and ignore relevant ARP updates.
+	 */
+	if (new != old || lladdr != neigh->ha) {
+		if (new & NUD_CONNECTED)
+			neigh->confirmed = jiffies;
+		neigh->updated = jiffies;
+	}
+
 	if (new != old) {
 		neigh_del_timer(neigh);
 		if (new & NUD_IN_TIMER)
