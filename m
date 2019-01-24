Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4016CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054D121855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfAXHlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:41:13 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42422 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfAXHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:41:12 -0500
Received: by mail-vs1-f67.google.com with SMTP id b74so2950163vsd.9;
        Wed, 23 Jan 2019 23:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmszsbSzBqPLuRbPR1q3jrnvTIr131JX+t3IN0KzXos=;
        b=IUPNtVXthEl5jIXQym8Xyi6/82yqQezpOuvk0P3WsG3DmAQNAftqwmrwR70QDngtA0
         eCH5G5NULMYvu/eoNFYdsck+tjVBYKDazPvHmeH9M4Hrfy4eeTkuAC3jTkuds+kMB1Hh
         lGY9cemeVyR7BqtnqVaUeoHTg9HpzoNupI4JNN4xbtWnL+koCQU4iGTuwM98/h/v59LH
         ck1o9lgtjCUhN5DswuIPSeAQVk1FBJAyfKtLqVyNZi6whu/L/upPN4McxgbUmUa0MZAQ
         KA9l6ALqd2hN0xbKCTM82a5kwh/waMwsXPWMKSR3+ww3M60mwEkSQqj3nfeYXI/q2s7S
         FZmg==
X-Gm-Message-State: AJcUukdDudiK2zTuNzNmOlXZm6VYF53EsM828CckQylDHG2DT+hHMdl2
        3D406Q/VADkd6fYLX47nlso7uLjv5G30rSfxM2I=
X-Google-Smtp-Source: ALg8bN4uQLejlT9E719pzyY2j+UMsKvU7KcuOXBX6+9GpbVx66u8mBIGXY354AbWGPH8g4jmSA+3Zj/qi6V4MEnTqNI=
X-Received: by 2002:a67:d119:: with SMTP id u25mr2086343vsi.63.1548315670716;
 Wed, 23 Jan 2019 23:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20190107175127.21240-1-geert+renesas@glider.be>
In-Reply-To: <20190107175127.21240-1-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Jan 2019 08:40:58 +0100
Message-ID: <CAMuHMdULGBXmbN+zSqzbXWUT3oi=ALfpRV191VFv4i17fgTfMw@mail.gmail.com>
Subject: Re: [RFC] device-tree: resets properties, reset topology, and shared resets
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Mark,

Ping, can you please provide your feedback?
Even if you have no comments, please say so.

Thanks again!

On Mon, Jan 7, 2019 at 6:51 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Best Wishes for 2019!
>
> Can you please provide your opinion on parsing the whole device tree for
> "resets" phandle properties to find shared resets, cfr. patch [1] below?
>
> This is a prerequisite for safe generic reset handling for
> virtualization on DT-based platforms, cfr. patch [2].
>
> Many thanks in advance!
>
> References:
>   1. [PATCH v3] reset: Exclusive resets must be dedicated to a single
>      hardware block
>      https://lore.kernel.org/lkml/20181113133520.20889-1-geert+renesas@glider.be/
>   2. [PATCH v5] vfio: platform: Add generic reset controller support
>      https://lore.kernel.org/lkml/20181113131508.18246-1-geert+renesas@glider.be/
>
> From 96418942472531d736dffd64ff5ae90d055d71b0 Mon Sep 17 00:00:00 2001
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Date: Mon, 17 Sep 2018 16:34:26 +0200
> Subject: [PATCH v3] reset: Exclusive resets must be dedicated to a single
>  hardware block
>
> In some SoCs multiple hardware blocks may share a reset control.
> The reset control API for shared resets will only assert such a reset
> when the drivers for all hardware blocks agree.
> The exclusive reset control API still allows to assert such a reset, but
> that impacts all other hardware blocks sharing the reset.
>
> While the kernel doc comments clearly state that the API for shared
> resets applies to reset controls which are shared between hardware
> blocks, the exact meaning of exclusive resets is not documented.
> Fix the semantic ambiguity with respect to exclusive access vs.
> exclusive reset lines by:
>   1. Clarifying that exclusive resets really are intended for use with
>      reset controls which are dedicated to a single hardware block,
>   2. Ensuring that obtaining an exclusive reset control will fail if the
>      reset is shared by multiple hardware blocks, for both DT-based and
>      lookup-based reset controls.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Question from Philipp for the DT maintainers:
>
>    "I'd still like to hear the device tree maintainers' opinion on
>     parsing the whole DT for "resets" phandle properties to find shared
>     resets like this."
>
> Thanks!
>
> v3:
>   - Make args parameter of __of_reset_is_exclusive() a pointer,
>   - Print a warning when detecting a shared reset,
>   - Rebase on top of of_node_put() move,
>
> v2:
>   - Fix wrong variable in __reset_is_dedicated() loop,
>   - Add missing of_node_put() in __of_reset_is_dedicated(),
>   - Document that exclusive reset controls imply they are dedicated to a
>     single hardware block,
>   - Drop new dedicated flag and new API reset_control_get_dedicated(),
>     as exclusive already implies dedicated,
>   - Rename {__of_,}reset_is_dedicated() to {__of_,}reset_is_exclusive(),
>   - Reword description.
>
> Note: Exclusive lookup-based reset controls were not tested.
> ---
>  drivers/reset/core.c  | 67 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/reset.h |  5 +++-
>  2 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index bce2d6aefef98131..022740cfab9f429e 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -459,6 +459,42 @@ static void __reset_control_put_internal(struct reset_control *rstc)
>         kref_put(&rstc->refcnt, __reset_control_release);
>  }
>
> +static bool __of_reset_is_exclusive(const struct device_node *node,
> +                                   const struct of_phandle_args *args,
> +                                   const char *id)
> +{
> +       struct of_phandle_args args2;
> +       struct device_node *node2;
> +       int index, ret;
> +       bool eq;
> +
> +       for_each_node_with_property(node2, "resets") {
> +               if (node == node2)
> +                       continue;
> +
> +               for (index = 0; ; index++) {
> +                       ret = of_parse_phandle_with_args(node2, "resets",
> +                                                        "#reset-cells", index,
> +                                                        &args2);
> +                       if (ret)
> +                               break;
> +
> +                       eq = (args2.np == args.np &&
> +                             args2.args_count == args.args_count &&
> +                             !memcmp(args2.args, args.args,
> +                                     args.args_count * sizeof(args.args[0])));
> +                       of_node_put(args2.np);
> +                       if (eq) {
> +                               pr_warn("%pOF requests exclusive control over reset %s shared with %pOF on %pOF\n",
> +                                       node, id, node2, args->np);
> +                               return false;
> +                       }
> +               }
> +       }
> +
> +       return true;
> +}
> +
>  struct reset_control *__of_reset_control_get(struct device_node *node,
>                                      const char *id, int index, bool shared,
>                                      bool optional)
> @@ -513,6 +549,11 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
>                 goto out;
>         }
>
> +       if (!shared && !__of_reset_is_exclusive(node, &args, id)) {
> +               rstc = ERR_PTR(-EINVAL);
> +               goto out;
> +       }
> +
>         /* reset_list_mutex also protects the rcdev's reset_control list */
>         rstc = __reset_control_get_internal(rcdev, rstc_id, shared);
>
> @@ -542,6 +583,27 @@ __reset_controller_by_name(const char *name)
>         return NULL;
>  }
>
> +static bool __reset_is_exclusive(const struct reset_control_lookup *lookup)
> +{
> +       const struct reset_control_lookup *lookup2;
> +
> +       list_for_each_entry(lookup2, &reset_lookup_list, list) {
> +               if (lookup2 == lookup)
> +                       continue;
> +
> +               if (lookup2->provider == lookup->provider &&
> +                   lookup2->index == lookup->index) {
> +                       pr_warn("%s/%s requests exclusive control over reset %s:%u shared with %s/%s",
> +                               lookup->dev_id, lookup->con_id,
> +                               lookup->provider, lookup->index,
> +                               lookup2->dev_id, lookup2->con_id);
> +                       return false;
> +               }
> +       }
> +
> +       return true;
> +}
> +
>  static struct reset_control *
>  __reset_control_get_from_lookup(struct device *dev, const char *con_id,
>                                 bool shared, bool optional)
> @@ -563,6 +625,11 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
>                 if ((!con_id && !lookup->con_id) ||
>                     ((con_id && lookup->con_id) &&
>                      !strcmp(con_id, lookup->con_id))) {
> +                       if (!shared && !__reset_is_exclusive(lookup)) {
> +                               mutex_unlock(&reset_lookup_mutex);
> +                               return ERR_PTR(-EINVAL);
> +                       }
> +
>                         mutex_lock(&reset_list_mutex);
>                         rcdev = __reset_controller_by_name(lookup->provider);
>                         if (!rcdev) {
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index b7f3ad691ee9773e..2698b36bd1eb3e0c 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -123,8 +123,11 @@ static inline int device_reset_optional(struct device *dev)
>   * @id: reset line name
>   *
>   * Returns a struct reset_control or IS_ERR() condition containing errno.
> - * If this function is called more than once for the same reset_control it will
> + * If this function is called more than once for the same reset control it will
>   * return -EBUSY.
> + * This function is intended for use with reset controls which are dedicated
> + * to a single hardware block.  If called for a reset control shared among
> + * multiple hardware blocks, it will return -EINVAL.
>   *
>   * See reset_control_get_shared for details on shared references to
>   * reset-controls.
> --
> 2.17.1

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
