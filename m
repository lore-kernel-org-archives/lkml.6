Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473747-2-18038735662088025751
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
    1523473746; b=LiCp3Ia4DKGsgrejJBHw3mXb2Q9op20b1lJLkKal4+4fcTZfCm
    g5hGHZlSImGdTDq7K+5D9WhdIazAsVzLPqKAai1InItdBAjA0xHFScEOaaNrUnXO
    fmxd/Wj9rsxnzLGUwqES+dDur4qWb7KKwr9K3UkoHx24Jj/G4HnmgZOSl+1OXIe+
    ORxNU4WT44r5DcDtgXeT2tGdqK4gsd94wJFm/UmhCn6fb795z/B90nJoXZ2U+EnR
    JaMeKeQEAFm4CLB8QRbg8YhN70JaReNmJXe82afcNbFvWB/d/p04Vo86WRXjoAGm
    U+zKxkkHIdyltSsXa0wzYiQTXlOrZ6p9FRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473746; bh=1FO41nlChwpdBAxxhkQG8li8Flfa95
    FLxeaaAUJ7HtI=; b=QbX8HeehYtklBZEF0gMsgU8q1Z47ZLxWbY8uVwOmHBqSEF
    PKsMZdqmynExVV0TzVpzwmEbNxnGfjAX1qmxVE1xw97FHN/hrvETY2ndR5hq8oCz
    8u2q2r0zqlTB4dyd9M8FNCxMZ3GNOsVs5ArCbk3wDJ2NCoWLW6JzpSyE9/aizEqE
    PdByNCK9ECwFLoFEXzyqcQ2uxdGc5QzMRWAl4s1Hv/DQfHDEmTBJp9eW2ZKblVmB
    Z/0kREYYgPL+TD8XfSwW0KtUwTiMl4h9ewxbmRlMaMkiKhxqStXy4Sjw1hNDGc6f
    JDuKbcCQzyanZxy1pJxIdqDlBS4eqsL6AQKliKqw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfOOhWfZaRpXA41m0YLsPP7kFhOauoD6RcOkVwvDeDnZJPs4BHC603f6q58C7VdH8LpRQ0bseB0FLsDbpHCQpw2k303oOpb5Ofm4rQDrMZbgot4zwH1G6
    8TGi6rAZFTMH7GJt8zQqi1g1k+w6cWrSnI63/brt0YGeu9GVv3H4MZPsaPPUOKyWZyshtF9A0/eONTo/K0icx/V6CEEf08L3ShlDJOuAoBNYlhUJyYQo888F
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=-COPsrLyAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=hrFxstoo5W6S0AUybPMA:9 a=QEXdDO2ut3YA:10 a=ksTjKdeKf_QrTKGjYr5L:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755082AbeDKTIv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:08:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935306AbeDKTGt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miguel Fadon Perlines <mfadon@teldat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 310/310] vrf: Fix use after free and double free in vrf_finish_output
Date: Wed, 11 Apr 2018 20:37:29 +0200
Message-Id: <20180411183635.987200356@linuxfoundation.org>
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

From: David Ahern <dsahern@gmail.com>

commit 82dd0d2a9a76fc8fa2b18d80b987d455728bf83a upstream.

Miguel reported an skb use after free / double free in vrf_finish_output
when neigh_output returns an error. The vrf driver should return after
the call to neigh_output as it takes over the skb on error path as well.

Patch is a simplified version of Miguel's patch which was written for 4.9,
and updated to top of tree.

Fixes: 8f58336d3f78a ("net: Add ethernet header for pass through VRF device")
Signed-off-by: Miguel Fadon Perlines <mfadon@teldat.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ backport to 4.4 and 4.9 dropped the sock_confirm_neigh and
  changed neigh_output to dst_neigh_output ]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/vrf.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -585,13 +585,15 @@ static int vrf_finish_output(struct net
 	neigh = __ipv4_neigh_lookup_noref(dev, nexthop);
 	if (unlikely(!neigh))
 		neigh = __neigh_create(&arp_tbl, &nexthop, dev, false);
-	if (!IS_ERR(neigh))
+	if (!IS_ERR(neigh)) {
 		ret = dst_neigh_output(dst, neigh, skb);
+		rcu_read_unlock_bh();
+		return ret;
+	}
 
 	rcu_read_unlock_bh();
 err:
-	if (unlikely(ret < 0))
-		vrf_tx_error(skb->dev, skb);
+	vrf_tx_error(skb->dev, skb);
 	return ret;
 }
 
