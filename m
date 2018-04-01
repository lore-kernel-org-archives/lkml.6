Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeDAPgh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 11:36:37 -0400
Received: from muru.com ([72.249.23.125]:34776 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753582AbeDAPgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 11:36:35 -0400
Date: Sun, 1 Apr 2018 08:36:31 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Dan Williams <dcbw@redhat.com>
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
Message-ID: <20180401153631.GA5700@atomide.com>
References: <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180331145531.GA10404@amd>
 <20180331181935.GX5700@atomide.com>
 <20180331191939.GA8999@amd>
 <20180331194616.GA19388@amd>
 <20180331195524.GB19388@amd>
 <20180331234314.GZ5700@atomide.com>
 <20180401131852.GA11086@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180401131852.GA11086@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180401 13:20]:
> On Sat 2018-03-31 16:43:14, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [180331 19:56]:
> > > On Sat 2018-03-31 21:46:16, Pavel Machek wrote:
> > > > On Sat 2018-03-31 21:19:39, Pavel Machek wrote:
> > > > > On Sat 2018-03-31 11:19:35, Tony Lindgren wrote:
> > > > > > Cool :) Microphone still does not work for me.. I tried tweaking
> > > > > > the alsamixer settings but no mic. This is with cold boot with
> > > > > > droid4-kexecboot if that might make a difference, we may have
> > > > > > some register uninitialized somewhere. Any ideas?
> > > > > 
> > > > > Ok, I was focusing on the speaker side.
> > > > > 
> > > > > alsamixer, tab to go to capture settings, set it to 37 37 Mic2 Mic1
> > > > > should work, according to my notes, but not recently tested and not
> > > > > tested against real human.
> > > > > 
> > > > > I'll attempt to test it, but something in my userland shuts down
> > > > > system just after boot 60% of time, which is rather annoying.
> > > > 
> > > > Hmm. So I tried again, and setting Mic1 and back in the capture
> > > > settings crashed the modem. Bang, disconnected from the USB.
> > > 
> > > Next try, and it worked this time.
> > > 
> > > _Before the call_, set mode to Normal and then Call. Then go to
> > > capture, and set 100 100 Mic2 Mic1. Then place a call,
> > > 
> > > AT+CFUN=1
> > > OK
> > > ATD6;
> > 
> > No luck with microphone here :( Using ttyUSB4, AT+CFUN=1
> > works, but ATD command on it just hangs the USB interface
> > and I have to reload phy-mapphone-mdm6600 to reset the
> > modem.
> 
> Test call with real human worked (thanks to Rolf K.), I could hear him
> well but he reported call was very quiet. And that was with capture
> settings at 100%.

Maybe the volume also needs to be controlled at mdm6600 end.
I'm seeing some AT+CLVL=n with n being between [0-7] calls on
DLCI2 in my Android logcat logs.

> If you had a register dump from android with mics working, preferably
> not in speaker mode, perhaps I could try to figure it out?

OK here are four diffs against starting the phone app for regular
call, speaker call, and muted versions of them:

http://muru.com/linux/d4/cpcap/

Also, I'm connected over cdma right now, not 3g, but I doubt
that makes a difference for the microphone.

Regards,

Tony
