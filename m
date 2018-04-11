Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477230-2-11897741496455371526
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
    1523477229; b=leQvEQDqFpmCDoTu1rc28+UbEqWnFQeAqaKShLnMhNBdqzjn8I
    rKl48Mmwmd7QppwuKIL45b+pTMfA0uU3TijsmYVD6BLpaQVf3k7TNJuM7tqjSddX
    hHriD0BEgVwoekRRcltTF/LkMy3owsGvD1qDSbjMQyDtMJK7+yCawGl4tTZLNh3V
    HP2hEtLR/3h6Y1rFzku85l9J18ku0QA471gz7FwQT0X+DxK2WShxHoZ+ba3PgyTt
    EFFQLB6wM1bJVNcCeSP3/DtwIuOWj17iJGZ72gjy7SYGuo9hyXiubV5pSkouXW7R
    2lReA+LMCqQJlFjbPAnJf+5cAy+BvGNQRIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477229; bh=X/7qY3zw7RwduTFWb/+8/YoPRIcaxF
    98IWBtBYfKj8E=; b=vhUMTgw7aZ+M6rBKu7qT0seOZc3RsO/O5WQdptU/Htwlqt
    9t7b8neLPaN2P3pqfW9GyRNtcv54AwvJUb/mYV8aTTUTuCBNCnVPYAppu3RlX4EB
    v7ZImmrZa+yMBDKsIkApDoaafFX4/hBXMkrMPfE+wWl1u+ovU7y7C9+MPV6Q1rnM
    Yp3ysIfnurTDpNT2MVF7F/GvVY60hhi8PNkUSdcywGlw35jeKKcV1/d/NCYMGTT1
    0tCjz2zBxi+N0xjOAqnm8wKCGbQ2LpKqKVVKicn8Tt64UY+KuWF3awPWb6NjNgYd
    ALj3ZiQ2jOb3juK94pJdNIqnz9reOyBJIZ4MAP9A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfE3pSzfq2fTwxiDo9Xoc44dmlaJzTCubosHTvQePm8D0/U+HRm7J5UvXz5VMiaKUvKPqId+azysA/xImvqKGLKYM9iScRaIuURA9RDxe37hHhSFm3le/
    sx4TJtVOlaNqoaLvMbqEtOltkjL3zUWSZ5nFdDSlJz0mGpwxUUUsTqTCw6Zr/IKkfAtpMUzY7CjUqShQRqLUvz4Vzfzm7zq04r2hk8JLnJMmltKOR1VS+AP8
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CDq0vqnqAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=UMikwde4_RvlFcDU50QA:9 a=QEXdDO2ut3YA:10
    a=Xn7iXEen_xUG9zZOO_Hb:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbeDKSzP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:55:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932916AbeDKSzN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:55:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>,
        David Ahern <dsa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        roopa <roopa@cumulusnetworks.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 060/310] ipmr: vrf: Find VIFs using the actual device
Date: Wed, 11 Apr 2018 20:33:19 +0200
Message-Id: <20180411183624.814783726@linuxfoundation.org>
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

From: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>


[ Upstream commit bcfc7d33110b0f33069d74138eeb7ca9acbb3c85 ]

The skb->dev that is passed into ip_mr_input is
the loX device for VRFs. When we lookup a vif
for this dev, none is found as we do not create
vifs for loopbacks. Instead lookup a vif for the
actual device that the packet was received on,
eg the vlan.

Signed-off-by: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>
cc: David Ahern <dsa@cumulusnetworks.com>
cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
cc: roopa <roopa@cumulusnetworks.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ipmr.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1929,6 +1929,20 @@ int ip_mr_input(struct sk_buff *skb)
 	struct net *net = dev_net(skb->dev);
 	int local = skb_rtable(skb)->rt_flags & RTCF_LOCAL;
 	struct mr_table *mrt;
+	struct net_device *dev;
+
+	/* skb->dev passed in is the loX master dev for vrfs.
+	 * As there are no vifs associated with loopback devices,
+	 * get the proper interface that does have a vif associated with it.
+	 */
+	dev = skb->dev;
+	if (netif_is_l3_master(skb->dev)) {
+		dev = dev_get_by_index_rcu(net, IPCB(skb)->iif);
+		if (!dev) {
+			kfree_skb(skb);
+			return -ENODEV;
+		}
+	}
 
 	/* Packet is looped back after forward, it should not be
 	 * forwarded second time, but still can be delivered locally.
@@ -1966,7 +1980,7 @@ int ip_mr_input(struct sk_buff *skb)
 	/* already under rcu_read_lock() */
 	cache = ipmr_cache_find(mrt, ip_hdr(skb)->saddr, ip_hdr(skb)->daddr);
 	if (!cache) {
-		int vif = ipmr_find_vif(mrt, skb->dev);
+		int vif = ipmr_find_vif(mrt, dev);
 
 		if (vif >= 0)
 			cache = ipmr_cache_find_any(mrt, ip_hdr(skb)->daddr,
@@ -1986,7 +2000,7 @@ int ip_mr_input(struct sk_buff *skb)
 		}
 
 		read_lock(&mrt_lock);
-		vif = ipmr_find_vif(mrt, skb->dev);
+		vif = ipmr_find_vif(mrt, dev);
 		if (vif >= 0) {
 			int err2 = ipmr_cache_unresolved(mrt, vif, skb);
 			read_unlock(&mrt_lock);
