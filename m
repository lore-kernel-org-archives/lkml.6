Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29709C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22F62145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD9FeJe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22F62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeJSEE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:04:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34574 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJSEE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:04:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id j17-v6so28884145lja.1;
        Thu, 18 Oct 2018 13:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6z3vP0fwt68zYFXKZdD0CpdSptngekFINHn9PeTxJ4=;
        b=mD9FeJe7eBscyRcgNWxjQvs/84r2Ja+OEXOE2PtQiO4xXOGwv72h7IqoEv5S0dX9Ek
         NlcwTLUz8kehedfW7WcKwaeSZfDyss6VNC4D+1a/mfnTskKKpuxeen/XDxKecKksPBqn
         yxbVafz3uc9y7Qhcw64p1Pi8++SJR8Rpp6fS7MxQzIWiaixkoLB8WNNP4WDDdjeEYCpW
         VZUwLyMIs3G3A73y0FyWS4FNKc/+9rPYcDYbtL/U2ZyreoLYWiIx9eBtO2fqwQ/JwquX
         yY/0zjZ9fEe+IM0KNHmxaDFQVCQGF1ET3VdwC+8KfMkasmIbgUSoUHHgz4pI9Qh9JEJT
         jEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6z3vP0fwt68zYFXKZdD0CpdSptngekFINHn9PeTxJ4=;
        b=Isyi//IAbTYFFSVCxuSudbPnBycMs5APk99+8p3qRBmGciQrpzvgG424Xq29ge6F/2
         DRmgUXUtMm9imVhlBSKdytxcJho5ET/3CDuEyCLazif9cEXZNinQ6+CabL4s4DFFQ/rd
         rMSUiExsNC17MowlyeNaeRht6AAfIxf7rCUmHih0jrMAwvJS/Oq9W8ZeGSGU+H5asDR+
         UALvWLSgMWo2dcoLr8hzAlOlMazFf7Fj8cgaxRkfgAwmDZKTAdFiJ0LlVJRg3VVlywrJ
         Lw5WR0NQrT6L9pz9ZKf+WcUr3y/bpK2lSTvghS6RgOTYigW5mK5illpedDYLo26aMMcQ
         6wpg==
X-Gm-Message-State: ABuFfojmZC6QWDwqr/epFeV0IwIUjTwTwkQ2bIt6v+NW4w7iYW34J25j
        GRF2SXSCdvBRpY8VnFsN2o/PqqHDDMd+tQHnZJc=
X-Google-Smtp-Source: ACcGV628+aiGEt99h+U9UerXY0DaupCrErOaRxpgNgZ0adca3jsMOgRDAa0i8sq6Rw3QUK9ZyoQGIMDRxlFP6ELVsYE=
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr21079226ljj.30.1539892938758;
 Thu, 18 Oct 2018 13:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <1467735814-23518-1-git-send-email-ricardo.ribalda@gmail.com>
 <1467735814-23518-11-git-send-email-ricardo.ribalda@gmail.com> <CANk1AXRvJQtcmAysrkfAGurGUGVHSq55=8PZARGYsEZNv2zt0g@mail.gmail.com>
In-Reply-To: <CANk1AXRvJQtcmAysrkfAGurGUGVHSq55=8PZARGYsEZNv2zt0g@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 18 Oct 2018 22:02:01 +0200
Message-ID: <CAPybu_2MyMyM9PXANowPkZ2LjnCUarNJmyHR+-bAowPNxVUThw@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] clk: fixed-rate: Convert into a module platform driver
To:     atull@kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        frowand.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan


On Thu, Oct 18, 2018 at 9:21 PM Alan Tull <atull@kernel.org> wrote:
>
> On Tue, Jul 5, 2016 at 11:45 AM Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
>
> I've stumbled across a of_node_get/put imbalance that happens when the
> fixed rate clock is added and deleted using device tree.  The cause is
> that this driver calls of_clk_add_provider() when probed, but doesn't
> call of_clk_del_provider() when removed.
>
> It looks like a lot of clock drivers share that issue:
>
> $ cd drivers/clk/
> $ git grep -l of_clk_add_provider * | xargs grep -L of_clk_del_provider | wc -l
> 131
>
> It should be a one line fix, but for many files.
>
> I'm not a clock subsystem expert, so please let me know whether I'm
> missing something here.

Not an expert either, but I believe that the affected drivers are much
less. We have to consider only the drivers that can be removed

git grep -l  of_clk_add_provider  | xargs grep -l platform_driver |
xargs grep -l  remove | xargs grep -L of_clk_del_provider
drivers/clk/clk-fixed-factor.c
drivers/clk/clk-fixed-rate.c
drivers/clk/davinci/psc.c
drivers/clk/ti/adpll.c
drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c


Also there is something else that I do not undersand:
of_clk_add_hw_provider() is the same as of_clk_add_provider() ?

Maybe is a good idea to remove one of them and use the devm_of_add_hw_provider.

I can try to do that with coccinelle if you want.

Cheers




>
> Thanks,
> Alan
>
> >
> > Adds support for fixed-rate clock providers which have not been
> > enabled via of_clk_init().
> >
> > This is required by Device trees overlays that introduce clocks
> > providers.
> >
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> >  drivers/clk/clk-fixed-rate.c | 69 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 65 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> > index 2edb39342a02..e64ba2315880 100644
> > --- a/drivers/clk/clk-fixed-rate.c
> > +++ b/drivers/clk/clk-fixed-rate.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/io.h>
> >  #include <linux/err.h>
> >  #include <linux/of.h>
> > +#include <linux/platform_device.h>
> >
> >  /*
> >   * DOC: basic fixed-rate clock that cannot gate
> > @@ -160,15 +161,16 @@ EXPORT_SYMBOL_GPL(clk_hw_unregister_fixed_rate);
> >  /**
> >   * of_fixed_clk_setup() - Setup function for simple fixed rate clock
> >   */
> > -void of_fixed_clk_setup(struct device_node *node)
> > +struct clk *_of_fixed_clk_setup(struct device_node *node)
> >  {
> >         struct clk *clk;
> >         const char *clk_name = node->name;
> >         u32 rate;
> >         u32 accuracy = 0;
> > +       int ret;
> >
> >         if (of_property_read_u32(node, "clock-frequency", &rate))
> > -               return;
> > +               return ERR_PTR(-EIO);
> >
> >         of_property_read_u32(node, "clock-accuracy", &accuracy);
> >
> > @@ -176,9 +178,68 @@ void of_fixed_clk_setup(struct device_node *node)
> >
> >         clk = clk_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
> >                                                     0, rate, accuracy);
> > -       if (!IS_ERR(clk))
> > -               of_clk_add_provider(node, of_clk_src_simple_get, clk);
> > +       if (IS_ERR(clk))
> > +               return clk;
> > +
> > +       ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
> > +       if (ret) {
> > +               clk_unregister(clk);
> > +               return ERR_PTR(ret);
> > +       }
> > +
> > +       return clk;
> > +}
> > +
> > +void of_fixed_clk_setup(struct device_node *node)
> > +{
> > +       _of_fixed_clk_setup(node);
> >  }
> >  EXPORT_SYMBOL_GPL(of_fixed_clk_setup);
> >  CLK_OF_DECLARE(fixed_clk, "fixed-clock", of_fixed_clk_setup);
> > +
> > +static int of_fixed_clk_remove(struct platform_device *pdev)
> > +{
> > +       struct clk *clk = platform_get_drvdata(pdev);
> > +
> > +       if (clk)
> > +               clk_unregister_fixed_rate(clk);
> > +
> > +       return 0;
> > +}
> > +
> > +static int of_fixed_clk_probe(struct platform_device *pdev)
> > +{
> > +       struct clk *clk;
> > +
> > +       /*
> > +        * This function is not executed when of_fixed_clk_setup
> > +        * succeeded.
> > +        */
> > +
> > +       clk = _of_fixed_clk_setup(pdev->dev.of_node);
> > +
> > +       if (IS_ERR(clk))
> > +               return PTR_ERR(clk);
> > +
> > +       platform_set_drvdata(pdev, clk);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id of_fixed_clk_ids[] = {
> > +       { .compatible = "fixed-clock" },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(of, of_fixed_clk_ids);
> > +
> > +static struct platform_driver of_fixed_clk_driver = {
> > +       .driver = {
> > +               .name = "of_fixed_clk",
> > +               .of_match_table = of_fixed_clk_ids,
> > +       },
> > +       .probe = of_fixed_clk_probe,
> > +       .remove = of_fixed_clk_remove,
> > +};
> > +
> > +builtin_platform_driver(of_fixed_clk_driver);
> >  #endif
> > --
> > 2.8.1
> >



-- 
Ricardo Ribalda
