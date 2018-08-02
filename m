Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4877CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F272220C0A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUarn/p+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F272220C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeHBJXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:23:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54039 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeHBJXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:23:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so1304927wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K7WHwPGo6HFW1ak06spWzHZNFUFD5HUjiWljmOJKSpI=;
        b=VUarn/p+33VQdWWk/akKH9YMXvt2VKby/3DbaV3/A0rQ4IereyTGA+kmVTshdFbi09
         N8VP1gHLwhFMVIK/bsRp8VqEMKC+IQRIIZa62TxVN2c7reyCsqSmNIefEB3hf0orp63P
         pe2xWi0wpQ+MDQsEO8pqRhWtnt8ANq5thaObg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7WHwPGo6HFW1ak06spWzHZNFUFD5HUjiWljmOJKSpI=;
        b=P75p2E74xh252sGCOtfcYXDqxPKOPi9fWJFNKpdEBpVybH6Mz85ZJwNV4zOmWHbGS+
         DNb3urOHsBTVVK/FH96WjKjXmavgq5IBzgFnKdjl3Li+M7uGTJweSAhxZoPFl+3iToUy
         H3kWyynTM2GsJwAsPC394sSqJZgFBeXAmA3/0m0TnmDaVwTEv0ozzFVbLjSjw7pRoqQk
         34bQSBm2Z3STAfndlB16rbRI3+BujtuLVihVJTXIsa+rZxoMXiU6G9jw87PrrHZRsDW3
         of3HikX0koeOGfKw5+hJgU0cWZNm8JGFsXy0Kcc+/VdHYXG9npJPWuJMoPuWDnHk2EI2
         R1bQ==
X-Gm-Message-State: AOUpUlH0wjxwyLSjLlwCphuVF91yjljAEqZ4v3KbJcmstFRdqn6pxSDu
        hTGlwwB4HGKD81ATUeatawcRMw==
X-Google-Smtp-Source: AAOMgpfdly4zrD0MKybDtKgVnV3J2d/RMTQLIavP58aoUAItWkQhUFJ3a77Mf2oZSTOS6b83va1lkg==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26-v6mr1138139wmh.61.1533195229055;
        Thu, 02 Aug 2018 00:33:49 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id t70-v6sm1460744wmt.30.2018.08.02.00.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 00:33:48 -0700 (PDT)
Subject: Re: [PATCH v2 01/10] ASoC: dt-bindings: add dt bindings for wcd9335
 audio codec
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod <vkoul@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
 <20180731204315.GA5265@rob-hp-laptop>
 <53a4e82c-7270-fdbd-a2ea-efbfc2d747a2@linaro.org>
 <CAL_JsqKcxB2NZR94BP9-Qc8AAFsySPoADm2UA_ZV8V7JdP8-wQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4c821ce9-6268-150f-2ab0-358f5b312ec0@linaro.org>
Date:   Thu, 2 Aug 2018 08:33:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKcxB2NZR94BP9-Qc8AAFsySPoADm2UA_ZV8V7JdP8-wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review,

On 01/08/18 23:20, Rob Herring wrote:
>>>> +- qcom,ifd:
>>>> +    Usage: required
>>>> +    Value type: <phandle>
>>>> +    Definition: SLIM interface device
>>> Wouldn't this be the parent?
>>>
>> No, Interface device is just like other slim device and is part of
>> SLIMbus Component and has a unique address. Every SLIMbus component has
>> one interface device.
> I still don't understand what this means. If this is SLIMbus specific,
> then maybe it should be named that way? Or it is QCom specific?

It is SLIMbus specific, I will rename this to "slim,ifd" in next version 
which makes it clear!

thanks,
srini
