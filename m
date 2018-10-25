Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4049C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997E62082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGjHI+lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997E62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJYT1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:27:32 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55985 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJYT1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:27:32 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so1092475itd.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fvo08d12bCoZ7G4p669cOQobeYejwLsNWhgfABG3FJA=;
        b=QGjHI+lmb8d0lwmdS8WckRObeO9X3BphURFzbX46OXCu0Jag3mI8a4gOaojT7ouNeO
         fbNknaFpIe8sRvp91aNjYLYOnL1a9YCIAURxApWQ6xPaVoozOagU1Ey3chfQ0UynYU27
         GBAzRRYdBaKMjaL7hhCeoKqWlexaer/7pXmAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fvo08d12bCoZ7G4p669cOQobeYejwLsNWhgfABG3FJA=;
        b=bWLt9HfVqchJqP1YgMlNsq4y4G1iRo9vXTxHy1FSR2s7o8tZEtQoF7NaxZZGvv2AxE
         Ku41xtQCy0Pq5SeWH7Z6UPLbLlkIst/CqnNTMHlBPGhvKjuHS/oM+W2vJ3zc7h9J7zuB
         zk//fPwJrqfPuFdVgQzuKffez5QQvWu0PoOPAP3Ee4tNScxoiDu6Bixn3hsmnj/RfH+Y
         MWuCy/+JeZfZjqwTY8Q55QRU2gxCAbY4DGG9kMujiMDNyj2+/t0sDwSdL+3P1TC/AjfS
         XHVih2evV78YgDeEvV7nZ6o+vF6tywHitSLmZW+WnQmwN7tvwy8GJGX6EGlLaB0gaq4a
         IiDA==
X-Gm-Message-State: AGRZ1gK6qdVCD5WNC3bbNCeg4H4DpQySUlcEAomV400gYDkwbSMggRa+
        4H8F3Nip7aShcdYDSwf7TxIHVII2J47upf7qG2LoPA==
X-Google-Smtp-Source: AJdET5c8N7NHtZZygJGgAFBSN8Ixuc9dRg6PHU7n3naCO2B8uNuu+qmctWputFg3GGYOgtW+yDJMwxEqRaXYrmTdzFU=
X-Received: by 2002:a24:6b4d:: with SMTP id v74-v6mr586394itc.26.1540464917813;
 Thu, 25 Oct 2018 03:55:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 03:54:37
 -0700 (PDT)
In-Reply-To: <e09b2960614c70e38347d52bd4093ab93af1da47.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org> <e09b2960614c70e38347d52bd4093ab93af1da47.1540446493.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Oct 2018 12:54:37 +0200
Message-ID: <CAPDyKFqrbMRjpf8Siy3-43q0Jd+mY1jo2N+uRaoDeaq9Q-5T2w@mail.gmail.com>
Subject: Re: [PATCH V3 06/10] PM / Domains: Add genpd_opp_to_performance_state()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 October 2018 at 07:52, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The OPP core currently stores the performance state in the consumer
> device's OPP table, but that is going to change going forward and
> performance state will rather be set directly in the genpd's OPP table.
>
> For that we need to get the performance state for genpd's device
> structure (genpd->dev) instead of the consumer device's structure. Add a
> new helper to do that.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  9 +++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index fe9b0527b161..7be8c94c6b7f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2520,6 +2520,38 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>
> +/**
> + * pm_genpd_opp_to_performance_state - Gets performance state of the genpd from its OPP node.
> + *
> + * @genpd_dev: Genpd's device for which the performance-state needs to be found.
> + * @opp: struct dev_pm_opp of the OPP for which we need to find performance
> + *     state.
> + *
> + * Returns performance state encoded in the OPP of the genpd. This calls
> + * platform specific genpd->opp_to_performance_state() callback to translate
> + * power domain OPP to performance state.
> + *
> + * Returns performance state on success and 0 on failure.
> + */
> +unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> +                                              struct dev_pm_opp *opp)
> +{
> +       struct generic_pm_domain *genpd = NULL;
> +       int state;
> +
> +       genpd = container_of(genpd_dev, struct generic_pm_domain, dev);
> +
> +       if (unlikely(!genpd->opp_to_performance_state))
> +               return 0;
> +
> +       genpd_lock(genpd);
> +       state = genpd->opp_to_performance_state(genpd, opp);
> +       genpd_unlock(genpd);
> +
> +       return state;
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_opp_to_performance_state);
> +
>  /**
>   * of_genpd_opp_to_performance_state- Gets performance state of device's
>   * power domain corresponding to a DT node's "required-opps" property.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 3b5d7280e52e..4f803f934308 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -258,6 +258,8 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent,
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>  int of_genpd_parse_idle_states(struct device_node *dn,
>                                struct genpd_power_state **states, int *n);
> +unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> +                                              struct dev_pm_opp *opp);
>  unsigned int of_genpd_opp_to_performance_state(struct device *dev,
>                                 struct device_node *np);
>
> @@ -299,6 +301,13 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
>         return -ENODEV;
>  }
>
> +static inline unsigned int
> +pm_genpd_opp_to_performance_state(struct device *genpd_dev,
> +                                 struct dev_pm_opp *opp)
> +{
> +       return 0;
> +}
> +
>  static inline unsigned int
>  of_genpd_opp_to_performance_state(struct device *dev,
>                                   struct device_node *np)
> --
> 2.19.1.568.g152ad8e3369a
>
