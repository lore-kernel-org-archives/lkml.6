Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163006-2-16226788867381012392
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
    1527163005; b=YR7PeifjYsAAILytOmEmpGw8m0tsQzbP3tqjPwk17inW6jU6P8
    CikRdD7twxOENZp3zPvuu/2Afwln78EiNrkoxsEc0tqsV/ki/QMmaXgX8sScVAAC
    ZYYl4dhwe+xvqu6tJHilzVeXu3j8pJMlKSdBTMFhLpYW9d5BAhGhHOMhqJ4oreUm
    5okGUcqMjH/eYa1YiHKbrTPsdLbkS3HN9ibRWMz7RKz7cXr8HFigReZh36sR+53D
    lKZKEW+XduGzwkhzA43YrP6KtPvKvSyvNXMriNpHCbwKtUskSu4h2k33mckdWVzL
    3/EXPAu4++UpHkcAYPENZQATZnCUGjFyISWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163005; bh=JLU9O5UeOsa+0ncVhx+j7sWgOxNAxE
    MqOS8c8kxPUjo=; b=iMsgDXryi/H3aCSHuRkz7COkRbzYpvByRpfJEg/KGSZIEo
    JeqaI7XINGb4BzQV8RTJxpfEtkCQOAuQxfJvc+iXLWZigV3jfcAol/6T8hYzAG24
    qXWkS8JheL34hWfVOg9y+YtKxyxPmgMTEfU8g32jIJNF5iBAorFvY0bJ90h7fFJU
    4R/Y5GY2htd23VQsLgCfV7OvJYWKyms/Xlwb7uyUADuRW8pwR9wjyqNfdUz/SDXp
    6/zA4AUq/mWmL91xc2gBgIA8245ObgBuoVXbZTkT2S+ZjxH2ijNiGDaWV404AoHE
    F37+wt/I7FhQEcnYerNOStiatj5luMkNirXx7GdA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=MHCq8+ry x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=MHCq8+ry x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPAKxecnG132CfgMokg6WIAFcOyHVHAzNbhpcBV5wJZYSdpZ/vanHnV7qter1KfWtiJsgxl9fFL4EQ+Eshdyp5zhuEdFZ7Ft+CiaLifPoH8Vq5clJm9S
    xdrN8EmEZ1vGt4y8nNm8HnBLAp5DKgyRKswOe0d1V4Knb4Ctp3svSx2YJZrbgZ6bF9JJx1u/8jgLWvzbpl4k3AHJkmcaPfx+h9BKOhj4+TjfI7Sc5uAwJ2Pd
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=G8Vht56IOoz3jrsCRGQA:9 a=7CZQgDGIAkha4vUH:21 a=ise_7HGtSiYG6tJr:21
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966438AbeEXL4R (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966843AbeEXJpv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 72/92] packet: in packet_snd start writing at link layer allocation
Date: Thu, 24 May 2018 11:38:49 +0200
Message-Id: <20180524093206.227673739@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2771,13 +2771,15 @@ static int packet_snd(struct socket *soc
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
