Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E35EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439C9223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1cqApuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439C9223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbeKPD0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:26:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37617 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeKPD0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:26:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so18631988wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 09:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DfPMiCANFbA6D8i78UzuFHN05oMXyem2Dv8ebh62Up0=;
        b=X1cqApuHlfhYSYxYLhp7hp2VhfaPcVmIFxhgysof4/XmAi1NUR7PMXVAAg7P3bRoL5
         chgIwM6955KezEtq2kHvh+Nf/RUp4vgA7ogY12cZ6JQJ9ePHPk4IjwIWKdrOaQ9kUCZY
         rp86Ld/mig3Wnvkz966is2lmh72+tZur5hPeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DfPMiCANFbA6D8i78UzuFHN05oMXyem2Dv8ebh62Up0=;
        b=kia8lzfrpO6uK/u5UNDCwFYdMp36085pzc3W2QKoT93Y3SNfSMnPsieQJPhr4MPqPK
         SMRu6Z9BLPgz1FtruTHmz3FEYRpOlo8byWz9l++3COCKzm2+GTdrFjf1f3H2ronHGvVI
         jlyTm3eQYOJ1EjZ1xPT6Ybc7CdrPfV4n8FBNRrEuLR3cnA9rmhMMyoYm/HQkHjRd5IRM
         8Elrd+inKvFX6SYVMoo1+DdV25NELWEKs9nrDdCaA29U+L0i/xbo1P5HXwYIXqnT2bpF
         uQMCTjbA6sbtWXpUeCxQqI5VeqXIVWba02OEnrs8x5rQOi/HA4vKBKE4q1WSof/4do5j
         rlWQ==
X-Gm-Message-State: AA+aEWZP89EkV8q9grdHT5RF0CSxeZ0oYoHZ6Vz0quQJ0U+e+c2krHZ3
        VideWKuKC/HR0OzeqmdkeMENV5h7CMxB48VQOTkwwl98TtaQ0g==
X-Google-Smtp-Source: AJdET5c+gzkwojpNoCR9cHltnLGmC2QDT5vKR1xbpKjtqKU+mwfrxqWC5r+VUU7w0F9HmXw0gqvYe/YKC3QQTjGR7uQ=
X-Received: by 2002:a1c:7209:: with SMTP id n9mr2381335wmc.5.1542302271583;
 Thu, 15 Nov 2018 09:17:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a1c:4054:0:0:0:0:0 with HTTP; Thu, 15 Nov 2018 09:17:50
 -0800 (PST)
In-Reply-To: <20181115170701.4696-1-mzhivich@akamai.com>
References: <20181115170701.4696-1-mzhivich@akamai.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 15 Nov 2018 09:17:50 -0800
Message-ID: <CALAqxLV0sQaWx837Vrz3hfGdUNSBa+cJWaaL_RpPsgRTMQknuA@mail.gmail.com>
Subject: Re: [PATCH] softirq: don't push timer softirq handling to ksoftirqd
To:     Michael Zhivich <mzhivich@akamai.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, tiny.windzz@gmail.com,
        Joel Fernandes <joel@joelfernandes.org>,
        alexander.levin@verizon.com, frederic@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>, kreview@akamai.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 9:07 AM, Michael Zhivich <mzhivich@akamai.com> wrote:
> Require TIMER_SOFTIRQ to be handled immediately instead of delaying until
> ksoftirqd runs, thus preventing problems with reading clocksources that
> wrap often (e.g. acpi_pm).
>
> If acpi_pm is used as the clocksource watchdog, and machine is under heavy
> load, the time period for the watchdog check may be significantly longer
> than the requested 0.5 seconds.  If the watchdog check is delayed by 2
> seconds (observed behavior), then acpi_pm time delta will be
>
>     2.5 sec * 3579545 ticks/sec = 8948863 = 0x888c3f
>
> which will be treated as negative (since acpi_pm is only 24-bits wide) and
> truncated to 0.  This behavior will cause tsc to be incorrectly declared
> unstable in clocksource_watchdog(), as it no longer agrees with acpi_pm.
> If the clocksource watchdog check is delayed by more than 4.7 sec, then the
> acpi_pm clocksource will wrap altogether and produce incorrect time delta.
>
> The likely cause of this delay is that timer interrupts are serviced in
> ksoftirqd when the machine is very busy.
>
> Per Linus' comment in commit 3c53776e29f8 ("Mark HI and TASKLET softirq
> synchronous"):
>    ...
>    We should probably also consider the timer softirqs to be synchronous
>    and not be delayed to ksoftirqd (since they were the issue with the
>    earlier watchdog problems), but that should be done as a separate patch.
>    ...
>
> Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
> ---
>  kernel/softirq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index d28813306b2c..6d517ce0fba8 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -82,7 +82,8 @@ static void wakeup_softirqd(void)
>   * right now. Let ksoftirqd handle this at its own rate, to get fairness,
>   * unless we're doing some of the synchronous softirqs.
>   */
> -#define SOFTIRQ_NOW_MASK ((1 << HI_SOFTIRQ) | (1 << TASKLET_SOFTIRQ))
> +#define SOFTIRQ_NOW_MASK \
> +       ((1 << HI_SOFTIRQ) | (1 << TASKLET_SOFTIRQ) | (1 << TIMER_SOFTIRQ))
>  static bool ksoftirqd_running(unsigned long pending)
>  {
>         struct task_struct *tsk = __this_cpu_read(ksoftirqd);

Thanks so much for sending this along! Sorry I didn't get back to your
mail earlier this week, I've been at Plumbers.

So while this does try to attack the reliability issue w/ the
clocksource watchdog being delayed, I worry this will have to many
side-effects elsewhere.

Would a more focused fix be to move the clocksource watchdog from a
normal timer to a hrtimer?

thanks
-john
