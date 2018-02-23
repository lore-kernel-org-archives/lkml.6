Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeBWH1C (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:27:02 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46475 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeBWH07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:26:59 -0500
X-Google-Smtp-Source: AG47ELuXrXl2H2vMHv4Xbq3dMHjDwx7K0AIT/g4zkdXoGF1CnSEb7wmVdMh8YHUHtVsUQRh/hFMWyHJH9EgreOU9BCw=
MIME-Version: 1.0
In-Reply-To: <20180223130920.1db2c245@canb.auug.org.au>
References: <20180223130920.1db2c245@canb.auug.org.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2018 08:26:58 +0100
X-Google-Sender-Auth: Q9ui3Hby9g0iPLR8QTAvrN_USUo
Message-ID: <CAMuHMdWma8eh5A=EE4Jw3PTO+yNfMHg9xhfN2umatY2QwNPBjg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kvms390 tree with the nds32 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, Greentime Hu <green.hu@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Farhan Ali <alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 3:09 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the kvms390 tree got a conflict in:
>
>   drivers/video/console/Kconfig
>
> between commit:
>
>   2312dbf7462b ("drivers/video/concole: add negative dependency for VGA_CONSOLE on nds32")
>
> from the nds32 tree and commit:
>
>   2f1ca75f69f3 ("s390/setup : enable display support for KVM guest")
>
> from the kvms390 tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/video/console/Kconfig
> index 27bb893cf6b2,7aa721e3a581..000000000000
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@@ -9,7 -9,7 +9,7 @@@ config VGA_CONSOL
>         depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
>                 !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
>                 (!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
> -               !ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32
>  -              !ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390
> ++              !ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32 && !S390
>         default y
>         help
>           Saying Y here will allow you to use Linux in text mode through a

Which brings us to repeating the old advice: "The next new architecture added
should invest the work to add a MAY_HAVE_VGA_CONSOLE Kconfig symbol, to be
selected by the handful architectures/platforms that can have a VGA console".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
