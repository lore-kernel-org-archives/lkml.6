Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7231FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3065E20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=labo.rs header.i=@labo.rs header.b="l73QHTek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w/Dhv90x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3065E20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=labo.rs
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeKEW03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:26:29 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:49439 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728870AbeKEW02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:26:28 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 0C5EF1687;
        Mon,  5 Nov 2018 08:06:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Nov 2018 08:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labo.rs; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=U
        9nzanSJIND/JqNgyWFIVTnyXOclV1oxoHVOwJ3pC4U=; b=l73QHTek7436sVWQH
        g6y6em4yfU/57xoOujj4/Iaf0RVAt9zPq5NK8VAMff9XO2jCg8rciZVIKuKIuAjm
        5I/hPcP2vvsnJ/ZzwjiVqorwDzFerOYlU4vSVxT9Ft8shMbP27r0CA8jYe7rAiHQ
        SnIJib7CUCZFU5GpwuC4bN+YNfERteTbjkqaz4d3bFwbM8K1bfhIycCaqs8RIo3j
        TpKMlZo3noIk2Xx5sXjJq+RKVSWm0pEXKf1VYpmoe8wjPd4fsx2Y38QsGDSTNuNP
        UnCokCOYemdndUtQCnbATyZew8OxtzRHYbQbs0FmiBi3MhYmIsYVPhskRRbmgaIF
        RVHZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=U9nzanSJIND/JqNgyWFIVTnyXOclV1oxoHVOwJ3pC
        4U=; b=w/Dhv90xxuJk0FtipXh8B5lwBfoEaDg2qDhQfUM7xD4HoxlNUvyBcd98e
        R/1oSDYGyM8RCefo8JvFtu0i9KbI9MFQn7AvJaAJiyrbHNYpYjBzuLO2Kyup2jMH
        XDxMYiKDqaEXiGue0hFqB/C01zbCvFz6CtRJtUe74Uua2UCmQ1+5V+a/zTLo7mpI
        KS91CY3Wv7oNwWJ2diiUnULd+rSai/QIzqDj35+sN9cTpupzmq1Ang4HvgItUreE
        TtaONjZSGWGHViCSW5zxROsDlu6jy9l6gEL/io9Jrd10gCyC4fuvLv0wiwg87lxe
        twGGdAALbT8wHEutpqSd8FHftqFPA==
X-ME-Sender: <xms:ZUDgW4rwmizjZc01OlX1gNsr92JVPaUsSaZfqb0LKj919PGgg1xI6w>
X-ME-Proxy: <xmx:ZUDgW9By6NA5PaBxXtV-nxs1Wd_JrLcoojpxMpRa0Rib6r_ikphhKQ>
    <xmx:ZUDgW5g9N6KP94INfOvvT87El0m0x2fZHrVlTg-lCY8rZwDCCBY3JA>
    <xmx:ZUDgWxcC0fbsOTpFGcORRYZjOp51RFTarAr1SAhzi1TVyLgEjaxnsg>
    <xmx:ZUDgW0hO3C_OPQCMdUa9IMfkCC5u42qHMh2mLNSL9ofjNwNQTf3zWw>
    <xmx:ZUDgW6Q6FmIxFAo5-z8NGTakR_0XnhYnR5lXrfBtQ2W30owlx-PlaA>
    <xmx:ZkDgW1RIq4IOTBQeCHAnVgwhNfTKMQGXB1dwGo0c6ymSHnsbXDlxqA>
Received: from [0.0.0.0] (lada.labath.rs [185.194.239.81])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2A649E490F;
        Mon,  5 Nov 2018 08:06:43 -0500 (EST)
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Taht <dave.taht@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-24-Jason@zx2c4.com>
 <7830522a-968e-0880-beb7-44904466cf14@labo.rs>
 <CAHmME9oQJ9y51Pv7U=+=5uDA_tb+U1zWZdsLcyNMhdcFZmjM8Q@mail.gmail.com>
From:   =?UTF-8?Q?Ivan_Lab=c3=a1th?= <labokml@labo.rs>
Message-ID: <e4b500e9-f24a-43c5-c2df-834dafc3aae5@labo.rs>
Date:   Mon, 5 Nov 2018 14:06:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHmME9oQJ9y51Pv7U=+=5uDA_tb+U1zWZdsLcyNMhdcFZmjM8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 9. 2018 18:04, Jason A. Donenfeld wrote:
> Hi Ivan,
> 
> On Wed, Sep 26, 2018 at 6:00 PM Ivan Labáth <labokml@labo.rs> wrote:
>>
>> On 25.09.2018 16:56, Jason A. Donenfeld wrote:
>>> Extensive documentation and description of the protocol and
>>> considerations, along with formal proofs of the cryptography, are> available at:
>>>
>>>   * https://www.wireguard.com/
>>>   * https://www.wireguard.com/papers/wireguard.pdf
>> []
>>> +enum { HANDSHAKE_DSCP = 0x88 /* AF41, plus 00 ECN */ };
>> []
>>> +     if (skb->protocol == htons(ETH_P_IP)) {
>>> +             len = ntohs(ip_hdr(skb)->tot_len);
>>> +             if (unlikely(len < sizeof(struct iphdr)))
>>> +                     goto dishonest_packet_size;
>>> +             if (INET_ECN_is_ce(PACKET_CB(skb)->ds))
>>> +                     IP_ECN_set_ce(ip_hdr(skb));
>>> +     } else if (skb->protocol == htons(ETH_P_IPV6)) {
>>> +             len = ntohs(ipv6_hdr(skb)->payload_len) +
>>> +                   sizeof(struct ipv6hdr);
>>> +             if (INET_ECN_is_ce(PACKET_CB(skb)->ds))
>>> +                     IP6_ECN_set_ce(skb, ipv6_hdr(skb));
>>> +     } else
>> []
>>> +     skb_queue_walk (&packets, skb) {
>>> +             /* 0 for no outer TOS: no leak. TODO: should we use flowi->tos
>>> +              * as outer? */
>>> +             PACKET_CB(skb)->ds = ip_tunnel_ecn_encap(0, ip_hdr(skb), skb);
>>> +             PACKET_CB(skb)->nonce =
>>> +                             atomic64_inc_return(&key->counter.counter) - 1;
>>> +             if (unlikely(PACKET_CB(skb)->nonce >= REJECT_AFTER_MESSAGES))
>>> +                     goto out_invalid;
>>> +     }
>> Hi,
>>
>> is there documentation and/or rationale for ecn handling?
>> Quick search for ecn and dscp didn't reveal any.
> 
> ECN support was developed with Dave Taht so that it does the right
> thing with CAKE and such. He's CC'd, so that he can fill in details,
> and sure, we can write these up. As well, I can add the rationale for
> the handshake-packet-specific DSCP value to the paper in the next few
> days; thanks for pointing out these documentation oversights.
> 
> Jason
> 

Any news on this?

To be clear, question is not about an insignificant documentation
oversight. It is about copying bits from inner packets to outer packets
of a secure* tunnel and documenting it AFAICT nowhere, while claiming
extensive documentation.

* it really should be specified what secure tunnel means, as it has many
plausible interpretations and wireguard surely does not fulfill all of them.

Ivan
