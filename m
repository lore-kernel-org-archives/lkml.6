Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2428ECDFAC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5272064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoPk65AM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5272064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeJJBGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:06:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37567 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbeJJBGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:06:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id 63-v6so2389217ljs.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXsu0e0GXs1+CpNuUGNKCWpfdjFPFPc+07jPUsU76qo=;
        b=MoPk65AMOoU+2d9M9Qne8wN/Aoq6SVJ45fIcBAqGgMCV9s1mBdM9YgdtFzvCUcv/LB
         YPAlT/CGiLWL53Cnfl0Oz1UQxGdlOaxuizN0FQKG///SY5jF2kfFIJFnQFk3VSHGOmoS
         0bI6Kvi+f/NuF9nb7MpUVZSgl3D8Jfhjm7vIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXsu0e0GXs1+CpNuUGNKCWpfdjFPFPc+07jPUsU76qo=;
        b=O2tb3wO9/Sk8qcj1aI3gp8++U0kt2t/tEGHdnHjIIU/XtxgUlAfoGBRXSlB1zxMy6l
         E8Zf5GbqHXXMCjOfCuwuDP6iEnKmmb641HY5mGjEZXgx1SXuEK+t3+7/eRB3hfygVMPe
         VEcApjBFFiUunXBfvlFGOtGESqXF8LvL+JBtYnxf3iSKrENK4MqQhXbn1IVzS5sh7yeW
         c/zNE6lJYnEYbrE55Fl8nEOoMY9RcSNZCTLmTGZdSK2iB2w2wnPoIJnOSwwhgzL3ppe7
         1UUfSpmINvEMNYhsU7Losm3FkOpJI3HcwG3XxYT84A4puqMV2P2LeU8k8taXAqAArEHP
         hZPA==
X-Gm-Message-State: ABuFfoi51yr+swIgyAyaFbXXfZtqKf/ft8BnY7sYKBESY6933zXBy2+/
        SMSgXhG0ChVlD5n3C4iPtBXh6r+haOnBcAw94hOfEQ==
X-Google-Smtp-Source: ACcGV631B/pngTrMqFN9sZppiq7tizL07GMVxYMXtT6MJsMgxapaPZ9lNoPwDTzRnYWAP2V+P9STCYG9H5W4noIhM2M=
X-Received: by 2002:a2e:7017:: with SMTP id l23-v6mr18247341ljc.160.1539107310228;
 Tue, 09 Oct 2018 10:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
 <20181009172726.GA2182@xps15> <CAJZ5v0gckkg0jyTc7=JYPpUruQQXL_FhEjm03-0mrFcxH60cHA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gckkg0jyTc7=JYPpUruQQXL_FhEjm03-0mrFcxH60cHA@mail.gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 9 Oct 2018 11:48:19 -0600
Message-ID: <CANLsYkxcUvBBFRFD9Vco559Y5LFw=X0H3Lyzm=nFat6z5yH44g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Silesh C V <svellattu@mvista.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 at 11:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 9, 2018 at 7:27 PM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > Hi Silesh,
> >
> > On Tue, Oct 09, 2018 at 03:47:24PM +0530, Silesh C V wrote:
> > > Some drivers need to find the device on a bus having a specific firmware
> > > node. Currently, such drivers have their own implementations to do this.
> > > Provide a helper similar to bus_find_device_by_name so that each driver
> > > does not have to reinvent this.
> > >
> > > Signed-off-by: Silesh C V <svellattu@mvista.com>
> > > ---
> > > Changes since v2:
> > >       - make use of dev_fwnode in match_fwnode.
> > >
> > >  drivers/base/bus.c     | 20 ++++++++++++++++++++
> > >  include/linux/device.h |  3 +++
> > >  2 files changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> > > index 8bfd27e..a2f39db 100644
> > > --- a/drivers/base/bus.c
> > > +++ b/drivers/base/bus.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/string.h>
> > >  #include <linux/mutex.h>
> > >  #include <linux/sysfs.h>
> > > +#include <linux/property.h>
> > >  #include "base.h"
> > >  #include "power/power.h"
> > >
> > > @@ -373,6 +374,25 @@ struct device *bus_find_device_by_name(struct bus_type *bus,
> > >  }
> > >  EXPORT_SYMBOL_GPL(bus_find_device_by_name);
> > >
> > > +static int match_fwnode(struct device *dev, void *fwnode)
> > > +{
> > > +     return dev_fwnode(dev) == fwnode;
> > > +}
> > > +
> > > +/**
> > > + * bus_find_device_by_fwnode - device iterator for locating a particular device
> > > + * having a specific firmware node
> > > + * @bus: bus type
> > > + * @start: Device to begin with
> > > + * @fwnode: firmware node of the device to match
> > > + */
> > > +struct device *bus_find_device_by_fwnode(struct bus_type *bus, struct device *start,
> > > +                                     struct fwnode_handle *fwnode)
> >
> > I get the following when running checkpatch on your set:
> >
> > mpoirier@xps15:~/work/linaro/coresight/kernel-maint$ ./scripts/checkpatch.pl
> > 0001-Driver-core-add-bus_find_device_by_fwnode.patch
> > WARNING: line over 80 characters
>
> Lines longer than 80 chars often are legitimate.  No need to send
> extra reports about those cases in general.

In this case I don't see a reason not to abide to the guideline.
Wrapping the function declaration to 80 characters would be easy
without effecting code readability.

Mathieu

>
> Thanks,
> Rafael
