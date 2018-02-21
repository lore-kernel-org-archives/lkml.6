Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeBUMPB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:15:01 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:47267 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeBUMO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:14:58 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH v4 03/16] of: dynamic: Add __of_node_dupv()
Date: Wed, 21 Feb 2018 14:15:39 +0200
Message-ID: <8443535.FeXUiDPB9F@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAMuHMdWQEKETp50VnU4eiHcXvBqzgdwH1z6CYbkJq_YH1=UHaw@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com> <20180220231046.32638-4-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdWQEKETp50VnU4eiHcXvBqzgdwH1z6CYbkJq_YH1=UHaw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wednesday, 21 February 2018 12:26:45 EET Geert Uytterhoeven wrote:
> On Wed, Feb 21, 2018 at 12:10 AM, Laurent Pinchart wrote:
> > From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> > 
> > Add an __of_node_dupv() private method and make __of_node_dup() use it.
> > This is required for the subsequent changeset accessors which will
> > make use of it.
> > 
> > Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/of/dynamic.c | 29 +++++++++++++++++++++++------
> >  1 file changed, 23 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > index 7bb33d22b4e2..4ffd04925fdf 100644
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
> > @@ -382,8 +382,9 @@ struct property *__of_prop_dup(const struct property
> > *prop, gfp_t allocflags)> 
> >  }
> >  
> >  /**
> > 
> > - * __of_node_dup() - Duplicate or create an empty device node
> > dynamically.
> > - * @fmt: Format string (plus vargs) for new full name of the device node
> > + * __of_node_dupv() - Duplicate or create an empty device node
> > dynamically. + * @fmt: Format string for new full name of the device node
> > + * @vargs: va_list containing the arugments for the node full name
> > 
> >   *
> >   * Create an device tree node, either by duplicating an empty node or by
> >   allocating * an empty one suitable for further modification.  The node
> >   data are> 
> > @@ -391,17 +392,15 @@ struct property *__of_prop_dup(const struct property
> > *prop, gfp_t allocflags)> 
> >   * OF_DETACHED bits set. Returns the newly allocated node or NULL on out
> >   of
> >   * memory error.
> >   */
> > 
> > -struct device_node *__of_node_dup(const struct device_node *np, const
> > char *fmt, ...) +struct device_node *__of_node_dupv(const struct
> > device_node *np,
> 
> static, cfr.
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/co
> mmit/?h=topic/overlays&id=c45324e1807dd708344c9a478b777b68aca11cdf

I'll fix that in the next version.

-- 
Regards,

Laurent Pinchart
