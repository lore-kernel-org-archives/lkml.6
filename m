Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeBFSKk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:10:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60234 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752481AbeBFSKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:10:33 -0500
Subject: Re: [PATCH 16/20] auxdisplay: img-ascii-lcd: Remove MIPS_SEAD3 dep.
To: Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        paul.burton@mips.com
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        tfiga@chromium.org, Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, Tony Lindgren <tony@atomide.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-17-ulfalizer@gmail.com>
 <CAFkk2KSQ9EBYn0dFhU7qbWXj2nYOu-SL7DfuE99NwiEeOpKBaw@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d02d2488-5e8e-8586-486f-ad5f01a60a02@infradead.org>
Date: Tue, 6 Feb 2018 10:09:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAFkk2KSQ9EBYn0dFhU7qbWXj2nYOu-SL7DfuE99NwiEeOpKBaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2018 05:58 PM, Ulf Magnusson wrote:
> On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> The MIPS_SEAD3 symbol was removed in commit 64601cb1343f ("leds: Remove SEAD-3
>> driver").
>>
>> Remove the MIPS_SEAD3 dependency from IMG_ASCII_LCD.
>>
>> Discovered with the
>> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
>> script.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
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
> 
> The SYSCON symbol selected here is also globally undefined. Maybe
> MFD_SYSCON was intended.

Yes.

from 2018-JAN-18, Corentin Labbe:
https://marc.info/?l=linux-kernel&m=151630656607526&w=2

-- 
~Randy
