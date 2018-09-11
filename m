Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ED8C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805E220854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="hF6BsDz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805E220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeIKOKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:10:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44755 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeIKOKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:10:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so20227906ljq.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+hRAOXX/4WlwteZOPt1nnGT9PlqvrgoiHbGp2lkPGBo=;
        b=hF6BsDz0OX5HjWlIZ0RgtL1Dqwe0+mn+crKjZcsw0RpFrqczGvogSK3OL8CzBbCIuC
         /O4da5nzxwGpw4aHBLyMqIJ+nqLGXZQUXvHNn3SJ731jxRx5QUoLyJBhzOMSv6TMViiz
         jrqp8sJTAgrYPTeeP1aNo1uYoBQk/qq0vB3jxgKr3ck942EKGg71aKlqLoI9gni6y7WG
         zVZ5lgi5e378PpnKIbShRvTBcDHLguyFLbotMLdDEgWa96yIlI8ujm8v8sHpOoKUNuD4
         jS18IdY7BNbxc11QVmqFgvpYE1100DPAIWsFc+0ymBdMVULixI+oBLDxZyHb/5Nrvzji
         U+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+hRAOXX/4WlwteZOPt1nnGT9PlqvrgoiHbGp2lkPGBo=;
        b=YINoAMfjbb5pgZsWa2GlinEoaSlfTCjjiFAZi3Qs04nVliiLpnw9KesgsIB4JX6GjG
         acM/wTX+pRFSDWvvUwUrwjWD9LodnWxUfHKrUKr75t2hn5ylyAVzA/lsk5Kp5+Q6uIM7
         k1Yb1BHrvSzCjkli9jRLwLMANoqmUJx8Zdu5xJUnDVaVeIAoYVBsNoIg3SrAEVIEUvkS
         c32wNLgMeYtJ9IRRegtdwl4Cq6spTzBrB83wtTDMB7P8OxhPh/BoRp1I2m6+HXIujBsO
         Q7ZZ1x+SxAHrpEizsRNdOiX2Khd0JzpBRxmr+1MrOpGxa2OebsFyhGRZ/88SL9TYfv6K
         Hzmw==
X-Gm-Message-State: APzg51CAnInmgNSdSBAxE+O/IjLXYgR0ycGqhX05dF/LbfEXb5tNHeov
        1G2IPMd/4vSiD5ZgBh9MYCM/Rb1fVzk=
X-Google-Smtp-Source: ANB0VdbgLEIBMpC4mrvGLsLHqorah0L3x/TThH58loOG5xdgqQkbg3wB2LFm+6I/hbEnqoaTpaKJOA==
X-Received: by 2002:a2e:9b59:: with SMTP id o25-v6mr8312076ljj.132.1536657106467;
        Tue, 11 Sep 2018 02:11:46 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.81.2])
        by smtp.gmail.com with ESMTPSA id 13-v6sm3170484lfy.87.2018.09.11.02.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 02:11:45 -0700 (PDT)
Subject: Re: [PATCH] net: ipv4: Use BUG_ON directly instead of a if condition
 followed by BUG
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536590282-23899-1-git-send-email-zhongjiang@huawei.com>
 <a000b5a4-2907-70f9-70ed-7e1c6a797876@cogentembedded.com>
 <5B9783ED.4080908@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <e1b9c36c-5459-a68e-e6fd-cca038e31d5f@cogentembedded.com>
Date:   Tue, 11 Sep 2018 12:11:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5B9783ED.4080908@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/2018 11:59 AM, zhong jiang wrote:

>>> The if condition can be removed if we use BUG_ON directly.
>>> The issule is detected with the help of Coccinelle.
>>
>>    Issue?
>>
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>    net/ipv4/tcp_input.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>> index 62508a2..893bde3 100644
>>> --- a/net/ipv4/tcp_input.c
>>> +++ b/net/ipv4/tcp_input.c
>>> @@ -4934,8 +4934,8 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
>>>                BUG_ON(offset < 0);
>>>                if (size > 0) {
>>>                    size = min(copy, size);
>>> -                if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
>>> -                    BUG();
>>> +                BUG(skb_copy_bits(skb, offset,
>>
>>     You said BUG_ON()?
>   Yep. Do you think that it is worthing to do

    I think BUG() doesn't take parameters, BUG_ON() does. Have you tried to 
build the kernel with your patch at all?

>   Thanks,
> zhong jiang
[...]

MBR, Sergei

