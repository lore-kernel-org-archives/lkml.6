Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0720C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B412077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9mu3Ea4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B412077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeHaQIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:08:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46902 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaQIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:08:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so10943226wrc.13;
        Fri, 31 Aug 2018 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MI3c9Zjxiz7+dIG4vNNVGe/6nlppwW0Vol6m0g37leE=;
        b=t9mu3Ea4U+0R1CYh0Ugw9jKvBcPjWwJcobT8nF0yitQa9n5smMo0Fs0TLzL2pwtiZq
         voVtHvoEfS03k457VqkjfZzKjNZAgIbvWN2Kefe1r5jopXFbCbPpOuJkP9pS1sZBGE2N
         Rq0f0vX2Vbn/2RuAoVm/fsUGJ9EHkkCijIO5LfQQO7qfviMyrlk46gBZVu4vFJ01y/so
         a1hrlTVArH7vTCUGb+9ZGNZhcssZzI1Z/KhLthVbesbqDNCXb/7cA49Z4P8cyzFn+Bcq
         kOayc/69hXipl7eAXDVFdvKeT5GjHtaPAo8EIed0DWP/Kn9xEE8uYnfO8uiz9t/1Chxb
         Trsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MI3c9Zjxiz7+dIG4vNNVGe/6nlppwW0Vol6m0g37leE=;
        b=OW45u/gBJMmeBJYIpxcEXQny6X3trax3HaN4GJhdxyN1j3+XKV2AEsOZpLH6hCOlzC
         csU5KdEDgixNNHmxqsqC3x23Nd9UDCBPisWtRGdukbpm/xepVXVgQrnEmSpYEZVqFCHe
         ahOpVAIe4Zd5/TWVhEOb+Nf5b1LffbjoKXsLaXOO7OZYGWVXFxBVe3zl8F9OLrnzg5GZ
         6uBuXTNMtC4cvhMW9u/8mckjjjq63EYSZDwDOUNjd6/jZz3nYubSi4ixI2fjLKX2ED+d
         L1iw77aDlkhqE/XCjVq+uCBE9g+EKDlLFbQlE0ekJmiNZDLjijzgqbkvREiLG/yPWu7G
         ybaw==
X-Gm-Message-State: APzg51Cs9g9vl+rH+2y44KB+GvUFFANrpyQavDZjJM2TE8sRy6OFuGVl
        Til4QcL0Gtm66gsO2m3Zi2g=
X-Google-Smtp-Source: ANB0VdY3g3FYg/PKdiLKhA+dyfzKhFe2/MitGCSYQ/Gh2NeaW2HMXuFWAvu/SStG0rv491JU69BN2w==
X-Received: by 2002:adf:e44e:: with SMTP id t14-v6mr10422978wrm.96.1535716871293;
        Fri, 31 Aug 2018 05:01:11 -0700 (PDT)
Received: from [134.60.170.20] (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id g126-v6sm4621605wmg.5.2018.08.31.05.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 05:01:10 -0700 (PDT)
Subject: Re: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
 <20180831091137.wkbbipssyd6mqfbt@flea>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <b834bc83-e3fa-511b-7c29-bd3a9af01d5b@gmail.com>
Date:   Fri, 31 Aug 2018 14:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831091137.wkbbipssyd6mqfbt@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.2018 11:11, Maxime Ripard wrote:
>> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL0,
>> +			SUN4I_GPADC_CTRL0_T_ACQ(0xff));
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
>> +			SUN8I_H3_THS_ACQ1(0x3f));
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
>> +			SUN8I_H3_THS_INTS_TDATA_IRQ_0);
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_FILTER,
>> +			SUN4I_GPADC_CTRL3_FILTER_EN |
>> +			SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2));
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC,
>> +			SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
>> +			SUN8I_H3_THS_TEMP_PERIOD(0x55));
>> +
>> +	regmap_read(info->regmap, SUN8I_H3_THS_CTRL2, &value);
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
>> +			SUN8I_H3_THS_TEMP_SENSE_EN0 | value);
> Ideally, all these values should have a comment explaining what they
> are.
> 
> And we really start to have a lot of registers defines. We'd be better
> off using regmap_fields.

I will rework this in the next version.

Thanks,
Philipp
