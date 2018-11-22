Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8462EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACB020820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPbe9+XZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACB020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405647AbeKWBbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:31:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35301 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403903AbeKWBbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:31:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so9555932wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xr3HH+38xb2AAK3rrwZuDa65+IN8XHHCOchLXUoFikk=;
        b=OPbe9+XZdhAdRWkhZ4AICasB/Mq88dSeJhKNiEzSOPJz21rz68Vf6JD27pIJPq466M
         /k2dptoIMojDI3TW8pjZfZ9E2M//BFzpVmPKRkjmeVrLeCFfz/TBtzk5Q14nB/obSfCq
         uvhzGR9cBlWXBEoHto4GtN8NXmkivNyToGS5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xr3HH+38xb2AAK3rrwZuDa65+IN8XHHCOchLXUoFikk=;
        b=dqIPfiKwO8V8k1J5YZR76950/Q1fXUiTTcXWv1FilD5smzn2v0gL9jPZEUQIhsisdO
         yyf2YVNawrBK0RUAbF+to2eKcvyzl6KYcVckG4XHCpY/hh9BfjDLo4uZbhv8P58gpEeh
         YLyZH/Zw/tOM4S3ne0xy1cAU6ieRyesRl8fhW8rAfNzYHc5wT6qa9umU+1BS1tRH3EvI
         Y+Y/bVUAG9X8a1WE51Ah7lGY8hL7x6Ds4KoGtN4Sd5BuVHDMzmVfsPlgc2ByWipNrU/s
         fPr+Fn1onXZPfSJPHlj20tkBqSgT7NooaHoIj7p21h4uszzh9w9ybogiymMP9n+ghMNU
         gN8g==
X-Gm-Message-State: AA+aEWawLknI7K+zp9sME9mXQEe81Mv/lT64D8oK4aEuHBqrjlyPmRiR
        oJWtdDkDG9T0pJNFStHLvQ0Ar8UOXEM=
X-Google-Smtp-Source: AFSGD/XmCotXTV6+q1rv8YD7FgzAYKhvjGUwrR0FlPW9lQfFWiSJbM2VLskBQBEzfhC4KGShkUUP+g==
X-Received: by 2002:adf:8228:: with SMTP id 37mr9820206wrb.160.1542898299992;
        Thu, 22 Nov 2018 06:51:39 -0800 (PST)
Received: from [192.168.0.40] (44.65.136.77.rev.sfr.net. [77.136.65.44])
        by smtp.googlemail.com with ESMTPSA id h127sm4938297wmd.31.2018.11.22.06.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 06:51:39 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20181120131853.19710-1-tiny.windzz@gmail.com>
 <5ea4da1e-65de-ddc3-5ca6-eb83c2347930@linaro.org>
 <CAEExFWsOh1gixoC4bbSkbawC-ybz1YUA-tmw5FW5W-GFyFGs7Q@mail.gmail.com>
 <54a66dbf-df0a-8cec-cb60-0603a52dad99@linaro.org>
 <CAEExFWvTCJ-k+54PGv7Ov5FRMpD1C2ZzzUxi4=Kbn_hrkmBmqw@mail.gmail.com>
 <2cbc73df-e1b4-21bc-c226-38b69ebe9f08@linaro.org>
 <CAEExFWvOG9YmUdJjJ-d-acHLU9DrS9ccRWs-u1wMOJocQhXZSw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b6c8bdc9-d43a-5884-0678-b34176292909@linaro.org>
Date:   Thu, 22 Nov 2018 15:51:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWvOG9YmUdJjJ-d-acHLU9DrS9ccRWs-u1wMOJocQhXZSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 15:48, Frank Lee wrote:
> On Thu, Nov 22, 2018 at 10:43 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 22/11/2018 15:39, Frank Lee wrote:
>>> On Thu, Nov 22, 2018 at 10:37 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 22/11/2018 15:33, Frank Lee wrote:
>>>>> On Thu, Nov 22, 2018 at 10:26 PM Daniel Lezcano
>>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>>
>>>>>> On 20/11/2018 14:18, Yangtao Li wrote:
>>>>>>> use of_node_put() to release the refcount.
>>>>>>>
>>>>>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>>>>>>
>>>>>> Applied, thanks!
>>>>> Hi Daniel：
>>>>>
>>>>> This patch is a bit small, I will resend。
>>>>
>>>> What do you mean by 'small' ?
>>>         pri_node = of_find_node_by_path(path);
>>>         if (node == pri_node){
>>>                 of_node_put(pri_node);
>>>
>>>                 /* The primary timer lacks IRQ, use as clocksource */
>>>                 return integrator_clocksource_init(rate, base);
>>>         }
>>>
>>>         sec_node = of_find_node_by_path(path);
>>>
>>> Under my revision, pri_node and sec_nodeare the same thing.
>>
>> Oh, right. Missed it :/
> Daniel ,
> 
> Have you mde the patch merged?
> Which git is the patch in?
> I hope that you can revert it and I‘ll resend new one
> or I'll resend patch based on the modify.

I can drop it, resend a new one.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

