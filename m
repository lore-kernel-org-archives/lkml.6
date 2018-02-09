Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeBIIsv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:48:51 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36576 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeBIIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:48:50 -0500
X-Google-Smtp-Source: AH8x226jPwV2gr4bMBnd27APuJlsc3ei0XOJzfRk0+DwtlsDckh7L+dsZ51TeZG3JMvQ5BNPpGkcYYfU0UU+M+KGX38=
MIME-Version: 1.0
In-Reply-To: <20180209021031.20631-1-jaedon.shin@gmail.com>
References: <20180209021031.20631-1-jaedon.shin@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Feb 2018 09:48:48 +0100
X-Google-Sender-Auth: RoxBSjWB4i7i220GSR2RhDFTock
Message-ID: <CAMuHMdXOtrnMrNkuexHdpX+asaG1ADwmb5JWwAYYrvvvn0P8ZQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Use %px to print pointer value
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaedon,

On Fri, Feb 9, 2018 at 3:10 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> pointers printed with %p are hashed. Use %px instead of %p to print
> pointer value.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Thanks for your patch!

> --- a/drivers/irqchip/irq-bcm7038-l1.c
> +++ b/drivers/irqchip/irq-bcm7038-l1.c
> @@ -339,7 +339,7 @@ int __init bcm7038_l1_of_init(struct device_node *dn,
>                 goto out_unmap;
>         }
>
> -       pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
> +       pr_info("registered BCM7038 L1 intc (mem: 0x%px, IRQs: %d)\n",
>                 intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);

I believe the printing of this value should just be removed.
Printing virtual addresses of mapped registers is usually not helpful, except
for an attacker.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
