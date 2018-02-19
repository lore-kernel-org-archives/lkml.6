Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeBSKtK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:49:10 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40953 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeBSKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:49:08 -0500
X-Google-Smtp-Source: AH8x226uchAwU0CIbdAYQ4lIFkheqF88oa3k/K5qAXYr7k3Jrn/PujVG2E8b0bDD2MBliX2Z7DNl2girLMQ+hKt+FiM=
MIME-Version: 1.0
In-Reply-To: <79a981ae-881f-b358-629c-0b64e48f192d@lechnology.com>
References: <20180207134553.13510-1-brgl@bgdev.pl> <4dbc57ec-3506-eb1d-e00d-adfe75c3b39b@lechnology.com>
 <a736d727-5805-94ea-3e40-34fc4a6267ef@ti.com> <79a981ae-881f-b358-629c-0b64e48f192d@lechnology.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 19 Feb 2018 11:49:07 +0100
Message-ID: <CAMpxmJXc6Fr+JhN8WxXGAYRzkk9+u+cCkHGtsXAT-3ikw408rg@mail.gmail.com>
Subject: Re: [PATCH 0/7] ARM: davinci: add genpd support
To: David Lechner <david@lechnology.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-18 4:41 GMT+01:00 David Lechner <david@lechnology.com>:
> On 02/09/2018 06:42 AM, Sekhar Nori wrote:
>>
>> Hi David,
>>
>> On Thursday 08 February 2018 04:13 AM, David Lechner wrote:
>>>
>>> On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
>>>>
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> Hi Sekhar et al,
>>>>
>>>> please take a look at the following patches. They add a simple genpd
>>>> driver and use it in DT mode on da850 boards.
>>>>
>>>> I was trying to use genpd in legacy mode too, but couldn't find neither
>>>> any interfaces nor users that would do that. For now I added a check in
>>>> arch/arm/mach-davinci/pm_domain.c that disables the clock pm setup if
>>>> we're using genpd.
>>>>
>>>> This series applies on top of and has been tested with David Lechner's
>>>> for-bartosz branch. It fixes the clock look-up issues we faced with
>>>> lcdc and emac.
>>>
>>>
>>> I'm starting to think that it makes more sense to just make the PSC
>>> driver
>>> a power-domain and reset provider rather than a clock provider. It is
>>> unfortunate that genpd is DT only.
>>
>>
>> This will mean that the only way to enable clocks on DaVinci is to use
>> pm_runtime() calls. We do still have drivers which depend on clk api for
>> enabling clocks, so I am not sure its feasible just yet.
>>
>> I think a question like this can arise for any gate clock.
>>
>
> I've incorporated parts of this series into my v7 work in progress
> using the suggestions I made about using the existing PSC device
> as the power domain provider.
>

FYI I had added the power domain functionality to the v6 PSC driver
here: https://github.com/brgl/linux/commits/topic/davinci-genpd-final-v2

Thanks,
Bartosz
