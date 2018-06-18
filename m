Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2AEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8434B20693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF4rq0Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8434B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935923AbeFRSSu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:18:50 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32820 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935585AbeFRSSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:18:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so8583411pfi.0;
        Mon, 18 Jun 2018 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8E4VHY5KWLPP9XG6ex40CyQdmNZ4MTEKwJVQ+JO1M0A=;
        b=hF4rq0Qlfp4TRUnF2vSh/V+Z54RbdnZKvW+tEdZzn9q38YTzxjfo5Dtw++PhgQPHcQ
         Inli1bKjyagRQRv3ypDA6Za7fozqdJxATnPl5ETduiHkOeB/9BwrpV/iS16oRsoB7SWp
         7z2YKumM8t0v5yp8EFIUsRjJzY18epCD37+UMFscSjWOfAE3ApezmUuAKB2sfYajqzDU
         gfxs54OV2R8EVRpNmLTHjnlk4ZY7yCzMFECkFyp81x5wJyi6oeaTLmye9uuNGOFswWNz
         MfY0kvnL8ywak/ALPuLNGWntP4TJL05ZA+sNubb3NMzdm63wo0d5eayHjnHe4NYQfwAI
         IdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8E4VHY5KWLPP9XG6ex40CyQdmNZ4MTEKwJVQ+JO1M0A=;
        b=oXGp6e/eFZq2GvXUqhEh3YsX3kPhf4yoA9JmUCDm3FaZ3vtuR7E06AA6XxjO6zskFg
         gjis1FhGFlWRL/u+LVUEGUCaH48HMfolp+JDbocThOFYQ2tc9O0fS9lKzaEY4YUATMKP
         8ZTuZE/hHeBkImjZZl98m67FY0iJO9TDclp78InZhixB0/5ajjH2MkgGacSt5BAr1aCn
         e3PcjwL4V0aXD/Xbp1Wgz8u9EbwJdufnDp8Y7X0b53r2Jpkcl4dqRu/of5S5oJ+feDOe
         MKRXq7MpF1bBsZJRTC7BtHXii1q20M23IIfWavSSQNbwDoBkjs6qA97PbfW5MALS7kZo
         BR5Q==
X-Gm-Message-State: APt69E0+ok2Y/qtxxyaRZtU7Sc/ovYDXBtZ1KAMDfqBCm2T11F8LVs8H
        +/ggoD0X5Wp2lai8nbGD73s=
X-Google-Smtp-Source: ADUXVKKupLLhxZ8SvciRSdVxXaRA/akwzX7wuMcKChO4/94G9j4ffulSZbRsdC+f0jI9ui8ecO6jlw==
X-Received: by 2002:a62:ca99:: with SMTP id y25-v6mr14512434pfk.187.1529345928277;
        Mon, 18 Jun 2018 11:18:48 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id o87-v6sm28910704pfa.106.2018.06.18.11.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 11:18:47 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
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
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <816ef746-5278-1d51-1d9d-55593e377681@gmail.com>
Date:   Mon, 18 Jun 2018 11:18:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87o9g8geu0.fsf@igel.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/18/2018 10:54 AM, Andreas Schwab wrote:
> On Jun 17 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> 
>> Oh this is silly, please try :
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index c642304f178ce0a4e1358d59e45032a39f76fb3f..54dd9c18ecad817812898d6f335e1794a07dabbe 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -1845,10 +1845,9 @@ EXPORT_SYMBOL(___pskb_trim);
>>  int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
>>  {
>>         if (skb->ip_summed == CHECKSUM_COMPLETE) {
>> -               int delta = skb->len - len;
>> +               __wsum csumdiff = skb_checksum(skb, len, skb->len - len, 0);
>>  
>> -               skb->csum = csum_sub(skb->csum,
>> -                                    skb_checksum(skb, len, delta, 0));
>> +               skb->csum = csum_block_sub(skb->csum, csumdiff, len);
>>         }
>>         return __pskb_trim(skb, len);
>>  }
> 
> That doesn't help either.
> 
> Andreas.
> 

Then maybe NIC provided csum is not correct.

It does not compute a checksum on all the frame, but part of it.

You could use this patch to double check.

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..277859ea73e35271a10b02011120fca248ec8e71 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -857,6 +857,11 @@ static int gem_rx(struct gem *gp, int work_to_do)
 
                csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
                skb->csum = csum_unfold(csum);
+               {
+               __wsum rsum = csum_partial(skb->data + ETH_HLEN, len - ETH_HLEN, 0);
+               if (csum != csum_fold(rsum))
+                       pr_err_ratelimited("sungem wrong csum : %x/%x, len %u bytes\n", csum, csum_fold(rsum), len);
+               }
                skb->ip_summed = CHECKSUM_COMPLETE;
                skb->protocol = eth_type_trans(skb, gp->dev);
 




