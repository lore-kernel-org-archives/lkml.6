Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85986C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBC22086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoCVzr4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBC22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbeK2BqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:46:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46740 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbeK2BqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:46:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so10246566pfe.13;
        Wed, 28 Nov 2018 06:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6wha/INn/D3e0RtDI+LaouWVcZ5GFbBIB9T6TPapMQ0=;
        b=EoCVzr4ZCIvBMCI6DXgZufZrdKQDtuF3PUYM06apAzPmV7kONa7HVQdjQtNXadw2lE
         715rP1lugcLaX4GaSRrx6G+Y5+rAGRVDTmKCDQ4HQeWH5syfAksOkV9CURWelr1lKDSv
         f3z9Kck/hnrTTH38jc6eMvD7/NzqpMxYALjCX1Ja+DM7P7khMOEkYcG1lMtYcJMUAPSs
         52nhs8jlXMlIwugMNBGq7GZhX9GK39WbbFg/T5LikM6znFDcOcfjIBckSMu+POqUsiYD
         0xAZQI4QfADm+E5hU3v7BZuv9GNmX1+tEu85tRJSe9QxHcsdTnsSG4vX3sDfXCfUASxD
         SpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6wha/INn/D3e0RtDI+LaouWVcZ5GFbBIB9T6TPapMQ0=;
        b=Mhv8jzbjQZMe8Uxt/zl4XdMfj4+Xf/Ek9oj52Orf5RdzJWtDxWJ0TP8PR7JcALuykK
         SEsFvoWYTGbU/wFsuRjKRoNW5kCDycCffMl2BbZzibptheF/P8305+viK9U2gH42gwe+
         VnUt/Sj2TQX+S2XCePPhyPSHeObZhcLP2RWtxt2xdNCoPR+uNWsTJaBQ7RS0UGeWOXOo
         gRBd9sN88t1u5HC5i3CkI0mrYXzMrelGoyQrRqZeD3Lw8mzluFEZLKPUT92B1HmX+/8o
         ZHCqqHSH0RzVLyFB9iwsINhQMHm//jTI6a4q4xJ3hLbN6JdpCQ5rcQO5l2Ju1epwoGmU
         EB8Q==
X-Gm-Message-State: AGRZ1gI49S8o7F5A0PjrrR4q3txtlRh1IkJjwvaSkdJRpRTGh9itOq8G
        TcuQbQPC3QMeu/2l54TBkb+VEYqj
X-Google-Smtp-Source: AFSGD/USr9FcIrkhRW0LHIs9Yn0UYSsT/1wn2tLB32oK5CIVDDYArZDPqI1N1W2VVZtFK5TbBiVkdw==
X-Received: by 2002:a63:2d46:: with SMTP id t67mr34138188pgt.140.1543416270825;
        Wed, 28 Nov 2018 06:44:30 -0800 (PST)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id u70sm14275722pfa.176.2018.11.28.06.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 06:44:30 -0800 (PST)
Subject: Re: [PATCH net-next] tcp: introduce skb_rbtree_walk_safe() and use it
 in tcp_clean_rtx_queue()
To:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543407379-3144-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <60467855-ea5f-3351-8b88-ffdfa60501e0@gmail.com>
Date:   Wed, 28 Nov 2018 06:44:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543407379-3144-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2018 04:16 AM, Yafang Shao wrote:
> When walk RB tree, we'd better use skb_rbtree_walk* helpers, that can make
> the code more clear.
> As skb_rbtree_walk() can't be used in tcp_clean_rtx_queue(), so the new
> helper skb_rbtree_walk_safe() is introduced.

This makes things slower. Let me explain inline.

> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/skbuff.h | 5 +++++
>  net/ipv4/tcp_input.c   | 5 ++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 73902ac..37ff792 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3256,6 +3256,11 @@ static inline int __skb_grow_rcsum(struct sk_buff *skb, unsigned int len)
>  		for (skb = skb_rb_first(root); skb != NULL;			\
>  		     skb = skb_rb_next(skb))
>  
> +#define skb_rbtree_walk_safe(skb, root, tmp)					\
> +		for (skb = skb_rb_first(root);					\
> +		     tmp = skb ? skb_rb_next(skb) : NULL, skb != NULL;		\
> +		     skb = tmp)
> +
>  #define skb_rbtree_walk_from(skb)						\
>  		for (; skb != NULL;						\
>  		     skb = skb_rb_next(skb))
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index f323978..ab6add2 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3043,7 +3043,7 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
>  	struct tcp_sock *tp = tcp_sk(sk);
>  	u32 prior_sacked = tp->sacked_out;
>  	u32 reord = tp->snd_nxt; /* lowest acked un-retx un-sacked seq */
> -	struct sk_buff *skb, *next;
> +	struct sk_buff *skb, *tmp;
>  	bool fully_acked = true;
>  	long sack_rtt_us = -1L;
>  	long seq_rtt_us = -1L;
> @@ -3055,7 +3055,7 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
>  
>  	first_ackt = 0;
>  
> -	for (skb = skb_rb_first(&sk->tcp_rtx_queue); skb; skb = next) {
> +	skb_rbtree_walk_safe(skb, &sk->tcp_rtx_queue, tmp) {
>  		struct tcp_skb_cb *scb = TCP_SKB_CB(skb);
>  		const u32 start_seq = scb->seq;
>  		u8 sacked = scb->sacked;
> @@ -3126,7 +3126,6 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
>  		if (!fully_acked)
>  			break;
>  
> -		next = skb_rb_next(skb);

We call skb_rb_next() here only, not at the beginning of the loop.

Why ? 

Because we can break of the loop if the current skb is not fully acked.

So your patch would add unnecessary overhead, since the extra sk_rb_next()
could add more extra cache line misses.


