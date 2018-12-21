Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D6DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BC2218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJvPwxNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389750AbeLUKdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:33:44 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39537 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389727AbeLUKdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:33:42 -0500
Received: by mail-ua1-f68.google.com with SMTP id c12so1528473uas.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2stpEs+OWZ3uWLK9hlxi7mbh2HBhZzXFGkfrYf5BNE=;
        b=dJvPwxNGtR1t8eM1+bkotVh4w7vuv0wzT70EFruj/tb77+W9g3DEtO8+cIyG6AeCNK
         7zoB++UQYI3W4eO0c+gdaqdceq59eTgStJvs16dEsi2H1jg56yx1RYXdrkkpDYZ1BcV5
         yngBfeG+lKVcdSbYc3cllH01+iAVhNyDQH7Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2stpEs+OWZ3uWLK9hlxi7mbh2HBhZzXFGkfrYf5BNE=;
        b=DsmB8YuqX3KaY+6Gm0sSU+WUe4SBUKKO/Y5eJZ+S5POxS+BSXwq92MPw/9T+zLeEDK
         mGDZV1AQDIAYj4ZvUAJGGqb+XQOhhby3/kjvOCxwVaDaZ+6r1PueolIfwooS+8o/FzFP
         TZ9BLlQopDe4oTxOpe3RTT6lE71P0S4ZhLULXZm+/a5wbyiediGOD5eF4zFWFl8E9iMO
         Ns1/Fp4Ieo/rHm25t9U2mP07vaeDu0Kqio+EoEyWKCh5AsWlizzNsoAr+VGAQ3kthGNQ
         pnZazNviBHSn8Kp35TVBLmlLOGQDxWdjQwgR4NZdI65k2/TGJnFU7oG8re/aHIjHSS2+
         qyqQ==
X-Gm-Message-State: AJcUukfsSn50+9YhdfbXtochHyyU7J9Y6eW26lqNZN83x/6LJVEmoKFG
        IcKHqJdStiegqGFNylcQejcI0KG0+vTtzZI0YEbqIA==
X-Google-Smtp-Source: ALg8bN5V5lYTN6ZRvL8q5sP0oacnS5cekybnuDj1/72tTsnxpanPQvlEvu52X/XYBtr1xGZnvtw9EVWwp+vYXVbApT4=
X-Received: by 2002:ab0:526:: with SMTP id 35mr713348uax.25.1545388420627;
 Fri, 21 Dec 2018 02:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20181221085622.25573-1-rnayak@codeaurora.org> <20181221085622.25573-11-rnayak@codeaurora.org>
In-Reply-To: <20181221085622.25573-11-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Dec 2018 11:33:03 +0100
Message-ID: <CAPDyKFqFW-UmdBf00Rt5F=40QBys98f6WLRKMzYXGpiLYhwW4A@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] soc: qcom: rpmhpd: Mark mx as a parent for cx
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
> Specify the active + sleep and active-only MX power domains as
> the parents of the corresponding CX power domains. This will ensure that
> performance state requests on CX automatically generate equivalent requests
> on MX power domains.
>
> This is used to enforce a requirement that exists for various
> hardware blocks on SDM845 that MX performance state >= CX performance
> state for a given operating frequency.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/qcom/rpmhpd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index f7fbe57f31ae..71d693c31e3b 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -97,12 +97,14 @@ static struct rpmhpd sdm845_cx_ao;
>  static struct rpmhpd sdm845_cx = {
>         .pd = { .name = "cx", },
>         .peer = &sdm845_cx_ao,
> +       .parent = &sdm845_mx.pd,
>         .res_name = "cx.lvl",
>  };
>
>  static struct rpmhpd sdm845_cx_ao = {
>         .pd = { .name = "cx_ao", },
>         .peer = &sdm845_cx,
> +       .parent = &sdm845_mx_ao.pd,
>         .res_name = "cx.lvl",
>  };
>
> @@ -372,6 +374,15 @@ static int rpmhpd_probe(struct platform_device *pdev)
>                 data->domains[i] = &rpmhpds[i]->pd;
>         }
>
> +       /* Add subdomains */
> +       for (i = 0; i < num_pds; i++) {
> +               if (!rpmhpds[i])
> +                       continue;
> +               if (rpmhpds[i]->parent)
> +                       pm_genpd_add_subdomain(rpmhpds[i]->parent,
> +                                              &rpmhpds[i]->pd);
> +       }
> +
>         return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>  }
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
