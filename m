Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875EFC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455EA2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5XWNjTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455EA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeK3UEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:04:11 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34114 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeK3UEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:04:11 -0500
Received: by mail-vs1-f67.google.com with SMTP id y27so2903292vsi.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSW0OlWBH8S+iMQjSC01IBBxDcw19Hjzm68ERef9VoI=;
        b=U5XWNjTzaJst2uXATS28knnTxudRRCQ3LzPVxQrTqs4oAEsxYoeYvjv7OCKNK/vuF0
         mXvftba4rQDy8ywMHXJFhADecwakE3qeo/7qoK84b44tnXLzoa1yIVr5VfwN2R1hBTJq
         5Ggi6dPunk21AM94s68srSMyn7tSWs0Au0qQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSW0OlWBH8S+iMQjSC01IBBxDcw19Hjzm68ERef9VoI=;
        b=WbxbluxjpOmfRc9jGXoAOZMq50N3cgIq49nyyJNwzqBAoKxSIyUjWYMKwSbgtHHw0t
         f+R4a8YzABvu4T9KWUBEc9xxiFRKXhC6+FIcLxMPzXoUWvrm/jNp2NLpuJ0lPYZL6D+j
         H9hoHvoIIPiKgjqYaridPT3GITOdTvf04FB9ndjY0l2Yb6+FIdW1Ch04EcqtD73GneS8
         ezJe8jYgWinTFR/97FnuCVfy64TqpdfoX1s2I8olsqaLOq3X27nVegpkpWavctJp/Orx
         vD1/f9zBDe1TFrUqKZmi2d8wFHCHgghz73YUwqGgzkuDMp3Ss5Oe/OD8ohhRcRXARCis
         zy1A==
X-Gm-Message-State: AA+aEWYO0PHKXhxFCle2A7UW+Y7UDviDSXqyGnD+cFe50W04+Zq+IuiP
        E7Cy2ABfi0XzJcBNVD+cPqGyabYoKuPW7LbwbPIYmA==
X-Google-Smtp-Source: AFSGD/UsnlL/mk4d92rleWj0e5s6xFP3Yq6aKLBTJkemlcKidizSqkhUU/G9M+DvdGAH/0+MmZ0kdXzDbpoBhGFdh6M=
X-Received: by 2002:a67:b245:: with SMTP id s5mr2181038vsh.200.1543568134536;
 Fri, 30 Nov 2018 00:55:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543219386.git.viresh.kumar@linaro.org> <401e29cb9e8d762e076253220f4a5dc22464e9fa.1543219386.git.viresh.kumar@linaro.org>
In-Reply-To: <401e29cb9e8d762e076253220f4a5dc22464e9fa.1543219386.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Nov 2018 09:54:58 +0100
Message-ID: <CAPDyKFroPQBwx1ryYor=Zo9xdmHAsboSffWi7Dq_5g-Xs8SVwQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] PM / Domains: Factorize dev_pm_genpd_set_performance_state()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 at 09:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Separate out _genpd_set_performance_state() and
> _genpd_reeval_performance_state() from
> dev_pm_genpd_set_performance_state() to handle performance state update
> related stuff. This will be used by a later commit.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 105 +++++++++++++++++++++---------------
>  1 file changed, 62 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0d928359b880..d6b389a9f678 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -239,6 +239,63 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
>  static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>  #endif
>
> +static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> +                                       unsigned int state)
> +{
> +       int ret;
> +
> +       ret = genpd->set_performance_state(genpd, state);
> +       if (ret)
> +               return ret;
> +
> +       genpd->performance_state = state;
> +       return 0;
> +}
> +
> +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> +                                          unsigned int state)
> +{
> +       struct generic_pm_domain_data *pd_data;
> +       struct pm_domain_data *pdd;
> +
> +       /* New requested state is same as Max requested state */
> +       if (state == genpd->performance_state)
> +               return 0;
> +
> +       /* New requested state is higher than Max requested state */
> +       if (state > genpd->performance_state)
> +               goto update_state;
> +
> +       /* Traverse all devices within the domain */
> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +               pd_data = to_gpd_data(pdd);
> +
> +               if (pd_data->performance_state > state)
> +                       state = pd_data->performance_state;
> +       }
> +
> +       if (state == genpd->performance_state)
> +               return 0;
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
> +
> +update_state:
> +       if (!genpd_status_on(genpd)) {
> +               genpd->performance_state = state;
> +               return 0;
> +       }
> +
> +       return _genpd_set_performance_state(genpd, state);
> +}
> +
>  /**
>   * dev_pm_genpd_set_performance_state- Set performance state of device's power
>   * domain.
> @@ -257,10 +314,9 @@ static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
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
> @@ -281,47 +337,10 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
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
> -       if (genpd_status_on(genpd)) {
> -               ret = genpd->set_performance_state(genpd, state);
> -               if (ret) {
> -                       gpd_data->performance_state = prev;
> -                       goto unlock;
> -               }
> -       }
> -
> -       genpd->performance_state = state;
> +       ret = _genpd_reeval_performance_state(genpd, state);
> +       if (ret)
> +               gpd_data->performance_state = prev;
>
> -unlock:
>         genpd_unlock(genpd);
>
>         return ret;
> --
> 2.19.1.568.g152ad8e3369a
>
