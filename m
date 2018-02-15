Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967877AbeBOL0T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 06:26:19 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37966 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966662AbeBOL0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 06:26:18 -0500
X-Google-Smtp-Source: AH8x224tWSGWevoKQHBcCmstmnoyGEiHlcJ2LE34VBNXaZTmD7meii+979GwmWC+IH1BvYO23Ej9hPK9fxAquIbz5r0=
MIME-Version: 1.0
In-Reply-To: <20180215111423.96598-1-borntraeger@de.ibm.com>
References: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com> <20180215111423.96598-1-borntraeger@de.ibm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2018 12:26:16 +0100
X-Google-Sender-Auth: IShv1NbgCOYlM4izngakURwsdhg
Message-ID: <CAMuHMdWCK1V3PWXHMNZUmFVMCSqi5xhs72mT_M=gE96TSzMN9w@mail.gmail.com>
Subject: Re: [PATCH] s390/console: enable dummy console for vt
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Farhan Ali <alifm@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Thu, Feb 15, 2018 at 12:14 PM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> To enable the virtual terminal layer with virtio-gpu, we need to
> provide the dummy console. This console is hidden behind CONFIG_IOMEM
> via the graphics support. Instead of fully enabling the graphic
> drivers lets just provide a Kconfig option for the dummy console.
>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> New version: instead of moving around the graphic and console stuff,
> let's just keep an s390 specific variant of CONFIG_DUMMY_CONSOLE
>  arch/s390/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index cbe1d978693a..a69690f616f3 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -952,6 +952,11 @@ config S390_HYPFS_FS
>
>  source "arch/s390/kvm/Kconfig"
>
> +config DUMMY_CONSOLE
> +       bool
> +       depends on VT
> +       default y
> +
>  config S390_GUEST
>         def_bool y
>         prompt "s390 support for virtio devices"

Really?

You already have your own copy of HAS_IOMEM, which makes it hard for
people to track which one applies where.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
