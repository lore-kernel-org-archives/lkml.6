Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9726CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4762083D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SshmzCNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfBZUQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:16:04 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35744 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfBZUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:16:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id z13so8441515qki.2;
        Tue, 26 Feb 2019 12:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h0exWfUc/l0B4iKi2Weupr9F+jS2NFATzeYNt5vWbig=;
        b=SshmzCNOhgZH1Z+hhw40uU/+sf+586YrHj4dxio787u+oASuBKBlRFZBDLcUHMqK1v
         t62WjO2qKU0Y9JBU0BPpPR466yabfrH5NBD/2kv9KS/UH4IveDdDYkwxUTUAnBEQsGLj
         KDFfugo2XyG/OdXFxckO/GDNLgykXnNj4iPw1+JhEOXRnFgLBlT+GSQewqJS8K/ZprRl
         Tg4Lk8JMlovBCk0CRrsxTH7A95ZsKlQhjlWlF/gYt8LTtwVqAbc6LHvxeENOMmQcbpko
         q/VIcXstjz3js3/T+QbHXgRB4QT3wuZGjpjuBUqRu8rf0ZsOSHxUot0UA66i5leBviXs
         ++HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h0exWfUc/l0B4iKi2Weupr9F+jS2NFATzeYNt5vWbig=;
        b=odS2QfoTmqBiV9NzgaBy/hpLKdBrp4u+2Zkp6057QZTIbB9isTStOj1i0EPU6v9vqT
         dEBjsWN8XHsif8cBRHHekozRrpl7OhKmEb4KoAixFsFknWewJXk/zvNnSn9MLKhH6qxP
         gED9/mEgN5i+Gu1TfapK1uDWGUkYHzAA80rizsl+T8j826F8U08Y89p2oHKHyaso1vUd
         JXy9xUS1HenxFBTgDY5kTKNm0kWzFZGYOjP92AOn4tSPKh4KiQFwBJM1NdLFGaXvBL/a
         1bQXg2VyrFVXTNkaKo1tKiMm9it96lHVWwGfG4PUAycfCiWZJ4tYKtMAKT5y4cmvo8rv
         yt6w==
X-Gm-Message-State: AHQUAuYboRIMux4YesGrsBkion8tWHfMdAzc4RypkDgsUAWFKN4mcMeB
        jaE3TG584ahL451QqJPUxUE=
X-Google-Smtp-Source: AHgI3Ib+OETw//q8u2ichhD+NzBA3FWTaQjDo9mm17yGgmgZRzTwLDZ+L9pIdDD6qXZaucxYWFyN+g==
X-Received: by 2002:a37:e503:: with SMTP id e3mr17635689qkg.316.1551212162253;
        Tue, 26 Feb 2019 12:16:02 -0800 (PST)
Received: from [192.168.44.108] ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o2sm10104834qtf.46.2019.02.26.12.15.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 12:16:01 -0800 (PST)
Subject: Re: [PATCH 5/5] iio:potentiostat:lmp91000: add '\n' on dev_err
To:     Joe Perches <joe@perches.com>, Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
 <20190218172236.7781-6-lucasseikioshiro@gmail.com>
 <d5d88a5acc984554240047944cb3071371025085.camel@perches.com>
 <20190220094921.6777d6f8@archlinux>
 <68f8ea8165f4a87cd1c99c14f2d1cc3ecdd54ed3.camel@perches.com>
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
Message-ID: <f21c5ea1-2775-91e4-4df6-3f15eec4fb81@gmail.com>
Date:   Tue, 26 Feb 2019 17:15:52 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <68f8ea8165f4a87cd1c99c14f2d1cc3ecdd54ed3.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review!

On 20/02/2019 19:22, Joe Perches wrote:
> On Wed, 2019-02-20 at 09:49 +0000, Jonathan Cameron wrote:
>> On Mon, 18 Feb 2019 13:01:23 -0800 Joe Perches <joe@perches.com> wrote:
>>> On Mon, 2019-02-18 at 14:22 -0300, Lucas Oshiro wrote:
>>>> Add missing '\n' at the end of dev_err message on line 215.
>>> []
>>>> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
>>> []
>>>> @@ -212,7 +212,7 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>>>>   	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
>>>>   	if (ret) {
>>>>   		if (!of_property_read_bool(np, "ti,external-tia-resistor")) {
>>>> -			dev_err(dev, "no ti,tia-gain-ohm defined");
>>>> +			dev_err(dev, "no ti,tia-gain-ohm defined\n");
>>>
>>> Perhaps a copy/paste error as the test is for
>>> external-tia-resistor and not tia-gain-ohm
>>>
>> It is an odd construct, but I think this is correct.  What it is actually
>> saying is that, given that we don't have an external resistor, we care
>> that the tia-gain-ohm isn't set (otherwise it wouldn't matter).
>>
>>  From the docs
>>    - ti,external-tia-resistor: if the property ti,tia-gain-ohm is not defined this
>>      needs to be set to signal that an external resistor value is being used.
>>
>> So, it might be ideal to say that tia-gain-ohm is not defined and we do
>> not have an external resistor specified.
>>
>> So not wrong, but could be more informative!  So perhaps a follow up patch
>> to tidy that up would be good.

So, this means that it's a good idea to change the dev_err message to something
like "no ti,tia-gain-ohm defined and external resistor not specified"?

> 
> Then thanks in advance for doing that.
> cheers, Joe
> 
