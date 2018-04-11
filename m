Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473384-2-15692774154776263026
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
    1523473383; b=FRmFMshDKM/PlYA/fjK1lgaS93xCbWBaiO8s/FPJSmYCUkhIZw
    y/E8AhG2AtRFMouWuBaVO6U4Cl36aYRr3uLuCWqb0yjlv7vZDGo5Uq9lujMCKbsm
    Lw+72wzEGRc7Th7rYM0bt/hVrKlSGy7DN0b7Jz7PfAB/AehVh63C+gvwDY8NMqjL
    8Wcp67fQE31oFlEYuDhpW9/LAgNFmXBgZaNArznan4DapIqxwpM2vJ6GHhdefAxa
    z4mv+CrAulndvHQoyBk5fzJ/H6/057xOEASMuTou+yC+iv3WBhP/C4Xw8WcrAqVj
    WguBnLCPXkzu3gCHaY6/vh/hsYxXMQl9gJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473383; bh=DAWqp3fDMCnMg+on72LTp2RvJDZo9q
    VAFcShUBmDs8s=; b=iU+mu1kk0I1xTGkTlI/zeIigquWqgdc5RkQwMtqkM5RzbN
    Q/leWrlaNirE6QS3cq1aZBEnFb6JNQxEwdFHhPNOj0NBGXi6zGl/Tu7cC0AHWBQa
    GyHPGZkzVAhhyHzvpLvQHrhE2p86qN8vERVXsWdjgUL0FKOvOyiiO3rp30agzTMJ
    rfXEG8n8b/tGuNsfoqFTjmmnEI1h8fMJlk3+jXdmvbCFyF17HK4qzcrhzosBibxT
    qAgyUmeBTUiLk0dZtJekXDZyCOCVs5HvnuUw8IaT6nOW3diRGetndKDx+EoHTKVw
    vkFa+dg0IDclRFj67mpvi/cJwewlGNxRxALs2P/w==
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
X-CM-Envelope: MS4wfMl5ibpKmToD3IZG2Lj/yZy4XhmUQ/YzrRZd6dYU1g02gaZ0j5D/Xb21bxoBSvmnfufhZVF5sXm9JGM0+4cTPLZct7/OWjCAJ4WXbrumC5m64hAhRqPj
    dRdTHLEqa6hw+e7baTH9B/OYzPhCrpQMDK7LYZTNmmld8O01jul6oT4Kdiyev9AwiTNT/qU3BW6QyKd1QcvjfZQo9OyuXPjD5urp4cJZvCWfsbR5kjUyryy7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=anrhI8clf2O8uQyciCwA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933773AbeDKTC6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:02:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933692AbeDKTC4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:02:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 226/310] skbuff: only inherit relevant tx_flags
Date: Wed, 11 Apr 2018 20:36:05 +0200
Message-Id: <20180411183632.243368942@linuxfoundation.org>
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

From: Willem de Bruijn <willemb@google.com>


[ Upstream commit fff88030b3ff930ca7a3d74acfee0472f33887ea ]

When inheriting tx_flags from one skbuff to another, always apply a
mask to avoid overwriting unrelated other bits in the field.

The two SKBTX_SHARED_FRAG cases clears all other bits. In practice,
tx_flags are zero at this point now. But this is fragile. Timestamp
flags are set, for instance, if in tcp_gso_segment, after this clear
in skb_segment.

The SKBTX_ANY_TSTAMP mask in __skb_tstamp_tx ensures that new
skbs do not accidentally inherit flags such as SKBTX_SHARED_FRAG.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2615,7 +2615,8 @@ void skb_split(struct sk_buff *skb, stru
 {
 	int pos = skb_headlen(skb);
 
-	skb_shinfo(skb1)->tx_flags = skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FRAG;
+	skb_shinfo(skb1)->tx_flags |= skb_shinfo(skb)->tx_flags &
+				      SKBTX_SHARED_FRAG;
 	if (len < pos)	/* Split line is inside header. */
 		skb_split_inside_header(skb, skb1, len, pos);
 	else		/* Second chunk has no header, nothing to copy. */
@@ -3228,8 +3229,8 @@ normal:
 		skb_copy_from_linear_data_offset(head_skb, offset,
 						 skb_put(nskb, hsize), hsize);
 
-		skb_shinfo(nskb)->tx_flags = skb_shinfo(head_skb)->tx_flags &
-			SKBTX_SHARED_FRAG;
+		skb_shinfo(nskb)->tx_flags |= skb_shinfo(head_skb)->tx_flags &
+					      SKBTX_SHARED_FRAG;
 
 		while (pos < offset + len) {
 			if (i >= nfrags) {
@@ -3881,7 +3882,8 @@ void __skb_tstamp_tx(struct sk_buff *ori
 		return;
 
 	if (tsonly) {
-		skb_shinfo(skb)->tx_flags = skb_shinfo(orig_skb)->tx_flags;
+		skb_shinfo(skb)->tx_flags |= skb_shinfo(orig_skb)->tx_flags &
+					     SKBTX_ANY_TSTAMP;
 		skb_shinfo(skb)->tskey = skb_shinfo(orig_skb)->tskey;
 	}
 
