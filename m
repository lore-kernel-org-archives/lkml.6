Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14DDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CB221570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yNcrUJJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CB221570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeI0PKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:10:32 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39010 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeI0PKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:10:31 -0400
Received: by mail-it1-f195.google.com with SMTP id w200-v6so6668339itc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LN82kBLMbUwOGlu9+EOQTrB7Wt/hDKp4rCdGDeOv1hU=;
        b=yNcrUJJHTaZ69VBCpoNwoiH7e9mHAURHrwy4i+D0moCXLsSJygObO49oOZodtqIt1G
         37xQmjfSiO7uSJBuR+RwJLCfbmfFswUZuAfDKiKhNpt4S4iCxCN0IAFu2+8hw9vbo4hv
         WvctYUI3K1svuObW/1o84HURnZsjFYZ77DR7pYhGClNU3ZxKSvrQmIXMC+oOP0slmxYf
         RDrnsiSLv//JGlendXJBPh4o4GJ6DyUDodpo3LJD1HFwfdjCOR7GgWhlCIQfCurjeqp8
         7BZz7/4i915fplPapGKBdz9uYcD4fuOpgo75En6pW/rXA0/JwmCtBdYlH1jwYeH+UOAf
         mr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LN82kBLMbUwOGlu9+EOQTrB7Wt/hDKp4rCdGDeOv1hU=;
        b=FZJPKIc7hiFHjrRmXHGlFCGfRX3s2jPZpHjWDPJKfHBR+67hNl54zbb95PV85PMcPp
         CG92Cw1rH0NITsgfY6XEFUvLciy+GQYzKOOBXaIUXkB3gm4Kg8njkeJuPFgUsPovRvTy
         GUpEz5EQIUTEmd7LYdpHwH5eY0gpzQAHyl/3JrrVosBlkT5SizQd1ABau5sJ4az//7lT
         VNDGoemAdVDL+AfxmbbdJQqD5lVRTRh1+jfrHR5VwEhMBQtCQivJ+5IFzFLCmFJlZwbK
         MlGKE0uILPVeK1GZiEpsR/4HtkkGPWRt4AVQDFun3VJRKSIERXC4Q98GF8n6YlITN0Wc
         hdTA==
X-Gm-Message-State: ABuFfojKCWeYjemJDvxzKdAqajN3W320rVR8brmvqAqWT5b/LMM87/Vf
        RN7hd5F9axLqq/hBGbjbwId1WoWp/D29QTWbDu+W8g==
X-Google-Smtp-Source: ACcGV60iCLhThrzzBUtuF9GNUPiCRpucvcXy5ZPaWX/f351Dz7XjcRH/rgmEphqSR6Pkv1mmhM0yqgNzT5o+sPu0ueQ=
X-Received: by 2002:a02:943:: with SMTP id f64-v6mr9038771jad.31.1538038400916;
 Thu, 27 Sep 2018 01:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180924101150.23349-1-brgl@bgdev.pl> <20180924101150.23349-4-brgl@bgdev.pl>
 <CAGXu5j+GGbRyQDU=TKKXb9EbRSczEJYqjTaDSsmeBeQn3Qdu_g@mail.gmail.com>
In-Reply-To: <CAGXu5j+GGbRyQDU=TKKXb9EbRSczEJYqjTaDSsmeBeQn3Qdu_g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 27 Sep 2018 10:53:09 +0200
Message-ID: <CAMRc=McNoV6JA=ON71LByVn7e+mMDQW2-YrSMBOPDML2k=Z4bQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] devres: provide devm_kstrdup_const()
To:     Kees Cook <keescook@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 27 wrz 2018 o 01:20 Kees Cook <keescook@chromium.org> napisa=C5=82(a)=
:
>
> On Mon, Sep 24, 2018 at 3:11 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> > Provide a resource managed version of kstrdup_const(). This variant
> > internally calls devm_kstrdup() on pointers that are outside of
> > .rodata section and returns the string as is otherwise.
> >
> > Also provide a corresponding version of devm_kfree().
> >
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/base/devres.c  | 38 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/device.h |  3 +++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > index 438c91a43508..48185d57bc5b 100644
> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -11,6 +11,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/percpu.h>
> >
> > +#include <asm/sections.h>
> > +
> >  #include "base.h"
> >
> >  struct devres_node {
> > @@ -822,6 +824,28 @@ char *devm_kstrdup(struct device *dev, const char =
*s, gfp_t gfp)
> >  }
> >  EXPORT_SYMBOL_GPL(devm_kstrdup);
> >
> > +/**
> > + * devm_kstrdup_const - resource managed conditional string duplicatio=
n
> > + * @dev: device for which to duplicate the string
> > + * @s: the string to duplicate
> > + * @gfp: the GFP mask used in the kmalloc() call when allocating memor=
y
> > + *
> > + * Strings allocated by devm_kstrdup_const will be automatically freed=
 when
> > + * the associated device is detached.
> > + *
> > + * RETURNS:
> > + * Source string if it is in .rodata section otherwise it falls back t=
o
> > + * devm_kstrdup.
> > + */
> > +const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_=
t gfp)
> > +{
> > +       if (is_kernel_rodata((unsigned long)s))
> > +               return s;
> > +
> > +       return devm_kstrdup(dev, s, gfp);
> > +}
> > +EXPORT_SYMBOL(devm_kstrdup_const);
> > +
> >  /**
> >   * devm_kvasprintf - Allocate resource managed space and format a stri=
ng
> >   *                  into that.
> > @@ -895,6 +919,20 @@ void devm_kfree(struct device *dev, const void *p)
> >  }
> >  EXPORT_SYMBOL_GPL(devm_kfree);
> >
> > +/**
> > + * devm_kfree_const - Resource managed conditional kfree
> > + * @dev: device this memory belongs to
> > + * @p: memory to free
> > + *
> > + * Function calls devm_kfree only if @p is not in .rodata section.
> > + */
> > +void devm_kfree_const(struct device *dev, const void *p)
> > +{
> > +       if (!is_kernel_rodata((unsigned long)p))
> > +               devm_kfree(dev, p);
> > +}
> > +EXPORT_SYMBOL(devm_kfree_const);
> > +
> >  /**
> >   * devm_kmemdup - Resource-managed kmemdup
> >   * @dev: Device this memory belongs to
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 33f7cb271fbb..79ccc6eb0975 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -693,7 +693,10 @@ static inline void *devm_kcalloc(struct device *de=
v,
> >         return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
> >  }
> >  extern void devm_kfree(struct device *dev, const void *p);
> > +extern void devm_kfree_const(struct device *dev, const void *p);
>
> With devm_kfree and devm_kfree_const both taking "const", how are
> devm_kstrdup_const() and devm_kfree_const() going to be correctly
> paired at compile time? (i.e. I wasn't expecting the prototype change
> to devm_kfree())
>

I guess the same as with kfree() and kfree_const() which both take
const void * as argument - it's up to users to only use
devm_kfree_const() on resources allocated with devm_kstrdup_const().

Bart

> -Kees
>
> >  extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp=
) __malloc;
> > +extern const char *devm_kstrdup_const(struct device *dev,
> > +                                     const char *s, gfp_t gfp);
> >  extern void *devm_kmemdup(struct device *dev, const void *src, size_t =
len,
> >                           gfp_t gfp);
> >
> > --
> > 2.18.0
> >
>
>
>
> --
> Kees Cook
> Pixel Security
