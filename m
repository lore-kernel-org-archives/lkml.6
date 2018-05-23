Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-684374-1527109625-2-16208616978835766810
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527109624; b=L3F7HTJY9YbngvBbEW1beB2nULL84JqBAgzRIP8mBdCl2pGwg1
    Ur5W+kebJq3LB4jCZXtHHuLIM6vxuHhLOtnjii3uFFIapisO47vRSOBLx8irdQmD
    zczorudyhAFjoL2ozj1ODWJ1x5FZi5G6Trueff/WJUUL7xXneyn2nmr3ngZ06f0J
    r4hKsKtTNsV7oW33RQ2fBR6Ibn5L9ZsYn3F2PzQS9m9gOafLqlSQUnkjNCeXoBun
    efNquIk7tHY5IuDvXAmx1hxXgh0Jk5b3ghb7jGztOFyL5WftjrFnK3Id4ouI4wn4
    DJEm+kvUXPxohiVgmfH1ZYDEnrtmPd4KzIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527109624; bh=y1yC3gu24oufQT/MUKCRCeNDq7NhygpU+Mnrlkh0es
    Q=; b=Nwg4x9fAwYL/tcuT9Fm7VgM7p4caEjSjeTIZz8+XJzdXokcjryA82F2dCo
    kYpd/aUoNjaGWB3YnjySZmYLRUdtObL4lEJMb2uS4QraCXtKqktUybjE4QH5pXKE
    LRoZ67um5xksITq1OwKh7utTHQMf272wTehEqbAV1W31teXeV5Q4e30qxcIncZD2
    GH589nUfbEChntdZVYIdduJOh6zlvcr85Zccpdpq+Zf8nNYZ59RFKNHYPfqRaQdq
    L4MANvIcNhEhl++0nVYxaJEwWXjRJHlw7davYpnz5+CSX7wRRKjdPqMX3zhVpwL3
    W9n5E6kX88W3n8hhaKGRKp5R83eg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=mji0Egv6 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=mji0Egv6 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAppOYwtnqNQ+erbNJbpKwUrDr0ec3ZAXKEZeycW9BCP8dALlRiuMj0w+GWrYBox4Xw/GLhNVUdovmNBrbBcFcPCPGtQ3YZ66kF6WgJ/xMhPpBGxxHWc
    c+C8Dx/4ry6Phy+rfrsQ+XnqZS9hCsNEPMJdVaSra+a7yMl+nYOC4Ir9QxYicZCrMLH420umK+vyRrRNzfSDJk/5rbYtzS8tTh2FmhYMkf1otwr5t7KwbJdN
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=D19gQVrFAAAA:8 a=U3s5aVsZ5ESar4x0GH4A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934402AbeEWVHB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 17:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934230AbeEWVG7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 23 May 2018 17:06:59 -0400
X-Google-Smtp-Source: AB8JxZp7LngH7LZpA1ipoza7/eHd+MRN5eqqmWfmcVIOW9b9uX7HXp66dBfXj3myAXtsrCMj++nGfgAmYmBiX+A41xk=
MIME-Version: 1.0
In-Reply-To: <20180523152841.GA23834@hao-dev>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
 <1525229431-3087-21-git-send-email-hao.wu@intel.com> <CANk1AXS3M=GyTtdk=YYMadD22VqDPbB_XRYrnoue6nXrNQqqkQ@mail.gmail.com>
 <20180523152841.GA23834@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Wed, 23 May 2018 16:06:17 -0500
X-Gmail-Original-Message-ID: <CANk1AXR-0=O2Ypyxn+wnyPmfdqG7Rmk_oK9et0YLkAkNHzbqLw@mail.gmail.com>
Message-ID: <CANk1AXR-0=O2Ypyxn+wnyPmfdqG7Rmk_oK9et0YLkAkNHzbqLw@mail.gmail.com>
Subject: Re: [PATCH v5 20/28] fpga: dfl: add fpga bridge platform driver for FME
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 10:28 AM, Wu Hao <hao.wu@intel.com> wrote:
> On Wed, May 23, 2018 at 10:15:00AM -0500, Alan Tull wrote:
>> On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:
>>
>> Hi Hao,
>>
>> > This patch adds fpga bridge platform driver for FPGA Management Engine.
>> > It implements the enable_set callback for fpga bridge.
>> >
>> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
>> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
>> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
>> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
>> > Signed-off-by: Wu Hao <hao.wu@intel.com>
>> > Acked-by: Alan Tull <atull@kernel.org>
>> > Acked-by: Moritz Fischer <mdf@kernel.org>
>> > ---
>> > v3: rename driver to fpga-dfl-fme-br
>> >     remove useless dev_dbg in probe function.
>> >     rebased due to fpga api change.
>> > v4: rename to dfl-fme-br and fix SPDX license issue
>> >     include dfl-fme-pr.h instead of dfl-fme.h
>> >     add Acked-by from Alan and Moritz
>> > v5: rebase due to API changes.
>> >     defer port and its ops finding when really need.
>> > ---
>> >  drivers/fpga/Kconfig      |   6 +++
>> >  drivers/fpga/Makefile     |   1 +
>> >  drivers/fpga/dfl-fme-br.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 121 insertions(+)
>> >  create mode 100644 drivers/fpga/dfl-fme-br.c
>> >
>> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> > index 89f76e8..a8f939a 100644
>> > --- a/drivers/fpga/Kconfig
>> > +++ b/drivers/fpga/Kconfig
>> > @@ -156,6 +156,12 @@ config FPGA_DFL_FME_MGR
>> >         help
>> >           Say Y to enable FPGA Manager driver for FPGA Management Engine.
>> >
>> > +config FPGA_DFL_FME_BRIDGE
>> > +       tristate "FPGA DFL FME Bridge Driver"
>> > +       depends on FPGA_DFL_FME
>> > +       help
>> > +         Say Y to enable FPGA Bridge driver for FPGA Management Engine.
>> > +
>> >  config FPGA_DFL_PCI
>> >         tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
>> >         depends on PCI && FPGA_DFL
>> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> > index f82814a..75096e9 100644
>> > --- a/drivers/fpga/Makefile
>> > +++ b/drivers/fpga/Makefile
>> > @@ -32,6 +32,7 @@ obj-$(CONFIG_OF_FPGA_REGION)          += of-fpga-region.o
>> >  obj-$(CONFIG_FPGA_DFL)                 += dfl.o
>> >  obj-$(CONFIG_FPGA_DFL_FME)             += dfl-fme.o
>> >  obj-$(CONFIG_FPGA_DFL_FME_MGR)         += dfl-fme-mgr.o
>> > +obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)      += dfl-fme-br.o
>> >
>> >  dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
>> >
>> > diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
>> > new file mode 100644
>> > index 0000000..5c51b08
>> > --- /dev/null
>> > +++ b/drivers/fpga/dfl-fme-br.c
>> > @@ -0,0 +1,114 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/*
>> > + * FPGA Bridge Driver for FPGA Management Engine (FME)
>> > + *
>> > + * Copyright (C) 2017 Intel Corporation, Inc.
>> > + *
>> > + * Authors:
>> > + *   Wu Hao <hao.wu@intel.com>
>> > + *   Joseph Grecco <joe.grecco@intel.com>
>> > + *   Enno Luebbers <enno.luebbers@intel.com>
>> > + *   Tim Whisonant <tim.whisonant@intel.com>
>> > + *   Ananda Ravuri <ananda.ravuri@intel.com>
>> > + *   Henry Mitchel <henry.mitchel@intel.com>
>> > + */
>> > +
>> > +#include <linux/module.h>
>> > +#include <linux/fpga/fpga-bridge.h>
>> > +
>> > +#include "dfl.h"
>> > +#include "dfl-fme-pr.h"
>> > +
>> > +struct fme_br_priv {
>> > +       struct dfl_fme_br_pdata *pdata;
>> > +       struct dfl_fpga_port_ops *port_ops;
>> > +       struct platform_device *port_pdev;
>> > +};
>> > +
>> > +static int fme_bridge_enable_set(struct fpga_bridge *bridge, bool enable)
>> > +{
>> > +       struct fme_br_priv *priv = bridge->priv;
>> > +       struct platform_device *port_pdev;
>> > +       struct dfl_fpga_port_ops *ops;
>> > +
>> > +       if (!priv->port_pdev) {
>> > +               port_pdev = dfl_fpga_cdev_find_port(priv->pdata->cdev,
>> > +                                                   &priv->pdata->port_id,
>> > +                                                   dfl_fpga_check_port_id);
>> > +               if (!port_pdev)
>> > +                       return -ENODEV;
>> > +
>> > +               priv->port_pdev = port_pdev;
>> > +       }
>> > +
>> > +       if (priv->port_pdev && !priv->port_ops) {
>> > +               ops = dfl_fpga_get_port_ops(priv->port_pdev);
>> > +               if (!ops || !ops->enable_set)
>> > +                       return -ENOENT;
>> > +
>> > +               priv->port_ops = ops;
>> > +       }
>>
>> This is saving some pointers.  Is it possible that the port_pdev or
>> port_ops could go away?
>
> Hi Alan
>
> Thanks for the comments.
>
> The find_port function will get the port device to prevent that.
> You can see put device in remove function. And it's similar for the
> port ops. In dfl_fpga_get_port_ops function, it will prevent unexpected
> port ops removing by try module get.

OK, good, and I see the find_port function documents that put_device
is needed, so that's good too.

When we previously discussed this [1] you described a procedure of
hot-unplugging the VF AFU from the VM and turning it back to PF before
doing the FPGA programming.   Some comments on that would be helpful,
maybe located with the port_ops functions.

[1] https://lkml.org/lkml/2018/4/6/180

>
>>
>> Also, the port ops routines probably should be named
>> dfl_fpga_port_ops_get/find_port/etc
>>
>
> Hm.. as I see there are functions named as get_device(), put_device(), so
> I just name it as ..._get_port_ops and ..._put_port_ops in similar way. :)
> If you think that could be a better name, it's fine for me to change them.

Yes, I've seen that too.  I think keeping the prefix the same helps to
organize the namespace.  Plus :) if I'm grepping through the code, I
can be lazy and not have to use a regex to find the port ops
functions.

Alan

>
> Thanks
> Hao
>
>> Alan
>>
>> > +
>> > +       return priv->port_ops->enable_set(priv->port_pdev, enable);
>> > +}
>> > +
>> > +static const struct fpga_bridge_ops fme_bridge_ops = {
>> > +       .enable_set = fme_bridge_enable_set,
>> > +};
>> > +
>> > +static int fme_br_probe(struct platform_device *pdev)
>> > +{
>> > +       struct device *dev = &pdev->dev;
>> > +       struct fme_br_priv *priv;
>> > +       struct fpga_bridge *br;
>> > +       int ret;
>> > +
>> > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> > +       if (!priv)
>> > +               return -ENOMEM;
>> > +
>> > +       priv->pdata = dev_get_platdata(dev);
>> > +
>> > +       br = fpga_bridge_create(dev, "DFL FPGA FME Bridge",
>> > +                               &fme_bridge_ops, priv);
>> > +       if (!br)
>> > +               return -ENOMEM;
>> > +
>> > +       platform_set_drvdata(pdev, br);
>> > +
>> > +       ret = fpga_bridge_register(br);
>> > +       if (ret)
>> > +               fpga_bridge_free(br);
>> > +
>> > +       return ret;
>> > +}
>> > +
>> > +static int fme_br_remove(struct platform_device *pdev)
>> > +{
>> > +       struct fpga_bridge *br = platform_get_drvdata(pdev);
>> > +       struct fme_br_priv *priv = br->priv;
>> > +
>> > +       fpga_bridge_unregister(br);
>> > +
>> > +       if (priv->port_pdev)
>> > +               put_device(&priv->port_pdev->dev);
>> > +       if (priv->port_ops)
>> > +               dfl_fpga_put_port_ops(priv->port_ops);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static struct platform_driver fme_br_driver = {
>> > +       .driver = {
>> > +               .name    = DFL_FPGA_FME_BRIDGE,
>> > +       },
>> > +       .probe   = fme_br_probe,
>> > +       .remove  = fme_br_remove,
>> > +};
>> > +
>> > +module_platform_driver(fme_br_driver);
>> > +
>> > +MODULE_DESCRIPTION("FPGA Bridge for DFL FPGA Management Engine");
>> > +MODULE_AUTHOR("Intel Corporation");
>> > +MODULE_LICENSE("GPL v2");
>> > +MODULE_ALIAS("platform:dfl-fme-bridge");
>> > --
>> > 1.8.3.1
>> >
