Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC58C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C9F21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549582242;
	bh=UzrJH70RihoLsMJ7KZpC8J3w2y5zo0RHm9uDNSD55zk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MXs7ILsIX5scbN3z9XF4YS35gK6FKewJUDSvQMJZQ9/+wXMQw9jCCu7hRvuwejmhb
	 1gzOyqlFahWO8zXxmO0ulnCGWhoeAPN1HrTQeZ/qqf+2iSZNefb01CCSNhA3Ze4FYV
	 lOzCBX/i8bf6GlJLHC8mxbfSUu+AZp0iHhLklT4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBGXak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:30:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38584 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGXaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:30:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so2954145otl.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhu+PaPuqqBEvleA2oHaND12G2hKxUrm28uYH3dUrCA=;
        b=L20dWtsB4xEsWmusoithe3p7t2gBrdOc/9yJMiFI8MF4KVezQHZMvWVKFpAHxnMOhR
         e9SIbGC2v6R6zN23kdHG9rzkiXnKXQIWSIMPUVhXC5EkCS/oMJV6apNR0UqGm6MBKYWB
         qcm2rkhYIwansy8KNI9hI7LVjZ4FuDCDHW7lEp6arBIdbiOqgVuPNXvbldhVnt7DMrfy
         UC4Hks/aNyNXCzCeG/i0KtQHhC9NfKi7+kzrqa1braQQZLujnNUGewsfi5HfxRH1e+DJ
         PKb3hoWbPvpQW7rBa/xFReGh7J3Mg+/Z/TGFm208LBNc4+H3WkeEJ2xfGaAHfBJ5RL/7
         qM6Q==
X-Gm-Message-State: AHQUAuZV30dq/Kjx5NYxtLaxNoYZ4prmQiWRf2YKvywn+dzAX6jCyw6s
        rKFXV2l5ayuwN/31EEzDs4Yv+I+/bBsV/A4dRTU=
X-Google-Smtp-Source: AHgI3IaJfwXLaz1ejVYiVJ99M5EQ/pAhu6ROohS+ll7xUFm9eK5zkBKPpn1ndEyzUYH5F+hqsUhqNZLpSR3DgN1LrE4=
X-Received: by 2002:aca:c591:: with SMTP id v139mr378556oif.76.1549582238616;
 Thu, 07 Feb 2019 15:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20190207232759.14553-1-daniel.vetter@ffwll.ch> <20190207232759.14553-2-daniel.vetter@ffwll.ch>
In-Reply-To: <20190207232759.14553-2-daniel.vetter@ffwll.ch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Feb 2019 00:30:27 +0100
Message-ID: <CAJZ5v0hqfitWiuLO4PEedyhbkp3wWs9gA74PXcF=cRe_W6w0wg@mail.gmail.com>
Subject: Re: [PATCH 2/4] components: multiple components for a device
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 12:28 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> Component framework is extended to support multiple components for
> a struct device. These will be matched with different masters based on
> its sub component value.
>
> We are introducing this, as I915 needs two different components
> with different subcomponent value, which will be matched to two
> different component masters(Audio and HDCP) based on the subcomponent
> values.
>
> v2: Add documenation.
>
> v3: Rebase on top of updated documenation.
>
> v4: Review from Rafael:
> - Remove redundant "This" from kerneldoc (also in the previous patch)
> - Streamline the logic in find_component() a bit.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch> (v1 code)
> Signed-off-by: Ramalingam C <ramalingam.c@intel.com> (v1 commit message)
> Cc: Ramalingam C <ramalingam.c@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/component.c  | 158 +++++++++++++++++++++++++++++---------
>  include/linux/component.h |  10 ++-
>  2 files changed, 129 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index 1624c2a892a5..7dbc41cccd58 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -47,6 +47,7 @@ struct component;
>  struct component_match_array {
>         void *data;
>         int (*compare)(struct device *, void *);
> +       int (*compare_typed)(struct device *, int, void *);
>         void (*release)(struct device *, void *);
>         struct component *component;
>         bool duplicate;
> @@ -74,6 +75,7 @@ struct component {
>         bool bound;
>
>         const struct component_ops *ops;
> +       int subcomponent;
>         struct device *dev;
>  };
>
> @@ -158,7 +160,7 @@ static struct master *__master_find(struct device *dev,
>  }
>
>  static struct component *find_component(struct master *master,
> -       int (*compare)(struct device *, void *), void *compare_data)
> +       struct component_match_array *mc)
>  {
>         struct component *c;
>
> @@ -166,7 +168,11 @@ static struct component *find_component(struct master *master,
>                 if (c->master && c->master != master)
>                         continue;
>
> -               if (compare(c->dev, compare_data))
> +               if (mc->compare && mc->compare(c->dev, mc->data))
> +                       return c;
> +
> +               if (mc->compare_typed &&
> +                   mc->compare_typed(c->dev, c->subcomponent, mc->data))
>                         return c;
>         }
>
> @@ -192,7 +198,7 @@ static int find_components(struct master *master)
>                 if (match->compare[i].component)
>                         continue;
>
> -               c = find_component(master, mc->compare, mc->data);
> +               c = find_component(master, mc);
>                 if (!c) {
>                         ret = -ENXIO;
>                         break;
> @@ -327,29 +333,12 @@ static int component_match_realloc(struct device *dev,
>         return 0;
>  }
>
> -/**
> - * component_match_add_release - add a component match with release callback
> - * @master: device with the aggregate driver
> - * @matchptr: pointer to the list of component matches
> - * @release: release function for @compare_data
> - * @compare: compare function to match against all components
> - * @compare_data: opaque pointer passed to the @compare function
> - *
> - * Adds a new component match to the list stored in @matchptr, which the @master
> - * aggregate driver needs to function. The list of component matches pointed to
> - * by @matchptr must be initialized to NULL before adding the first match.
> - *
> - * The allocated match list in @matchptr is automatically released using devm
> - * actions, where upon @release will be called to free any references held by
> - * @compare_data, e.g. when @compare_data is a &device_node that must be
> - * released with of_node_put().
> - *
> - * See also component_match_add().
> - */
> -void component_match_add_release(struct device *master,
> +static void __component_match_add(struct device *master,
>         struct component_match **matchptr,
>         void (*release)(struct device *, void *),
> -       int (*compare)(struct device *, void *), void *compare_data)
> +       int (*compare)(struct device *, void *),
> +       int (*compare_typed)(struct device *, int, void *),
> +       void *compare_data)
>  {
>         struct component_match *match = *matchptr;
>
> @@ -381,13 +370,69 @@ void component_match_add_release(struct device *master,
>         }
>
>         match->compare[match->num].compare = compare;
> +       match->compare[match->num].compare_typed = compare_typed;
>         match->compare[match->num].release = release;
>         match->compare[match->num].data = compare_data;
>         match->compare[match->num].component = NULL;
>         match->num++;
>  }
> +
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
> + * by @matchptr must be initialized to NULL before adding the first match. This
> + * only matches against components added with component_add().
> + *
> + * The allocated match list in @matchptr is automatically released using devm
> + * actions, where upon @release will be called to free any references held by
> + * @compare_data, e.g. when @compare_data is a &device_node that must be
> + * released with of_node_put().
> + *
> + * See also component_match_add() and component_match_add_typed().
> + */
> +void component_match_add_release(struct device *master,
> +       struct component_match **matchptr,
> +       void (*release)(struct device *, void *),
> +       int (*compare)(struct device *, void *), void *compare_data)
> +{
> +       __component_match_add(master, matchptr, release, compare, NULL,
> +                             compare_data);
> +}
>  EXPORT_SYMBOL(component_match_add_release);
>
> +/**
> + * component_match_add_typed - add a compent match for a typed component
> + * @master: device with the aggregate driver
> + * @matchptr: pointer to the list of component matches
> + * @compare_typed: compare function to match against all typed components
> + * @compare_data: opaque pointer passed to the @compare function
> + *
> + * Adds a new component match to the list stored in @matchptr, which the @master
> + * aggregate driver needs to function. The list of component matches pointed to
> + * by @matchptr must be initialized to NULL before adding the first match. This
> + * only matches against components added with component_add_typed().
> + *
> + * The allocated match list in @matchptr is automatically released using devm
> + * actions.
> + *
> + * See also component_match_add_release() and component_match_add_typed().
> + */
> +void component_match_add_typed(struct device *master,
> +       struct component_match **matchptr,
> +       int (*compare_typed)(struct device *, int, void *), void *compare_data)
> +{
> +       __component_match_add(master, matchptr, NULL, NULL, compare_typed,
> +                             compare_data);
> +}
> +EXPORT_SYMBOL(component_match_add_typed);
> +
>  static void free_master(struct master *master)
>  {
>         struct component_match *match = master->match;
> @@ -616,19 +661,8 @@ int component_bind_all(struct device *master_dev, void *data)
>  }
>  EXPORT_SYMBOL_GPL(component_bind_all);
>
> -/**
> - * component_add - register a component
> - * @dev: component device
> - * @ops: component callbacks
> - *
> - * Register a new component for @dev. Functions in @ops will be called when the
> - * aggregate driver is ready to bind the overall driver by calling
> - * component_bind_all(). See also &struct component_ops.
> - *
> - * The component needs to be unregistered at driver unload/disconnect by calling
> - * component_del().
> - */
> -int component_add(struct device *dev, const struct component_ops *ops)
> +static int __component_add(struct device *dev, const struct component_ops *ops,
> +       int subcomponent)
>  {
>         struct component *component;
>         int ret;
> @@ -639,6 +673,7 @@ int component_add(struct device *dev, const struct component_ops *ops)
>
>         component->ops = ops;
>         component->dev = dev;
> +       component->subcomponent = subcomponent;
>
>         dev_dbg(dev, "adding component (ops %ps)\n", ops);
>
> @@ -657,6 +692,55 @@ int component_add(struct device *dev, const struct component_ops *ops)
>
>         return ret < 0 ? ret : 0;
>  }
> +
> +/**
> + * component_add_typed - register a component
> + * @dev: component device
> + * @ops: component callbacks
> + * @subcomponent: nonzero identifier for subcomponents
> + *
> + * Register a new component for @dev. Functions in @ops will be call when the
> + * aggregate driver is ready to bind the overall driver by calling
> + * component_bind_all(). See also &struct component_ops.
> + *
> + * @subcomponent must be nonzero and is used to differentiate between multiple
> + * components registerd on the same device @dev. These components are match
> + * using component_match_add_typed().
> + *
> + * The component needs to be unregistered at driver unload/disconnect by
> + * calling component_del().
> + *
> + * See also component_add().
> + */
> +int component_add_typed(struct device *dev, const struct component_ops *ops,
> +       int subcomponent)
> +{
> +       if (WARN_ON(subcomponent == 0))
> +               return -EINVAL;
> +
> +       return __component_add(dev, ops, subcomponent);
> +}
> +EXPORT_SYMBOL_GPL(component_add_typed);
> +
> +/**
> + * component_add - register a component
> + * @dev: component device
> + * @ops: component callbacks
> + *
> + * Register a new component for @dev. Functions in @ops will be called when the
> + * aggregate driver is ready to bind the overall driver by calling
> + * component_bind_all(). See also &struct component_ops.
> + *
> + * The component needs to be unregistered at driver unload/disconnect by
> + * calling component_del().
> + *
> + * See also component_add_typed() for a variant that allows multipled different
> + * components on the same device.
> + */
> +int component_add(struct device *dev, const struct component_ops *ops)
> +{
> +       return __component_add(dev, ops, 0);
> +}
>  EXPORT_SYMBOL_GPL(component_add);
>
>  /**
> diff --git a/include/linux/component.h b/include/linux/component.h
> index 83da25bdf59c..30bcc7e590eb 100644
> --- a/include/linux/component.h
> +++ b/include/linux/component.h
> @@ -34,6 +34,8 @@ struct component_ops {
>  };
>
>  int component_add(struct device *, const struct component_ops *);
> +int component_add_typed(struct device *dev, const struct component_ops *ops,
> +       int subcomponent);
>  void component_del(struct device *, const struct component_ops *);
>
>  int component_bind_all(struct device *master, void *master_data);
> @@ -91,6 +93,9 @@ void component_match_add_release(struct device *master,
>         struct component_match **matchptr,
>         void (*release)(struct device *, void *),
>         int (*compare)(struct device *, void *), void *compare_data);
> +void component_match_add_typed(struct device *master,
> +       struct component_match **matchptr,
> +       int (*compare_typed)(struct device *, int, void *), void *compare_data);
>
>  /**
>   * component_match_add - add a compent match
> @@ -101,12 +106,13 @@ void component_match_add_release(struct device *master,
>   *
>   * Adds a new component match to the list stored in @matchptr, which the @master
>   * aggregate driver needs to function. The list of component matches pointed to
> - * by @matchptr must be initialized to NULL before adding the first match.
> + * by @matchptr must be initialized to NULL before adding the first match. This
> + * only matches against components added with component_add().
>   *
>   * The allocated match list in @matchptr is automatically released using devm
>   * actions.
>   *
> - * See also component_match_add_release().
> + * See also component_match_add_release() and component_match_add_typed().
>   */
>  static inline void component_match_add(struct device *master,
>         struct component_match **matchptr,
> --
> 2.20.1
>
