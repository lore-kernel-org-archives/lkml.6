Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F84FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC5820870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWfkcSRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfAWKLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:11:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33099 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfAWKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:11:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so10579062wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nLxiScRLz8cH+iZJUgz9qXGBFW+9ruCNo8cZDSC9voE=;
        b=gWfkcSRIrQTV+vso+6ZVS9/q15+zO7PuEXlFIxqzhlCi91q4m36rmLz1gEJFeKTORk
         RvVp0JRO/1ujWt8is1KlVq0nzUVltUcfpEb4EQFxE1mM9+EvYHfJVUjrj9E66TffeqGF
         wIM3hmMNapCr2l1S986LrvurLImwzHQSnEcuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nLxiScRLz8cH+iZJUgz9qXGBFW+9ruCNo8cZDSC9voE=;
        b=GsJFizis7nsUsNXqjvQtkl67UFhr0QpQDuw3rn3qrjwLfXBCFiOoGIZ4VPZLi6dfw8
         Q9Pb9uLZhptoBpcKiL3CaVZTQS9bob8cBeMl0bhrTZf4GBDZdkf7YVEIU24J6nXRsLeG
         HMpSbncmJD4Wilj/0rrfuB07XuvvR6eK4V1y/LOsPpeKuhqZsN9Mm88Sy1Dn1DuCJrJU
         QbM5iGmERi+qqmsF94Qiejxf3cU/PtNKpuLXCaLmzTKzZJBF8eFGkJy2sPlbtja50xu+
         TiLtHiFLR/b66qYf1UUc+lmeoc7SWeZ6Q0NiPUzKmyKjASNbuGsv9UzHkEbNzJ9TiiBM
         Sahg==
X-Gm-Message-State: AJcUukfDYVxWHtsDIJDiGBeEgcgih8liOcfnSY7vMNwGSKMlWSte07oz
        awqokESYdTVW/V1BRfjnoBbLFw==
X-Google-Smtp-Source: ALg8bN71KprpqdHRbc9vj3B7gdecOnBVk2X+/A6rLlaRLURXjT4qx6Wrout2pV3wedJy9jQnj40G0g==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr1981212wmh.12.1548238303425;
        Wed, 23 Jan 2019 02:11:43 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id i192sm60603836wmg.7.2019.01.23.02.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:11:42 -0800 (PST)
Subject: Re: [PATCH v5 2/8] ASoC: wcd9335: add support to wcd9335 codec
To:     Mark Brown <broonie@kernel.org>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
 <20190110150616.2332-3-srinivas.kandagatla@linaro.org>
 <20190122184146.GF7579@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4e09bbcb-2258-9a41-eca6-19c6a9dea97b@linaro.org>
Date:   Wed, 23 Jan 2019 10:11:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122184146.GF7579@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 22/01/2019 18:41, Mark Brown wrote:
> On Thu, Jan 10, 2019 at 03:06:10PM +0000, Srinivas Kandagatla wrote:
> 
> This all looks good apart from a couple of small things that should be
> easy to fix:
> 
>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>> index 62bdb7e333b8..1c4904940621 100644
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -1100,6 +1100,12 @@ config SND_SOC_UDA1380
>>           tristate
>>   	depends on I2C
>>   
>> +config SND_SOC_WCD9335
>> +	tristate "WCD9335 Codec"
>> +	depends on SLIMBUS
>> +	select REGMAP_SLIMBUS
>> +        tristate
>> +
>>   config SND_SOC_WL1273
>>   	tristate
>>   
> 
> You should add this to SND_SOC_ALL_CODECS.
Sure, I will add this in next version.
> 
>> +static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
>> +{
>> +	struct wcd9335_codec *wcd = data;
>> +	unsigned long status = 0;
>> +	int i, j, port_id;
>> +	unsigned int val, int_val = 0;
>> +	bool tx;
>> +	unsigned short reg = 0;
>> +
>> +	for (i = WCD9335_SLIM_PGD_PORT_INT_STATUS_RX_0, j = 0;
>> +	     i <= WCD9335_SLIM_PGD_PORT_INT_STATUS_TX_1; i++, j++) {
>> +		regmap_read(wcd->if_regmap, i, &val);
>> +		status |= ((u32)val << (8 * j));
>> +	}
>> +
>> +	for_each_set_bit(j, &status, 32) {
>> +		tx = (j >= 16 ? true : false);
>> +		port_id = (tx ? j - 16 : j);
> 
> ...
> 
>> +	return IRQ_HANDLED;
>> +}
> 
> This will report that it handled the interrupt unconditionally, this
> means that if the interrupt fires in error or there's some bug the
> interrupt will never be acknowledged (it looks like the chip requires
> acks?) but the interrupt core won't be able to notice and handle the
> problem as effectively as it could've done.  It's better to report
> IRQ_NONE if nothing as handled so that the core can do error handling.
I agree, Will fix this in next version!

thanks,
srini
> 
