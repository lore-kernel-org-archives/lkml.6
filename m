Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B802081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENYXm2rW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B802081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeKHArI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:47:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37205 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeKHArI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:47:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so7445877pgq.4;
        Wed, 07 Nov 2018 07:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s3uQNLZ0xnXl8aHoNxOz/s0JQbfR9Ehd2ASnbJ1VF0Q=;
        b=ENYXm2rWOWTSdV3CIfo1EuhzzEREub2s7M+wYx9HXMihpf1Phut1+p8muL6w3p0jKo
         8gMQGJsWawX6HVbIUMUoetiV9UXsEtYJTLEt6Ay9Eh4tPL+hcwBEdr2aAx83TWuPpKrd
         +TZ+0oOfmjUfqCCaFZaiJTLBsDj0851F4O7Hfutoma8Scym/tIgB9+WAcSt6W6XKKcpa
         wrK2mAUQlu1D3Eg4sZ//Sz3U/+j1MF2jHdXYMVz8M9qVeOg47JvPqt28VLRJDsLSsem6
         SB+4QhANYPs7Dx9wQ9T0hDKwt4qEJtugc+zSNo63rK9Dm7iMEKgDPVzL2uFGhl54UWga
         n9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s3uQNLZ0xnXl8aHoNxOz/s0JQbfR9Ehd2ASnbJ1VF0Q=;
        b=lHwgCb7CgLXP4kqDzG7JhhoSQYBFe8Gd0rNZp5dFOsR9k9RdfLSSOvHgrRiKo6+ixV
         2se1n+ELieZmlGBQqavcbrS+XmYGT3t9HWerDGioAWVcdR4FxvjCJbv7+GJl6ZGnb8yM
         Pvh+OpB6G5gj7IJLB2ezmzY8J956d6gU+Y2GrM3KmM2NJJgoalZfIBa7j1qIaZjiwB2H
         Xm8c7MDknYmM4PSOjkLBjQnFIKEuC/ytpqT4K/5BA6/HPW6mHzmD2wfmV0Ot9/ycniD4
         zEhyPn+u2huSJL7tdj8HxJBsWxJPpuX/AMRALIDsnrgCwt8qTUHmvnj6C0H1ENBjfLKX
         q21w==
X-Gm-Message-State: AGRZ1gKj3pV48NA571Y12fvosXMYLZ8Uf4XVEyNH/+2wZ1jnrWzemDf6
        yamD8GoP0CH2MGvbRInqqx0=
X-Google-Smtp-Source: AJdET5eTirn6oaTEcRf1JrlqfAUhX0FybFfVW49OpSo0DEFKvxTJibPiQe/UwCzK3LqLP6UXj3xT9w==
X-Received: by 2002:a63:c0f:: with SMTP id b15mr525573pgl.314.1541603780431;
        Wed, 07 Nov 2018 07:16:20 -0800 (PST)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id e65-v6sm1067595pfa.90.2018.11.07.07.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 07:16:19 -0800 (PST)
Subject: Re: [PATCH net-next] tcp: minor optimization in tcp ack fast path
 processing
To:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
References: <1541589617-1607-1-git-send-email-laoar.shao@gmail.com>
 <1541589617-1607-2-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <560b2828-cb1b-5ab5-f98b-b042a7e483f8@gmail.com>
Date:   Wed, 7 Nov 2018 07:16:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541589617-1607-2-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/07/2018 03:20 AM, Yafang Shao wrote:
> Bitwise operation is a little faster.


> So I replace after() with (flag & FLAG_SND_UNA_ADVANCED) as this flag is
> already set before.
> 
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 2868ef2..0167015 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3610,7 +3610,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>  	if (flag & FLAG_UPDATE_TS_RECENT)
>  		tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
>  
> -	if (!(flag & FLAG_SLOWPATH) && after(ack, prior_snd_una)) {
> +	if (!(flag & FLAG_SLOWPATH) && (flag & FLAG_SND_UNA_ADVANCED)) {
>  		/* Window is constant, pure forward advance.
>  		 * No more checks are required.
>  		 * Note, we use the fact that SND.UNA>=SND.WL2.
> 

What about reducing this to a single conditional jump ?

if ((flag & (FLAG_SLOWPATH | FLAG_SND_UNA_ADVANCED)) == FLAG_SND_UNA_ADVANCED)  {

