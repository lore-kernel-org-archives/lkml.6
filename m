Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6496ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE4A21477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChKPlqpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE4A21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJRQl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:41:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52928 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeJRQl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:41:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so4559009wmw.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BkicYG7ij0EGe+36E67asG9gOs4hqzrdBWfs/ryQqFo=;
        b=ChKPlqpZBry2hzNmn6k5G0ERCzQ7dC16kkKxAPwRMPnC+UeiL+UaPYeiYWPd6RiYQB
         qLmP0/MgyYwsLIrpTki2oglIvBgaUBoCxxxM8ijIgPzN91z0G2d+uw59Sl/J47TFKJnq
         3a/I92NJS8xUjHwq55sFgPQwNbJaoKqU34Fp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BkicYG7ij0EGe+36E67asG9gOs4hqzrdBWfs/ryQqFo=;
        b=OhxcD678fgsql0wIrElQmLYxPGxpdljQppWFJtTpVR3dVCtP078agVdY7RLohFhLpS
         P2N87YY1sirB4Q4zgoQZYuXnlpwCNlWyk6MwAwTKEma+kcnLC/SzJDPTVevrRi1HBloR
         ktiX5mcBP0gHWG9H2ssvNQgIki5eDYt58ZLHUH8N6FRMv1/9cogQwtJsePmREQZWbXQY
         gbdlV4eX+1xNlg94JHC/6s7VfOUQu46BJX1oW8sTPYUy+viPpxvQsQw5wvrer9FKuI4p
         AIm0vDiXoO1bA1OiNN5NYNvctcWVmKmuS/vW8JnulAxBLQ01c4fUX72ypr1orq2CoCkB
         2jNw==
X-Gm-Message-State: ABuFfoj9MHVb5f0pAr6t7tfr0JZpeU8fN4cNURaujtahuIVcO4eeHZTH
        jYePaA8B1acqE9iyeelk+UZ8ENzE/z8=
X-Google-Smtp-Source: ACcGV62Li+r/s2ry1rHsnGtprEstI9fMmcL03ecvREdVIGhGR9b4qboXq8NSOOuLQmoyzg57zP3eDA==
X-Received: by 2002:a1c:7809:: with SMTP id t9-v6mr6243955wmc.77.1539852088946;
        Thu, 18 Oct 2018 01:41:28 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id 143-v6sm6524232wmv.6.2018.10.18.01.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 01:41:27 -0700 (PDT)
Subject: Re: [PATCH v11 1/5] venus: firmware: add routine to reset ARM9
To:     Joe Perches <joe@perches.com>,
        Vikash Garodia <vgarodia@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org
References: <1539005572-803-1-git-send-email-vgarodia@codeaurora.org>
 <1539005572-803-2-git-send-email-vgarodia@codeaurora.org>
 <fffd5b1f-73b5-81d5-a95b-a2dc9db1961d@linaro.org>
 <864470f074e634e7276bf999e3c3704b58c1e913.camel@perches.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <9d47c2d4-3a36-f05f-74c1-0d6e98d73314@linaro.org>
Date:   Thu, 18 Oct 2018 11:41:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <864470f074e634e7276bf999e3c3704b58c1e913.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 10/18/2018 04:42 AM, Joe Perches wrote:
> On Wed, 2018-10-17 at 11:49 +0300, Stanimir Varbanov wrote:
>> On 10/08/2018 04:32 PM, Vikash Garodia wrote:
>>> Add routine to reset the ARM9 and brings it out of reset. Also
>>> abstract the Venus CPU state handling with a new function. This
>>> is in preparation to add PIL functionality in venus driver.
> []
>>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> []
>>> @@ -129,6 +130,7 @@ struct venus_core {
>>>  	struct device *dev;
>>>  	struct device *dev_dec;
>>>  	struct device *dev_enc;
>>> +	bool use_tz;
>>
>> could you make it unsigned? For more info please run checkpatch --strict.
>>
>> I know that we have structure members of type bool already - that should
>> be fixed with follow-up patches, I guess.
> 
> That's probably not necessary.
> 
> I personally have no issue with bool struct members that
> are only used on a transitory basis and not used by hardware
> or shared between multiple cpus with different hardware
> alignment requirements.

Thanks for the clarification. I personally have preference to 'unsigned'
for such flag, but let Hans decide which one to take.

> 
> Nothing in this struct is saved or shared.
> 
> Perhaps the checkpatch message should be expanded to
> enumerate when bool use in a struct is acceptable.
> 

It'd be good to explain more, because it sounds imperative to every
structure.

-- 
regards,
Stan
