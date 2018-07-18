Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37572ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF7C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIu2wHPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF7C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbeGRESt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:18:49 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36937 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeGRESt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:18:49 -0400
Received: by mail-qk0-f196.google.com with SMTP id t79-v6so1705719qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 20:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eq+pE3RnleQrlqpjqeP5iGQjAeunhaEwy6aXm7zaHw=;
        b=FIu2wHPRru/DaDhipsXdaSW0jd6V4UZaajuKz19Ccw1Bwk5THpNx1bu8qaRnpa1dAK
         Y57H2M66RZ53+U9Gt/g2el03gVB73Zyxo3Utgt91D5moE7CxI+STStXnAQ9JWFYhxt/d
         w86Szp76eD4+4YIir7bufTfkcvjdduAoKWbck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eq+pE3RnleQrlqpjqeP5iGQjAeunhaEwy6aXm7zaHw=;
        b=kmYj59jqH/NsfrLR3037daqCHKDyCy22VMVA6i1ZJA79+/EE0p51nZFONaA3CFf9rR
         DBUIHH1UwfAQ47Wui/SkWdvNVAe2+bApTwh9e1rFisRMkKPI7+dCT7uWUwuJ4Mcc8Ya0
         kN+8CNj7n7arcGSAeA8OxIAgalWE/GelgH8kmPKFPYCjkFDmIBJvBRAXBR47A40Ht6/m
         qRC5efDtq/Udx2y5oM0z5LiRLeG2K6WLlIIpQm6uJh5HkFiW2Y6yhsoHF+rLKRCG/GZy
         WhuamQQdgbPSgdatYtVign83vTvn58HeYnhqKh7XYrQHrRfWT5bglfm5bivGgGdcASn0
         BSIg==
X-Gm-Message-State: AOUpUlEH8uzAbbPpcnVY3Qtv4z83BhCdAVuVB30zmaURs31hD1xaXYO0
        BtItvaMfu7SbFmnRGa8qySZGGUf9J8B43tXzlichiScL
X-Google-Smtp-Source: AAOMgpdcIdto1JaTUKMQhyzMcpQCIZEzsYc2dXDpO5clP8WXFt/0bTnvKBl2K9j1NW+j0tY8ju+NFoZsrq6IvjNQWGM=
X-Received: by 2002:a37:9187:: with SMTP id t129-v6mr3874142qkd.112.1531885382247;
 Tue, 17 Jul 2018 20:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <8f833fee80565c4dfd381697e47f99fb5f9e65d3.1531384019.git.amit.kucheria@linaro.org>
 <20180717232907.GC129942@google.com>
In-Reply-To: <20180717232907.GC129942@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 18 Jul 2018 09:12:50 +0530
Message-ID: <CAP245DXH=k--JJvTxV29uxqeRGJgFW+QgN-ctq5NJLYXRgjjWg@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] thermal: tsens: Add support to split up register
 address space into two
To:     mka@chromium.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 4:59 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Thu, Jul 12, 2018 at 02:09:03PM +0530, Amit Kucheria wrote:
> > There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
> > SoCs these were contiguous, leading to DTs mapping them as one register
> > address space of size 0x2000. In newer SoCs, these two banks are not
> > contiguous anymore.
> >
> > Add logic to init_common() to differentiate between old and new DTs and
> > adjust associated offsets for the TM register bank so that the old DTs will
> > continue to function correctly.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/thermal/qcom/tsens-8996.c   |  4 ++--
> >  drivers/thermal/qcom/tsens-common.c | 12 ++++++++++++
> >  drivers/thermal/qcom/tsens.h        |  1 +
> >  3 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
> > index e1f7781..3e60cec 100644
> > --- a/drivers/thermal/qcom/tsens-8996.c
> > +++ b/drivers/thermal/qcom/tsens-8996.c
> > @@ -16,7 +16,7 @@
> >  #include <linux/regmap.h>
> >  #include "tsens.h"
> >
> > -#define STATUS_OFFSET        0x10a0
> > +#define STATUS_OFFSET        0xa0
> >  #define LAST_TEMP_MASK       0xfff
> >  #define STATUS_VALID_BIT     BIT(21)
> >  #define CODE_SIGN_BIT                BIT(11)
> > @@ -28,7 +28,7 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
> >       unsigned int sensor_addr;
> >       int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
> >
> > -     sensor_addr = STATUS_OFFSET + s->hw_id * 4;
> > +     sensor_addr = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
> >       ret = regmap_read(tmdev->map, sensor_addr, &code);
> >       if (ret)
> >               return ret;
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index b1449ad..c22dc18 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/io.h>
> >  #include <linux/nvmem-consumer.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  #include "tsens.h"
> > @@ -126,11 +127,22 @@ static const struct regmap_config tsens_config = {
> >  int __init init_common(struct tsens_device *tmdev)
> >  {
> >       void __iomem *base;
> > +     struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
> >
> > +     if (!op)
> > +             return -EINVAL;
> >       base = of_iomap(tmdev->dev->of_node, 0);
> >       if (!base)
> >               return -EINVAL;
> >
> > +     /* The driver only uses the TM register address space for now */
> > +     if (op->num_resources > 1) {
> > +             tmdev->tm_offset = 0;
> > +     } else {
> > +             /* old DTs where SROT and TM were in a contiguous 2K block */
> > +             tmdev->tm_offset = 0x1000;
> > +     }
>
> nit: no curly braces for conditionals with a single statement. There
> is probably no need to respin just for this though.

Yeah, that was leftover from refactoring because I have an upcoming
patch that adds SROT mapping inside those braces. I'm about to post it
soon.

> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
