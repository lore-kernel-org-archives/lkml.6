Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbeCLJIo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:08:44 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:55050 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbeCLJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:08:42 -0400
X-Google-Smtp-Source: AG47ELvDxUZGKJWyK/DypotxGuOT8Bau4OLZQaDDWhoYYSBbKFFtqcStIeYlKdYxwYf5fddiIvYr5w==
Date: Mon, 12 Mar 2018 09:08:38 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Message-ID: <20180312090838.ubqvlqnqzv6g4cxr@dell>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
 <20180308170736.GN5799@atomide.com>
 <20180309112915.bjnqi7tddgucdqjl@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180309112915.bjnqi7tddgucdqjl@earth.universe>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Mar 2018, Sebastian Reichel wrote:

> Hi,
> 
> On Thu, Mar 08, 2018 at 09:07:36AM -0800, Tony Lindgren wrote:
> > * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180308 09:47]:
> > > Hi Lee,
> > > 
> > > On Wed, Mar 07, 2018 at 04:32:11PM +0000, Lee Jones wrote:
> > > > On Fri, 23 Feb 2018, Sebastian Reichel wrote:
> > > > > +static const struct mfd_cell cpcap_mfd_devices[] = {
> > > 
> > > [...]
> > > 
> > > > > +	}, {
> > > > > +		.name          = "cpcap-led",
> > > > > +		.id            = 4,
> > > > > +		.of_compatible = "motorola,cpcap-led-cp",
> > > > > +	}, {
> > > > > +		.name          = "cpcap-codec",
> > > > > +	}
> > > > > +};
> > > > 
> > > > With none of the entries containing platform_data /me wonders why you
> > > > can't still use devm_of_platform_populate()?
> > > 
> > > Because devm_of_platform_populate works with compatible properties and
> > > cpcap-codec does not have one after I removed it for Mark.
> > 
> > How about keep devm_of_platform_populate() for the ones that
> > already have compatible. Then add a table entry for cpcap-codec
> > only and call devm_mfd_add_devices()?
> 
> This should work. I think it makes sense to wait for Rob Herring's
> feedback on the binding. My understanding is, that he has the last
> word on binding questions and I would like to avoid changing this
> back and forth.

I've been avoiding mix-and-matching mfd_*() and of_platform_*() APIs,
else it gets too confusing for new developers.

*If* you make the switch to mfd_*() APIs (not preferable), then I
would like to see of_platform_*() removed.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
