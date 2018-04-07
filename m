Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeDGJ4z (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 05:56:55 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:40791 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeDGJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 05:56:50 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, airlied@linux.ie, vladimir_zapolskiy@mentor.com,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
Date: Sat, 07 Apr 2018 12:56:48 +0300
Message-ID: <2813569.TyIUb2mkfU@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180407094556.GQ20945@w540>
References: <1523018517-24121-1-git-send-email-jacopo+renesas@jmondi.org> <2441543.5xTHaLXzZ0@avalon> <20180407094556.GQ20945@w540>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Saturday, 7 April 2018 12:45:56 EEST jacopo mondi wrote:
> On Fri, Apr 06, 2018 at 06:40:14PM +0300, Laurent Pinchart wrote:
> > Hi Jacopo,
> > 
> > (CC'ing Mark Brown)
> 
> Hi Mark
> 
> [snip]
> 
> >> Anyway, we spent enough time on naming issues, starting from my first
> >> stupid 'pdwn' permutations then on this semi-standard names.
> >> 
> >> I'll send next version with 'powerdown-gpios' and 'oe-gpios'
> >> properties hoping that would be finally accepted by everyone.
> > 
> > I certainly won't complain (as long as you write pwdn instead of pdwn in
> > the driver :-)).
> 
> Oh, so you won't complain if I address your comments? Thank you! :D
> By the way, the dumb pdwn name comes, again, from the chip name. I can
> change it to a saner name for sure...

And I've just realized that, I thought it was a typo :-/ If it comes with the 
datasheet I'm fine with either.

> >> Same on the mandatory/optional VCC supply thing. Let's try to make
> >> next version the final one. If the optional property with the dummy
> >> regulator doesn't satisfy you and it is preferred to have a
> >> fixed-regulator anyhow in DT I'll do in next version, othewise let's try
> >> not to change it again. I'll just remark here that in the current Eagle
> >> design vcc is connected to a power rail with no regulator at all :)
> > 
> > I don't like the dummy regulator much, as it generates a dev_warn(), which
> > makes me believe that it's a hack rather than a proper solution. You might
> > want to ask Mark Brown for his opinion.
> 
> Sure: Hi Mark, a bit of context here to save you a long(er) reading.
> 
> Unsurprisingly, the chip for which I'm writing this small driver needs
> a power supply to be properly functional :) In the development board
> it is installed on, the power supply is connected to a power rail,
> with no regulator. At the same time, some other designs may instead
> include a regulator.

To be precise, with an always-on regulator that can't be software-controlled.

> I assume that's a very common situation. I started by describing the
> regulator as optional in DT bindings, and use regulator_get_optional(). If
> that function returns PTR_ERR, the regulator is then ignored in driver's
> power management routines.
> 
> In this last version I thought I was acting smart and copied what happens
> in other DRM bridges like adv7511, which use 'regulator_get()' and work
> with a dummy if no regulator is provided in DT. Laurent has the above
> doubts on using a dummy, and I actually share some of his concerns
> (that dev_warn() is how I found out adv7511 was using a dummy, actually).
> 
> To sum up: when a regulator is described as optional in DT, do you
> suggest to work with a dummy if it's not there, or use the _optional()
> version of regulator_get() and manually set it to NULL and ignore it
> in the enable/disable driver's routines?
> 
> Bonus question: Laurent likes to have the regulator described as required,
> and thus require it to be described in DT also in cases where it is not
> actually there using a 'fixed-regulator' and refuse to probe if the
> regulator is not available. Do you encourage this approach, or prefer to
> have it optional and handle it in the driver in one of the above described
> ways?

-- 
Regards,

Laurent Pinchart
