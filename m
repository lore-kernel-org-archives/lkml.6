Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F95C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1EE213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtZkBfom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1EE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbeJLWpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:45:06 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55168 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeJLWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:45:06 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so19203313ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bSzyCGmCsstz+YQAG2MJWawzX5T5S/9q2X5C1g/8PQ0=;
        b=gtZkBfomJZAgzMRkrkccktrQYBOPf81hQjxJAymRqnDF3qBdaFEU6xLAL1wZRqFsk0
         IdB9CQyzmQM78Ea4fXRI17ngIbXk3LuRMfCwhw9u9piIoHTcDZOHLlbsSC7H43tU9tXB
         iDZdfxtBJ/oEZcjsvD0OBiYnnI1JO1IZPfeoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bSzyCGmCsstz+YQAG2MJWawzX5T5S/9q2X5C1g/8PQ0=;
        b=aMTUucrUxd+tKq8riS/EeGD2y6MNMSZx2lAjnF4yManUUSGJ0EgXcfSx7NLho5uhkw
         +RlujAstkF19M9HxbxiXo+d1rholy+/ODQS91iwapIshVzdiDxQt5OXWRPdFtiBce4sC
         CcOvn9klXDeZ5UPJI1DkVRqG5G75bfvZXZsxLv6XRgrHFD863Oi7lt5aUsQAJhLbdqra
         tDo5HTxxyD7MgL8eyX3AqUZl8vqBpAONxhGjPTL8lH9DN8xs4kQ35eP0xYYjj5P355jN
         umCcNNtB43LT1nylcvFbQqKSixabjqiKjhOPYOWVAqcCySLTaM/IWdSoNuDlbJU8co7L
         3p2Q==
X-Gm-Message-State: ABuFfojoZnbn3oLyiDS9xu90znhv3Ctrl1TQSgwQnXVkVp70Kb00n8/N
        WUaUe0RBQGO/cDTstLEydr0adUfs0qflyvpY8yAkcA==
X-Google-Smtp-Source: ACcGV63AkTVlQJNqlaN80tJLUFW1nCu60VhiDHBWoUBew5/t3HSailm2ihrMB+KAqY/appXQq2ykk0YLfaRp34lGCSI=
X-Received: by 2002:a24:6b4d:: with SMTP id v74-v6mr4819234itc.26.1539357130883;
 Fri, 12 Oct 2018 08:12:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 08:11:30
 -0700 (PDT)
In-Reply-To: <8e654324f879a04eb0c93493402520f024d2bc17.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <8e654324f879a04eb0c93493402520f024d2bc17.1539341929.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Oct 2018 17:11:30 +0200
Message-ID: <CAPDyKFpgcJ-VUpjYn5q+ut80BXe6S2ZAWVNoX2zBoLmzY9p_Fg@mail.gmail.com>
Subject: Re: [PATCH V2 2/9] OPP: Separate out custom OPP handler specific code
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 October 2018 at 13:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Create a separate routine to take care of custom set_opp() handler
> specific stuff.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/opp/core.c | 67 +++++++++++++++++++++++++++-------------------
>  1 file changed, 40 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2c2df4e4fc14..ebb3b648e0fd 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -635,6 +635,34 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
>         return ret;
>  }
>
> +static int _set_opp_custom(const struct opp_table *opp_table,
> +                          struct device *dev, unsigned long old_freq,
> +                          unsigned long freq,
> +                          struct dev_pm_opp_supply *old_supply,
> +                          struct dev_pm_opp_supply *new_supply)
> +{
> +       struct dev_pm_set_opp_data *data;
> +       int size;
> +
> +       data = opp_table->set_opp_data;
> +       data->regulators = opp_table->regulators;
> +       data->regulator_count = opp_table->regulator_count;
> +       data->clk = opp_table->clk;
> +       data->dev = dev;
> +
> +       data->old_opp.rate = old_freq;
> +       size = sizeof(*old_supply) * opp_table->regulator_count;
> +       if (IS_ERR(old_supply))
> +               memset(data->old_opp.supplies, 0, size);
> +       else
> +               memcpy(data->old_opp.supplies, old_supply, size);
> +
> +       data->new_opp.rate = freq;
> +       memcpy(data->new_opp.supplies, new_supply, size);
> +
> +       return opp_table->set_opp(data);
> +}
> +
>  /**
>   * dev_pm_opp_set_rate() - Configure new OPP based on frequency
>   * @dev:        device for which we do this operation
> @@ -649,7 +677,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>         unsigned long freq, old_freq;
>         struct dev_pm_opp *old_opp, *opp;
>         struct clk *clk;
> -       int ret, size;
> +       int ret;
>
>         if (unlikely(!target_freq)) {
>                 dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
> @@ -702,8 +730,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>         dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
>                 old_freq, freq);
>
> -       /* Only frequency scaling */
> -       if (!opp_table->regulators) {
> +       if (opp_table->set_opp) {
> +               ret = _set_opp_custom(opp_table, dev, old_freq, freq,
> +                                     IS_ERR(old_opp) ? NULL : old_opp->supplies,
> +                                     opp->supplies);
> +       } else if (opp_table->regulators) {
> +               ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
> +                                                IS_ERR(old_opp) ? NULL : old_opp->supplies,
> +                                                opp->supplies);
> +       } else {
> +               /* Only frequency scaling */
> +
>                 /*
>                  * We don't support devices with both regulator and
>                  * domain performance-state for now.
> @@ -714,30 +751,6 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>                                                       opp->pstate);
>                 else
>                         ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
> -       } else if (!opp_table->set_opp) {
> -               ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
> -                                                IS_ERR(old_opp) ? NULL : old_opp->supplies,
> -                                                opp->supplies);
> -       } else {
> -               struct dev_pm_set_opp_data *data;
> -
> -               data = opp_table->set_opp_data;
> -               data->regulators = opp_table->regulators;
> -               data->regulator_count = opp_table->regulator_count;
> -               data->clk = clk;
> -               data->dev = dev;
> -
> -               data->old_opp.rate = old_freq;
> -               size = sizeof(*opp->supplies) * opp_table->regulator_count;
> -               if (IS_ERR(old_opp))
> -                       memset(data->old_opp.supplies, 0, size);
> -               else
> -                       memcpy(data->old_opp.supplies, old_opp->supplies, size);
> -
> -               data->new_opp.rate = freq;
> -               memcpy(data->new_opp.supplies, opp->supplies, size);
> -
> -               ret = opp_table->set_opp(data);
>         }
>
>         dev_pm_opp_put(opp);
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
