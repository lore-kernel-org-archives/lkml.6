Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeCXAcD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 20:32:03 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:62933 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeCXAb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 20:31:58 -0400
Subject: Re: [PATCH v4 0/8] ARM: davinci: complete the conversion to using the
 reset framework
To: Bartosz Golaszewski <brgl@bgdev.pl>, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
CC: David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Sekhar Nori <nsekhar@ti.com>, devicetree <devicetree@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180323130455.11470-1-brgl@bgdev.pl>
 <152182378792.178046.3747112581117251857@swboyd.mtv.corp.google.com>
 <CAMRc=MfEebDk4D=t-ybRgbn+HaY7RUfOFCDAf9H8F3cZRchJmA@mail.gmail.com>
 <152182490783.178046.1191965992600877708@swboyd.mtv.corp.google.com>
 <CAMRc=MdmTAwPAAnL1+n+OXSycnyjuQ1hKmts158mPcgat1NUYQ@mail.gmail.com>
From: Suman Anna <s-anna@ti.com>
Message-ID: <c78817f9-02fd-0ded-609e-5014efdd4a77@ti.com>
Date: Fri, 23 Mar 2018 19:30:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdmTAwPAAnL1+n+OXSycnyjuQ1hKmts158mPcgat1NUYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 03/23/2018 12:16 PM, Bartosz Golaszewski wrote:
> 2018-03-23 18:08 GMT+01:00 Stephen Boyd <sboyd@kernel.org>:
>> Quoting Bartosz Golaszewski (2018-03-23 09:55:47)
>>> 2018-03-23 17:49 GMT+01:00 Stephen Boyd <sboyd@kernel.org>:
>>>> Quoting Bartosz Golaszewski (2018-03-23 06:04:47)
>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>
>>>>> This series converts the only user of the handcoded, mach-specific reset
>>>>> routines in the davinci platform to using the reset framework.
>>>>>
>>>>> Patch 1 modifies the way lookup entries are registered with the reset
>>>>> framework.
>>>>>
>>>>> Patches 2-4 add necessary lookups/DT-properties.
>>>>>
>>>>> Patches 5-7 convert the davinci-rproc driver to the reset framework.
>>>>>
>>>>> Patch 8 removes now dead code.
>>>>>
>>>>> Philipp: it turned out that it's indeed better to use the reset
>>>>> controller's device name for the entry lookup.
>>>>>
>>>>> Tested both in DT and legacy modes by booting the examples from
>>>>> ti-ipc-rtos recipe in meta-ti.
>>>>>
>>>>> This series applies on top of David Lechner's common-clk-v9 branch[1]
>>>>> with Philipp Zabel's reset/next branch[2] pulled in.
>>>>>
>>>>> It can be found in my github tree as well[3].
>>>>>
>>>>
>>>> What's the merge strategy for the rest of the patches? I should apply
>>>> the clk ones after the next -rc1?
>>>
>>> Or maybe Philipp can provide us with an immutable branch with the reset patches?
>>>
>>> The you could apply the driver patches and let Sekhar take all the
>>> platform code?
>>>
>>
>> Ok that could work too.
> 
> Ohad, Bjorn can you ack the remoteproc patches? Are you OK with
> Stephen taking them through the clock tree? Otherwise it would get
> complicated since they depend on the first clk patch and the last clk
> patch depends on them.

I will take a closer look and test on Mon. A quick glance of the
remoteproc changes seem to be fine. I will let Bjorn comment on the
patch flow.

The only reason I had to use the clock in the driver was for the reset
before, and hopefully this will allow me to actually switch to using
pm_runtime API like I do with the rest of the TI remoteproc drivers
(Keystone remoteproc driver also uses PSC for clock and reset but then
it goes through different set of drivers).

So, I see a mix of driver and dts patches in the series, are all the dts
patches coming through Sekhar?

regards
Suman

> 
> Thanks,
> Bart
> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
