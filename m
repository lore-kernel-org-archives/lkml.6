Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932954AbeBUK0t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:26:49 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43499 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932751AbeBUK0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:26:46 -0500
X-Google-Smtp-Source: AG47ELvRBrsxkH7GAlt6MsrHX25597PdbbwKCHTFwlt0njzydCDG/A3/Hcc5VrETZZf6XEPs9/nr0CtGcMGOq6Iae6k=
MIME-Version: 1.0
In-Reply-To: <20180220231046.32638-4-laurent.pinchart+renesas@ideasonboard.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com> <20180220231046.32638-4-laurent.pinchart+renesas@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2018 11:26:45 +0100
X-Google-Sender-Auth: KsfK_zOogbvvNeB7x1j044Ek74c
Message-ID: <CAMuHMdWQEKETp50VnU4eiHcXvBqzgdwH1z6CYbkJq_YH1=UHaw@mail.gmail.com>
Subject: Re: [PATCH v4 03/16] of: dynamic: Add __of_node_dupv()
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Feb 21, 2018 at 12:10 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>
> Add an __of_node_dupv() private method and make __of_node_dup() use it.
> This is required for the subsequent changeset accessors which will
> make use of it.
>
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/of/dynamic.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 7bb33d22b4e2..4ffd04925fdf 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -382,8 +382,9 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
>  }
>
>  /**
> - * __of_node_dup() - Duplicate or create an empty device node dynamically.
> - * @fmt: Format string (plus vargs) for new full name of the device node
> + * __of_node_dupv() - Duplicate or create an empty device node dynamically.
> + * @fmt: Format string for new full name of the device node
> + * @vargs: va_list containing the arugments for the node full name
>   *
>   * Create an device tree node, either by duplicating an empty node or by allocating
>   * an empty one suitable for further modification.  The node data are
> @@ -391,17 +392,15 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
>   * OF_DETACHED bits set. Returns the newly allocated node or NULL on out of
>   * memory error.
>   */
> -struct device_node *__of_node_dup(const struct device_node *np, const char *fmt, ...)
> +struct device_node *__of_node_dupv(const struct device_node *np,

static, cfr.
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/overlays&id=c45324e1807dd708344c9a478b777b68aca11cdf

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
