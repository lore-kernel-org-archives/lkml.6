Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbeBEUbO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:31:14 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36324 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeBEUbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:31:06 -0500
X-Google-Smtp-Source: AH8x226WcWw/kEMkgH5p+VRlJlTabm98W4GKbmGrt8YTKeuXTlSuDMReuOj5RhPYM/7HeV9hHoCnL3eSv6K9wnNbijc=
MIME-Version: 1.0
In-Reply-To: <20180205140134.GN3404@piout.net>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-6-ulfalizer@gmail.com>
 <CAFkk2KRmK=fw=WYwr3eC8RJh7nxsUvC=uUnz7UCni72H9sHv4g@mail.gmail.com> <20180205140134.GN3404@piout.net>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 5 Feb 2018 21:31:04 +0100
Message-ID: <CAFkk2KRt0wWY0Q6S-R-wKa6iKrmnmj6HRfDmDrHu942joEPpRg@mail.gmail.com>
Subject: Re: [PATCH 05/20] rtc: at32ap700x: Remove PLATFORM_AT32AP dependency
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        tfiga@chromium.org, paul.burton@mips.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org,
        Paul Mackerras <paulus@ozlabs.org>, will.deacon@arm.com,
        Tony Lindgren <tony@atomide.com>, Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 3:01 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 05/02/2018 at 02:42:38 +0100, Ulf Magnusson wrote:
>> On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> > The PLATFORM_AT32AP symbol went away when AVR32 was removed in
>> > commit 26202873bb51 ("avr32: remove support for AVR32 architecture").
>> >
>> > Remove the RTC_DRV_AT32AP700X dependency from RTC_DRV_AT32AP700X.
>> >
>> > Discovered with the
>> > https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
>> > script.
>> >
>> > Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> > ---
>> >  drivers/rtc/Kconfig | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> > index b71cc7b5fbc9..1f5f3bd82ab6 100644
>> > --- a/drivers/rtc/Kconfig
>> > +++ b/drivers/rtc/Kconfig
>> > @@ -1404,7 +1404,7 @@ config RTC_DRV_PL031
>> >
>> >  config RTC_DRV_AT32AP700X
>> >         tristate "AT32AP700X series RTC"
>> > -       depends on PLATFORM_AT32AP || COMPILE_TEST
>> > +       depends on COMPILE_TEST
>> >         help
>> >           Driver for the internal RTC (Realtime Clock) on Atmel AVR32
>> >           AT32AP700x family processors.
>> > --
>> > 2.14.1
>> >
>>
>> RTC_DRV_AT32AP700X could probably be removed along with
>> ./drivers/rtc/rtc-at32ap700x.c as well.
>>
>
> Note that the driver is already removed in Linus' tree.
>
>
> --
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> http://bootlin.com

That got rid of the config symbol too. This patch is moot then.

Cheers,
Ulf
