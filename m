Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF73C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EDB20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccdvbBBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EDB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937025AbeFRXgT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:36:19 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39487 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934880AbeFRXgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:36:17 -0400
Received: by mail-pg0-f68.google.com with SMTP id w12-v6so8250030pgc.6;
        Mon, 18 Jun 2018 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kCHNaVC7od/IApNXGlJmYwUjVNVaC4YXJLyQjX+2zig=;
        b=ccdvbBBNBW4Ye+YVodIYQWQr0V6AUUj3n/2wBK4tLXAIhDBGsrX9m4QnqH8ebM9CyD
         hxOEsdxVEN4u52OsyN04HuCbxROyxAfzkHxAOyfyV0nkWI5VpkExlf2zTcOzvlqi4jAj
         D8lv0WXcQ9rG+uaHUTPABWjA8BVZE1aLDMGL0Dm0qcgBy1qzkC4FBR7lKJ2e/7cQVh72
         2xUzjB+rD5kmyR272WJAuUnsH0vus+1J/7YWjQLx2SggXbCN1AFKIktZVjvIaB9E1Q/g
         Cv3l2uvrEynLbC2s1zi4JUbDTes5moBCxf45b4ErYvdyFTmAv1n9EWtIoj0Ps6RsxaVi
         8Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kCHNaVC7od/IApNXGlJmYwUjVNVaC4YXJLyQjX+2zig=;
        b=kYb1g0hM6WNoMzevGOK4rzNmoqXE8kg0FLk/4OKP5FiPRxhDLEOjmg/R67TZeodnsE
         BkULxBGSmp9LiVx30Ydtj0K1ciUFpmZx++wNEQ6++D9szyd+SiwO0XuW4j9qjn3/e2r+
         gWG4Khk6fjG7Bny1kZcxNhhnWv4SZa9kIj0KLsaXzFvEQ6ZAr8LFqRQ55e0KjSLDHnIU
         KUOGyd41CzU24BtM9D2Wd9SbsWmebVX/p/X+oHR1DnQF+bUi/blfxcll5M6B3i48BBUP
         t21hSa0cZpcLKgWKPpjGhhybJKcQ9H3Kxx3uz7ZCoWZJlVowwQaxwLSTc4bRNnLq7fdT
         Z91A==
X-Gm-Message-State: APt69E2jWHnGt7wlprCClC4YzIRHU+OyStkHEUMFysrLFcpOwt5TAuET
        ivJljqIQJrxPjuKoVz4+3JyogWFt
X-Google-Smtp-Source: ADUXVKJMX6nGTdw/2bbFNjy8qOahydJolbmbnYQQ8fgdAjaowgzD3/zzuVgxlL0ANO8yfutDsFKWOQ==
X-Received: by 2002:a63:41c1:: with SMTP id o184-v6mr12945542pga.323.1529364977054;
        Mon, 18 Jun 2018 16:36:17 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id a14-v6sm18998169pgv.4.2018.06.18.16.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 16:36:16 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Mathieu Malaterre <malat@debian.org>
Cc:     schwab@linux-m68k.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Meelis Roos <mroos@linux.ee>, netdev@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180615185645.8921-1-malat@debian.org>
 <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
 <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
 <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com>
 <m2tvq1672p.fsf@linux-m68k.org>
 <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com> <87o9g8geu0.fsf@igel.home>
 <816ef746-5278-1d51-1d9d-55593e377681@gmail.com>
 <CA+7wUszG3Tmq5qT7o7w7ttAU+bzyJfRORL_Qzk4wUG6y2gZUuw@mail.gmail.com>
 <21523399-92ee-f8da-1a3e-0561f62850b7@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <dd6f13bc-c5f2-85f8-c08d-837bc024fc7c@gmail.com>
Date:   Mon, 18 Jun 2018 16:36:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <21523399-92ee-f8da-1a3e-0561f62850b7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/18/2018 04:29 PM, Eric Dumazet wrote:
> 
> 
> On 06/18/2018 11:45 AM, Mathieu Malaterre wrote:
> 
>>
>> Here is what I get on my side
>>
>> [   53.628847] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
>> [   53.667063] sungem: sungem wrong csum : eea8/6eec, len 149 bytes
>> [   58.648952] sungem: sungem wrong csum : 2095/3d06, len 64 bytes
>> [   58.669414] sungem: sungem wrong csum : 5245/b50, len 149 bytes
>> [   63.674451] sungem: sungem wrong csum : 2d8/5abd, len 149 bytes
>> [   68.678233] sungem: sungem wrong csum : b8fc/a498, len 149 bytes
>> [   73.685771] sungem: sungem wrong csum : 374/5a21, len 149 bytes
>> [   78.689089] sungem: sungem wrong csum : d81/5014, len 149 bytes
>> [   83.683261] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
>> [   83.690193] sungem: sungem wrong csum : c2f7/9a9d, len 149 bytes
>> [   88.692511] sungem: sungem wrong csum : f4d8/68bc, len 149 bytes
>> [   93.699915] sungem: sungem wrong csum : 1370/4a25, len 149 bytes
>> [   98.703136] sungem: sungem wrong csum : e1b5/7bdf, len 149 bytes
>> [  103.704230] sungem: sungem wrong csum : 5321/a74, len 149 bytes
>> [  108.688912] sungem: sungem wrong csum : 2095/3d06, len 64 bytes
>> [  108.706559] sungem: sungem wrong csum : ddbc/7fd8, len 149 bytes
>> [  113.713189] sungem: sungem wrong csum : 5a65/330, len 149 bytes
>> [  113.891697] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
>> [  118.717151] sungem: sungem wrong csum : f7c8/65cc, len 149 bytes
>> [  123.722680] sungem: sungem wrong csum : 3d7a/201b, len 149 bytes
>> [  128.726524] sungem: sungem wrong csum : c8fd/9497, len 149 bytes
>> [  133.732045] sungem: sungem wrong csum : de0d/7f87, len 149 bytes
>> [  135.529163] sungem: sungem wrong csum : 3089/b6dd, len 96 bytes
>> [  135.529208] eth0: hw csum failure
>> [  135.529220] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #7
>> [  135.529226] Call Trace:
>> [  135.529243] [dffedbe0] [c069ddac]
>> __skb_checksum_complete+0xf0/0x108 (unreliable)
> 
> Thanks, then I guess next step would be to dump the content of the frames
> having a wrong checksum, hoping we find an easy way to discard the CHECKSUM_COMPLETE
> in a selective way.
> 
> Otherwise, we will need to remove CHECKSUM_COMPLETE setting in this driver.
> 
> diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
> index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..77a761f95be788bb86c8d917f613c9084818f826 100644
> --- a/drivers/net/ethernet/sun/sungem.c
> +++ b/drivers/net/ethernet/sun/sungem.c
> @@ -857,6 +857,14 @@ static int gem_rx(struct gem *gp, int work_to_do)
>  
>                 csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
>                 skb->csum = csum_unfold(csum);
> +               {
> +               __wsum rsum = csum_partial(skb->data + ETH_HLEN, len - ETH_HLEN, 0);
> +               if (csum != csum_fold(rsum) && net_ratelimit())
> +                       pr_err("sungem wrong csum : %04x/%04x, len %u bytes\n",
> +                               csum, csum_fold(rsum), len);
> +                       print_hex_dump(KERN_ERR, "raw data: ", DUMP_PREFIX_OFFSET,


DUMP_PREFIX_ADDRESS might give us more information (say alignment problem, or crossing page boundaries)

> +                                           16, 1, skb->data, len, true);
> +               }
>                 skb->ip_summed = CHECKSUM_COMPLETE;
>                 skb->protocol = eth_type_trans(skb, gp->dev);
>  
> 
