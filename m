Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeBVPAk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:00:40 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:54665 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753858AbeBVPAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:00:35 -0500
X-Google-Smtp-Source: AG47ELumYOZT9m2/EPeW1dOGGoTqNDyzSHvvZGvHIsGOTcJtwLOEpwDsRCCBM8JYVTI7uww/7uNzoVSa3BlD/P+jr50=
MIME-Version: 1.0
In-Reply-To: <7efffc52-1332-5d98-e6b8-634d5ee9082e@lechnology.com>
References: <1516566774-1786-1-git-send-email-david@lechnology.com>
 <CACRpkdbKWrdnbBp2e1kFd_3fYZxtWKnWPPgOd_FXSvXcOetLwA@mail.gmail.com> <7efffc52-1332-5d98-e6b8-634d5ee9082e@lechnology.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 16:00:34 +0100
Message-ID: <CACRpkdYPVOP_O+TWg3qHiRq_d18rW33sv96dOqyPHeC4U0-rJQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: suppress error message on EPROBE_DEFER
To: David Lechner <david@lechnology.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 4:47 AM, David Lechner <david@lechnology.com> wrote:
> On 02/07/2018 06:57 AM, Linus Walleij wrote:
>>
>> On Sun, Jan 21, 2018 at 9:32 PM, David Lechner <david@lechnology.com>
>> wrote:
>>
>>> This suppresses printing an error message during probe of gpio drivers
>>> when the error is EPROBE_DEFER.
>>>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>
>>
>> I'm not sure about this.
>>
>> GPIO can be very basic system components. If we don't
>> print this, defer a few times (for some reason) and then
>> the kernel gives up on retrying, silently (as it happens)
>> there is no trace in dmesg of what happened. That makes
>> things hard to debug.
>>
>> This happened to me with some other driver, so it is not
>> a made up example.
>>
>> What about an explicit deferral message for now?
>
>
> so you mean something like this?
>
> if (err == -EPROBE_DEFER)
>         dev_info(dev, "deferring probe\n")
> else
>         dev_err(dev, "... failed to register\n")

Yes exactly.

It has been brought to my attention that people are especially
allergic to dmesg messages containing the word "failed". So
if that is the problem, let's avoid it like this.

Yours,
Linus Walleij
