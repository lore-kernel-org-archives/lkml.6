Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeBVUaU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:30:20 -0500
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37189 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeBVUaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:30:17 -0500
X-Google-Smtp-Source: AH8x226SRrxPWEb1JeN84W9D9/ZsHXGFLR8uqVHhK64432uThPIKvBw4PAu4C1q1C5KLtADhdJySLg==
Date: Thu, 22 Feb 2018 15:30:09 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] gpio: Change ISA_BUS_API dependency to selection
Message-ID: <20180222203009.GA10834@sophia>
References: <cover.1514578085.git.vilhelm.gray@gmail.com>
 <1534276cb63d1e9e6dd139b4edceedbe728f65f5.1514578085.git.vilhelm.gray@gmail.com>
 <CACRpkdaw75RH_WR4Ta9AmqNmGnaPhFKK2HfC=m8SNabACs95vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdaw75RH_WR4Ta9AmqNmGnaPhFKK2HfC=m8SNabACs95vg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 04:16:17PM +0100, Linus Walleij wrote:
>On Fri, Dec 29, 2017 at 9:13 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>
>> The ISA_BUS_API Kconfig option enables the compilation of the ISA bus
>> driver. The ISA bus driver does not perform any hardware interaction,
>> and is instead just a thin layer of software abstraction to eliminate
>> boilerplate code common to ISA-style device drivers. Since ISA_BUS_API
>> has no dependencies and does not jeopardize the integrity of the system
>> when enabled, drivers should select it when the ISA bus driver
>> functionality is needed.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>
>Patch applied to the GPIO tree for v4.17.
>
>Can you confirm that we don't have any dangling ISA
>drivers not using this?
>
>Yours,
>Linus Walleij

Hi Linus,

This patchset should cover all current mainline drivers depending on
ISA_BUS_API.

However, there are existing drivers for ISA compatible devices that
would benefit from utilizing struct isa_driver rather than struct
platform_driver as was done for the Winbond GPIO driver; for example,
a number of the drivers under the "Port-mapped I/O GPIO drivers" menu
are also for Super I/O devices and may benefit from using struct
isa_driver. I thought it best to let the respective maintainers of those
drivers make the changes if they so desire, since the primary benefit of
struct isa_driver over struct platform_driver is code clarity in my
opinion.

I may submit patches myself for some of the low-hanging fruit later this
year if I find the time. Right now implementing the counter subsystem
has been my priority, but perhaps some downtime will be available soon
enough for me to add ISA driver improvements to my plate -- we'll just
have to see how it all goes. :)

William Breathitt Gray
