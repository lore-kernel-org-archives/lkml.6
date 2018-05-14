Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbeENJtH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:49:07 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38306 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbeENJtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:49:03 -0400
X-Google-Smtp-Source: AB8JxZroqPbuT1jPi33Qsx8gpJMDPKU+9CteKrDoCApu7+gWk0cr2j5I8uaRlVH3uaDlaJXDbaFO/g==
Date: Mon, 14 May 2018 11:49:00 +0200
From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, horms@verge.net.au,
        geert@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: renesas: draak: Describe HDMI input
Message-ID: <20180514094900.GF30519@bigcity.dyn.berto.se>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526032802-14376-4-git-send-email-jacopo+renesas@jmondi.org>
 <20180513125755.GQ18974@bigcity.dyn.berto.se>
 <26780153.JLo9OE30iv@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26780153.JLo9OE30iv@avalon>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 2018-05-14 05:49:41 +0300, Laurent Pinchart wrote:

[snip]

> > > +&vin4 {
> > > +	pinctrl-0 = <&vin4_pins>;
> > > +	pinctrl-names = "default";
> > > +
> > > +	status = "okay";
> > > +
> > > +	ports {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		port@0 {
> > > +			reg = <0>;
> > > +
> > > +			vin4_in: endpoint {
> > > +				hsync-active = <0>;
> > > +				vsync-active = <0>;
> > 
> > Comparing this to the Gen2 bindings some properties are missing,
> > 
> > bus-width = <24>;
> > pclk-sample = <1>;
> > data-active = <1>;
> > 
> > This is not a big deal as the VIN driver don't use these properties so
> > no functional change should come of this but still a difference.
> 
> I think the VIN DT bindings should be updated to explicitly list the endpoint 
> properties that are mandatory, optional, or not allowed.

I think it's documented as it reference video-interfaces.txt which lists 
all these properties as optional. And in deed they are all optional.  If 
the VIN driver makes use of all the optional ones is another matter. How 
do we know that the remote subdevice is not looking at its remote 
endpoint for bus parameters not considered by the rcar-vin driver?

The thing is that the rcar-vin driver only looks at the remote endpoint 
for these properties and ignores the on its local endpoint. Maybe some 
v4l2 framework change is needed here to make sure the bus properties are 
the same on both endpoints of a link. But I fear such a change would 
break a lot of stuff.

-- 
Regards,
Niklas Söderlund
