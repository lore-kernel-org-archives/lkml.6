Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D175C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8C520671
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeeE2CLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8C520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeG1E7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 00:59:53 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40121 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeG1E7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 00:59:53 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so10038390ita.5;
        Fri, 27 Jul 2018 20:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D3amOF7G+ay6TIFFNc7aL9pg4uX0aWl+AajvVc2IoWI=;
        b=YeeE2CLVhYL006t16hAZyBF8uj9XPH5sHwxZ13PBh6dPRMD2DPSceUJlt4cUGaCs6s
         3suGtXf6EivuOhAmACXUomci0Vzwo+kcvRqCgj+wdKBBvWYtBCh03q3pxab2ZOgCWnZS
         m+ndHqStZcxoKXyhpYeh2Clo10MlbaHfbaThAr7vPXFua6vol80wU/T+c3GogFY5W2Wv
         VWokRWoCQMdVD1P6mjaE38y2pH0CEwEFieZQP9OFQUIDPHxwcXyEGLh4dXOX53Kalcr+
         NpOh/hT4tePhXcy3I4GUJJaRikwqiaGx75iDOXtlAGnvGcqKfYQSW3OgW4T3xxyzkpml
         2M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D3amOF7G+ay6TIFFNc7aL9pg4uX0aWl+AajvVc2IoWI=;
        b=EP7xBQ7KnBrNOhgJH+GzAii5V72Pk32+SBclor3qhe2K7PPcSBUrcn4egkMKn3FyVc
         G7fsvMqCxhUkZB4qbS/lzgX1EVnDn//veCoYroxnebbTLqcAYRqbPU6R0XDzCCGarC/d
         erkD+FLG6llQ7Hp5BideuEzb2gryKVYynX0MZ9+kqH/v71Zia8aEw9XPKlG19y1LLKfY
         fJGwn7xGq1GMIXHXudXmOUEXDwI6Qaab4P3V4yL6gtJnfyPD5QtWg1FY89jcqr0YMEQz
         8+oJFSGmJ9EOL8xNgJ+M+VUBv/JIBYDqCwPZRBADT8D+DaRNsf77yA4EXIusRcbqbZaE
         NgxQ==
X-Gm-Message-State: AOUpUlGcxEq/HqE96pqPCDYXZSALl4drkiUFwSdRbWtSHF51KGJw24iF
        YqEtnhqXnFwseA9e0MKyFPREhwNBWBQ+COCEdX3Ru7mnusY=
X-Google-Smtp-Source: AAOMgpcx374KJPT+p+xG3SZy/8lYzq1b6DohtWip/uVh14nLy5SdwxLwMoM4x02L5q5bSrhfHrRTYuMMh5kxcVulBfs=
X-Received: by 2002:a02:13c6:: with SMTP id 189-v6mr8786354jaz.50.1532748903255;
 Fri, 27 Jul 2018 20:35:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 20:34:22
 -0700 (PDT)
In-Reply-To: <CANn89iJ=Ad7sVWr3zBmXNSyePJJZaxgnMymN8S7x6fCSvG2jTQ@mail.gmail.com>
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com> <CANn89iJ=Ad7sVWr3zBmXNSyePJJZaxgnMymN8S7x6fCSvG2jTQ@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 28 Jul 2018 11:34:22 +0800
Message-ID: <CALOAHbC4Rs7w1RwZRBsw_fjGSDvuHV37=nguzJNZzkreR5f4Dw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: call tcp_drop() in tcp collapse
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 11:06 AM, Eric Dumazet <edumazet@google.com> wrote:
> On Fri, Jul 27, 2018 at 8:02 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> When this SKB is dropped, we should add the counter sk_drops.
>> That could help us better tracking this behavior.
>>
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> ---
>>  net/ipv4/tcp_input.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index d51fa35..90f83eb 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -4802,7 +4802,7 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
>>         else
>>                 rb_erase(&skb->rbnode, root);
>>
>> -       __kfree_skb(skb);
>> +       tcp_drop(sk, skb);
>
>
> Absolutely not.
>
> We do not drop the packet, we have simply lowered the memory overhead.

So what about LINUX_MIB_TCPOFOMERGE ?
Regarding LINUX_MIB_TCPOFOMERGE,  a skb is already covered by another
skb, is that dropping the packet or simply lowering the memory
overhead ?

Thanks
Yafang
