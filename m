Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeBVUo1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:44:27 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:51430 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbeBVUoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:44:25 -0500
Subject: Re: [PATCH v2 3/5] gpio: Change ISA_BUS_API dependency to selection
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1514578085.git.vilhelm.gray@gmail.com>
 <1534276cb63d1e9e6dd139b4edceedbe728f65f5.1514578085.git.vilhelm.gray@gmail.com>
 <CACRpkdaw75RH_WR4Ta9AmqNmGnaPhFKK2HfC=m8SNabACs95vg@mail.gmail.com>
 <20180222203009.GA10834@sophia>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <278aed38-1b40-e362-00e2-38d61a4b81c2@maciej.szmigiero.name>
Date: Thu, 22 Feb 2018 21:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222203009.GA10834@sophia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,
Hi Linus,

On 22.02.2018 21:30, William Breathitt Gray wrote:
> On Thu, Feb 22, 2018 at 04:16:17PM +0100, Linus Walleij wrote:
>> On Fri, Dec 29, 2017 at 9:13 PM, William Breathitt Gray
>> <vilhelm.gray@gmail.com> wrote:
>>
>>> The ISA_BUS_API Kconfig option enables the compilation of the ISA bus
>>> driver. The ISA bus driver does not perform any hardware interaction,
>>> and is instead just a thin layer of software abstraction to eliminate
>>> boilerplate code common to ISA-style device drivers. Since ISA_BUS_API
>>> has no dependencies and does not jeopardize the integrity of the system
>>> when enabled, drivers should select it when the ISA bus driver
>>> functionality is needed.
>>>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>>
>> Patch applied to the GPIO tree for v4.17.
>>
>> Can you confirm that we don't have any dangling ISA
>> drivers not using this?
>>
>> Yours,
>> Linus Walleij
> 
> Hi Linus,
> 
> This patchset should cover all current mainline drivers depending on
> ISA_BUS_API.
> 

Thanks for merging this series!

Note that gpio-winbond (CONFIG_GPIO_WINBOND) driver was originally
merged using ISA_BUS_API selection as done for other ISA bus gpio drivers
by this patch, then temporary switched to the previous ("depends on")
style by commit 92a8046c9d952a to fix a circular Kconfig dependency.
So now this commit (92...) should be reverted to make gpio-winbond
driver Kconfig dependency / selection consistent with the remaining ISA
bus gpio drivers.

Unfortunately, I can't test the reversion myself because it looks like
Linus didn't push his trees yet to git.kernel.org after applying this
series (or I am not looking at the right place - linusw/linux-gpio.git?).

Best regards,
Maciej
