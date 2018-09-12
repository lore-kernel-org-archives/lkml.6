Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F7DC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6AB20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDke7j2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6AB20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeIMNrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:47:45 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43048 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeIMNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:47:45 -0400
Received: by mail-wr1-f51.google.com with SMTP id k5-v6so4690050wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 01:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ict1UzC3CDp5S8HWeR8JbUueAqfkv91zqZFwffOI40g=;
        b=QDke7j2P89dN2ykqZoAX6lZ6wJu9ncXiYrJ9c9HtOlGItjQnMSSB/5A/gz7DMHEajm
         wgqAOunCrhH1cX44adrEd8Urw6Lf8pnnZfIHnQVahE/z4Cg9aPVo44bifcC2meaNaPlS
         YsWCzAqGVBVXorxj6EfUKU4DJlEJVGBsbpPY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ict1UzC3CDp5S8HWeR8JbUueAqfkv91zqZFwffOI40g=;
        b=pKLQD49+qfNIzf9nLmWbVjFnlVKX5omeVid4b/SYrGSi8Isj/QRadyiIjwrUeDEgX3
         5KlLluIrMen0ExYbYMDSbciWR32bKTtFegSydvoT1zjjB1sJOGVTSF805kTaUN1iUDnz
         x+D0NdPZAcCwMHIgimBXW/bOVxidlAb9sZba43VObky5ktPe/SjAANawgYQ77Iset0pK
         w2SBjVYqVmaCuUqKPRMaBqTztx/zYIrTNgWKKvJGVaXHRpeOjwRL4dnZhAjNLYv0vKwl
         KgWPhraIfPeC4chmmi4ZnyA7USx6tzvwkOa3FWmcosBiNLfFvdwmG3aG/LBS6h95joGN
         HOLA==
X-Gm-Message-State: APzg51CsLS7shlkFgmwUYGcqRi3XNlOzIwMo+7EtIxbtZ44NzXWFWqKy
        mUdMAWFEZAIetyVAnGErT5dsXg==
X-Google-Smtp-Source: ANB0VdY6az9wICoXg/RW+A8oyQJPsMVAMyTrnXwxnc3FVaOwDzoUX3CSgpmKSPZ5e77CRGnTno8oMA==
X-Received: by 2002:a5d:434c:: with SMTP id u12-v6mr4480189wrr.189.1536827956561;
        Thu, 13 Sep 2018 01:39:16 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id f13-v6sm2154275wrt.9.2018.09.13.01.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 01:39:15 -0700 (PDT)
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
 <20180911153340.GY4185@dell>
 <94c68436-b618-40fc-46d6-165799312289@linaro.org>
 <20180912085848.GP4185@dell>
 <b4ddfd10-360c-a844-8542-1f81a1cc9c6b@linaro.org>
 <20180912105941.GS4185@dell>
 <11f213e5-8c93-f75f-1b74-517f00cd9a96@linaro.org>
 <20180912114633.GU4185@dell>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ffcf1b3a-b66c-6e0e-3e7a-da092e9d1894@linaro.org>
Date:   Wed, 12 Sep 2018 13:43:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180912114633.GU4185@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> There are two parts for device to be ready to talk at bus level:
>> 1> power up and reset,
>> 2> enumerate and assign a logical address by the slimbus controller.
>>
>> First part as you said is already done in probe.
>> When second part happens when status callback is invoked, that is when the
>> slimdevice is ready for any kind of communication at bus level.
> 
> I see.  I still think it's hacky to conduct start-up procedures when
> all the SS requested was status.  Perhaps it needs a new API call
> init()?

When we added these callbacks the purpose of this was to allow drivers 
to do specific setup/teardown.

AFIAU, even-though if we add init(), SLIMbus would still call it just 
before or after status which to me is redundant ATM.
Its up to slim driver what it exactly whats to do with status, in some 
cases this can involve setting up the device.

> 
