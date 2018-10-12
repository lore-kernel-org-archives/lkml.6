Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5FBC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9BA2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGVDEnPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9BA2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeJLWpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:45:01 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50797 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbeJLWpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:45:01 -0400
Received: by mail-it1-f195.google.com with SMTP id k206-v6so13121617ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nITRR3k5gq55IMNj95L99RcsiAscLip2fQb0dSg5jQk=;
        b=VGVDEnPx5Yq+O66xTn4qHFqOdSbcAW0XIRDGgxbmoLFTHXr/7vnBv2xFxnzbe7Xbqw
         5baR3TfAr5NP1OxoagXicIz2B+Q+d73QW7+qPvJ1cigU8mMeUYYBSVtU1jI3RiTsHEda
         vm8D6SpD5HRXW8+lVi9slbMfTa+Tl7ykabk8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nITRR3k5gq55IMNj95L99RcsiAscLip2fQb0dSg5jQk=;
        b=PvzjQZQhvHIk8eP7+ymeWlxSA0uaD1vzPACHnCNpoW0e1TpBVHoh4p/iPpTCvwi7Gm
         81B7+r4qTCH+pXTtgLjtNW+LPk4GCqenL10ncoIvGkLg/3VgRGvfmfNvVrnyeMzzPAu1
         jHlwrWPxNz6LqQ7idrOBBm1k/vfZJZ3Ro09SzhvwDVDxFp4Oyast13BJQKVi6hp2lBoL
         I2yF5FSQ87kDrwsqza2u6QQgBn0TI/m26cQXTHMyLx2xa9tK0i2XZlHUu7+v2X3oLu9z
         xEZE89IqpqFvwq42UEppdP5f9hf6M15pbW0j6lco9nEx9ftq22PUXKGQQXKD/ny7i78G
         OJVA==
X-Gm-Message-State: ABuFfohMUz19aiNm8Co86wWHpa1brU9TkefdstcrNS78DXtfBWDvVi1/
        NuZiTdFIq+3GN/uEFUhtp6fGZi4ouPlbfzrcfHyRgA==
X-Google-Smtp-Source: ACcGV619A2NgdiXuWpU9SH3VZPgOC0QfmvPtZKm43cSXvWiFq34gA6jH2Giir/wN8F2Iq6mPjfnJDGplnItH3HjJwkE=
X-Received: by 2002:a24:4795:: with SMTP id t143-v6mr4836438itb.78.1539357125924;
 Fri, 12 Oct 2018 08:12:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 08:11:25
 -0700 (PDT)
In-Reply-To: <8130f5e3128fbd0dd34b02dbca9cde2b042d2494.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <8130f5e3128fbd0dd34b02dbca9cde2b042d2494.1539341929.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Oct 2018 17:11:25 +0200
Message-ID: <CAPDyKFrKCDnc_0fXFKpzzUJrvNx4QHft1FmHBWN26Z1v6e1FRA@mail.gmail.com>
Subject: Re: [PATCH V2 1/9] OPP: Identify and mark genpd OPP tables
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
> We need to handle genpd OPP tables differently, this is already the case
> at one location and will be extended going forward. Add another field to
> the OPP table to check if the table belongs to a genpd or not.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/opp/of.c  | 6 ++++--
>  drivers/opp/opp.h | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 5a4b47958073..5f114cd3d88c 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -92,6 +92,9 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
>         of_property_read_u32(np, "voltage-tolerance",
>                              &opp_table->voltage_tolerance_v1);
>
> +       if (of_find_property(np, "#power-domain-cells", NULL))
> +               opp_table->is_genpd = true;
> +
>         /* Get OPP table node */
>         opp_np = _opp_of_get_opp_desc_node(np, index);
>         of_node_put(np);
> @@ -326,8 +329,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>         ret = of_property_read_u64(np, "opp-hz", &rate);
>         if (ret < 0) {
>                 /* "opp-hz" is optional for devices like power domains. */
> -               if (!of_find_property(dev->of_node, "#power-domain-cells",
> -                                     NULL)) {
> +               if (!opp_table->is_genpd) {
>                         dev_err(dev, "%s: opp-hz not found\n", __func__);
>                         goto free_opp;
>                 }
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 9c6544b4f4f9..cdb0c2b095e2 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -140,6 +140,7 @@ enum opp_table_access {
>   * @regulators: Supply regulators
>   * @regulator_count: Number of power supply regulators
>   * @genpd_performance_state: Device's power domain support performance state.
> + * @is_genpd: Marks if the OPP table belongs to a genpd.
>   * @set_opp: Platform specific set_opp callback
>   * @set_opp_data: Data to be passed to set_opp callback
>   * @dentry:    debugfs dentry pointer of the real device directory (not links).
> @@ -178,6 +179,7 @@ struct opp_table {
>         struct regulator **regulators;
>         unsigned int regulator_count;
>         bool genpd_performance_state;
> +       bool is_genpd;
>
>         int (*set_opp)(struct dev_pm_set_opp_data *data);
>         struct dev_pm_set_opp_data *set_opp_data;
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
