Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31847C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00840218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOWbgrGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389726AbeLUKdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:33:12 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:32838 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbeLUKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:33:12 -0500
Received: by mail-vk1-f196.google.com with SMTP id d201so1052816vka.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yo7C3mfxMGpExGrsv/1VELR7Zr5lJCuNyK/T0CQ52wY=;
        b=aOWbgrGus2A3mAMvIkJjp8JTXiF91d0D8W9xD5YfMYLXrWhJkHdlZWb7h1JtP0TZIE
         lJAj67F5+1sor4yl+4SGZQwTn1Mv9hVBMz27tPZu6lT1UFy9NzANqZigcUaPJQD8xbFB
         Zq+C7B41dhbb4vRho8IL8QX1Sb+v1uQ1Fuck8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yo7C3mfxMGpExGrsv/1VELR7Zr5lJCuNyK/T0CQ52wY=;
        b=n8TpOnTDhQKvSOdswZQUiV60eQNDTdW9J02j0zGXvYibWGC4WxfdjfmGpLxpmiTl0z
         7YD/Wu6veNIgf+RfbbswnlvtinqFr/wMNBenxakt4MBoM31EEmxJh42ndJUW9WpGc8kp
         J3rvj7hrfB02KdSJ7RfCltgINpEG5FSlF35elzhUMU9m+o9xhtxU1RMkK1lEytw8pfQJ
         GyXhzr/2chHp6N3DJ40tS1Ayo4mPGrrWuMF7nLkd8D3Qb60KVC+ZuWsOwYyWN25dh69S
         c+mSNzgbyCpnWODpOg7Wmj4VG8MjX4THdh6cQZOkZJg+1/Bgcph6dkQNqSgOm4wrLE8X
         z7Fw==
X-Gm-Message-State: AJcUukfg9bUTG6XczrtPuMdnAzDac5CXlQfLfAefL4e29yXlLXtbC26x
        U4iOot4W+6/o83rrrYddeavC3PEmv0l6AGlnfLeDfA==
X-Google-Smtp-Source: ALg8bN44jxv68MkB14P6mTQcEylG+lj6bykDD89Og9bmxy06oJu5Ge81t5lPjd1WLju7MaiGiYsZj9EuhLuHCHMei+0=
X-Received: by 2002:a1f:4982:: with SMTP id w124mr727563vka.4.1545388391385;
 Fri, 21 Dec 2018 02:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20181221085622.25573-1-rnayak@codeaurora.org> <20181221085622.25573-10-rnayak@codeaurora.org>
In-Reply-To: <20181221085622.25573-10-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Dec 2018 11:32:34 +0100
Message-ID: <CAPDyKFoZmJ22uswL4nkbhfqeeSpcz09mgQ6-tsrJRxE5EwTUsw@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] soc: qcom: rpmpd: Use simple_opp_to_performance_state()
 helper
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>, Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 at 09:57, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Get rid of the duplicate code across rpmpd and rpmhpd to read the
> performance state value from Device tree and use the
> simple_opp_to_performance_state() helper instead.
>
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/qcom/rpmhpd.c | 11 +----------
>  drivers/soc/qcom/rpmpd.c  | 11 +----------
>  2 files changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index e37976e87370..f7fbe57f31ae 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -276,16 +276,7 @@ static int rpmhpd_set_performance_state(struct generic_pm_domain *domain,
>  static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd,
>                                                  struct dev_pm_opp *opp)
>  {
> -       struct device_node *np;
> -       unsigned int level = 0;
> -
> -       np = dev_pm_opp_get_of_node(opp);
> -       if (of_property_read_u32(np, "qcom,level", &level))
> -               pr_err("%s: missing 'qcom,level' property\n", __func__);
> -
> -       of_node_put(np);
> -
> -       return level;
> +       return simple_opp_to_performance_state(genpd, opp, "qcom,level");
>  }
>
>  static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index 59e21c88a144..29288af502b0 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -248,16 +248,7 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
>  static unsigned int rpmpd_get_performance(struct generic_pm_domain *genpd,
>                                           struct dev_pm_opp *opp)
>  {
> -       struct device_node *np;
> -       unsigned int corner = 0;
> -
> -       np = dev_pm_opp_get_of_node(opp);
> -       if (of_property_read_u32(np, "qcom,level", &corner))
> -               pr_err("%s: missing 'qcom,level' property\n", __func__);
> -
> -       of_node_put(np);
> -
> -       return corner;
> +       return simple_opp_to_performance_state(genpd, opp, "qcom,level");
>  }
>
>  static int rpmpd_probe(struct platform_device *pdev)
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
