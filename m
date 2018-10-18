Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385A0C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2906208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQkmefHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2906208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeJRQYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:24:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35072 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeJRQYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:24:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so14538491pff.2;
        Thu, 18 Oct 2018 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ierBnNcOqwgF8btn3PEYVbXUGzFZZr4qNpa/uiO7pcA=;
        b=VQkmefHTQbvnwB7wTBcEoq6L1OmEoP0hV3OIUDw/VctK7GCl7HFZL8qdxiVa4hp3ue
         wbc5uyfhuETx6Up6fSJ+4e5Ot1eNGQSB87mgGhic3z0+AeQaSld7OOwrfnERnAP32lnX
         jTXJUgo8qcEDaZFltSDolpHPw6t7XP8jviicLZufqau1iixfGv6r92TpdUrDYwMutxPs
         hh4ibFuZHJmzYhVesx+cdfprCEeFSpdu+cCkPp2cPLGQ6MwlvRjNjPvIwYiwAnWAR7Y2
         Jdt3bZLI4q2kId+AzkBnosiaxrNPZ/dpnbZciv9PkV+NtPU4nUv9Xuee2HQb5bvXLGUt
         dQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ierBnNcOqwgF8btn3PEYVbXUGzFZZr4qNpa/uiO7pcA=;
        b=QCusVwflxrgBwRI71/wWjYdKMRQSSwfYReFvdje48jWIt1K4A6i9FBI9JLPrY72aex
         m2T+ks/Wcy6yaH2ddoia+va8cwvgTCptfkQEc8H8yw5B2tRZeT2yK2xUE2otZZF/eOyX
         41d3x8FaN6a03d3O7PX2jbrlIS5DBxyNH9zqy2BWA9QdfkHAoTWdR/a3dzdka9oW7c2X
         8WE8Rdft2NeK/GALVzwj3ZwCAJhOEZJ0QcP7Y2n/1wIZNdplzpYHRhwjXw5FF4zIbfUO
         9G4Tm7UmXeTfGT/sCkkgLP8j2GFL1vWVpraVVhVSVv8Pt/McTQw9WNv6RKiyKb9nbzCO
         k2qg==
X-Gm-Message-State: ABuFfoiXC1TutzQnLqLhQiVvGDND17mXn8yN/7SZCUcVdooNMbCyI3gz
        qJIRG+Dz4/I/09nLnm2yZ3JltMkoygs=
X-Google-Smtp-Source: ACcGV61309p0Jw3pDgFY7B3E/RrgbUl00iyASLGiJ4sGZ8mPJ4wRYHha7Klt0JD4ryBiWnlwf1LB9w==
X-Received: by 2002:a62:670a:: with SMTP id b10-v6mr29533487pfc.243.1539851059270;
        Thu, 18 Oct 2018 01:24:19 -0700 (PDT)
Received: from [0.0.0.0] (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id 126-v6sm26680152pfd.16.2018.10.18.01.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 01:24:18 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
 <20181012073536.20339-4-songqiang1304521@gmail.com>
 <20181013111935.00a2e1af@archlinux>
Message-ID: <e1715942-8fd8-152f-49c8-2a9e081d8a2a@gmail.com>
Date:   Thu, 18 Oct 2018 16:24:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181013111935.00a2e1af@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/10/13 下午6:19, Jonathan Cameron wrote:
> On Fri, 12 Oct 2018 15:35:36 +0800
> Song Qiang<songqiang1304521@gmail.com>  wrote:
>
>> PNI RM3100 is a high resolution, large signal immunity magnetometer,
>> composed of 3 single sensors and a processing chip with a MagI2C
>> interface.
>>
>> Following functions are available:
>>   - Single-shot measurement from
>>     /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
>>   - Triggerd buffer measurement.
>>   - DRDY pin for data ready trigger.
>>   - Both i2c and spi interface are supported.
>>   - Both interrupt and polling measurement is supported, depends on if
>>     the 'interrupts' in DT is declared.
>>
>> Signed-off-by: Song Qiang<songqiang1304521@gmail.com>
> A few questions for you (getting very close to being good to go btw!)
>
> Why do we have the 3second additional wait for conversions?  I know we
> rarely wait that long, but still seems excessive.
>
> Few more comments inline.
>
> Thanks,
>
> Jonathan

Hi Jonathan,


The measurement time of this device varies from 1.7ms to 13 seconds, 3 seconds 
is just a number in the middle between them. This may be worth discussing, 
hoping to get a better solution from the community.


>> ---
>>   MAINTAINERS                            |   7 +
>>   drivers/iio/magnetometer/Kconfig       |  29 ++
>>   drivers/iio/magnetometer/Makefile      |   4 +
>>   drivers/iio/magnetometer/rm3100-core.c | 627 +++++++++++++++++++++++++
>>   drivers/iio/magnetometer/rm3100-i2c.c  |  58 +++
>>   drivers/iio/magnetometer/rm3100-spi.c  |  64 +++
>>   drivers/iio/magnetometer/rm3100.h      |  17 +
>>   7 files changed, 806 insertions(+)
>>   create mode 100644 drivers/iio/magnetometer/rm3100-core.c
>>   create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
>>   create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
>>   create mode 100644 drivers/iio/magnetometer/rm3100.h
>>

...

>
>> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	unsigned long scan_mask = *indio_dev->active_scan_mask;
>> +	unsigned int mask_len = indio_dev->masklength;
>> +	struct rm3100_data *data = iio_priv(indio_dev);
>> +	struct regmap *regmap = data->regmap;
>> +	int ret, i, bit;
>> +
>> +	mutex_lock(&data->lock);
>> +	switch (scan_mask) {
>> +	case BIT(0) | BIT(1) | BIT(2):
>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
>> +		mutex_unlock(&data->lock);
>> +		if (ret < 0)
>> +			goto done;
>> +	break;
>> +	case BIT(0) | BIT(1):
>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
>> +		mutex_unlock(&data->lock);
>> +		if (ret < 0)
>> +			goto done;
>> +	break;
>> +	case BIT(1) | BIT(2):
>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
>> +		mutex_unlock(&data->lock);
>> +		if (ret < 0)
>> +			goto done;
>> +	break;
> What about BIT(0) | BIT(2)?
>
> Now you can do it like you have here and on that one corner case let the iio core
> demux code take care of it, but then you will need to provide available_scan_masks
> so the core knows it needs to handle this case.
>

This confused me a little. The available_scan_masks I was using is {BIT(0) | 
BIT(1) | BIT(2), 0x0}. Apparently in this version of patch I would like it to 
handle every circumstances like BIT(0), BIT(0) | BIT(2), BIT(1) | BIT(2), etc. 
Since Phil mentioned he would like this to reduce bus usage as much as we can 
and I want it, too, I think these three circumstances can be read consecutively 
while others can be read one axis at a time. So I plan to let  BIT(0) | BIT(2) 
fall into the 'default' section, which reads axis one by one.

My question is, since this handles every possible combination, do I still need 
to list every available scan masks in available_scan_masks?


All other problems will be fixed in the next patch.

yours,

Song Qiang


...
