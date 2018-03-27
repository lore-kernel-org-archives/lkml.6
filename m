Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeC0J35 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:29:57 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43059 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeC0J3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:29:54 -0400
X-Google-Smtp-Source: AG47ELtneDx4/LFYxs0EGbjCMVcyGvCJ+W70w4OcyiZT7kHffzwUwL/z0xyu4zdEoQOdkFRLeFUz8ve1S8iXmrphQbQ=
MIME-Version: 1.0
In-Reply-To: <6c55e081-57ba-6c39-8494-cda5022aa927@ti.com>
References: <20180323130455.11470-1-brgl@bgdev.pl> <152182378792.178046.3747112581117251857@swboyd.mtv.corp.google.com>
 <CAMRc=MfEebDk4D=t-ybRgbn+HaY7RUfOFCDAf9H8F3cZRchJmA@mail.gmail.com>
 <152182490783.178046.1191965992600877708@swboyd.mtv.corp.google.com>
 <CAMRc=MdmTAwPAAnL1+n+OXSycnyjuQ1hKmts158mPcgat1NUYQ@mail.gmail.com> <6c55e081-57ba-6c39-8494-cda5022aa927@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 27 Mar 2018 11:29:53 +0200
Message-ID: <CAMRc=MdkfrEvMrFtf_TUDcMVHNC2O9zw8Mn0pQnyFw3iMqVmmg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] ARM: davinci: complete the conversion to using the
 reset framework
To: Sekhar Nori <nsekhar@ti.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-27 8:09 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> Hi Bart,
>
> On Friday 23 March 2018 10:46 PM, Bartosz Golaszewski wrote:
>> 2018-03-23 18:08 GMT+01:00 Stephen Boyd <sboyd@kernel.org>:
>>> Quoting Bartosz Golaszewski (2018-03-23 09:55:47)
>>>> 2018-03-23 17:49 GMT+01:00 Stephen Boyd <sboyd@kernel.org>:
>>>>> Quoting Bartosz Golaszewski (2018-03-23 06:04:47)
>>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>>
>>>>>> This series converts the only user of the handcoded, mach-specific reset
>>>>>> routines in the davinci platform to using the reset framework.
>>>>>>
>>>>>> Patch 1 modifies the way lookup entries are registered with the reset
>>>>>> framework.
>>>>>>
>>>>>> Patches 2-4 add necessary lookups/DT-properties.
>>>>>>
>>>>>> Patches 5-7 convert the davinci-rproc driver to the reset framework.
>>>>>>
>>>>>> Patch 8 removes now dead code.
>>>>>>
>>>>>> Philipp: it turned out that it's indeed better to use the reset
>>>>>> controller's device name for the entry lookup.
>>>>>>
>>>>>> Tested both in DT and legacy modes by booting the examples from
>>>>>> ti-ipc-rtos recipe in meta-ti.
>>>>>>
>>>>>> This series applies on top of David Lechner's common-clk-v9 branch[1]
>>>>>> with Philipp Zabel's reset/next branch[2] pulled in.
>>>>>>
>>>>>> It can be found in my github tree as well[3].
>>>>>>
>>>>>
>>>>> What's the merge strategy for the rest of the patches? I should apply
>>>>> the clk ones after the next -rc1?
>>>>
>>>> Or maybe Philipp can provide us with an immutable branch with the reset patches?
>>>>
>>>> The you could apply the driver patches and let Sekhar take all the
>>>> platform code?
>>>>
>>>
>>> Ok that could work too.
>>
>> Ohad, Bjorn can you ack the remoteproc patches? Are you OK with
>> Stephen taking them through the clock tree? Otherwise it would get
>> complicated since they depend on the first clk patch and the last clk
>> patch depends on them.
>
> I will not be queuing the DTS patches for v4.17. They depend on clock
> framework DTS patches which itself I plan to queue for v4.18. Given
> this, I think the best bet is:
>
> Ohad/Bjorn queue remoteproc patches already acked by Suman and having no
> dependencies. That is, 5/8 and 6/8.
>
> If Philipp can provide an immutable branch with reset changes, it will
> be great and Stephen can queue 4/8. If not, its best to resend that
> patch to Stephen once v4.17-rc1 is out.
>
> The remaining patches need to wait till v4.18 (or even v4.19 if
> dependencies don't pan out well).
>
> Thanks,
> Sekhar

Very good, thanks.

I've just sent out a v3 with three non-reset remoteproc patches that
can already be applied by Suman.

Thanks,
Bartosz
