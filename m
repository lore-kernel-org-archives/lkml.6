Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeCTMNZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:13:25 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45504 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeCTMNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:13:21 -0400
X-Google-Smtp-Source: AG47ELtygq59tunNzm2lAstEdOdjHAYWcFpwW0dWislbGOZOmtqhpHDvOVpI0q9bQzFGkpwQ6nNkNMMv7ykouv/Zeh4=
MIME-Version: 1.0
In-Reply-To: <20180320112212.2mwthxug3pu7uqgg@holly.lan>
References: <20180208113032.27810-1-enric.balletbo@collabora.com>
 <CAFqH_52bXq76TnQLfnD0mohgr0d5iAcrHBcPefwnRB8gdbaYFQ@mail.gmail.com> <20180320112212.2mwthxug3pu7uqgg@holly.lan>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Tue, 20 Mar 2018 13:13:20 +0100
Message-ID: <CAFqH_51E+9L2fuTY7Zo3=B2fUmL=pJtg7wz3GdN5wxhpqV8p0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] backlight: pwm_bl: support linear interpolation
 and brightness to human eye
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@google.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>, Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,


2018-03-20 12:22 GMT+01:00 Daniel Thompson <daniel.thompson@linaro.org>:
> On Mon, Mar 19, 2018 at 05:04:31PM +0100, Enric Balletbo Serra wrote:
>> Hi Daniel,
>>
>> Gentle ping for this series, there is any possibility you have a
>> chance to review it? Let me know if you want I change something.
>
> I haven't got it in my TODO backlog... which means either I mistakenly
> deleted it when it went through originally or that I deliberately deleted
> it because I thought a v4 was coming along soon.
>
> I could go diving through the archives if I need to but were there other
> pending changes for this patchset?
>

Unless I am missing something there isn't pending changes requested.

1/4 I addressed your latest comments in this version.
2/4 Has been acked by Rob Herring
3/4 I did not receive feedback but iirc we agreed to use a pre-computed table.
4/4 Is already acked by you.

Regards,
 Enric

>
> Daniel.
>
>
>>
>> Thanks,
>>   Enric
>>
>> 2018-02-08 12:30 GMT+01:00 Enric Balletbo i Serra
>> <enric.balletbo@collabora.com>:
>> > Dear all,
>> >
>> > This series is a third patchset integrating the requested changes.
>> >
>> > The first and second patch what tries to solve is the problem of
>> > granularity for high resolution PWMs. The idea is simple interpolate
>> > between 2 brightness values so we can have a high PWM duty cycle (a
>> > 16 bits PWM is up to 65535 possible steps) without having to list
>> > out every possible value in the dts. I think that this patch is
>> > required to not break backward compability, to be more flexible and
>> > also extend the functionality to be able to use high resolution PWM
>> > with enough steps to have a good UI experience in userspace.
>> >
>> > The thirth and fourth patch is a bit more ambicious, the idea is let
>> > decide the driver the brightness-levels required in function of the PWM
>> > resolution. To do this create a brightness-levels table filled with the
>> > CIE 1931 algorithm values to convert brightness to PWM duty cycle.
>> >
>> > More detailed info is available in the commit message of every patch.
>> >
>> > Both functionalities were tested on a Samsung Chromebook Plus (that has
>> > a 16 bits PWM) and a SL50 device (with a 8 bits PWM)
>> >
>> > Waiting for your feedback.
>> >
>> > Best regards,
>> >
>> > Enric Balletbo i Serra (4):
>> >   backlight: pwm_bl: linear interpolation between brightness-levels
>> >   dt-bindings: pwm-backlight: add a num-interpolation-steps property.
>> >   backlight: pwm_bl: compute brightness of LED linearly to human eye.
>> >   dt-bindings: pwm-backlight: move brightness-levels to optional.
>> >
>> >  .../bindings/leds/backlight/pwm-backlight.txt      |  34 ++-
>> >  drivers/video/backlight/pwm_bl.c                   | 232 +++++++++++++++++++--
>> >  2 files changed, 246 insertions(+), 20 deletions(-)
>> >
>> > --
>> > 2.15.1
>> >
