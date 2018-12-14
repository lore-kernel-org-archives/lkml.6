Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6473C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B20B20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M63xiEdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B20B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeLNKlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:41:14 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36438 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeLNKlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:41:14 -0500
Received: by mail-vs1-f68.google.com with SMTP id v205so3090676vsc.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThwQm9PelqlP9qLVsY5zCNAPR9ah2r4BHisRoLeS7lo=;
        b=M63xiEdmiNn7Mcx6otub/UIkdS4co1WDfu2S2IdwoUQPJB7ZZEtPlS2Upu4NyUSnvM
         pkF3Ar98em64JBCFSkwiw0XK9Y3sdWypBrWKcju0vEXIROaAW0JkH+5/xMFDF2n63l5u
         Fqb1Nk+OZ3YJB7G2nm20E1LhzG6qzJKG7iqtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThwQm9PelqlP9qLVsY5zCNAPR9ah2r4BHisRoLeS7lo=;
        b=Q4xpwsQR69mB6R9HW0sw8BLrlg3J2qonuI7mmubmSQBBTwEBah9qZ+9MxI+2o0dHTM
         1NqXYg4ykTOa+WWlyKxtTf3877TdizKQBM1GUzgJCnaqGmZY1G/ZPelyNa14BAZROFU4
         sfmO4gZyX2aFzXNpgC+MNWAqaxJuwpVHNUYWKUhU+sEL3GwEPzvb90g5ucg6NB1WAzw8
         oWGE/1w1mMZYGZvfWKuxBu6+iahlsLewqw/E/YuLmh6QEQ8jamk1H49BYXftoQOXIKFF
         REnZj9N9nU2h9J8Dy87POLceXn0abcPtnvYafP2zaFKupezLN6HwHe2I3kIw8hOZXNGM
         Tlmg==
X-Gm-Message-State: AA+aEWZhJqu/WyYEWelbNn26Sm3kDxq5adCgm9655pSNSoT2gi/kV6Gg
        Oz1zNWRTSn9r0k1MTIYLgzPkRnAkzQPbGb2J4Av1CQ==
X-Google-Smtp-Source: AFSGD/VR+lzqYILdQ0l6BJiyZRKecoWDcdBkb3ExPONydpAcFrT3ylYyivQzw09YdaYPJJBeBP3yKmHJkr1FoVnwzRU=
X-Received: by 2002:a67:b245:: with SMTP id s5mr1046509vsh.200.1544784072578;
 Fri, 14 Dec 2018 02:41:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544782279.git.viresh.kumar@linaro.org> <184bbc28f982752cc040f0b9286516c3897e2808.1544782279.git.viresh.kumar@linaro.org>
In-Reply-To: <184bbc28f982752cc040f0b9286516c3897e2808.1544782279.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Dec 2018 11:40:36 +0100
Message-ID: <CAPDyKFret-vV-jSMYtJD1JFDak6HB+xShn8ps0y337EhycGs5Q@mail.gmail.com>
Subject: Re: [PATCH V4 2/7] OPP: Improve _find_table_of_opp_np()
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
> Make _find_table_of_opp_np() more efficient by using of_get_parent() to
> find the parent OPP table node.
>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/opp/of.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 3ef7f38c0986..8e57d257be77 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -114,19 +114,25 @@ static struct device_node *of_parse_required_opp(struct device_node *np,
>  static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
>  {
>         struct opp_table *opp_table;
> -       struct dev_pm_opp *opp;
> +       struct device_node *opp_table_np;
>
>         lockdep_assert_held(&opp_table_lock);
>
> +       opp_table_np = of_get_parent(opp_np);
> +       if (!opp_table_np)
> +               goto err;
> +
> +       /* It is safe to put the node now as all we need now is its address */
> +       of_node_put(opp_table_np);
> +
>         list_for_each_entry(opp_table, &opp_tables, node) {
> -               opp = _find_opp_of_np(opp_table, opp_np);
> -               if (opp) {
> -                       dev_pm_opp_put(opp);
> +               if (opp_table_np == opp_table->np) {
>                         _get_opp_table_kref(opp_table);
>                         return opp_table;
>                 }
>         }
>
> +err:
>         return ERR_PTR(-ENODEV);
>  }
>
> --
> 2.19.1.568.g152ad8e3369a
>
