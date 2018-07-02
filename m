Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE47C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E0725E06
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fa4cV6jJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E0725E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbeGBOBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:01:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40207 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbeGBOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:01:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so8860443wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gUk12uFVlH6kT3vbjXNXaOLEs5r7yvt5c48UojvJ30g=;
        b=fa4cV6jJIKPT6r9KWNYOPKlHMfOcyiWqmJBY6ni3yEuvoSUKvaf/8lWbmVx7DrroaI
         F3nzOaCRiGN2RQpLlTzRslIMKah8ivFgS2xOSpWjX+KXaTsNGz9zGbGX2R1DSSdwWVPU
         NUgzlZWsVhZuGEenZSz6x5NoMrvBiFd4YnED8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gUk12uFVlH6kT3vbjXNXaOLEs5r7yvt5c48UojvJ30g=;
        b=DbX9LuMSTkPrZwxR7oXHBGqwch/FXceVYf4tASFfz8WY1vYZKsdN6RVCIFxtPo/5EM
         jELNVmEOTjYRLIwMO45gy7GlGOPh1XokbmU3DmfqhU4pIEhDLrOe1F1inOaxY2X7zbno
         uE7pX0cObLO8pp3AuSIluU8YBSivsVsCzx0Ob5SeZhd0ERd3StxdAS5xeyV0e+cpjl+A
         +rZGO/FDthm7utKJqZ7sexPse4SJQO79X1h8tuBvrQ2AKaypRvIeew9zQbWO5+4IFfnV
         NnbLczvUqZB4u2NpRyMhxCRYLZNkx37ZmL/GlqfJbSlZdvr0U8S7qzhJSntUptXI13xa
         hS7Q==
X-Gm-Message-State: APt69E3Mv+6A9R+8eQl3gqrkuav7S31Y5SEFUd9tBdmMdK6mYnqPh/zT
        LkBacqZxaHEHbw27t9aiGOve+A==
X-Google-Smtp-Source: AAOMgpdwCF6OgMbPVjIqT7bvv8lxvIlNJoaga4aqRRtLvyUWz/QZDmgPA5/mW/IkBhCyZHIwtP8DrQ==
X-Received: by 2002:a1c:903:: with SMTP id 3-v6mr8462607wmj.130.1530540079626;
        Mon, 02 Jul 2018 07:01:19 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id z14-v6sm6602971wma.11.2018.07.02.07.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:01:19 -0700 (PDT)
Subject: Re: [PATCH v4 11/27] venus: core,helpers: add two more clocks found
 in Venus 4xx
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org,
        Tomasz Figa <tfiga@chromium.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
 <20180627152725.9783-12-stanimir.varbanov@linaro.org>
 <CAPBb6MVToYzWhmbjU-M6g2CjwMzWyF97k2WqcUBFA+zTq6uhdg@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <e5b99cec-6401-32ee-57d2-7feafaaa5a11@linaro.org>
Date:   Mon, 2 Jul 2018 17:01:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPBb6MVToYzWhmbjU-M6g2CjwMzWyF97k2WqcUBFA+zTq6uhdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks for the review!

On 07/02/2018 11:45 AM, Alexandre Courbot wrote:
> On Thu, Jun 28, 2018 at 12:34 AM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Add two more clocks for Venus 4xx in core structure and create
>> a new power enable function to handle it for 3xx/4xx versions.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/core.h    |  4 +++
>>  drivers/media/platform/qcom/venus/helpers.c | 51 +++++++++++++++++++++++++++++
>>  drivers/media/platform/qcom/venus/helpers.h |  2 ++
>>  drivers/media/platform/qcom/venus/vdec.c    | 44 ++++++++++++++++++++-----
>>  drivers/media/platform/qcom/venus/venc.c    | 44 ++++++++++++++++++++-----
>>  5 files changed, 129 insertions(+), 16 deletions(-)
>>

<snip>

>> @@ -1131,15 +1137,21 @@ static int vdec_remove(struct platform_device *pdev)
>>  static __maybe_unused int vdec_runtime_suspend(struct device *dev)
>>  {
>>         struct venus_core *core = dev_get_drvdata(dev);
>> +       int ret;
>>
>> -       if (core->res->hfi_version == HFI_VERSION_1XX)
>> +       if (IS_V1(core))
>>                 return 0;
>>
>> -       writel(0, core->base + WRAPPER_VDEC_VCODEC_POWER_CONTROL);
>> +       ret = venus_helper_power_enable(core, VIDC_SESSION_TYPE_DEC, true);
>> +
>> +       if (IS_V4(core))
>> +               clk_disable_unprepare(core->core0_bus_clk);
>> +
>>         clk_disable_unprepare(core->core0_clk);
>> -       writel(1, core->base + WRAPPER_VDEC_VCODEC_POWER_CONTROL);
>>
>> -       return 0;
>> +       ret |= venus_helper_power_enable(core, VIDC_SESSION_TYPE_DEC, false);
> 
> Is it safe to OR two potentially different error messages, at the risk
> of getting a third one that is different?

venus_helper_power_enable can return zero or ETIMEDOUT, but ...

> 
> If venus_helper_power_enable() fails, shouldn't we just exit early and
> signify that the suspend operation failed?
> 

I had the same comment from Tomasz, hence maybe I'm wrong :) so I will
re-work that and will exit early if error.

-- 
regards,
Stan
