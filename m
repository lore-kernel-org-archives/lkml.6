Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524840481; cv=none;
        d=google.com; s=arc-20160816;
        b=mGoeXj3zXT05MMLTOydvSBSNWfryoEholCeuI/l1aKnhOj/p9IWLu29u/cKAEvGzCZ
         LHmiMlBLFUi+Xyev93SQP8ITEU0xwHzSQRpHbC6dF9q6J1/EFGeKp8U2QuMzR/acCpYl
         JpOhB972DJxrPsFHr6h3tGaByBq8qs4RM575JB1ipWn9XOuj7JHxOBe6iibDhk279oHe
         Bc0Ds6FY3MVJGrjD1YuxVwvJOghXEjGKIrYWNqrMVMSce4B5PgQTFkKldSsJi9MhfgwK
         5UA5hUjwjqyteaBNFCBG7cI34tsUXh9xPkPWF4jPEsonvhM8yjTdh2+WP2RFMxBTNThR
         F0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=bu1uwr+o9/+PiAcZTDmirstuYOvrnXsyB5CJBiu+m0E=;
        b=TBBcuor1EG2iDrlfRfFEyJ7OZwOJYQLUOdE2H2NACO7Zh6/1UCtdb1y8E9gkSTBPsM
         bfaDoN++fRFwhMwqZJEFMOquTrtfndAoLSoGgmFvQA2UUGzLopo7P04Tn1X2/mOlrKVI
         TzbR5J4XBh8jOnf7bAec99m43425g2Kmi67bIgqwLeqC+JyntTUdh1afqI+BzgdPcFYX
         DiG0nLUDLgxhUMcPSq1OHKNvn4bb+GtqnX1ci4JGyHmiE/V9AC3lq0+cx7MvUMsIr86b
         xUCjE4VWDn/T8qYzOiryI/1mDzVT/XqsF2jpaM9CNtjeO/migp2SNBDGvp++HaLxD1rA
         FYDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uKPuRFB2;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uKPuRFB2;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZoa8LhCkADp7SQH/FmeU+zSNz1+QhyVrSUwlWobzIhuNPdMJTUPVg2xOXIFk5vG7qwXZZcohU7F71Rl2QunCLc=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAMpxmJVkRDLkpcgzhMb41z=Tp6zvszLd0vqfdTtZBNGT6Trtqw@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com> <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
 <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
 <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com> <CAMpxmJVkRDLkpcgzhMb41z=Tp6zvszLd0vqfdTtZBNGT6Trtqw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 16:48:00 +0200
X-Google-Sender-Auth: hacJzFUg1MCjUh5SkB5TPgccazw
Message-ID: <CAK8P3a22DKpqMGdjYoBzKfNHc2GvAbvaZowZpz=SFeQHVSWjsg@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
X-GMAIL-MSGID: =?utf-8?q?1598911133061119567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 4:05 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> 2018-04-27 14:40 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:

>> For timer-ti-dm, it seems like a leftover from old times that can
>> be removed. The other four are shared between arch/sh and
>> arch/arm/mach-shmobile and already have some #ifdef
>> to handle those two cases.
>>
>
> I'm also seeing that we also call early_platform_cleanup() from
> platform_bus_init(). Any ideas for this one?

My first idea would be to call it immediately after registering all
devices and drivers. It looks like it's only needed to make all
devm_ allocations persistent by removing them from the list,
so we have to call early_platform_cleanup() before getting
to the real platform code, but it could be done much earlier
if we want to, at least after both setup_arch() and sh_late_time_init()
are complete.

>> I'd rather keep those separate and would prefer not to have
>> that many different ways of getting there instead. DT and
>> board files can already share most of the code through the
>> use of platform_device, especially when you start using
>> device properties instead of platform_data, and the other
>> two are rare corner cases and ideally left that way.
>>
>> The early boot code is always special and instead of making
>> it easier to use, we should focus on using it as little as
>> possible: every line of code that we call before even
>> initializing timers and consoles means it gets harder to
>> debug when something goes wrong.
>>
>
> I'm afraid I don't quite understand your reasoning. I fully agree that
> devices that need to be initialized that early are a rare corner case.
> We should limit any such uses to the absolute minimum. But when we do
> need to go this way, we should do it right. Having a unified mechanism
> for early devices will allow maintainers to enforce good practices
> (using resources for register mapping, devres, reusing driver code for
> reading/writing to registers). Having initialization code in machine
> code will make everybody use different APIs and duplicate solutions. I
> normally assume that code consolidation is always good.
>
> If we add a way for DT-based platform devices to be probed early - it
> would be based on platform device/driver structures anyway. Why would
> we even want to not convert the board code into a simple call to
> early_platform_device_register() if we'll already offer this API for
> device tree?

I think we first need to define what we really want to achieve here.
It sounds like you still want to recreate a lot of what early_platform
devices do, but it seems more important to me to add the missing
functionality to the OF_DECLARE infrastructure. The most
important pieces that seem to be missing are solved by finding
a way to provide a platform_device pointer with the following
properties:

- allow being passed into dev_print()
- allow using the pointer as a token for devres unwinding
- access to device_private data that remains persistent
  until real a platform_driver gets loaded

That can probably be done as an extension to the current
infrastructure.

However, I'd be very cautious about the resource portion:
filling the platform resources (registers, irqs, ...) the way
we do for regular devices is much harder and can introduce
additional (or circular) dependencies on other devices.
OTOH, not using those resources means you have a hard
time passing information from board files.

          Arnd
