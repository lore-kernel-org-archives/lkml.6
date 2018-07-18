Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35228ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81D72075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAflv8Hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81D72075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbeGRP1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:27:44 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38368 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbeGRP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:27:43 -0400
Received: by mail-ua0-f193.google.com with SMTP id o11-v6so3094366uak.5;
        Wed, 18 Jul 2018 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=8WC6zN7cagcGzNmY7MQZYR8/CbgZEuX7H8uqtMwZq2o=;
        b=DAflv8HrFdeXjgOz5v+pYkHJvadcZS9anI1VCThl2K9qJvS9KqpoCzAi6lHAui0/kL
         oyibWjiA4/gMLatJuT2O8Ej9q12fgL1vImNmu91RbwV/qvQV9en3seB8hvKQQ3Z+M7UB
         m0iQomr8e1weTobZqbdD1cvWg4olbv1rMIH3vSWD/pirERE2HxBVNpnZhTLEbQIe8TLf
         JZsD+c1UG0IT1OHtHz06AVm00XWnZQFd4X4VSYU44GB7Pci91BFDR6B5epMv7JeTimpc
         OXSm4NpXgEYNnDGvG7U0+p7TIiOgDkt68tCYNVpcabCK2U+itXQK3TZOQACuyCMxkt0o
         mEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8WC6zN7cagcGzNmY7MQZYR8/CbgZEuX7H8uqtMwZq2o=;
        b=qhoOS81OKisZWRYdYQtBCGh7Ren+RzSe6xZSzR5a9EvbJDe5jy/7JDCjzvMvOmzhnn
         h41rdKQR6KkV5DKDQAjpuHN6b2qUdOADwqEjiqLQxe/EzR3WUfhHEJnfzZYYsIski/Vb
         jXZkVgEk6746PCiQMDVRh9VAwWaUMekXbkN/QzvNpYmnhcx+3fKP6z8336r2uuVoEAQA
         3PFXn2BRwRUajMPx+s3CtfTfqK/UlDW8yC5amoHaeN0GPk5KkpWVZDYlZ2x9G/FgNWZ/
         WyDYR+XIIM+MACEimedC5y/S5M0hnOn4HSMgwPrzhSaecoiZtVfL2gWMji5oKaHiTE/q
         NaFQ==
X-Gm-Message-State: AOUpUlGEMujixmqJRVDMowjD+zGwaO92EqxcD+/7ISGN6sdQc1B7llSg
        jRk8f2eIhzkE26A2YV75LG+/rAOg3NWKMIVZjegYYQ==
X-Google-Smtp-Source: AAOMgpcZJ+Ej3g7dNhh4ys8qgpucgpOYtrIc7K5Ztb810lxTXB/8Qs35Uyf/46WXraLw3VPMhjcsx3n9yl9Vru3z/28=
X-Received: by 2002:ab0:4705:: with SMTP id h5-v6mr4111295uac.140.1531925367247;
 Wed, 18 Jul 2018 07:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiK9tdHF6k+mNSqEQG92hA9oo4C+obhiwpjVOi_zaBZXw@mail.gmail.com>
In-Reply-To: <CAOuPNLiK9tdHF6k+mNSqEQG92hA9oo4C+obhiwpjVOi_zaBZXw@mail.gmail.com>
From:   Pintu Kumar <pintu.ping@gmail.com>
Date:   Wed, 18 Jul 2018 20:19:15 +0530
Message-ID: <CAOuPNLhTBdzj8B_u9f7FLXHwaA5KYVwPoy87LaZNhzLxbuifaQ@mail.gmail.com>
Subject: Re: [PREEMPT_RT]: Using printk-rt-aware.patch in non-rt kernel
To:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a question about PREEMPT_RT patch for 3.10 kernel.
I am trying to port this rt patch: 0224-printk-rt-aware.patch.patch
(see the patch below), in non-rt kernel.
I could able to successfully apply this patch after replacing:
migrate_enable/disable with preempt_enable/disable.
Things were working fine so far.

Then, I noticed that "printk" from interrupt context is not appearing
on console (minicom), if console shell is active.
However, it appears on the dmesg output.

So, I am wondering, what could be the cause of this patch for this
behavior in non-rt kernel?
Is this the expected behavior, even on PREEMPT_RT kernel?
Is there a way we can fix this issue on non-rt kernel?

Please help us with your suggestions.

Thanks,
Pintu

On Wed, Jun 13, 2018 at 8:02 PM Pintu Kumar <pintu.ping@gmail.com> wrote:
>
> Dear Thomas,
>
> I was looking into this RT patches for 3.10 kernel:
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/3.10/patches-3.10.108-rt123.tar.gz
>
> And I came across your patch: 0224-printk-rt-aware.patch.patch
> I guess, this patch is related to improving irq latency during printk.
> And this patch can work only if PREEMPT_RT_FULL is enabled.
>
> But, I have 3.10 non-RT kernel, and still I want to use this feature
> for non-RT case and achieve the same functionality.
> Can you give me some idea, how to convert this RT patch to non-RT
> kernel and still achieve the same behavior.
> I know this is weird but it is our internal requirement.
>

> So, if you have any suggestions, it will be really helpful.
>
> Thank You!
>
> Regards,
> Pintu
>
> This is the patch details:
> -----------------------------------
> rt-patches/patches$ cat 0224-printk-rt-aware.patch.patch
> From ec944721d45454681485906615affa9368e0dfae Mon Sep 17 00:00:00 2001
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Wed, 19 Sep 2012 14:50:37 +0200
> Subject: [PATCH 224/405] printk-rt-aware.patch
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/printk.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/printk.c b/kernel/printk.c
> index e879b8615a0f..07d32a2c8a5f 100644
> --- a/kernel/printk.c
> +++ b/kernel/printk.c
> @@ -1277,6 +1277,7 @@ static void call_console_drivers(int level,
> const char *text, size_t len)
>         if (!console_drivers)
>                 return;
>
> +       migrate_disable();
>         for_each_console(con) {
>                 if (exclusive_console && con != exclusive_console)
>                         continue;
> @@ -1289,6 +1290,7 @@ static void call_console_drivers(int level,
> const char *text, size_t len)
>                         continue;
>                 con->write(con, text, len);
>         }
> +       migrate_enable();
>  }
>
>  /*
> @@ -1348,12 +1350,18 @@ static inline int can_use_console(unsigned int cpu)
>   * interrupts disabled. It should return with 'lockbuf_lock'
>   * released but interrupts still disabled.
>   */
> -static int console_trylock_for_printk(unsigned int cpu)
> +static int console_trylock_for_printk(unsigned int cpu, unsigned long flags)
>         __releases(&logbuf_lock)
>  {
>         int retval = 0, wake = 0;
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +       int lock = !early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
> +               (preempt_count() <= 1);
> +#else
> +       int lock = 1;
> +#endif
>
> -       if (console_trylock()) {
> +       if (lock && console_trylock()) {
>                 retval = 1;
>
>                 /*
> @@ -1688,8 +1696,15 @@ asmlinkage int vprintk_emit(int facility, int level,
>          * The console_trylock_for_printk() function will release 'logbuf_lock'
>          * regardless of whether it actually gets the console semaphore or not.
>          */
> -       if (console_trylock_for_printk(this_cpu))
> +       if (console_trylock_for_printk(this_cpu, flags)) {
> +#ifndef CONFIG_PREEMPT_RT_FULL
>                 console_unlock();
> +#else
> +               raw_local_irq_restore(flags);
> +               console_unlock();
> +               raw_local_irq_save(flags);
> +#endif
> +       }
>
>         lockdep_on();
>  out_restore_irqs:
> @@ -2043,11 +2058,16 @@ static void console_cont_flush(char *text, size_t size)
>                 goto out;
>
>         len = cont_print_text(text, size);
> +#ifndef CONFIG_PREEMPT_RT_FULL
>         raw_spin_unlock(&logbuf_lock);
>         stop_critical_timings();
>         call_console_drivers(cont.level, text, len);
>         start_critical_timings();
>         local_irq_restore(flags);
> +#else
> +       raw_spin_unlock_irqrestore(&logbuf_lock, flags);
> +       call_console_drivers(cont.level, text, len);
> +#endif
>         return;
>  out:
>         raw_spin_unlock_irqrestore(&logbuf_lock, flags);
> @@ -2141,13 +2161,17 @@ skip:
>                 console_idx = log_next(console_idx);
>                 console_seq++;
>                 console_prev = msg->flags;
> -               raw_spin_unlock(&logbuf_lock);
>
> +#ifndef CONFIG_PREEMPT_RT_FULL
> +               raw_spin_unlock(&logbuf_lock);
>                 stop_critical_timings();        /* don't trace print latency */
>                 call_console_drivers(level, text, len);
>                 start_critical_timings();
>                 local_irq_restore(flags);
> -
> +#else
> +               raw_spin_unlock_irqrestore(&logbuf_lock, flags);
> +               call_console_drivers(level, text, len);
> +#endif
>                 if (do_cond_resched)
>                         cond_resched();
>         }
> --
> 2.13.2
