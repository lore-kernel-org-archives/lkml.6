Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeB1CWL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:22:11 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46714 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeB1CWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:22:09 -0500
X-Google-Smtp-Source: AH8x226yU8mFIHTGvXi0dT2b9lJvY11J9eYkHSYqSlnDkLYJIEqQFiiCJCwUH9INVDDTliDa1r+/W0M0c0C/VMJKbh0=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfes+7yKRu1Q+V91c4SxPgNbvBKKDWLxy34Q+3GauRcoQ@mail.gmail.com>
References: <334505d3a13a73ad347427b408ed581832434289.1519468782.git.baolin.wang@linaro.org>
 <f4a2fefb4c3179e7598dbc8141a661833200b922.1519468782.git.baolin.wang@linaro.org>
 <CAHp75VdvLDEmNs-YUFYf+Og18kaU6j6zAxXc1w31X2vw26ACHQ@mail.gmail.com>
 <CAMz4kuJ+BmWnSFFvE91Ric-Wm6tzxs_a5UWMx82tPj_ZVvC4tw@mail.gmail.com>
 <CAHp75VeJiqp74LrsETHTwxd5iaOObRX5bdYXz=rYeHm-4KbgHA@mail.gmail.com>
 <CAMz4kuJYEfwLHexq-KA6d9+u4+Cx2M9TAeEkHbbU4GJ-Sz50gg@mail.gmail.com> <CAHp75Vfes+7yKRu1Q+V91c4SxPgNbvBKKDWLxy34Q+3GauRcoQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 28 Feb 2018 10:22:08 +0800
Message-ID: <CAMz4kuJJpVEbvS8pUaqW6qQYo1K=y61yb+JsfU9rQ6GKNotRYw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: Add Spreadtrum PMIC EIC driver support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 February 2018 at 23:54, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Tue, Feb 27, 2018 at 4:35 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On 26 February 2018 at 20:02, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Mon, Feb 26, 2018 at 5:01 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>> On 25 February 2018 at 20:19, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>>>>>> +       for (n = 0; n < chip->ngpio; n++) {
>>>>>> +               if (!(BIT(n) & val))
>>>>>
>>>>> for_each_set_bit().
>>>>>
>>>>> At some point you may need just to go across lib/ in the kernel and
>>>>> see what we have there.
>>>>
>>>> I've considered the for_each_set_bit(), it need one 'unsigned long'
>>>> type parameter, but we get the value from regmap is 'u32' type. So we
>>>> need one extra conversion from 'u32' to 'unsigned long' like:
>>>>
>>>> unsigned long reg = val;
>>>>
>>>> for_each_set_bit(n, &reg, chip->ngpio) {
>>>>         .......
>>>> }
>>>>
>>>> If you like this conversion, then I can change to use
>>>> for_each_set_bit(). Thanks.
>>>
>>> Wouldn't it work like
>>>
>>> unsigned long val;
>>>
>>> ...regmap_read(..., &val);
>>>
>>> ?
>>
>> It can not work, regmap_read() expects 'unsigned int *'.
>
> Ah, OK, than the temporary variable is a left approach.
>
>> But I can
>> convert it like this:
>>
>> for_each_set_bit(n, (unsigned long *)&val, chip->ngpio) {
>>          .......
>> }
>
> No, this is a boilerplate for static analyzers and definitely UB.

OK. Thanks for pointing this issue out.

-- 
Baolin.wang
Best Regards
