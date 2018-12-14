Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE91C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACB420892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vo+/ZXK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACB420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbeLNKl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:41:29 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35497 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbeLNKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:41:27 -0500
Received: by mail-vk1-f194.google.com with SMTP id b18so1173094vke.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/BVCBDAdED2LAgjebUwHLxY5C3m2wZvn+o784wpRcw=;
        b=Vo+/ZXK9dWN3Wsg3l6pjAqo6Iz2kjJguw98J4ZCYWhEADj5agOqlFvzhHvnAmcVyp3
         lT1W9Ln0oztHUC4M19ON780tTq5ttUZ5i57+aPwVbRVJYHWV4fr5dhGNawXvFDqs1WKT
         nLS+IvE6ncX7wSC+FVGVJJa07ywm6UukzdqXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/BVCBDAdED2LAgjebUwHLxY5C3m2wZvn+o784wpRcw=;
        b=LHMMk+PrBnlfWABW7k0M7M5dz7mR2LTIEWA8HBmcJyQabOaGInTRpl9mRMFLbjzpjG
         vbZicVsMIxFdv3PnR/KVO13Ur7yO9qV9xr9SNghmOWx0CnNG+JoP2KzkV1TZO4OZZU8U
         JKeLt4q74ARDtGKDCtKl17ciVE7pK31CKWWlieBn+BKHK6vd+5QSNh37BV30t4Yn2avS
         LsEs3l51hmz/LA/zP31SuFo/I7VcXLta+sPfJRNzBvj/uOaN5zywJW9fb6bByWg+LyRM
         EuhYv6K3z1GAnOLb0N1GRX1Ig7UGQ19SbzLfDFYL1OJ5kmhA8FsR1FYdlxNII82HY6gj
         jrDw==
X-Gm-Message-State: AA+aEWYE2JHCE4CplvEN74XOmYZ4rj0A7cmguVH+VUbviKB4q6mRVKRV
        bVYLuKnScDq1BPzI39jrobR5Thh2v8NGhmQijfTZIw==
X-Google-Smtp-Source: AFSGD/XPtcJhungv7Ec/bxPuL23ctBBQrKNUKWSqwX53jXVsI5SOmbNigNMmU/G/OKXXVNCeQ7GhmRykqx6R8X8aG14=
X-Received: by 2002:a1f:4982:: with SMTP id w124mr988017vka.4.1544784086403;
 Fri, 14 Dec 2018 02:41:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544782279.git.viresh.kumar@linaro.org> <f6153683d88cce25319945e4308bef46edaaaa54.1544782279.git.viresh.kumar@linaro.org>
In-Reply-To: <f6153683d88cce25319945e4308bef46edaaaa54.1544782279.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Dec 2018 11:40:50 +0100
Message-ID: <CAPDyKFr7_Cn0N=pctuTdqzcUy9fg-fmpd5OgEFS9eRz-SFh1Fw@mail.gmail.com>
Subject: Re: [PATCH V4 6/7] PM / Domains: Factorize dev_pm_genpd_set_performance_state()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 at 11:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Separate out _genpd_set_performance_state() and
> _genpd_reeval_performance_state() from
> dev_pm_genpd_set_performance_state() to handle performance state update
> related stuff. This will be used by a later commit.
>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Nitpick: Would be nice to remove the beginning "_" from both
_genpd_reeval_performance_state() and _genpd_set_performance_state(),
as to be consistent with existing function naming in genpd. However,
it's not a big deal and can be done on top.



> ---
>  drivers/base/power/domain.c | 95 +++++++++++++++++++++----------------
>  1 file changed, 55 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 1e98c637e069..808ba41b6580 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -239,6 +239,56 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
>  static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>  #endif
>
> +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> +                                          unsigned int state)
> +{
> +       struct generic_pm_domain_data *pd_data;
> +       struct pm_domain_data *pdd;
> +
> +       /* New requested state is same as Max requested state */
> +       if (state == genpd->performance_state)
> +               return state;
> +
> +       /* New requested state is higher than Max requested state */
> +       if (state > genpd->performance_state)
> +               return state;
> +
> +       /* Traverse all devices within the domain */
> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +               pd_data = to_gpd_data(pdd);
> +
> +               if (pd_data->performance_state > state)
> +                       state = pd_data->performance_state;
> +       }
> +
> +       /*
> +        * We aren't propagating performance state changes of a subdomain to its
> +        * masters as we don't have hardware that needs it. Over that, the
> +        * performance states of subdomain and its masters may not have
> +        * one-to-one mapping and would require additional information. We can
> +        * get back to this once we have hardware that needs it. For that
> +        * reason, we don't have to consider performance state of the subdomains
> +        * of genpd here.
> +        */
> +       return state;
> +}
> +
> +static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> +                                       unsigned int state)
> +{
> +       int ret;
> +
> +       if (state == genpd->performance_state)
> +               return 0;
> +
> +       ret = genpd->set_performance_state(genpd, state);
> +       if (ret)
> +               return ret;
> +
> +       genpd->performance_state = state;
> +       return 0;
> +}
> +
>  /**
>   * dev_pm_genpd_set_performance_state- Set performance state of device's power
>   * domain.
> @@ -257,10 +307,9 @@ static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>  {
>         struct generic_pm_domain *genpd;
> -       struct generic_pm_domain_data *gpd_data, *pd_data;
> -       struct pm_domain_data *pdd;
> +       struct generic_pm_domain_data *gpd_data;
>         unsigned int prev;
> -       int ret = 0;
> +       int ret;
>
>         genpd = dev_to_genpd(dev);
>         if (IS_ERR(genpd))
> @@ -281,45 +330,11 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>         prev = gpd_data->performance_state;
>         gpd_data->performance_state = state;
>
> -       /* New requested state is same as Max requested state */
> -       if (state == genpd->performance_state)
> -               goto unlock;
> -
> -       /* New requested state is higher than Max requested state */
> -       if (state > genpd->performance_state)
> -               goto update_state;
> -
> -       /* Traverse all devices within the domain */
> -       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> -               pd_data = to_gpd_data(pdd);
> -
> -               if (pd_data->performance_state > state)
> -                       state = pd_data->performance_state;
> -       }
> -
> -       if (state == genpd->performance_state)
> -               goto unlock;
> -
> -       /*
> -        * We aren't propagating performance state changes of a subdomain to its
> -        * masters as we don't have hardware that needs it. Over that, the
> -        * performance states of subdomain and its masters may not have
> -        * one-to-one mapping and would require additional information. We can
> -        * get back to this once we have hardware that needs it. For that
> -        * reason, we don't have to consider performance state of the subdomains
> -        * of genpd here.
> -        */
> -
> -update_state:
> -       ret = genpd->set_performance_state(genpd, state);
> -       if (ret) {
> +       state = _genpd_reeval_performance_state(genpd, state);
> +       ret = _genpd_set_performance_state(genpd, state);
> +       if (ret)
>                 gpd_data->performance_state = prev;
> -               goto unlock;
> -       }
>
> -       genpd->performance_state = state;
> -
> -unlock:
>         genpd_unlock(genpd);
>
>         return ret;
> --
> 2.19.1.568.g152ad8e3369a
>
