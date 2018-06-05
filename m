Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeFEHbp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:31:45 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37385 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeFEHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:31:43 -0400
X-Google-Smtp-Source: ADUXVKJCWe3eY5XUP5s220VpsKR+1/SzbTDZgTgXWL8nWii7KJdeEQFzpoDDCsXMcls8faS//MptyWYQdB5/9bXLB84=
MIME-Version: 1.0
In-Reply-To: <20180605070913.GH21163@dell>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-2-marek.vasut+renesas@gmail.com> <20180604122624.GB21163@dell>
 <b3c9a486-002e-a63b-7d2d-2b51ce55b08f@gmail.com> <20180605070913.GH21163@dell>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Jun 2018 09:31:40 +0200
X-Google-Sender-Auth: 1_epo8h8--2HAEI1y8FixtRvUSg
Message-ID: <CAMuHMdWEeH4_ciyn6V7FYrs0doutqkz++32D_bz57rSHnY=CEQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] mfd: da9063: Use REGMAP_IRQ_REG
To: Lee Jones <lee.jones@linaro.org>
Cc: Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Tue, Jun 5, 2018 at 9:09 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 04 Jun 2018, Marek Vasut wrote:
>> On 06/04/2018 02:26 PM, Lee Jones wrote:
>> > On Sat, 02 Jun 2018, Marek Vasut wrote:
>> >> Convert the regmap_irq table to use REGMAP_IRQ_REG().
>> >>
>> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> >> Cc: Lee Jones <lee.jones@linaro.org>
>> >> Cc: Mark Brown <broonie@kernel.org>
>> >> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
>> >> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> >> Cc: linux-renesas-soc@vger.kernel.org
>> >> ---
>> >> V3: New patch
>> >> Note: A sed oneliner was used:
>> >>       sed -i "/\[DA9063_IRQ_/ {N;N;N;s/\n//g;s/.*\[\(DA9063_IRQ_[^]]\+\)].*reg_offset = \([^,]\+\),.* = \([^,]\+\),.*/\tREGMAP_IRQ_REG(\1, \2, \3),/}" drivers/mfd/da9063-irq.c
>> >> ---
>> >>  drivers/mfd/da9063-irq.c | 145 ++++++++++-------------------------------------
>> >>  1 file changed, 29 insertions(+), 116 deletions(-)
>> >>
>> >> diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
>> >> index 207bbfe55449..5b406ecfc14a 100644
>> >> --- a/drivers/mfd/da9063-irq.c
>> >> +++ b/drivers/mfd/da9063-irq.c
>> >> @@ -28,125 +28,38 @@
>> >>
>> >>  static const struct regmap_irq da9063_irqs[] = {
>> >>    /* DA9063 event A register */
>> >> -  [DA9063_IRQ_ONKEY] = {
>> >> -          .reg_offset = DA9063_REG_EVENT_A_OFFSET,
>> >> -          .mask = DA9063_M_ONKEY,
>> >> -  },
>> >> -  [DA9063_IRQ_ALARM] = {
>> >> -          .reg_offset = DA9063_REG_EVENT_A_OFFSET,
>> >> -          .mask = DA9063_M_ALARM,
>> >> -  },
>> >> -  [DA9063_IRQ_TICK] = {
>> >> -          .reg_offset = DA9063_REG_EVENT_A_OFFSET,
>> >> -          .mask = DA9063_M_TICK,
>> >> -  },
>> >> -  [DA9063_IRQ_ADC_RDY] = {
>> >> -          .reg_offset = DA9063_REG_EVENT_A_OFFSET,
>> >> -          .mask = DA9063_M_ADC_RDY,
>> >> -  },
>> >> -  [DA9063_IRQ_SEQ_RDY] = {
>> >> -          .reg_offset = DA9063_REG_EVENT_A_OFFSET,
>> >> -          .mask = DA9063_M_SEQ_RDY,
>> >> -  },
>> >> +  REGMAP_IRQ_REG(DA9063_IRQ_ONKEY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
>> >> +  REGMAP_IRQ_REG(DA9063_IRQ_ALARM, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ALARM),
>> >> +  REGMAP_IRQ_REG(DA9063_IRQ_TICK, DA9063_REG_EVENT_A_OFFSET, DA9063_M_TICK),
>> >> +  REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
>> >> +  REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),
>> >
>> > Nice, but I think checkpatch.pl would complain.
>> >
>> > Better to break after the first argument I think.
>>
>> Doesn't really help the readability, but done.
>
> I don't make the rules. :)

Documentation/process/coding-style.rst:

"Statements longer than 80 columns will be broken into sensible chunks, unless
 exceeding 80 columns significantly increases readability and does not hide
 information."

> Personally /me is hoping that the 80 char limit is lifted to ~120 soon.

Please no ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
