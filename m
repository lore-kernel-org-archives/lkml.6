Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9179C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B1F20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549363693;
	bh=l0lTr6k9h7znnjwkB/50BRxQTE3FQGsmRXdhZZ8IWpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tKCqU0ZboobhLRRRD8IsBeGldDBy89UxxZmXZLEhKqCYVlFiOenSqI3L2UpDzfqoo
	 XAdD7ZyomvjAD6GwM0ZuLaa247VtPMjhqMqW2SV+wAYcxNtz+to7q4zG913CdaDTB+
	 jgDvgxVmtk89q9b7TKJfWYJR4NmL1CD3xqBzHxFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfBEKsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:48:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46554 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEKsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:48:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so4819767otm.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2Xjzn71EhybUPZIpK0m2Lio2H12xATQxztDqAzix1E=;
        b=W8X+WFteli8DAa0PNqecXpJEA14sQoxXGsGJKMfLj3b/27xS42y5Wnt+KArHw5yKzi
         3BfHsjgVKzoPUlbab7GeHJ19S5yotYxb/Shc8Oh4swGEYjBmt7k9DjDHhkPZxj/L+MoI
         ACFucXphxviKcbw4K9fwM2jQXd/vuV1QWUInArbMV8JK5MUXy0X0WKvnHvyWcjlTdirm
         cho1IaAxVLqsaIG5/Fj5d2uVA/qfUpa9Ubnp6lSyxd0PSCA5Y0hVTavQqsgzOnboi2Ov
         MnJM2jToVjb7XuxS5NWecaM8bLXk0kxaf5fjPN5np6ipD0rYDKE+FY5N7PvshOnC3tcS
         zyhA==
X-Gm-Message-State: AHQUAubbOMHAIekOjPUBZWbRgyfC5YLZKYFSvsIcvsnN+c/n/KxInuNr
        K0n6AcemzBa/PGT0fn/yZW3/zO/VVUiKoyFgzDk=
X-Google-Smtp-Source: AHgI3IbMTcEuHP7o6Y5EAG9yG9iMgyeZ8foQxmcQ0q4ZvAOWkIHhZoNexkUe/K9CTlxF0OBb1cgwCfMImmvA9XqAo+0=
X-Received: by 2002:aca:368a:: with SMTP id d132mr2269358oia.193.1549363689923;
 Tue, 05 Feb 2019 02:48:09 -0800 (PST)
MIME-Version: 1.0
References: <1548917996-28081-2-git-send-email-ramalingam.c@intel.com> <20190131144640.17896-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190131144640.17896-1-daniel.vetter@ffwll.ch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Feb 2019 11:47:58 +0100
Message-ID: <CAJZ5v0hhYnRs+J6w+EAsd=0+MJ9irBThLiUC+ptgvyKyeo5f7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] component: Add documentation
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 w/compOn Thu, Jan 31, 2019 at 3:46 PM Daniel Vetter
<daniel.vetter@ffwll.ch> wrote:
>
> Someone owes me a beer ...
>
> While typing these I think doing an s/component_master/aggregate/
> would be useful:
> - it's shorter :-)
> - I think component/aggregate is much more meaningful naming than
>   component/puppetmaster or something like that. At least to my
>   English ear "aggregate" emphasizes much more the "assemble a pile of
>   things into something bigger" aspect, and there's not really much
>   of a control hierarchy between aggregate and constituing components.
>
> But that's way more than a quick doc typing exercise ...
>
> Thanks to Ram for commenting on an initial draft of these docs.

Look goods to me overall (even though I'm not super-familiar with the
component framework), but see below.

> Cc: "C, Ramalingam" <ramalingam.c@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  Documentation/driver-api/device_link.rst |   3 +
>  Documentation/driver-api/index.rst       |   1 +
>  drivers/base/component.c                 | 107 ++++++++++++++++++++++-
>  include/linux/component.h                |  70 +++++++++++++++
>  4 files changed, 178 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
> index d6763272e747..2d5919b2b337 100644
> --- a/Documentation/driver-api/device_link.rst
> +++ b/Documentation/driver-api/device_link.rst
> @@ -1,6 +1,9 @@
>  .. |struct dev_pm_domain| replace:: :c:type:`struct dev_pm_domain <dev_pm_domain>`
>  .. |struct generic_pm_domain| replace:: :c:type:`struct generic_pm_domain <generic_pm_domain>`
>
> +
> +.. _device_link:
> +
>  ============
>  Device links
>  ============
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index ab38ced66a44..c0b600ed9961 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -22,6 +22,7 @@ available subsections can be seen below.
>     device_connection
>     dma-buf
>     device_link
> +   component

Do I think correctly that this doc is going to be generated
automatically from the kerneldoc comments in component.c?

>     message-based
>     sound
>     frame-buffer
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index ddcea8739c12..e5b04bce8544 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -16,6 +16,33 @@
>  #include <linux/slab.h>
>  #include <linux/debugfs.h>
>
> +/**
> + * DOC: overview
> + *
> + * The component frameworks allows drivers to collect a pile of sub-devices,

s/frameworks/framework/

> + * including their bound drivers, into an aggregate driver. Various subsystem

s/subsystem/subsystems/

> + * already provide functions to get hold of such components, e.g.
> + * of_clk_get_by_name(). Anytime there's such a subsystem specific way to find a
> + * a device the component framework should not be used.

I would use a positive statement here, like "The component framework
can be used when such a subsystem-specific way to find a device is not
available".

> The component framework
> + * fills the niche of aggregate drivers for specific hardware, where further
> + * standardization into a subsystem doesn't make sense.

I would say "would not be practical" instead of "doesn't make sense".

> The common example is
> + * when a logical device (e.g. a DRM display driver) is spread around the SoC on
> + * various component (scanout engines, blending blocks, transcoders for various
> + * outputs and so on).
> + *
> + * The component framework also doesn't solve runtime dependencies, e.g. for
> + * system suspend and resume operations. See also :ref:`device
> + * links<device_link>`.
> + *
> + * Components are registered using component_add() and unregistered with
> + * component_del(), usually from the driver's probe and disconnect functions.
> + *
> + * Aggregate drivers first assemble a component match list of what they need
> + * using component_match_add(). This is then registered as an aggregate driver
> + * using component_master_add_with_match(), and unregistered using
> + * component_master_del().
> + */
> +
>  struct component;
>
>  struct component_match_array {
> @@ -301,10 +328,24 @@ static int component_match_realloc(struct device *dev,
>         return 0;
>  }
>
> -/*
> - * Add a component to be matched, with a release function.
> +/**
> + * component_match_add_release - add a compent match with release callback

s/compent/component/ ?

> + * @master: device with the aggregate driver
> + * @matchptr: pointer to the list of component matches
> + * @release: release function for @compare_data
> + * @compare: compare function to match against all components
> + * @compare_data: opaque pointer passed to the @compare function
> + *
> + * This adds a new component match to the list stored in @matchptr, which the
> + * @master aggregate driver needs to function. @matchptr must be initialized to
> + * NULL before adding the first match.
> + *
> + * The allocated match list in @matchptr is automatically released using devm
> + * actions. At that point @release will be called, to free any references held
> + * by @compare_data, e.g. when @compare_data is a &device_node that must be
> + * released with of_node_put().
>   *
> - * The match array is first created or extended if necessary.
> + * See also component_match_add().
>   */
>  void component_match_add_release(struct device *master,
>         struct component_match **matchptr,
> @@ -367,6 +408,18 @@ static void free_master(struct master *master)
>         kfree(master);
>  }
>
> +/**
> + * component_master_add_with_match - register an aggregate driver
> + * @dev: device with the aggregate driver
> + * @ops: callbacks for the aggregate driver
> + * @match: component match list for the aggregate driver
> + *
> + * Registers a new aggregate driver consisting of the components added to @match
> + * by calling one of the component_match_add() functions. Once all components in
> + * @match are available it will be assembled by calling

A comma seems to be missing after "available".

> + * &component_master_ops.bind from @ops. Must be unregistered by calling
> + * component_master_del().
> + */
>  int component_master_add_with_match(struct device *dev,
>         const struct component_master_ops *ops,
>         struct component_match *match)
> @@ -403,6 +456,15 @@ int component_master_add_with_match(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(component_master_add_with_match);
>
> +/**
> + * component_master_del - unregister an aggregate driver
> + * @dev: device with the aggregate driver
> + * @ops: callbacks for the aggregate driver
> + *
> + * Unregistered an aggregate driver registered with

s/Unregistered/Unregisters/ ?

> + * component_master_add_with_match(). If necessary the aggregate driver is first
> + * disassembled by calling &component_master_ops.unbind from @ops.

Q: How does the &component_master_ops.unbind annotation work?  Does it
produce any special output?

> + */
>  void component_master_del(struct device *dev,
>         const struct component_master_ops *ops)
>  {
> @@ -430,6 +492,15 @@ static void component_unbind(struct component *component,
>         devres_release_group(component->dev, component);
>  }
>
> +/**
> + * component_unbind_all - unbind all component to an aggregate driver
> + * @master_dev: device with the aggregate driver
> + * @data: opaque pointer, passed to all components
> + *
> + * This unbinds all components to the aggregate @dev by passing @data to their

I guess "This" is redundant.

> + * &component_ops.unbind functions. Should be called from
> + * &component_master_ops.unbind.
> + */
>  void component_unbind_all(struct device *master_dev, void *data)
>  {
>         struct master *master;
> @@ -503,6 +574,15 @@ static int component_bind(struct component *component, struct master *master,
>         return ret;
>  }
>
> +/**
> + * component_bind_all - bind all component to an aggregate driver
> + * @master_dev: device with the aggregate driver
> + * @data: opaque pointer, passed to all components
> + *
> + * This binds all components to the aggregate @dev by passing @data to their

Likewise.

> + * &component_ops.bind functions. Should be called from
> + * &component_master_ops.bind.
> + */
>  int component_bind_all(struct device *master_dev, void *data)
>  {
>         struct master *master;
> @@ -537,6 +617,18 @@ int component_bind_all(struct device *master_dev, void *data)
>  }
>  EXPORT_SYMBOL_GPL(component_bind_all);
>
> +/**
> + * component_add - register a component
> + * @dev: component device
> + * @ops: component callbacks
> + *
> + * Register a new component for @dev. Functions in @ops will be call when the

s/call/called/

> + * aggregate driver is ready to bind the overall driver by calling
> + * component_bind_all(). See also &struct component_ops.
> + *
> + * The component needs to be unregistered again at driver unload/disconnect by
> + * calling component_del().
> + */
>  int component_add(struct device *dev, const struct component_ops *ops)
>  {
>         struct component *component;
> @@ -568,6 +660,15 @@ int component_add(struct device *dev, const struct component_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(component_add);
>
> +/**
> + * component_del - unregister a component
> + * @dev: component device
> + * @ops: component callbacks
> + *
> + * Unregister a component added with component_add(). If the component is bound
> + * into an aggregate driver this will force the entire aggrate driver, including

A comma is missing after "driver".  Also s/aggrate/aggregate/

> + * all its components, to be unbound.
> + */
>  void component_del(struct device *dev, const struct component_ops *ops)
>  {
>         struct component *c, *component = NULL;
> diff --git a/include/linux/component.h b/include/linux/component.h
> index e71fbbbc74e2..67a899dd2e10 100644
> --- a/include/linux/component.h
> +++ b/include/linux/component.h
> @@ -4,11 +4,31 @@
>
>  #include <linux/stddef.h>
>
> +
>  struct device;
>
> +/**
> + * struct component_ops - callbacks for component drivers
> + *
> + * Components are registered with component_add() and unregistered with
> + * component_del().
> + */
>  struct component_ops {
> +       /**
> +        * @bind:
> +        *
> +        * Called through component_bind_all() when the aggregate driver is
> +        * ready to bind the overall driver.
> +        */
>         int (*bind)(struct device *comp, struct device *master,
>                     void *master_data);
> +       /**
> +        * @unbind:
> +        *
> +        * Called through component_unbind_all() when the aggregate driver is
> +        * ready to bind the overall driver, or when component_bind_all() fails
> +        * part-ways through and needs to unbind some already bound components.
> +        */
>         void (*unbind)(struct device *comp, struct device *master,
>                        void *master_data);
>  };
> @@ -21,8 +41,42 @@ void component_unbind_all(struct device *master, void *master_data);
>
>  struct master;
>
> +/**
> + * struct component_master_ops - callback for the aggregate driver
> + *
> + * Aggregate drivers are registered with component_master_add_with_match() and
> + * unregistered with component_master_del().
> + */
>  struct component_master_ops {
> +       /**
> +        * @bind:
> +        *
> +        * Called when all components or the aggregate driver, as specified in
> +        * the match list passed to component_master_add_with_match(), are
> +        * ready. Usually there are 3 steps to bind an aggregate driver:
> +        *
> +        * 1. Allocate a structure for the aggregate driver.
> +        *
> +        * 2. Bind all components to the aggregate driver by calling
> +        *    component_bind_all() with the aggregate driver structure as opaque
> +        *    pointer data.
> +        *
> +        * 3. Register the aggregate driver with the subsystem to publish its
> +        *    interfaces.
> +        *
> +        * Note that the lifetime of the aggregate driver does not align with
> +        * any of the underlying &struct device instances. Therefore devm cannot
> +        * be used and all resources acquired or allocated in this callback must
> +        * be expecitly released in the @unbind callback.

s/expecitly/explicitly/

> +        */
>         int (*bind)(struct device *master);
> +       /**
> +        * @unbind:
> +        *
> +        * Called when either the aggregate driver, using
> +        * component_master_del(), or one of its components, using
> +        * component_del(), is unregistered.
> +        */
>         void (*unbind)(struct device *master);
>  };
>
> @@ -38,6 +92,22 @@ void component_match_add_release(struct device *master,
>         void (*release)(struct device *, void *),
>         int (*compare)(struct device *, void *), void *compare_data);
>
> +/**
> + * component_match_add - add a compent match
> + * @master: device with the aggregate driver
> + * @matchptr: pointer to the list of component matches
> + * @compare: compare function to match against all components
> + * @compare_data: opaque pointer passed to the @compare function
> + *
> + * This adds a new component match to the list stored in @matchptr, which the

"This" appears to be redundant.

> + * @master aggregate driver needs to function. @matchptr must be initialized to
> + * NULL before adding the first match.
> + *
> + * The allocated match list in @matchptr is automatically released using devm
> + * actions.
> + *
> + * See also component_match_add_release().
> + */
>  static inline void component_match_add(struct device *master,
>         struct component_match **matchptr,
>         int (*compare)(struct device *, void *), void *compare_data)
> --
> 2.20.1
>
