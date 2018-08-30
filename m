Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E19C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B447F205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXreErcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B447F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeHaAvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:51:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51013 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaAvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:51:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so3233312wmc.0;
        Thu, 30 Aug 2018 13:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mRiDOgmOGX7HWwaBkYd3ttcY/QxJNCT7YyW2QTOiM9U=;
        b=iXreErcB0ViPk+waUuavt2vhjJnegQwZcs05ZEe6jCupLNIjWgq878BnD+xWn2eyoK
         wh2yV+p7yPkpuEWXeBl0sCgnvSmiAGNUCiBhTWdXUiu+Oe7MK3JenmifM3MqkP1vWN0b
         aj3Q7lom2DyBAePNokhOAXy1n5sPxORXcH3x0BH4XexKE2Qoo0VlE5hMLH3MEs8pfjm6
         0p5550m/CdycPoIPN18vgebcYJHJO4II9YwJOp/FI82WiPi6BTruQqTGW0+AaH4MZUlD
         eTeeWcX/25k2RUpFJyhecowjZFskmUbMrKntHlRICgHtcdqj18h/LYTxc9RBIOqBW8su
         vB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mRiDOgmOGX7HWwaBkYd3ttcY/QxJNCT7YyW2QTOiM9U=;
        b=TwOUk4oHPo/x9dsoEhg7YtZi93sByeyXH1RinKdWxwrzE1Og4b/qwyWnQAc2DY3liv
         TqV287JmgsrJTcFEU4xNPskwcPM3zp2z0RFQH7T9BVXusE4T0q+YafM2yhFNME9OmiK+
         xMoqmdlvVBI8K6DclU1sY/Q5MdK/e/KeQsyOEL/LKBYojOhR7EBuskWN19WABsym2MlI
         hMGSG5Wds14vL4Y0ft/CtvAHT6sGSuzMehbBZ7hSZQgQknaflO0XekQU/bY5KkinjHl0
         WVBc8RH7hdmdQfK8980evh8YVGmQMF7QKSKN0JzyxFAzFzXH4SUOoASdE9B/fQdx/WYT
         EANw==
X-Gm-Message-State: APzg51CuV0KHkAOTfCBR25UAxV/yhrNZOAxlEKDlc/3Ss8ZWPkr7EFQG
        RUyzZnJDeBqznvGVfJ6ieRY=
X-Google-Smtp-Source: ANB0VdaE9yA+BJx8rcWaJxTWLegZ2FkrdnxuoreK8LmBdhR2o38VLV2CnOpyqZlKyHBkRfZwyuoFPA==
X-Received: by 2002:a1c:357:: with SMTP id 84-v6mr2803513wmd.8.1535662021757;
        Thu, 30 Aug 2018 13:47:01 -0700 (PDT)
Received: from [192.168.2.67] (p578F0EE7.dip0.t-ipconnect.de. [87.143.14.231])
        by smtp.gmail.com with ESMTPSA id y206-v6sm3505035wmg.14.2018.08.30.13.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:47:01 -0700 (PDT)
Subject: Re: [linux-sunxi] [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add
 support for H3 thermal sensor
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
 <20180830162734.uq65l6ox6uwrmulo@core>
 <e919cbdd-a874-4b46-a505-9412d093f54a@gmail.com>
Message-ID: <858dbcce-027a-5f48-ce66-06c79b6eeadd@gmail.com>
Date:   Thu, 30 Aug 2018 22:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e919cbdd-a874-4b46-a505-9412d093f54a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.08.2018 22:00, Philipp Rossak wrote:
> On 30.08.2018 18:27, Ondřej Jirman wrote:
>>> +static int sun8i_h3_calibrate(struct sun4i_gpadc_iio *info)
>>> +{
>>> +//    regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
>>> +//            info->calibration_data[0]);
>>> +//    regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
>>> +//            info->calibration_data[1]);
>> This should probably be implemented, or left out completely.
>>
>> regards,
>>    o.
>>
> Thanks you are right!
> This should be implemented! I will fix this in the next version!
> 
> Thanks,
> Philipp

I just realized this function need to check if calibration datas are 
available. Writing zeros to the calibration data regs "breaks" the 
thermal sensor.

Philipp
