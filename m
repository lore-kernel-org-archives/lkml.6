Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6EAECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8DF20833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VaTHNXwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8DF20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbeJYExZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:53:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46289 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeJYExZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:53:25 -0400
Received: by mail-io1-f66.google.com with SMTP id y22-v6so3978421ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1WVKsPq34LDynxmlYTtr5sMoaPQVZF85kQveofLdkg=;
        b=VaTHNXwPyp0Vq3w5SwGjMDZ+H36Lz1jdUqnaMeGzW0kBv8e6LyaYojVu6wg0LmWvTj
         oHFI5unrEam8JSw9Ejy2rnxqHECNQroKW7fIaWcHESDZmN2BkoxkKBgtE68Of7G42sja
         gmBcd3dsZ73RtO4AwdoI35oLmA/p604YjsZq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1WVKsPq34LDynxmlYTtr5sMoaPQVZF85kQveofLdkg=;
        b=GPAIrZBE1r33CEY7Nxk9ztK9kkB1UbdNP/KjhGScSxxDBrwlI1ASHegSBd/caov09P
         eyaSrT99PPrgHI56c6e64WWGn89HM3432oY5209/+UJGUB7Wczj2kYDAzt87rsozpo9V
         i3/zQ3YfjiXhtbYc9lMXYA8phv00PwytoiNq3rRzwB5zorPTb8OOsnwvhU4MuWdpzTn5
         ArX/DmY0YQ3ZExnQOYKzU+YvPUP2EztlTzEwieljkHq2ihdLuf6vgO52cmKMWNNKNB0J
         cvb8mLTKaPzYp22t1V14HURvrQlhtxu8fKdg+JNlzzS6pWakl4MjXXUuRXayLkMjfpmG
         Xp+w==
X-Gm-Message-State: AGRZ1gJQa2MyrKU2B9uiUcFgmXXAlAPfhP0ZDnKTWeyzQZceB6h/8cyH
        5PmUhDdBaCVqpdDrP77jjRkOkfdbYKBBJ73vemaJvcK+d/0=
X-Google-Smtp-Source: AJdET5dcNF2q/whRrjYpyegewTASljsPY43b2eyiH439IIGwgW3Lf2m4rOIDOYfrv5+afg+q+GX9Q96zPsT+aGa6nIk=
X-Received: by 2002:a6b:bf43:: with SMTP id p64-v6mr14039651iof.41.1540412633300;
 Wed, 24 Oct 2018 13:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181024013132.115907-1-dbasehore@chromium.org>
 <20181024013132.115907-2-dbasehore@chromium.org> <264adf2a81bcd602f2a58e4a46c3273cd7c77ca2.camel@baylibre.com>
 <CAGAzgspHFiuUpfTjD5v9-U=yAxwkBnZh3Mwtaom4wsiO-Bcfgw@mail.gmail.com>
In-Reply-To: <CAGAzgspHFiuUpfTjD5v9-U=yAxwkBnZh3Mwtaom4wsiO-Bcfgw@mail.gmail.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Wed, 24 Oct 2018 13:23:42 -0700
Message-ID: <CAGAzgspQg4_TVLi9XLGFaFHbOo2fuduihajud4GtA5cDu1v+5w@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: Remove recursion in clk_core_{prepare,enable}()
To:     jbrunet@baylibre.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:15 PM dbasehore . <dbasehore@chromium.org> wrote:
>
> On Wed, Oct 24, 2018 at 2:51 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> >
> > On Tue, 2018-10-23 at 18:31 -0700, Derek Basehore wrote:
> > > From: Stephen Boyd <sboyd@codeaurora.org>
> > >
> > > Enabling and preparing clocks can be written quite naturally with
> > > recursion. We start at some point in the tree and recurse up the
> > > tree to find the oldest parent clk that needs to be enabled or
> > > prepared. Then we enable/prepare and return to the caller, going
> > > back to the clk we started at and enabling/preparing along the
> > > way.
> > >
> > > The problem is recursion isn't great for kernel code where we
> > > have a limited stack size. Furthermore, we may be calling this
> > > code inside clk_set_rate() which also has recursion in it, so
> > > we're really not looking good if we encounter a tall clk tree.
> > >
> > > Let's create a stack instead by looping over the parent chain and
> > > collecting clks of interest. Then the enable/prepare becomes as
> > > simple as iterating over that list and calling enable.
> >
> > Hi Derek,
> >
> > What about unprepare() and disable() ?
> >
> > This patch removes the recursion from the enable path but keeps it for the
> > disable path ... this is very odd. Assuming doing so works, It certainly makes
> > CCF a lot harder to understand.
> >
> > What about clock protection which essentially works on the same model as prepare
> > and enable ?
> >
> > Overall, this change does not look like something that should be merged as it
> > is. If you were just seeking comments, you should add the "RFC" tag to your
> > series.
> >
> > Jerome.
> >
> > >
> > > Cc: Jerome Brunet <jbrunet@baylibre.com>
> >
> > If you don't mind, I would prefer to get the whole series next time. It helps to
> > get the context.
> >
> > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > ---
> > >  drivers/clk/clk.c | 113 ++++++++++++++++++++++++++--------------------
> > >  1 file changed, 64 insertions(+), 49 deletions(-)
> > >
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index af011974d4ec..95d818f5edb2 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -71,6 +71,8 @@ struct clk_core {
> > >       struct hlist_head       children;
> > >       struct hlist_node       child_node;
> > >       struct hlist_head       clks;
> > > +     struct list_head        prepare_list;
> > > +     struct list_head        enable_list;
> > >       unsigned int            notifier_count;
> > >  #ifdef CONFIG_DEBUG_FS
> > >       struct dentry           *dentry;
> > > @@ -740,49 +742,48 @@ EXPORT_SYMBOL_GPL(clk_unprepare);
> > >  static int clk_core_prepare(struct clk_core *core)
> > >  {
> > >       int ret = 0;
> > > +     struct clk_core *tmp, *parent;
> > > +     LIST_HEAD(head);
> > >
> > >       lockdep_assert_held(&prepare_lock);
> > >
> > > -     if (!core)
> > > -             return 0;
> > > +     while (core) {
> > > +             list_add(&core->prepare_list, &head);
> > > +             /* Stop once we see a clk that is already prepared */
> > > +             if (core->prepare_count)
> > > +                     break;
> > > +             core = core->parent;
> > > +     }
> > >
> > > -     if (core->prepare_count == 0) {
> > > -             ret = clk_pm_runtime_get(core);
> > > -             if (ret)
> > > -                     return ret;
> > > +     list_for_each_entry_safe(core, tmp, &head, prepare_list) {
> > > +             list_del_init(&core->prepare_list);
> >
> > Is there any point in removing it from the list ?
> > Maybe I missed it but it does not seems useful.
> >
> > Without this, we could use list_for_each_entry()
> >
> > >
> > > -             ret = clk_core_prepare(core->parent);
> > > -             if (ret)
> > > -                     goto runtime_put;
> > > +             if (core->prepare_count == 0) {
> >
> > Should we really check the count here ? You are not checking the count when the
> > put() counterpart is called below.
>
> I think I accidentally messed that up when I picked up the patch.
> There were some merge conflicts with the addition of the
> clk_pm_runtime code.
>
> >
> > Since PM runtime has ref counting as well, either way would work I guess ... but
> > we shall be consistent
> >
> > > +                     ret = clk_pm_runtime_get(core);
> > > +                     if (ret)
> > > +                             goto err;
> > >
> > > -             trace_clk_prepare(core);
> > > +                     trace_clk_prepare(core);
> > >
> > > -             if (core->ops->prepare)
> > > -                     ret = core->ops->prepare(core->hw);
> > > +                     if (core->ops->prepare)
> > > +                             ret = core->ops->prepare(core->hw);
> > >
> > > -             trace_clk_prepare_complete(core);
> > > +                     trace_clk_prepare_complete(core);
> > >
> > > -             if (ret)
> > > -                     goto unprepare;
> > > +                     if (ret) {
> > > +                             clk_pm_runtime_put(core);
> > > +                             goto err;
> > > +                     }
> > > +             }
> > > +             core->prepare_count++;
> > >       }
> > >
> > > -     core->prepare_count++;
> > > -
> > > -     /*
> > > -      * CLK_SET_RATE_GATE is a special case of clock protection
> > > -      * Instead of a consumer claiming exclusive rate control, it is
> > > -      * actually the provider which prevents any consumer from making any
> > > -      * operation which could result in a rate change or rate glitch while
> > > -      * the clock is prepared.
> > > -      */
> > > -     if (core->flags & CLK_SET_RATE_GATE)
> > > -             clk_core_rate_protect(core);
> >
> > This gets removed without anything replacing it.
> >
> > is CLK_SET_RATE_GATE and clock protection support dropped after this change ?
>
> No, I think I just accidentally removed this when resolving conflicts.
>
> >
> > > -
> > >       return 0;
> > > -unprepare:
> > > -     clk_core_unprepare(core->parent);
> > > -runtime_put:
> > > -     clk_pm_runtime_put(core);
> > > +err:
> > > +     parent = core->parent;
> > > +     list_for_each_entry_safe_continue(core, tmp, &head, prepare_list)
> > > +             list_del_init(&core->prepare_list);
> > > +     clk_core_unprepare(parent);
> >
> > If you get here because of failure clk_pm_runtime_get(), you will unprepare a
> > clock which may have not been prepared first
> >
> > Overall the rework of error exit path does not seem right (or necessary)
> >
>
> Yeah, all of this seems to just be a poor resolution of patch
> conflicts on my part. Will fix.
>

Actually, I think that the rework of the error exit path makes sense
since the prior exit path was for the recursive case, not the list
iteration case. I will fix the issue where we call clk_core_unprepare
when it shouldn't, though.

> > >       return ret;
> > >  }
> > >
> > > @@ -878,37 +879,49 @@ EXPORT_SYMBOL_GPL(clk_disable);
> > >  static int clk_core_enable(struct clk_core *core)
> > >  {
> > >       int ret = 0;
> > > +     struct clk_core *tmp, *parent;
> > > +     LIST_HEAD(head);
> > >
> > >       lockdep_assert_held(&enable_lock);
> > >
> > > -     if (!core)
> > > -             return 0;
> > > -
> > > -     if (WARN(core->prepare_count == 0,
> > > -         "Enabling unprepared %s\n", core->name))
> > > -             return -ESHUTDOWN;
> > > +     while (core) {
> > > +             list_add(&core->enable_list, &head);
> > > +             /* Stop once we see a clk that is already enabled */
> > > +             if (core->enable_count)
> > > +                     break;
> > > +             core = core->parent;
> > > +     }
> > >
> > > -     if (core->enable_count == 0) {
> > > -             ret = clk_core_enable(core->parent);
> > > +     list_for_each_entry_safe(core, tmp, &head, enable_list) {
> > > +             list_del_init(&core->enable_list);
> > >
> > > -             if (ret)
> > > -                     return ret;
> > > +             if (WARN_ON(core->prepare_count == 0)) {
> > > +                     ret = -ESHUTDOWN;
> > > +                     goto err;
> > > +             }
> > >
> > > -             trace_clk_enable_rcuidle(core);
> > > +             if (core->enable_count == 0) {
> > > +                     trace_clk_enable_rcuidle(core);
> > >
> > > -             if (core->ops->enable)
> > > -                     ret = core->ops->enable(core->hw);
> > > +                     if (core->ops->enable)
> > > +                             ret = core->ops->enable(core->hw);
> > >
> > > -             trace_clk_enable_complete_rcuidle(core);
> > > +                     trace_clk_enable_complete_rcuidle(core);
> > >
> > > -             if (ret) {
> > > -                     clk_core_disable(core->parent);
> > > -                     return ret;
> > > +                     if (ret)
> > > +                             goto err;
> > >               }
> > > +
> > > +             core->enable_count++;
> > >       }
> > >
> > > -     core->enable_count++;
> > >       return 0;
> > > +err:
> > > +     parent = core->parent;
> > > +     list_for_each_entry_safe_continue(core, tmp, &head, enable_list)
> > > +             list_del_init(&core->enable_list);
> > > +     clk_core_disable(parent);
> > > +     return ret;
> > >  }
> > >
> > >  static int clk_core_enable_lock(struct clk_core *core)
> > > @@ -3281,6 +3294,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
> > >       core->num_parents = hw->init->num_parents;
> > >       core->min_rate = 0;
> > >       core->max_rate = ULONG_MAX;
> > > +     INIT_LIST_HEAD(&core->prepare_list);
> > > +     INIT_LIST_HEAD(&core->enable_list);
> > >       hw->core = core;
> > >
> > >       /* allocate local copy in case parent_names is __initdata */
> >
> >
