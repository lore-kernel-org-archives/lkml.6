Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162381-2-11591795517110181126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162380; b=YmSL3Oi7x/xEuiP95aRkGX/9okHw91OnNzyDA100wNaSOtHVx+
    YtXcIRDJDXVk60PjxvxRJAM8KLOLWibaaR14qCk3KPJkee8PUVbMD0yG3I495so9
    lbmwzsivvAyZsJKAz6ZxfjXbk0Cnhf0s1DDC2is90yewrHOONF5fgMfeWsHFvW/i
    lX5KaytgGjv4k4E33cZxgXZQjwFAOTlI/CgtTOcAtfaDRv7RRJ861NQteP6nE3TU
    a2jCSzqiVg1TgVHt6fp+4YlGCmdFxtKO7ZjaVaTlujwRiiX0ss2W3JZWStXqipa2
    5NCrn9E9yo+C8cX/c5tco3PEu34vFkFCOmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162380; bh=hrGxuQnlmOPUiZN3oM5vVjN7LT1BFy
    BqiGHtmidAWTA=; b=RW6kWcnV4vX8rFqozDHeD+K/Gzl9ZCNxqMSC0Nqrv58VPk
    tgWQ3MA8fnstJ51oWOycGzc4KPdTpTXlzkXat3rrKglBNk67xel5AUxy/otmE62k
    ei5Rsn9xMEu1Wrg6FC6oAhFhc5oW7rhYdTHlqSWo1URT9RMt38mnXgDkjvECPbEC
    Ung7jORQ5uv3VM9kTpwYre3ezLeuedgq4jS22Px7zPDAe/oH6g4BKH8fHZEdao6J
    +pY/KSkjw6B0qm9rWeCSRWHtYJZmna6l8mT0ufIclN0lRlGQtVqnIOJBv6HYx80A
    rYH5oWKXy/ReCLPsH6SLtA/veKwY6CdiTykCBOkQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=QUPlclp7 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=QUPlclp7 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIdHQvY9avlIxbt4p+pgR/myR9uLyVNLHQEwrwb3hxaA3C9QWrpryIOB1QBVVx/zeVTXNNHzMyePB9WTDB3GyBW8q8+gs86gI8Jo5JfXBynBvMktdtw3
    +ISiwyCx7BN1VkaAtFG3v7l4dfpabMS4RG4Bezgn4kwDHTq/zsn3aS0kR9r8uFVrf9aJLGlMzFQxse0m2DxlzdBvR3pb9Fq5uteKaZNliAux4F7bXmjK2ziR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=G8Vht56IOoz3jrsCRGQA:9 a=9MzY4qaIEuA2mC1_:21 a=ise_7HGtSiYG6tJr:21
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967115AbeEXJrt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967106AbeEXJrr (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 03/96] packet: in packet_snd start writing at link layer allocation
Date: Thu, 24 May 2018 11:37:46 +0200
Message-Id: <20180524093605.846607760@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
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

[ Upstream commit b84bbaf7a6c8cca24f8acf25a2c8e46913a947ba ]

Packet sockets allow construction of packets shorter than
dev->hard_header_len to accommodate protocols with variable length
link layer headers. These packets are padded to dev->hard_header_len,
because some device drivers interpret that as a minimum packet size.

packet_snd reserves dev->hard_header_len bytes on allocation.
SOCK_DGRAM sockets call skb_push in dev_hard_header() to ensure that
link layer headers are stored in the reserved range. SOCK_RAW sockets
do the same in tpacket_snd, but not in packet_snd.

Syzbot was able to send a zero byte packet to a device with massive
116B link layer header, causing padding to cross over into skb_shinfo.
Fix this by writing from the start of the llheader reserved range also
in the case of packet_snd/SOCK_RAW.

Update skb_set_network_header to the new offset. This also corrects
it for SOCK_DGRAM, where it incorrectly double counted reserve due to
the skb_push in dev_hard_header.

Fixes: 9ed988cd5915 ("packet: validate variable length ll headers")
Reported-by: syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2910,13 +2910,15 @@ static int packet_snd(struct socket *soc
 	if (skb == NULL)
 		goto out_unlock;
 
-	skb_set_network_header(skb, reserve);
+	skb_reset_network_header(skb);
 
 	err = -EINVAL;
 	if (sock->type == SOCK_DGRAM) {
 		offset = dev_hard_header(skb, dev, ntohs(proto), addr, NULL, len);
 		if (unlikely(offset < 0))
 			goto out_free;
+	} else if (reserve) {
+		skb_push(skb, reserve);
 	}
 
 	/* Returns -EFAULT on error */
