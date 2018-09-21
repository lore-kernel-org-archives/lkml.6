Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8452ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C3521522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROigMOcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C3521522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbeIUROy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:14:54 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37319 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389746AbeIUROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:14:53 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so11092335oic.4;
        Fri, 21 Sep 2018 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vw0e28fwSZC5UQc5BVCOLbGo+yoDvxKS5llDJY/qwuw=;
        b=ROigMOcFwVzgIKkSC+Aknm0Yax5z0Bt8xgKkCSE602kGi3Mg1H89oSwI9d46wRyeYb
         RmpEM1L+CX9xG7Y0cD3G8bjDAk9loiENARMpt4/cl+s4sbAF827q2sXS8B7MJHDoJ8+x
         1ft5+Kurt9joBNo4X5ao8WPtyNq8V5hc/KNVkaSKBCOk605wL+3z84Ln7u7ZFSXum9yd
         ALQhTfBF67cVHE9rgJlEbV9vmFY74FCP546IxE4NqmVgsHt7MM9jUdJ8PT5Et484Hgmr
         ujH7or+JK3H7PFKL7j+KDnJXqKO0WywjaLTAx/QtCsDaW+M7ZwbYcgTxRE/qL8uYY89B
         iNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vw0e28fwSZC5UQc5BVCOLbGo+yoDvxKS5llDJY/qwuw=;
        b=mXH1QZFLwT9vE7UUB2Ue3Cb9fcDZ6aJbWSQIYvbqqEf4TSAzfVRUxj22mNqPOpyCeI
         p0/KP7MgJyXdujbQIpFbfR5dE/gF+pn6PpcshxQuI5vcgMtY44i7rcwbhCwnywFVDIKt
         YwUc3yAJG8s1L/Z5GJZCAaCJamxFhqakXX/dNvdwf55JO+iNHgGRS/3Zg0i3IjEEPVKF
         GdGZXmJ5YVD2H8r2zJq1Jb18MQz3DAw4T05PKe90+kDCwRym0epZj+Xuk91bBt6pQMDN
         yZABu+wk5FxIz4wR1DM+IWpSmlB/N3kLQibTCguDpRzcHdKkTFkSlS9QxYXgw1nId7Xt
         UetA==
X-Gm-Message-State: APzg51D0Wr9JwLmW4dzmqYIyu753a9JeQWD/vA8teFYE/uDFZCrR7T1D
        1eA8F/82I3R22g/DWiDvrK/lBM6DXmi1EZnzlWM=
X-Google-Smtp-Source: ANB0VdafiVnEdFrQToTn9wM0Xe6RT2xOW2OQq+5nQujhuaoYp8VK0cG8EgGXzov8VsAS5gAzbms9VqsJmCNHwRAJ5Vw=
X-Received: by 2002:aca:2203:: with SMTP id b3-v6mr1358004oic.366.1537529186279;
 Fri, 21 Sep 2018 04:26:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:326:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 04:26:25 -0700 (PDT)
In-Reply-To: <CAGfqbt7xJxGbq3oOJp9S0Sg7Z9=T6Dy52MDNWSDdsU==kPt1KQ@mail.gmail.com>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
 <9860023.SlBYqtbjDV@z50> <CGME20180920161947epcas3p491e6c136fe05d9672c81b7b4b8328f64@epcas3p4.samsung.com>
 <15226900.TQMLYV7PZ0@z50> <20180921081806eucas1p182d4646e8510b5f0356214af7edba11e~WXF8Ptw4M0970709707eucas1p1p@eucas1p1.samsung.com>
 <CAGfqbt7xJxGbq3oOJp9S0Sg7Z9=T6Dy52MDNWSDdsU==kPt1KQ@mail.gmail.com>
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date:   Fri, 21 Sep 2018 13:26:25 +0200
Message-ID: <CAGfqbt6chUGTDQ-yjppMydet+LFLAjpVzzRsr4+ho3Nu9y_2UQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in get/set array
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

2018-09-21 12:51 GMT+02:00, Janusz Krzysztofik <jmkrzyszt@gmail.com>:
> Hi Marek,
>
> 2018-09-21 10:18 GMT+02:00, Marek Szyprowski <m.szyprowski@samsung.com>:
>> Hi Janusz,
>>
>> On 2018-09-20 18:21, Janusz Krzysztofik wrote:
>>> On Thursday, September 20, 2018 5:48:22 PM CEST Janusz Krzysztofik
>>> wrote:
>>>> On Thursday, September 20, 2018 12:11:48 PM CEST Marek Szyprowski
>>>> wrote:
>>>>> On 2018-09-02 14:01, Janusz Krzysztofik wrote:
>>>>>> Certain GPIO descriptor arrays returned by gpio_get_array() may
>>>>>> contain
>>>>>> information on direct mapping of array members to pins of a single
>>>>>> GPIO
>>>>>> chip in hardware order.  In such cases, bitmaps of values can be
>>>>>> passed
>>>>>> directly from/to the chip's .get/set_multiple() callbacks without
>>>>>> wasting time on iterations.
>>>>>>
>>>>>> Add respective code to gpiod_get/set_array_bitmap_complex()
>>>>>> functions.
>>>>>> Pins not applicable for fast path are processed as before, skipping
>>>>>> over the 'fast' ones.
>>>>>>
>>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>>>> I've just noticed that this patch landed in today's linux-next. Sadly
>>>>> it
>>>>> breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
>>>>> device-tree source arch/arm/boot/dts/exynos5250-snow.dts).
>>>>>
>>>>> Booting hangs after detecting MMC cards. Reverting this patch fixes
>>>>> the
>>>>> boot. I will try later to add some debugs and investigate it further
>>>>> what
>>>>> really happens when booting hangs.
>>>> Hi Marek,
>>>>
>>>> Thanks for reporting. Could you please try the following fix?
>>> Hi again,
>>>
>>> I realized the patch was not correct, j, not i, should be updated in
>>> second
>>> hunk. Please try the following one.
>>>
>>> Thanks,
>>> Janusz
>>>
>>> >From a919c504850f6cb40e8e81267a3a37537f7c4fd4 Mon Sep 17 00:00:00 2001
>>> From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>> Date: Thu, 20 Sep 2018 17:37:21 +0200
>>> Subject: [PATCH] gpiolib: Fix bitmap index not updated
>>> While skipping fast path bits, bitmap index is not updated with next
>>> found zero bit position. Fix it.
>>>
>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>
>> This one also doesn't help. A quick compare of logs with this version and
>> a working system shows, that with your patch (and fix) there are no calls
>> to
>> gpx0-2 pin (which are a part of mmc pwrseq), what causes mmc failure. If
>> you need any more information (what kind of logs will help?), let me
>> know.

One more question. You said before that booting hanged after detecting MMC
cards.  Without the fix, I could imagine it keeps iterating with index not
updated and simply never returns from gpiod_get/set_array_bitmap_complex().
Is the behaviour you observe the same with the fix applied?

Thanks,
Janusz

> There is a debug message on array_info content available at the end of
> gpiod_get_array(), could you please activate it and post the message so
> we can understand better what is going on?
>
> On the other hand, I've had a look your device-tree configuration and
> it looks like that specific setup won't benefit from the fast bitmap path.
> You have pin 2 at position 0 and pin 1 at position 1 of the array.
> Hence, the fast bitmap path covers only pin 1, and pin 2 is processed
> by the old path with apparently buggy code for skipping over fast pins.
>
> As a temporary workaround, you could try to revert the order of pins in
> your dts file (pin 1 at position 0, pin 2 at 1) and the mmc pwrseq code
> should work for you again by taking the original old path, not skipping
> over fast pins.  Results of such check may also help us to better
> understand and resolve the issue.
>
> Thanks,
> Janusz
>
>>
>>> ---
>>>   drivers/gpio/gpiolib.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>>> index a53d17745d21..369bdd358fcc 100644
>>> --- a/drivers/gpio/gpiolib.c
>>> +++ b/drivers/gpio/gpiolib.c
>>> @@ -2880,7 +2880,7 @@ int gpiod_get_array_value_complex(bool raw, bool
>>> can_sleep,
>>>   			__set_bit(hwgpio, mask);
>>>
>>>   			if (array_info)
>>> -				find_next_zero_bit(array_info->get_mask,
>>> +				i = find_next_zero_bit(array_info->get_mask,
>>>   						   array_size, i);
>>>   			else
>>>   				i++;
>>> @@ -2905,7 +2905,8 @@ int gpiod_get_array_value_complex(bool raw, bool
>>> can_sleep,
>>>   			trace_gpio_value(desc_to_gpio(desc), 1, value);
>>>
>>>   			if (array_info)
>>> -				find_next_zero_bit(array_info->get_mask, i, j);
>>> +				j = find_next_zero_bit(array_info->get_mask, i,
>>> +						       j);
>>>   			else
>>>   				j++;
>>>   		}
>>> @@ -3192,7 +3193,7 @@ int gpiod_set_array_value_complex(bool raw, bool
>>> can_sleep,
>>>   			}
>>>
>>>   			if (array_info)
>>> -				find_next_zero_bit(array_info->set_mask,
>>> +				i = find_next_zero_bit(array_info->set_mask,
>>>   						   array_size, i);
>>>   			else
>>>   				i++;
>>
>> Best regards
>> --
>> Marek Szyprowski, PhD
>> Samsung R&D Institute Poland
>>
>>
>
