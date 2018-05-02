Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525295475; cv=none;
        d=google.com; s=arc-20160816;
        b=N7xeUJ6ImZ8UMw9EmWKh+4lvMoHa9+8Zmv0zPGYuBF3PW6lFjO5vqxRv5pH09fUsaS
         GRzajxnsR8LZe9SkgYiCReRWAalis3D0EgNck7bfoLacOjZkLwU8By3mzb1erJVfMlTR
         13dFIgZbX/+OKRRWh2fjbKVTl0EdTCk2p40nVGoJTwXnpUHe0cHcggz6sdLOCsbVAxvZ
         LEzZbGKPhwAjgNs8woGMMcUZdjKvlonhAGKSnW7lM1zDrGowWxq1hgvoLTmz1OVj/X+1
         UnAYd7OjounBBYRYr/itQNA/JyCXIzyx5WJfPYHo9YDKumLJMtRcQHvoTWVgxiqveFiK
         HhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=iAsDCiysLpb2MDNHCAHWgQ1LWxmW6WediMztGiEoDpw=;
        b=cvWs6tca/GyVIcZYlzt/MCaLQcBb4/iLIbqBsD7uvJwPnzumHyD/IMGgA1HTGdiF/d
         KTOXhKwYWlloADs1ZGoGCxS0PMqQTk/LTE4uaEOTmDjlurxv5COyqHsDORSgkMVMpPby
         kktPGADHrIuyKIlFAryjJ0Y72nNVoQiKxL3PwoaeZURrnvxABcqGBU+VVytXv9iKLHtk
         gB284P7ZfU4IOsYj7wYVcagn1TFd5lNozVK0/Ux0xtxZHGscr9rLwNcT5DIbVzMzEH93
         izCyBWdYdOb26VVhw6kujd/8ABGMTifAA0YXim9UIUrzZ3hp8AKhzE4wdToTDhEW1Kog
         rjyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r2PLEGWa;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r2PLEGWa;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZoHtVAB63EzGAsRwHZehgPGzbikRRCwiv7jjB9ZXQhobY+aeIrAfWXfB+9P3qT0wlicIAziZnRZMm8Nw/06SpA=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com> <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
 <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com> <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 May 2018 23:11:14 +0200
X-Google-Sender-Auth: S0uXDNy5rykkEpHG0jUizsZyJH4
Message-ID: <CAMuHMdU7b86fWAFaK6LQ0gHukJebc4fegUetHPCvu7ujdjSfRw@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, Michael Turquette <mturquette@baylibre.com>,
	Sekhar Nori <nsekhar@ti.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Frank Rowand <frowand.list@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Kevin Hilman <khilman@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Michal Suchanek <msuchanek@suse.de>, DTML <devicetree@vger.kernel.org>,
	David Lechner <david@lechnology.com>, Marc Zyngier <marc.zyngier@arm.com>,
	Rob Herring <robh+dt@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Arend van Spriel <aspriel@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823149958129846?=
X-GMAIL-MSGID: =?utf-8?q?1599388228890425848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 2:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Apr 27, 2018 at 1:53 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> 2018-04-27 12:18 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Fri, Apr 27, 2018 at 10:57 AM, Bartosz Golaszewski
>>> <bgolaszewski@baylibre.com> wrote:
>>>> 2018-04-27 9:52 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>>>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>>>> My patch tries to address exactly the use cases we're facing - for
>>>> example by providing means to probe devices twice (early and late) and
>>>> to check the state we're at in order for users to be able to just do
>>>> the critical initialization early on and then continue with regular
>>>> stuff later.
>>>
>>> Maybe the problem is reusing the name and some of the code from
>>> an existing functionality that we've been trying to get rid of.
>>>
>>
>> I'm not reusing the name - in fact I set the prefix to earlydev_
>> exactly in order to not confuse anyone. I'm also not reusing any code
>> in the second series.
>
> Ok.
>
>>> If what you want to do is completely different from the existing
>>> early_platform implementation, how about starting by moving that
>>> out of drivers/base/platform.c into something under arch/sh/
>>> and renaming it to something with an sh_ prefix.
>>>
>>
>> Yes, this is a good idea, but what about the sh-specific drivers that
>> rely on it? Is including headers from arch/ in driver code still an
>> accepted practice?
>
> I think it's fine here, since we're just move it out of the way and
> there are only very few drivers using it:
>
> drivers/clocksource/sh_cmt.c:early_platform_init("earlytimer",
> &sh_cmt_device_driver);
> drivers/clocksource/sh_mtu2.c:early_platform_init("earlytimer",
> &sh_mtu2_device_driver);
> drivers/clocksource/sh_tmu.c:early_platform_init("earlytimer",
> &sh_tmu_device_driver);
> drivers/clocksource/timer-ti-dm.c:early_platform_init("earlytimer",
> &omap_dm_timer_driver);
> drivers/tty/serial/sh-sci.c:early_platform_init_buffer("earlyprintk",
> &sci_driver,
>
> For timer-ti-dm, it seems like a leftover from old times that can
> be removed. The other four are shared between arch/sh and
> arch/arm/mach-shmobile and already have some #ifdef
> to handle those two cases.

Sh-sci is also used on arm64, for R-Car Gen3 SoCs.
While the latter has CMT and TMU hardware blocks, so far we haven't enabled
support for it yet (just using the ARM arch timer is too convenient? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
