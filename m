Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69175C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316472085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316472085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbeKFWgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:36:52 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35216 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbeKFWgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:36:52 -0500
Received: by mail-oi1-f196.google.com with SMTP id v198-v6so10655648oif.2;
        Tue, 06 Nov 2018 05:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YKL7kbu5LE+cm6OUkLk176Pxi1d1UQz1q1Rzu+VpeP8=;
        b=aM5ZjmNOy4BRwbNgFQbwGbn3NjOqDK2+Mh9EI6j4ipuqGHOSLxGL8z/wKRtmZSI53u
         MjC+wS0yGPhwf8FahAPmLiy5R3nKjf/gEiJEbO8B2pW01vOlEyIUL8eUhW4kjd07CENQ
         qNSbSXQ2hsgZDdMRGH9HYSTtZJPbk1HYf2WpnNIzENbPmLwCNl+JqwXJDCW6bnEQthHt
         UlsN5OFMCBsNJ9RURIBjEr/zzJopB6bVJeI8llhvn0HR2eTw1HMYDhbkHAvQT1l3GY2C
         pm/LM/bbgy+dN8M1VQsT22Co0KOG8g/gQIdFhBU4eQc64s/t2sVmrKIzUfHv7WRvUXuo
         KG1Q==
X-Gm-Message-State: AGRZ1gKwlQ0AOiSnSO/gy6Wt65+pfOxXltHH6CoIe3kIGmS5ZtBzkMwt
        LU4gT5XgE117AzNeudoU+uT/BYM=
X-Google-Smtp-Source: AJdET5d5/XNM+UEOCrVmb+WGJ5RkPleWyXjsSfRA6y/G41QTdXQMsM+aZDpL0LSJ/qf1YPg1B5Y7XQ==
X-Received: by 2002:aca:1314:: with SMTP id e20-v6mr4758576oii.36.1541509901593;
        Tue, 06 Nov 2018 05:11:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b74-v6sm12963418oih.33.2018.11.06.05.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 05:11:41 -0800 (PST)
Date:   Tue, 6 Nov 2018 07:11:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jaewon Kim <jaewon02.kim@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, jaewon02.kim@samsung.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of/platform: Support dynamic device tree on AMBA bus
Message-ID: <20181106131140.GA27291@bogus>
References: <1540485597-12240-1-git-send-email-jaewon02.kim@samsung.com>
 <CAL_Jsq+V8HmmHV98Wsq-Kec2NXgY4ih+KKEVd-1nZbCoLUPe7Q@mail.gmail.com>
 <1f7b35fd-7900-0c48-50a2-4f84481a208c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f7b35fd-7900-0c48-50a2-4f84481a208c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 01:49:05AM +0900, Jaewon Kim wrote:
> Hi Rob,
> 
> On 11/1/18 3:31 AM, Rob Herring wrote:
> > On Thu, Oct 25, 2018 at 11:40 AM Jaewon Kim <jaewon02.kim@gmail.com> wrote:
> > > This patch supports dynamic device-tree for AMBA device.
> > > The AMBA device must be registered on the AMBA bus, not the platform bus.
> > I'm not convinced we should even support this. There's a limited
> > number of AMBA devices. They would almost certainly be on-chip and
> > static. I suppose in theory you could have them in an FPGA, but
> > generally the FPGA vendors have their own IP blocks and don't use ARM
> > Primecell IP. So what is the usecase?
> 
> In my case, our target has GPIO output pin, like RPI board. And I want to
> use dt-overlay to change GPIO alternative function. But, I found that AMBA
> device not work with dt-overlay. Most AMBA devices do not require dynamic
> device-tree. But, pl022(serial) and pl011(SPI) needs dynamic device-tree.

The bootloader should apply the overlay.

> 
> > 
> > > Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> > Your author and S-o-b emails should match.
> Okay, I will change it my gmail.
> > 
> > > ---
> > >   drivers/of/platform.c | 93 ++++++++++++++++++++++++++++++++++++++++-----------
> > >   1 file changed, 73 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > index 04ad312..b9ac105 100644
> > > --- a/drivers/of/platform.c
> > > +++ b/drivers/of/platform.c
> > > @@ -286,6 +286,22 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
> > >          of_node_clear_flag(node, OF_POPULATED);
> > >          return NULL;
> > >   }
> > > +
> > > +/**
> > > + * of_find_amba_device_by_node - Find the amba_device associated with a node
> > > + * @np: Pointer to device tree node
> > > + *
> > > + * Returns amba_device pointer, or NULL if not found
> > > + */
> > > +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
> > > +{
> > > +       struct device *dev;
> > > +
> > > +       dev = bus_find_device(&amba_bustype, NULL, np, of_dev_node_match);
> > > +       return dev ? to_amba_device(dev) : NULL;
> > > +}
> > > +EXPORT_SYMBOL(of_find_amba_device_by_node);
> > I would prefer we add (or change the platform device version) an
> > of_find_device_by_node which can be extended to different bus types.
> 
> The returned type is different. of_find_device_by_node () returns 'struct
> platform_device *', and of_find_amba_device_by_node() returns 'struct
> amba_device *'. To make this the same, It need to modify return value of
> of_find_device_by_node() function or merge amba_device to
> platform_device.of_find_device_by_node() function is a widely used kernel
> source and it requires a lot of modifications.I think it would be simpler to
> make of_find_amba_device_by_node().

You don't have to make treewide changes. Define a new function returning 
struct device. Make of_find_device_by_node() a wrapper that gets the 
platform_device from the struct device.

> 
> > 
> > > +
> > >   #else /* CONFIG_ARM_AMBA */
> > >   static struct amba_device *of_amba_device_create(struct device_node *node,
> > >                                                   const char *bus_id,
> > > @@ -294,6 +310,12 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
> > >   {
> > >          return NULL;
> > >   }
> > > +
> > > +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
> > > +{
> > > +       return NULL;
> > > +}
> > > +EXPORT_SYMBOL(of_find_amba_device_by_node);
> > >   #endif /* CONFIG_ARM_AMBA */
> > > 
> > >   /**
> > > @@ -665,6 +687,7 @@ static int of_platform_notify(struct notifier_block *nb,
> > >   {
> > >          struct of_reconfig_data *rd = arg;
> > >          struct platform_device *pdev_parent, *pdev;
> > > +       struct amba_device *adev_p, *adev;
> > >          bool children_left;
> > > 
> > >          switch (of_reconfig_get_state_change(action, rd)) {
> > > @@ -677,17 +700,34 @@ static int of_platform_notify(struct notifier_block *nb,
> > >                  if (of_node_check_flag(rd->dn, OF_POPULATED))
> > >                          return NOTIFY_OK;
> > > 
> > > -               /* pdev_parent may be NULL when no bus platform device */
> > > -               pdev_parent = of_find_device_by_node(rd->dn->parent);
> > > -               pdev = of_platform_device_create(rd->dn, NULL,
> > > -                               pdev_parent ? &pdev_parent->dev : NULL);
> > > -               of_dev_put(pdev_parent);
> > > -
> > > -               if (pdev == NULL) {
> > > -                       pr_err("%s: failed to create for '%pOF'\n",
> > > -                                       __func__, rd->dn);
> > > -                       /* of_platform_device_create tosses the error code */
> > > -                       return notifier_from_errno(-EINVAL);
> > > +               if (of_device_is_compatible(rd->dn, "arm,primecell")) {
> > > +                       /* adev_p may be NULL when no bus amba device */
> > > +                       adev_p = of_find_amba_device_by_node(rd->dn->parent);
> > An amba_device can't ever have a parent that's an amba_device. The
> > parent of an amba_device is typically a platform_device for a
> > 'simple-bus'.
> 
> You are right. there is no parent device .
> I will remove it in v2.
> 
> > 
> > > +                       adev = of_amba_device_create(rd->dn, NULL, NULL,
> > > +                                       adev_p ? &adev_p->dev : NULL);
> > > +
> > > +                       if (adev_p)
> > > +                               put_device(&adev_p->dev);
> > > +
> > > +                       if (adev == NULL) {
> > > +                               pr_err("%s: failed to create for '%s'\n",
> > > +                                               __func__, rd->dn->full_name);
> > > +                               /* of_amba_device_create tosses the error */
> > > +                               return notifier_from_errno(-EINVAL);
> > > +                       }
> > > +               } else {
> > > +                       /* pdev_parent may be NULL when no bus platform device*/
> > > +                       pdev_parent = of_find_device_by_node(rd->dn->parent);
> > > +                       pdev = of_platform_device_create(rd->dn, NULL,
> > > +                                       pdev_parent ? &pdev_parent->dev : NULL);
> > > +                       of_dev_put(pdev_parent);
> > > +
> > > +                       if (pdev == NULL) {
> > > +                               pr_err("%s: failed to create for '%pOF'\n",
> > > +                                               __func__, rd->dn);
> > > +                               /* of_platform_device_create tosses the error */
> > > +                               return notifier_from_errno(-EINVAL);
> > > +                       }
> > This all pretty much duplicates what of_platform_bus_create() does and
> > we should use it here rather than have another copy. Plus what about
> > handling of any child devices (in the platform device case).
> 
> The code looks duplicated, but processed type of variable is
> different.(struct amba_device, struct platform_device)

of_platform_bus_create() works on both. Also, it handles some conditions 
not handled here.

Rob
