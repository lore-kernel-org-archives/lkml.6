Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350C7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C8C20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLu6cfG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C8C20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLKKXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:23:16 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42286 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeLKKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:23:16 -0500
Received: by mail-vs1-f68.google.com with SMTP id b74so8538916vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrYR4fvb9Zuy/diATyTIFQ/WDg9meXa7ljUFngMKNH4=;
        b=QLu6cfG+l0xhTSx07Yw7onreDDPEHoM0DY+Kv3ds4j3wOG5w3luAXYsFzprHbv+EMp
         jOEI/Of+uImSuYxqhZYVf65q6DOTRHw08apR4C6RcpLEXpUdmuVSOL35o6KKAn9zL4wR
         L1ny9rQ6hPoilkos2HVpR+Zf1LJPyoulT2ppI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrYR4fvb9Zuy/diATyTIFQ/WDg9meXa7ljUFngMKNH4=;
        b=cH0BN8ZeMq249JjHdjmkIVvXX0seYIA+wMNFefYhg5A+kMc72zF/bSoPKFq5j4pLvp
         yo7/ws/etRNw+YmQH9geQ+US5SPCoxNTd8AzF2yipat0w6d2c/nkziWpSCebbOEjFrLF
         J+HFVj1KBiD8jAvdiUqnWmUQWPJKQwXq4oSoOkOw4vCLBCOsgvTvh9FHgzdCKXBG/SbR
         fnsNN0wCpZhjWUL7f1sYO/RUoOhYytwGHTrVgqJu8IQR20fwEuwhO84p/QERt3pbdyZn
         xp6uoMBsbLmlKXu2ZYf7KbwdoAtslBAvAaEfWt2NfFu2xlMKfT8QFJNHUNI/FhUTNVoV
         Irhg==
X-Gm-Message-State: AA+aEWZDUMNibuIcT0vtjS3j8Z0gcbbCo3w0R5AqFlNOoelDsprLEvTJ
        v7/L+PbCAsgFR6LuV0lpCyvv76w3bavTn1ABRNazog==
X-Google-Smtp-Source: AFSGD/W4LYTzHEL6L7GCwBSBEUmecRY1goOwITKMIl0f1JKhq7k/T9G0uVoC6StbC4Qsjia2nKvD0cKv6VRqDW0Ua/8=
X-Received: by 2002:a67:b245:: with SMTP id s5mr7066706vsh.200.1544523795071;
 Tue, 11 Dec 2018 02:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20181211094938.25086-1-rnayak@codeaurora.org> <20181211094938.25086-11-rnayak@codeaurora.org>
In-Reply-To: <20181211094938.25086-11-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Dec 2018 11:22:39 +0100
Message-ID: <CAPDyKFof-rkzmzibWOrAhDFysU=y+C8Bp0cK=_iht4=vmv-0vw@mail.gmail.com>
Subject: Re: [PATCH v6 10/10] soc: qcom: rpmhpd: Mark mx as a parent for cx
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

On Tue, 11 Dec 2018 at 10:50, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Specify the active + sleep and active-only MX power domains as
> the parents of the corresponding CX power domains. This will ensure that
> performance state requests on CX automatically generate equivalent requests
> on MX power domains.
>
> This is used to enforce a requirement that exists for various
> hardware blocks on SDM845 that MX performance state >= CX performance
> state for a given operating frequency.

I assume that also means the MX power domain must not be power off as
long as the CX power domain is powered on?

Just to make sure there are no conflicting hierarchical constraints
between idle management and performance state management!?

Kind regards
Uffe

>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> This patch is dependent on the series from
> Viresh [1] which adds support to propogate performance states across the
> power domain hierarchy which is still being reviewed.
>
> [1] https://lkml.org/lkml/2018/11/26/333
>
>  drivers/soc/qcom/rpmhpd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 1ce86f0cc9fa..af7b07d49e4f 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -102,12 +102,14 @@ static struct rpmhpd sdm845_cx_ao;
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
> @@ -389,6 +391,15 @@ static int rpmhpd_probe(struct platform_device *pdev)
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
