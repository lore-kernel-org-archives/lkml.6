Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAE0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F2B20658
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf4ehSgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F2B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeJLQH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:07:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38577 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeJLQH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:07:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id q19-v6so2504995pll.5;
        Fri, 12 Oct 2018 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jnC+8fOcl5yP24zlpiSK3TjgaQ0sWXnITD/YcDf/Sxg=;
        b=nf4ehSgshakLXxPe8CvkPhMHxOJctUZcUfp9g2ejBbf4riStYQVSp2mqzodXjYKrdA
         pNgTTN23Ql9E97chsMA46mIQSS5ebw5jmM/9bm7VE+51LZLF26OTGxny4ADJ0I8Z8Rgf
         1rM/pIGi46fz7fhBS5hcrggJ1iue0j14zRvTZPhtNvHqUs9Ef2Wt+iEeyRvDoJ6Xt7Ka
         81HZNdpfxMn/6d5V/1W/XpLycNtCCq6uY4Z5Zo/pQf3Bf04/WIrfDhGrspQn/sHINeEU
         BqGqPdGbMM2MI3VZiWe68/kYHjamCwEYCsJ1U4CO7pCx5A5RhwLZ+4oZXHkGQ89xCLpe
         aKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jnC+8fOcl5yP24zlpiSK3TjgaQ0sWXnITD/YcDf/Sxg=;
        b=LYTB/awrZIHYv+i/IerDSadCoHURsv7Gee6iOHeVwv8OrHTNv7/xCVp3ceUzGLq92x
         dBPDxcxmrOa1sLJr9DD42i1nFNGDS4TPwvfnHiVslzSBRV3f7wLLQ7169ZamZ7S0YvPF
         h3DZgqYAqT38raI6O8ItmlazMDG209dqUUL+Nj5tK46snPGr7DpZu0TggincmErii7Vu
         wP/XkU+J2jl7n+WrwKo/uHiLPLZG/CLKNqxaRQfQW0AwI6k18RCPk6W/5+TumjQZ4gDq
         jsugFiwtCSTWeVdpSslEpawQQJJlBocSQL3eA79IbAig7K+AgkSGvLuqgjjBL3LR8rEC
         dTrQ==
X-Gm-Message-State: ABuFfoizBkPSp9TTcW7gSOvYUVHI5p9YIRv2c4P0e8ETKxDf9AI8x0hH
        9n4euv5eQwdIpfjYI1bTX3t5D477
X-Google-Smtp-Source: ACcGV63SkyYBUXJbP2VUVz+D080CrcwYXg3m0CgK7x4lHpQOC9fLXFLQk2PzBXdRZe4mu4gKXMBU4g==
X-Received: by 2002:a17:902:4225:: with SMTP id g34-v6mr5013310pld.161.1539333365549;
        Fri, 12 Oct 2018 01:36:05 -0700 (PDT)
Received: from [127.0.0.1] (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id d2-v6sm1379043pfj.122.2018.10.12.01.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 01:36:05 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
 <20181012073536.20339-4-songqiang1304521@gmail.com>
From:   Song Qiang <songqiang1304521@gmail.com>
Message-ID: <436097c6-b32b-42e4-e704-a15280e13cb0@gmail.com>
Date:   Fri, 12 Oct 2018 16:36:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012073536.20339-4-songqiang1304521@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年10月12日 15:35, Song Qiang wrote:
> PNI RM3100 is a high resolution, large signal immunity magnetometer,
> composed of 3 single sensors and a processing chip with a MagI2C
> interface.
>
...
> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	unsigned long scan_mask = *indio_dev->active_scan_mask;
> +	unsigned int mask_len = indio_dev->masklength;
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret, i, bit;
> +
> +	mutex_lock(&data->lock);
> +	switch (scan_mask) {
> +	case BIT(0) | BIT(1) | BIT(2):
> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			goto done;
> +	break;
> +	case BIT(0) | BIT(1):
> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			goto done;
> +	break;
> +	case BIT(1) | BIT(2):
> +		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			goto done;
> +	break;
Hi Jonathan,

I just noticed that these three breaks are not proper aligned.

yours,
Song Qiang
