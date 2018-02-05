Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeBEMDo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:03:44 -0500
Received: from mx.socionext.com ([202.248.49.38]:23226 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751979AbeBEMDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:03:36 -0500
Date: Mon, 05 Feb 2018 21:03:35 +0900
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] fbdev: simplefb: add support for 'memory-region' property on DT node
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
In-Reply-To: <20180205060914.4wherneafj6dfnev@rob-hp-laptop>
References: <2359956.Z9lQWSAgHb@amdc3058> <20180205060914.4wherneafj6dfnev@rob-hp-laptop>
Message-Id: <20180205210334.32F0.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, 5 Feb 2018 00:09:14 -0600 <robh@kernel.org> wrote:

> On Thu, Feb 01, 2018 at 04:56:08PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Tuesday, January 23, 2018 08:34:56 PM Kunihiko Hayashi wrote:
> > > Enables 'memory-region' property referring to the memory description on
> > > the reserved-memory node in case of devicetree use.
> > > If there is no 'reg' property that specifies the address and size of
> > > the framebuffer, the address and size written in the memory description
> > > on the reserved-memory node can be used for the framebuffer.
> > > 
> > > Furthermore, the reserved-memory node needs to have "no-map" attributes
> > > because simplefb driver maps the region by ioremap_wc().
> > > 
> > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > 
> > This needs an ACK from Rob or Mark (DT bindings Maintainers).
> > 
> > > ---
> > >  .../bindings/display/simple-framebuffer.txt        |  3 ++
> > >  drivers/video/fbdev/simplefb.c                     | 32 ++++++++++++++++++++++
> > >  2 files changed, 35 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.txt b/Documentation/devicetree/bindings/display/simple-framebuffer.txt
> > > index 5a9ce51..be5139f 100644
> > > --- a/Documentation/devicetree/bindings/display/simple-framebuffer.txt
> > > +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.txt
> > > @@ -56,6 +56,9 @@ Optional properties:
> > >    framebuffer remains active.
> > >  
> > >  - display : phandle pointing to the primary display hardware node
> > > +- memory-region: phandle to a node describing memory region as framebuffer
> > > +		 memory instead of reg property. The node should include
> > > +		 'no-map'.
> 
> This should also state when it's appropriate to use this instead of reg. 
> The memory would only be reclaimed if reg is used.
> 
> Though I'm wondering what keeps the simple fb memory from getting used 
> by the OS if reserved memory is not always used.

Sorry that my understanding might not be correct.

Since a framebuffer defined by "reserved-memory" can't be reclaimed,
I've assumed such the framebuffer was dedicated and had some restrictions
by device or firmware.

Even in that case, You mean that we describe only "reg" directly,
not go through "reserved-memory". Is that correct?

It might be better to define new driver handling the dedicated framebuffer
rather than using simple-fb, though, I'm not sure.

---
Best Regards,
Kunihiko Hayashi
