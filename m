Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C716BC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9391A20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MF08K1N/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfA3Hog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:44:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43987 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfA3Hof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:44:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so24842978wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 23:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X4QCf+1aoDy366tLdrMDAEPagCHQZQgMBcUSlcgghUw=;
        b=MF08K1N/yysxuch0gDLytcVb4nyipvQoeLO0UEoO7ZgkE6iICkQlj1PVmsYMRRKISh
         4u7NMtuiJAX05C+FeNzFdu5NtQEICje2nF3CeBqE0Qjoc/YPNJ2ssbb52oPp/M8vkPGl
         yeo9NwGD6DwCo1MB/+kD27xOEbQ1yNSmt6gjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X4QCf+1aoDy366tLdrMDAEPagCHQZQgMBcUSlcgghUw=;
        b=jY8aaZpYxypFMzl85G2iLZIAydkeRvY2KLix+a9DOG5JI6U0RxA9WP+XJLd4qjdtJV
         auKU7oSJhkoUpLEOsVVbvjdIufgb5d80I7Ofpmw+erCICzSJubQBAYwJN9U/JNNE95Xz
         Jmz9Rr/sSdQxrBmNQ2H6MohiaRqjVeds+P+WoMMuro6i1DSQDAsAhvCtnpywVgJc3nI1
         yno3b8ddVdh8f7NT1ZyuiFBEWW8L96Oir4pIDgRlDHQLNFsRU6Cu2KethJ4TiP0Gwpu3
         LJs8E40a4J0TW3L8rmNMTz18MukWxLoCbqumCQkupReMizTPXzOFTNGgk83ne74k8m1y
         pO8g==
X-Gm-Message-State: AHQUAuYHS2MDNl+WdG6mtN9/jRTpxPUTiHpU0ZwWvBV99l/l8mRoW++A
        7igAhRDT2WNcqzcSUamTVNLU2w==
X-Google-Smtp-Source: AHgI3Iakylj+iVzhLALJzuTReayxq9BWnMAXiIZ+C1YZnsmExAcA9nwkLX8acKZQ1Wwxx3AybZ6iVw==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr7013843wru.245.1548834273590;
        Tue, 29 Jan 2019 23:44:33 -0800 (PST)
Received: from [192.168.0.41] (164.30.95.92.rev.sfr.net. [92.95.30.164])
        by smtp.googlemail.com with ESMTPSA id f191sm1034950wmg.12.2019.01.29.23.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 23:44:32 -0800 (PST)
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
To:     Peter Shih <pihsun@chromium.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michael.Kao@mediatek.com
References: <20190109055724.184692-1-pihsun@chromium.org>
 <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
Date:   Wed, 30 Jan 2019 08:44:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2019 07:04, Peter Shih wrote:
> Adding Michael Kao to cc list.
> 
> On Wed, Jan 9, 2019 at 1:57 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>>
>> The mtk_thermal struct contains a 'struct mtk_thermal_bank banks[];',
>> but the allocation only allocates sizeof(struct mtk_thermal) bytes,
>> which cause out of bound access with the ->banks[] member. Change it to
>> a fixed size array instead.

Even if the fix is correct, it pushes back the bug later in time if a
new board containing more than MAX_NUM_ZONES is introduced. I suggest to
dynamically allocate the array with the 'num_banks' value.


>> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
>> ---
>>  drivers/thermal/mtk_thermal.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
>> index 0691f260f6eabe..ea11edb3fcced6 100644
>> --- a/drivers/thermal/mtk_thermal.c
>> +++ b/drivers/thermal/mtk_thermal.c
>> @@ -159,6 +159,9 @@
>>  #define MT7622_NUM_SENSORS_PER_ZONE    1
>>  #define MT7622_TS1     0
>>
>> +/* The maximum number of banks */
>> +#define MAX_NUM_ZONES          8
>> +
>>  struct mtk_thermal;
>>
>>  struct thermal_bank_cfg {
>> @@ -178,7 +181,7 @@ struct mtk_thermal_data {
>>         const int *sensor_mux_values;
>>         const int *msr;
>>         const int *adcpnp;
>> -       struct thermal_bank_cfg bank_data[];
>> +       struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>>  };
>>
>>  struct mtk_thermal {
>> @@ -197,7 +200,7 @@ struct mtk_thermal {
>>         s32 vts[MT8173_NUM_SENSORS];
>>
>>         const struct mtk_thermal_data *conf;
>> -       struct mtk_thermal_bank banks[];
>> +       struct mtk_thermal_bank banks[MAX_NUM_ZONES];
>>  };
>>
>>  /* MT8173 thermal sensor data */
>> --
>> 2.20.1.97.g81188d93c3-goog
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

