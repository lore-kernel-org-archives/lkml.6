Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CA907C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776EB208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SU8Y5aoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776EB208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbeFNHMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:12:23 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51581 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754589AbeFNHMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:12:21 -0400
Received: by mail-it0-f67.google.com with SMTP id n7-v6so7012467itn.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BOohwfeFGPANxXRV52HzxKMlKYLjJMJxES/9S9IAN6c=;
        b=SU8Y5aohGKY7OU2lCYEnaNgsSkxSoH4bocm3oy6f7Nw+zn3WJ8Z5+PuOkybuFC9fQ8
         h/mocG161oIKLyUKk+Z/q9I8OEau++uGFJEyENKFI+sL7t8T3whzXuIX5Qj98YOId9lR
         hHkKCPT1Rx3xDZJ4csrwuHkVkSHmc5fn9LU+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BOohwfeFGPANxXRV52HzxKMlKYLjJMJxES/9S9IAN6c=;
        b=E6CpY44kXL2H/YwCvQ2MaSix+MzwhncO3BBrS3eEwdR5AiowsOBpJZu/w0RjoLxzIP
         z1ePCbD0DA23Vdxsf5bCxh0sFwsC3ljjqHJP2m7wvqS4mva3l9dHybrESFu6ATjMo3s8
         WAOM+fjRs1ziUg7/lYRS1jnIiLxh9QM1Gu981iKBJCqvJqX8I7qOJNnDbpXq0xEwjjD/
         iZxaIB1E61UFRnoAnFvK3VcPmjQNRvfcIflJGBJHCYTotd+X6As9UIoV9371ULyVHyrQ
         vFdL1Mhh9EAeEZ6P32CbgOYAO7oa52rCnJ+LSA9tBsDZv36PdzWLDsAI0xRfSLq6UUgc
         aTXg==
X-Gm-Message-State: APt69E1OiOBTdorh8KnQ1zl1dUIJDJj3VSLTlDLeWonXzsW3ETQ93yYZ
        SXjCwgEcgeHpnbLejIJy9/PGAXOQtnhIYuHn44+f6Q==
X-Google-Smtp-Source: ADUXVKK3P+izr4Aemts8MtEV5v+x6uGhs0XxPfNTK3YlNLp1iGAidiJHPX3L/fmAlnyYOlJE0+3l6Wlnt849OanjE0Y=
X-Received: by 2002:a24:91d3:: with SMTP id i202-v6mr1190560ite.97.1528960340592;
 Thu, 14 Jun 2018 00:12:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 00:12:20
 -0700 (PDT)
In-Reply-To: <b90f44d35e8e0fa9c81b3a88d05449a580be5567.1528953706.git.viresh.kumar@linaro.org>
References: <b90f44d35e8e0fa9c81b3a88d05449a580be5567.1528953706.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Jun 2018 09:12:20 +0200
Message-ID: <CAPDyKFpN+wLHGE4a14Me7F=dLLGZDnN23BUBd7yBifNuApQYxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / Domains: Rename opp_node to np
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 June 2018 at 07:23, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The DT node passed here isn't necessarily an OPP node, as this routine
> can also be used for cases where the "required-opps" property is present
> directly in the device's node. Rename it.
>
> This also removes a stale comment.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4925af5c4cf0..c298de8a8308 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2487,10 +2487,9 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>   * power domain corresponding to a DT node's "required-opps" property.
>   *
>   * @dev: Device for which the performance-state needs to be found.
> - * @opp_node: DT node where the "required-opps" property is present. This can be
> + * @np: DT node where the "required-opps" property is present. This can be
>   *     the device node itself (if it doesn't have an OPP table) or a node
>   *     within the OPP table of a device (if device has an OPP table).
> - * @state: Pointer to return performance state.
>   *
>   * Returns performance state corresponding to the "required-opps" property of
>   * a DT node. This calls platform specific genpd->opp_to_performance_state()
> @@ -2499,7 +2498,7 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>   * Returns performance state on success and 0 on failure.
>   */
>  unsigned int of_genpd_opp_to_performance_state(struct device *dev,
> -                                              struct device_node *opp_node)
> +                                              struct device_node *np)
>  {
>         struct generic_pm_domain *genpd;
>         struct dev_pm_opp *opp;
> @@ -2514,7 +2513,7 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
>
>         genpd_lock(genpd);
>
> -       opp = of_dev_pm_opp_find_required_opp(&genpd->dev, opp_node);
> +       opp = of_dev_pm_opp_find_required_opp(&genpd->dev, np);
>         if (IS_ERR(opp)) {
>                 dev_err(dev, "Failed to find required OPP: %ld\n",
>                         PTR_ERR(opp));
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
