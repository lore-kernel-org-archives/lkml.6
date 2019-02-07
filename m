Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD4C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2E4218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfBGRbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:31:35 -0500
Received: from muru.com ([72.249.23.125]:37942 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfBGRbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:31:35 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A16DB8126;
        Thu,  7 Feb 2019 17:31:43 +0000 (UTC)
Date:   Thu, 7 Feb 2019 09:31:31 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, letux-kernel@openphoenux.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm: dts: gta04: add gps support
Message-ID: <20190207173131.GF5720@atomide.com>
References: <20190131180640.14480-1-andreas@kemnade.info>
 <20190131180640.14480-3-andreas@kemnade.info>
 <20190201100416.GD3691@localhost>
 <20190201200630.2efc9eef@kemnade.info>
 <20190204083032.GB4686@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204083032.GB4686@localhost>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [190204 08:30]:
> On Fri, Feb 01, 2019 at 08:06:30PM +0100, Andreas Kemnade wrote:
> > On Fri, 1 Feb 2019 11:04:16 +0100
> > Johan Hovold <johan@kernel.org> wrote:
> > 
> > > On Thu, Jan 31, 2019 at 07:06:40PM +0100, Andreas Kemnade wrote:
> > > > The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> > > > which one is mounted so use the compatibility entry for w2sg0004
> > > > for all which will work for both.
> > > > 
> > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > ---
> > > > Changes in v3:
> > > > - converted to a patchset
> > > > - added vcc-supply
> > > > 
> > > > Changes in v2:
> > > > - some s/gps/gnss/
> > > > - not added vcc-supply because the regulator is not modelled
> > > >   in dts at all
> > > > 
> > > > w2sg0004 bindings are in next-20190129
> > > > 
> > > >  arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> > > > index 02d8274a2f47..4ea0f7dc37c6 100644
> > > > --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> > > > +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> > > > @@ -320,6 +320,12 @@  
> > > >  		>;  
> > > >         };
> > > >  
> > > > +	gps_pins: pinmux_gps_pins {  
> > > 
> > > s/gps/gnss/ would be more consistent, but whatever.
> > > 
> > well, gps is already in the file at another place. So it is a bit
> > inconsistent in any case, without further cleanup. If someone comes
> > up with a strong opinion here I would of course change it.
> 
> Up to you. As long as the gnss node is named "gnss" I don't have a
> strong opinion on the other names (as long as they follow the spec of
> course).

OK so I'm applying these two patches into omap-for-v5.1/dt.

Thanks,

Tony
