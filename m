Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9679C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F33120854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBlf3C0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F33120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbeKEJ4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 04:56:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41001 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeKEJ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 04:56:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id p16-v6so3551239plr.8;
        Sun, 04 Nov 2018 16:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6neK8wDxcPtfKxnxOpLM868G1Km25ksSSZAdztyqY+c=;
        b=ZBlf3C0vaM0MbxLHGFn/PcAdKfBNSlZmxHr+etBP6NynE8vdEnQO3OAOCao9d1NxnU
         v3NySkOjQv4Nu8EhierjlYmw9iuTI5AEqtxh8amytAne4Gc6+5RsP8S6z5EoHd1IYS/1
         urLtgqHUoZ/QzgwZECIQSqQqTIIDHs6t3RzgL9oyHbx9A+eApBeEVyK3Qz9Ks4ltMkbA
         xc9Dud6ntRMY3yKlN8FodSD9IDB+P6pJp3v/491ldfwkc8MkTLErGmFPr46gMbwj48D5
         5bw0gVLpcxl8QberWUkiG4MP+7YKkVVJMu80drZGpDKm8DohYAXVcJMj3TMqDxBNsf5S
         FQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6neK8wDxcPtfKxnxOpLM868G1Km25ksSSZAdztyqY+c=;
        b=Ek49vkLmC1ZvuK3u2NJAEwutElw35t8gRL6/0hsDYnlCwYhMUryO6AvSfAu4ztLsOK
         9gE6NIKOWv+tDwMfq8Io2ekcGuHRkftf0eyX8q+w9+zoFnUHaBayl/73HeKbxvUBid2D
         KdZ/9xabr/3hltEA3L9NrsrPYj8mar4wS9aAxw/dTxjwBJHI10ytR8B/c5GCKE2KGppn
         cSyHS/jL3otKKtfqzxn999mTpYGVVLzogPdcEttQw9UgQuWm+4O7cJRaQTQvNE1CvtSR
         3fdtyk5jbHm3YHZgmE8WA4iPRXX1ZlZ9RfBx0nGiIBuBc8ymQVA7uzModmsc4ca767qZ
         XR1g==
X-Gm-Message-State: AGRZ1gKa8r2nUB6JjQnUFtMrn2WbVN+prndrnsF/l7Mv64OX64wVbkkL
        X62IpgFeKiypQEhyWgYvwG/VV8J6
X-Google-Smtp-Source: AJdET5dPxn5yDHMpt9yMv0XfbYPl69Dh2F0Zrp17nxFuEIucGtDtO02E7n87i7hBKSpwpU0Pav7YDw==
X-Received: by 2002:a17:902:a418:: with SMTP id p24-v6mr19344610plq.29.1541378357980;
        Sun, 04 Nov 2018 16:39:17 -0800 (PST)
Received: from [0.0.0.0] (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id z1-v6sm23728282pgj.37.2018.11.04.16.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 16:39:16 -0800 (PST)
Subject: Re: [PATCH v4 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, preid@electromag.com.au,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
 <20181012073536.20339-4-songqiang1304521@gmail.com>
 <20181013111935.00a2e1af@archlinux>
 <e1715942-8fd8-152f-49c8-2a9e081d8a2a@gmail.com>
 <20181021151427.5b3dbb9b@archlinux>
 <b7078a05-c40b-eba5-73f6-d5e3940d88f2@gmail.com>
 <20181102092411.00003cb5@huawei.com>
From:   Song Qiang <songqiang1304521@gmail.com>
Message-ID: <71b9a137-4f7f-67c2-e83c-71f2c8cf9f75@gmail.com>
Date:   Mon, 5 Nov 2018 08:39:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102092411.00003cb5@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/2 下午5:24, Jonathan Cameron wrote:
> On Fri, 2 Nov 2018 15:55:27 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
>
>> On 2018/10/21 下午10:14, Jonathan Cameron wrote:
>>> On Thu, 18 Oct 2018 16:24:15 +0800
>>> Song Qiang <songqiang1304521@gmail.com> wrote:
>>>
>>> ...
>>>>>> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>>>>>> +{
>>>>>> +	struct iio_poll_func *pf = p;
>>>>>> +	struct iio_dev *indio_dev = pf->indio_dev;
>>>>>> +	unsigned long scan_mask = *indio_dev->active_scan_mask;
>>>>>> +	unsigned int mask_len = indio_dev->masklength;
>>>>>> +	struct rm3100_data *data = iio_priv(indio_dev);
>>>>>> +	struct regmap *regmap = data->regmap;
>>>>>> +	int ret, i, bit;
>>>>>> +
>>>>>> +	mutex_lock(&data->lock);
>>>>>> +	switch (scan_mask) {
>>>>>> +	case BIT(0) | BIT(1) | BIT(2):
>>>>>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
>>>>>> +		mutex_unlock(&data->lock);
>>>>>> +		if (ret < 0)
>>>>>> +			goto done;
>>>>>> +	break;
>>>>>> +	case BIT(0) | BIT(1):
>>>>>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
>>>>>> +		mutex_unlock(&data->lock);
>>>>>> +		if (ret < 0)
>>>>>> +			goto done;
>>>>>> +	break;
>>>>>> +	case BIT(1) | BIT(2):
>>>>>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
>>>>>> +		mutex_unlock(&data->lock);
>>>>>> +		if (ret < 0)
>>>>>> +			goto done;
>>>>>> +	break;
>>>>> What about BIT(0) | BIT(2)?
>>>>>
>>>>> Now you can do it like you have here and on that one corner case let the iio core
>>>>> demux code take care of it, but then you will need to provide available_scan_masks
>>>>> so the core knows it needs to handle this case.
>>>>>      
>>>> This confused me a little. The available_scan_masks I was using is {BIT(0) |
>>>> BIT(1) | BIT(2), 0x0}. Apparently in this version of patch I would like it to
>>>> handle every circumstances like BIT(0), BIT(0) | BIT(2), BIT(1) | BIT(2), etc.
>>>> Since Phil mentioned he would like this to reduce bus usage as much as we can
>>>> and I want it, too, I think these three circumstances can be read consecutively
>>>> while others can be read one axis at a time. So I plan to let  BIT(0) | BIT(2)
>>>> fall into the 'default' section, which reads axis one by one.
>>>>
>>>> My question is, since this handles every possible combination, do I still need
>>>> to list every available scan masks in available_scan_masks?
>>> Ah. I see, I'd missed that the default was picking up that case as well as the
>>> single axes.   It would be interesting to sanity check if it is quicker on
>>> a 'typical' platform to do the all axis read for the BIT(0) | BIT(2) case
>>> and drop the middle value (which would be done using available scan_masks)
>>> or to just do two independent reads.
>>>
>>> (I would guess it is worth reading the 'dead' axis).
>>>   
>>>> All other problems will be fixed in the next patch.
>>>>
>>>> yours,
>>>>
>>>> Song Qiang
>>>>
>>>>
>>>> ...
>>> Thanks,
>>>
>>> Jonathan
>> I tested this two ways of getting data with the following code snippet:
>>
>>
>>       u8 buffer[9];
>>       struct timeval timebefore, timeafter;
>>
>>       do_gettimeofday(&timebefore);
>>       ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, 9);
>>       if (ret < 0)
>>           goto unlock_return;
>>       do_gettimeofday(&timeafter);
>>       printk(KERN_INFO "read with dead axis time: %ld",
>>              timeafter.tv_sec * 1000000 + timeafter.tv_usec -
>>              timebefore.tv_sec * 1000000 - timebefore.tv_usec);
>>       do_gettimeofday(&timebefore);
>>
>>       ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, 3);
>>       if (ret < 0)
>>           goto unlock_return;
>>       ret = regmap_bulk_read(regmap, RM3100_REG_MZ2, buffer + 6, 3);
>>       if (ret < 0)
>>           goto unlock_return;
>>       do_gettimeofday(&timeafter);
>>       printk(KERN_INFO "read two single axis time: %ld",
>>              timeafter.tv_sec * 1000000 + timeafter.tv_usec -
>>              timebefore.tv_sec * 1000000 - timebefore.tv_usec);
>>
>>
>> And get this result:
>>
>> [  161.264777] read with dead axis time: 883
>> [  161.270621] read two single axis time: 1359
>> [  161.575134] read with dead axis time: 852
>> [  161.580973] read two single axis time: 1356
>> [  161.895704] read with dead axis time: 854
>> [  161.903744] read two single axis time: 3540
>> [  162.223600] read with dead axis time: 853
>> [  162.229451] read two single axis time: 1363
>> [  162.591227] read with dead axis time: 850
>> [  162.597630] read two single axis time: 1555
>> [  162.920102] read with dead axis time: 852
>> [  162.926467] read two single axis time: 1534
>> [  163.303121] read with dead axis time: 881
>> [  163.308997] read two single axis time: 1390
>> [  163.711004] read with dead axis time: 861
>>
>>
>> It seems like you're right! Reading consecutively 9 bytes does save a lot time
>> compared to read 3 bytes twice.
>>
> I've done this stuff before ;)  We had this on the adis16365 parts back
> in the early days of IIO.  A worse case as it has a lot more channels,
> but otherwise similar from what I recall.
>
> It would be an interesting exercise to trace those paths and find out the
> balance between real hardware stuff we can't change and potential software
> overheads.
>
> Chances are this is mostly 'real' stuff though but would be great to
> confirm this. It's been on my list of things to do for years (not on
> this driver obviously but in general)...
>
> Jonathan
>
I think I can try to use ftrace to trace it's flow path on my platform. I don't 
familiar with it, may need some time.

yours,

Song Qiang

