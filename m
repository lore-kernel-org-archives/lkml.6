Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09256C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C252082E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xsSLMnX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfA2KMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:12:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37451 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfA2KMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:12:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so21333338wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 02:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NULnMeTN8tfwxxxh2vQIaNXOHOwfuhJw55omz8T8qcY=;
        b=xsSLMnX2hmeRwc5oQGgjk7OT+RLQUWST/46n8VPhS94fx1f+XK00dGw5NWV+Kl5G1M
         yFEICMHl800KiLH5R8s0es+/NgwaqEtQpM7pWzSdYK9lokTKvYCmG1v04L1m2vJtsQpc
         7lOIL9rfhzJpGAQUjxhKWuPSjr5ndQGYqMOZrYn7S0W8yfTILuOpEwx5P2luIz/pCZdd
         iGAydKa9Azx0CvHxPSjUsvsSpfd8MpwNInonWiakcVw9SyjLKWgukVstw6Jo7UE4mR0z
         bi3K3CtPSBy9cogsnrlEfyR/PtWCYEZfI2zKkpr+PpQt0EX250imEiv5Zpjxm+XV0MJI
         n8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NULnMeTN8tfwxxxh2vQIaNXOHOwfuhJw55omz8T8qcY=;
        b=XyTuZIKbIF0vJPQSxnbyRpXDxrsllygeGY1mwb2ZrxvuaIS8zTX5BO2Ok8ZxlUJGMj
         usJ+fjS7HSOnXbNjYrI6T1sXqk4/KuFuI2450IZhb2E3b2r4zAsDbuKOT3Sa2VDCT7LN
         UDxlN/mpkELkN9Mx8csgfkaqITxyHcb0wFzvcBaC2FChhoLJVvQe7WY59T62AbD91AKo
         LWhMBhxVd/Hf/mtG4bFfm3n38JHW+tn/dOwyYuJ+dGMKRn+rkLe6Vnv0pI5jU6Kre+mi
         wv+t4M0B8cQRCow1vfKf+yEfqqg8aBmfsCSnzkO80feef2zI3xfHxOTcvyGL5WOmTxDR
         4GTQ==
X-Gm-Message-State: AJcUukeLr7gdqByUf4nfh4LJ0l/X1IOxAjr1Zi9BVDtvvAlkFkFN6NrX
        Qizf4o6wu8vDp9dkaQiiylG25A==
X-Google-Smtp-Source: ALg8bN4CHVUyD9okCIsxDkEmtii7J7kPdwnV9iP2wzpDJ0fjvC57urxCelSaTg5/7d4FuWMoptijPw==
X-Received: by 2002:a5d:50c5:: with SMTP id f5mr24260726wrt.37.1548756723020;
        Tue, 29 Jan 2019 02:12:03 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id q12sm103911833wrx.31.2019.01.29.02.12.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 29 Jan 2019 02:12:02 -0800 (PST)
Message-ID: <2f88e7fb1788f68f7b97d9806d56f9271663bdfc.camel@baylibre.com>
Subject: Re: [PATCH 7/9] clk: Allow parents to be specified without string
 names
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Date:   Tue, 29 Jan 2019 11:12:00 +0100
In-Reply-To: <20190129061021.94775-8-sboyd@kernel.org>
References: <20190129061021.94775-1-sboyd@kernel.org>
         <20190129061021.94775-8-sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-28 at 22:10 -0800, Stephen Boyd wrote:
> The common clk framework is lacking in ability to describe the clk
> topology without specifying strings for every possible parent-child
> link. There are a few drawbacks to the current approach:
> 
>  1) String comparisons are used for everything, including describing
>  topologies that are 'local' to a single clock controller.
> 
>  2) clk providers (e.g. i2c clk drivers) need to create globally unique
>  clk names to avoid collisions in the clk namespace, leading to awkward
>  name generation code in various clk drivers.
> 
>  3) DT bindings may not fully describe the clk topology and linkages
>  between clk controllers because drivers can easily rely on globally unique
>  strings to describe connections between clks.
> 
> This leads to confusing DT bindings, complicated clk name generation
> code, and inefficient string comparisons during clk registration just so
> that the clk framework can detect the topology of the clk tree.
> Furthermore, some drivers call clk_get() and then __clk_get_name() to
> extract the globally unique clk name just so they can specify the parent
> of the clk they're registering. We have of_clk_parent_fill() but that
> mostly only works for single clks registered from a DT node, which isn't
> the norm. Let's simplify this all by introducing two new ways of
> specifying clk parents.
> 
> The first method is an array of pointers to clk_hw structures
> corresponding to the parents at that index. This works for clks that are
> registered when we have access to all the clk_hw pointers for the
> parents.
> 
> The second method is a mix of clk_hw pointers and strings of local and
> global parent clk names. If the .name member of the map is set we'll
> look for that clk by performing a DT based lookup of the device the clk
> is registered with and the .name specified in the map. If that fails,
> we'll fallback to the .fallback member and perform a global clk name
> lookup like we've always done before.
> 
> Using either one of these new methods is entirely optional. Existing
> drivers will continue to work, and they can migrate to this new approach
> as they see fit. Eventually, we'll want to get rid of the 'parent_names'
> array in struct clk_init_data and use one of these new methods instead.

This may indeed allow to remove a lot of annoying code.

However, does this remove the globally unique name string constraints ? Are we
now allowed to have 2 instances of a driver registering a clock named "foo" ?

If this is the case, I wonder:
* How will it work with debugfs: clock names are used to create the
directories in there, plus clk_summary will quickly get messy.
* How will it behave if 2 clock registers with "foo" and one clock register
with the fallback parent "foo" ?

> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c            | 215 +++++++++++++++++++++++++----------
>  include/linux/clk-provider.h |  17 ++-
>  2 files changed, 173 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 202902e64799..0cd90a2339ad 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -42,6 +42,13 @@ static LIST_HEAD(clk_notifier_list);
>  
>  /***    private data structures    ***/
>  
> +struct clk_parent_map {
> +	struct clk_hw		*hw;
> +	struct clk_core		*core;
> +	const char	 	*name;
> +	const char	 	*fallback;
> +};
> +
>  struct clk_core {
>  	const char		*name;
>  	const struct clk_ops	*ops;
> @@ -49,8 +56,7 @@ struct clk_core {
>  	struct module		*owner;
>  	struct device		*dev;
>  	struct clk_core		*parent;
> -	const char		**parent_names;
> -	struct clk_core		**parents;
> +	struct clk_parent_map	*parents;
>  	u8			num_parents;
>  	u8			new_parent_index;
>  	unsigned long		rate;
> @@ -319,17 +325,77 @@ static struct clk_core *clk_core_lookup(const char
> *name)
>  	return NULL;
>  }
>  
> +/**
> + * clk_core_get - Find the parent of a clk using a clock specifier in DT
> + * @core: clk to find parent of
> + * @name: name to search for in 'clock-names' of device providing clk
> + *
> + * This is the preferred method for clk providers to find the parent of a
> + * clk when that parent is external to the clk controller. The parent_names
> + * array is indexed and treated as a local name matching a string in the
> device
> + * node's 'clock-names' property. This allows clk providers to use their
> own
> + * namespace instead of looking for a globally unique parent string.
> + *
> + * For example the following DT snippet would allow a clock registered by
> the
> + * clock-controller@c001 that has a clk_init_data::parent_data array
> + * with 'xtal' in the 'name' member to find the clock provided by the
> + * clock-controller@f00abcd without needing to get the globally unique name
> of
> + * the xtal clk.
> + *
> + * 	parent: clock-controller@f00abcd {
> + * 		reg = <0xf00abcd 0xabcd>;
> + * 		#clock-cells = <0>;
> + * 	};
> + *
> + * 	clock-controller@c001 {
> + * 		reg = <0xc001 0xf00d>;
> + * 		clocks = <&parent>;
> + * 		clock-names = "xtal";
> + * 		#clock-cells = <1>;
> + * 	};
> + */
> +static struct clk_core *clk_core_get(struct clk_core *core, const char
> *name)
> +{
> +	struct clk_hw *hw;
> +	struct device *dev = core->dev;
> +
> +	if (!dev)
> +		return NULL;
> +
> +	/* TODO: Support clkdev clk_lookups */
> +	hw = of_clk_get_hw(dev->of_node, -1, name);
> +	if (IS_ERR_OR_NULL(hw))
> +		return NULL;
> +
> +	return hw->core;
> +}
> +
> +static void clk_core_fill_parent_index(struct clk_core *core, u8 index)
> +{
> +	struct clk_parent_map *entry = &core->parents[index];
> +	struct clk_core *parent = NULL;
> +
> +	if (entry->hw)
> +		parent = entry->hw->core;
> +	else if (entry->name)
> +		parent = clk_core_get(core, entry->name);
> +
> +	if (!parent)
> +		parent = clk_core_lookup(entry->fallback);
> +
> +	entry->core = parent;
> +}
> +
>  static struct clk_core *clk_core_get_parent_by_index(struct clk_core *core,
>  							 u8 index)
>  {
> -	if (!core || index >= core->num_parents)
> +	if (!core || index >= core->num_parents || !core->parents)
>  		return NULL;
>  
> -	if (!core->parents[index])
> -		core->parents[index] =
> -				clk_core_lookup(core->parent_names[index]);
> +	if (!core->parents[index].core)
> +		clk_core_fill_parent_index(core, index);
>  
> -	return core->parents[index];
> +	return core->parents[index].core;
>  }
>  
>  struct clk_hw *
> @@ -2353,6 +2419,7 @@ void clk_hw_reparent(struct clk_hw *hw, struct clk_hw
> *new_parent)
>  bool clk_has_parent(struct clk *clk, struct clk *parent)
>  {
>  	struct clk_core *core, *parent_core;
> +	int i;
>  
>  	/* NULL clocks should be nops, so return success if either is NULL. */
>  	if (!clk || !parent)
> @@ -2365,8 +2432,11 @@ bool clk_has_parent(struct clk *clk, struct clk
> *parent)
>  	if (core->parent == parent_core)
>  		return true;
>  
> -	return match_string(core->parent_names, core->num_parents,
> -			    parent_core->name) >= 0;
> +	for (i = 0; i < core->num_parents; i++)
> +		if (!strcmp(core->parents[i].fallback, parent_core->name))
> +			return true;
> +
> +	return false;
>  }
>  EXPORT_SYMBOL_GPL(clk_has_parent);
>  
> @@ -2949,9 +3019,9 @@ static int possible_parents_show(struct seq_file *s,
> void *data)
>  	int i;
>  
>  	for (i = 0; i < core->num_parents - 1; i++)
> -		seq_printf(s, "%s ", core->parent_names[i]);
> +		seq_printf(s, "%s ", core->parents[i].fallback);
>  
> -	seq_printf(s, "%s\n", core->parent_names[i]);
> +	seq_printf(s, "%s\n", core->parents[i].fallback);

Wouldn't this show nothing if parent_data is used but fallback is not provided
(like in your example when you provide the clk_hw pointer instead) or did I
miss something ?

>  
>  	return 0;
>  }
> @@ -3085,7 +3155,7 @@ static inline void clk_debug_unregister(struct
> clk_core *core)
>   */
>  static int __clk_core_init(struct clk_core *core)
>  {
> -	int i, ret;
> +	int ret;
>  	struct clk_core *orphan;
>  	struct hlist_node *tmp2;
>  	unsigned long rate;
> @@ -3139,12 +3209,6 @@ static int __clk_core_init(struct clk_core *core)
>  		goto out;
>  	}
>  
> -	/* throw a WARN if any entries in parent_names are NULL */
> -	for (i = 0; i < core->num_parents; i++)
> -		WARN(!core->parent_names[i],
> -				"%s: invalid NULL in %s's .parent_names\n",
> -				__func__, core->name);
> -
>  	ret = clk_init_parent(core);
>  	if (ret)
>  		goto out;
> @@ -3360,6 +3424,74 @@ struct clk *clk_hw_create_clk(struct device *dev,
> struct clk_hw *hw,
>  	return clk;
>  }
>  
> +static int clk_core_populate_parent_map(struct clk_core *core)
> +{
> +	const struct clk_init_data *init = core->hw->init;
> +	u8 num_parents = init->num_parents;
> +	const char * const *parent_names = init->parent_names;
> +	struct clk_hw **parent_hws = init->parent_hws;
> +	const struct clk_parent_data *parent_data = init->parent_data;
> +	int i, ret = 0;
> +	struct clk_parent_map *parents, *parent;
> +
> +	if (!num_parents)
> +		return 0;
> +
> +	/*
> +	 * Avoid unnecessary string look-ups of clk_core's possible parents by
> +	 * having a cache of names/clk_hw pointers to clk_core pointers.
> +	 */
> +	parents = kcalloc(num_parents, sizeof(*parents), GFP_KERNEL);
> +	core->parents = parents;
> +	if (!parents)
> +		return -ENOMEM;
> +
> +	/* Copy everything over because it might be __initdata */
> +	for (i = 0, parent = parents; i < num_parents; i++, parent++) {
> +		if (parent_names) {
> +			/* throw a WARN if any entries are NULL */
> +			WARN(!parent_names[i],
> +				"%s: invalid NULL in %s's .parent_names\n",
> +				__func__, core->name);
> +			parent->fallback = kstrdup_const(parent_names[i],
> +							 GFP_KERNEL);
> +			if (!parent->fallback) {
> +				ret = -ENOMEM;
> +				while (--i >= 0)
> +					kfree_const(parents[i].fallback);
> +			}
> +		} else if (parent_data) {
> +			parent->hw = parent_data[i].hw;
> +			parent->name = parent_data[i].name;
> +			parent->fallback = parent_data[i].fallback;

I'm a bit confused by the comment at the top of the loop. Strings in
parent_data are not copied over like we used to do with parent_names.

Is it allowed to have parent_data in __initdata ? It could be error prone if
parent_names and parent_data behaved differently on this.

> +		} else if (parent_hws) {
> +			parent->hw = parent_hws[i];
> +		} else {
> +			ret = -EINVAL;
> +			WARN(1, "Must specify parents if num_parents > 0\n");
> +		}
> +
> +		if (ret) {
> +			kfree(parents);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void clk_core_free_parent_map(struct clk_core *core)
> +{
> +	int i = core->num_parents;
> +
> +	if (!core->num_parents)
> +		return;
> +
> +	while (--i >= 0)
> +		kfree_const(core->parents[i].fallback);
> +	kfree(core->parents);
> +}
> +
>  /**
>   * clk_register - allocate a new clock, register it and return an opaque
> cookie
>   * @dev: device that is registering this clock
> @@ -3373,7 +3505,7 @@ struct clk *clk_hw_create_clk(struct device *dev,
> struct clk_hw *hw,
>   */
>  struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>  {
> -	int i, ret;
> +	int ret;
>  	struct clk_core *core;
>  
>  	core = kzalloc(sizeof(*core), GFP_KERNEL);
> @@ -3406,33 +3538,9 @@ struct clk *clk_register(struct device *dev, struct
> clk_hw *hw)
>  	core->max_rate = ULONG_MAX;
>  	hw->core = core;
>  
> -	/* allocate local copy in case parent_names is __initdata */
> -	core->parent_names = kcalloc(core->num_parents, sizeof(char *),
> -					GFP_KERNEL);
> -
> -	if (!core->parent_names) {
> -		ret = -ENOMEM;
> -		goto fail_parent_names;
> -	}
> -
> -
> -	/* copy each string name in case parent_names is __initdata */
> -	for (i = 0; i < core->num_parents; i++) {
> -		core->parent_names[i] = kstrdup_const(hw->init-
> >parent_names[i],
> -						GFP_KERNEL);
> -		if (!core->parent_names[i]) {
> -			ret = -ENOMEM;
> -			goto fail_parent_names_copy;
> -		}
> -	}
> -
> -	/* avoid unnecessary string look-ups of clk_core's possible parents.
> */
> -	core->parents = kcalloc(core->num_parents, sizeof(*core->parents),
> -				GFP_KERNEL);
> -	if (!core->parents) {
> -		ret = -ENOMEM;
> +	ret = clk_core_populate_parent_map(core);
> +	if (ret)
>  		goto fail_parents;
> -	};
>  
>  	INIT_HLIST_HEAD(&core->clks);
>  
> @@ -3443,7 +3551,7 @@ struct clk *clk_register(struct device *dev, struct
> clk_hw *hw)
>  	hw->clk = alloc_clk(core, NULL, NULL);
>  	if (IS_ERR(hw->clk)) {
>  		ret = PTR_ERR(hw->clk);
> -		goto fail_parents;
> +		goto fail_create_clk;
>  	}
>  
>  	clk_core_link_consumer(hw->core, hw->clk);
> @@ -3459,13 +3567,9 @@ struct clk *clk_register(struct device *dev, struct
> clk_hw *hw)
>  	free_clk(hw->clk);
>  	hw->clk = NULL;
>  
> +fail_create_clk:
> +	clk_core_free_parent_map(core);
>  fail_parents:
> -	kfree(core->parents);
> -fail_parent_names_copy:
> -	while (--i >= 0)
> -		kfree_const(core->parent_names[i]);
> -	kfree(core->parent_names);
> -fail_parent_names:
>  fail_ops:
>  	kfree_const(core->name);
>  fail_name:
> @@ -3495,15 +3599,10 @@ EXPORT_SYMBOL_GPL(clk_hw_register);
>  static void __clk_release(struct kref *ref)
>  {
>  	struct clk_core *core = container_of(ref, struct clk_core, ref);
> -	int i = core->num_parents;
>  
>  	lockdep_assert_held(&prepare_lock);
>  
> -	kfree(core->parents);
> -	while (--i >= 0)
> -		kfree_const(core->parent_names[i]);
> -
> -	kfree(core->parent_names);
> +	clk_core_free_parent_map(core);
>  	kfree_const(core->name);
>  	kfree(core);
>  }
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 8b84dee942bf..f513f4074a93 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -264,6 +264,18 @@ struct clk_ops {
>  	void		(*debug_init)(struct clk_hw *hw, struct dentry
> *dentry);
>  };
>  
> +/**
> + * struct clk_parent_data - clk parent information
> + * @hw: parent clk_hw pointer (used for clk providers with internal clks)
> + * @name: parent name local to provider registering clk
> + * @fallback: globally unique parent name (used as a fallback)
> + */
> +struct clk_parent_data {
> +	struct clk_hw 	*hw;
> +	const char	*name;
> +	const char	*fallback;

If I understand correctly, .name and .fallback will be ignored if hw is
provided ? Maybe this should be documented somehow ?

> +};
> +
>  /**
>   * struct clk_init_data - holds init data that's common to all clocks and
> is
>   * shared between the clock provider and the common clock framework.
> @@ -277,7 +289,10 @@ struct clk_ops {
>  struct clk_init_data {
>  	const char		*name;
>  	const struct clk_ops	*ops;
> -	const char		* const *parent_names;
> +	/* Only one of the following three should be assigned */
> +	const char		* const *parent_names; /* If NULL (and
> num_parents != 0) look at parent_data and parent_hws */
> +	const struct clk_parent_data	*parent_data;
> +	struct clk_hw		**parent_hws;

Isn't parent_hws redundant with parent_data ? you may pass the clk_hw pointer
with both, right ?


>  	u8			num_parents;
>  	unsigned long		flags;
>  };


