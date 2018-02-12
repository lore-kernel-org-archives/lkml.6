Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933007AbeBLI3O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:29:14 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44647 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932625AbeBLI3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:29:12 -0500
X-Google-Smtp-Source: AH8x226bjrEVpnenjD0WPfQZQaIfEN1lWQTMMYMP/wJIpK43Y4EEF9AqUBWpoIbJEJ3CNi2eL0mMbgKHdriYJymIJ7k=
MIME-Version: 1.0
In-Reply-To: <219b4da3972b28307c599f7d340e613303de7ed7.1518397634.git.fthain@telegraphics.com.au>
References: <cover.1518397634.git.fthain@telegraphics.com.au> <219b4da3972b28307c599f7d340e613303de7ed7.1518397634.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2018 09:29:11 +0100
X-Google-Sender-Auth: VUZXzsGWcktGiga2kyHnPJNm-ls
Message-ID: <CAMuHMdUoiVhA5BxVpxJ81VxZ5Y_n1DBugqPxhABE5Z8eL1Bd3w@mail.gmail.com>
Subject: Re: [PATCH net v4 09/13] net/mac8390: Convert to nubus_driver
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 4:08 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> This resolves an old bug that constrained this driver to no more than
> one card.
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

> --- a/drivers/net/ethernet/8390/mac8390.c
> +++ b/drivers/net/ethernet/8390/mac8390.c

> @@ -390,86 +389,86 @@ static bool __init mac8390_init(struct net_device *dev,
>         return true;
>  }
>
> -struct net_device * __init mac8390_probe(int unit)
> +static int mac8390_device_probe(struct nubus_board *board)
>  {
>         struct net_device *dev;
> -       struct nubus_rsrc *ndev = NULL;
>         int err = -ENODEV;
> -       static unsigned int slots;
> -
> -       enum mac8390_type cardtype;
> -
> -       /* probably should check for Nubus instead */
> +       struct nubus_rsrc *fres;
> +       enum mac8390_type cardtype = MAC8390_NONE;
>
>         if (!MACH_IS_MAC)
> -               return ERR_PTR(-ENODEV);
> +               return -ENODEV;

I think this check can be removed completely, as the nubus_board will
exist on suitable Macs only.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
