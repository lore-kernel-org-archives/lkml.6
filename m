Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C0321908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2fF/a2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbeLUKcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:32:07 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34279 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389558AbeLUKcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:32:07 -0500
Received: by mail-vs1-f68.google.com with SMTP id y27so2956806vsi.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izWgaZduLJ4ZZfBJHh9HqZfbpzXJM1zAJ7oJFAku28g=;
        b=I2fF/a2f4vW7u8hZdQ5+V9wjJ3ZcjpziqH0ZMY+7yieM5pWB23n/AadzirGIy1TK5Q
         Uwnx7A/vp0uLtcYxwZtSq2aHvU0Uu3aiMnmGFhBLrmoT6rJWkOvOKe8N2jhHadKJMump
         juNpFiMWZnBeUnsAd5tUFcT/4aCn+7g7FDZIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izWgaZduLJ4ZZfBJHh9HqZfbpzXJM1zAJ7oJFAku28g=;
        b=CecwJ0nyOYkTQOrEOYugHNUdRZyJc3cDjVG3fydPh2nVWjdV/e8y4g8k4FDht7CIcs
         uhgJzGVdN8CkojbjyIwxBANqk1urL3VD6IrIINY9qR9Z2qXDIa5zSGOK5UFW5Z6zngQm
         7tGVJBq00+See3LXXLCB6rbX3RLZRipEUCqkAEMBviXb90gZIJXrfITeoOQhqKjkFlcP
         +nIbET07GIzCMrfgEe+CJjWIY52qd4KsEDnGBgbBBbVEmiNiH54ll17SK9GuCE//xjfx
         ajAnbK85hFRfCCBFuJpKYlgGXUP9NtAanzu6cD0EgoPj8krc8PuBlGrdfm7x73GUHBoU
         3Dgg==
X-Gm-Message-State: AA+aEWbBFBdcKFx04Xbpt32NEGMVaICuJ1PwN//8GLUWnLw/X0otpt13
        rKI8AN2O31pR+5LOEPcK+G3tvfrwkBZAVhE9yuwnUw==
X-Google-Smtp-Source: ALg8bN5n3BhspuwPUcPwCxKyIyXv2drDDa+vuwxmaj2r+Uj45LqavGxTe6FyylLb7fcgmwk05lLKiC018qVa1VDgkJM=
X-Received: by 2002:a67:b245:: with SMTP id s5mr812832vsh.200.1545388326240;
 Fri, 21 Dec 2018 02:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20181221085622.25573-1-rnayak@codeaurora.org> <20181221085622.25573-9-rnayak@codeaurora.org>
In-Reply-To: <20181221085622.25573-9-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Dec 2018 11:31:28 +0100
Message-ID: <CAPDyKFpsqGJ4mMYEMto4nHcYeNr0z-dEea9LFfCuSeTfok8SDQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/10] PM / Domains: Add a simple_opp_to_performance_state()
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
> Now that we have atleast 2 genpd providers, both using a simple
> routine to read a performance state value from device tree and
> return it, in order to implement the .opp_to_performance_state
> callback, add a simple_opp_to_performance_state() helper to do
> it, so it can be resued across all such genpd providers which
> just need to read the value from DT.
>
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/power/domain.c | 17 +++++++++++++++++
>  include/linux/pm_domain.h   |  9 +++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 8e554e6a82a2..193872afbe20 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2520,6 +2520,23 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>
> +unsigned int simple_opp_to_performance_state(struct generic_pm_domain *genpd,
> +                                            struct dev_pm_opp *opp,
> +                                            const char *name)
> +{

Looks like this function should be moved into the OPP library instead.
There is no use of the genpd.

> +       struct device_node *np;
> +       unsigned int perf_state = 0;
> +
> +       np = dev_pm_opp_get_of_node(opp);
> +       if (of_property_read_u32(np, name, &perf_state))
> +               pr_err("%s: missing %s property\n", __func__, name);
> +
> +       of_node_put(np);
> +
> +       return perf_state;
> +}
> +EXPORT_SYMBOL_GPL(simple_opp_to_performance_state);
> +

Kind regards
Uffe
