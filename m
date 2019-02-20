Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8015421773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oEdOR/SZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfBTJUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:20:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36294 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfBTJUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:20:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id p25so26129838qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4B9NzpkAopf8RQY348E3G+2brMdCIhEuSb1SpVc+UIE=;
        b=oEdOR/SZoZj/dl856c+xdYqakFTJJgoJAZCLewMZxRjObuwwCd5vPCynQ82rbZ+6Z0
         Ex9MLuIpm3efp8YbJvZBMzmoYDKevzelMaA07KMRmZwVu+t9oOt8ob5oyVh4ppuUs0kC
         l7T5QWIhT7qP0M7g7GsSrkagPIo2l0JrPBMcFzToDNRiFIlMxbIwRVoL1tq9wct3P/SA
         TqP1n/XV3Mt+tqGVbuzHhxQbAPbUbbZts6jtRpBJg/ttAzKfOT1HuAMMpHhx5S/xxYE6
         kZ50dw3PdS+wiJLNILll1VcffMzlQAfXQXhr2pAUcxrn9/2BwRm4/uYMhekY/xkoJ3oy
         1pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4B9NzpkAopf8RQY348E3G+2brMdCIhEuSb1SpVc+UIE=;
        b=XHiVJe7VSx7pTxw46fgPR+ycJwEAh7jiAeEzzJbXNu9mV0Fezx45cyMMgC4gzp6tJ+
         1NabPOYf7W8l0zg8sJWF7mSgOcQ+wG477ijmLX1q3ONtHrxxhHLY7pfKMG4S93dn2Y6J
         rnyzKZ4BOd0D+XxLV4GosbLQLZwgPwiayZlUJeJXLS9rIxFYQGMb3ryXK9fJfjvkUQ7N
         q3RWjH4rCucrvHtvWT2W2oGKkP7Jy8V3kKab05GKkg8BclAZT72Z8yaIVn1lVYLME/s8
         cC38u6i98i3wMqJ1qxjat6xUGapm5oH/zpHG/LXM3IedjT7555BOaBbjFQWy/KHcO0nG
         GipA==
X-Gm-Message-State: AHQUAub+Ia+64sW+T6pKhyl4FrE/a/tUexLcXyPJpat7VfLMcEsh570X
        TgU+P45FgMrNKfF9rh1l3bow37UGkftFiO8OCt+hdw==
X-Google-Smtp-Source: AHgI3IaWir54LynzN1l0XRrqAmLRnZfg5qis+LtTpu7zDxJf7g7Z6mxtpPlC8649SOhVONiKPppsURxk80Y1tMXfPw4=
X-Received: by 2002:a0c:e942:: with SMTP id n2mr24617900qvo.119.1550654404226;
 Wed, 20 Feb 2019 01:20:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549525708.git.amit.kucheria@linaro.org>
 <ab6dd34ce0236de12ec1e9984931780c3df643f9.1549525708.git.amit.kucheria@linaro.org>
 <20190220011718.GD2811@localhost.localdomain>
In-Reply-To: <20190220011718.GD2811@localhost.localdomain>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 20 Feb 2019 14:49:53 +0530
Message-ID: <CAP245DUEbYhMw0WMP713uB34xVO0AF3-u_knpXfjP=858FgO-w@mail.gmail.com>
Subject: Re: [PATCH v1 13/24] drivers: thermal: tsens: Print IP version
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 6:47 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Thu, Feb 07, 2019 at 04:19:31PM +0530, Amit Kucheria wrote:
> > On some TSENS IP, version is stored. Print that version at init.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-common.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index aae3d71d7eed..39cd5733fd44 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -121,7 +121,7 @@ int __init init_common(struct tsens_priv *priv)
> >       void __iomem *tm_base, *srot_base;
> >       struct device *dev = priv->dev;
> >       struct resource *res;
> > -     u32 enabled;
> > +     u32 enabled, maj_ver, min_ver;
> >       int ret, i, j;
> >       struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
> >
> > @@ -155,6 +155,27 @@ int __init init_common(struct tsens_priv *priv)
> >       if (IS_ERR(priv->tm_map))
> >               return PTR_ERR(priv->tm_map);
> >
> > +     for (i = 0; i < MAX_REGFIELDS; i++) {
> > +             priv->rf[i] = NULL;
> > +     }
> > +
> > +     /* alloc regmap_fields in srot_map */
> > +     if (priv->feat->ver_info) {
> > +             for (i = 0, j = VER_MAJOR; i < 2; i++, j++) {
> > +                     priv->rf[j] = devm_regmap_field_alloc(dev, priv->srot_map,
> > +                                                           priv->fields[j]);
> > +                     if (IS_ERR(priv->rf[j]))
> > +                             return PTR_ERR(priv->rf[j]);
> > +             }
> > +             ret = regmap_field_read(priv->rf[VER_MAJOR], &maj_ver);
> > +             if (ret)
> > +                     return ret;
> > +             ret = regmap_field_read(priv->rf[VER_MINOR], &min_ver);
> > +             if (ret)
> > +                     return ret;
> > +             dev_info(dev, "version: %d.%d\n", maj_ver, min_ver);
>
> Is this really needed? Printing stuff into kernel log during boot can
> just add a lot of info that ends up just slowing down things. Besides,
> if this info is important shouldnt be available somewhere else as the
> kernel log is a circular buffer and eventually that line will get
> wrapped up?

Fair point, I'll remove this statement and dump this into debugfs for
which I'll send a separate series adding debugfs support.
