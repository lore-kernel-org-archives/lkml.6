Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524815572; cv=none;
        d=google.com; s=arc-20160816;
        b=JTWKqSgjUWhpFDhwNeVRrZlbojD5FpBjIs3dawREZdJgASLQ8IHLv4cPayceA7YPj/
         BQWzEMC22Utk1MNQmd1SXIZMmEpS/Y0VIumvIlQ7JeETFN333+FIEBUgpH+6HbB0t+R4
         ov+c8ogmtzh5PXzQWaQ3mIk4A7eE0YtfP1hEK8YF/+B1W/zb28v2hVj7HVslkSGZZTUw
         onJD98FHGypdfZ3hXwZz2RIvZKd5Qf/hidrsIm2awMD7BnH7K36lgSbVE0c2swKC4h7+
         JahzZFMNTtNNEzahvZM6Ol52OrB3wOO+tM+XwIGTzdTbje2OQq5f/8WsLAB4SfSyItph
         UDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9hCR4FdpJAQQFCHKC0qBIYceVywu/uFGtYMqI+anffA=;
        b=Dufn81trHiv4ag0iYmcUxmd2ni4Yq5WJ5fSxCUOzN3kiwg5ZkfqRn09rVdENQ6Q1bV
         DdNq2gIxdtDQVegYfpXt01lisPk+g4zUpH8Y2ZbIx/AgUN7VLKGznyTCPbI9I08eT1oU
         lyeuwAmrsFmt0v5Nz4rBpUrsczfZvee2YYXXDHL4e2uVhgZQastSBSECKohgpoiVk6o4
         vW4e1Y9gIPWlOfCm2SvAGd6GDJr/sx/Ir7ddHPzx6WI4FApvqnvjTmrloA/PoDSTxKVR
         qkyH4vZleuP6+/rtuhYBRF+0CQPmCI4IvmZUrBo53mTEe2EQcsOOcI+17RlZfmzozh5q
         a4ew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VhWsssQZ;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VhWsssQZ;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZpcSfPV3BhJPYCD2FBx0vCcT/Ab1IukjSDWqG/vaUnKsp4U0lxvHFTXWzH3w0xAMQpxaTE6H/289QVBGFrh/hA=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 09:52:51 +0200
X-Google-Sender-Auth: 29yabX5CDB7JI5xahR7T74qd6GE
Message-ID: <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: David Lechner <david@lechnology.com>
Cc: Rich Felker <dalias@libc.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
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
X-GMAIL-MSGID: =?utf-8?q?1598885013208156585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
> On 04/26/2018 12:31 PM, Rich Felker wrote:
>>
>> On Thu, Apr 26, 2018 at 05:29:18PM +0200, Bartosz Golaszewski wrote:
>>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> This is a follow to my series[1] the aim of which was to introduce device
>>> tree
>>> support for early platform devices.
>>>
>>> It was received rather negatively. Aside from using device tree to pass
>>> implementation specific details to the system, two important concerns
>>> were
>>> raised: no probe deferral support and the fact that currently the early
>>> devices
>>> never get converted to actual platform drivers. This series is a
>>> proof-of-concept that's trying to address those issues.
>>>
>>> The only user of the current version of early platform drivers is the
>>> SuperH
>>> architecture. If this series eventually gets merged, we could simply
>>> replace
>>> the other solution.
>>
>>
>> Looking at a quick output of:
>>
>>         grep -r -A10 early_devices[[] arch/sh/kernel/
>>
>> it looks like all of the existing early platform devices are serial
>> ports, clocks, and clocksources. The switch to device tree should pick
>> them all up from CLK_OF_DECLARE, TIMER_OF_DECLARE, and
>> EARLYCON_DECLARE. Until that's complete, the existing code works
>> as-is. I don't see what problem you're trying to solve.
>
>
> The problem for us is that clk maintainers don't want new drivers to use
> CLK_OF_DECLARE and instead use platform devices. I have just written such
> a new driver that is shared by 6 different SoCs. For some combinations of
> SoCs and clocks, using a platform device is fine but on others we need to
> register early, so the drivers now have to handle both cases, which is
> kind of messy and fragile. If there is a generic way to register platform
> devices early, then the code is simplified because we only have to handle
> one method of registering the clocks instead of two.

The early_platform code is certainly not a way to make things simpler,
it just adds one more way of doing the same thing that OF_CLK_DECLARE
already does. We removed the last early_platform users on ARM a few
years ago, and I would hope to leave it like that.

I haven't seen the discussion about your clock drivers, but I know that
usually only a very small subset of the clocks on an SoC are needed
that 'early', and you should use a regular platform driver for the rest.

Can you elaborate on which devices need to access your clocks before
you are able to initialize the clk driver through the regular platform_driver
framework? Do any of these need complex interactions with the clk
subsystem, or do you just need to ensure they are turned on?

     Arnd
