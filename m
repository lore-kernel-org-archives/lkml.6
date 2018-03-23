Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeCWRQJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:16:09 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36478 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeCWRQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:16:07 -0400
X-Google-Smtp-Source: AG47ELtU0lrp6i6Fu3rfP+ps4Vlz2ssrkgPeAqQDllw1lrI+MdSuObE+aokbIV6CCuCfZfyo0Szp25uIWV/UDq4Uv1Q=
MIME-Version: 1.0
In-Reply-To: <152182490783.178046.1191965992600877708@swboyd.mtv.corp.google.com>
References: <20180323130455.11470-1-brgl@bgdev.pl> <152182378792.178046.3747112581117251857@swboyd.mtv.corp.google.com>
 <CAMRc=MfEebDk4D=t-ybRgbn+HaY7RUfOFCDAf9H8F3cZRchJmA@mail.gmail.com> <152182490783.178046.1191965992600877708@swboyd.mtv.corp.google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Mar 2018 18:16:06 +0100
Message-ID: <CAMRc=MdmTAwPAAnL1+n+OXSycnyjuQ1hKmts158mPcgat1NUYQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] ARM: davinci: complete the conversion to using the
 reset framework
To: Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc: David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Sekhar Nori <nsekhar@ti.com>, devicetree <devicetree@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-23 18:08 GMT+01:00 Stephen Boyd <sboyd@kernel.org>:
> Quoting Bartosz Golaszewski (2018-03-23 09:55:47)
>> 2018-03-23 17:49 GMT+01:00 Stephen Boyd <sboyd@kernel.org>:
>> > Quoting Bartosz Golaszewski (2018-03-23 06:04:47)
>> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> >>
>> >> This series converts the only user of the handcoded, mach-specific reset
>> >> routines in the davinci platform to using the reset framework.
>> >>
>> >> Patch 1 modifies the way lookup entries are registered with the reset
>> >> framework.
>> >>
>> >> Patches 2-4 add necessary lookups/DT-properties.
>> >>
>> >> Patches 5-7 convert the davinci-rproc driver to the reset framework.
>> >>
>> >> Patch 8 removes now dead code.
>> >>
>> >> Philipp: it turned out that it's indeed better to use the reset
>> >> controller's device name for the entry lookup.
>> >>
>> >> Tested both in DT and legacy modes by booting the examples from
>> >> ti-ipc-rtos recipe in meta-ti.
>> >>
>> >> This series applies on top of David Lechner's common-clk-v9 branch[1]
>> >> with Philipp Zabel's reset/next branch[2] pulled in.
>> >>
>> >> It can be found in my github tree as well[3].
>> >>
>> >
>> > What's the merge strategy for the rest of the patches? I should apply
>> > the clk ones after the next -rc1?
>>
>> Or maybe Philipp can provide us with an immutable branch with the reset patches?
>>
>> The you could apply the driver patches and let Sekhar take all the
>> platform code?
>>
>
> Ok that could work too.

Ohad, Bjorn can you ack the remoteproc patches? Are you OK with
Stephen taking them through the clock tree? Otherwise it would get
complicated since they depend on the first clk patch and the last clk
patch depends on them.

Thanks,
Bart
