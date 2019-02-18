Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECF4218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LsCygmQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfBRDcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:32:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfBRDcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 22:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oJpnfLVXDDlznXm4C+k813i4B0q9nWDzbudAIucfPAw=; b=LsCygmQxNF1R3QsGi/AzaUIQB
        ud4oG9vLLm41WDReSAORtjVYPOfrqydx3fc0nYmIeKCFnc2KLloXoDgUAQYoThOuzfIOguVuliMkd
        f5ho5hkk6z3JbRaFrFVknEiu7uis7Ubv/7VUjg2snUr/LBXaNMIYwQywtk9hKYVU5ptR/nWD0z8xx
        I0OBN6kSXpJUg6Z08ksRnJ4jSREv/9N6W91Nu7/eMUysN3euy8N5ThKz1gH8piSUeCy7R6TQEm3F+
        Fdh5/D+NqGKrrmClpvZKn7AGMquo4E0vfm5CwzYzNebxDQT7PTc6tWbzuPM7k2+3vDm80UeaxXDFB
        A7zdO3H8A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvZem-00049r-P3; Mon, 18 Feb 2019 03:31:48 +0000
Subject: Re: [PATCH 1/4] component: Add documentation
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5deecf5-5564-b7eb-dcb7-7bfcfdbdb83a@infradead.org>
Date:   Sun, 17 Feb 2019 19:31:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 3:27 PM, Daniel Vetter wrote:

Hi Daniel,

I have a few possible changes for this documentation (see below).

> ---
>  Documentation/driver-api/component.rst   |  17 ++++
>  Documentation/driver-api/device_link.rst |   3 +
>  Documentation/driver-api/index.rst       |   1 +
>  drivers/base/component.c                 | 106 ++++++++++++++++++++++-
>  include/linux/component.h                |  70 +++++++++++++++
>  5 files changed, 194 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/driver-api/component.rst
> 



> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index ddcea8739c12..1624c2a892a5 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -16,6 +16,32 @@
>  #include <linux/slab.h>
>  #include <linux/debugfs.h>
>  
> +/**
> + * DOC: overview
> + *
> + * The component helper allows drivers to collect a pile of sub-devices,
> + * including their bound drivers, into an aggregate driver. Various subsystems
> + * already provide functions to get hold of such components, e.g.
> + * of_clk_get_by_name(). The component helper can be used when such a
> + * subsystem-specific way to find a device is not available: The component
> + * helper fills the niche of aggregate drivers for specific hardware, where
> + * further standardization into a subsystem would not be practical. The common
> + * example is when a logical device (e.g. a DRM display driver) is spread around
> + * the SoC on various component (scanout engines, blending blocks, transcoders

              on various components

> + * for various outputs and so on).
> + *
> + * The component helper also doesn't solve runtime dependencies, e.g. for system
> + * suspend and resume operations. See also :ref:`device links<device_link>`.
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
> @@ -301,10 +327,24 @@ static int component_match_realloc(struct device *dev,
>  	return 0;
>  }
>  
> -/*
> - * Add a component to be matched, with a release function.
> +/**
> + * component_match_add_release - add a component match with release callback
> + * @master: device with the aggregate driver
> + * @matchptr: pointer to the list of component matches
> + * @release: release function for @compare_data
> + * @compare: compare function to match against all components
> + * @compare_data: opaque pointer passed to the @compare function
> + *
> + * Adds a new component match to the list stored in @matchptr, which the @master
> + * aggregate driver needs to function. The list of component matches pointed to
> + * by @matchptr must be initialized to NULL before adding the first match.
> + *
> + * The allocated match list in @matchptr is automatically released using devm
> + * actions, where upon @release will be called to free any references held by
> + * @compare_data, e.g. when @compare_data is a &device_node that must be
> + * released with of_node_put().
>   *
> - * The match array is first created or extended if necessary.
> + * See also component_match_add().
>   */
>  void component_match_add_release(struct device *master,
>  	struct component_match **matchptr,
> @@ -367,6 +407,18 @@ static void free_master(struct master *master)
>  	kfree(master);
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
> + * @match are available, it will be assembled by calling
> + * &component_master_ops.bind from @ops. Must be unregistered by calling
> + * component_master_del().
> + */
>  int component_master_add_with_match(struct device *dev,
>  	const struct component_master_ops *ops,
>  	struct component_match *match)
> @@ -403,6 +455,15 @@ int component_master_add_with_match(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(component_master_add_with_match);
>  
> +/**
> + * component_master_del - unregister an aggregate driver
> + * @dev: device with the aggregate driver
> + * @ops: callbacks for the aggregate driver
> + *
> + * Unregisters an aggregate driver registered with
> + * component_master_add_with_match(). If necessary the aggregate driver is first
> + * disassembled by calling &component_master_ops.unbind from @ops.
> + */
>  void component_master_del(struct device *dev,
>  	const struct component_master_ops *ops)
>  {
> @@ -430,6 +491,15 @@ static void component_unbind(struct component *component,
>  	devres_release_group(component->dev, component);
>  }
>  
> +/**
> + * component_unbind_all - unbind all component to an aggregate driver

                                        components {of | from} an aggregate driver

> + * @master_dev: device with the aggregate driver
> + * @data: opaque pointer, passed to all components
> + *
> + * Unbinds all components to the aggregate @dev by passing @data to their

                             {of | from}

> + * &component_ops.unbind functions. Should be called from
> + * &component_master_ops.unbind.
> + */
>  void component_unbind_all(struct device *master_dev, void *data)
>  {
>  	struct master *master;
> @@ -503,6 +573,15 @@ static int component_bind(struct component *component, struct master *master,
>  	return ret;
>  }
>  
> +/**
> + * component_bind_all - bind all component to an aggregate driver

                                    components

> + * @master_dev: device with the aggregate driver
> + * @data: opaque pointer, passed to all components
> + *
> + * Binds all components to the aggregate @dev by passing @data to their
> + * &component_ops.bind functions. Should be called from
> + * &component_master_ops.bind.
> + */
>  int component_bind_all(struct device *master_dev, void *data)
>  {
>  	struct master *master;
> @@ -537,6 +616,18 @@ int component_bind_all(struct device *master_dev, void *data)
>  }
>  EXPORT_SYMBOL_GPL(component_bind_all);
>  
> +/**
> + * component_add - register a component
> + * @dev: component device
> + * @ops: component callbacks
> + *
> + * Register a new component for @dev. Functions in @ops will be called when the
> + * aggregate driver is ready to bind the overall driver by calling
> + * component_bind_all(). See also &struct component_ops.
> + *
> + * The component needs to be unregistered at driver unload/disconnect by calling
> + * component_del().
> + */
>  int component_add(struct device *dev, const struct component_ops *ops)
>  {
>  	struct component *component;
> @@ -568,6 +659,15 @@ int component_add(struct device *dev, const struct component_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(component_add);
>  
> +/**
> + * component_del - unregister a component
> + * @dev: component device
> + * @ops: component callbacks
> + *
> + * Unregister a component added with component_add(). If the component is bound
> + * into an aggregate driver, this will force the entire aggregate driver, including
> + * all its components, to be unbound.
> + */
>  void component_del(struct device *dev, const struct component_ops *ops)
>  {
>  	struct component *c, *component = NULL;
> diff --git a/include/linux/component.h b/include/linux/component.h
> index e71fbbbc74e2..83da25bdf59c 100644
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
> +	/**
> +	 * @bind:
> +	 *
> +	 * Called through component_bind_all() when the aggregate driver is
> +	 * ready to bind the overall driver.
> +	 */
>  	int (*bind)(struct device *comp, struct device *master,
>  		    void *master_data);
> +	/**
> +	 * @unbind:
> +	 *
> +	 * Called through component_unbind_all() when the aggregate driver is
> +	 * ready to bind the overall driver, or when component_bind_all() fails
> +	 * part-ways through and needs to unbind some already bound components.
> +	 */
>  	void (*unbind)(struct device *comp, struct device *master,
>  		       void *master_data);
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
> +	/**
> +	 * @bind:
> +	 *
> +	 * Called when all components or the aggregate driver, as specified in
> +	 * the match list passed to component_master_add_with_match(), are
> +	 * ready. Usually there are 3 steps to bind an aggregate driver:
> +	 *
> +	 * 1. Allocate a structure for the aggregate driver.
> +	 *
> +	 * 2. Bind all components to the aggregate driver by calling
> +	 *    component_bind_all() with the aggregate driver structure as opaque
> +	 *    pointer data.
> +	 *
> +	 * 3. Register the aggregate driver with the subsystem to publish its
> +	 *    interfaces.
> +	 *
> +	 * Note that the lifetime of the aggregate driver does not align with
> +	 * any of the underlying &struct device instances. Therefore devm cannot
> +	 * be used and all resources acquired or allocated in this callback must
> +	 * be explicitly released in the @unbind callback.
> +	 */
>  	int (*bind)(struct device *master);
> +	/**
> +	 * @unbind:
> +	 *
> +	 * Called when either the aggregate driver, using
> +	 * component_master_del(), or one of its components, using
> +	 * component_del(), is unregistered.
> +	 */
>  	void (*unbind)(struct device *master);
>  };
>  
> @@ -38,6 +92,22 @@ void component_match_add_release(struct device *master,
>  	void (*release)(struct device *, void *),
>  	int (*compare)(struct device *, void *), void *compare_data);
>  
> +/**
> + * component_match_add - add a compent match

                                  component match entry (or item)
?

> + * @master: device with the aggregate driver
> + * @matchptr: pointer to the list of component matches
> + * @compare: compare function to match against all components
> + * @compare_data: opaque pointer passed to the @compare function
> + *
> + * Adds a new component match to the list stored in @matchptr, which the @master
> + * aggregate driver needs to function. The list of component matches pointed to
> + * by @matchptr must be initialized to NULL before adding the first match.
> + *
> + * The allocated match list in @matchptr is automatically released using devm
> + * actions.
> + *
> + * See also component_match_add_release().
> + */
>  static inline void component_match_add(struct device *master,
>  	struct component_match **matchptr,
>  	int (*compare)(struct device *, void *), void *compare_data)
> 


cheers.
-- 
~Randy
