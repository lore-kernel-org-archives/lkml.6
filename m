Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0365DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B471A2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL/+4ah0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B471A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389901AbeKQAxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:53:21 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45122 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbeKQAxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:53:20 -0500
Received: by mail-vs1-f67.google.com with SMTP id v10so6454401vsv.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 06:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dj133bQt9UjDgAy+Qd184kS0Dv4p8xQ0fBSz7eQ3h38=;
        b=AL/+4ah0O+d42MfPSUDqqj6Np6RP/rXb6tBHnttoisa/71z/ZzxEYcyE/s0MNMXuq/
         O3Ig1MAfvuBS4TjZXU9OtgK9OzmyLuxf7TOeQy/hVdWzR9pF2fmZbiq2uxOxpOEnwVy1
         R73TkPY/DnphGi5APs7XDKy2YpirHobYcVQvbibV01K2wO1EoaXxEZSj6u8jxyTHJCDX
         P/L43eM0ieN3usJgOfPsjdnvWOEkttLFg7STunSUZTyLO6qoU9S2OOXhQ2iYUBFYlRCH
         S4Qj/DBial0z7lYjsCnUhJP70zvQ4FNtatCbfo6evIzkumFDZmdSsYghg+aE/guxwbqN
         5RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dj133bQt9UjDgAy+Qd184kS0Dv4p8xQ0fBSz7eQ3h38=;
        b=kDl3O5VOZm865CgOSynmbFZF/Xr0nyPkoxd8eGNMgH5NSi7mtleEIac1xwB5/JRVu2
         NXdF3I+mvvOaIImprLjlAZP+/p7W5+kknRkjS7VyoqHOqp353HYrEjSKaV/MBYzww5az
         hHWqNLiZ67s9OMPlZENj59qdTrCrP8jeEyF+d3SnrmdUh7zT8pXt47jGoaeswMIxFRxW
         Wp1WXoxAl5k+P4G8oM6hZu4QidFLi72kduW0FxhVvAW5oKV+pUe96V2nvK2bhbVhKFVE
         91oBP+BNtu5R2KLs26t+YD3n3HjeUbUIFcjnSsb2DpX6fdsXyylqPcm+H9B97wzQcOY2
         yVWw==
X-Gm-Message-State: AGRZ1gK+wuMxvXT09NLkCvL960OOyWr3Sy6LCcNjwbw84UWLad6p62iF
        JN7SNC8syfJjEGS0PwXHIBZNTuKzIUiavYHJG6I=
X-Google-Smtp-Source: AJdET5cq18VCQ5ohl0IkA2iR8weBZ1EHiTxanxGK+wDA3cDiB6kU/NeC/Bc5YQPdRLIYmRep6T3r7AxsDd1sFETPPzs=
X-Received: by 2002:a67:f756:: with SMTP id w22mr4683239vso.30.1542379240624;
 Fri, 16 Nov 2018 06:40:40 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu> <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
 <49219.1542367988@turing-police.cc.vt.edu>
In-Reply-To: <49219.1542367988@turing-police.cc.vt.edu>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 16 Nov 2018 20:10:28 +0530
Message-ID: <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
Subject: Re: [ARM64] Printing IRQ stack usage information
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        kernelnewbies@kernelnewbies.org,
        Jungseok Lee <jungseoklee85@gmail.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        mark.rutland@arm.com, Sungjinn Chung <barami97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 5:03 PM <valdis.kletnieks@vt.edu> wrote:
>
> On Fri, 16 Nov 2018 11:44:36 +0530, Pintu Agarwal said:
>
> > > If your question is "Did one
> > > of the CPUs blow out its IRQ stack (or come close to doing so)?" there's better
> > > approaches.
> > >
> > Yes, exactly, this is what the main intention.
> > If you have any better idea about this approach, please refer me.
> > It will be of great help.
>
> Look at the code controlled by '#ifdef CONFIG_DEBUG_STACK_USAGE'
> which does the same thing for process stacks, or CONFIG_SCHED_STACK_END_CHECK
> or the use of guard pages for detecting stack overrun....

Hi,

Thank you so much for your reference.
Yes, I have already gone through the process stack usage, which I
found slightly different.
However, I will go through it in more detail, and see if I can gain
some ideas from there.

I found a similar irq_stack_usage implementation in parisc architecture:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/parisc/kernel/irq.c?h=v4.19.1

I have also gone through the unwind_frame() part in arch/arm64/stacktrace.c:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm64/kernel/stacktrace.c?h=v4.9.137

By referring to these, I tried to make a similar approach for arm64:
I created a new function: dump_irq_stack_info()
[arch/arm64/kernel/traps.c], and called it as part of show_stack().

This is the experimental patch I created.
Note: This is just for my experiment purpose. I know this is ugly and
in very bad shape right now.
It is only to get some idea about irq stack usage.

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 11e5eae..6ac855d 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -214,9 +214,39 @@ static void dump_backtrace(struct pt_regs *regs,
struct task_struct *tsk)
        }
 }

+void dump_irq_stack_info(void)
+{
+        int cpu, actual;
+        unsigned long irq_stack_ptr;
+        unsigned long stack_start;
+        unsigned long free_stack;
+
+        actual = IRQ_STACK_SIZE;
+        free_stack = 0;
+        pr_info("CPU UNUSED-STACK ACTUAL-STACK\n");
+
+       for_each_present_cpu(cpu) {
+               unsigned long sp;
+               irq_stack_ptr = IRQ_STACK_PTR(cpu);
+               sp = current_stack_pointer;
+               //sp = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
+               stack_start = (unsigned long)per_cpu(irq_stack, cpu);
+               if (on_irq_stack(sp, cpu)) {
+                       pr_info("cpu:%d : sp: on irq_stack\n", cpu);
+                       free_stack = sp - stack_start;
+               } else {
+                       free_stack = irq_stack_ptr - stack_start;
+               }
+               pr_info("%2d %10lu %10d\n", cpu, free_stack, actual);
+       }
+}
+
 void show_stack(struct task_struct *tsk, unsigned long *sp)
 {
        dump_backtrace(NULL, tsk);
+       dump_irq_stack_info();
        barrier();
 }

Then, I developed a sample kernel module for timer handler
(timerirq.c) and called the dump_stack() function from inside my timer
interrupt handler.
The dump_stack() will internally call show_stack(), which will then
call our function: dump_irq_stack_info().

/* From interrupt context */
static void my_timer_irq_handler(unsigned long ptr)
{
        int i;
        unsigned long flags;

        if (in_interrupt()) {
                pr_info("[timerirq]: %s: in interrupt context, count: %d\n",
                                        __func__, count);
                spin_lock_irqsave(&mylock, flags);
+               dump_stack();
                spin_unlock_irqrestore(&mylock, flags);
        } else {
                /* This is not needed here*/
        }
        tasklet_schedule(&my_tasklet);
}

OUTPUT:
------------
With this, I got the below output as part of dump_stack() and backtrace:
<snip>
[   43.267923] CPU UNUSED-STACK ACTUAL-STACK
[   43.271925]  0      16368      16384
[   43.275493]  1      16368      16384
[   43.279061]  2      16368      16384
[   43.282628] cpu:3 : sp: on irq_stack
[   43.286195]  3      15616      16384
[   43.289762]  4      16368      16384
[   43.293330]  5      16368      16384
[   43.296898]  6      16368      16384
[   43.300465]  7      16368      16384
<snip>

So, I observed that my interrupt handler was executed by cpu3, and
it's irq_stack usage is shown:
3      15616      16384

With this information, I can know that which interrupt handler is
using how much irq_stack ?

Is this approach valid ?
Or still there is much better way to dump the information ?

For example: is it possible to keep storing the irq_stack_usage (for
each cpu in a variable) information from boot time, and then use this
variable to dump the irq_stack information, after the system booted,
may be from proc entry ?


Thanks,
Pintu
