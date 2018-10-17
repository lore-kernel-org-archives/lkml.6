Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D54ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEE321528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzMCdL8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEE321528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJQPyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:54:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43311 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:54:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id d8-v6so917157pgv.10;
        Wed, 17 Oct 2018 01:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mCvlGy8CA9/62CQ/b+OrKENmTK7WbZSo1J2CmB9SFRw=;
        b=WzMCdL8TU2gvc4MY5YVt7UwKNdxNRHx1gYQl6DJXKtg2WMlH0zRrmwQ0fW9VtSWGoA
         hnZZ+fBqda86Kch147B+oZeD5TiaQxIwwNcayMiUKZY6YBaXT+2+kNnXWhxu5Uvp1fGr
         lE4Kqw5qUj9PD2kxuaHcbUgfYDgOvtH3FnJy7vGVJXyxgfCgetl92InCzPwOtQM7t7Ot
         u0gXGHyAZ99MvvqEOzXOdOo6bDZKT5OaMc5BHKDRmEkLInwVLfNS3qybcme/2rlJ5tJY
         RPw7YrBDmq0wC46DadveFUnzjIIoOF4plrrzEUToUEPuiHRmxJm/XfP74F9NnL4NIdZM
         5QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mCvlGy8CA9/62CQ/b+OrKENmTK7WbZSo1J2CmB9SFRw=;
        b=fTryEM1xE8lA7SX2LtHWIYaIqYENNDyAQvLAN0vW/rCh/WXrZI/n9CNc78AYuEVyhV
         yq9VAYL7pGkl0G36bHZha+IuHp1EcF4pH9HfwQBoGoXeu+XXPzVxUcn82BZSKoXrysxf
         hdwCDvLf/wSSkKQ40MGrP6VYaAJHdlNhdkH23v9Z9QyKaViW/L3lVI2o/q3ui0kRYUBQ
         SbCLbJIXqtXkFduEEkZ6Q/tY0Q2TK2t4bm8CVA1h33O0GlRYN7rbOrlUvOaTSTGsM+Nt
         wibRkmPbXD9QwPODgJSzsfRlNjJQ6M2oRj9vICALuR1jAh1U6dghEbgIGs7mSAlBCQb4
         jwWg==
X-Gm-Message-State: ABuFfoj7dqt9rqFz+k2vui7/r2/bywd4/SVYe/CnS8A6/F+E22qqfwYi
        KHHM+BsLYfbmb66UUScVG3uOJ2ulD78=
X-Google-Smtp-Source: ACcGV63wV5YU5emVPPokaMzcgPDNpZblPSbi87N8LWi/vPtSkWrQ8jJk2cFJ6bwmHb41gwUgJOmN2A==
X-Received: by 2002:a62:fc13:: with SMTP id e19-v6mr25755261pfh.101.1539763206763;
        Wed, 17 Oct 2018 01:00:06 -0700 (PDT)
Received: from [0.0.0.0] (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id u77-v6sm28576890pfj.40.2018.10.17.01.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 01:00:06 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
 <20181012073536.20339-4-songqiang1304521@gmail.com>
 <436097c6-b32b-42e4-e704-a15280e13cb0@gmail.com>
 <20181012125316.GA6480@himanshu-Vostro-3559>
From:   Song Qiang <songqiang1304521@gmail.com>
Message-ID: <ce65b203-2a44-08e4-bdd0-f3c8df48e2f1@gmail.com>
Date:   Wed, 17 Oct 2018 16:00:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181012125316.GA6480@himanshu-Vostro-3559>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/10/12 下午8:53, Himanshu Jha wrote:
> Hi Qiang,
>
> On Fri, Oct 12, 2018 at 04:36:01PM +0800, Song Qiang wrote:
>>
>> On 2018年10月12日 15:35, Song Qiang wrote:
>>> PNI RM3100 is a high resolution, large signal immunity magnetometer,
>>> composed of 3 single sensors and a processing chip with a MagI2C
>>> interface.
>>>
>> ...
>>> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>>> +{
>>> +	struct iio_poll_func *pf = p;
>>> +	struct iio_dev *indio_dev = pf->indio_dev;
>>> +	unsigned long scan_mask = *indio_dev->active_scan_mask;
>>> +	unsigned int mask_len = indio_dev->masklength;
>>> +	struct rm3100_data *data = iio_priv(indio_dev);
>>> +	struct regmap *regmap = data->regmap;
>>> +	int ret, i, bit;
>>> +
>>> +	mutex_lock(&data->lock);
>>> +	switch (scan_mask) {
>>> +	case BIT(0) | BIT(1) | BIT(2):
>>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
>>> +		mutex_unlock(&data->lock);
>>> +		if (ret < 0)
>>> +			goto done;
>>> +	break;
>>> +	case BIT(0) | BIT(1):
>>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
>>> +		mutex_unlock(&data->lock);
>>> +		if (ret < 0)
>>> +			goto done;
>>> +	break;
>>> +	case BIT(1) | BIT(2):
>>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
>>> +		mutex_unlock(&data->lock);
>>> +		if (ret < 0)
>>> +			goto done;
>>> +	break;
>> Hi Jonathan,
>>
>> I just noticed that these three breaks are not proper aligned.
> Please send the new version of a patch as a *new* thread and don't
> use `--in-reply-to` flag(if you're using) to chain into older versions
> as whole thread of older discussion comes up and is often not required.
>
> The changelog gives enough info of what's new in the revised series.
>
>
Hi Himanshu,


Thanks for your advise.

I did it because the following instruction tells me to, and I think it's 
also a very quick way of gathering

all scattered messages. Both ways have their own advantages and 
disadvantages I think. :)

<https://kernelnewbies.org/PatchPhilosophy> Section "Updating and 
resending patches".


yours,

Song Qiang

