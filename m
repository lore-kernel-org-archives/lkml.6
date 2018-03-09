Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeCIKOk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:14:40 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37483 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeCIKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:14:38 -0500
X-Google-Smtp-Source: AG47ELsk6L+icfkE8nIz1uvzaNEwh38wadGTlSooeUxL0RABzoRUrrfg/UsiDnzTJn217Achxzze/OnlJ0x1ETVPTtM=
MIME-Version: 1.0
In-Reply-To: <20180219111136.jpv4wtcm6h2hfwac@oak.lan>
References: <20180216174034.15936-1-enric.balletbo@collabora.com>
 <20180216174034.15936-2-enric.balletbo@collabora.com> <20180219111136.jpv4wtcm6h2hfwac@oak.lan>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Fri, 9 Mar 2018 11:14:36 +0100
Message-ID: <CAFqH_51EGNzMx76WrjEr9Ss7QoU8FSHAhUf2OeencUC-XXtSWQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 2/5] dt-bindings: pwm-backlight: add PWM delay proprieties.
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
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
        kernel@collabora.com,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

oh, devicetree mailing list is not added, sorry, so cc'ing ...

2018-02-19 12:11 GMT+01:00 Daniel Thompson <daniel.thompson@linaro.org>:
> On Fri, Feb 16, 2018 at 06:40:31PM +0100, Enric Balletbo i Serra wrote:
>> Hardware needs a delay between setting an initial (non-zero) PWM and
>> enabling the backlight using GPIO. The post-pwm-on-delay-ms specifies
>> this delay in milli seconds. Hardware also needs a delay between disabing
>> the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-ms
>> is this delay in milli seconds.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>

Lee, I guess that after Daniel ack the only ack missing here is one
from Rob Herring?

Rob, if you have a chance to look at this I'd appreciate.

Thanks,
  Enric

>> ---
>> Based on the original Huang Lin <hl@rock-chips.com> work.
>>
>> Changes since v4:
>>  - Rebase on top of mainline.
>> Changes since v3:
>>  - Replace us for ms.
>>  - Add Acked-by: Pavel Machek <pavel@ucw.cz>
>> Changes since v2:
>>  - Use separate properties (Rob Herring)
>> Changes since v1:
>>  - As suggested by Daniel Thompson
>>    - Do not assume power-on delay and power-off delay will be the same
>>
>>  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>> index 764db86d441a..310810906613 100644
>> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>> @@ -17,6 +17,10 @@ Optional properties:
>>                 "pwms" property (see PWM binding[0])
>>    - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>>                    and disables the backlight (see GPIO binding[1])
>> +  - post-pwm-on-delay-ms: Delay in ms between setting an initial (non-zero) PWM
>> +                          and enabling the backlight using GPIO.
>> +  - pwm-off-delay-ms: Delay in ms between disabling the backlight using GPIO
>> +                      and setting PWM value to 0.
>>
>>  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
>>  [1]: Documentation/devicetree/bindings/gpio/gpio.txt
>> @@ -32,4 +36,6 @@ Example:
>>
>>               power-supply = <&vdd_bl_reg>;
>>               enable-gpios = <&gpio 58 0>;
>> +             post-pwm-on-delay-ms = <10>;
>> +             pwm-off-delay-ms = <10>;
>>       };
>> --
>> 2.15.1
>>
