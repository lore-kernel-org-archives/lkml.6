Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A697BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C2F2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9Vld+zN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C2F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbeK2E2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:28:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45844 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbeK2E2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:28:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so9784004pgc.12;
        Wed, 28 Nov 2018 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bgIml5f3ssev+4yweQ+lo6vP+5lG/77Tw2uvYeHiCFI=;
        b=S9Vld+zN7qSDeVeDoJQaq272IvofARmTmt5/tDljJjvUkYrFI3ZQGkQwBEjaQzbYdI
         eAqfl7GJNkI4WUv6/0TMyA7emIIwt9o7esElADyRCNuOGurfqbfyB6FZhcSLo6Xip4JW
         C5cZi/Ow4DjOTOhltaabgUvKkayj30PZOukg6oFAhKttr7riKQqq2fUOzc7FAvyIfB6H
         zk1WwsQvfLIx3QbJL66H72zCEbpxoUMaE9ZuWVj0leS7O1SCiaFbJmD4rUvkmwDlpcQL
         E1iTlEEnheHCnTrZYS4wTx8/1eg2mAgy6XlS83amuXBqpM4sJQ3UFYR6dZIesVuDveih
         mNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bgIml5f3ssev+4yweQ+lo6vP+5lG/77Tw2uvYeHiCFI=;
        b=Q/erZZUKVmZoyZGvCoNRdOGWd+d+7Rn5XMu6MuRzN05yWAHba/mh+rbEW2TkdU6m6x
         IbLcadYgegV0tJOWy7yKxUI9+yW7oMzYRhBd5Zn6RJX1omFlCEfb81NKAJKD5tJIwwO8
         TprCIFmujtQD3RN79neYdoLB8L3pK7dpiv0UgAiRx/7272qBctirwCUx0PDW5097e4bf
         LGlSpiauuT50vSA5GEVEYpFgKJrp+rgFpwBt56sSV07Q9tw0IsoCKANdiaoxhazidyqY
         yDps2SGd40TVWHO6bhG0eh6p0MBWw13gfrUYh+0XuBMHgGfAc4r1Zvcudz4/LGerZ7Iz
         su+Q==
X-Gm-Message-State: AA+aEWaJOOJcrkC5YwxH+qYvD5Ur+YQIoUojykckCLLhIEJTpBQWUvdj
        tiq0aSES6KFqAJkG7nOv8xlhAX8Q
X-Google-Smtp-Source: AFSGD/WMY4ItQYwDPGNGhtauJL8BZMw0+YqlEV7nxJelbn/2bGeHT/3/3YlrK5u7oEA44iNqz5WDYw==
X-Received: by 2002:a63:ca0a:: with SMTP id n10mr34128980pgi.258.1543425988213;
        Wed, 28 Nov 2018 09:26:28 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id d6sm8758406pgc.89.2018.11.28.09.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 09:26:27 -0800 (PST)
Subject: Re: [PATCH net-next] tcp: introduce skb_rbtree_walk_safe() and use it
 in tcp_clean_rtx_queue()
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543407379-3144-1-git-send-email-laoar.shao@gmail.com>
 <60467855-ea5f-3351-8b88-ffdfa60501e0@gmail.com>
 <408125e7-bbb0-dcfb-ee19-58089802cac7@gmail.com>
Message-ID: <b8b7bbd2-8f7c-2aef-e9d0-343f8c4c2b2d@gmail.com>
Date:   Wed, 28 Nov 2018 09:26:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <408125e7-bbb0-dcfb-ee19-58089802cac7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2018 08:53 AM, Eric Dumazet wrote:
> 
> 
> On 11/28/2018 06:44 AM, Eric Dumazet wrote:
>>
> 
>> Because we can break of the loop if the current skb is not fully acked.
>>
>> So your patch would add unnecessary overhead, since the extra sk_rb_next()
>> could add more extra cache line misses.
> 
> I am testing the following optimization, since we can avoid the rb_next() call
> when we reached snd_una
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index f32397890b6dcbc34976954c4be142108efa04d8..6829e470f0c186a73c34dca414cd4a2b379baded 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3126,7 +3126,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
>                 if (!fully_acked)
>                         break;
>  
> -               next = skb_rb_next(skb);
> +               next = (scb->end_seq == tp->snd_una) ? NULL : skb_rb_next(skb);
> +
>                 if (unlikely(skb == tp->retransmit_skb_hint))
>                         tp->retransmit_skb_hint = NULL;
>                 if (unlikely(skb == tp->lost_skb_hint))
> 

This does not work since we use next skb after the loop :

1)   if (!skb)
          tcp_chrono_stop(sk, TCP_CHRONO_BUSY);

  This test could use tcp_rtx_queue_empty()

2) SACK reneging
    if (skb && (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED))
            flag |= FLAG_SACK_RENEGING;

3) FLAG_SET_XMIT_TIMER
     } else if (skb && rtt_update && sack_rtt_us >= 0 && 
                sack_rtt_us > tcp_stamp_us_delta(tp->tcp_mstamp,
                                                 tcp_skb_timestamp_us(skb))) {
                flag |= FLAG_SET_XMIT_TIMER;  /* set TLP or RTO timer */
 
So this idea is not feasible.
