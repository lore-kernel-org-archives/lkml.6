Return-Path: <dalias@aerifal.cx>
X-Google-Smtp-Source: AB8JxZpPk7j155U8vD8znwAzeqDg2QJl/3X2KXXHr8DEmjxNKYE09oPlZlS7Tf8NddDr12XYktYj
ARC-Seal: i=1; a=rsa-sha256; t=1524842589; cv=none;
        d=google.com; s=arc-20160816;
        b=j2aeCCo8B8JKwliGE/fEk0gXpbXS0BUTymFvag8lfK+7IBRs+GkBiUPTld78BnJFA0
         fExAUE1XIPNHaGXuoVwrCq/ZZTy0Trnsu8/AL4wiIWsvypoDVdir2o+icE1rzNiYqnpn
         bOqjLy5XmG5mAkO8KE+Bm3zYgvq9xbpCfy0oqrF7k9jJSff44WYuKCTMYmfUkKiRrurb
         t0jYNnRJ2ZX+OjSLZxC/LjhREEyJyAER1L1yaaNSzNVhJ4GlyNSTC1198f2L/BC6tD8z
         4s/tvR/cqxAD/a48lWKe+rVXr8+37r+rIRd13gIcnWEGZrohMJxGKmfg9m3Hu5L7qITc
         a/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=5qEURTPVu41S5deKkzfxaMSKm2G+ksMUQlb7NvWu2o4=;
        b=ooxe+sV7UJwSgbH8G8hdARGvvajf4xLNYSp7MfPNR3OJ3gbfZQXvrwJutxvWKoMJuN
         /Thb3c455rv1LK6zg8gMsqLYqKR1NJUMc2x1d5SHDd1bXIuAVBk0EUUyP4w1dsvJ/wvr
         cZXAxRFdJ0o8/3sv20MGKFgdtAMj0LHYKajuqpzcXybhNllIsrDxf5rKVBrOTvApg1vM
         VTAYVVq6czeG5ThmHAc9NT68M5hf7n8A5WaS+RVcLbpa9yivX0bWnk3JqR3OAzv8Z2OD
         4x8I4pfAPdyQzerjT0pTpZ496CjSVZb+EwVNsbZmmgS/I3klgFhVSzpZsW/9vM+4NqmJ
         Ip+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Date: Fri, 27 Apr 2018 11:22:12 -0400
From: Rich Felker <dalias@libc.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>,
	David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Peter Rosin <peda@axentia.se>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
Message-ID: <20180427152212.GO3094@brightrain.aerifal.cx>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
 <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
 <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
 <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: Rich Felker <dalias@aerifal.cx>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823149958129846?=
X-GMAIL-MSGID: =?utf-8?q?1598913342888114987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 02:40:34PM +0200, Arnd Bergmann wrote:
> On Fri, Apr 27, 2018 at 1:53 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > 2018-04-27 12:18 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> >> On Fri, Apr 27, 2018 at 10:57 AM, Bartosz Golaszewski
> >> <bgolaszewski@baylibre.com> wrote:
> >>> 2018-04-27 9:52 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> >>>> On Fri, Apr 27, 2018 at 4:28 AM, David Lechner <david@lechnology.com> wrote:
> >>> My patch tries to address exactly the use cases we're facing - for
> >>> example by providing means to probe devices twice (early and late) and
> >>> to check the state we're at in order for users to be able to just do
> >>> the critical initialization early on and then continue with regular
> >>> stuff later.
> >>
> >> Maybe the problem is reusing the name and some of the code from
> >> an existing functionality that we've been trying to get rid of.
> >>
> >
> > I'm not reusing the name - in fact I set the prefix to earlydev_
> > exactly in order to not confuse anyone. I'm also not reusing any code
> > in the second series.
> 
> Ok.
> 
> >> If what you want to do is completely different from the existing
> >> early_platform implementation, how about starting by moving that
> >> out of drivers/base/platform.c into something under arch/sh/
> >> and renaming it to something with an sh_ prefix.
> >>
> >
> > Yes, this is a good idea, but what about the sh-specific drivers that
> > rely on it? Is including headers from arch/ in driver code still an
> > accepted practice?
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

FWIW if arch/sh is the only remaining user of the earlyprintk part,
please don't go to any trouble to preserve it. I want to move to
earlycon exclusively. Not sure if that is possible before moving the
boards that are using it to device tree; if so and it's easy, please
consider sending a patch or a sketch of what it should look like so I
can do it.

Rich
