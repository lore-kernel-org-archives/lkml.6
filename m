Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4934CC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52AF20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM2MU0XH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52AF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeG2QXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 12:23:04 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43298 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeG2QXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 12:23:04 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so16929940oib.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Mj3jzqOH4ucWcl8JL/T9VLgS75LofnzFvrs3qnCc8I=;
        b=KM2MU0XHu05gQHlsVFwIB4LWic8AzEtlHFIBYXsRbka8JaDiBc/atT1Njxl7HRTfbA
         6pZPF+WTsz/g3Q6KrvUATgJopdoadF1nT7OcZioZuVfykdyudwm2YIdaIgaw/fXrrCYB
         ZLufo3riYIacEPQrqSNiJ1KuNzB4Pe0VhvFg3huKx59r3NlaF2P0YHcFXygPMk55XfLW
         AMBV9dAt0wjdVxhlNAbm4rbl4gmsNhYE2aaIK+ftbk/0NztIc6/b4i2GkStWy0vrUqvc
         PkJ986fArgPaBa73uodf5mGvUciHtyacG6yY6oTbIVcfhgtkfV/P96WB8EU/KT+mst8P
         pkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Mj3jzqOH4ucWcl8JL/T9VLgS75LofnzFvrs3qnCc8I=;
        b=B5zKRsJIZCqIkUuKh4cAVJVP95HLX6tXVW0fk2I9TL77evkEInBaJTqjLBn4WwR1dJ
         hIRsyJFAgUtf0cNHvO5UiIQclRLt3E9bjiXS+ug4x1k9hO+hfGO5st+7Td7Qsdyp2yDg
         Vi3dtDshoSJMHjV6MOuBQW1G3heHY45EZSKBIfH+OXPObIMLZWI6Vjf2DubbOczXL6Nn
         gylaCZ9IQdsMllQHUm/pUReVf5/R2Sa3CHPa+tOKLlNcN4LB9Lxc8Gy1kluriHWqEZAq
         bP0JhGoxZe7MUJb8OHd2OTSrnDn+F2d6LFZyWU+5AYG43P+y1fDq8XRmcPrAAHifnSWp
         HthQ==
X-Gm-Message-State: AOUpUlFyhGBavBR521MOi0bCFXEOlL2YPhxRihIYevqEi1VOOSSYn7FA
        KUFDbwWEhYDYE8/82SCcLzJJYL8AN+b8rbR/P7M=
X-Google-Smtp-Source: AAOMgpec7sWKqkKwVCnkWhZhiDO7bYjVDA9OvWv/Xa/bd+rSWeMfeKesa4x4Wgf9SL4AIqAx5Qg5cH1AewyMPZqNOaE=
X-Received: by 2002:aca:cd84:: with SMTP id d126-v6mr15417035oig.325.1532875941287;
 Sun, 29 Jul 2018 07:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <3b90173dc3a8ce12ef7f4896f05673140ac3b4d7.camel@perches.com>
 <cover.1532864059.git.tsotsos@gmail.com> <81f71a7c1997e53ec97f2b90ae562ff361a46f42.1532864059.git.tsotsos@gmail.com>
 <20180729124320.GA27275@kroah.com>
In-Reply-To: <20180729124320.GA27275@kroah.com>
From:   Georgios Tsotsos <tsotsos@gmail.com>
Date:   Sun, 29 Jul 2018 17:52:10 +0300
Message-ID: <CADERADOfQrrgi09SyFR4gdGLyF5k3x6rdoMtJkfU5rjHQjTrYw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] Staging: octeon-usb: Breaks down cvmx_usb_poll_channel().
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, James Hogan <jhogan@kernel.org>,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Regarding your latest comment, i have notice many functions in this module
using kerneldoc and not been global, also there are various erroneous
situations that functions return not defined error codes.
I will try to fix them all and a new patch series for those two issues after
this one is ok. (I hope with less versions :))
On Sun, 29 Jul 2018 at 15:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jul 29, 2018 at 02:41:53PM +0300, Georgios Tsotsos wrote:
> > In order to make this function more clear a new function created that controls
> > channels halt on no DMA mode.
> >
> > Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> > ---
> >  drivers/staging/octeon-usb/octeon-hcd.c | 81 +++++++++++++++++++++------------
> >  1 file changed, 53 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> > index 8a7bdf1a9fe6..3f44ac260eff 100644
> > --- a/drivers/staging/octeon-usb/octeon-hcd.c
> > +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> > @@ -2593,7 +2593,51 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
> >               cvmx_usb_complete(usb, pipe, transaction, CVMX_USB_STATUS_OK);
> >       }
> >  }
> > +/**
>
> Blank line between functions please.
>
> Also, as this is not a global function, no need for kerneldoc
> formatting, but you did it already, so no big deal.
>
> > + * Handles channels halt in non DMA mode
> > + * @hcchar_chena:
> > + * @hcint_xfercompl:
> > + * @usb:             USB device
> > + * @channel:         Channel to poll
> > + *
> > + * In non DMA mode the channels don't halt themselves. We need
> > + * to manually disable channels that are left running
> > + *
> > + * Returns: -1 on halt
> > + */
> > +static int cvmx_usb_dma_halt(u32 hcchar_chena, u32 hcint_xfercompl,
> > +                          struct octeon_hcd *usb, int channel)
> > +{
> > +     struct usb_hcd *hcd = octeon_to_hcd(usb);
> > +     struct device *dev = hcd->self.controller;
> >
> > +     if (hcchar_chena) {
> > +             union cvmx_usbcx_hcintmskx hcintmsk;
> > +             union cvmx_usbcx_hccharx usbc_hcchar;
> > +             /* Disable all interrupts except CHHLTD */
> > +             hcintmsk.u32 = 0;
> > +             hcintmsk.s.chhltdmsk = 1;
> > +             cvmx_usb_write_csr32(usb,
> > +                                  CVMX_USBCX_HCINTMSKX(channel, usb->index),
> > +                                  hcintmsk.u32);
> > +             usbc_hcchar.s.chdis = 1;
> > +             cvmx_usb_write_csr32(usb,
> > +                                  CVMX_USBCX_HCCHARX(channel, usb->index),
> > +                                  usbc_hcchar.u32);
> > +             return -1;
>
> Do not make up error values, return -EINVAL or something like that (what
> ever the real error here is.)
>
> > +     } else if (hcint_xfercompl) {
> > +             /*
> > +              * Successful IN/OUT with transfer complete.
> > +              * Channel halt isn't needed.
> > +              */
> > +     } else {
> > +             dev_err(dev, "USB%d: Channel %d interrupt without halt\n",
> > +                     usb->index, channel);
> > +             return -1;
>
> Same here.
>
> thanks,
>
> greg k-h



--
Best regards!
Georgios Tsotsos
Greece-Evia-Chalkida
tsotsos@linux.com
skype: tsotsos
------------------------------------
Georgios Tsotsos
*Greece - Evia - Chalkida*
tsotsos[at]linux.com
skype: tsotsos
