Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BCDECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667662075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn0JYq82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667662075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeGRUB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:01:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40365 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbeGRUB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:01:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id t6-v6so5735740wrn.7;
        Wed, 18 Jul 2018 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8cokHvNP0jb+NIY+vzAU2wN0O2jTMyC1jgw+B1F9rF0=;
        b=kn0JYq82CrS3rVkmhLZ01U9JDCLf2dJbGUiu3USaMwwUx+x/LLaFilts7gfhAok6LM
         CAc920m0CavyDJ8jS+b9Ygaku/kJv5+QaIfWRfcRct+k0Lbch0CXdAvf79Dv0AozZwJP
         SYRXk483YfceR8nKFkGAtotp3zkcIUnUIcjuDMh3/CTGAFpYxijqt7eF0Kwl+cUJgxfR
         0CByaoEbWZhuwheIQhjDWT+9aqz7P+1VnQkjmKpT5PirH0J0HP7hCiBy2aqYUS8eEfIA
         IAUWXzQDoFHL4CXD0f3nN8gNMyge6sxRGz/2k9mn/Kla+V0gPcQ7dJJljmdypb60p3eL
         3+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8cokHvNP0jb+NIY+vzAU2wN0O2jTMyC1jgw+B1F9rF0=;
        b=WhoYPyWlDpzyNGx/t4ACvpgYXhx56LBCidCjGEZEpY15T8IGNt6g2nSyWQmfn+nEl5
         A5538Mzt2gSyH9THXqf0sIymRSWy3ucY6LFbt6EkuiecHasHMLFB823h0l9LHoZxmUTv
         ao+dXK3TW68ygEe9QLM/TVkRjN50VBnn4GJORlaQ7AAa1sq+uNvU/oKd16XeBxswlmjm
         yqvdQae3zEVwW21lPX7HnM33fGUZoNnbCfSlLlpf9S5WY383pKKtwnEtozw+n3JouvUE
         rX7F8Ltydhy3KSuWMHXJwHs+O5Y4iMTyg/G/goDWolQA9n+o1iKFtToAVhQsrqa+SfIR
         h6Ig==
X-Gm-Message-State: AOUpUlEUdGFWy67aLAvBe3HEXYOwPo9p58QWS58BnORg28nTrL0gM+KA
        CwLc1az8nIbuDMbgN/8yZ4/dRwoF
X-Google-Smtp-Source: AAOMgpeBFuRTtG7RFNKwRGJuaOL5w9vja5XOd9SCGBynsZgvABRXs+UaUF2LKof9ZKI1cLhW94DyJg==
X-Received: by 2002:adf:df07:: with SMTP id y7-v6mr5033345wrl.117.1531941728161;
        Wed, 18 Jul 2018 12:22:08 -0700 (PDT)
Received: from [192.168.1.18] (ckg128.neoplus.adsl.tpnet.pl. [83.31.82.128])
        by smtp.gmail.com with ESMTPSA id d102-v6sm6006570wma.10.2018.07.18.12.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 12:22:07 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     David Lechner <david@lechnology.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAMz4kuJfPKykB6G-8C25mmMCfQgefv-Y=k2OQYZR_e0Tvg3guQ@mail.gmail.com>
 <8da1b769-8aa3-9698-467a-2e7b0707fecf@gmail.com>
 <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd> <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd> <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com> <20180718075637.GA10279@amd>
 <913151e4-c19f-9a22-697c-52a9fb48cb32@gmail.com>
Message-ID: <0e0cd8f7-dc73-6733-65f2-9a14506b0f0e@gmail.com>
Date:   Wed, 18 Jul 2018 21:22:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <913151e4-c19f-9a22-697c-52a9fb48cb32@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 08:54 PM, Jacek Anaszewski wrote:
> On 07/18/2018 09:56 AM, Pavel Machek wrote:
>> Hi!
>>
>>>>>>> I believe I meant "changing patterns from kernel in response to 
>>>>>>> events
>>>>>>> is probably overkill"... or something like that.
>>>>>>
>>>>>> Anyway -- to clean up the confusion -- I'd like to see
>>>>>>
>>>>>> echo pattern > trigger
>>>>>> echo "1 2 3 4 5 6 7 8" > somewhere
>>>>>
>>>>> s/somewhere/pattern/
>>>>>
>>>>> pattern trigger should create "pattern" file similarly how 
>>>>> ledtrig-timer
>>>>> creates delay_{on|off} files.
>>
>> Yes, that sounds reasonable. v5 still says
>>
>> +               Writing non-empty string to this file will activate 
>> the pattern,
>> +               and empty string will disable the pattern.
>>
>> I'd deactivate the pattern by simply writing something else to the
>> trigger file.
> 
> Please keep in mind that this is ABI documentation for the pattern file
> to be exposed by LED core, and not by the pattern trigger, that, as we
> agreed, will be implemented later. In this case, I'd go for

Gosh, I got completely distracted by the recent discussion about
pattern synchronization.

So, to recap, we need to decide if we are taking Baolin's solution
or we're opting for implementing pattern trigger.

If we choose the latter, then we will also need some software
pattern engine in the trigger, to be applied as a software pattern
fallback for the devices without hardware pattern support.
It will certainly delay the contribution process, provided that Baolin
would find time for this work at all.

I'd just take v5 based solution for now (with improved semantics
of disabling pattern - in this case my reasoning from the message
I'm replying to is still valid),

> "echo 0 > brightness" as a command disabling pattern. The same operation
> disables triggers, so later transition to using pattern trigger will be
> seamless for userspace.
> 

-- 
Best regards,
Jacek Anaszewski
