Return-Path: <bgolaszewski@baylibre.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524819556; cv=none;
        d=google.com; s=arc-20160816;
        b=tsdWNSE12Xb/dvlklQf97xwQQBJoHJRfM8ag+DaIbzyWtyzYCk6qbSCo73Fli4WyUd
         wsLf/yXZBCRofnWgujkLduhAkOwoLF/RcMVMr4IG/GW6zSiN+3y6b5X9VAnyaLP4sUJA
         QzUhaupHaVm43m/OpeAur7odZ1161uf4JQqdY5DbiCD+BRttjDYfITvVOFBwbhRYaH0s
         TSGiEQyXhCgIsCAb0lPmhEG80GLCql9yMOPvvZiGtE1jbuByeQwiaVieExOUtBVsiEOJ
         fYdaBzxzbfgIrySO/KWLHETs6aR013RME/1Lx5FDgNuqHx0lNHvI/DkwW8+sp5h5WAVq
         X/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=KPAqiKvUcSVJcpp51do0IzBxcrNb/hQmSf3QZYX0XZU=;
        b=ZMW+XcB2KREPJnYkm0eqSpM8HqgeXbHZXJMWuU1x6JwMQKd6GlNXokYZcohRsgHBXX
         j/lUegiiOXQcdmBqPqqMK/myinLhUT0AEy44cSDa5py6e5vTrnUQij901bmLVW/nsQQ+
         2jZ5zEJJtInPBvggiloJHov9kh9bztPvi5F3nf7Mid/KxpWqles8STl02Ph6CIVAWka0
         98m60uRd8n102847dyCJXIeoVIGJDaM2mAaui20x9z8oUMJqCn7VyDvopf8a/6O6Dnav
         xi5K0u78yx3zauHj4BKHImZOjkeW2mJx89De7yey3aUXnW7wZuNNuud2FQxWNlYI6YMJ
         pbPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=FqtQrl3Q;
       spf=softfail (google.com: domain of transitioning bgolaszewski@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=bgolaszewski@baylibre.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=FqtQrl3Q;
       spf=softfail (google.com: domain of transitioning bgolaszewski@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=bgolaszewski@baylibre.com
X-Google-Smtp-Source: AB8JxZqbw2GCNnyDCVXnBuAK+0h6IyvmxgH+fUyPASpEmwoejDpkk1Ci+PcMMNi1i0gsBDPvL8zPLB/mv1vyky4YuEA=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a394ig-OSzZLj+50gnBw1x_c41EicuM7mF_ubswweQoSg@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com> <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <6194511c-b649-8c02-7db0-3514bfb292f5@ti.com> <CAK8P3a394ig-OSzZLj+50gnBw1x_c41EicuM7mF_ubswweQoSg@mail.gmail.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 27 Apr 2018 10:59:15 +0200
Message-ID: <CAMpxmJVtq0joL1r9WJUC2BNX4mQdy0kMvmpfSv7hNZn8a3Lxxg@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>, Rich Felker <dalias@libc.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1598889190764013195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-27 10:55 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> On Fri, Apr 27, 2018 at 10:29 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On Friday 27 April 2018 01:22 PM, Arnd Bergmann wrote:
>>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>>>> On 04/26/2018 12:31 PM, Rich Felker wrote:
>
>>>
>>> I haven't seen the discussion about your clock drivers, but I know that
>>> usually only a very small subset of the clocks on an SoC are needed
>>> that 'early', and you should use a regular platform driver for the rest.
>>
>> Its true that the subset is small, but they are either PLL bypass clocks
>> or clocks derived out of the main clock gate controller on the Soc
>> (DaVinci PSC). So we need some non-platform-device based initialization
>> support in the two main clock drivers used on mach-davinci anyway.
>>
>>> Can you elaborate on which devices need to access your clocks before
>>> you are able to initialize the clk driver through the regular platform_driver
>>> framework? Do any of these need complex interactions with the clk
>>> subsystem, or do you just need to ensure they are turned on?
>>
>> Its just the timer IP. There is no complex interaction, just need to
>> ensure that the clock is registered with the framework and also switched
>> on when there is a gate clock.
>>
>> The latest attempt by David for this was posted last night here:
>>
>> https://lkml.org/lkml/2018/4/26/1093
>
> Ok, so the workaround in that series is to set up the timer clk manually
> in the SoC specific code (dm365_init_time etc) and register it to the
> clk subsystem, right?
>
> That seems to be a much more appropriate workaround than adding
> back early_platform devices. We can always try to do something better
> later, but for now I'm happy with that as a workaround.
>

Just to clarify: this is not bringing back the hacky early platform
devices from before. It's a new approach that actually uses the linux
platform driver model (unlike the current mechanism which only uses
the same data structures).

Thanks,
Bart
