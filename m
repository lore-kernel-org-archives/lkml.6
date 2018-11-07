Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BC4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162D420837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzATzUZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162D420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeKHFJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:09:01 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33716 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHFJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:09:01 -0500
Received: by mail-yb1-f196.google.com with SMTP id i78-v6so7343390ybg.0;
        Wed, 07 Nov 2018 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y1DH6KbdnQmQRVnBzWdxwikPXlUu9DEEgUUGi56wSdQ=;
        b=JzATzUZeWjRCr5x9kcvqHY8D6+G7PEojCZM329mObX6uN6px2JhsU59hOrA87eiRQA
         uGUmFVCV3Ft/0YQB9WZkLEFuqYKr3YjQv2rZlJ43ktSUa19QM9R1GGZgH2/woDZf1pEv
         tp+YOUVNJ8A4dWtPG92bGYCSX3rmwwTx5gbCneTWGekKz8rXHGR86OoOflL4gazrmAKY
         oM9wgBHr5t3v3frmULQa9vtIVHBMS2QX+qvzoH1Patoniw6Vpm/oOlCu2l6P7Er2Vt4k
         QtpIcAueZVi97wCggJIYl+rM77Ts+LaflfHLiMXTWRKaz8nrfJOYCcgIUlCARX3fxjTw
         jztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Y1DH6KbdnQmQRVnBzWdxwikPXlUu9DEEgUUGi56wSdQ=;
        b=EycUXeTrZSFCA7pn8BTPakuluXUiqBKJJU5ZUetdZU3lFpSsrG4rsMut0afwws1O73
         YuoII23OkWMN43yEmSPY86cPbV5kNrN92WlQjr2Y0FuBnMpspvmSnRv2Br9bg1qRb1xb
         n/oIxBCoXmKFUAL69ntq4HlH+En0mOM58KAx+K1IYhEFP7vQKCmY5KYS9x9+5VhyNx0V
         2q2BgbrbnNOHk6hHBfpjuBWtT2HlL5hNSYyX8PkhniDphMA1Wva5XtCIam0n6IwevMqD
         fgMNQA4xRLEJ6ngl0VUSDQCF0dTa6dV3aK77Fr1/ym0IYkICiUys/98Ykps1dYzXQHXV
         Bf5Q==
X-Gm-Message-State: AGRZ1gIJVkBypf0x2jM6N3VfuAMDNaDgK54+gY+MwVD8d0kVwYNygzey
        4JBIrqVv58Y5vuCnEZGTkQY=
X-Google-Smtp-Source: AJdET5fdPkTuR13fNdVcbmtCGXrYZVS98Ual4CxVu1ZjUKyQ8Iplc8/ApPXYk3RC283klf70JaKYGw==
X-Received: by 2002:a25:ac0e:: with SMTP id w14-v6mr1682077ybi.139.1541619433359;
        Wed, 07 Nov 2018 11:37:13 -0800 (PST)
Received: from [10.67.49.62] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id s129-v6sm349976ywc.41.2018.11.07.11.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 11:37:12 -0800 (PST)
Subject: Re: [PATCH stable 4.9] posix-timers: Sanitize overrun handling
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <1541102558-14839-1-git-send-email-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <6341cf9e-b2aa-9447-88e9-ad89ab42a641@gmail.com>
Date:   Wed, 7 Nov 2018 11:37:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541102558-14839-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/18 1:02 PM, Florian Fainelli wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> [ Upstream commit 78c9c4dfbf8c04883941445a195276bb4bb92c76 ]
> 
> The posix timer overrun handling is broken because the forwarding functions
> can return a huge number of overruns which does not fit in an int. As a
> consequence timer_getoverrun(2) and siginfo::si_overrun can turn into
> random number generators.
> 
> The k_clock::timer_forward() callbacks return a 64 bit value now. Make
> k_itimer::ti_overrun[_last] 64bit as well, so the kernel internal
> accounting is correct. 3Remove the temporary (int) casts.
> 
> Add a helper function which clamps the overrun value returned to user space
> via timer_getoverrun(2) or siginfo::si_overrun limited to a positive value
> between 0 and INT_MAX. INT_MAX is an indicator for user space that the
> overrun value has been clamped.
> 
> Reported-by: Team OWL337 <icytxw@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: John Stultz <john.stultz@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Link: https://lkml.kernel.org/r/20180626132705.018623573@linutronix.de
> [florian: Make patch apply to v4.9.135]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Thomas, can you review for correctness? Thanks!

Thomas, John, does that look like a reasonable backport for 4.9?

> 
>  include/linux/posix-timers.h   |  4 ++--
>  kernel/time/posix-cpu-timers.c |  2 +-
>  kernel/time/posix-timers.c     | 29 +++++++++++++++++++----------
>  3 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
> index 62d44c176071..e4b8678183f5 100644
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -65,8 +65,8 @@ struct k_itimer {
>  	spinlock_t it_lock;
>  	clockid_t it_clock;		/* which timer type */
>  	timer_t it_id;			/* timer id */
> -	int it_overrun;			/* overrun on pending signal  */
> -	int it_overrun_last;		/* overrun on last delivered signal */
> +	s64 it_overrun;			/* overrun on pending signal  */
> +	s64 it_overrun_last;		/* overrun on last delivered signal */
>  	int it_requeue_pending;		/* waiting to requeue this timer */
>  #define REQUEUE_PENDING 1
>  	int it_sigev_notify;		/* notify word of sigevent struct */
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index 39008d78927a..21a27bb73587 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -103,7 +103,7 @@ static void bump_cpu_timer(struct k_itimer *timer,
>  			continue;
>  
>  		timer->it.cpu.expires += incr;
> -		timer->it_overrun += 1 << i;
> +		timer->it_overrun += 1LL << i;
>  		delta -= incr;
>  	}
>  }
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index fc7c37ad90a0..0e6ed2e7d066 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -355,6 +355,17 @@ static __init int init_posix_timers(void)
>  
>  __initcall(init_posix_timers);
>  
> +/*
> + * The siginfo si_overrun field and the return value of timer_getoverrun(2)
> + * are of type int. Clamp the overrun value to INT_MAX
> + */
> +static inline int timer_overrun_to_int(struct k_itimer *timr, int baseval)
> +{
> +	s64 sum = timr->it_overrun_last + (s64)baseval;
> +
> +	return sum > (s64)INT_MAX ? INT_MAX : (int)sum;
> +}
> +
>  static void schedule_next_timer(struct k_itimer *timr)
>  {
>  	struct hrtimer *timer = &timr->it.real.timer;
> @@ -362,12 +373,11 @@ static void schedule_next_timer(struct k_itimer *timr)
>  	if (timr->it.real.interval.tv64 == 0)
>  		return;
>  
> -	timr->it_overrun += (unsigned int) hrtimer_forward(timer,
> -						timer->base->get_time(),
> -						timr->it.real.interval);
> +	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
> +					    timr->it.real.interval);
>  
>  	timr->it_overrun_last = timr->it_overrun;
> -	timr->it_overrun = -1;
> +	timr->it_overrun = -1LL;
>  	++timr->it_requeue_pending;
>  	hrtimer_restart(timer);
>  }
> @@ -396,7 +406,7 @@ void do_schedule_next_timer(struct siginfo *info)
>  		else
>  			schedule_next_timer(timr);
>  
> -		info->si_overrun += timr->it_overrun_last;
> +		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
>  	}
>  
>  	if (timr)
> @@ -491,8 +501,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
>  					now = ktime_add(now, kj);
>  			}
>  #endif
> -			timr->it_overrun += (unsigned int)
> -				hrtimer_forward(timer, now,
> +			timr->it_overrun += hrtimer_forward(timer, now,
>  						timr->it.real.interval);
>  			ret = HRTIMER_RESTART;
>  			++timr->it_requeue_pending;
> @@ -633,7 +642,7 @@ SYSCALL_DEFINE3(timer_create, const clockid_t, which_clock,
>  	it_id_set = IT_ID_SET;
>  	new_timer->it_id = (timer_t) new_timer_id;
>  	new_timer->it_clock = which_clock;
> -	new_timer->it_overrun = -1;
> +	new_timer->it_overrun = -1LL;
>  
>  	if (timer_event_spec) {
>  		if (copy_from_user(&event, timer_event_spec, sizeof (event))) {
> @@ -762,7 +771,7 @@ common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
>  	 */
>  	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING ||
>  			timr->it_sigev_notify == SIGEV_NONE))
> -		timr->it_overrun += (unsigned int) hrtimer_forward(timer, now, iv);
> +		timr->it_overrun += hrtimer_forward(timer, now, iv);
>  
>  	remaining = __hrtimer_expires_remaining_adjusted(timer, now);
>  	/* Return 0 only, when the timer is expired and not pending */
> @@ -824,7 +833,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
>  	if (!timr)
>  		return -EINVAL;
>  
> -	overrun = timr->it_overrun_last;
> +	overrun = timer_overrun_to_int(timr, 0);
>  	unlock_timer(timr, flags);
>  
>  	return overrun;
> 


-- 
Florian
