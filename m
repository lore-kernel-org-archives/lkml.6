Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC9FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E589A214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=labo.rs header.i=@labo.rs header.b="VbhQcJKA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xw1UVnSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E589A214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=labo.rs
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeIZWOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:14:12 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43305 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727280AbeIZWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:14:11 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 4234821CDD;
        Wed, 26 Sep 2018 12:00:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 26 Sep 2018 12:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labo.rs; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=uLc7wKq5Yp3OVG0DPz0gyBleHJHCE
        rSatM5smeAN00Q=; b=VbhQcJKAHC2tl25Y9rWqipyEJ33vO1g9O4Pfv2HevxFoj
        rvGGCeeLx4efe2eRTfkygaIQIjkk2cB+QnjIv7UkzwVX9EM5tyjt5XGFKFoOmhrH
        yRe/Rr684XsfNcwh0lHs423IUBp8fs4g8BAIz9qeNP/Crp9vSukz+PFDMJ+ooF9J
        O8Xtmhy7IF41mhDBpvwlqKPGvji0SSXAW2iD829M1+CeA0dbKm/fznCN/zdFBuul
        qbWcAqrbaevvcnPqLkiTZocp7Qg6TXgqwckaTQt93YoJdINzspZfKOTw3kndnxrg
        Ln3z7Xfu7hkPlXja0oUzSeXe5Z6IKg99LcNz99LZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uLc7wK
        q5Yp3OVG0DPz0gyBleHJHCErSatM5smeAN00Q=; b=Xw1UVnSctD2X83rDWCos8E
        e7WMp9gaV82ccAggk6gVfQvp352zUOrLCXzoKioNvoPh5pPNhfU4eNaahfT5v/5q
        LfZijb9Ep01e3cYvma00BJonwsvaV1WNB/b1zX0Ys0vGK9eNtu97XCPNM/nYFLwq
        9TFUwe7JWOo3e93RVJzA82p7b/Qg4Yk2bC04VolOdRPjdVyY1pQaGtXNykCNNleW
        ApRswVhKLU4m/DamfotFLbmKJ5Yo3SJTDQgIVOfpXbD9cC/aZP6+aQ+KQDMc3Ug5
        9jjIBhyqebmo3hCNNL/45Kbgov3/w9VIZHb32uj9NNd285kkbwpcIQmnzFvGFABQ
        ==
X-ME-Proxy: <xmx:Iq2rWxbhxY86DjJ-KDC8U_0kOYeCh-pstTI8FIViByVoLEA83l6L_g>
    <xmx:Iq2rW4mQC8ikIsiqZH0zLdeMqIOVY314Z1BJYu09ZLQJhr_Gesr4-w>
    <xmx:Iq2rW1zp7cRNveF85kBm7sti9URWSI-qjAeAVXQIdbHCpoP0KaGC4A>
    <xmx:Iq2rW-OBi2vhIy21aTtMtPuFFLOSgvhqnl2rc64kzu7mmDb-YdOXSw>
    <xmx:Iq2rWxQr9FUVbnmxHgubc2WuFPJcBHDrToyQla3NfwY82a26-fbOdw>
    <xmx:I62rW6ggKbRJWxkElzAwcMELfqOe5gRGOGTz6wiO76L0TJDs6gKWdA>
X-ME-Sender: <xms:Iq2rWyFKtg_pRqPrhPSCeIiV0YPxnNM8OtdKm1-DLanCpUeBK83ezw>
Received: from [0.0.0.0] (lada.labath.rs [185.194.239.81])
        by mail.messagingengine.com (Postfix) with ESMTPA id 44D29E461E;
        Wed, 26 Sep 2018 12:00:33 -0400 (EDT)
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-24-Jason@zx2c4.com>
From:   =?UTF-8?Q?Ivan_Lab=c3=a1th?= <labokml@labo.rs>
Message-ID: <7830522a-968e-0880-beb7-44904466cf14@labo.rs>
Date:   Wed, 26 Sep 2018 18:00:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925145622.29959-24-Jason@zx2c4.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.2018 16:56, Jason A. Donenfeld wrote:
> Extensive documentation and description of the protocol and
> considerations, along with formal proofs of the cryptography, are> available at:
> 
>   * https://www.wireguard.com/
>   * https://www.wireguard.com/papers/wireguard.pdf
[]
> +enum { HANDSHAKE_DSCP = 0x88 /* AF41, plus 00 ECN */ };
[]
> +	if (skb->protocol == htons(ETH_P_IP)) {
> +		len = ntohs(ip_hdr(skb)->tot_len);
> +		if (unlikely(len < sizeof(struct iphdr)))
> +			goto dishonest_packet_size;
> +		if (INET_ECN_is_ce(PACKET_CB(skb)->ds))
> +			IP_ECN_set_ce(ip_hdr(skb));
> +	} else if (skb->protocol == htons(ETH_P_IPV6)) {
> +		len = ntohs(ipv6_hdr(skb)->payload_len) +
> +		      sizeof(struct ipv6hdr);
> +		if (INET_ECN_is_ce(PACKET_CB(skb)->ds))
> +			IP6_ECN_set_ce(skb, ipv6_hdr(skb));
> +	} else
[]
> +	skb_queue_walk (&packets, skb) {
> +		/* 0 for no outer TOS: no leak. TODO: should we use flowi->tos
> +		 * as outer? */
> +		PACKET_CB(skb)->ds = ip_tunnel_ecn_encap(0, ip_hdr(skb), skb);
> +		PACKET_CB(skb)->nonce =
> +				atomic64_inc_return(&key->counter.counter) - 1;
> +		if (unlikely(PACKET_CB(skb)->nonce >= REJECT_AFTER_MESSAGES))
> +			goto out_invalid;
> +	}
Hi,

is there documentation and/or rationale for ecn handling?
Quick search for ecn and dscp didn't reveal any.

Regards,
Ivan
