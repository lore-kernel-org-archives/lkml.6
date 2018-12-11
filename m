Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D52EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B50A2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uN0061dA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B50A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeLKODB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:03:01 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54901 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:03:00 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so3634044ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 06:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DilIrTL0MCs06tmRGevnvVt8URXH8KtaGCIvIVsGQbo=;
        b=uN0061dAFMNYsKJ4FAFaNt6dIu/XKXfJK8aEkbq4hvK+ZWHKAZYP3s0IYT9J33MMpO
         1j9uks1O1LNqPbtdEz6Ta7AnBmN2cirMhvhr4/ne+DI1T2P7KEFSjT8SFvCLAzlbzfjp
         76QogmT2H+U34VC3M4NA0CpiRGmrSkPsbzJzd88xnGCJ0QxMHxj336yNdZd++ZwZ5Iyd
         JHd0jNy6fqxllUbAfeieTfYHcM2UI8LYKWoZunZkbLQXPaFQdwM2/njamUn3NdRry/Sq
         9mgu7Pfb8YtLf3JNpC/uW1H9Wxf4ulKaLh3opILRmcLRCNLG/+LHsmfakHHhtZzXN5L3
         GvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DilIrTL0MCs06tmRGevnvVt8URXH8KtaGCIvIVsGQbo=;
        b=A2vp5/enypLr+yA2/aETfJ7jTOwZXGdDY5yWO8dk4YmZeRp+jHWIEEZX//QK4W3NoM
         /8haYEPI9EGES0gX4lChIiSQEr7Osb1dtoXaoKdIkpUsIeZ3M41yudPXqWhm+VaaJvWc
         Js3jBC86RAcSlQp6ALAzGS1ALQ0p39tnmOswAecJCCVroz/DueVoEIZogC08u3/L8Uxj
         VyyIj5imcj1QBAZpnjlicvOMF3gt1gevbqVH2aZqcuBIijPfWBURuiIyIMLqJ6sZDBzX
         IXFYEWvskKQKsXYEaFevmqb8q0QbCqIGHVG+4oKL6Siy7eAVlp+mtsluP4XWnp9OsSOy
         YyYQ==
X-Gm-Message-State: AA+aEWYZOVSuD5w5VkcNqwiPjn5hQHYkBeKbSJmc/DlpUAl4DjafaWJj
        AOT7xAJkJJ2cr16bm2CmCERyz/wsJ9m1h7M6jVmq/ISPyBw=
X-Google-Smtp-Source: AFSGD/UgOhbJaxH4dIchaZvPqOFf2pUS5aDiqeLfDmEzsLc0ELJrUn3Ht6YxZv5hGr3WalixxJmeXckknjmPMHoC/Ek=
X-Received: by 2002:a02:98bb:: with SMTP id q56mr15420761jaj.24.1544536979495;
 Tue, 11 Dec 2018 06:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20181109172132.30939-1-brgl@bgdev.pl>
In-Reply-To: <20181109172132.30939-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 11 Dec 2018 15:02:48 +0100
Message-ID: <CAMRc=MeY_CbdQDF7UOai5MW3OLF1u+a04AAyq5bsux8_Fv5DVQ@mail.gmail.com>
Subject: Re: [PATCH] irq/irq_sim: store multiple interrupt offsets in a bitmap
To:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 9 lis 2018 o 18:21 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a)=
:
>
> Two threads can try to fire the irq_sim with different offsets and will
> end up fighting for the irq_work asignment. Thomas Gleixner suggested a
> solution based on a bitfield where we set a bit for every offset
> associated with an interrupt that should be fired and then iterate over
> all set bits in the interrupt handler.
>
> This is a slightly modified solution using a bitmap so that we don't
> impose a limit on the number of interrupts one can allocate with
> irq_sim.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  include/linux/irq_sim.h |  2 +-
>  kernel/irq/irq_sim.c    | 23 +++++++++++++++++++++--
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> index 630a57e55db6..4500d453a63e 100644
> --- a/include/linux/irq_sim.h
> +++ b/include/linux/irq_sim.h
> @@ -16,7 +16,7 @@
>
>  struct irq_sim_work_ctx {
>         struct irq_work         work;
> -       int                     irq;
> +       unsigned long           *pending;
>  };
>
>  struct irq_sim_irq_ctx {
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index dd20d0d528d4..98a20e1594ce 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -34,9 +34,20 @@ static struct irq_chip irq_sim_irqchip =3D {
>  static void irq_sim_handle_irq(struct irq_work *work)
>  {
>         struct irq_sim_work_ctx *work_ctx;
> +       unsigned int offset =3D 0;
> +       struct irq_sim *sim;
> +       int irqnum;
>
>         work_ctx =3D container_of(work, struct irq_sim_work_ctx, work);
> -       handle_simple_irq(irq_to_desc(work_ctx->irq));
> +       sim =3D container_of(work_ctx, struct irq_sim, work_ctx);
> +
> +       while (!bitmap_empty(work_ctx->pending, sim->irq_count)) {
> +               offset =3D find_next_bit(work_ctx->pending,
> +                                      sim->irq_count, offset);
> +               clear_bit(offset, work_ctx->pending);
> +               irqnum =3D irq_sim_irqnum(sim, offset);
> +               handle_simple_irq(irq_to_desc(irqnum));
> +       }
>  }
>
>  /**
> @@ -63,6 +74,13 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num=
_irqs)
>                 return sim->irq_base;
>         }
>
> +       sim->work_ctx.pending =3D bitmap_zalloc(num_irqs, GFP_KERNEL);
> +       if (!sim->work_ctx.pending) {
> +               kfree(sim->irqs);
> +               irq_free_descs(sim->irq_base, num_irqs);
> +               return -ENOMEM;
> +       }
> +
>         for (i =3D 0; i < num_irqs; i++) {
>                 sim->irqs[i].irqnum =3D sim->irq_base + i;
>                 sim->irqs[i].enabled =3D false;
> @@ -89,6 +107,7 @@ EXPORT_SYMBOL_GPL(irq_sim_init);
>  void irq_sim_fini(struct irq_sim *sim)
>  {
>         irq_work_sync(&sim->work_ctx.work);
> +       bitmap_free(sim->work_ctx.pending);
>         irq_free_descs(sim->irq_base, sim->irq_count);
>         kfree(sim->irqs);
>  }
> @@ -143,7 +162,7 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
>  void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
>  {
>         if (sim->irqs[offset].enabled) {
> -               sim->work_ctx.irq =3D irq_sim_irqnum(sim, offset);
> +               set_bit(offset, sim->work_ctx.pending);
>                 irq_work_queue(&sim->work_ctx.work);
>         }
>  }
> --
> 2.19.1
>

Ping and Cc'ing Marc Zyngier. Any chance of getting this in for 4.21?

Bart
