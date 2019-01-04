Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1DEC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E9221871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gDVU+rXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfADHVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:21:22 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33809 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfADHVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 02:21:21 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so39594935qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 23:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+T1zAqzsjsRCsWOGvgNAYmKjzogu0XN9kgSsZf8+U7U=;
        b=gDVU+rXky/kXBWaN88pyA39nTK63YJWyefaj9NMBGWURX5ODdeujeU20uq0qXGtKNt
         aKDRERNmq5AW1JYCHZH+07WnRTb+I4hC/mx4nPfkA6HhV+DPh/tFVVCbQ/HrxsCGa6q+
         RsmVMjnXK2JUXTny+ib8xHKzG9Kq1xbtgrnUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+T1zAqzsjsRCsWOGvgNAYmKjzogu0XN9kgSsZf8+U7U=;
        b=iyr+L6sZsZk72s3nostlx8XN0PvD1gG3SsdAyMso+aPnt5Ti+pFVqkMqS8iSDbpJZP
         OKdeepK6kWajgfP77Mf8meFFaCvyAp2PY96KsibGipbMtp6fB3WQCZebqrfgGoQpCcir
         YHvGrOnDzkx6V8OqO3m0fl4DwFTjWaqJ5metjZNLFTZ3MW263LZUJl42husvIWHdgG8v
         +o8CrI5CN99EQdaj9X6V4+5rw/8ZFBRKiZlGIRMV2O0UKYiL0uAyp/sjPz7lXduKITGh
         rG0QW4s78382wg5iBNHEO1EtDdUtkhVZMoVhBS73biL2TKWb3TNguvh3gFb7jVvyjI8f
         mCfw==
X-Gm-Message-State: AA+aEWYSKhqWvpSZejC4vSHujWgZtjtpZs7dCj0jTd26vgkYWjStoPTn
        kjw4/t47B54M6sa/Mc7LMrTi/uvBeM53H/8+bTTCyA==
X-Google-Smtp-Source: AFSGD/U3I21lq6IKl4aI5P9jOJSCjGTeJMe3df3iGyKG2HN5LKk339V9+IjAbbW94RVP5COIkykBhrM0zUi0UsY32zQ=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr49651800qts.144.1546586479926;
 Thu, 03 Jan 2019 23:21:19 -0800 (PST)
MIME-Version: 1.0
References: <1546436644-19234-1-git-send-email-henryc.chen@mediatek.com>
 <1546436644-19234-4-git-send-email-henryc.chen@mediatek.com>
 <CANMq1KCNSRv36L7mFNDEwFEdHm+q8cYz7GmfQZJQSGboe36vKQ@mail.gmail.com> <1546524988.6818.54.camel@mtksdaap41>
In-Reply-To: <1546524988.6818.54.camel@mtksdaap41>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 4 Jan 2019 15:21:09 +0800
Message-ID: <CANMq1KBm1Ggaqhd3S3dhkh5Z+YqqD1B5uN48bN2y1_Oq=_u4rQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] soc: mediatek: add support for the performance state
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 10:16 PM Henry Chen <henryc.chen@mediatek.com> wrote:
>
> On Thu, 2019-01-03 at 09:48 +0800, Nicolas Boichat wrote:
> > On Wed, Jan 2, 2019 at 10:01 PM Henry Chen <henryc.chen@mediatek.com> wrote:
> > >
> > > Support power domain performance state, add header file for scp event.
> > >
> > > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > > ---
> > >  drivers/soc/mediatek/mtk-scpsys.c | 60 +++++++++++++++++++++++++++++++++++++++
> > >  drivers/soc/mediatek/mtk-scpsys.h | 22 ++++++++++++++
> > >  2 files changed, 82 insertions(+)
> > >  create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
> > >
> > > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > > index 58d84fe..90102ae 100644
> > > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > > @@ -11,7 +11,9 @@
> > >  #include <linux/of_device.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_domain.h>
> > > +#include <linux/pm_opp.h>
> > >  #include <linux/regulator/consumer.h>
> > > +#include <linux/slab.h>
> > >  #include <linux/soc/mediatek/infracfg.h>
> > >  #include <linux/soc/mediatek/scpsys-ext.h>
> > >
> > > @@ -22,6 +24,7 @@
> > >  #include <dt-bindings/power/mt7623a-power.h>
> > >  #include <dt-bindings/power/mt8173-power.h>
> > >  #include <dt-bindings/power/mt8183-power.h>
> > > +#include "mtk-scpsys.h"
> > >
> > >  #define MTK_POLL_DELAY_US   10
> > >  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> > > @@ -187,6 +190,18 @@ struct scp_soc_data {
> > >         bool bus_prot_reg_update;
> > >  };
> > >
> > > +BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);
> > > +
> > > +int register_scpsys_notifier(struct notifier_block *nb)
> > > +{
> > > +       return blocking_notifier_chain_register(&scpsys_notifier_list, nb);
> > > +}
> > > +
> > > +int unregister_scpsys_notifier(struct notifier_block *nb)
> > > +{
> > > +       return blocking_notifier_chain_unregister(&scpsys_notifier_list, nb);
> > > +}
> > > +
> > >  static int scpsys_domain_is_on(struct scp_domain *scpd)
> > >  {
> > >         struct scp *scp = scpd->scp;
> > > @@ -536,6 +551,48 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
> > >                 clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> > >  }
> > >
> > > +static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
> > > +                                 unsigned int state)
> > > +{
> > > +       int i;
> > > +       struct scp_domain *scpd =
> > > +               container_of(genpd, struct scp_domain, genpd);
> >
> > nit: This (just) fits in 80 chars.
> Try again and get 81 chars :)

Really not a big deal, but I did check and I think it fits ,-)

        struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
01234567890123456789012345678901234567890123456789012345678901234567890123456789

> >
> > > +       struct scp_event_data scpe;
> > > +       struct scp *scp = scpd->scp;
> > > +       struct genpd_onecell_data *pd_data = &scp->pd_data;
> > > +
> > > +       for (i = 0; i < pd_data->num_domains; i++) {
> > > +               if (genpd == pd_data->domains[i]) {
> > > +                       dev_dbg(scp->dev, "%d. %s = %d\n",
> > > +                               i, genpd->name, state);
> > > +                       break;
> > > +               }
> > > +       }
> >
> > Do we need a sanity check here, if i == pd_data->num_domains?
> Oops. It needed, thanks for remind.
> >
> > > +
> > > +       scpe.event_type = MTK_SCPSYS_PSTATE;
> > > +       scpe.genpd = genpd;
> > > +       scpe.domain_id = i;
> > > +       blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static unsigned int mtk_pd_get_performance(struct generic_pm_domain *genpd,
> > > +                                          struct dev_pm_opp *opp)
> > > +{
> > > +       struct device_node *np;
> > > +       unsigned int state;
> > > +
> > > +       np = dev_pm_opp_get_of_node(opp);
> > > +
> > > +       if (of_property_read_u32(np, "mtk,level", &state))
> > > +               return 0;
> > > +
> > > +       of_node_put(np);
> > > +
> > > +       return state;
> > > +}
> > > +
> > >  static struct scp *init_scp(struct platform_device *pdev,
> > >                         const struct scp_domain_data *scp_domain_data, int num,
> > >                         const struct scp_ctrl_reg *scp_ctrl_reg,
> > > @@ -659,6 +716,9 @@ static struct scp *init_scp(struct platform_device *pdev,
> > >                 genpd->power_on = scpsys_power_on;
> > >                 if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
> > >                         genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
> > > +
> > > +               genpd->set_performance_state = mtk_pd_set_performance;
> > > +               genpd->opp_to_performance_state = mtk_pd_get_performance;
> > >         }
> > >
> > >         return scp;
> > > diff --git a/drivers/soc/mediatek/mtk-scpsys.h b/drivers/soc/mediatek/mtk-scpsys.h
> > > new file mode 100644
> > > index 0000000..c1e8325
> > > --- /dev/null
> > > +++ b/drivers/soc/mediatek/mtk-scpsys.h
> > > @@ -0,0 +1,22 @@
> > > +/* SPDX-License-Identifier: GPL-2.0
> > > + *
> > > + * Copyright (c) 2018 MediaTek Inc.
> > > + */
> > > +
> > > +#ifndef __MTK_SCPSYS_H__
> > > +#define __MTK_SCPSYS_H__
> > > +
> > > +struct scp_event_data {
> > > +       int event_type;
> > > +       int domain_id;
> > > +       struct generic_pm_domain *genpd;
> > > +};
> > > +
> > > +enum scp_event_type {
> > > +       MTK_SCPSYS_PSTATE,
> > > +};
> > > +
> > > +int register_scpsys_notifier(struct notifier_block *nb);
> > > +int unregister_scpsys_notifier(struct notifier_block *nb);
> > > +
> > > +#endif /* __MTK_SCPSYS_H__ */
> > > --
> > > 1.9.1
> > >
>
>
