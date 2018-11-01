Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC3EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3763120664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HJVMfI+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3763120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeKAL7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:59:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37990 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeKAL7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 07:59:43 -0400
Received: by mail-io1-f65.google.com with SMTP id q18-v6so11263088iod.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 19:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOSxRggcjUksRsOCf6mfNAeYLRROOH7cdOzQ/0UZTUk=;
        b=HJVMfI+jP8qwJ+T5gXrMmsDmI+ofJOL1Zc7zim6jzTGGjBzvvmdaAUYNxAcOCyoCZy
         l2BbePFTLM8Xe7YOYDtJVOQBYIZquZv0DLCEil4aRxYlAUlkJQ9UBUU4/DZysgJ5+GCR
         pRUeNr2la3NA+fWqclBbCtByJkyXS7UBZ8WCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOSxRggcjUksRsOCf6mfNAeYLRROOH7cdOzQ/0UZTUk=;
        b=mFrlTeOAOaB3C2XRK3WQcwkiUDOakEbSez4IqAwsAix/I/CdUToAbLf3hU1U4K8HIQ
         XVz8+YWzJSfwbV5iGmA2/vQICI5T/TwelzQVs1dWLoJzkWKrwNg+yKn/Om7Q6Am8oPiZ
         Vc0wL4ufVXd0Gr2GMbHg5uD+hLgKQe6jelnbz9hgti8RIDTJtLO23w3dTAnYtHVzKd5+
         CiD2PWK2+r0yoLT53Xp+/BRXV9MF0010nNjpCk3NgKpRuOUL474Y/UJrs5gMB7HNq1aJ
         4fn7qOZFKVPsnygzNp2pTBrL4FbdBDOwI0STDYdLWc5UG7VFPDOBFkurYFz5xfCzrZBX
         qZZw==
X-Gm-Message-State: AGRZ1gKU57fte9YI543hMwy6xvDW8gvQDyRKoWyGfzGAHi4ILq6JWGnt
        1E17hhIq03AfFtmXmKZWXh0famMJzC3UlQ82qOZOS8zj1HXY5A==
X-Google-Smtp-Source: AJdET5eZA+CWKB3xMB0hzxG9LyRzNKdrWtn4v/9O4XdnjqqJTf5GvP/0beC1RDChfnU77Yt0UhEG+fBV1EhpsBA/Ruc=
X-Received: by 2002:a6b:acc5:: with SMTP id v188-v6mr4363558ioe.66.1541041122644;
 Wed, 31 Oct 2018 19:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181024013132.115907-1-dbasehore@chromium.org> <20181024013132.115907-3-dbasehore@chromium.org>
In-Reply-To: <20181024013132.115907-3-dbasehore@chromium.org>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Wed, 31 Oct 2018 19:58:31 -0700
Message-ID: <CAGAzgsp-tuSAThRGPtGM98opK0pJ5OfmxB9tx+9VBuxT6rz3cA@mail.gmail.com>
Subject: Re: [PATCH 2/6] clk: fix clk_calc_subtree compute duplications
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 6:31 PM Derek Basehore <dbasehore@chromium.org> wrote:
>
> clk_calc_subtree was called at every step up the clk tree in
> clk_calc_new_rates. Since it recursively calls itself for its
> children, this means it would be called once on each clk for each
> step above the top clk is.
>
> This fixes this by breaking the subtree calculation into two parts.
> The first part recalcs the rate for each child of the parent clk in
> clk_calc_new_rates. This part is not recursive itself. The second part
> recursively calls a new clk_calc_subtree on the clk_core that was
> passed into clk_set_rate.
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/clk/clk.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 95d818f5edb2..61de8ad3e4cf 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1717,11 +1717,19 @@ static int __clk_speculate_rates(struct clk_core *core,
>         return ret;
>  }
>
> -static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
> -                            struct clk_core *new_parent, u8 p_index)
> +static void clk_calc_subtree(struct clk_core *core)
>  {
>         struct clk_core *child;
>
> +       hlist_for_each_entry(child, &core->children, child_node) {
> +               child->new_rate = clk_recalc(child, core->new_rate);
> +               clk_calc_subtree(child);
> +       }
> +}
> +
> +static void clk_set_change(struct clk_core *core, unsigned long new_rate,
> +                          struct clk_core *new_parent, u8 p_index)
> +{
>         core->new_rate = new_rate;
>         core->new_parent = new_parent;
>         core->new_parent_index = p_index;
> @@ -1729,11 +1737,6 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
>         core->new_child = NULL;
>         if (new_parent && new_parent != core->parent)
>                 new_parent->new_child = core;
> -
> -       hlist_for_each_entry(child, &core->children, child_node) {
> -               child->new_rate = clk_recalc(child, new_rate);
> -               clk_calc_subtree(child, child->new_rate, NULL, 0);
> -       }
>  }
>
>  /*
> @@ -1744,7 +1747,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
>                                            unsigned long rate)
>  {
>         struct clk_core *top = core;
> -       struct clk_core *old_parent, *parent;
> +       struct clk_core *old_parent, *parent, *child;
>         unsigned long best_parent_rate = 0;
>         unsigned long new_rate;
>         unsigned long min_rate;
> @@ -1791,6 +1794,8 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
>                 /* pass-through clock with adjustable parent */
>                 top = clk_calc_new_rates(parent, rate);
>                 new_rate = parent->new_rate;
> +               hlist_for_each_entry(child, &parent->children, child_node)
> +                       child->new_rate = clk_recalc(child, new_rate);
>                 goto out;
>         }
>
> @@ -1813,11 +1818,14 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
>         }
>
>         if ((core->flags & CLK_SET_RATE_PARENT) && parent &&
> -           best_parent_rate != parent->rate)
> +           best_parent_rate != parent->rate) {
>                 top = clk_calc_new_rates(parent, best_parent_rate);
> +               hlist_for_each_entry(child, &parent->children, child_node)
> +                       child->new_rate = clk_recalc(child, parent->new_rate);
> +       }
>
>  out:
> -       clk_calc_subtree(core, new_rate, parent, p_index);
> +       clk_set_change(core, new_rate, parent, p_index);
>
>         return top;
>  }
> @@ -2018,6 +2026,8 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>         if (ret)
>                 return ret;
>
> +       clk_calc_subtree(core);

This should be:
hlist_for_each_entry(child, core->new_parent? core->new_parent :
core->parent, child_node)
  clk_calc_subtree(child);

> +
>         /* notify that we are about to change rates */
>         fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
>         if (fail_clk) {
> --
> 2.19.1.568.g152ad8e336-goog
>
