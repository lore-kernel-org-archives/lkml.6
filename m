Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC636C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3E62081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CjwTCiI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfBDJ7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:59:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43932 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfBDJ7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:59:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id r2so1955852wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 01:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeI2DtFyd3cY+jY1489HFbl0luQvdWGB6TJ7lBabdo0=;
        b=CjwTCiI8T4M3Hz/dfytA4ZuN726PaIpQZTJy2Xq/FvGNqvtthG1FC+Oe24vxhrffkb
         0wnNg1uPr3xSmRnTtrxaWp/kry6Qp6IIyqY3tWdsEAG8MUW9KS4geftLJqWAgMJlnuB+
         Tw4XXVnRU7rtNXfMp/YB0jiKOGeUMB5EpxY4b8f/oASH6lfeHTGA98eNJ4PjgfeweNL3
         5k24J2MjXHaz+lEzkqN6jSpZkFhUZspCP0IsvkiNHPqi849m7XGHjqvIZ8Ky5onoozdC
         OSr2HlfcTamOyLdhYf5fGt8PHwK7yUwVRL4N+alXI3IxPwhcZvY/ybEcntcBpEaT4Nce
         M72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeI2DtFyd3cY+jY1489HFbl0luQvdWGB6TJ7lBabdo0=;
        b=o/Iiwb6Ztb3qNTXKgAtl3iOJ6YgBRb1jdOH4aRP+E164mi676efd1Kxo+ExLrj605u
         8vo2V/3Gn44/fs0IN3JHLiszoTHnAjhwe6I1P0OvZ/F/L391bC8H8xPmS8v5/JB5CpAW
         xERtGLO+E5iuCZvLmiXT5iDVEDGI6mAnhaEJOg04/+X51ikVxsprVybIRhPksCXzEFDv
         gSXlIslfoU73VMYkEA9g007PYq4zr+DyjcJoQlB5KClQU868JDhhnvLefJrNee/fb/m6
         h2/3DrmpQDS2Zc9sfa/+KpQXkl99uetvQbJuXJrVSh+kbA1NjP34FE9dFMBUEejxY9Uh
         UnFA==
X-Gm-Message-State: AJcUukcg20cKNrIDPlHZsg2OUBOq1i7ytfRT1eXl+oAaia7jX8OrE/2U
        KSv5ZCAkS7lRSyQWbnZkMFcdzMF/hP0dZWiat50nogAmpV0TJQ==
X-Google-Smtp-Source: ALg8bN7lHMO6Hlgap21U4xcnbHcWEtLdg+eW0yH5Qmwtj7w62V9elNN46ayTwvt2/0GSaE1FI0Z1QIqG1JP7CaHzTno=
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr47728456wro.29.1549274385281;
 Mon, 04 Feb 2019 01:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20190204094937.22763-1-narmstrong@baylibre.com>
In-Reply-To: <20190204094937.22763-1-narmstrong@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Mon, 4 Feb 2019 10:59:34 +0100
Message-ID: <CAMO6nawKrH3d2X=TikdJy8yjiPyuJJRnpaBjyfPYuRx3d=7vVA@mail.gmail.com>
Subject: Re: [PATCH] soc: amlogic: canvas: Fix meson_canvas_get when probe failed
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
On Mon, Feb 4, 2019 at 10:49 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> When probe fails, a platforn_device is still associated to the node,
> but dev_get_drvdata() returns NULL.
>
> Handle this case by returning a consistent error.
>
> Fixes: d4983983d987 ("soc: amlogic: add meson-canvas driver")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/soc/amlogic/meson-canvas.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> This fix depends on "soc: amlogic: add missing of_node_put()" at [1]
>
> [1] https://patchwork.kernel.org/patch/10794545/
>
> diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
> index 87a6c6e23591..151aa84bc593 100644
> --- a/drivers/soc/amlogic/meson-canvas.c
> +++ b/drivers/soc/amlogic/meson-canvas.c
> @@ -51,6 +51,7 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
>  {
>         struct device_node *canvas_node;
>         struct platform_device *canvas_pdev;
> +       struct meson_canvas *canvas;
>
>         canvas_node = of_parse_phandle(dev->of_node, "amlogic,canvas", 0);
>         if (!canvas_node)
> @@ -63,7 +64,17 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
>         }
>
>         of_node_put(canvas_node);
> -       return dev_get_drvdata(&canvas_pdev->dev);
> +
> +       /*
> +        * If priv is NULL, it's probably because the canvas hasn't
> +        * properly initialized. Bait out with -EINVAL because, in the

Bait -> Bail ?

> +        * current state, this driver probe cannot return -EPROBE_DEFER
> +        */
> +       canvas = dev_get_drvdata(&canvas_pdev->dev);
> +       if (!canvas)
> +               return ERR_PTR(-EINVAL);
> +
> +       return canvas;
>  }
>  EXPORT_SYMBOL_GPL(meson_canvas_get);
>
> --
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Thanks for the patch, I missed the fact that a driver could have a
pdev yet with a failed probe.

Reviewed-by: Maxime Jourdan <mjourdan@baylibre.com>
