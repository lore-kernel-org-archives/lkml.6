Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEFBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B600120866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSGH1YeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B600120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeKLAtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:49:08 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35322 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbeKLAtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:49:08 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so2651264lfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 07:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qAkZBofw5H1C8HzfEHSsBJfso/xMo+VN2B/NBJcBaaQ=;
        b=WSGH1YeTiGFmDbCRwakmHKatuN3aS1Tgy9KsSqYqETfHTceA1XxMBeCwxgqnzTI34h
         klRquBqmB7bsyVQorKxo/M83eW2dfzFTfmn/eIHT2xHl0Lt1NOxnPKtNRbkqCE/58SQk
         cXEwyFHr0r0f7zw5zs8qyBz4tX/O4sMmDUH2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qAkZBofw5H1C8HzfEHSsBJfso/xMo+VN2B/NBJcBaaQ=;
        b=IQxGSfAEfpRD6LmDQVpTHHGnn75tEvehYZU5RDvonHLE1XcpFr3+lLkz0wDLS1oegN
         vyDntxpkL7qSdXJwBwj9qXAF4eUlqqTJqrmwl6jru90qMZu4c9VDrgQuOaOYtbQM1NUv
         rUQUBy2CAWJhKlwHEx5S8MYnHsAHC5J2dt3LJuPdZcEb7c3rqoCuJAXo5FVAOH7PZOt+
         BtVs5XYjmUaVATx6QAMQbF9EPDP4wrdMWhcTXExxKqh1DS7Qruo2pajJrLk37eA7VeE5
         /3UBJ6MYQWqlEeLx5xt2tuQeTFnDxFY60x6mAxz5EYGpEpNeLcCbPwIg16tjkpfmcB7e
         vx8Q==
X-Gm-Message-State: AGRZ1gJ8CFKYoU3uLDt0SSOFebnVnMw45zkejveeaAfXurPKuVT4qoFk
        oasTPlDGLBwDUB6Fa+8l0wCmbAaygkNF/l1SHMedPw==
X-Google-Smtp-Source: AJdET5fIsZ2QumPhRUQeG8gVOWxs3c2AFvyQSn1rhXa47mryR873Iar2QXLJKsiQCqaCszMl3smizsjpet/rhsSQ2/M=
X-Received: by 2002:a19:ca51:: with SMTP id h17mr8835126lfj.126.1541948419254;
 Sun, 11 Nov 2018 07:00:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:95ca:0:0:0:0:0 with HTTP; Sun, 11 Nov 2018 07:00:18
 -0800 (PST)
In-Reply-To: <20181111124044.52f61897@archlinux>
References: <208f9043fbd9b14b7a0c2743f68fa424388f5dcd.1541733478.git.baolin.wang@linaro.org>
 <20181111124044.52f61897@archlinux>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Sun, 11 Nov 2018 23:00:18 +0800
Message-ID: <CAMz4kuJoJAEq1uGvwnnkbQDi8SqS+kWfpgjtmcNoutfgJDwQaw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: sc27xx: Add ADC data conversion timeout
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@unisoc.com, Mark Brown <broonie@kernel.org>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 11 November 2018 at 20:40, Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri,  9 Nov 2018 11:25:31 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> From: Freeman Liu <freeman.liu@unisoc.com>
>>
>> Sometimes the ADC controller met some problems, and it will not complete
>> the data conversion, that will can not wake up the read process any more
>> to block users. So we should add one maximum conversion time to avoid
>> this issue.
>>
>> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Hi.
>
> Patch looks good, but sounds like this is a fix so could I have a fixes
> tag and a patch title that makes that clear?
>
> I think we will want this one back ported to stable by the sound of it.
>
> If it is just a theoretical issue then perhaps we don't need to bother.

Thanks for your review. This patch is not one bug fix, just make the
code more robust in case of some bad cases. So I think we do not need
the stable tag.

>
> Thanks,
>
> Jonathan
>
>> ---
>>  drivers/iio/adc/sc27xx_adc.c |   12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
>> index 7940b23..f7f7a189 100644
>> --- a/drivers/iio/adc/sc27xx_adc.c
>> +++ b/drivers/iio/adc/sc27xx_adc.c
>> @@ -52,6 +52,9 @@
>>  /* Timeout (ms) for the trylock of hardware spinlocks */
>>  #define SC27XX_ADC_HWLOCK_TIMEOUT    5000
>>
>> +/* Timeout (ms) for ADC data conversion according to ADC datasheet */
>> +#define SC27XX_ADC_RDY_TIMEOUT               100
>> +
>>  /* Maximum ADC channel number */
>>  #define SC27XX_ADC_CHANNEL_MAX               32
>>
>> @@ -223,7 +226,14 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>>       if (ret)
>>               goto disable_adc;
>>
>> -     wait_for_completion(&data->completion);
>> +     ret = wait_for_completion_timeout(&data->completion,
>> +                             msecs_to_jiffies(SC27XX_ADC_RDY_TIMEOUT));
>> +     if (!ret) {
>> +             dev_err(data->dev, "read ADC data timeout\n");
>> +             ret = -ETIMEDOUT;
>> +     } else {
>> +             ret = 0;
>> +     }
>>
>>  disable_adc:
>>       regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
>



-- 
Baolin Wang
Best Regards
