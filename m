Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-865074-1527119588-2-6685826155288867083
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527119588; b=dSuRR9bsC3vKHbkmg8XROs3IPnLxAyp1BcPhR2QCtMRtHJ5P9M
    hgnDymmKWp8dH9u4tTlpWIFX1qWUm2IUUscIiPKYg+Ryal0RTnrqM7sI2mp+FgOb
    PVuYHQwpy7IdzlKauyRQUMbMqqhOeen9ia4PKvCSTp62zpTv5sy/o6ak3kgbtHYG
    pnnetakLkpq6CT2jBVbzSrbDDJPiTIVwBOm98fUh8z1ZgNcWmqwEZHR9iNHuOD+V
    qEsI6tmoflShOp1oU7o0nvMgjJFJHcZX4OOo8sDR6yDc5DYAdFx++OyiMD87mhd2
    P/pT62hMbYwTSFEXdZJHVdZv4c5VBsX0gTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527119588; bh=1oMrsOBy4ViYOtiDf5BIQ2iDOJ3mL1
    6zp8/jE1T8kfE=; b=TD0yHsClqNBQWlgj+9hv/1NP47TKMLw8lQRarl60aR5exu
    8t6VGCLi4aYWqH5SaZNtTWES2zqs6aflV1fGK9ECnaLkWLEl5iCssovnWUqMeD5h
    5vnL4shyKlLWmK75TwZJy3cn63v9wc5arbt8rXIKaSAfXfpEOsri0fJGMq/niqn0
    C3C3T9yq8JJrJCvkgXavtyauz3E5KP4P8N90riAYoWJaduFqbx46PbuTnn1wAygO
    RiYUGkj+mh8/SObgVpIteJUl6eTfxjUM8+K+jndGxmuNSjJzodnpCpbPn+Of1xRS
    af04YJnV+8GiP3ZgCf1qQ3d6bjR/n/mEuuVb7DXg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK4Fh0+CnmijvpRsXpSupYmGm2PGdDGncRZekSrbS9gYWADYp5wOuCMrO1v2kLePcrSC9zdguOn9N895gbgLP/OI73sERsGQEkF3SMeBuISstDTK03f0
    0WJS+X0QfZslBo5ZMVRryVBW1p6nSExhMyrQ1MmYkmgyTnTjlFj0vWVxhJVrP83pDYgu5EQ+x7vnK6dZNZhpxuS8tKDigfbQG+0mTQU4RE1IHY10LEh/AOy+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=D19gQVrFAAAA:8 a=FynaKCd_aHLcxK59H4sA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935015AbeEWXxF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 19:53:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:59494 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934770AbeEWXxE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 23 May 2018 19:53:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,435,1520924400";
   d="scan'208";a="43432286"
Date: Thu, 24 May 2018 07:42:13 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: Re: [PATCH v5 20/28] fpga: dfl: add fpga bridge platform driver for
 FME
Message-ID: <20180523234213.GA24455@hao-dev>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
 <1525229431-3087-21-git-send-email-hao.wu@intel.com>
 <CANk1AXS3M=GyTtdk=YYMadD22VqDPbB_XRYrnoue6nXrNQqqkQ@mail.gmail.com>
 <20180523152841.GA23834@hao-dev>
 <CANk1AXR-0=O2Ypyxn+wnyPmfdqG7Rmk_oK9et0YLkAkNHzbqLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXR-0=O2Ypyxn+wnyPmfdqG7Rmk_oK9et0YLkAkNHzbqLw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 04:06:17PM -0500, Alan Tull wrote:
> On Wed, May 23, 2018 at 10:28 AM, Wu Hao <hao.wu@intel.com> wrote:
> > On Wed, May 23, 2018 at 10:15:00AM -0500, Alan Tull wrote:
> >> On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:
> >>
> >> Hi Hao,
> >>
> >> > This patch adds fpga bridge platform driver for FPGA Management Engine.
> >> > It implements the enable_set callback for fpga bridge.
> >> >
> >> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> >> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> >> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> >> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> >> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> >> > Acked-by: Alan Tull <atull@kernel.org>
> >> > Acked-by: Moritz Fischer <mdf@kernel.org>
> >> > ---
> >> > v3: rename driver to fpga-dfl-fme-br
> >> >     remove useless dev_dbg in probe function.
> >> >     rebased due to fpga api change.
> >> > v4: rename to dfl-fme-br and fix SPDX license issue
> >> >     include dfl-fme-pr.h instead of dfl-fme.h
> >> >     add Acked-by from Alan and Moritz
> >> > v5: rebase due to API changes.
> >> >     defer port and its ops finding when really need.
> >> > ---
> >> >  drivers/fpga/Kconfig      |   6 +++
> >> >  drivers/fpga/Makefile     |   1 +
> >> >  drivers/fpga/dfl-fme-br.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++
> >> >  3 files changed, 121 insertions(+)
> >> >  create mode 100644 drivers/fpga/dfl-fme-br.c
> >> >
> >> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> >> > index 89f76e8..a8f939a 100644
> >> > --- a/drivers/fpga/Kconfig
> >> > +++ b/drivers/fpga/Kconfig
> >> > @@ -156,6 +156,12 @@ config FPGA_DFL_FME_MGR
> >> >         help
> >> >           Say Y to enable FPGA Manager driver for FPGA Management Engine.
> >> >
> >> > +config FPGA_DFL_FME_BRIDGE
> >> > +       tristate "FPGA DFL FME Bridge Driver"
> >> > +       depends on FPGA_DFL_FME
> >> > +       help
> >> > +         Say Y to enable FPGA Bridge driver for FPGA Management Engine.
> >> > +
> >> >  config FPGA_DFL_PCI
> >> >         tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
> >> >         depends on PCI && FPGA_DFL
> >> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> >> > index f82814a..75096e9 100644
> >> > --- a/drivers/fpga/Makefile
> >> > +++ b/drivers/fpga/Makefile
> >> > @@ -32,6 +32,7 @@ obj-$(CONFIG_OF_FPGA_REGION)          += of-fpga-region.o
> >> >  obj-$(CONFIG_FPGA_DFL)                 += dfl.o
> >> >  obj-$(CONFIG_FPGA_DFL_FME)             += dfl-fme.o
> >> >  obj-$(CONFIG_FPGA_DFL_FME_MGR)         += dfl-fme-mgr.o
> >> > +obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)      += dfl-fme-br.o
> >> >
> >> >  dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
> >> >
> >> > diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
> >> > new file mode 100644
> >> > index 0000000..5c51b08
> >> > --- /dev/null
> >> > +++ b/drivers/fpga/dfl-fme-br.c
> >> > @@ -0,0 +1,114 @@
> >> > +// SPDX-License-Identifier: GPL-2.0
> >> > +/*
> >> > + * FPGA Bridge Driver for FPGA Management Engine (FME)
> >> > + *
> >> > + * Copyright (C) 2017 Intel Corporation, Inc.
> >> > + *
> >> > + * Authors:
> >> > + *   Wu Hao <hao.wu@intel.com>
> >> > + *   Joseph Grecco <joe.grecco@intel.com>
> >> > + *   Enno Luebbers <enno.luebbers@intel.com>
> >> > + *   Tim Whisonant <tim.whisonant@intel.com>
> >> > + *   Ananda Ravuri <ananda.ravuri@intel.com>
> >> > + *   Henry Mitchel <henry.mitchel@intel.com>
> >> > + */
> >> > +
> >> > +#include <linux/module.h>
> >> > +#include <linux/fpga/fpga-bridge.h>
> >> > +
> >> > +#include "dfl.h"
> >> > +#include "dfl-fme-pr.h"
> >> > +
> >> > +struct fme_br_priv {
> >> > +       struct dfl_fme_br_pdata *pdata;
> >> > +       struct dfl_fpga_port_ops *port_ops;
> >> > +       struct platform_device *port_pdev;
> >> > +};
> >> > +
> >> > +static int fme_bridge_enable_set(struct fpga_bridge *bridge, bool enable)
> >> > +{
> >> > +       struct fme_br_priv *priv = bridge->priv;
> >> > +       struct platform_device *port_pdev;
> >> > +       struct dfl_fpga_port_ops *ops;
> >> > +
> >> > +       if (!priv->port_pdev) {
> >> > +               port_pdev = dfl_fpga_cdev_find_port(priv->pdata->cdev,
> >> > +                                                   &priv->pdata->port_id,
> >> > +                                                   dfl_fpga_check_port_id);
> >> > +               if (!port_pdev)
> >> > +                       return -ENODEV;
> >> > +
> >> > +               priv->port_pdev = port_pdev;
> >> > +       }
> >> > +
> >> > +       if (priv->port_pdev && !priv->port_ops) {
> >> > +               ops = dfl_fpga_get_port_ops(priv->port_pdev);
> >> > +               if (!ops || !ops->enable_set)
> >> > +                       return -ENOENT;
> >> > +
> >> > +               priv->port_ops = ops;
> >> > +       }
> >>
> >> This is saving some pointers.  Is it possible that the port_pdev or
> >> port_ops could go away?
> >
> > Hi Alan
> >
> > Thanks for the comments.
> >
> > The find_port function will get the port device to prevent that.
> > You can see put device in remove function. And it's similar for the
> > port ops. In dfl_fpga_get_port_ops function, it will prevent unexpected
> > port ops removing by try module get.
> 
> OK, good, and I see the find_port function documents that put_device
> is needed, so that's good too.
> 
> When we previously discussed this [1] you described a procedure of
> hot-unplugging the VF AFU from the VM and turning it back to PF before
> doing the FPGA programming.   Some comments on that would be helpful,
> maybe located with the port_ops functions.
> 

Hi Alan

Actually I plan to add those descriptions about virtualization in the
documenation/fpga/dfl.txt, together with the patch which enables the
virtualization support for Intel FPGA device (e.g Intel PAC card). I
think dfl.txt is a better place to have that procedure documented.
How do you think?


> [1] https://lkml.org/lkml/2018/4/6/180
> 
> >
> >>
> >> Also, the port ops routines probably should be named
> >> dfl_fpga_port_ops_get/find_port/etc
> >>
> >
> > Hm.. as I see there are functions named as get_device(), put_device(), so
> > I just name it as ..._get_port_ops and ..._put_port_ops in similar way. :)
> > If you think that could be a better name, it's fine for me to change them.
> 
> Yes, I've seen that too.  I think keeping the prefix the same helps to
> organize the namespace.  Plus :) if I'm grepping through the code, I
> can be lazy and not have to use a regex to find the port ops
> functions.

so we good with current naming?

some places we find it's get_device() and put_device(), but other functions
like device_add(), device_del(). actually it's not a big problem I think, :)
currently port_ops has a unified style ..._add/del/get/put_port_ops. I am
fine with both kind of naming, if you prefer ...port_ops_add/del/get/put
style, please let me know, I can change them in the next version.

Thanks
Hao

> 
> Alan
> 
> >
> > Thanks
> > Hao
> >
> >> Alan
> >>
> >> > +
> >> > +       return priv->port_ops->enable_set(priv->port_pdev, enable);
> >> > +}
> >> > +
> >> > +static const struct fpga_bridge_ops fme_bridge_ops = {
> >> > +       .enable_set = fme_bridge_enable_set,
> >> > +};
> >> > +
> >> > +static int fme_br_probe(struct platform_device *pdev)
> >> > +{
> >> > +       struct device *dev = &pdev->dev;
> >> > +       struct fme_br_priv *priv;
> >> > +       struct fpga_bridge *br;
> >> > +       int ret;
> >> > +
> >> > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >> > +       if (!priv)
> >> > +               return -ENOMEM;
> >> > +
> >> > +       priv->pdata = dev_get_platdata(dev);
> >> > +
> >> > +       br = fpga_bridge_create(dev, "DFL FPGA FME Bridge",
> >> > +                               &fme_bridge_ops, priv);
> >> > +       if (!br)
> >> > +               return -ENOMEM;
> >> > +
> >> > +       platform_set_drvdata(pdev, br);
> >> > +
> >> > +       ret = fpga_bridge_register(br);
> >> > +       if (ret)
> >> > +               fpga_bridge_free(br);
> >> > +
> >> > +       return ret;
> >> > +}
> >> > +
> >> > +static int fme_br_remove(struct platform_device *pdev)
> >> > +{
> >> > +       struct fpga_bridge *br = platform_get_drvdata(pdev);
> >> > +       struct fme_br_priv *priv = br->priv;
> >> > +
> >> > +       fpga_bridge_unregister(br);
> >> > +
> >> > +       if (priv->port_pdev)
> >> > +               put_device(&priv->port_pdev->dev);
> >> > +       if (priv->port_ops)
> >> > +               dfl_fpga_put_port_ops(priv->port_ops);
> >> > +
> >> > +       return 0;
> >> > +}
> >> > +
> >> > +static struct platform_driver fme_br_driver = {
> >> > +       .driver = {
> >> > +               .name    = DFL_FPGA_FME_BRIDGE,
> >> > +       },
> >> > +       .probe   = fme_br_probe,
> >> > +       .remove  = fme_br_remove,
> >> > +};
> >> > +
> >> > +module_platform_driver(fme_br_driver);
> >> > +
> >> > +MODULE_DESCRIPTION("FPGA Bridge for DFL FPGA Management Engine");
> >> > +MODULE_AUTHOR("Intel Corporation");
> >> > +MODULE_LICENSE("GPL v2");
> >> > +MODULE_ALIAS("platform:dfl-fme-bridge");
> >> > --
> >> > 1.8.3.1
> >> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
