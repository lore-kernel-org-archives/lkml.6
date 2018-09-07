Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED2AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E20D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E20D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeIGXjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:39:03 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33797 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIGXjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:39:03 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so29201009ois.1;
        Fri, 07 Sep 2018 11:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gqvcyz8nRYGewQ+PkLiYtmTIi6Qfsv3na1btjxTw1FY=;
        b=eRBZU9itFvxvjWMFr8MhCKz7oYDdJHotnhQNooI+w7d0A0Nsw84SfYuvpsLUKvjFOS
         5hqBelYv4wxFZAk9KAnt8u7A2rnNNcrRisi8kPTDrhR48QqfDMyajCzhIH/jxi1O+/Ui
         i0Wy5oOhGn5n8bNI77ZZqxNkIAWCm1gU8EctZlBNL0R9IfPVFy+H3gVne84yxFvm6ZJo
         0FMyZqP6+mpZkcYJeSeP11FzXajAe/Pl/iq0eB0M2jnpnvMvJsDj0WH2YqTAfJ0yuhxB
         HympUf10kAa+qWrPIfsszDtFxOcrUZpz+bUOWZKlWlJSNfRi0qhYkalBKgQ1b95lEauh
         BvTA==
X-Gm-Message-State: APzg51AcURBq8jhaQJg7gmEi8H9Drdg4bnJyKaByrb7K7XRa2eANYypu
        sMO1EN6kWxbuMATeezGkWfNJhFgjJsM=
X-Google-Smtp-Source: ANB0VdZKGK54da9IWfYOEjh408sJKWX9MvIaYCbvmCIO6A9TYaBF6Glsdp9SJmSOvj88biDSjr92pw==
X-Received: by 2002:a54:4505:: with SMTP id l5-v6mr9975869oil.179.1536346606159;
        Fri, 07 Sep 2018 11:56:46 -0700 (PDT)
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id j16-v6sm18356100oib.42.2018.09.07.11.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:56:45 -0700 (PDT)
Received: by mail-oi0-f43.google.com with SMTP id l202-v6so29094922oig.7;
        Fri, 07 Sep 2018 11:56:45 -0700 (PDT)
X-Received: by 2002:a54:4d9d:: with SMTP id y29-v6mr9868762oix.273.1536346605118;
 Fri, 07 Sep 2018 11:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180831035219.31619-1-ran.wang_1@nxp.com> <20180831035219.31619-3-ran.wang_1@nxp.com>
 <be39f5ea8c9046b0bf1f6bbfe935fae4@HXTBJIDCEMVIW02.hxtcorp.net>
 <CADRPPNQN=27+pOSckxvwSuBJoFaz7pT+Z6h07Wu3Liz5ao5kkA@mail.gmail.com> <AM5PR0402MB2865E57EDC0DE8B0047282A2F1000@AM5PR0402MB2865.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR0402MB2865E57EDC0DE8B0047282A2F1000@AM5PR0402MB2865.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 7 Sep 2018 13:56:33 -0500
X-Gmail-Original-Message-ID: <CADRPPNTGrKBxzpbP05R0T3ovngYgQ4P_kgwgYwB6Aqrs8maXqw@mail.gmail.com>
Message-ID: <CADRPPNTGrKBxzpbP05R0T3ovngYgQ4P_kgwgYwB6Aqrs8maXqw@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: fsl: add RCPM driver
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        dongsheng.wang@hxt-semitech.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 4:51 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Hi Leo,
>
> On September 05, 2018 at 11:22 Yang Li wrote:
> > -----Original Message-----
> > From: Li Yang <leoyang.li@nxp.com>
> > Sent: Wednesday, September 05, 2018 11:22
> > To: dongsheng.wang@hxt-semitech.com
> > Cc: Ran Wang <ran.wang_1@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> > Mark Rutland <mark.rutland@arm.com>; open list:OPEN FIRMWARE AND
> > FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linuxppc-
> > dev <linuxppc-dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>;
> > moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> > kernel@lists.infradead.org>
> > Subject: Re: [PATCH 3/3] soc: fsl: add RCPM driver
> >
> > On Tue, Sep 4, 2018 at 9:58 PM Wang, Dongsheng <dongsheng.wang@hxt-
> > semitech.com> wrote:
> > >
> > > Please change your comments style.
> >
> > Although this doesn't get into the Linux kernel coding style documentation
> > yet, Linus seems changed his mind to prefer // than /*
> > */ comment style now.
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml
> > .org%2Flkml%2F2017%2F11%2F25%2F133&amp;data=02%7C01%7Cran.wang_
> > 1%40nxp.com%7Cc0d88e6690384e02b95108d612dec235%7C686ea1d3bc2b4c
> > 6fa92cd99c5c301635%7C0%7C0%7C636717145285126200&amp;sdata=JIoCZp
> > WhRyW76EqgSflfTDA1f0gMQGKa%2FcbvSc5CO%2Fw%3D&amp;reserved=0
> > So the
> > // style should be acceptable for now.
> >
> > >
> > > On 2018/8/31 11:56, Ran Wang wrote:
> > > > The NXP's QorIQ Processors based on ARM Core have RCPM module (Run
> > > > Control and Power Management), which performs all device-level tasks
> > > > associated with power management such as wakeup source control.
> > > >
> > > > This driver depends on FSL platform PM driver framework which help
> > > > to isolate user and PM service provider (such as RCPM driver).
> > > >
> > > > Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> > > > Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
> > > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > > ---
> > > >  drivers/soc/fsl/Kconfig   |    6 ++
> > > >  drivers/soc/fsl/Makefile  |    1 +
> > > >  drivers/soc/fsl/ls-rcpm.c |  153
> > > > +++++++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 160 insertions(+), 0 deletions(-)  create mode
> > > > 100644 drivers/soc/fsl/ls-rcpm.c
> > > >
> > > > diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index
> > > > 6517412..882330d 100644
> > > > --- a/drivers/soc/fsl/Kconfig
> > > > +++ b/drivers/soc/fsl/Kconfig
> > > > @@ -30,3 +30,9 @@ config FSL_PLAT_PM
> > > >         have to know the implement details of wakeup function it require.
> > > >         Besides, it is also easy for service side to upgrade its logic when
> > > >         design changed and remain user side unchanged.
> > > > +
> > > > +config LS_RCPM
> > > > +     bool "Freescale RCPM support"
> > > > +     depends on (FSL_PLAT_PM)
> > > > +     help
> > > > +       This feature is to enable specified wakeup source for system sleep.
> > > > diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> > > > index 8f9db23..43ff71a 100644
> > > > --- a/drivers/soc/fsl/Makefile
> > > > +++ b/drivers/soc/fsl/Makefile
> > > > @@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)            += qe/
> > > >  obj-$(CONFIG_CPM)                    += qe/
> > > >  obj-$(CONFIG_FSL_GUTS)                       += guts.o
> > > >  obj-$(CONFIG_FSL_PLAT_PM)    += plat_pm.o
> > > > +obj-$(CONFIG_LS_RCPM)                += ls-rcpm.o
> >
> > Probably use "_" instead of "-" for alignment.
>
> OK, will update in next version
>
> > > > diff --git a/drivers/soc/fsl/ls-rcpm.c b/drivers/soc/fsl/ls-rcpm.c
> > > > new file mode 100644 index 0000000..b0feb88
> > > > --- /dev/null
> > > > +++ b/drivers/soc/fsl/ls-rcpm.c
> > > > @@ -0,0 +1,153 @@
> > > > +// SPDX-License-Identifier: GPL-2.0 // // plat_pm.c - Freescale
> > > > +Layerscape RCPM driver
> >
> > The file name here is not the same as the real file name.
>
> Got it, will correct it.
>
> > > > +//
> > > > +// Copyright 2018 NXP
> > > > +//
> > > > +// Author: Ran Wang <ran.wang_1@nxp.com>,
> >
> > Where do you need the comma in the end?
>
> My bad, will remove comma in next version.
>
> > > > +
> > > > +#include <linux/init.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/of_address.h>
> > > > +#include <linux/slab.h>
> > > > +#include <soc/fsl/plat_pm.h>
> > > > +
> > > > +#define MAX_COMPATIBLE_NUM   10
> > > > +
> > > > +struct rcpm_t {
> > > > +     struct device *dev;
> > > > +     void __iomem *ippdexpcr_addr;
> > > > +     bool big_endian;        /* Big/Little endian of RCPM module */
> > > > +};
> > > > +
> > > > +// rcpm_handle - Configure RCPM reg according to wake up source
> > > > +request // @user_dev: pointer to user's device struct // @flag: to
> > > > +enable(true) or disable(false) wakeup source // @handle_priv:
> > > > +pointer to struct rcpm_t instance // // Return 0 on success other
> > > > +negative errno
> >
> > Although Linus preferred this // comment style.  I'm not sure if this will be
> > handled correctly by the kernel-doc compiler.
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fww
> > w.kernel.org%2Fdoc%2Fhtml%2Fv4.18%2Fdoc-guide%2Fkernel-
> > doc.html&amp;data=02%7C01%7Cran.wang_1%40nxp.com%7Cc0d88e669038
> > 4e02b95108d612dec235%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > %7C636717145285126200&amp;sdata=H7GkUNOLVG%2FCcZESzhtHBeHCbO9
> > %2FK4k9EdH30Cxq2%2BM%3D&amp;reserved=0
>
> So, do you think I need to change all comment style back to '/* ... */' ?
> Actually I feel a little bit confused here.

I think Linus's comment about // comment style applies to normal code
comment.  But kernel-doc comment is a special kind of code comment
that needs to meet certain requirements.  People can use the
scripts/kernel-doc tool to generate readable API documents from the
source code.  It looks like you wanted to make the function
description aligned with the kernel-doc format, but kernel-doc
specifically requires to use the /* */ style(at least for now).

Regards,
Leo
