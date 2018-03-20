Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753736AbeCTOGv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:06:51 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:34131 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753351AbeCTOGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:06:45 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Rob Herring <robh@kernel.org>
Cc: Archit Taneja <architt@codeaurora.org>,
        Alexandru M Stan <amstan@chromium.org>,
        David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>, Sean Paul <seanpaul@chromium.org>,
        devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        marcheu@chromium.org, hoegsberg@chromium.org,
        Thierry Escande <thierry.escande@collabora.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH 1/2] dt-bindings: analogix-dp: Add backlight-pwm-passthru
Date: Tue, 20 Mar 2018 16:07:50 +0200
Message-ID: <15529527.TZOXJSfS0B@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180318125245.ndnplplmtsy3hmu7@rob-hp-laptop>
References: <20180316025659.217423-1-amstan@chromium.org> <124034c6-a0af-0142-0d04-7d8bbc19bb82@codeaurora.org> <20180318125245.ndnplplmtsy3hmu7@rob-hp-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sunday, 18 March 2018 14:52:45 EET Rob Herring wrote:
> On Fri, Mar 16, 2018 at 02:56:09PM +0530, Archit Taneja wrote:
> > On Friday 16 March 2018 08:26 AM, Alexandru M Stan wrote:
> > > Documentation for the optional backlight-pwm-passthru property.
> > > Tells the EDP panel to folow the input pwm frequency instead
> > 
> > s/folow/follow
> > 
> > It would be nice if we could add the details you mentioned in
> > patch #0 in either this or the next patch.
> > 
> > > of generating its own.
> > 
> > This is one of those bindings which is more a knob than a HW property,
> > but I can't think of any easy way to figure this out in SW. So, I guess
> > it's okay to have.
> > 
> > One thing I was wondering about was whether this prop should belong to
> > the eDP controller or the eDP panel. I don't have any strong opinion
> > about it, though.
> 
> Seems to me, it should be the panel. It's a setting in the panel, right?

As this aims at fixing an issue with the panel, I agree it should be a panel 
property.

Stupid question (I'm not too familiar with eDP panels), couldn't we set 
EDP_BACKLIGHT_FREQ_PWM_PIN_PASSTHRU unconditionally ?

> Is this generic to DP panels or something specific to a certain panel?
> The naming (vendor prefix or not) and doc location should match
> whatever the answer to that is.
> 
> > Reviewed-by: Archit Taneja <architt@codeaurora.org>
> > 
> > Thanks,
> > Archit
> > 
> > > Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> > > ---
> > > 
> > >   Documentation/devicetree/bindings/display/bridge/analogix_dp.txt | 4
> > >   ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
> > > b/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
> > > index 0c7473dd0e51..3c15242f6ce3 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
> > > +++ b/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
> > > 
> > > @@ -23,6 +23,10 @@ Required properties for dp-controller:
> > >   		from general PHY binding: Should be "dp".
> > >   
> > >   Optional properties for dp-controller:
> > > +	-backlight-pwm-passthru:
> > > +		Directly pass the PWM frequency applied to the BL_PWM_DIM
> > > +		pin to the backlight current source. Done via
> > > +		EDP_BACKLIGHT_MODE_SET_REGISTER on DPCD.
> > > 
> > >   	-force-hpd:
> > >   		Indicate driver need force hpd when hpd detect failed, this
> > >   		is used for some eDP screen which don't have hpd signal.

-- 
Regards,

Laurent Pinchart
