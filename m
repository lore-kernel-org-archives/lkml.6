Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8481EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357B1214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9X/6dve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357B1214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbeHBL6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:58:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37639 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeHBL57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:57:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so1514215wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ghi7V3ERNuLGa1e9TrHejalfFqlbpni4xRQdCdxjmcM=;
        b=M9X/6dve4qbiV47Ggbr0Znvgq5rgFFMOaZEKfpFHrkX5x0LwHGvdlav99Y1vaCdN1+
         tqDpOhsGzn04p8eco2zMRaeTGoEgpB/HwVbz3YduAmpIp1RxqmbrxpDTX5iwZkpWML3L
         CAZknanl0t7VAPVDaPY7AL6ovQyHahXXI3dzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ghi7V3ERNuLGa1e9TrHejalfFqlbpni4xRQdCdxjmcM=;
        b=UsulF7fVWRsNu1hznFcPwsIv6/XKTzOeFz7aKFTpyKXc6Yf1W0x1cysMG7lNHg0wpT
         gsLftmCQyjF2/KvhrmJUrnfU8H4No0YnyLxQ6soopLQ/QA9awhjxBHaZTCQvRQr/4gaE
         O6keKtQ0gORPgfK3V9AEqgBxK1/agweFYf4fiNNyCUdyNzRm9+wBKc5UmnXTfFH9np/y
         v+g1TDRTbrocsphMP9DyCEAlI/yydgJ/ICu8F050dJXFMPtlamlmmaEhISePXJwzG4WD
         +HQzHiLP0b5Ufdbw7hOtsYij4sdMXlSoWWQTlZ7adZvQfBZB8inzvvbTi+rxCxzx94CB
         5jzQ==
X-Gm-Message-State: AOUpUlFdXukDtq9d8VIPeCkAjzItaCbWsclwnj+7axKUvAXO9//zlG9b
        /TId8A2T+fYA3OlmlViOoGuUBQ==
X-Google-Smtp-Source: AAOMgpdqSJaCnPyeqJ8qJPLFtESoQCDKitgUddNEbRhIiSh6lGbu3joXcsCwFM1SGeZ2wSWkqMZ7Xw==
X-Received: by 2002:a5d:6841:: with SMTP id o1-v6mr1460687wrw.159.1533204451486;
        Thu, 02 Aug 2018 03:07:31 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id f6-v6sm1885555wrw.78.2018.08.02.03.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 03:07:30 -0700 (PDT)
Subject: Re: [PATCH v2 03/10] mfd: wcd9335: add wcd irq support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-4-srinivas.kandagatla@linaro.org>
 <20180802080525.GM4662@dell>
 <74081a83-abcf-5529-babb-83a7b5242f68@linaro.org>
 <20180802100117.GQ4662@dell>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <26123a18-ad12-b654-c3bf-4faba0aa0646@linaro.org>
Date:   Thu, 2 Aug 2018 11:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180802100117.GQ4662@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/18 11:01, Lee Jones wrote:
>>> Any particular reason for separating out IRQ handling?
>> No particular reason, I tried to follow what other codecs like wm8994,
>> wm8350 and 14 others do.
> I haven't look at them in a while, but maybe theirs are optional?
> 
> Either way, I don't think you need to do it.
Sure, I can merge them into core in next version.
> 
>>>>    include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++
>>>>    include/linux/mfd/wcd9335/wcd9335.h |   3 +
>>>>    5 files changed, 228 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/mfd/wcd9335-irq.c
>>>>    create mode 100644 include/dt-bindings/mfd/wcd9335.h
>>>>
>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>>> index a4697370640b..210875afe78a 100644
>>>> --- a/drivers/mfd/Makefile
>>>> +++ b/drivers/mfd/Makefile
>>>> @@ -58,7 +58,7 @@ obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
>>>>    endif
>>>>    obj-$(CONFIG_MFD_WCD9335)	+= wcd9335.o
>>>> -wcd9335-objs			:= wcd9335-core.o
>>>> +wcd9335-objs			:= wcd9335-core.o wcd9335-irq.o
>>>>    obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
>>>>    wm831x-objs			:= wm831x-core.o wm831x-irq.o wm831x-otp.o
>>>> diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
>>>> index 8f746901f4e9..6299dfb63aca 100644
>>>> --- a/drivers/mfd/wcd9335-core.c
>>>> +++ b/drivers/mfd/wcd9335-core.c
>>>> @@ -243,12 +243,20 @@ static int wcd9335_slim_status(struct slim_device *sdev,
>>>>    		return ret;
>>>>    	}
>>>> +	wcd9335_irq_init(wcd);
>>> Why don't you check the return value?
>>>
>>> What happens if it defers?
>>>
>> It would not defer here as the regmaps are already setup in probe and the
>> status callback is only invoked when the SLIMbus device is up.
> I guess now you have seen my comment below, you know that it can
> defer, right?

Yes, I see it can defer on gpios.

> 
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +// Copyright (c) 2018, Linaro Limited
>>>> +//
>>> Blank line?
>>>
>> Yep.
> Does "yep" mean, "I'll fix it"?
Yes, I mean I agree with you and will fix this in next version.

--srini
> 
> -- 
