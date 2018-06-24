Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217A8C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15A324E67
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yg1Herzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15A324E67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeFXJND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:13:03 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41693 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeFXJNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:13:01 -0400
Received: by mail-ot0-f196.google.com with SMTP id d19-v6so11972422oti.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SFb5mIT+2LP+61z6uT4iOfM7oBjkVouwUCHsK1R5nxY=;
        b=Yg1HerztQujuawP0JWxwgmxfSgzCbSJv9PLlxKrhIDAzS/vLV8XEIFMUj45o2lxiQ1
         WhdmkBWRJWc7WLEX7+r3UNMGXu4x0TuXMgQfBw9dshRKwbvCfqS1GpTX2wh/RsC1YW5i
         y6CkXJfN+ggAfXVBBUFs20cZdlRlMnhHSPRxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SFb5mIT+2LP+61z6uT4iOfM7oBjkVouwUCHsK1R5nxY=;
        b=otFA0NzQTPpyBN9jQhMJ/ZLXprLBNyoK6D0xAHQKwYuwP+VDONCFMCNwb1x9oHUsoD
         Jq4MplavHH5OlLhCgyP0vmlEcBSTtbz7Kxo/472apEPfcsekqWzzP+Xn3pwV0KCPaeHi
         8dFnuhpqI42Piclq3RWvMdT/MxzNU8ZlemKNBWHzGPJLinSZRkHd0DNOnukCgJ5ub/Jv
         WaVaWYBSKXzAh/HeJtnpie8KjM9aLEhjjoglKZ8ZIMdxc12EjgM6soL1GqsuAg+/9wKj
         rpj5J7v7vwwlbgD3CMI4qbRaKN73dvJXy5VqZ4Zxsa1L9eiphNoGAwgNF4czxnCi0d0U
         f40g==
X-Gm-Message-State: APt69E37xusw25F0BxojeHzPdgQla5bwA/EOaU1/qIuXOFx/D30Mk2hx
        moKL4SD0e9UyI3n285nqzZBEmf2ogriowaaSUtziHw==
X-Google-Smtp-Source: AAOMgpe3wx5wNeq0UPSceYet5jifyGLs8MibRhE4qfX6+Bjh2KDaz/MmTOBxpEI9KbYwCu2J8tLSenA4fNyq/WRDitc=
X-Received: by 2002:a9d:184:: with SMTP id e4-v6mr1831315ote.249.1529831580738;
 Sun, 24 Jun 2018 02:13:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d44:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 02:13:00
 -0700 (PDT)
In-Reply-To: <20180622151338.00003622@huawei.com>
References: <900586c7a4ce55818ab330c738f306c7452191ef.1529550463.git.baolin.wang@linaro.org>
 <95836d610301133ffdac1efa86d7daf4cecb97b7.1529550463.git.baolin.wang@linaro.org>
 <20180622151338.00003622@huawei.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Sun, 24 Jun 2018 17:13:00 +0800
Message-ID: <CAMz4kuJUeDjTVJqNc4cNv=LwR1HkuFap4vBF7CCcrxNqnTHa-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add Spreadtrum SC27XX PMICs ADC support
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@spreadtrum.com, Mark Brown <broonie@kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 22 June 2018 at 22:13, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> On Thu, 21 Jun 2018 11:14:05 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> From: Freeman Liu <freeman.liu@spreadtrum.com>
>>
>> The Spreadtrum SC27XX PMICs ADC controller contains 32 channels,
>> which is used to sample voltages with 12 bits conversion.
>>
>> [Baolin Wang did lots of improvements]
>>
>> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> One trivial missed bit of cleanup inline.  I'll sort that
> when applying if no one else points anything out before I get back to my
> development machine.

Thanks.

>> +
>> +     indio_dev->dev.parent = &pdev->dev;
>> +     indio_dev->name = dev_name(&pdev->dev);
>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>> +     indio_dev->info = &sc27xx_info;
>> +     indio_dev->channels = sc27xx_channels;
>> +     indio_dev->num_channels = ARRAY_SIZE(sc27xx_channels);
>> +     ret = devm_iio_device_register(&pdev->dev, indio_dev);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "could not register iio (ADC)");
>> +             return ret;
>> +     }
>> +
>> +     platform_set_drvdata(pdev, indio_dev);
>
> Why?  Looks like this is left over from when we had a remove.

Sorry, I missed to remove this redundant code.

-- 
Baolin Wang
Best Regards
