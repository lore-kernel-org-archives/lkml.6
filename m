Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB49C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE38A2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV3IBgAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE38A2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeHYAVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:21:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55504 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeHYAVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:21:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so2687235wmc.5;
        Fri, 24 Aug 2018 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w6kD8DXFWMl1r9hG+XJeBOQ3lrb2s90OElvycUTMOB4=;
        b=gV3IBgAQe4YEQ3U6AUGbciEkCx/HYUBoG2iGmoJlvBg6tKQ+ZTMzxL1mDfxsnRcvLD
         Gh9rJr0r2VvDnnoJmktTTsUc03+1dOsCM1PHjduWwfG1CHOG48AX2WruQH2M/om2TGRr
         DOFkyp6rHLGpsC9EdSHPHvd738T1mI/kPKy31kOxTiZMoi6G/1vm+tSJlwkaV4ByFGvy
         79gIc3ViGUu5YGOntZSnansB8MlRTG7cgtvVt29Z5vS2EBXiyTw3bYBUULvdK8h6fHyP
         0YWQ42Ynt4hKSVBCFD+glkAGBle36ZwvKGfO7N8AZthLy9g6fFI9AHkve3G7h2gQ0VP8
         Eynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w6kD8DXFWMl1r9hG+XJeBOQ3lrb2s90OElvycUTMOB4=;
        b=FA/BNDI9uBK7CGZRqJHfxDEbFqh9dii+Hx+Nj5uGbNPQAPcIOUnN5kc1GRoHG0yHH/
         ROYnApZIKM8fIWNcTYuMx/VIZroGNnnAFnwDaoIZYbAiT+5VX8ubghlDJRonvQHtwJxw
         sx9dZnGu9fEAFjcPxwc8aat36lMS4P2wkY9lw5auO2axDIq33qkM8hsmYcZYSXxlE8Od
         /nKoCHY69shie2Ujd5n0GoJXGlWDIPdY3V1PPmocz7s4vJ7m0G5SiQd/0KO2PrRcEBza
         w4NWyqdieZDd7sllxtrCq/9Tf4qv0ExG1YeAObl+oOnLmp5Vwo/6h3bCv1YiExW/ujAP
         KdEw==
X-Gm-Message-State: APzg51DUHJN0haSl3kfFBVx31uGDiKCT4oLzEahWXflp4TCS5toGy822
        8b/YsrOsv0EtjJCVaoCHLuzRUElr
X-Google-Smtp-Source: ANB0VdbnKBxrMa4DmWNy6cLNqa4VAhhtclFuGQ7oDlluOFWeJKaVvYCdfF1RcBq2IxuHTzRUfS/17g==
X-Received: by 2002:a1c:ac1:: with SMTP id 184-v6mr2275690wmk.119.1535143489801;
        Fri, 24 Aug 2018 13:44:49 -0700 (PDT)
Received: from [192.168.1.18] (bga163.neoplus.adsl.tpnet.pl. [83.28.64.163])
        by smtp.gmail.com with ESMTPSA id q5-v6sm3820827wru.79.2018.08.24.13.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 13:44:48 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com> <20180824101145.GA1510@amd>
 <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com> <20180824201227.GB17146@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <f5046e2d-9f15-4b7e-083e-e97f7ca0693c@gmail.com>
Date:   Fri, 24 Aug 2018 22:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824201227.GB17146@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 10:12 PM, Pavel Machek wrote:
> On Fri 2018-08-24 21:49:50, Jacek Anaszewski wrote:
>> Hi Pavel,
>>
>> On 08/24/2018 12:11 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>> I think that it would be more flexible if software pattern fallback
>>>> was applied in case of pattern_set failure. Otherwise, it would
>>>> lead to the situation where LED class devices that support hardware
>>>> blinking couldn't be applied the same set of patterns as LED class
>>>> devices that don't implement pattern_set. The latter will always have to
>>>> resort to using software pattern engine which will accept far greater
>>>> amount of pattern combinations.
>>>>
>>>> In this case we need to discuss on what basis the decision will be
>>>> made on whether hardware or software engine will be used.
>>>>
>>>> Possible options coming to mind:
>>>> - an interface will be provided to determine max difference between
>>>>   the settings supported by the hardware and the settings requested by
>>>>   the user, that will result in aligning user's setting to the hardware
>>>>   capabilities
>>>> - the above alignment rate will be predefined instead
>>>> - hardware engine will be used only if user requests supported settings
>>>>   on the whole span of the requested pattern
>>>> - in each of the above cases it would be worth to think of the
>>>>   interface to show the scope of the settings supported by hardware
>>>
>>> I'd recommend keeping it simple. We use hardware engine if driver
>>> author thinks pattern is "close enough".
>>
>> The thing is that in the ledtrig-pattern v5 implementation there
>> is no option of using software fallback if pattern_set op
>> is initialized:
>>
>> +	if (led_cdev->pattern_set) {
>> +		return led_cdev->pattern_set(led_cdev, data->patterns,
>> +					     data->npatterns, data->repeat);
>> +	}
> 
> Yeah, that sounds wrong. (Sorry I did not pay enough attention).
> 
> It pattern_set() returns special error code, it should just continue
> and use software pattern fallback.

And now we can get back to the issue I was concerned about in the
email you replied to, i.e. what series of [brightness delta_t] tuples
should be written to the pattern file to enable hardware breathing
engine.

-- 
Best regards,
Jacek Anaszewski
