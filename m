Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779CCC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298DD20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbcQ6f5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298DD20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeIKXny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:43:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44594 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKXny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:43:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so27070777wro.11;
        Tue, 11 Sep 2018 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0drb+/CS2lzkJiS7EqvZdflW/nK1Y7n9YmXVxNZwp0Q=;
        b=pbcQ6f5MeSMnk28M//DpOka0xZUCe7JPa4CHXJ8GB7E6FiR7ibT5cCf9hZh47W6f+X
         HFZ1kLd0a09yUy5200BpPio1uPwx/SokoIX92r0H83Li8SRXTOtbhFa+CA4mp3JgyWJr
         YwmCroVc2ucdMH74UH+UiFX2b0WSHSdCZ+XMMkWDgp2Paor9L35FHdPZUGNVp10zqdA0
         mKoJDdV2OZ6roVGERPUkzHJpi93pQ8qKT0uOkiRwcAj2LxH/BD1AydDvpLMA5A2uxwet
         K2lmv0Mxp+ZAlHshd2dM9typ0hGRnwwT3N/28X7Ut+phwxO6ePhrqOW+VANVuOL6SLIB
         bBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0drb+/CS2lzkJiS7EqvZdflW/nK1Y7n9YmXVxNZwp0Q=;
        b=VFYxPHBzoj0eBnAHGenHaIWBIdn2TU2Duhv6jAAl+H/i20Ld/PiOzAnG69a7zig7Ah
         Qbd1JhhsONQisFKz/aR/Fi5A2IGz93/JCZnI2173EH+yImBkk3QWYOsw3RG7j1AHUNiS
         UgE/08WAixI+w6BXzUkirqlWNKF4erksdZhxSToChky1vKJ6MxHcUiVojahzRqdA9gft
         /ieWxuvTo2297yhQKO3MGwh61jwbyOHbP27NoLjffRKFOaTBRUctk7A0kn6vLFVgwWVS
         VnAhU5WO9Y779mefDQk+qP+6r95m6VNH3C9IO2xbke5QTj0Ph2l7XPXikqQfjf8g0fbX
         Lg8Q==
X-Gm-Message-State: APzg51DnflNcyDLPWwAXYvicJ4TZLCu64pslpkKV9E7ZkZ5j7OPiHGAo
        FnyARajpsSKv9TJrLJTrdHJxG4Yo
X-Google-Smtp-Source: ANB0VdZMiKjjdrKw7R6WQ5uvWpxCJrEEece+5Tc7u6t9KDqdDwtev+NekO2mT9FBIF2UH9vNbvn47g==
X-Received: by 2002:adf:b7c9:: with SMTP id t9-v6mr18983177wre.274.1536691395817;
        Tue, 11 Sep 2018 11:43:15 -0700 (PDT)
Received: from [192.168.1.18] (bks43.neoplus.adsl.tpnet.pl. [83.28.186.43])
        by smtp.gmail.com with ESMTPSA id f18-v6sm19795143wrw.32.2018.09.11.11.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:43:14 -0700 (PDT)
Subject: Re: [PATCH v8 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <20180908050208.GY2523@minitux> <20180910211935.GA4697@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <dd1f8dd2-d577-ab12-e67a-7ed71459055a@gmail.com>
Date:   Tue, 11 Sep 2018 20:43:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910211935.GA4697@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

On 09/10/2018 11:19 PM, Pavel Machek wrote:
> On Fri 2018-09-07 22:02:08, Bjorn Andersson wrote:
>> On Tue 04 Sep 04:01 PDT 2018, Baolin Wang wrote:
>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> [..]
>>> +What:		/sys/class/leds/<led>/hw_pattern
>>> +Date:		September 2018
>>> +KernelVersion:	4.20
>>> +Description:
>>> +		Specify a hardware pattern for the LED, for LED hardware that
>>> +		supports autonomously controlling brightness over time, according
>>> +		to some preprogrammed hardware patterns.
>>> +
>>> +		Since different LED hardware can have different semantics of
>>> +		hardware patterns, each driver is expected to provide its own
>>> +		description for the hardware patterns in their ABI documentation
>>> +		file.
>>> +
>>
>> So, after a full circle we're back at drivers with support for hardware
>> patterns should have their own ABI for setting that pattern.
>>
>> The controls for my hardware is:
>> * a list of brightness values
>> * the rate of the pattern
>> * a flag to indicate that the pattern should be played from start
>>   to end, end to start or start to end to start
>> * a boolean indicating if the pattern should be played once or repeated
>>   indefinitely.
> 
> No, we are not back to full circle.
> 
> Or at least we should not be.
> 
> Yes, hw_pattern can have some limitation pattern does not, but if you
> take values from hw_pattern file and put them into pattern file, you
> should get the same pattern (with more power being consumed). And that
> property is kind of important for me, because it should keep the ABI
> reasonable.

If you looked at what we agreed on with Baolin, you'd realize
that this property is in no way preserved.
This is what the whole story is about - we're introducing hw_pattern
because of difficulties in describing breathing pattern by a series
of [brightness delta_t] tuples.

And Bjorn presented another example. I'm inclined to leave the
definition of hw_pattern semantics to the LED class drivers,
and allow them to create related sysfs files.

>>> +What:		/sys/class/leds/<led>/repeat
>>> +Date:		September 2018
>>> +KernelVersion:	4.20
>>> +Description:
>>> +		Specify a pattern repeat number. 0 means repeat indefinitely.
>>> +
>>> +		This file will always return the originally written repeat
>>> +		number.
>>
>> I'm still convinced that this will confuse our users and to me it would
>> be more logical if this denotes the number of times the pattern should
>> be repeated, with e.g. negative numbers denoting infinite.
>>
>> In particular I expect to have to explain why my driver expects that you
>> write 0 in the file named "repeat" to make it repeat and 1 to make it
>> not repeat.
> 
> Ok, -1 works for me :-).
> 
> Thanks,
> 									Pavel
> 

-- 
Best regards,
Jacek Anaszewski
