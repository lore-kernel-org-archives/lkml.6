Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73693C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2331A20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hybR9cAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2331A20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388787AbeHAKlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:41:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40134 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387728AbeHAKln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:41:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id y9-v6so6141049wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fmAftgO3f/CX3HLsGTkE0X64lHZrKJQFEs6fx5m+BGg=;
        b=hybR9cAanIX2DiCOMcpmtew7TOxjXC62V6gaxDFoW6RlPlByifVGwlIbEVXHh9UL2r
         qCTizbmg7CW+T1p8gtaAKSvwG2emKZ4s4lR7yFkMUBNWf8XhRD8y5nwLNYyvp9zGBd95
         t0ElYQTQEZmNQHrV2Fuz5+y6NYBr0KuNY4l5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fmAftgO3f/CX3HLsGTkE0X64lHZrKJQFEs6fx5m+BGg=;
        b=V49qDkSqu+U158/QZ9acfmoq7IqcsDNkHVdAVID+YmIgrZAn6XRPqAd2FwQlTDm0vM
         G/VvB0no0Y6VC8k0Pb1tZPJBhN3xcjnZXCCxeclPxUjr8BHpKk+uKujNxFy3qgZ1fsGG
         nD+znSmLtH1x9UVRAHOtLEGxIQOUr1+lkiRbGjpAzl9PBVLpVu9x1HEtxKP/W4nnn/PC
         ieF3Q+90aSUeA3MuNqz8hli4gUccWPxGy87JoslLMixHbdJJ9lmpEUZBS9DU/trEhs5a
         8Fg0XlzhheR8R1hY81wcuh4VQSqSTMEVrGu+aPGK752BBIAoLGoCpDFagakcAEJosxjZ
         ys5w==
X-Gm-Message-State: AOUpUlFiqV9szdO89BpX8CWU3Vl4HZRQFt5IJZKIGBfEhtqH33kKpGyZ
        7Ch3rMmivWwDFkAPfWFvldIvmw==
X-Google-Smtp-Source: AAOMgpd0HrN2XOB4s3vl1D4DIx4NM6uzPob6DQbyZ0iLMf0BbUlIzI4SY5w7iwfrmZsST4ku/w90cg==
X-Received: by 2002:a1c:6d9a:: with SMTP id b26-v6mr1958024wmi.74.1533113820641;
        Wed, 01 Aug 2018 01:57:00 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id i1-v6sm19082139wrq.69.2018.08.01.01.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:57:00 -0700 (PDT)
Subject: Re: [PATCH v2 01/10] ASoC: dt-bindings: add dt bindings for wcd9335
 audio codec
To:     Rob Herring <robh@kernel.org>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
 <20180731204315.GA5265@rob-hp-laptop>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <53a4e82c-7270-fdbd-a2ea-efbfc2d747a2@linaro.org>
Date:   Wed, 1 Aug 2018 09:56:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180731204315.GA5265@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On 31/07/18 21:43, Rob Herring wrote:
>> +
>> +- reset-gpio:
> reset-gpios
> 
Yep, reset-gpios makes more inline with others!
>> +	Usage: required
>> +	Value type: <String Array>
>> +	Definition: Reset gpio line
>> +
>> +- qcom,ifd:
>> +	Usage: required
>> +	Value type: <phandle>
>> +	Definition: SLIM interface device
> Wouldn't this be the parent?
> 
No, Interface device is just like other slim device and is part of 
SLIMbus Component and has a unique address. Every SLIMbus component has 
one interface device.
...
>> +
>> +codec@1{
> audio-codec@1
> 
Yep, I will fix this in next version.

>> +	compatible = "slim217,1a0";
>> +	reg  = <1 0>;

Thanks,
srini
