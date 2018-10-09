Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ECBC00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985A2214C2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="nvAG3DbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985A2214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeJIK0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 06:26:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40299 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJIK0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 06:26:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so106178ljr.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 20:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkSXEmHMtC4YdngtMurNMT7KNM81bEXK68+Hx/0QL+g=;
        b=nvAG3DbX3qMNpnivByuGO3omLkVpIKm0hJR75PXbub7NkNJWmQKrY+qPA2cpwblRIG
         zzjuxIxPrBt2Uu+i3XM12beZ+rMeoK/Ukmp5znFqwT9ny6inuN9EfqyLBg2+FkJm7RKl
         GpSKLw6kN/1r4xjWGyDfB1PeVhFDd4fZscWMY0kD63p5BuW4OfmLPZTaDxcOGl+Ikiq6
         kuVbZ6sKSM6zBIdOiC14+iO5MvPYP8PKKsscp8guED0ee+Z5sZBrd2KhpF/45/ogSyzj
         zjTnY0hL08/VL4hi8HMRVB4pik1DRYRmu06aUiA9tmH+BiHcYMMxl2tha+IvHuPyZdAr
         kV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkSXEmHMtC4YdngtMurNMT7KNM81bEXK68+Hx/0QL+g=;
        b=VSxSejQ/EzBqkwRvpH2z5IhvmHuOw/NGTndoKmunXhkKgW07FBPIr7fqLY6g4pNqj7
         skMzfuBGmoefkilWJeW3O8Trw7wgTedlXZc7w4CgBbi2k5ZZsOLT4OeRlyCUeXlV/mUV
         iUuBwOJ5TVvxt5RdqF0J7F2deI3CtIxtZXEr1Lp0Y0XUM+KMOz2Q1uuH04b7klFwHgXR
         S2rV7PpyZIMw4qovcfj8BDW2gHGEANyZ1m4JEEi8jEWAQdkhvWc9laV7fpgFk8w/cI1D
         N3sF5MRxqBri98X0s88Q/n10Jggk0vKLMKDZxavOXYGd5EiWXZiMx089Be4VQXHo3vLn
         OYjQ==
X-Gm-Message-State: ABuFfoiv4dD899lBb+5GkCuxX1qpQ5RB+3aL8w3UYqu2I5Ex+jozfHH1
        qfulfRy0hsv+xhXQUrUeKw3pTHGmG0T6GseFhaHcxw==
X-Google-Smtp-Source: ACcGV626VGGdBQpap/BJ/U/hDINaP8bPPf0vidTvZB5PNBTWDPMeOZdZQg4hwoSggjGAdQH7HrNHVAO9uCbalS+Abtc=
X-Received: by 2002:a2e:884e:: with SMTP id z14-v6mr2133520ljj.98.1539054679096;
 Mon, 08 Oct 2018 20:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <1537853328-1282-1-git-send-email-svellattu@mvista.com> <CAJZ5v0gvn=bipyTXEyVUbxJJbOmH5B40K=adaPVxoeX17M+M_Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gvn=bipyTXEyVUbxJJbOmH5B40K=adaPVxoeX17M+M_Q@mail.gmail.com>
From:   Silesh C V <svellattu@mvista.com>
Date:   Tue, 9 Oct 2018 08:41:13 +0530
Message-ID: <CALabi0Gz-er6JKGCYB2UR8UR6uuk-A8H5TbR4DnbEO7gGu9bCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Driver core: add bus_find_device_by_fwnode
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafael,

On Mon, Oct 8, 2018 at 1:43 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Sep 25, 2018 at 7:29 AM Silesh C V <svellattu@mvista.com> wrote:
> >
> > Some drivers need to find the device on a bus having a specific firmware
> > node. Currently, such drivers have their own implementations to do this.
> > Provide a helper similar to bus_find_device_by_name so that each driver
> > does not have to reinvent this.
> >
> > Signed-off-by: Silesh C V <svellattu@mvista.com>
> >
> > ---
> >  drivers/base/bus.c     | 26 ++++++++++++++++++++++++++
> >  include/linux/device.h |  3 +++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> > index 8bfd27e..148b198 100644
> > --- a/drivers/base/bus.c
> > +++ b/drivers/base/bus.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/string.h>
> >  #include <linux/mutex.h>
> >  #include <linux/sysfs.h>
> > +#include <linux/of.h>
> >  #include "base.h"
> >  #include "power/power.h"
> >
> > @@ -373,6 +374,31 @@ struct device *bus_find_device_by_name(struct bus_type *bus,
> >  }
> >  EXPORT_SYMBOL_GPL(bus_find_device_by_name);
> >
> > +static int match_fwnode(struct device *dev, void *data)
> > +{
> > +       struct fwnode_handle *fwnode = data;
> > +       struct device_node *of_node = to_of_node(fwnode);
> > +
> > +       if (of_node)
> > +               return dev->of_node == of_node;
> > +       else
> > +               return dev->fwnode == fwnode;
>
> Why don't you use dev_fwnode() here?
>

OK. Will send an updated patch.

Thanks,
Silesh.
