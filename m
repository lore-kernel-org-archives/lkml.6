Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeEPWTv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:19:51 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33435 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeEPWTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:19:49 -0400
X-Google-Smtp-Source: AB8JxZq5POiAQFaQ64RduvKny/j5vAq0BmXRQZcKBkbgqfEHuMASMd0JfPMRvewLZyzg3k5QEy4KhNAjaoEGAUgJvlc=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd-cyR7zVofP7g+4Z1ouqawV+Rqp5s5BcDhpGiHheUgpg@mail.gmail.com>
References: <20180515154352.20263-1-dmurphy@ti.com> <20180515154352.20263-2-dmurphy@ti.com>
 <CAHp75VegjkiiD1qTGpi9rr6cg=72t9kSwDrG=sUpUWFVO58M4A@mail.gmail.com>
 <08dda10d-f865-9cf2-b9a5-c79cbab5da98@ti.com> <CAHp75Vcz08zrs3bgMFcvYwRrN_A43D=Nvt5cFDQf8m9whB=yhA@mail.gmail.com>
 <3a0f27b7-86a1-235c-0a96-5ec9c8feb6f0@ti.com> <CAHp75Vd-cyR7zVofP7g+4Z1ouqawV+Rqp5s5BcDhpGiHheUgpg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 17 May 2018 01:19:47 +0300
Message-ID: <CAHp75VeP6Ui-Sw65T-cwGh9ADMEcEGOzf8C3aYCTK_seZjgqeg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Dan Murphy <dmurphy@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 1:11 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, May 16, 2018 at 11:43 PM, Dan Murphy <dmurphy@ti.com> wrote:
>> On 05/15/2018 05:24 PM, Andy Shevchenko wrote:
>>> On Wed, May 16, 2018 at 1:08 AM, Dan Murphy <dmurphy@ti.com> wrote:
>>>> On 05/15/2018 04:56 PM, Andy Shevchenko wrote:

>>>>>> +static const struct lm3601x_max_timeouts strobe_timeouts[] = {
>>>>>> +       { 40000, 0x00 },
>>>>>> +       { 80000, 0x01 },
>>>>>> +       { 120000, 0x02 },
>>>>>> +       { 160000, 0x03 },
>>>>>> +       { 200000, 0x04 },
>>>>>> +       { 240000, 0x05 },
>>>>>> +       { 280000, 0x06 },
>>>>>> +       { 320000, 0x07 },
>>>>>> +       { 360000, 0x08 },
>>>>>> +       { 400000, 0x09 },
>>>>>> +       { 600000, 0x0a },
>>>>>> +       { 800000, 0x0b },
>>>>>> +       { 1000000, 0x0c },
>>>>>> +       { 1200000, 0x0d },
>>>>>> +       { 1400000, 0x0e },
>>>>>> +       { 1600000, 0x0f },

>>> if (x < 9)
>>>  strobe_timeout = (x + 1) * 40 * MSECS_IN_SEC;
>>> else
>>>  strobe_timeout = (x - 7) * 200 * MSECS_IN_SEC;

>>
>> Not sure if this will produce the register value I am looking for.  I have to run through the
>> algorithim.  The idea is to take in the timeout and get the reg value to program.
>>
>> If it yields the expected output, or with a modified equation, then I can pull it in.
>
> So, you need a reversed calculus in this case.
>
> u8 regval;
>
> /* To make it in range... */
> timeout = clamp_val(timeout, 40000, 1600000);
> /* ...other possibility to issue an error */
>
> if (timeout >= 400000)
>  regval = timeout / 200000 + 0x07;
> else
>  regval = timeout / 40000 - 0x01;

Forgot to mention that there are also three approaches (considering
division here):
- round up
- round down
- round to closest

>
> In any case, please double check it gives a correct values.


-- 
With Best Regards,
Andy Shevchenko
