Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeCZOkZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:40:25 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:45901 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeCZOkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:40:23 -0400
X-Google-Smtp-Source: AG47ELtUXrTvNM5OH+S/tcva0z7pIJHJfMUJu9oDCL9XgTMdBZt9nzLKXKxDvXORpF2PxxE6PPj1QfgZ+sUYhaGogfc=
MIME-Version: 1.0
In-Reply-To: <20180326104205.GA12425@amd>
References: <20180326095213.18362-1-enric.balletbo@collabora.com> <20180326104205.GA12425@amd>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Mon, 26 Mar 2018 16:40:21 +0200
Message-ID: <CAFqH_52fFLhuj6gkRNJsPozNfLSAKd0OpQKMjrdhqHRYU4xZ3Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] pwm-backlight: enable/disable the PWM before/after
 LCD enable toggle.
To: Pavel Machek <pavel@ucw.cz>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-fbdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-leds@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

2018-03-26 12:42 GMT+02:00 Pavel Machek <pavel@ucw.cz>:
> On Mon 2018-03-26 11:52:09, Enric Balletbo i Serra wrote:
>> Before this patch the enable signal was set before the PWM signal and
>> vice-versa on power off. This sequence is wrong, at least, it is on
>> the different panels datasheets that I checked, so I inverted the sequence
>> to follow the specs.
>>
>> For reference the following panels have the mentioned sequence:
>>   - N133HSE-EA1 (Innolux)
>>   - N116BGE (Innolux)
>>   - N156BGE-L21 (Innolux)
>>   - B101EAN0 (Auo)
>>   - B101AW03 (Auo)
>>   - LTN101NT05 (Samsung)
>>   - CLAA101WA01A (Chunghwa)
>
> Ok, but this changes behaviour for other panels, too. Are you sure you
> are not breaking one of those?

I can't say that I am 100% sure because I didn't find all the
datasheets of all the panels supported in the kernel. But all the
datasheets I checked specifies this sequence as valid. In general I
think that doesn't really matter, but I know that at least the
B116XTN02 panel requires enable first the PWM, wait 10ms and then
enable BL_EN to avoid garbage. So the other way around is not valid
for this panel. That's the reason for this patchset.

If anyone knows a panel that says the contrary, please let me know and
I'll try to rework the patches to satisfy both requirements.

Regards,
 Enric


>                                                                 Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
