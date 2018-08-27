Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB01C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13267208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SejB4gwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13267208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeH0Qv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:51:28 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41530 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeH0Qv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:51:28 -0400
Received: by mail-qk0-f195.google.com with SMTP id h138-v6so10370715qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KFh+SNy5OQ9piD2w7/Sn30dnwpxD1czFrXEAImEM2E=;
        b=SejB4gwZ8BQmJW3AdfaI8xvvdaaNnurNU8TvbgX+ipcXK/AKAqBIIu21v3lA9u/TLY
         5TH8MLaP8QSIm/0v6A5eHfTIYi5zcWOUIcWpy+r5P/Xy7zhBSrepiHiiWe5TGPsw8dNZ
         ZhqW8Yjfu4jJci2MqWqehSVBEIQ04lg/ITiXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KFh+SNy5OQ9piD2w7/Sn30dnwpxD1czFrXEAImEM2E=;
        b=bxI5uaBnJa8cRXHZz+lqTrSzYQOpk+D0N8CK4e9j092oNVZFHPhVr2oqKMWds4iEuF
         rtFv52GtXcAZ0G7DPV7qyXLHZc8c8za4AYtvGxlyoC3akAk+hOFgdjUmn5iktJPE98Pn
         PJfoRtg3cpM6q3y3H4Qy57u8j6ZTJobOz+hC1byNE5FPkoLF/d6rDhW4NoNhtFxYBuNw
         OHK6uxN7zX5P3cY7CFjz7iMHDSsssrDqaHGEzS5seLtFst5iv+xF124ddLcA4LKUwuS7
         6Ly1WEgqbJTU4aZ5aP+mHAlwGrch2itd4U2+o3WwqUvCP6norpRBiBoSYgSx9d6F1jjT
         5MdA==
X-Gm-Message-State: APzg51DFzTYJXcUITaZqWsuPspqlZ1nGE/oJbImfIIy1BnIZ7mo/EFoL
        K+sa5l+kZLPEcPLta/qrAOtlbnNzdfZ+xVKgflLilw==
X-Google-Smtp-Source: ANB0VdbP8MmAmztR54WAn+kMVMw0Po1rYz43+q+7qy3oz4rflw+EOd1Jlwea4p+sAJLQbjG0rkj+vCIBYiXsFQsLDqg=
X-Received: by 2002:a37:d74b:: with SMTP id m72-v6mr13126923qki.296.1535375091952;
 Mon, 27 Aug 2018 06:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <985ed415774fdac9ac21afad4b4b74f30f6c5068.1533815718.git.amit.kucheria@linaro.org>
 <20180824233039.GF25163@localhost.localdomain>
In-Reply-To: <20180824233039.GF25163@localhost.localdomain>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 27 Aug 2018 18:34:40 +0530
Message-ID: <CAP245DV282a-WW6KfaZM8JuSUgWTJtUQJOULXHviR4_cKTen8A@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] thermal: tsens: Check if the IP is correctly
 enabled by firmware
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 5:00 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Thu, Aug 09, 2018 at 06:02:39PM +0530, Amit Kucheria wrote:
> > The SROT registers are initialised by the secure firmware at boot. We
> > don't have write access to the registers. Check if the block is enabled
> > before continuing.
> >
>
> Should this be merged to patch 6?

I've kept it separate because this 'enable' check could've been added
to the old code as well, without the separate SROT mapping in patch 6.
So in my mind, they're two different things: splitting the address map
and adding the 'enable' check and I'd prefer to keep it as it is.

> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 0b8a793f15f4..d250b757d1f0 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -12,6 +12,11 @@
> >  #include <linux/regmap.h>
> >  #include "tsens.h"
> >
> > +/* SROT */
> > +#define CTRL_OFFSET          0x4
> > +#define TSENS_EN             BIT(0)
> > +
> > +/* TM */
> >  #define STATUS_OFFSET                0x30
> >  #define SN_ADDR_OFFSET               0x4
> >  #define SN_ST_TEMP_MASK              0x3ff
> > @@ -119,6 +124,8 @@ int __init init_common(struct tsens_device *tmdev)
> >  {
> >       void __iomem *tm_base, *srot_base;
> >       struct resource *res;
> > +     u32 code;
> > +     int ret;
> >       struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
> >
> >       if (!op)
> > @@ -151,5 +158,15 @@ int __init init_common(struct tsens_device *tmdev)
> >       if (IS_ERR(tmdev->tm_map))
> >               return PTR_ERR(tmdev->tm_map);
> >
> > +     if (tmdev->srot_map) {
> > +             ret = regmap_read(tmdev->srot_map, CTRL_OFFSET, &code);
> > +             if (ret)
> > +                     return ret;
> > +             if (!(code & TSENS_EN)) {
> > +                     dev_err(tmdev->dev, "tsens device is not enabled\n");
> > +                     return -ENODEV;
> > +             }
> > +     }
> > +
> >       return 0;
> >  }
> > --
> > 2.17.1
> >
