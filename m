Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14922C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C355D20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="voBqe/xe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C355D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeIKObb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:31:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37475 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKObb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:31:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id j8-v6so19757556lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0CqYcvNpE16qWp6cyTlBFDC525iQJL/z/iPpsZsoLnU=;
        b=voBqe/xeMSMqQWr1lYdewUzYWyrXWEUafoHvsXy+MYwMtmUdis0BWHKHzcYKCTBGMN
         mGjVVIHa+hQDcsrrXW3N1r9hWwn27648SCxzMkuEd7a+idYJgfD0cfNgrmE6ZmzXo3BA
         YU8lJRe5cjd0DrZVbzFUXJEiWcUKQMcGz7VZVZuQYI7u7wmym4mfUn2z1yN1Dwr3zTwe
         AWi7s8ySUHeGAquL8nS/1z7KWFjvgB8Mb2+bBQppVzPeLrZ71ucSbCIDjWEKlsRZ37zF
         I00Na0+3xmJPHMe+FhhPuB2Pcyg6W4plEOu8AnUvnpbI2rO4wdjAMY3T8KWj0/h+Fcd5
         NAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0CqYcvNpE16qWp6cyTlBFDC525iQJL/z/iPpsZsoLnU=;
        b=iCwXBFLInY25J36Yp7Hdx+UyfUbCh6Ku2OkpvQ48QgnnVPXipYmCvmNftx8+UqAZOZ
         Iv56yNgL1SpY17bEVnGTnQQkto3MTmHBBn3OwzcKGMDHlWQFhyAWgBAv5yiHOuMa1Khq
         C/HwpXGhuDsmYsUiLd4xBTiQ00Obnee3GDK67jxPphPyGjOGe5kbHBuCmt8qk2R4k0tG
         Ae+GSunye9PUTIF7FxXAZ9JjWo0Orr1bA6Uc38bJNozDZKjXcfY7y2sPktNva2KTmanQ
         ZGbczJU+LWcHNBbYvYn6wV123dW0Y2wQeQuQzPUcU/SUjadrGkrEGRU5QtXzvd+2CN3q
         wkzw==
X-Gm-Message-State: APzg51BM503/Y7r4z141W71+H/ZaO1xWZmHsWxuvL7JTbxCKbsZnTA6Y
        wmC6IrdwhvuEoEJbJ/jffnMrQvOcgno=
X-Google-Smtp-Source: ANB0VdbLdg8UMxzfVd6nqtYZDg9ezo6XSH6ZtdiM1KKfanJSFOyeV9zA8plAMBRubVR8zx6mlhPmrA==
X-Received: by 2002:a19:cc08:: with SMTP id c8-v6mr15761672lfg.145.1536658380729;
        Tue, 11 Sep 2018 02:33:00 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.81.2])
        by smtp.gmail.com with ESMTPSA id u2-v6sm3205691ljg.55.2018.09.11.02.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 02:32:59 -0700 (PDT)
Subject: Re: [PATCH] net: ipv4: Use BUG_ON directly instead of a if condition
 followed by BUG
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536590282-23899-1-git-send-email-zhongjiang@huawei.com>
 <a000b5a4-2907-70f9-70ed-7e1c6a797876@cogentembedded.com>
 <5B9783ED.4080908@huawei.com>
 <e1b9c36c-5459-a68e-e6fd-cca038e31d5f@cogentembedded.com>
 <5B97889F.3020303@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <6a9ff302-c86c-cd9e-7432-2de38d148678@cogentembedded.com>
Date:   Tue, 11 Sep 2018 12:33:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5B97889F.3020303@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/2018 12:19 PM, zhong jiang wrote:

>>>>> The if condition can be removed if we use BUG_ON directly.
>>>>> The issule is detected with the help of Coccinelle.
>>>>
>>>>     Issue?
>>>>
>>>>>
>>>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>>>> ---
>>>>>     net/ipv4/tcp_input.c | 8 ++++----
>>>>>     1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>>>> index 62508a2..893bde3 100644
>>>>> --- a/net/ipv4/tcp_input.c
>>>>> +++ b/net/ipv4/tcp_input.c
>>>>> @@ -4934,8 +4934,8 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
>>>>>                 BUG_ON(offset < 0);
>>>>>                 if (size > 0) {
>>>>>                     size = min(copy, size);
>>>>> -                if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
>>>>> -                    BUG();
>>>>> +                BUG(skb_copy_bits(skb, offset,
>>>>
>>>>      You said BUG_ON()?
>>>    Yep. Do you think that it is worthing to do
>>
>>     I think BUG() doesn't take parameters, BUG_ON() does. Have you tried to build the kernel with your patch at all?
>>
>   I know that the patch should be BUG_ON instead of BUG. This is my mistake.  I just want to know that it is worthing to do so.

    Yes, probably.

>   Thanks,
>   zhong jiang
[...]

MBR, Sergei

