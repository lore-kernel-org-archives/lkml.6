Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeDAXRw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 19:17:52 -0400
Received: from muru.com ([72.249.23.125]:34910 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753915AbeDAXRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 19:17:51 -0400
Date: Sun, 1 Apr 2018 16:17:46 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Dan Williams <dcbw@redhat.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Message-ID: <20180401231746.GC5700@atomide.com>
References: <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329160828.GA14007@amd>
 <20180329163450.GQ5700@atomide.com>
 <20180329180541.GA26545@amd>
 <20180329215840.GT5700@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329215840.GT5700@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180329 22:00]:
> If it entered low-power mode, in theory we should see the state
> change interrupt that's handled by phy-mapphone-mdm6600.c.
> I never managed to do that so far so maybe you figured it out
> with some command.

And looks like the trigger to mdm6600 to enter low power states
is done via USB:

# echo auto > /sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb1/1-1/power/level

Looks like with that and modem enabled I'm seeing 207mW power
consumption on a and idle system with screen off on my power supply.
Opening /dev/ttyUSB4 makes the power consumption go up to 502mW..
So now we need the wakeirqs and PM runtime to work for ohci and
then the device can be used for few hours on batteries.

Regards,

Tony
