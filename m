Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeBAM1F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:27:05 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35650 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbeBAM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:27:00 -0500
X-Google-Smtp-Source: AH8x224/VBAJr2l8KYpET7bNdsmNLJlFmHOMbaLjJMMSNlZwhuLWhMGTuv5IgqrZ/4mynU0DXipUBEYVkg7cuSm1AqY=
MIME-Version: 1.0
In-Reply-To: <20180201122230.GC690@gmail.com>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517313987.git.baolin.wang@linaro.org>
 <cccc1addb9c0cc541b676dbad005ec341d12d165.1517313987.git.baolin.wang@linaro.org>
 <CAHp75Vcig869pUQ5yK1b=GpXinhYkpw1q29OVKSs_7EqP4Hknw@mail.gmail.com>
 <CAMz4kuL9r+97_rDihgKD_TyNaDQ3aCk7go6e4mB24QOpovFYJg@mail.gmail.com>
 <CAHp75VcYQMYNmW9-MkOKA5TWV2JgNfqnUB22s1qB4Z0ZZbTG2g@mail.gmail.com>
 <CAMz4kuLO=zRqg72=7dC2fLHyVcEOcsU0PqiZM8XEYC3TGT1fYA@mail.gmail.com> <20180201122230.GC690@gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 1 Feb 2018 20:26:59 +0800
Message-ID: <CAMz4ku+J7RwkthJn9TbYCuVYWnUyD8sCLs892G_SO=vWxr2ddA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 February 2018 at 20:22, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> On Thu, Feb 01, 2018 at 11:08:46AM +0800, Baolin Wang wrote:
>> On 31 January 2018 at 22:23, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> > On Wed, Jan 31, 2018 at 4:01 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> >> On 31 January 2018 at 00:48, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> >>> On Tue, Jan 30, 2018 at 2:07 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> >>>> The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
>> >>>> each group contains 16 GPIOs. Each GPIO can set input/output and has
>> >>>> the interrupt capability.
>> >>>
>> >>>> +config GPIO_SPRD
>> >>>
>> >>>> +       bool "Spreadtrum GPIO support"
>> >>>
>> >>> Either you have to put tristate here, or remove all redundant
>> >>> module_*() and MODULE_*() macros.
>> >>
>> >> I will remove module_*() and MODULE_*() macros in next version. Thanks
>> >> for your comments.
>> >
>> > In that case you need to explain why driver can't be module. (And
>> > don't forget to replace module.h with init.h).
>>
>> After more investigation, I found most GPIO dependencies can be
>> deferred to probe. So I will change the GPIO driver to module level
>> and change bool to tristate in next version.
>
> Then you could replace
>
> +static int __init sprd_gpio_init(void)
> +{
> +       return platform_driver_register(&sprd_gpio_driver);
> +}
> +subsys_initcall(sprd_gpio_init);
> +
> +static void __exit sprd_gpio_exit(void)
> +{
> +       platform_driver_unregister(&sprd_gpio_driver);
> +}
> +module_exit(sprd_gpio_exit);
>
> with
>
> module_platform_driver(sprd_gpio_driver);

Yes, I already did this in V2 patch set, you can refer to the V2 patch
set. Thanks.

-- 
Baolin.wang
Best Regards
