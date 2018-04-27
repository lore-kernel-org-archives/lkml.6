Return-Path: <bgolaszewski@baylibre.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524845126; cv=none;
        d=google.com; s=arc-20160816;
        b=AUKgUzHJTodFLeI7o2hAkZEX3LPmrtBzPkqCbHvce8rsAY0IhUXfA3+NSEv9KTKZld
         Z6aPtIBk5TprwQGhR1iEvAW9HkUjKGsQJ/Xf5wHHpOyO/PT3Ph8+QLaL10/6H0KFIX/p
         pgHHwmshUOnXBU8xRuydtsQwLiSmgqtZTO2QHgHb/NCbNovfwTpBQUGxtiNwGCVW34lh
         SgJoq4I9BhdtzxdCMpmU7wL0VmU0b1TljRbH3hrZaYWSlvSqeUpNGoXzkDZWQIb0jYzO
         3TAFXsuU66za+inFw0Bz/AKRbM10x9mCJrSspTA/QJkk2VxnxLF3anNChfxqJZ7LoBay
         vovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7+zDqK4o5kO45+4WTp7mDHPxEn8fTfWYsxzKm5UDPGI=;
        b=G6yrKwGV6ykqwTK/JCshKzFO/C+xIdjQ0iSmUylPkCgpQrtIeAiV85lHeqC0ioUBQ1
         KvS++1w6JlPIQRty4sr1lUw0AHH4n5V4tUAKEMOJb38R2/dJhuPqYYowsAQ7MIqpzN5g
         4Oz60QFBPWhw8SWEFmRPKNKpP0hY+WkqLnd7RdMfhOjIX7WRY9n1/gIlFhK5O0/yOFC1
         qJMR/WT0SYwlZHl2fd2MtRIaPLiO0MdzW/KshufGdJEq/IkzaP34D1oYYGGpvKg4lhaV
         q+VLoMAhRfpN6l8vDRNG3M3vabi3Unuzr9JUhjJxgt1h1oj+IeND9JWS7M2WabE/IccQ
         emOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=oO5A13IB;
       spf=softfail (google.com: domain of transitioning bgolaszewski@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=bgolaszewski@baylibre.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=oO5A13IB;
       spf=softfail (google.com: domain of transitioning bgolaszewski@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=bgolaszewski@baylibre.com
X-Google-Smtp-Source: AB8JxZpT92wfnhSL7a7Glrl46LuTYec9h3GHcjfykFWcVROsiYmm60zNr/YxL/hcAuJCWEjTfBvlkY4U1Qr4kSg2u5w=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a22DKpqMGdjYoBzKfNHc2GvAbvaZowZpz=SFeQHVSWjsg@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com> <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
 <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
 <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
 <CAMpxmJVkRDLkpcgzhMb41z=Tp6zvszLd0vqfdTtZBNGT6Trtqw@mail.gmail.com> <CAK8P3a22DKpqMGdjYoBzKfNHc2GvAbvaZowZpz=SFeQHVSWjsg@mail.gmail.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 27 Apr 2018 18:05:25 +0200
Message-ID: <CAMpxmJUovyhsiHByA3MZX5H6AcU4k9shX45Z60NpDkOFTxg_eQ@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner <david@lechnology.com>, Rich Felker <dalias@libc.org>,
	Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
	Frank Rowand <frowand.list@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Peter Rosin <peda@axentia.se>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823149958129846?=
X-GMAIL-MSGID: =?utf-8?q?1598916003203956904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-27 16:48 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> On Fri, Apr 27, 2018 at 4:05 PM, Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
>> 2018-04-27 14:40 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>
>>> For timer-ti-dm, it seems like a leftover from old times that can
>>> be removed. The other four are shared between arch/sh and
>>> arch/arm/mach-shmobile and already have some #ifdef
>>> to handle those two cases.
>>>
>>
>> I'm also seeing that we also call early_platform_cleanup() from
>> platform_bus_init(). Any ideas for this one?
>
> My first idea would be to call it immediately after registering all
> devices and drivers. It looks like it's only needed to make all
> devm_ allocations persistent by removing them from the list,
> so we have to call early_platform_cleanup() before getting
> to the real platform code, but it could be done much earlier
> if we want to, at least after both setup_arch() and sh_late_time_init()
> are complete.
>
>>> I'd rather keep those separate and would prefer not to have
>>> that many different ways of getting there instead. DT and
>>> board files can already share most of the code through the
>>> use of platform_device, especially when you start using
>>> device properties instead of platform_data, and the other
>>> two are rare corner cases and ideally left that way.
>>>
>>> The early boot code is always special and instead of making
>>> it easier to use, we should focus on using it as little as
>>> possible: every line of code that we call before even
>>> initializing timers and consoles means it gets harder to
>>> debug when something goes wrong.
>>>
>>
>> I'm afraid I don't quite understand your reasoning. I fully agree that
>> devices that need to be initialized that early are a rare corner case.
>> We should limit any such uses to the absolute minimum. But when we do
>> need to go this way, we should do it right. Having a unified mechanism
>> for early devices will allow maintainers to enforce good practices
>> (using resources for register mapping, devres, reusing driver code for
>> reading/writing to registers). Having initialization code in machine
>> code will make everybody use different APIs and duplicate solutions. I
>> normally assume that code consolidation is always good.
>>
>> If we add a way for DT-based platform devices to be probed early - it
>> would be based on platform device/driver structures anyway. Why would
>> we even want to not convert the board code into a simple call to
>> early_platform_device_register() if we'll already offer this API for
>> device tree?
>
> I think we first need to define what we really want to achieve here.
> It sounds like you still want to recreate a lot of what early_platform
> devices do, but it seems more important to me to add the missing
> functionality to the OF_DECLARE infrastructure. The most
> important pieces that seem to be missing are solved by finding
> a way to provide a platform_device pointer with the following
> properties:
>
> - allow being passed into dev_print()
> - allow using the pointer as a token for devres unwinding
> - access to device_private data that remains persistent
>   until real a platform_driver gets loaded
>
> That can probably be done as an extension to the current
> infrastructure.
>
> However, I'd be very cautious about the resource portion:
> filling the platform resources (registers, irqs, ...) the way
> we do for regular devices is much harder and can introduce
> additional (or circular) dependencies on other devices.
> OTOH, not using those resources means you have a hard
> time passing information from board files.
>
>           Arnd

So speaking in pseudo-C we basically have two ways for an imaginary
future timer driver:

int foo_probe(struct platform_device *pdev)
{
    struct clk *clk;

    if (probing_early(pdev)) {
        clk = devm_clk_get(dev, "earlyclock");

       /* Do early stuff. */
        return 0;
    }

    /* Do late stuff. */

    return 0;
}

    --- vs ---

int foo_probe(struct platform_device *pdev)
{
    /* Do late stuff. */

    return 0;
}

static int foo_init(struct device_node *np)
{
    struct clk *clk;
    struct device *dev = device_from_device_node(np);

    /* Do early stuff. */
    clk = devm_clk_get(dev, "earlyclock");

    return 0;
}

TIMER_OF_DECLARE(foo, "bar,foo", foo_init);

I still believe the first approach is easier to implement and has the
added benefit of supporting board files.

I'll give it a thought and will be back at it next week.

Best regards,
Bartosz Golaszewski
