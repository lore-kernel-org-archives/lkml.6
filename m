Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E768EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CBA2073F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cuSHDsRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfACBsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:48:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35153 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfACBsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:48:40 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so35501389qtc.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 17:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thFpa+W1SI63LvDKRAZVs5xIhfA77m2jO3Zt+q2EF4g=;
        b=cuSHDsRk/Yv120LPqBJbDTt4+9A/tCprKfqL1CZtDwCyovp4Vi5EMjnjGgJ6jD6C1J
         ysFnFqkcKMoQOEzLgfttRStGKky0n8KtEO8jPVy8j6/rervGaRMeEi8BCJAZPctIqj7j
         5MoY8VY1rGhhGDVgxYAi5NeDk7tknj9o62h3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thFpa+W1SI63LvDKRAZVs5xIhfA77m2jO3Zt+q2EF4g=;
        b=sQ3DIsAH1NsMLUh+1aAoYLOnZ8pygd8u6suQvgeNoi9oC9Zm14edkHXV2lZj7jBrnM
         DMD9xluDnWXAmZD8X0f3EZsHaW7mwihYdKxcI8XrtBKY4QdKczNstrZ3A2r0VgbcbL9S
         GL3NNKDMZxRWLleGc/n6sWk11WwGNk0iyN03ImxEUS9zce0Je5Gy7+qwMfGrezVnW4r8
         K8D4c57ev54L30yNyxRsxjyCxpC0ho98BQ8KkDwzfRaFK+JZ4MUJZ1qUgE8COtAS80uL
         daieJk/fngx612WBKiI2RtZHmFSXW8cpxnsUPitvh62O2wcTdNmHEvBcn4sJNmthAG6Y
         TnJA==
X-Gm-Message-State: AA+aEWb0PQlPGZs9SCKF1xX7jS5packe6mHjzb+2wmz3yrRYy27kkDxD
        tgwLzCn6N4Uoz1ik039sZJejxT1N7ZUyK773rQ+rcQ==
X-Google-Smtp-Source: AFSGD/WowvwcXJ+98Oxcta0ir5GKsF1yrXzyQRT9SR1VSLVZwWAoxDVDM5y2Ly/78yncDrq8Zk1FPWqy1wYrHGtTinA=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr45047408qts.144.1546480118762;
 Wed, 02 Jan 2019 17:48:38 -0800 (PST)
MIME-Version: 1.0
References: <1546436644-19234-1-git-send-email-henryc.chen@mediatek.com> <1546436644-19234-4-git-send-email-henryc.chen@mediatek.com>
In-Reply-To: <1546436644-19234-4-git-send-email-henryc.chen@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 3 Jan 2019 09:48:27 +0800
Message-ID: <CANMq1KCNSRv36L7mFNDEwFEdHm+q8cYz7GmfQZJQSGboe36vKQ@mail.gmail.com>
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

On Wed, Jan 2, 2019 at 10:01 PM Henry Chen <henryc.chen@mediatek.com> wrote:
>
> Support power domain performance state, add header file for scp event.
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 60 +++++++++++++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-scpsys.h | 22 ++++++++++++++
>  2 files changed, 82 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 58d84fe..90102ae 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -11,7 +11,9 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pm_opp.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
>  #include <linux/soc/mediatek/infracfg.h>
>  #include <linux/soc/mediatek/scpsys-ext.h>
>
> @@ -22,6 +24,7 @@
>  #include <dt-bindings/power/mt7623a-power.h>
>  #include <dt-bindings/power/mt8173-power.h>
>  #include <dt-bindings/power/mt8183-power.h>
> +#include "mtk-scpsys.h"
>
>  #define MTK_POLL_DELAY_US   10
>  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> @@ -187,6 +190,18 @@ struct scp_soc_data {
>         bool bus_prot_reg_update;
>  };
>
> +BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);
> +
> +int register_scpsys_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_register(&scpsys_notifier_list, nb);
> +}
> +
> +int unregister_scpsys_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_unregister(&scpsys_notifier_list, nb);
> +}
> +
>  static int scpsys_domain_is_on(struct scp_domain *scpd)
>  {
>         struct scp *scp = scpd->scp;
> @@ -536,6 +551,48 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
>                 clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
>  }
>
> +static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
> +                                 unsigned int state)
> +{
> +       int i;
> +       struct scp_domain *scpd =
> +               container_of(genpd, struct scp_domain, genpd);

nit: This (just) fits in 80 chars.

> +       struct scp_event_data scpe;
> +       struct scp *scp = scpd->scp;
> +       struct genpd_onecell_data *pd_data = &scp->pd_data;
> +
> +       for (i = 0; i < pd_data->num_domains; i++) {
> +               if (genpd == pd_data->domains[i]) {
> +                       dev_dbg(scp->dev, "%d. %s = %d\n",
> +                               i, genpd->name, state);
> +                       break;
> +               }
> +       }

Do we need a sanity check here, if i == pd_data->num_domains?

> +
> +       scpe.event_type = MTK_SCPSYS_PSTATE;
> +       scpe.genpd = genpd;
> +       scpe.domain_id = i;
> +       blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
> +
> +       return 0;
> +}
> +
> +static unsigned int mtk_pd_get_performance(struct generic_pm_domain *genpd,
> +                                          struct dev_pm_opp *opp)
> +{
> +       struct device_node *np;
> +       unsigned int state;
> +
> +       np = dev_pm_opp_get_of_node(opp);
> +
> +       if (of_property_read_u32(np, "mtk,level", &state))
> +               return 0;
> +
> +       of_node_put(np);
> +
> +       return state;
> +}
> +
>  static struct scp *init_scp(struct platform_device *pdev,
>                         const struct scp_domain_data *scp_domain_data, int num,
>                         const struct scp_ctrl_reg *scp_ctrl_reg,
> @@ -659,6 +716,9 @@ static struct scp *init_scp(struct platform_device *pdev,
>                 genpd->power_on = scpsys_power_on;
>                 if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
>                         genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
> +
> +               genpd->set_performance_state = mtk_pd_set_performance;
> +               genpd->opp_to_performance_state = mtk_pd_get_performance;
>         }
>
>         return scp;
> diff --git a/drivers/soc/mediatek/mtk-scpsys.h b/drivers/soc/mediatek/mtk-scpsys.h
> new file mode 100644
> index 0000000..c1e8325
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-scpsys.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_SCPSYS_H__
> +#define __MTK_SCPSYS_H__
> +
> +struct scp_event_data {
> +       int event_type;
> +       int domain_id;
> +       struct generic_pm_domain *genpd;
> +};
> +
> +enum scp_event_type {
> +       MTK_SCPSYS_PSTATE,
> +};
> +
> +int register_scpsys_notifier(struct notifier_block *nb);
> +int unregister_scpsys_notifier(struct notifier_block *nb);
> +
> +#endif /* __MTK_SCPSYS_H__ */
> --
> 1.9.1
>
