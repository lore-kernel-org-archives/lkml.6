Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934408AbeBLNvw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:51:52 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38445 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933072AbeBLNvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:51:50 -0500
X-Google-Smtp-Source: AH8x226fnIyVdHi+m0Z959AV0pZzRH4UchRkkH5OA7JtJJ63KdzgcEuIOqxKSazro3ZDf8HVrZPJT4oL1Di6FEUJhEg=
MIME-Version: 1.0
In-Reply-To: <CANiq72mDZQFGsTXZM+ULd-5BLbA6xOjvKPoiCKuvF_hyhBmCrA@mail.gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-17-ulfalizer@gmail.com>
 <CANiq72kaCDcUHFuJ0P4CA-0KGgg+a8T+66p0aPwatAjfvDB8bA@mail.gmail.com>
 <20180210141405.syaeuuktkebsp5jy@huvuddator> <CANiq72mDZQFGsTXZM+ULd-5BLbA6xOjvKPoiCKuvF_hyhBmCrA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Feb 2018 14:51:49 +0100
Message-ID: <CANiq72mm5FxWfN1ai6HxOTTy_ixaXASHqJK_-TvtfEJHQvTuJg@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: img-ascii-lcd: kconfig: Remove MIPS_SEAD3 reference
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, Tony Lindgren <tony@atomide.com>,
        npiggin@gmail.com, yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 5:40 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Sat, Feb 10, 2018 at 3:14 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> Commit 3f5f0a4475e1 ("MIPS: generic: Convert SEAD-3 to a generic board")
>> removed the MIPS_SEAD3 symbol and moved the setting of IMG_ASCII_LCD to
>> the board-sead-3.config defconfig file, but IMG_ASCII_LCD still
>> references the removed MIPS_SEAD3 symbol.
>>
>> Remove the reference.
>>
>> Discovered with the
>> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
>> script.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
>> Changes in v2:
>>
>>  - The wrong commit was referenced in the commit message.
>>
>>  - Mention that IMG_ASCII_LCD is now set via the board-sead-3.config defconfig
>>    file.
>>
>>  - Clarify that Kconfig is involved. The previous commit title was
>>    "auxdisplay: img-ascii-lcd: Remove MIPS_SEAD3 reference".
>>
>
> Thanks for the new version!
>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

To clarify, I am picking this patch up for my queue (sorry for any confusion!).

>
>>
>>  drivers/auxdisplay/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
>> index 2c2ed9cf8796..3cba78d36eec 100644
>> --- a/drivers/auxdisplay/Kconfig
>> +++ b/drivers/auxdisplay/Kconfig
>> @@ -137,7 +137,7 @@ config CFAG12864B_RATE
>>  config IMG_ASCII_LCD
>>         tristate "Imagination Technologies ASCII LCD Display"
>>         depends on HAS_IOMEM
>> -       default y if MIPS_MALTA || MIPS_SEAD3
>> +       default y if MIPS_MALTA
>>         select SYSCON
>>         help
>>           Enable this to support the simple ASCII LCD displays found on
>> --
>> 2.14.1
>>
