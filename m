Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55976C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0957420871
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5jj4Oa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0957420871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeKSS6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:58:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39047 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbeKSS6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:58:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so9812894pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 00:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OKGbvDglEgffSrggvr3EYdJVXrnGD5uXE1ImKP89pok=;
        b=A5jj4Oa+o2MCRB5zPYl9C+Bjx6yl2S9KUkghG0etuqUMzRyZ74IFfwjOSoQOlQc4Th
         U7bSJw+jbylG8MzAHrSqjGyI4ZO5JZt2IZnFLXHQVnjKeEGgDml7Oqww81SdXoc6Gtk1
         QnQA99p/IG1OdEF03+B0PlCXhF/aYhUzTLB0Yr/YbKe7zwCm4F/UCz3gaKiKE005tBWR
         7SgteQosSygfE0pOntXGKFbY3H3IQfDIrbw6QaQ/TKg8+93GUrvubTIBuo5K8cWcB9Fh
         KDlqCJQl0pkcQaUC5jGP5+/qa3QxYzrL2NszxeW458qBiqEnx0Swy0ucd1bhp8QAGnI7
         kxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OKGbvDglEgffSrggvr3EYdJVXrnGD5uXE1ImKP89pok=;
        b=Foz3+4cXDkNAst1JmXfJ1ORtdwmxp0NAPIEsQ8LAP8FIvfSpXKL5ao6UlC3PIZIRAO
         zKKsYsVi3gwRZ0ydBX7fNPybNLlpMD55KGkKLB4WWvmKXVfc+K7dsQCW7sozBskdRnHb
         6RLuEljOlLEQeDc5FePytdLLIVlaF20hZ1Ls9xb1cOPEidJERn5fLfR59SqnpvhEqIQG
         JzkeQQRG2AjMSixROk7JA4RuYt5rGtwWMdprY8xLCaoeuNQimotiw7EMdvGcAEGJkaHd
         eN2exr6+kZDBw2LQsLIz90P+hiacMPALJl8PLcybo1t/xUyBrMl8D02btX1QSAuVP+qk
         HI8g==
X-Gm-Message-State: AGRZ1gKPsgwB/aL3ui6gyQvL5tYLEuPkihRUvWPLWJDI5i/1RN7BUUAz
        VUezHh/rWZtTOR50Ljeq3GormkbQLjc=
X-Google-Smtp-Source: AJdET5eo4N/gZIo1mAYDvgth9o+Ja5hCj3rYbg7qTB4NF25h+jxfQwzNsPxEsgvSS7xjw9/FYK96uw==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr19423202pgq.189.1542616552468;
        Mon, 19 Nov 2018 00:35:52 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id b2sm50765857pfm.3.2018.11.19.00.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 00:35:51 -0800 (PST)
Subject: Re: [RFC PATCH v2 07/14] m68k: atari: Convert to clocksource API
To:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1542589838.git.fthain@telegraphics.com.au>
 <b94b3aed32c0ae0f5de786ffc746ffb20fbe2d1e.1542589838.git.fthain@telegraphics.com.au>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c465ebbb-69f8-c42c-c2d0-0e57dffe30a5@gmail.com>
Date:   Mon, 19 Nov 2018 21:35:27 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <b94b3aed32c0ae0f5de786ffc746ffb20fbe2d1e.1542589838.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

this fixes the ssh timeout issues I reported for the earlier versions. 
Can't see a large degradation of resolution either.

The race in the previous versions may have been exacerbated in part by 
an incorrect assumption about the likelihood of counter wrap-around in 
the old atari_gettimeoffset() implementation. The comment in the code 
states that the likelihood is just 2%, so skips the interrupt pending 
bit check if the counter has run down more than 2%. It does not follow 
that the counter never runs down further than that threshold though. I 
have found the distribution of counter values observed with interrupt 
pending to be quite long-tailed, with a 50% threshold just beginning to 
catch the majority of wrap-arounds.

Your solution to stop the clock instead of allowing a jump backwards is 
much safer in this context.

Am 19.11.2018 um 14:10 schrieb Finn Thain:
> Add a platform clocksource by adapting the existing arch_gettimeoffset
> implementation.
>
> Normally the MFP timer C interrupt flag would be used to check for
> timer counter wrap-around. Unfortunately, that flag gets cleared by the
> MFP itself (due to automatic EOI mode). This means that
> mfp_timer_c_handler() and atari_read_clk() must race when accounting
> for counter wrap-around.
>
> That problem is avoided here by effectively stopping the clock when it
> might otherwise jump backwards. This harms clock accuracy; the result
> is not much better than the jiffies clocksource. Also, clock error is
> no longer uniformly distributed.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> ---
> TODO: find a spare counter for the clocksource, rather than hanging
> it off the HZ timer.
>
> It would be simpler to adopt the 'jiffies' clocksource here
> (c.f. patch for the hp300 platform in this series).
>
> Changed since v1:
>  - Moved clk_total access to within the irq lock.
>  - Renamed mfp_timer_handler and mfptimer_handler.
>  - Avoid accessing the timer interrupt flag in atari_read_clk(). To
> get monotonicity, keep track of the previous timer counter value.
> ---
>  arch/m68k/atari/time.c | 48 +++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 17 deletions(-)
>
> diff --git a/arch/m68k/atari/time.c b/arch/m68k/atari/time.c
> index fafa20f75ab9..914832e55ec5 100644
> --- a/arch/m68k/atari/time.c
> +++ b/arch/m68k/atari/time.c
> @@ -16,6 +16,7 @@
>  #include <linux/init.h>
>  #include <linux/rtc.h>
>  #include <linux/bcd.h>
> +#include <linux/clocksource.h>
>  #include <linux/delay.h>
>  #include <linux/export.h>
>
> @@ -24,12 +25,27 @@
>  DEFINE_SPINLOCK(rtc_lock);
>  EXPORT_SYMBOL_GPL(rtc_lock);
>
> +static u64 atari_read_clk(struct clocksource *cs);
> +
> +static struct clocksource atari_clk = {
> +	.name   = "mfp",
> +	.rating = 100,
> +	.read   = atari_read_clk,
> +	.mask   = CLOCKSOURCE_MASK(32),
> +	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +static u32 clk_total;
> +static u32 last_timer_count;
> +
>  static irqreturn_t mfp_timer_c_handler(int irq, void *dev_id)
>  {
>  	irq_handler_t timer_routine = dev_id;
>  	unsigned long flags;
>
>  	local_irq_save(flags);
> +	last_timer_count = st_mfp.tim_dt_c;
> +	clk_total += INT_TICKS;
>  	timer_routine(0, NULL);
>  	local_irq_restore(flags);
>
> @@ -44,32 +60,30 @@ atari_sched_init(irq_handler_t timer_routine)
>      /* start timer C, div = 1:100 */
>      st_mfp.tim_ct_cd = (st_mfp.tim_ct_cd & 15) | 0x60;
>      /* install interrupt service routine for MFP Timer C */
> -    if (request_irq(IRQ_MFP_TIMC, mfp_timer_c_handler, 0, "timer",
> +    if (request_irq(IRQ_MFP_TIMC, mfp_timer_c_handler, IRQF_TIMER, "timer",
>                      timer_routine))
>  	pr_err("Couldn't register timer interrupt\n");
> +
> +    clocksource_register_hz(&atari_clk, INT_CLK);
>  }
>
>  /* ++andreas: gettimeoffset fixed to check for pending interrupt */
>
> -#define TICK_SIZE 10000
> -
> -/* This is always executed with interrupts disabled.  */
> -u32 atari_gettimeoffset(void)
> +static u64 atari_read_clk(struct clocksource *cs)
>  {
> -  u32 ticks, offset = 0;
> -
> -  /* read MFP timer C current value */
> -  ticks = st_mfp.tim_dt_c;
> -  /* The probability of underflow is less than 2% */
> -  if (ticks > INT_TICKS - INT_TICKS / 50)
> -    /* Check for pending timer interrupt */
> -    if (st_mfp.int_pn_b & (1 << 5))
> -      offset = TICK_SIZE;
> +	unsigned long flags;
> +	u32 ticks;
>
> -  ticks = INT_TICKS - ticks;
> -  ticks = ticks * 10000L / INT_TICKS;
> +	local_irq_save(flags);
> +	ticks = st_mfp.tim_dt_c;
> +	if (ticks > last_timer_count) /* timer wrapped since last interrupt */
> +		ticks = last_timer_count;
> +	last_timer_count = ticks;
> +	ticks = INT_TICKS - ticks;
> +	ticks += clk_total;
> +	local_irq_restore(flags);
>
> -  return (ticks + offset) * 1000;
> +	return ticks;
>  }
>
>
>
