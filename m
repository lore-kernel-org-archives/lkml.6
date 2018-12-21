Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD2CC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5131C21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CE0Nn5Ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbeLUQDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:03:37 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:39708 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388229AbeLUQDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:03:36 -0500
Received: by mail-wm1-f48.google.com with SMTP id f81so6189784wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qxEk067MOwUWR/Nmqm6zH3dPRB5ZKsDdf9dlngWkXqs=;
        b=CE0Nn5LnulO+fJ/9ylLYP3p08HGVY2GATs/W40EIdeXfZn5nOEVqHRZ7lTnI+kfrTh
         E5I/jNewAf7xDp80fZ+UmaWjO54T+AOaJkLsWdau+TfP4n4rQ4t8GBi/zO3PkvozYgvi
         mRZ+aZRdFJQ0QbDb8j8ib9MAeuVSHqLFtIvX1+xOb0oqqvei/80VxSe6wxqrhG1USN9k
         q2fHjuO9UmPgAjeEFsknaV5fYYXsLYiKJg2HcLH4wWBt7LAXa06MGsyGxMUasE7WQpVK
         iT2dfaK3YzUZcMqoTRQJ7PcvNNAsFwr+GaUWWHUvcYlN3dFWP2cKKuCxvf5CPlS2NYja
         fSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qxEk067MOwUWR/Nmqm6zH3dPRB5ZKsDdf9dlngWkXqs=;
        b=futJ1ssLD3IV7RUqneq6doWhrx6YijnS7PPCZM0zcJy18a/72j+K5dwJsnFxSll/kn
         Mqqvq4MrcIG+JZYHySHrgPLe2xLyP49gp7HkSlROLqiO/cZbgDBHATwixqgW+B3Cqltq
         7BS4ZcIMwJ6kJ8yYafaKQTdzu0TgiXFyRpxVLzm+MN02ikDq+K6VmFgG2aj8LXyAqUh3
         Za2tUOVPW7d73JrQIPnwKE4YoQWiCJH5sLHs/BIsL3UTwgFs5Fyss/w6IU6LSQUcDDeR
         /DW1fm3v+fh2OV7k4ksFFChnzl2JtQ+Hiiem3/jD2M8rLV2M4kPnl1vp1HVOSzgmEfJ6
         k6aA==
X-Gm-Message-State: AJcUukcWK46ZKay4rovJmYYO5FjuaCDma6YNN1CdpWhDwFdsIDicHSHc
        5XHtQEJACZKNOzT5EcCi2zzvEQ==
X-Google-Smtp-Source: ALg8bN5IQ4iOdF0gjvrOQFB9BkdfF5GZPCw9e662gbpOFk+rRlQd8vTem+0zB1joy2GuDPKU7xF+xg==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr3614083wmg.42.1545408213779;
        Fri, 21 Dec 2018 08:03:33 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id v19sm19280460wrd.46.2018.12.21.08.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 08:03:32 -0800 (PST)
Message-ID: <7e6f1ce65a59f7ad7c3d0da7f8d4b41c93346c2b.camel@baylibre.com>
Subject: Re: [PATCH] Revert "clk: fix __clk_init_parent() for single parent
 clocks"
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 21 Dec 2018 17:03:29 +0100
In-Reply-To: <154509805561.19322.14057956205431846882@swboyd.mtv.corp.google.com>
References: <20181204163257.32085-1-jbrunet@baylibre.com>
         <154394675320.88331.12449582989130694425@swboyd.mtv.corp.google.com>
         <807f2924b67239f61c6d93de7f7b124f8a1f195a.camel@baylibre.com>
         <154399647605.88331.115722031910044874@swboyd.mtv.corp.google.com>
         <98e430d7a96fa6b4f0225e57820a4a677108a052.camel@baylibre.com>
         <154413410087.88331.10879623310968389005@swboyd.mtv.corp.google.com>
         <63f9b6f613cab0db91c8363635aa673a11f75fba.camel@baylibre.com>
         <154509805561.19322.14057956205431846882@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 17:54 -0800, Stephen Boyd wrote:
> Quoting Jerome Brunet (2018-12-07 02:03:19)
> > On Thu, 2018-12-06 at 14:08 -0800, Stephen Boyd wrote:
> > > Sorry this email is long.
> > 
> > I tried reply the best I could to your use cases
> > 
> > > TL;DR is that I don't think we need to revert the patch as you suggest.
> > > Instead, we should fix the driver to indicate NULL as the parent name of
> > > the index it tells the framework about.
> > 
> > The driver, can't indicate NULL, it just provides the index of the parent.
> > What we are saying is not very far apart.
> > 
> > Drivers implementing get_parent() must have way to tell the framework "I
> > have
> > no idea what I'm connected to ATM"
> > 
> > Since get_parent() return a u8, the only way to signal a problem like this
> > is
> > to return an out of bound value, which the framework already safely
> > understand
> > and maps to NULL, as you request
> 
> I'm saying that the clk with two parents but only one 'known' clk parent
> should have a parent_names array of two strings, where the second
> element is NULL.
> 
> 	.parent_names = { "known_clk", NULL }
> 	.num_parents = 2,

The problem is that CCF disallowed this from the beginning when rejecting NULL
in parent tables.

Are saying we should find and fix all the controllers with mux using value
table to avoid unknown/disconnected mux inputs ... sounds like a lot of work
for a benefit I still don't really understand.

Anywayu, adding support for this would be nice, I just don't understand how
the proposed patch how here makes it any harder.

> 
> And then the .get_parent op is OK to return '1' and then we know that
> the clk isn't known to be anything, but it's otherwise a valid index for
> the clk to be parented to. This is the orphan case. It's not the error
> case, which would be some value returned from .get_parent() that's >=
> num_parents.
> 
> I am not talking about the return value from get_parent() returning NULL
> or the driver indicating that the parent is a NULL clk. I'm just saying
> that the clk driver that wants to return an index that's outside the
> bounds of the parent_names array needs to do the right thing and either
> grow the parent_names array to say "it's unknown what's here, I've
> indicated that with a NULL name", or it needs to return another value
> outside of the array so the framework knows it's an error.

AFAIK, the framework knows that index == 'num_parents' is an error.

> 
> > This is done in the other patch I sent (... and now they are related ;)
> > ...)
> > by returning num_parents in the clk_mux code
> > 
> > This is an important case, whatever the number of parent. I think it makes
> > no
> > sense that a clock with 2 known parents can return this error, a one with
> > only
> > one known parent can't.
> > This why I still think the change should be reverted.
> > 
> > If you really insist on keeping it, there should at least be a warning
> > when
> > registering a clock with 'get_parent != NULL' and 'num_parents == 1', to
> > let
> > the user know that whatever is implemented there will be ignored ...
> > instead
> > of silently ignoring it. I think it would be a mistake, but at least there
> > would be no suprise.
> 
> Maybe we should add the warning. At least it would be good to grep
> around and try to find these cases and update them. The documentation on
> the get_parent clk op says it's unnecessary right now when 0 or 1 parent
> exists, so maybe that needs an update too.

If we are going to ignore something, I think that would be a minimum, yes.
I still don't like the fact that may we chose to ignore this.

> 
> > Earlier, you mention having a special parent that would adopt the the
> > orphan.
> > Actually, it already exists, it is the framework itself. If, instead of
> > returning 0, it returned a special value to let us know we reached the
> > root
> > and there actually no signal, we would be easy to make sure the orphan
> > (with
> > no signal) are never accidently used.
> 
> I don't understand this part. We have orphan tracking code that knows
> when a clk is no longer in an orphan chain (i.e. there is a signal
> there).
> 
> > > Quoting Jerome Brunet (2018-12-05 09:20:09)
> > > > We have sometimes a few orphans in the amlogic clock tree, it does not
> > > > seems
> > > > to a problem.
> > 
> > To the best of my knowledge, there will always be orphan in the tree. The
> > root
> > clock (usually an xtal) being a special case of this. 
> > 
> > It seems to me that the problem is we can't differentiate between this
> > special
> > orphan and the rest because none will return an error when calling
> > get_rate()
> 
> The root clk isn't an orphan. It has num_parents == 0 and is treated
> specially as such.

got confused, sorry

> 
> > xtal will provide something to round_rate() while other clock which are
> > supposed to be orphaned will defer to the framework which gives a 0 rate.
> > 
> > I think this is your real issue with orphan in the framework. The
> > framework
> > does not distinguish between a signal with rate == 0 and an error (no
> > signal)
> 
> Ok. I'm not sure that rate is the entire problem, but I suppose it's one
> problem.
> 
> > > I suppose drivers aren't calling clk_set_rate() on the orphaned clks and
> > > experiencing problems? There are problems around clk rates that could
> > > happen if there aren't any proper parents of a mux.
> > > 
> > > > I don't really understand the benefit of having a fake clock that
> > > > would
> > > > adopt
> > > > all the orphan ? You guess there is problem I'm not aware of ...
> > > 
> > > I see three cases that can go wrong if we make orphan clks probe defer
> > > clk_get():
> > > 
> > >   1) NULL as the parent name for some parent index that the hardware
> > >      indicates is the current parent of the clk when the clk is
> > > registered.
> > 
> > I don't think you can have NULL has a parent_name
> 
> Yes, it looks like Mike made that decision when introducing the CCF in
> 2012. I don't know why it is a problem though. Maybe kstrdup() on a NULL
> string returns NULl and then errors can't be detected? Should be simple
> enough to skip those ones when doing the deep copy though.

Maybe but all controller so far have been done with this in mind, what about
those ?

> 
> > > In this case, we need to make clk_get() succeed and not return
> > > -EPROBE_DEFER, so I think we need to make a special "unknown" clk in the
> > > framework so that clks aren't orphaned when the hardware is indicating
> > > the parent is something we don't (and won't) know anything about.
> > 
> > I think DEFER is returned when clock is unknown, not when it is orphaned.
> 
> Yes it's only returned right now if the provider node hasn't registered
> a provider function. We have wanted to extend that further so that clks
> can't be acquired until the clk is properly rooted in the clk tree
> instead of being orphaned. It may not matter on amlogic but it matters
> on other platforms.
> 
> > >   2) get_parent/set_parent on a clk with num_parents == 1
> > > 
> > > This seems to be how ao_cts_cec is implemented. This hides the fact that
> > > get_parent may return some number above the number of parents
> > 
> > The index returned will be either 0, to indicate the only known parent, or
> > num_parents (1) to indicate an invalid parent to framework. This is the
> > topic
> > of the other patch I sent you
> > 
> > You must have way for a driver to tell you that it is not connected to
> > anything it knows. That's a very basic error case and this is not specific
> > to
> > num_parents == 1. 
> > 
> > With any number of num_parent, there is still a possibility that a driver
> > ends
> > up in configuration where it cannot tell what it is his parent. (invalid
> > combination, reserved values, crappy doc ...)
> > 
> > This is why is important to call get_parent() (if available) even when
> > num_parent == 1. The driver might tell if it is connected as expected - or
> > not
> 
> Ok. Thanks for the explanation. What should the framework do when the
> parent is not known? Mark the clk as not an orphan but parent it to
> NULL? That might work here.

I don't really get the difference in the framework ATM. Is this linked to the
'orphan probe defer logic' WIP you have been mentionning ?

> 
> > > and then
> > > has that quietly make the parent of the clk NULL during registration so
> > > that it's orphaned. Then we rely on set_rate() or set_parent() being
> > > called to fix the parent chain at a later time.
> > > 
> > > That is complicated and non-obvious. I'd rather that we specify NULL as
> > > a parent in the parent_names array if we're going to return that index
> > > to the framework and then have the framework go to case #1. This makes
> > > it easier for the framework to assume that [0, num_parents) is the valid
> > > range of indices returned from the get_parent() op and a number outside
> > > that range is an error, clearing the way for errors to be returned from
> > > get_parent() if it somehow fails.
> > 
> > The fix I sent is quite simple.
> > 
> > The above would require that:
> > 1) the framework accept NULL in the list of parent (which it forbids ATM
> > AFAIK)
> > 2) Have all drivers account for this a create this fake parent
> > 
> > This seems to be putting more work on the drivers with no real gain for
> > the
> > framework, none that I can see at least.
> > 
> > >   3) A string as the parent name for some parent index that the hardware
> > >      indicates is the current parent of the clk when the clk is
> > > registered,
> > >      but that parent clk may never be registered with the framework.
> > > 
> > > I imagine this can happen with an external gpio clk that feeds some SoC
> > > internal clk. That gpio could be supplied by some clk signal that the
> > > board designer decides to send there, and it could also just "magically
> > > appear" by applying some DT overlay. Due to our use of global strings
> > > for parent linking, we don't have a good way to figure out that nothing
> > > is connected to some clock input signal, making this quite a nightmare
> > > to figure out a runtime!
> > > 
> > > One solution is to replace the parent name with NULL and ignore the
> > > runtime update case. This will work and bring us back to case #1. The
> > > problem is that if it is connected to something like a GPIO and it
> > > defaults to that pin instead of some internal clk we're stuck with an
> > > "orphan" clk that we can't clk_get(). I suppose the driver could read DT
> > > and see if this pin is not connected and then mark this input parent
> > > name as NULL. We can punt on solving the DT overlay problem until later,
> > > because we would need some way to dynamically resolve a new parent of a
> > > clk and update the tree when the DT node is modified to use a new GPIO.
> > 
> > I don't understand what is the problem here.
> > In Amlogic we have a lot of this cases, with optional input clocks of the
> > axg-
> > audio clock controller. Many muxes have parent names of clock that don't
> > exists.
> > 
> > CCF will return a 0 rate for these inputs.
> > It works well as it is, but as said above, I think it would be better if
> > we
> > could distinguish between a signal with 0 rate and no signal at all
> > (error)
> > 
> 

All this below is very interresting but it looks like a very complex way to
solve what was initially a very simple problem, with considerations that are
still WIP a this stage.

Even with these future constraints in mind, I don't understand how the
proposed patch changes anything to the situtation. A clock with a get_parent()
callback (and several known parents) may still return an out of bound value
... CCF will still have to deal with this case gracefully, as it is currently
doing

> Ok. It sounds like we want similar things but I'm worried about the
> orphan probe defer logic getting messed up.
> 
> How about we tri-state the get_parent() return value? So now [0,
> num_parents) means a valid parent is known, num_parents means "I don't
> know what it is but it must be something valid", and [num_parents + 1,
> 255] means some error occurred. Sounds obfuscated to me still.
> 
> Alternatively, we could make a get_parent_hw() op that returns a pointer
> to a clk_hw structure of the parent clk. Then drivers can be converted
> to use this new clk_op instead of get_parent and we can have it return
> an error pointer when some error happens, NULL when the parent is not
> known to the software but is otherwise valid, and the parent pointer
> when the parent is findable. It would still be tri-stated then, but at
> least it wouldn't be some odd u8 numberspace that it all has to fit
> into. This patch starts to do that. What do you think? Clk providers
> would need to implement a clk_ops that mostly does
> clk_hw_get_parent_by_index(), or they could stash the parent_hw pointer
> in their structure, or index into it based on some global numberspace in
> their driver.
> 
> -----8<----
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index af011974d4ec..5fe3c41e0b7b 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2242,14 +2242,84 @@ struct clk *clk_get_parent(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_get_parent);
>  
> -static struct clk_core *__clk_init_parent(struct clk_core *core)
> +static struct clk_core *
> +__clk_init_parent(struct clk_core *core, bool update_orphan)
>  {
>  	u8 index = 0;
> +	struct clk_hw *parent_hw = NULL;
>  
> -	if (core->num_parents > 1 && core->ops->get_parent)
> -		index = core->ops->get_parent(core->hw);
> +	if (core->ops->get_parent_hw) {
> +		parent_hw = core->ops->get_parent_hw(core->hw);
> +		/*
> +		 * The provider driver doesn't know what the parent is,
> +		 * but it's at least something valid, so it's not an
> +		 * orphan, just a clk with some unknown parent.
> +		 */
> +		if (!parent_hw && update_orphan)
> +			core->orphan = false;
> +	} else {
> +		if (core->num_parents > 1 && core->ops->get_parent)
> +			index = core->ops->get_parent(core->hw);
> +
> +		parent_hw = clk_hw_get_parent_by_index(core->hw, index);
> +	}
> +
> +	if (IS_ERR(parent_hw)) {
> +		/* Parent clk provider hasn't probed yet, orphan it */
> +		if (PTR_ERR(parent_hw) == -EPROBE_DEFER) {
> +			if (update_orphan)
> +				core->orphan = true;
> +
> +			return NULL;
> +		}
> +
> +		return ERR_CAST(parent_hw);
> +	}
> +
> +	if (!parent_hw)
> +		return NULL;
> +
> +	return parent_hw->core;
> +}
> +
> +static int clk_init_parent(struct clk_core *core)
> +{
> +	core->parent = __clk_init_parent(core, true);
> +	if (IS_ERR(core->parent))
> +		return PTR_ERR(core->parent);
> +
> +	/*
> +	 * Populate core->parent if parent has already been clk_core_init'd.
> If
> +	 * parent has not yet been clk_core_init'd then place clk in the
> orphan
> +	 * list.  If clk doesn't have any parents then place it in the root
> +	 * clk list.
> +	 *
> +	 * Every time a new clk is clk_init'd then we walk the list of orphan
> +	 * clocks and re-parent any that are children of the clock currently
> +	 * being clk_init'd.
> +	 */
> +	if (core->parent) {
> +		hlist_add_head(&core->child_node,
> +				&core->parent->children);
> +		core->orphan = core->parent->orphan;
> +	} else if (!core->num_parents) {
> +		hlist_add_head(&core->child_node, &clk_root_list);
> +		core->orphan = false;
> +	} else {
> +		hlist_add_head(&core->child_node, &clk_orphan_list);
> +	}
> +
> +	return 0;
> +}
>  
> -	return clk_core_get_parent_by_index(core, index);
> +static struct clk_core *clk_find_parent(struct clk_core *core)
> +{
> +	return __clk_init_parent(core, false);
> +}
> +
> +static bool clk_has_parent_op(const struct clk_ops *ops)
> +{
> +	return ops->get_parent || ops->get_parent_hw;
>  }
>  
>  static void clk_core_reparent(struct clk_core *core,
> @@ -3045,14 +3115,14 @@ static int __clk_core_init(struct clk_core *core)
>  		goto out;
>  	}
>  
> -	if (core->ops->set_parent && !core->ops->get_parent) {
> +	if (core->ops->set_parent && !clk_has_parent_op(core->ops)) {
>  		pr_err("%s: %s must implement .get_parent & .set_parent\n",
>  		       __func__, core->name);
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	if (core->num_parents > 1 && !core->ops->get_parent) {
> +	if (core->num_parents > 1 && !clk_has_parent_op(core->ops)) {
>  		pr_err("%s: %s must implement .get_parent as it has multi
> parents\n",
>  		       __func__, core->name);
>  		ret = -EINVAL;
> @@ -3073,29 +3143,9 @@ static int __clk_core_init(struct clk_core *core)
>  				"%s: invalid NULL in %s's .parent_names\n",
>  				__func__, core->name);
>  
> -	core->parent = __clk_init_parent(core);
> -
> -	/*
> -	 * Populate core->parent if parent has already been clk_core_init'd.
> If
> -	 * parent has not yet been clk_core_init'd then place clk in the
> orphan
> -	 * list.  If clk doesn't have any parents then place it in the root
> -	 * clk list.
> -	 *
> -	 * Every time a new clk is clk_init'd then we walk the list of orphan
> -	 * clocks and re-parent any that are children of the clock currently
> -	 * being clk_init'd.
> -	 */
> -	if (core->parent) {
> -		hlist_add_head(&core->child_node,
> -				&core->parent->children);
> -		core->orphan = core->parent->orphan;
> -	} else if (!core->num_parents) {
> -		hlist_add_head(&core->child_node, &clk_root_list);
> -		core->orphan = false;
> -	} else {
> -		hlist_add_head(&core->child_node, &clk_orphan_list);
> -		core->orphan = true;
> -	}
> +	ret = clk_init_parent(core);
> +	if (ret)
> +		goto out;
>  
>  	/*
>  	 * optional platform-specific magic
> @@ -3173,7 +3223,14 @@ static int __clk_core_init(struct clk_core *core)
>  	 * parent.
>  	 */
>  	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node)
> {
> -		struct clk_core *parent = __clk_init_parent(orphan);
> +		struct clk_core *parent = clk_find_parent(orphan);
> +
> +		/*
> +		 * Error parent should have been caught before and returned
> +		 * as an error during registration.
> +		 */
> +		if (WARN_ON_ONCE(IS_ERR(parent)))
> +			continue;
>  
>  		/*
>  		 * We need to use __clk_set_parent_before() and _after() to
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 60c51871b04b..8b84dee942bf 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -155,6 +155,14 @@ struct clk_duty {
>   *		multiple parents.  It is optional (and unnecessary) for clocks
>   *		with 0 or 1 parents.
>   *
> + * @get_parent_hw: Queries the hardware to determine the parent of a
> clock.  The
> + *		return value is a clk_hw pointer corresponding to
> + *		the parent clock. In short, this function translates the
> parent
> + *		value read from hardware into a pointer to the clk_hw for that
> clk.
> + *		Currently only called when the clock is initialized by
> + *		__clk_init.  This callback is mandatory for clocks with
> + *		multiple parents.  It is optional for clocks with 0 or 1
> parents.
> + *
>   * @set_rate:	Change the rate of this clock. The requested rate is
> specified
>   *		by the second argument, which should typically be the return
>   *		of .round_rate call.  The third argument gives the parent rate
> @@ -238,6 +246,7 @@ struct clk_ops {
>  					  struct clk_rate_request *req);
>  	int		(*set_parent)(struct clk_hw *hw, u8 index);
>  	u8		(*get_parent)(struct clk_hw *hw);
> +	struct clk_hw * (*get_parent_hw)(struct clk_hw *hw);
>  	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
>  				    unsigned long parent_rate);
>  	int		(*set_rate_and_parent)(struct clk_hw *hw,
> 
> 


