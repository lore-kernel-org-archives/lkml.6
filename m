Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69A5C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E1720853
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEVe2cj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E1720853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeINAsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:48:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38829 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbeINAsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:48:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so5605457ljc.5;
        Thu, 13 Sep 2018 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cbi0vMTYjvwskTSFJN8ujhB9V4BK8DkL59ezfD3cOOA=;
        b=rEVe2cj3NDbL0+UIw31Bs8+MI2W6guUiao8pUs1fmR/oBPdRMNTSd5lgGNktIdRU7U
         ejlaq3wcsFvWjOBKYd6/5j+ya+id2aA6tD3hM7oAbvRAoCvcnniC3cxd+yP618XwDoI9
         rEiaumEhE92vr1KKTxZvMDxQklEBEmZQkTdRyFvZu6Wahr0qg9RLWvGcf8pgp8cDrUdE
         lsaf3rYCD00f8IuaSCPVxAEDujeGYAmJGjWwCWrhkdUjO8BU7RpDM8kmTM6xEWU6dIkt
         ZeYPVfxG7MswwyHeUOpbFDyVslJ4r5brmShQ72O4fvKuo9p7ExlUIkZn6xyTXOuSgf4R
         ZpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cbi0vMTYjvwskTSFJN8ujhB9V4BK8DkL59ezfD3cOOA=;
        b=H9NAooV4Ebj1mEBBXDnLxXD4WzbagzXIgktdWAFq1A7M1PI9m7YoCom8y1+9UEj0iu
         vfB1l54h4HE9tYY0kXHFBgjR3roRyGwdmHIlNTaLcEtpV1HjTKyPLL+SUV8MHmtSThxx
         yhkk7P9f+kCJWVa8Ab5g3Qid/ANdJwzarW8iRcpFpPtF4guWn0aRUHdV7827lDfYTUTk
         RsYuFeBujgJyu5R+iMu4WRaaeUBTd57k7/bB4lCQZ4C9s5glhpL1XG9EMEWma0EfAUIw
         SVAizYmjDXMDIsnO5ipmjLj88BaaCQV6NlUoYYa+5QdYNLZUcpv3E/GfKx4IPMffQ1nF
         OFpQ==
X-Gm-Message-State: APzg51DXS825Mr4eGvIh2o6aZ2T2MzD01GzFCqtlCLAhVAAWoHTDE9kO
        j5H2PdQWywFOBmsqAbyftoW2oX8f
X-Google-Smtp-Source: ANB0VdaYUr+Cmc34lUBspkl7LdMECjp1ywLkJ7o30QH8aJ/Ike6uz+BtsqtNrLOI0jVNbd9T1dwSoQ==
X-Received: by 2002:a2e:259:: with SMTP id 86-v6mr5842759ljc.107.1536867443476;
        Thu, 13 Sep 2018 12:37:23 -0700 (PDT)
Received: from [192.168.1.18] (bgv82.neoplus.adsl.tpnet.pl. [83.28.85.82])
        by smtp.gmail.com with ESMTPSA id d16-v6sm864487lfa.42.2018.09.13.12.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 12:37:22 -0700 (PDT)
Subject: Re: [PATCH v8 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <20180908050208.GY2523@minitux> <20180910211935.GA4697@amd>
 <dd1f8dd2-d577-ab12-e67a-7ed71459055a@gmail.com> <20180912191820.GA27704@amd>
 <a82e3d9c-1df8-9e73-7371-613ad550693d@gmail.com> <20180912204156.GA15541@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <48df13cd-af36-7753-8469-54d67937b54d@gmail.com>
Date:   Thu, 13 Sep 2018 21:37:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912204156.GA15541@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 10:41 PM, Pavel Machek wrote:
> Hi!
> 
>>>>> No, we are not back to full circle.
>>>>>
>>>>> Or at least we should not be.
>>>>>
>>>>> Yes, hw_pattern can have some limitation pattern does not, but if you
>>>>> take values from hw_pattern file and put them into pattern file, you
>>>>> should get the same pattern (with more power being consumed). And that
>>>>> property is kind of important for me, because it should keep the ABI
>>>>> reasonable.
>>>>
>>>> If you looked at what we agreed on with Baolin, you'd realize
>>>> that this property is in no way preserved.
>>>> This is what the whole story is about - we're introducing hw_pattern
>>>> because of difficulties in describing breathing pattern by a series
>>>> of [brightness delta_t] tuples.
>>>>
>>>> And Bjorn presented another example. I'm inclined to leave the
>>>> definition of hw_pattern semantics to the LED class drivers,
>>>> and allow them to create related sysfs files.
>>>
>>> Please lets not do that.
>>>
>>> We already have drivers that do that and it is complete
>>> nightmare. Some take binary code for the tiny CPU driving the LED.
>>>
>>> What exactly is the problem? [brightness delta_t] can describe
>>
>> You wrote:
>>
>> <quote>
>> Yes, hw_pattern can have some limitation pattern does not, but if you
>> take values from hw_pattern file and put them into pattern file, you
>> should get the same pattern (with more power being consumed).
>> </quote>
>>
>> The problem is that we decided to introduce hw_pattern to
>> to take away from drivers a responsibility for translating
>> a series of tuples, approximating the brightness curve,
>> to the values that can be written to the hardware registers.
>>
>> Because this is what would need to be done to check if hw can support
>> given series of tuples and activate it. Actually with this approach
>> we wouldn't need hw_pattern at all, since pattern alone would do.
>> But implementation thereof is what we could call a nightmare.
>>
>> What follows, your claim from the quotation is inaccurate:
>> values from hw_pattern written to the pattern file will not
>> produce the same pattern, at least in case of what was proposed
>> in [0] for drivers/leds/leds-sc27xx-bltc.c.
> 
> That sounds easy, see below.
> 
>>> anything single LED can do in finite time. You are right, that
>>> [brightness delta_t] sequence may get rather long, and it may be hard
>>> to turn that sequence into parameters. Are there any _interesting_
>>> sequences hardware can do but [brightness delta_t] can not store
>>> reasonably?
>>
>> Please propose the implementation of pattern_set for
>> drivers/leds/leds-sc27xx-bltc.c breathing pattern, that will
>> setup breathing mode basing on the values from tuples.
>>
>> Use Baolin's patch [0] for a reference of what hardware expects.
>>
>> [0] https://lore.kernel.org/patchwork/patch/984246/
> 
> Yep, so we change documentation to require
> 
> 0 rise_duration brightness high_duration brightness fall_duration 0 low_duration"
> 
> ...and we are done; at least as long as user writes expected pattern
> to the file.
> 
> I'd actually like to see this at begining of function:
>     if (pattern[0].brightness != 0)
>         return -EINVAL;
>     if (pattern[2].brightness != 0)
>         return -EINVAL;
>     if (pattern[3].brightness != 0)
>         return -EINVAL;
>     if (pattern[1].brightness != pattern[2].brightness)
>         return -EINVAL;
> 
> ..so if user writes something unexpected, he gets the error back.
> 
> What am I missing?

I suppose that breathing pattern means smooth rise and fall of
brightness. I'd even say that it should be a non-linear function.

I'm not sure if you noticed my quotation of your statement from the
previous message, because the modification you proposed doesn't
introduce any novelty to the related matter.

The difference between pattern and discussed hw_pattern
semantics is that:

- hw_pattern semantics for leds-sc27xx-bltc.c requires only four
  tuples to setup the breathing pattern.

- the same four tuples written to the pattern file would result
  in four brightness changes

-- 
Best regards,
Jacek Anaszewski
