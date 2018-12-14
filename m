Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A5FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6613720892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbUlvptV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6613720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbeLNKlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:41:22 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45940 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeLNKlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:41:21 -0500
Received: by mail-vs1-f67.google.com with SMTP id v10so3063088vsv.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6uoNJ4U6tg3cb4S54JZ2fhLpeBOiPp/1FRNipxql+s=;
        b=PbUlvptVx91O+n3XyMgFbfc5AlTN8UqD4v9tdY/Th+K6/KF+awGcuUIgAsondvxvC6
         lxYcw6FCDdMrWu26/FNDB5DWtvjZNo3SpRQIltcid191v45CPSJZyl+aAlPgLzAkNUL6
         CDRU3k9y3cgR4U+qEAnbgk8+IPgfn0KlbANuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6uoNJ4U6tg3cb4S54JZ2fhLpeBOiPp/1FRNipxql+s=;
        b=Ud3qKjjjgzqlUV2g+yNx/iaIVvvjeF3d9Bp4lMPgVtSqfnQx3uQSxpSdqPeSdmaRfZ
         oLS3GhQm2Qxr7r1zqknHkXoDW6eZZwuLDLcYT4Glx8HHg8LCoQydeIIhsVkTHVPvelb5
         yNLxGhjVX8u6bYAiG5709rI26wHxlO7zdyd+AyHCo1TKcXBHhj/a1VjV4Dy8xx1GInPR
         /opF6zaP5DMNiQvQfMWOlOPiVRpaM5yllb2k4WSXmlN8Toq0KIS+n0/LW4omv2Ce2mfu
         VOwKL8Q0wN2t28i3YclLqQ3hOmZkizz0y1YOKn1znMI7J76WudrhoxcxgSOupAiuOIso
         s7lA==
X-Gm-Message-State: AA+aEWZAvfsXgck4rfYp9QBav6qC0lMIrLADEuLYzFRvzsClKbDqsVpr
        sMV3FjUR7/ZoalPKta0K2Ld1Zccm+CuX3YlUIqhx7w==
X-Google-Smtp-Source: AFSGD/VuLQ/XjyduHapm9crDsHWuoeYn3zDe5ylE72HdD6R3zsNWQSgyyQ1Gki5OU5MdU8UrdWqEwxJXI+TDhtc3k0o=
X-Received: by 2002:a67:e002:: with SMTP id c2mr1062943vsl.34.1544784080303;
 Fri, 14 Dec 2018 02:41:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544782279.git.viresh.kumar@linaro.org> <b8efe7f3f52c7d5736df279173467cd6c40f28d2.1544782279.git.viresh.kumar@linaro.org>
In-Reply-To: <b8efe7f3f52c7d5736df279173467cd6c40f28d2.1544782279.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Dec 2018 11:40:44 +0100
Message-ID: <CAPDyKFr9RW6G-Nj994w_F_quQNWOZiXTbOBGtjKPACaYLap-kg@mail.gmail.com>
Subject: Re: [PATCH V4 4/7] OPP: Don't return 0 on error from of_get_required_opp_performance_state()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
> of_get_required_opp_performance_state() returns 0 on errors currently
> and a positive performance state otherwise. Since 0 is a valid
> performance state (representing off), it would be better if this routine
> returns negative values on error.
>
> That will also make it behave similar to
> dev_pm_opp_xlate_performance_state(), which also returns performance
> states and returns negative values on error. Change the return type of
> the function to "int" in order to return negative values.
>
> This doesn't have any users for now and so no other part of the kernel
> will be impacted with this change.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/opp/of.c       | 10 +++++-----
>  include/linux/pm_opp.h |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 8e57d257be77..68b512846d72 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -995,19 +995,19 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
>   * Returns the performance state of the OPP pointed out by the "required-opps"
>   * property at @index in @np.
>   *
> - * Return: Positive performance state on success, otherwise 0 on errors.
> + * Return: Zero or positive performance state on success, otherwise negative
> + * value on errors.
>   */
> -unsigned int of_get_required_opp_performance_state(struct device_node *np,
> -                                                  int index)
> +int of_get_required_opp_performance_state(struct device_node *np, int index)
>  {
>         struct dev_pm_opp *opp;
>         struct device_node *required_np;
>         struct opp_table *opp_table;
> -       unsigned int pstate = 0;
> +       int pstate = -EINVAL;
>
>         required_np = of_parse_required_opp(np, index);
>         if (!required_np)
> -               return 0;
> +               return -EINVAL;
>
>         opp_table = _find_table_of_opp_np(required_np);
>         if (IS_ERR(opp_table)) {
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 0b04c2093eb9..0a2a88e5a383 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -321,7 +321,7 @@ void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
>  int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
> -unsigned int of_get_required_opp_performance_state(struct device_node *np, int index);
> +int of_get_required_opp_performance_state(struct device_node *np, int index);
>  #else
>  static inline int dev_pm_opp_of_add_table(struct device *dev)
>  {
> @@ -360,9 +360,9 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  {
>         return NULL;
>  }
> -static inline unsigned int of_get_required_opp_performance_state(struct device_node *np, int index)
> +static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
>  {
> -       return 0;
> +       return -ENOTSUPP;
>  }
>  #endif
>
> --
> 2.19.1.568.g152ad8e3369a
>
