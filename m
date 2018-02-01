Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbeBADIy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 22:08:54 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38915 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeBADIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 22:08:52 -0500
X-Google-Smtp-Source: AH8x227ox3vvT9xgrkqb0QDl2hWtXpx34j3Ygmojj8LJIyjvP3j82KhdHax7XRA1yGrBDG+B09+NR+keqbYdZ1rzEiA=
MIME-Version: 1.0
In-Reply-To: <CAHp75VcYQMYNmW9-MkOKA5TWV2JgNfqnUB22s1qB4Z0ZZbTG2g@mail.gmail.com>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517313987.git.baolin.wang@linaro.org>
 <cccc1addb9c0cc541b676dbad005ec341d12d165.1517313987.git.baolin.wang@linaro.org>
 <CAHp75Vcig869pUQ5yK1b=GpXinhYkpw1q29OVKSs_7EqP4Hknw@mail.gmail.com>
 <CAMz4kuL9r+97_rDihgKD_TyNaDQ3aCk7go6e4mB24QOpovFYJg@mail.gmail.com> <CAHp75VcYQMYNmW9-MkOKA5TWV2JgNfqnUB22s1qB4Z0ZZbTG2g@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 1 Feb 2018 11:08:46 +0800
Message-ID: <CAMz4kuLO=zRqg72=7dC2fLHyVcEOcsU0PqiZM8XEYC3TGT1fYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
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

On 31 January 2018 at 22:23, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Wed, Jan 31, 2018 at 4:01 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On 31 January 2018 at 00:48, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Tue, Jan 30, 2018 at 2:07 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>> The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
>>>> each group contains 16 GPIOs. Each GPIO can set input/output and has
>>>> the interrupt capability.
>>>
>>>> +config GPIO_SPRD
>>>
>>>> +       bool "Spreadtrum GPIO support"
>>>
>>> Either you have to put tristate here, or remove all redundant
>>> module_*() and MODULE_*() macros.
>>
>> I will remove module_*() and MODULE_*() macros in next version. Thanks
>> for your comments.
>
> In that case you need to explain why driver can't be module. (And
> don't forget to replace module.h with init.h).

After more investigation, I found most GPIO dependencies can be
deferred to probe. So I will change the GPIO driver to module level
and change bool to tristate in next version.

-- 
Baolin.wang
Best Regards
