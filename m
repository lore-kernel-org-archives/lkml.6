Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030475AbeCAMmD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 07:42:03 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42506 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030447AbeCAMmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 07:42:01 -0500
X-Google-Smtp-Source: AG47ELv1p9gfCMf9B6lstsRHXLC5QrrRoD3jVuw8qGUvGIdGniqzaEbZafpWNpFQ/O8jXfzaCQyayUq9tQoKO1yyr1I=
MIME-Version: 1.0
In-Reply-To: <CAHp75VeVE6vBRAh4mUbgrTACqRuf3iXwNwoW9E9gRjpgWG_aTA@mail.gmail.com>
References: <CGME20180301110252epcas2p3ea455cfb08b2f7edb4af6fbc95addc88@epcas2p3.samsung.com>
 <6699002.vrpdlHjtgs@amdc3058> <CAHp75VeVE6vBRAh4mUbgrTACqRuf3iXwNwoW9E9gRjpgWG_aTA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Mar 2018 13:42:00 +0100
X-Google-Sender-Auth: Q9hEMlQJlZbqIVti-rr7c9XEUnk
Message-ID: <CAMuHMdV0uX3zYe3u1j99HEs9ACtNP4K8z4M769_oiM2E2yOLyA@mail.gmail.com>
Subject: Re: [PATCH v2] ata: add Amiga Gayle PATA controller driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>, linux-ide@vger.kernel.org,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Mar 1, 2018 at 1:32 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Mar 1, 2018 at 1:02 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>> +       base = ZTWO_VADDR(pdata->base);
>
> Hmm... Can't you use devm_ioremap_resources() to get the virtual
> address for I/O ?

Zorro II address space is always mapped, and address conversion done
through ZTWO_VADDR()/ZTWO_PADDR().

>> +       ap->private_data = (void *)ZTWO_VADDR(pdata->irqport);
>> +
>> +       ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", (unsigned long)base,
>> +                     (unsigned long)base + GAYLE_CONTROL);
>
> When you use explicit casting in printf() you are doing in 99.9% cases
> something wrong.

Indeed. This should print the physical addresses, using pdata->base instead
of base.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
