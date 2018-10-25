Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C32EECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0756420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZUYI/lOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0756420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJYQoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:44:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41183 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeJYQoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:44:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id q7-v6so8265425wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KTeD11N2vcL/PBm+5Cn40Nag7y2olhmRH2A174v2JwI=;
        b=ZUYI/lOodPJNRh4rvtYLxhpm9HoF/T9tHT8GaJeVU38UnMrD3Dpk3wBixblysQLUWK
         QZAqe9I1cy2CM7dX3ynWGGqfJgGwif54gFfPlSD7yh7PQwhdvLnoceWriU6o5UI7hOiP
         HUFEqZMpKwVxz18QwI/2RVT4T4Tf8Gu09GvCrMFKrsAtNpIMC9u0lijqasb8nexk6NJl
         DrH7WZxqJoJcQ4+IuB0WD+wGdGPofWpK/KNijXgZx260FHU+iptX9DpaAMgenfVKihXw
         k6oQ4Aj8VQDR0O2grpKU1BDLwRW3J6h2Yuo++H9xUTW/KgXteTuAO+WoweXuNTJBVWTQ
         umbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KTeD11N2vcL/PBm+5Cn40Nag7y2olhmRH2A174v2JwI=;
        b=Fc0nkoPnn8qRueey/6IJQvzK46JZ0HWQbbNpWB4L7Lgd/NEmR/fVQi3CVTguEkG3V4
         gRWAt6gP4A60PkDu2tkxSlf7+lw39x9vBqGQaoDANYA5JNPzKkf3nV+rpgxQaIxcQkVj
         MRmi84tjb7qen5nEjNxsXPwcPqF3b8R35+HveCPOuyqXXG0UWV5Iy6N0bwK/Bpcfq+fg
         W31vfK6OaLn12FzkeyJWiEBASEI/w95sfgf/bHdfRH8Gunrogcp6Bf6bT8/KsZMUSfxn
         mqQy8kJWDe61c98zIHaOmkT1dz+LLtjf9WOUGvg47fHvHrUdPzfii9wLtSvX/V0jWiYj
         sFnA==
X-Gm-Message-State: AGRZ1gLT/TgbXunWkVO7b+ywT9AgG16hliLJpORi6Q1zjXgS82vUWgqi
        88qXKDHZEI5wAggR75cCwDS2KA==
X-Google-Smtp-Source: AJdET5eXT95pfSOQR0BYwdKGhUatqUlkCZpG7RLdQyouuYNMG35Ej2s1Gv3K92/eAiAwl68m8yTpKQ==
X-Received: by 2002:adf:eec1:: with SMTP id a1-v6mr790559wrp.242.1540455168013;
        Thu, 25 Oct 2018 01:12:48 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 4-v6sm3428259wrk.52.2018.10.25.01.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:12:47 -0700 (PDT)
Message-ID: <639e0498b81edf5f39b1e73efa8a3db8188d6930.camel@baylibre.com>
Subject: Re: [PATCH 1/6] clk: Remove recursion in clk_core_{prepare,enable}()
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     "dbasehore ." <dbasehore@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Boyd <sboyd@codeaurora.org>
Date:   Thu, 25 Oct 2018 10:12:45 +0200
In-Reply-To: <CAGAzgsox7bfh4fLBCjJvFeXAJRWx9imsrFVgQYa=q1ooX2Mi1w@mail.gmail.com>
References: <20181024013132.115907-1-dbasehore@chromium.org>
         <20181024013132.115907-2-dbasehore@chromium.org>
         <264adf2a81bcd602f2a58e4a46c3273cd7c77ca2.camel@baylibre.com>
         <CAGAzgsox7bfh4fLBCjJvFeXAJRWx9imsrFVgQYa=q1ooX2Mi1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-24 at 13:36 -0700, dbasehore . wrote:
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
> 
> It wasn't there in the original patch. I asked Stephen, and he thinks
> it may have been left that way because unprepare/disable are tail
> recursion cases, which the compiler can optimize away.

I'm sure the compiler is very clever ;) My point is more about maintainability
and how easy it is to understand for human beings.

> 
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


