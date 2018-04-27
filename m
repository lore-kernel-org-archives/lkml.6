Return-Path: <nsekhar@ti.com>
X-Google-Smtp-Source: AB8JxZp6N8+muW4MVBkO+c3t5vjzO/Vj3UEhJtkDdumhnjlPiVHIqRM5S+D3yVZt7cBBRh5+Lzp5
ARC-Seal: i=1; a=rsa-sha256; t=1524817867; cv=none;
        d=google.com; s=arc-20160816;
        b=davG/PZKPoGMozm216cBPkQnLdQ5F2vwl0Fuk8vE5Houy8s9lkmE8Wmy428a8pCgHV
         y9CsdboNED+FYUAv4E4UK6cvz+Ce1eSJ7/vCrAvx2avZsgxiOH+uNCp+47eFSPaYEqgh
         lfRcVQCMgDc/xyQXvme1MoVEEZxPkt9NpmPyn+dfL0OPIjVNagZ1VyYMZqNmjhyUoz4P
         bqjME5Cc4O5zE+FiWviyhAMd03+xWESlT5/rAE8B8H/imEygN1oRwwmhULackftr2B97
         g8EKnl5Qfkm9pFkdmtjFwHqARJG7OOZl/jLjz6kMYWWD24pde8OGrbkfa7ABMbAsfb8z
         BX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=HQJftOVfz9vvTnRdyKN4BbiJCGM0KFw4zPSmHNwk/rg=;
        b=EgqRK1h7X/RbpkXsGNo5S4GteJleQbT6TJOtJe2LUoe4llCon8c2qSUVDZE7x6MxZk
         /4ESyLOVflno1nEOgp4mJION0/lt+hwzNA3+H789MTEsvsVV875auh+SRXGipWfXyt8z
         F14p4PZAaHR0BDOv/NKM2aymD4nvIUu+vwjtzVvoaDZUKQLNgOKC+d8Dwtvk14U8yy4l
         tMXrswsO+l9NUCsTM/FVkRwrlx/jvZzURBCqHwuoQI/MkRteUrLuCQ65MNSb18Gijluu
         nq+cqI7UPLlEALuogUxlvGrF6/CuO75rXNLpq23OKWmX9kgfh9AfkKsb0chBxCemehgg
         pvUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=HVqXLN5k;
       spf=pass (google.com: domain of nsekhar@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=nsekhar@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=HVqXLN5k;
       spf=pass (google.com: domain of nsekhar@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=nsekhar@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Arnd Bergmann <arnd@arndb.de>, David Lechner <david@lechnology.com>
CC: Rich Felker <dalias@libc.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin
 Hilman <khilman@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Frank
 Rowand <frowand.list@gmail.com>,
        "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>,
        Jarkko Sakkinen
	<jarkko.sakkinen@linux.intel.com>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Heikki
 Krogerus <heikki.krogerus@linux.intel.com>,
        Michal Suchanek
	<msuchanek@suse.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>, Peter Rosin
	<peda@axentia.se>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML
	<devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
 <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <6194511c-b649-8c02-7db0-3514bfb292f5@ti.com>
Date: Fri, 27 Apr 2018 13:59:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823149958129846?=
X-GMAIL-MSGID: =?utf-8?q?1598887420282854157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arnd,

On Friday 27 April 2018 01:22 PM, Arnd Bergmann wrote:
> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>> On 04/26/2018 12:31 PM, Rich Felker wrote:
>>>
>>> On Thu, Apr 26, 2018 at 05:29:18PM +0200, Bartosz Golaszewski wrote:
>>>>
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> This is a follow to my series[1] the aim of which was to introduce device
>>>> tree
>>>> support for early platform devices.
>>>>
>>>> It was received rather negatively. Aside from using device tree to pass
>>>> implementation specific details to the system, two important concerns
>>>> were
>>>> raised: no probe deferral support and the fact that currently the early
>>>> devices
>>>> never get converted to actual platform drivers. This series is a
>>>> proof-of-concept that's trying to address those issues.
>>>>
>>>> The only user of the current version of early platform drivers is the
>>>> SuperH
>>>> architecture. If this series eventually gets merged, we could simply
>>>> replace
>>>> the other solution.
>>>
>>>
>>> Looking at a quick output of:
>>>
>>>         grep -r -A10 early_devices[[] arch/sh/kernel/
>>>
>>> it looks like all of the existing early platform devices are serial
>>> ports, clocks, and clocksources. The switch to device tree should pick
>>> them all up from CLK_OF_DECLARE, TIMER_OF_DECLARE, and
>>> EARLYCON_DECLARE. Until that's complete, the existing code works
>>> as-is. I don't see what problem you're trying to solve.
>>
>>
>> The problem for us is that clk maintainers don't want new drivers to use
>> CLK_OF_DECLARE and instead use platform devices. I have just written such
>> a new driver that is shared by 6 different SoCs. For some combinations of
>> SoCs and clocks, using a platform device is fine but on others we need to
>> register early, so the drivers now have to handle both cases, which is
>> kind of messy and fragile. If there is a generic way to register platform
>> devices early, then the code is simplified because we only have to handle
>> one method of registering the clocks instead of two.
> 
> The early_platform code is certainly not a way to make things simpler,
> it just adds one more way of doing the same thing that OF_CLK_DECLARE
> already does. We removed the last early_platform users on ARM a few
> years ago, and I would hope to leave it like that.
> 
> I haven't seen the discussion about your clock drivers, but I know that
> usually only a very small subset of the clocks on an SoC are needed
> that 'early', and you should use a regular platform driver for the rest.

Its true that the subset is small, but they are either PLL bypass clocks
or clocks derived out of the main clock gate controller on the Soc
(DaVinci PSC). So we need some non-platform-device based initialization
support in the two main clock drivers used on mach-davinci anyway.

> Can you elaborate on which devices need to access your clocks before
> you are able to initialize the clk driver through the regular platform_driver
> framework? Do any of these need complex interactions with the clk
> subsystem, or do you just need to ensure they are turned on?

Its just the timer IP. There is no complex interaction, just need to
ensure that the clock is registered with the framework and also switched
on when there is a gate clock.

The latest attempt by David for this was posted last night here:

https://lkml.org/lkml/2018/4/26/1093

Thanks,
Sekhar
