Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CDCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651112192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEPWweyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392186AbfBOVZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:25:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35627 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732447AbfBOVZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:25:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so11123316wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0eNnBFBktbtxDxrzUPCKk05GafV7DZx/ivyVqIoqsg=;
        b=hEPWweyYvV5qvXYIqQ796fTLMOb7hWgcdPsTIGElX64WbhuVyYKgU6kR/AgPRghzU4
         X5wNOYTSGQ/SWCT6HiSy8cQd37mRljTyPOtDE/+TEUs88A3mcNy8FuJ4RtqBg+/XtmiB
         VgMc9qaGs4Gx2V3prDYzT3rfjEVV+JJOUGNmdNXCzrOvteQazXDjNEzGmaqR0iNdKt5c
         k8yzhFgOeFoRiMb2dvi/onRx40E5ERjWKNQJ0tHw99zX2aSye1dxUur1lr601wx+yxbQ
         J8rhwXoz7eqMto1mlN/RmLqnBXnHM8ybWTooCEcC6WClwbbpcef/pKp5ZMlWP+lDj1UX
         LYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0eNnBFBktbtxDxrzUPCKk05GafV7DZx/ivyVqIoqsg=;
        b=hO8WHqepj8doN59DQtx0xCmnptGYN6snlHvp3UQ7UfilQSjRZg1MZThERH45TGP0FO
         1oT0kb6SmCxME4Z82G8HXAl4xHpW4RNl5kTjcWyRU1JPirrTV//mPc/XWdvFpO6jnVIX
         JzDQrhOD8S1zdIyCr8VVKyLQxV/PVN8J1dWwpSyCbsIAdJ/Dw5g39QBPEHKIiR01WIfA
         0GoDvdYy5O1bJ+E3Kbe9Xtxga6pUhcjse/7iodI3LiB9jVXdCvZmkOMDxXx+N3Spt5Sx
         2ajf2gwwCOC59Pq6EDWPVJT+ceDcCXZ9BIVq9CT5mFHiWr6LK/ci1fo9ufCw3RxTT3Vb
         RU4g==
X-Gm-Message-State: AHQUAua94YyuvdFciFINOmMTHVR8T3xTSS363PxU2dG/7NWtcZHOjj54
        IHbuGWACXxPdyjyj1TanJlB2KcxJstscL84EMhxpgQ==
X-Google-Smtp-Source: AHgI3IZmguYXipKQMfTuOXjJkooyZs6/vm6XCA0gbIJMwjWcl4FQQhqeJE3rpXCRNEiMaKQAT6dUCt+KjXTyGosMqUU=
X-Received: by 2002:a1c:f71a:: with SMTP id v26mr7355333wmh.131.1550265899784;
 Fri, 15 Feb 2019 13:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20180430031222.mapajgwprkkr6p36@sultan-box> <201804301721.JEar9rKK%fengguang.wu@intel.com>
 <20180430151229.pen4kay5qjbrg2f3@sultan-box>
In-Reply-To: <20180430151229.pen4kay5qjbrg2f3@sultan-box>
From:   Sultan Alsawaf <sultanxda@gmail.com>
Date:   Fri, 15 Feb 2019 13:24:48 -0800
Message-ID: <CAME=51PpCSD61=f5oC-zO3o1VrrusZob4fyfN_KZt1P5Omkj8w@mail.gmail.com>
Subject: Re: [PATCH] random: remove unused argument from add_interrupt_randomness()
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is still an issue in the latest kernel version.

Sultan

On Mon, Apr 30, 2018 at 8:12 AM Sultan Alsawaf <sultanxda@gmail.com> wrote:
>
> From a872cf4f0bb57a7bb3c95ea557082fb7733344f8 Mon Sep 17 00:00:00 2001
> From: Sultan Alsawaf <sultanxda@gmail.com>
> Date: Sun, 29 Apr 2018 20:04:35 -0700
> Subject: [PATCH] random: remove unused argument from
>  add_interrupt_randomness()
>
> The irq_flags parameter is not used. Remove it.
>
> Signed-off-by: Sultan Alsawaf <sultanxda@gmail.com>
> ---
>  drivers/char/random.c  | 4 ++--
>  drivers/hv/hv.c        | 2 +-
>  drivers/hv/vmbus_drv.c | 2 +-
>  include/linux/random.h | 2 +-
>  kernel/irq/handle.c    | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 3cd3aae24d6d..125c1f545277 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -131,7 +131,7 @@
>   *     void add_device_randomness(const void *buf, unsigned int size);
>   *     void add_input_randomness(unsigned int type, unsigned int code,
>   *                                unsigned int value);
> - *     void add_interrupt_randomness(int irq, int irq_flags);
> + *     void add_interrupt_randomness(int irq);
>   *     void add_disk_randomness(struct gendisk *disk);
>   *
>   * add_device_randomness() is for adding data to the random pool that
> @@ -1189,7 +1189,7 @@ static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
>         return *ptr;
>  }
>
> -void add_interrupt_randomness(int irq, int irq_flags)
> +void add_interrupt_randomness(int irq)
>  {
>         struct entropy_store    *r;
>         struct fast_pool        *fast_pool = this_cpu_ptr(&irq_randomness);
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 9b82549cbbc8..4b76ba23d666 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -115,7 +115,7 @@ static void hv_stimer0_isr(void)
>
>         hv_cpu = this_cpu_ptr(hv_context.cpu_context);
>         hv_cpu->clk_evt->event_handler(hv_cpu->clk_evt);
> -       add_interrupt_randomness(stimer0_vector, 0);
> +       add_interrupt_randomness(stimer0_vector);
>  }
>
>  static int hv_ce_set_next_event(unsigned long delta,
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index b10fe26c4891..41f4116f8c31 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1015,7 +1015,7 @@ static void vmbus_isr(void)
>                         tasklet_schedule(&hv_cpu->msg_dpc);
>         }
>
> -       add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
> +       add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR);
>  }
>
>
> diff --git a/include/linux/random.h b/include/linux/random.h
> index 2ddf13b4281e..210400258fef 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -32,7 +32,7 @@ static inline void add_latent_entropy(void) {}
>
>  extern void add_input_randomness(unsigned int type, unsigned int code,
>                                  unsigned int value) __latent_entropy;
> -extern void add_interrupt_randomness(int irq, int irq_flags) __latent_entropy;
> +extern void add_interrupt_randomness(int irq) __latent_entropy;
>
>  extern void get_random_bytes(void *buf, int nbytes);
>  extern int wait_for_random_bytes(void);
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index 38554bc35375..e2f7afcb1ae6 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -188,7 +188,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
>
>         retval = __handle_irq_event_percpu(desc, &flags);
>
> -       add_interrupt_randomness(desc->irq_data.irq, flags);
> +       add_interrupt_randomness(desc->irq_data.irq);
>
>         if (!noirqdebug)
>                 note_interrupt(desc, retval);
> --
> 2.14.1
