Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563FAC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B02223E3C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oLwn137z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B02223E3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeGDOj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:39:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43574 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeGDOj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:39:56 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w64EdraO085789;
        Wed, 4 Jul 2018 09:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530715193;
        bh=y3U4XokFCddUXFR24yjOmRkKqGXYQLI7E2wJkXgqbAE=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=oLwn137z5Y51WkP8X56Iv2DFoQlasuMFxMxgUbM3DOA8q4tp81yllB/bUjSMNndEd
         ZrzuqFQiRqrcd58qPf0c9VzwrX9o1TfLgHLmmjsYFybmZeOLYqXj7E6S71HUFggN3n
         HZmC9tLK5hwYO13i9LYggA71ZF2ENc4MIkpFMz0E=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w64Edrpx001196;
        Wed, 4 Jul 2018 09:39:53 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 4 Jul
 2018 09:39:53 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 4 Jul 2018 09:39:53 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w64EdoUe003497;
        Wed, 4 Jul 2018 09:39:51 -0500
From:   Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 4/5] iio: adc: ti_am335x_adc: Disable ADC during suspend
 unconditionally
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-5-vigneshr@ti.com> <20180630161848.1e72deea@archlinux>
Message-ID: <f639cd3f-ff67-c748-8768-cff05eb11305@ti.com>
Date:   Wed, 4 Jul 2018 20:10:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180630161848.1e72deea@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 30 June 2018 08:48 PM, Jonathan Cameron wrote:
> On Sat, 30 Jun 2018 16:03:17 +0530
> Vignesh R <vigneshr@ti.com> wrote:
> 
>> Parent MFD device takes care of enabling ADC interface whenever
>> touchscreen is marked wakeup capable. Therefore, unconditionally disable
>> ADC interface during system suspend to save power in case of system with
>> just ADC and no TSC.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> This sounds like a sensible change to me.   Is it applicable without the
> rest of the series?  If so I'll take it through IIO.  If the answer
> is that it needs to go with the rest then
> 

This patch as such does not have any compile time dependencies on other
patches, but I would like Dmitry's opinion on the series before being
merged.

> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thanks!


Regards
Vignesh

> Thanks,
> 
> Jonathan
>> ---
>>  drivers/iio/adc/ti_am335x_adc.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index 80df5a377d30..cafb1dcadc48 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -693,16 +693,12 @@ static int __maybe_unused tiadc_suspend(struct device *dev)
>>  {
>>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>> -	struct ti_tscadc_dev *tscadc_dev;
>>  	unsigned int idle;
>>  
>> -	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
>> -	if (!device_may_wakeup(tscadc_dev->dev)) {
>> -		idle = tiadc_readl(adc_dev, REG_CTRL);
>> -		idle &= ~(CNTRLREG_TSCSSENB);
>> -		tiadc_writel(adc_dev, REG_CTRL, (idle |
>> -				CNTRLREG_POWERDOWN));
>> -	}
>> +	idle = tiadc_readl(adc_dev, REG_CTRL);
>> +	idle &= ~(CNTRLREG_TSCSSENB);
>> +	tiadc_writel(adc_dev, REG_CTRL, (idle |
>> +			CNTRLREG_POWERDOWN));
>>  
>>  	return 0;
>>  }
> 

-- 
Regards
Vignesh
