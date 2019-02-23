Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F94C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AB820651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="K9bteh2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfBWUhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 15:37:06 -0500
Received: from 7of9.schinagl.nl ([62.251.20.244]:53406 "EHLO 7of9.schinagl.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfBWUhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 15:37:05 -0500
Received: from [10.2.10.179] (unknown [10.2.10.179])
        by 7of9.schinagl.nl (Postfix) with ESMTPA id D486FB5384B;
        Sat, 23 Feb 2019 21:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1550954221; bh=88LWWcj7fcRVMVK90+45rSyZSRbvwN2y/snql8jgUTU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=K9bteh2qN1BX0yis+WXdR28PJ9Cj8xJ3ZkGOpVdhhPr9/neX3OpthAQUZHzIxpRDg
         GB/MYY57tjUOliODUKN0HJ8up4JAhxwTPH/yX2RO/CyOayqpbd8kmP8ZPugxiEGc13
         ofCI/a9/N/ZbRWIoc1WGDCAYmTosSrPsHtgpFZSU=
Subject: Re: [PATCH] regulator: axp20x: Get rid of AXP20X_xxx_START/END/STEPS
 defines
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190220165013.12774-1-axel.lin@ingics.com>
 <24E35288-677D-4223-B94A-52A4F37792A8@schinagl.nl>
 <CAFRkauAPGEBxj7k2GvmFwhyc7ZuofhXou17b75F3G-mUWVaf9A@mail.gmail.com>
 <20190221094237.GA5970@sirena.org.uk>
 <d52c2711-71f3-9e72-f01b-e761f4a92a07@schinagl.nl>
 <CAFRkauDdx00VmqhmzohdCyWbPkctCU2D03JqkpSw2x7n-bDzHA@mail.gmail.com>
From:   Olliver Schinagl <oliver@schinagl.nl>
Message-ID: <15e97e28-0008-cda4-176d-a3feb9ad4e8a@schinagl.nl>
Date:   Sat, 23 Feb 2019 21:37:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAFRkauDdx00VmqhmzohdCyWbPkctCU2D03JqkpSw2x7n-bDzHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: nl-BE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-2019 13:54, Axel Lin wrote:
>> I will not disagree that it may be extra work to look up the define
>> (especially if there is no tool tip or split view in the editor) but
>> reading the whole lot of code, with only the magic values, you still
>> have to look up the meaning of each magic value, have to guess which one
>> has the same meaning etc.
>>
>> Further more, I do believe far more people reading will find an define
>> to be more descriptive to read. Whoever needs to actually go in and
>> fix/change things.
> I disagree.
> The reason I sent this patch is because these defines reduce readability.
> I do care about readability, but in this case these defines make
> readability worsen.
Well this really is up to personal preference isn't it? As personally
find it much nicer to read without the magics :) If I actually have to
modify or go into the actual meaning, then yes, I will have to dig into
it a little deeper. But the overal code to a passer by, is still in my
opinion much more readable.
>
> At the context of REGULATOR_LINEAR_RANGE, each fields has well known meaning.
> When I look at the table with values (I don't care if it's hex or decimal),
> it tells everything I need to know.
> I can easily check if any linear ranger cover other ranges.
> I can easily check if any gap between linar ranges, (probably due to
> reserved bits).
> I can easily count the number of entries in each range.
> I can easily calculate the min/max voltage of each range and double
> check with datasheet.
> i.e. If there are something wrong, it's eash to detect it.

In any case, you seem like a smart person that reads and writes hex and
bits often enough. This is not true for everyone. I can just as easily
reverse your arguments of course, for example, 'each field has a well
known meaning' ... to whom? People that use these things daily, sure.
People who just need to double check something or modify something, not
so much. They have to look up the MACRO, the struct its in, compare it
to others, so as you can see, what is natural for you, is not true for
everyone. :)

Also, the general consensus is still to avoid magic values, and to stay
consistent with the rest and not make expceptions, it makes sense to
have defines instead of magic values.

>
> When you change the values to DEFINES, I have to check the value of
> each define *one-by-one*.
> There is no benefit in this case.
>
> I don't mean adding DEFINES is wrong. Just in this case it does not
> help and actually has downside.
> I only remove AXP20X_xxx_START/END/STEPS defines, not all defines.
>
> BTW, just show you an example (from drivers/regulator/88pm8607.c)
> I don't think change all below values to DEFINES help in readability.
> static const unsigned int BUCK1_table[] = {
>          725000,  750000,  775000,  800000,  825000,  850000,  875000,  900000,
>          925000,  950000,  975000, 1000000, 1025000, 1050000, 1075000, 1100000,
>         1125000, 1150000, 1175000, 1200000, 1225000, 1250000, 1275000, 1300000,
>         1325000, 1350000, 1375000, 1400000, 1425000, 1450000, 1475000, 1500000,
>               0,   25000,   50000,   75000,  100000,  125000,  150000,  175000,
>          200000,  225000,  250000,  275000,  300000,  325000,  350000,  375000,
>          400000,  425000,  450000,  475000,  500000,  525000,  550000,  575000,
>          600000,  625000,  650000,  675000,  700000,  725000,  750000,  775000,
> };

Personally, I think this is a horrible table :p sure, I can guess that
these are voltages (based on the fact that it's a regulator table and I
am a little familiar here), but without knowing the context, I see a
bunch of voltages, from 0,725 to 1,5 appearantly in equal steps, but the
first question I ask, is the step always .25? I can't see, i'd have to
go over each value and compare them all. Quite cumbersome ;)

And then, there is a nother row, which starts after the 1.5 but at 0 and
goes to 7.75. Are these two the same regulator? Why the overlap?

The only way to save this, would be with 2 linear range define/macro's,
with a start voltage, and end voltage and steps; right? So yes, macro's
and defines would help immensly here :)

>
>
> Regards,
> Axel


