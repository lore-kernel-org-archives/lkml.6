Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524819351; cv=none;
        d=google.com; s=arc-20160816;
        b=hFMHgMGAWwZr/d/jZ/72DXcp6cV349CvhRpRClIMA78ZLeOUKysqRPIuuH548+atFL
         yiL0xqoQv3SS4W53XkczNYI5oac+VpoPaU7BmMvSvKMLk2wGw6fGSNHf+A+Tirqlw+sq
         Yo5i9rPAfEG6gH9vqqwMRnit7kJoH2yWiXu/RLBq3few1i384Dg2xqCW3lDV5HRCqr1a
         ECnEJcT7ib+1cFrcwRTTr8kdaa3BytmWNfXYXH7gnHNtvQl28vjWqEwHjbkDFgcDKduW
         BCKnpUoag6VL/FiE3yJyiRyEvo8QN7q91ZSQvXfu9uqiW6lWuKPd5c474nLCb9XYYvYI
         I2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5QbK94HRzOP2gzF8faMvwXm5S8itdMKn4+kVaNFei8U=;
        b=dlH9ixvEL/yTVR2Ym/2Ciq1PYYQ7jkeVUI943V85tvRvMRHl6a4kaWWKgP314qCSrK
         YI0xwvx4oToID3HIcI22+0ECnwvooxFHqgaj+qJMg1vYdl3SXb9OW1TD6Yj5JcACx/lY
         ldZVcSh2fswiQvc/BJy0Wgy+7DCZWzSAgpl+8A6WKCNUm4ACbKdQ6pRcfRiqcCd8IPbe
         VdIZUvHgxfs3wYU+zdAa4YYwNgWJlMnnwpNYLUcVxBx+kcOGwCCIBpDNxw6d0FVLKHaB
         ayBkLI8WkyHZ44JvL3fIjZoiBq3rDZDGDB1WiMxWWpvu20uT5eEsSKEXHuTMuUAdxx5G
         7acw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lmWV6TSD;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lmWV6TSD;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZopxkrMDlnHjG5VtbNs7ZhjHT7sJnfSGEJlVGEy1dU2lyKOK/HIX0XftdZbQXTqxDZo329O7zgnur8MApQx3LY=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <6194511c-b649-8c02-7db0-3514bfb292f5@ti.com>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com> <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <6194511c-b649-8c02-7db0-3514bfb292f5@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 10:55:50 +0200
X-Google-Sender-Auth: F2gS2lx9g9Ux2GPpOZBQoSttWTk
Message-ID: <CAK8P3a394ig-OSzZLj+50gnBw1x_c41EicuM7mF_ubswweQoSg@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Sekhar Nori <nsekhar@ti.com>
Cc: David Lechner <david@lechnology.com>, Rich Felker <dalias@libc.org>,
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
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823149958129846?=
X-GMAIL-MSGID: =?utf-8?q?1598888976184856129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 10:29 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Friday 27 April 2018 01:22 PM, Arnd Bergmann wrote:
>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
>>> On 04/26/2018 12:31 PM, Rich Felker wrote:

>>
>> I haven't seen the discussion about your clock drivers, but I know that
>> usually only a very small subset of the clocks on an SoC are needed
>> that 'early', and you should use a regular platform driver for the rest.
>
> Its true that the subset is small, but they are either PLL bypass clocks
> or clocks derived out of the main clock gate controller on the Soc
> (DaVinci PSC). So we need some non-platform-device based initialization
> support in the two main clock drivers used on mach-davinci anyway.
>
>> Can you elaborate on which devices need to access your clocks before
>> you are able to initialize the clk driver through the regular platform_driver
>> framework? Do any of these need complex interactions with the clk
>> subsystem, or do you just need to ensure they are turned on?
>
> Its just the timer IP. There is no complex interaction, just need to
> ensure that the clock is registered with the framework and also switched
> on when there is a gate clock.
>
> The latest attempt by David for this was posted last night here:
>
> https://lkml.org/lkml/2018/4/26/1093

Ok, so the workaround in that series is to set up the timer clk manually
in the SoC specific code (dm365_init_time etc) and register it to the
clk subsystem, right?

That seems to be a much more appropriate workaround than adding
back early_platform devices. We can always try to do something better
later, but for now I'm happy with that as a workaround.

Please clarify: do we have to set up the clk registers for the timer
here just because we can't rely on the bootloader to have it set up
initially, or is there some other reason? I think what some other
platforms do is to treat the timer clock as a fixed-rate clock that
is not managed by the actual clk driver but is set up by uboot
before we enter the kernel, and then the clk driver just makes sure
it doesn't turn that clk off later.

        Arnd
