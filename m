Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbeERMVL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbeERMVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:21:07 -0400
X-Google-Smtp-Source: AB8JxZrOk8PGGCRvlUIswvjbLHl8YdTomQsyho/I4kU8SczEQWsvCazr7fGsZ94gMFtDNNgI7MeOfD4rLd12sZZTeZQ=
MIME-Version: 1.0
In-Reply-To: <7143faaec2d0b7b0fd7e0f3b512839d8@codeaurora.org>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-3-git-send-email-kgunda@codeaurora.org> <20180507162004.GB2259@tuxbook-pro>
 <f970143860bd64624e7fad58333df1be@codeaurora.org> <82fa847760309cb3382bf0a8da50162c@codeaurora.org>
 <CAL_JsqLQvSpB3CiS1sA5AXwbvC0xkd1HqEYsjY+=oripMXSwuA@mail.gmail.com> <7143faaec2d0b7b0fd7e0f3b512839d8@codeaurora.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 18 May 2018 07:20:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJtn9hZJuF2uHC-jDMyM2HS2McBs4fy7JoS_rYj9h0j_w@mail.gmail.com>
Message-ID: <CAL_JsqJtn9hZJuF2uHC-jDMyM2HS2McBs4fy7JoS_rYj9h0j_w@mail.gmail.com>
Subject: Re: [PATCH V1 2/5] backlight: qcom-wled: Add support for WLED4 peripheral
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 10:10 AM,  <kgunda@codeaurora.org> wrote:
> On 2018-05-17 18:01, Rob Herring wrote:
>>
>> On Thu, May 17, 2018 at 4:47 AM,  <kgunda@codeaurora.org> wrote:
>>>
>>> On 2018-05-08 15:55, kgunda@codeaurora.org wrote:
>>>>
>>>>
>>>> On 2018-05-07 21:50, Bjorn Andersson wrote:
>>>>>
>>>>>
>>>>> On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:
>>>>>
>>>>>> WLED4 peripheral is present on some PMICs like pmi8998
>>>>>> and pm660l. It has a different register map and also
>>>>>> configurations are different. Add support for it.

[...]

>>>>>> +                     value:
>>>>>> +                     For pm8941: from 0 to 25000 with 5000 ua step
>>>>>> +                                 Default 20000 uA
>>>>>> +                     For pmi8998: from 0 to 30000 with 5000 ua step
>>>>>> +                                  Default 25000 uA.
>>>>>
>>>>>
>>>>>
>>>>> These values could be described just as well in mA, so keep the
>>>>> original
>>>>> unit - in particular since the boot-limit is in mA...
>>>>>
>>>> Ok. Will keep the original as is in the next series.
>>>
>>>
>>> Here, I may have to go with the approach as in "qcom,ovp". Because for
>>> pm8941
>>> the current step is 1 mA (I have wrongly mentioned as 5000uA here) and
>>> for
>>> PMI8998
>>> the current step is 2.5 mA. Hence, I will add another variable
>>> "qcom,current-limit-ua"
>>> just like "qcom,ovp-mv".
>>
>>
>> Use unit suffixes defined in bindings/property-units.txt.
>
> Thanks for pointing it ! hope I can use "qcom,current-limit-microamp" and
> "qcom,ovp-millivolt". I am asking this because i found only "-microvolt".
> "-millivolt" is not present in the bindings you pointed.

That's by design so everyone doesn't just pick whatever random units
they like. Does microvolts not give you enough range?

Rob
