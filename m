Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C74CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D079920645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umJ51yCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfBYRzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:55:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39059 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBYRzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:55:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id b65so1813069plb.6;
        Mon, 25 Feb 2019 09:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YN0OlnVQYJBntNqmwDAzD0fL0Qo/FWo9DZeANwyOEYY=;
        b=umJ51yCkHoVGcS5UNZdohDiLlGiioruKwcmo/gpz8JNCBvFLUNr1lCMkCDJe15Wbfl
         t+JXzuDCZCw/Ii3RGDnm0iCom1eg99rHWs9VjYvtnOsVKngRMwji9a4+5x1dy12SDGbb
         9zeeEh/HLVnIb6C7ijrr9VSi4D4PTVn0Y6DdXiPZFJ/jhWnNayCLLtZRkgQiCa6BHdd6
         m08rMFPsm06mBC/C3ePmoLZ8fhp00D6SBJa48JmFzzASeSBUO/UTKgJ1dX8qb1WGJy6E
         nB7gMJufigHYMNaRhCqNUQ6HSNBQ8zd4ocfkEKUqjDmYbpZI34HFdKkwcXfSarRmN8d+
         zWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YN0OlnVQYJBntNqmwDAzD0fL0Qo/FWo9DZeANwyOEYY=;
        b=XnedqE75YOOlQ5jU2+1lGmKavzjY+kVekRCh9wZPtEeKBd1/DzsW0O9Iq/VfFrPYAN
         GlQCIQpbSfQbtKPxhpgxJlCxP2oPZZo5iMiMHdjTNhjY4T8UYe7nRIjXKQxxY+nxCXE5
         z6bLLkuyNbitgN0WXGG/584aRcDJxYWQiaRl9aK7stjWaYX7WKuDx+7+11K1wz09pR8U
         Xas9JF/9w1i/IfHywfKIEtDrrDxbjiSNifS1CEUkm4JxM2E+y7TNAdvWx2d99zKAxYP4
         O2ngffHEsvGH9MdcreE1ShKXqXTdt0LvK3kpkYyA9M2W7mtqkNB8sCBV1XQMnahNm5eO
         yz2A==
X-Gm-Message-State: AHQUAubvv02Wd33OlGauW+DStCMxcL1m5TNaQEXmSss3Rc279atmY0xb
        Aoi/Ys2mx9ZTI3ftFHNlx40S43rp
X-Google-Smtp-Source: AHgI3IaR7jlSeYRjfhqiVbXGysPfM6w8rNSpq0ul/maepRX4Bet+UD4pSpOSmzEcnUTMMh7J7I8Dxw==
X-Received: by 2002:a17:902:24e7:: with SMTP id l36mr21770505plg.61.1551117313958;
        Mon, 25 Feb 2019 09:55:13 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id h126sm7861299pfc.135.2019.02.25.09.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 09:55:13 -0800 (PST)
Subject: Re: [PATCH v6 0/7] Support Trusted Foundations firmware on Tegra30
To:     Robert Yang <decatf@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190222193426.10747-1-digetx@gmail.com>
 <20190225040232.GA2242@qmqm.qmqm.pl> <20190225082155.1163ed85@dimatab>
 <20190225165836.GA12933@r>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <684c1196-b2c3-f381-7cb0-0ffa3f071378@gmail.com>
Date:   Mon, 25 Feb 2019 20:55:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190225165836.GA12933@r>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.02.2019 19:58, Robert Yang пишет:
> On Mon, Feb 25, 2019 at 08:21:55AM +0300, Dmitry Osipenko wrote:
>> В Mon, 25 Feb 2019 05:02:33 +0100
>> Michał Mirosław <mirq-linux@rere.qmqm.pl> пишет:
>>
>>> On Fri, Feb 22, 2019 at 10:34:19PM +0300, Dmitry Osipenko wrote:
>>>> Hello,
>>>>
>>>> This patchset adds support for the Trusted Foundations firmware on
>>>> NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have
>>>> that firmware and upstream kernel can't boot on those devices
>>>> without the firmware support.  
>>>
>>> Hi Dmitry
>>>
>>> I've applied and tested this patchset on my TF300T. Boots and
>>> suspends/wakes using 'rtcwake -m mem -s 1 -d /dev/rtc1' as the test.
>>> dmesg attached.
>>>
>>> The exact tree used:
>>> 	git://rere.qmqm.pl/linux tf300t
>>>
>>> Feel free to add my Tested-by and Signed-off-by on the patches where
>>> apropriate, and thanks for your work!
>>
>> Awesome, thank you very much!
>>
>> Robert, could you please confirm that v6 works for you too?
>>
> 
> Yes, v6 works on Ouya.
> 
> LP1/LP2 suspend tested with 'rtcwake -m mem -s 5'
> cpuidle LP2 tested with 'echo 0 | tee /sys/devices/system/cpu/cpu[1-3]/online'
> Tested with CONFIG_SMP disabled too.
> 
> You can add my Tested-by to this patch set.

Great, thank you!
