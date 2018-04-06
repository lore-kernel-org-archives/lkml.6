Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933137AbeDFNr1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:47:27 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:35056 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754965AbeDFNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:47:25 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: renesas: eagle: Enable DU
Date: Fri, 06 Apr 2018 16:47:23 +0300
Message-ID: <1607257.kzKzzg5gBe@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <35431593.B1LTs037XF@avalon>
References: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org> <1523020092-25540-6-git-send-email-jacopo+renesas@jmondi.org> <35431593.B1LTs037XF@avalon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On Friday, 6 April 2018 16:45:16 EEST Laurent Pinchart wrote:
> On Friday, 6 April 2018 16:08:10 EEST Jacopo Mondi wrote:
> > Enable DU for Renesas R-Car V3M Eagle board.
> > 
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> > 
> >  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> > b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts index 3c5f598..144b847
> > 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> > @@ -76,6 +76,11 @@
> > 
> >  		function = "i2c0";
> >  	
> >  	};
> > 
> > +	du_pins: du {
> > +		groups = "du_rgb666", "du_sync", "du_oddf", "du_clk_out";
> > +		function = "du";
> > +	};
> 
> As far as I can tell the DU parallel output isn't used on the Eagle board,
> but is used on the Eagle expansion board. I would move this to patch 7/7 in
> this series.

My bad, patch 7/7 describes the on-board HDMI encoder, not the one on the 
expansion board. I would thus drop pinmux completely for now until we add 
support for the expansion board.

> >  	scif0_pins: scif0 {
> >  	
> >  		groups = "scif0_data";
> >  		function = "scif0";
> > 
> > @@ -93,3 +98,9 @@
> > 
> >  	status = "okay";
> >  
> >  };
> > 
> > +
> > +&du {
> > +	pinctrl-0 = <&du_pins>;
> > +	pinctrl-names = "default";
> 
> These two properties should be moved to patch 7/7 too.

So this should be removed.

> > +	status = "okay";
> > +};
> 
> There's little use for enabling the DU in DT if you have no output port
> described. I'd move this to patch 6/7.

And I'd merge the status attribute and patches 6/7 and 7/7 all together.

-- 
Regards,

Laurent Pinchart
