Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D0C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CC12081F
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fROur40x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CC12081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeKDJxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 04:53:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45140 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeKDJxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 04:53:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id p17-v6so2322862pfj.12;
        Sat, 03 Nov 2018 17:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5wzR6fJgE1m2Lw4LkHFP27xBQ7EYJ6Vj89edQ5HTBs4=;
        b=fROur40xL9WcHj7Vf0fjQeGSbXSmkvNamwCqGea8NDm3QoZ9FMwO0az1Wp1rACqJC0
         zNKAW1GQQuYQgTJu2xGNoqhNivbNDW42hZKxUV7MaNcTKfk6lHBYYOkhcfC+pi6JSpik
         WNe1ZinkNjFNJcct3fBuoZaTlzlI02oba0A5il1kHOtPFZ+nho0oF2dNF+2E3Y20WvrZ
         +ZUUUyiItbhVlWa775/TgV48E7ZYAGA+x7Iwi5SAdsfDL1UmK86Sx6vYhxfc+2jxNvXF
         FNhzF5P0mBHnNVk1LvT3kxnAtqw3bdFcTZ07KQa0mIr8NlEvLhiq2bt2c8d9I8FRGZkM
         ttCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5wzR6fJgE1m2Lw4LkHFP27xBQ7EYJ6Vj89edQ5HTBs4=;
        b=jl2lCQplnrzDkpf5jE+GR0UBrWb5fra4QSWmswPkRKVrEj/ezli7Ujf44ZInZAZUJS
         wow+cd4Dyz3IELQVzb+XKXCwmvFgTElvj3uFVNDHHDgt4CguUNp5NvmrewEntgQIKjwa
         V14q0HZ+hX1HOnHrjYRLk9ZcwwrLV8aWqciuMYV05UDNHsbhXtbiHW3fJcrNsc2F2O+y
         L/Oy7AfcY4GsqxOR1xeKPmfs/LLQXb/faEia4Q8TZnXYkf4XI24ncikhVLbi8iIXu3mW
         6CGmFKaDcfHR2Xpeiis4ahMM0GJVvwcU+7+T/B66hhi2S20Ic81ly8MIaUNC8R6ApJqh
         pnHw==
X-Gm-Message-State: AGRZ1gLsmLq5YGBcKDeGZwQcmKC9UAwcLJ2nOWBH0XywVhsop7HuZGfV
        0NKGTdC0mbiOz1o/JHmOaX4M9wVV
X-Google-Smtp-Source: AJdET5corXERC42A91E9mD/P+UgHWIe8zwmROY4/bvrV7QcAjIkZcEZb6mwZAuYQxO6QSDjsVYZfuA==
X-Received: by 2002:a62:6981:: with SMTP id e123-v6mr1881546pfc.104.1541292041226;
        Sat, 03 Nov 2018 17:40:41 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id q11-v6sm15809789pgp.62.2018.11.03.17.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 17:40:40 -0700 (PDT)
Subject: Re: [PATCH] tcp: do not update snd_una if it is same with ack_seq
To:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1541264071-9905-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <5f585304-b6f5-5f49-adcf-eaed471c0d76@gmail.com>
Date:   Sat, 3 Nov 2018 17:40:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541264071-9905-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/03/2018 09:54 AM, Yafang Shao wrote:
> In the slow path, TCP_SKB_SB(skb)->ack_seq may be same with tp->snd_una,
> and under this condition we don't need to update the snd_una.
> 
> Furthermore, tcp_ack_update_window() is only called in slow path,
> so introducing this check won't affect the fast path processing.
> 
> By the way, '&' is a little faster than '-', so I replaced after() with
> "flag & FLAG_SND_UNA_ADVANCED".
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 2868ef2..db5a6b7 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3376,7 +3376,8 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
>  		}
>  	}
>  
> -	tcp_snd_una_update(tp, ack);
> +	if (after(ack, tp->snd_una))
> +		tcp_snd_una_update(tp, ack);
>  

Adding this after() here is confusing, how ack could be before snd_una ?
That would be a serious bug.

I do not see why another conditional has any gain here.

You are trying to avoid very cheap operations :

    u32 delta = ack - tp->snd_una;

    tp->bytes_acked += delta;
    tp->snd_una = ack;

Maybe the real reason for this patch is not explained in the changelog ?
