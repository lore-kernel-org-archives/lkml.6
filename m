Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030952AbeBPP5M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:57:12 -0500
Received: from muru.com ([72.249.23.125]:57236 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030613AbeBPP5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:57:11 -0500
Date: Fri, 16 Feb 2018 07:57:07 -0800
From: Tony Lindgren <tony@atomide.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,cpcap-audio-codec
Message-ID: <20180216155706.GS6364@atomide.com>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
 <20180216113008.GB5886@sirena.org.uk>
 <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
 <20180216134448.GI5886@sirena.org.uk>
 <20180216141237.rd75sbix7bopi7zu@earth.universe>
 <20180216151609.GK5886@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216151609.GK5886@sirena.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown <broonie@kernel.org> [180216 15:17]:
> On Fri, Feb 16, 2018 at 03:12:37PM +0100, Sebastian Reichel wrote:
> > On Fri, Feb 16, 2018 at 01:44:48PM +0000, Mark Brown wrote:
> > > On Fri, Feb 16, 2018 at 02:25:38PM +0100, Sebastian Reichel wrote:
> 
> > > > While it looks empty in the DT binding file, it's actually not empty
> > > > once some standard properties are added to support audio-graph-card.
> 
> > > This tells me you're missing something in the binding defining the
> > > DAIs and...
> 
> > Well it is described by the following document:
> 
> > Documentation/devicetree/bindings/sound/audio-graph-card.txt
> 
> You still need to say which DAIs exist on the device and how they are
> identified - if there's only one DAI it's obviously easy but if a device
> has multiple DAIs then there's some naming to do.
> 
> > > ...that still doesn't require a compatible here.
> 
> > I agree, that it's not required. Also the node is not required.
> > Everything could be dumped into the main node. Many things are
> > not required, but they make implementations easier and help in
> > regards to DT readability and consistency. Having the compatible
> > means, that all sub-functions _can_ be handled equally by the
> > operating system. Not having the compatible means you _always_
> > need special handling for the audio codec. This basically makes
> > the codec node different for the simple purpose of "because it is
> > not strictly required". If we have a compatible node, other
> > operating systems can still decide to ignore it, right?
> 
> It's not just other operating systems, it's also other versions of
> Linux we have to think about here.  The most obvious issue with audio is
> the clocking where the division between ASoC and clock APIs is not super
> obvious and could easily change in the future.

Yeah let's stick to describing how the hardware is wired in the
dts files. In this case it's really only the routing to the SoC,
right?

One advantage of using a compatible property for the pmic subdevices
though is that it leaves out a dependency between various device
drivers things happen automagically. The mfd core driver can be
minimal and just implement interrupt handling and regmap. So no need
to to parse the child nodes in the pmic mfd driver :)

So personally I'd prefer the option that requires least amount
of custom code if compatible vs no compatible property is the
only issue here.

Regards,

Tony
