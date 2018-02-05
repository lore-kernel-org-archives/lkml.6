Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeBEGMC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:12:02 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46081 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbeBEGJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:09:16 -0500
X-Google-Smtp-Source: AH8x225QoiEXZZBGcF1pM6kuerddsJx+tuyrjH6p9miwy9fmxAFTHAA5hoCkwwo1hwNwxS/7Fm+EJQ==
Date: Mon, 5 Feb 2018 00:09:14 -0600
From: Rob Herring <robh@kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] fbdev: simplefb: add support for 'memory-region'
 property on DT node
Message-ID: <20180205060914.4wherneafj6dfnev@rob-hp-laptop>
References: <CGME20180123113510epcas1p1fc8a6e3ad50127bb84fe350b156a8c07@epcas1p1.samsung.com>
 <1516707296-23667-1-git-send-email-hayashi.kunihiko@socionext.com>
 <2359956.Z9lQWSAgHb@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2359956.Z9lQWSAgHb@amdc3058>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 04:56:08PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Tuesday, January 23, 2018 08:34:56 PM Kunihiko Hayashi wrote:
> > Enables 'memory-region' property referring to the memory description on
> > the reserved-memory node in case of devicetree use.
> > If there is no 'reg' property that specifies the address and size of
> > the framebuffer, the address and size written in the memory description
> > on the reserved-memory node can be used for the framebuffer.
> > 
> > Furthermore, the reserved-memory node needs to have "no-map" attributes
> > because simplefb driver maps the region by ioremap_wc().
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> This needs an ACK from Rob or Mark (DT bindings Maintainers).
> 
> > ---
> >  .../bindings/display/simple-framebuffer.txt        |  3 ++
> >  drivers/video/fbdev/simplefb.c                     | 32 ++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.txt b/Documentation/devicetree/bindings/display/simple-framebuffer.txt
> > index 5a9ce51..be5139f 100644
> > --- a/Documentation/devicetree/bindings/display/simple-framebuffer.txt
> > +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.txt
> > @@ -56,6 +56,9 @@ Optional properties:
> >    framebuffer remains active.
> >  
> >  - display : phandle pointing to the primary display hardware node
> > +- memory-region: phandle to a node describing memory region as framebuffer
> > +		 memory instead of reg property. The node should include
> > +		 'no-map'.

This should also state when it's appropriate to use this instead of reg. 
The memory would only be reclaimed if reg is used.

Though I'm wondering what keeps the simple fb memory from getting used 
by the OS if reserved memory is not always used.

Rob
