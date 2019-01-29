Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5619C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C212214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bb8ui7IW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfA2VIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:08:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35961 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfA2VIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:08:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so19309708wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 13:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BxtYpXUD2LFi38DmTRtGAsyWXxBiDT4qI+NAylsmhE8=;
        b=bb8ui7IWA+JEvV8DKAkTR6htKkYI0Bk+IjE5yDjYPmmae1DZ7yy5P7S+0WMA1BdZpv
         tZEjSKmPKOeX7DhHub3SkkROx6q5nvggn4q9bB/hOf+kuiIcPu9CWk3Jc57u1+vcBBCX
         v1oq3eFJcJ+l5nTqmRrLkR9pCqOR81S729jWplLVy4hppZaiVcznriNTX6BZARQEv25U
         xMYl/YVG2tLeZl15mBnu0BlyItU8sgE/PPR0BEcKWIsZdU9sqKxy1aMIevE9kVNq5cxo
         ONyq8vdts9UcgOohHnAy3qRu6hpG2QLbeKA2ScpfxNLUAzo2dtYWlhIh/jqkb20YUn2U
         TPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BxtYpXUD2LFi38DmTRtGAsyWXxBiDT4qI+NAylsmhE8=;
        b=ABv8wlz1P6XdMPDWpzB1HJRVO/o/Wfj+VFdF+PlLZebxTDE30bhjF5UmpPT6k/Q+B8
         Clg8m/JIh4U4XOO/63DrsO5C5R7yx9SbzSIHZ4R1iwfJws0OfCxjApcoqwbjyFtDrfKW
         6tP6ZoK6BcLuj3RJEiCxxF+bAkkYxSw3VFUi18JZsIZL9yU4jB3OXnNeNJ3qyq5i/wG5
         JvJHDn55QkY/tFkZsuXvwdeqiJQGAiqqzlHjKwJt6q/tNHnP49q8ytqA7gYpeCWQqIhl
         /1MyymghEytApmJZSeQJj+7MHH5j5t6w+SGNK3gxJUGNoHbaPKGkw1H4Mweo/weFOEl2
         5VQA==
X-Gm-Message-State: AJcUukcaI3wyQ/pHgF8C1GNcEPFOiMc08K8gqi/A4BOJIQY1lk3/yHBa
        1klTMHcJnSRBuL1t2HgHReiGp08EodE=
X-Google-Smtp-Source: ALg8bN6YaujZOqz3odGbEQP216hGAeuKNHHQ5VBw8zcOFgXoJbj542/W6pQ6wYWXTQ5WoEMDNiuU8Q==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr22405674wmj.147.1548796108425;
        Tue, 29 Jan 2019 13:08:28 -0800 (PST)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id 202sm5076995wmt.8.2019.01.29.13.08.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 29 Jan 2019 13:08:27 -0800 (PST)
Message-ID: <6c4d1da5c796f354c55789269a3067f2c2e79ff9.camel@baylibre.com>
Subject: Re: [PATCH 7/9] clk: Allow parents to be specified without string
 names
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Date:   Tue, 29 Jan 2019 22:08:25 +0100
In-Reply-To: <154878820913.136743.9860407353339842831@swboyd.mtv.corp.google.com>
References: <20190129061021.94775-1-sboyd@kernel.org>
         <20190129061021.94775-8-sboyd@kernel.org>
         <2f88e7fb1788f68f7b97d9806d56f9271663bdfc.camel@baylibre.com>
         <154878820913.136743.9860407353339842831@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-29 at 10:56 -0800, Stephen Boyd wrote:
> Quoting Jerome Brunet (2019-01-29 02:12:00)
> > On Mon, 2019-01-28 at 22:10 -0800, Stephen Boyd wrote:
> > > Using either one of these new methods is entirely optional. Existing
> > > drivers will continue to work, and they can migrate to this new approach
> > > as they see fit. Eventually, we'll want to get rid of the 'parent_names'
> > > array in struct clk_init_data and use one of these new methods instead.
> > 
> > This may indeed allow to remove a lot of annoying code.
> > 
> > However, does this remove the globally unique name string constraints ?
> > Are we
> > now allowed to have 2 instances of a driver registering a clock named
> > "foo" ?
> 
> Yes it would be allowed to have multiple clocks with the same name but
> I'm not trying to solve that exact problem right now. The framework
> already complains if that's happening, so drivers need to generate
> unique names regardless of this series.

Ok. Got it

> 
> > If this is the case, I wonder:
> > * How will it work with debugfs: clock names are used to create the
> > directories in there, plus clk_summary will quickly get messy.
> 
> Agreed. We should probably prepend the device name to the front of the
> clk now when creating in debugfs. I'll throw a patch for that into the
> pile to get that problem out of the way.

If we are supposed to keep globally unique names, maybe we should be keep
things as they are for now.

> 
> I'm also beginning to think we should add a way to pass in the of_node
> for a clk when it's registered.  Probably need to do that with the
> initdata structure again. That way we can lookup a clk's parents with
> the DT node if they don't call clk_register() with a device and also to
> generate a better unique name for the clk for debug purposes.

I don't get it now, but I'm sure I'll understand better with the code later on
:)

> 
> > * How will it behave if 2 clock registers with "foo" and one clock
> > register
> > with the fallback parent "foo" ?
> 
> Sorry, I'm not following. The fallback is global so we'll be unable to
> figure out which parent the clk is referring to.

This is what I was thinking as well. But since the global clock namespace is
not the point of this series, the question is off topic. Let's leave this foranother day 

>  Maybe this is an
> argument for keeping everything globally unique in the clk name space?

For now, sure.

> 
> > > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> > > @@ -2365,8 +2432,11 @@ bool clk_has_parent(struct clk *clk, struct clk
> > > *parent)
> > >       if (core->parent == parent_core)
> > >               return true;
> > >  
> > > -     return match_string(core->parent_names, core->num_parents,
> > > -                         parent_core->name) >= 0;
> > > +     for (i = 0; i < core->num_parents; i++)
> > > +             if (!strcmp(core->parents[i].fallback, parent_core->name))
> > > +                     return true;
> 
> This is also messy and not great BTW.
> 
> > > +
> > > +     return false;
> > >  }
> > >  EXPORT_SYMBOL_GPL(clk_has_parent);
> > >  
> > > @@ -2949,9 +3019,9 @@ static int possible_parents_show(struct seq_file
> > > *s,
> > > void *data)
> > >       int i;
> > >  
> > >       for (i = 0; i < core->num_parents - 1; i++)
> > > -             seq_printf(s, "%s ", core->parent_names[i]);
> > > +             seq_printf(s, "%s ", core->parents[i].fallback);
> > >  
> > > -     seq_printf(s, "%s\n", core->parent_names[i]);
> > > +     seq_printf(s, "%s\n", core->parents[i].fallback);
> > 
> > Wouldn't this show nothing if parent_data is used but fallback is not
> > provided
> > (like in your example when you provide the clk_hw pointer instead) or did
> > I
> > miss something ?
> 
> Yes, it will show nothing. Maybe we need to generate the debug name
> somehow? 

That would be nice. that or dropping the possible parent entry.

> That code sounds quite awful because we're going in reverse to
> the device through a DT node pointer. Or add an indicator in the output
> if the parent is a global name vs. a local name or a clk debugfs name?
> 
>    "global_name(g)"
>    "local_name(l)"
>    "debug_name"
> 
> Or if we can't figure anything out then perhaps just ignoring this
> problem for now is fine. It is debugfs after all.

Humm, I don't know if there are any rules regarding debugfs but it bothers me
if we knowingly report wrong values through it. This may lead other developers
to waste their time on this 

If we can't report the actual parent_name, we should at very least warn about
it - display [FIXME] or [MISSING] for example.

> 
> > >  
> > >       return 0;
> > >  }
> > > @@ -3360,6 +3424,74 @@ struct clk *clk_hw_create_clk(struct device *dev,
> > > struct clk_hw *hw,
> > >       return clk;
> > >  }
> > >  
> > > +static int clk_core_populate_parent_map(struct clk_core *core)
> > > +{
> > > +     const struct clk_init_data *init = core->hw->init;
> > > +     u8 num_parents = init->num_parents;
> > > +     const char * const *parent_names = init->parent_names;
> > > +     struct clk_hw **parent_hws = init->parent_hws;
> > > +     const struct clk_parent_data *parent_data = init->parent_data;
> > > +     int i, ret = 0;
> > > +     struct clk_parent_map *parents, *parent;
> > > +
> > > +     if (!num_parents)
> > > +             return 0;
> > > +
> > > +     /*
> > > +      * Avoid unnecessary string look-ups of clk_core's possible
> > > parents by
> > > +      * having a cache of names/clk_hw pointers to clk_core pointers.
> > > +      */
> > > +     parents = kcalloc(num_parents, sizeof(*parents), GFP_KERNEL);
> > > +     core->parents = parents;
> > > +     if (!parents)
> > > +             return -ENOMEM;
> > > +
> > > +     /* Copy everything over because it might be __initdata */
> > > +     for (i = 0, parent = parents; i < num_parents; i++, parent++) {
> > > +             if (parent_names) {
> > > +                     /* throw a WARN if any entries are NULL */
> > > +                     WARN(!parent_names[i],
> > > +                             "%s: invalid NULL in %s's
> > > .parent_names\n",
> > > +                             __func__, core->name);
> > > +                     parent->fallback = kstrdup_const(parent_names[i],
> > > +                                                      GFP_KERNEL);
> > > +                     if (!parent->fallback) {
> > > +                             ret = -ENOMEM;
> > > +                             while (--i >= 0)
> > > +                                     kfree_const(parents[i].fallback);
> > > +                     }
> > > +             } else if (parent_data) {
> > > +                     parent->hw = parent_data[i].hw;
> > > +                     parent->name = parent_data[i].name;
> > > +                     parent->fallback = parent_data[i].fallback;
> > 
> > I'm a bit confused by the comment at the top of the loop. Strings in
> > parent_data are not copied over like we used to do with parent_names.
> > 
> > Is it allowed to have parent_data in __initdata ? It could be error prone
> > if
> > parent_names and parent_data behaved differently on this.
> 
> Good catch, thanks. Will fix.
> 
> > > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > > index 8b84dee942bf..f513f4074a93 100644
> > > --- a/include/linux/clk-provider.h
> > > +++ b/include/linux/clk-provider.h
> > > @@ -264,6 +264,18 @@ struct clk_ops {
> > >       void            (*debug_init)(struct clk_hw *hw, struct dentry
> > > *dentry);
> > >  };
> > >  
> > > +/**
> > > + * struct clk_parent_data - clk parent information
> > > + * @hw: parent clk_hw pointer (used for clk providers with internal
> > > clks)
> > > + * @name: parent name local to provider registering clk
> > > + * @fallback: globally unique parent name (used as a fallback)
> > > + */
> > > +struct clk_parent_data {
> > > +     struct clk_hw   *hw;
> > > +     const char      *name;
> > > +     const char      *fallback;
> > 
> > If I understand correctly, .name and .fallback will be ignored if hw is
> > provided ? Maybe this should be documented somehow ?
> 
> Sure. I'll add some documentation to the long portion of the kernel-doc
> here describing priority order.
> 
> > > +};
> > > +
> > >  /**
> > >   * struct clk_init_data - holds init data that's common to all clocks
> > > and
> > > is
> > >   * shared between the clock provider and the common clock framework.
> > > @@ -277,7 +289,10 @@ struct clk_ops {
> > >  struct clk_init_data {
> > >       const char              *name;
> > >       const struct clk_ops    *ops;
> > > -     const char              * const *parent_names;
> > > +     /* Only one of the following three should be assigned */
> > > +     const char              * const *parent_names; /* If NULL (and
> > > num_parents != 0) look at parent_data and parent_hws */
> > > +     const struct clk_parent_data    *parent_data;
> > > +     struct clk_hw           **parent_hws;
> > 
> > Isn't parent_hws redundant with parent_data ? you may pass the clk_hw
> > pointer
> > with both, right ?
> 
> Yeah it's redundant, but I thought that drivers may not want to waste
> the extra space for pointers if they had all the pointers in hand for
> the parents they care about, or if they had a single parent and just
> wanted to point to that directly.

Fine. Makes sense.

> 
> Another thought is to have a union on these three pointers and then a
> flag indicating which method is used:
> 
> 	union {
> 		const char              * const *parent_names;
> 		const struct clk_parent_data    *parent_data;
> 		struct clk_hw           **parent_hws;
> 	};
> 
> 	#define CLK_PARENTS_POINTERS		BIT(3)
> 	#define CLK_PARENTS_DATA		BIT(8)
> 

Whatever is simpler :) 
If keeping the current solution, we just need to document the priority order.


