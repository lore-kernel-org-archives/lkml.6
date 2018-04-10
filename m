Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeDJIAD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:00:03 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35750 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752052AbeDJIAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:00:02 -0400
X-Google-Smtp-Source: AIpwx4/2GRBA3nSKzyi8laK5TYMfcqwDJ/p2coaOSTXSl1eO3uNRDkWskunrkicySUW3DbxXeP5qH+Oi0lu402kSDZI=
MIME-Version: 1.0
In-Reply-To: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Apr 2018 10:00:01 +0200
X-Google-Sender-Auth: b9ciASoCtUd7BuJ6c9PMwYuKnzY
Message-ID: <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
Subject: Re: Subject: [PATCH] [PATCH] time: tick-sched: use bool for tick_stopped
To: yuankuiz@codeaurora.org
Cc: Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, aulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 9:33 AM,  <yuankuiz@codeaurora.org> wrote:
> From: John Zhao <yuankuiz@codeaurora.org>
>
> Variable tick_stopped returned by tick_nohz_tick_stopped
> can have only true / forse values. Since the return type
> of the tick_nohz_tick_stopped is also bool, variable
> tick_stopped nice to have data type as bool in place of int.
> Moreover, the executed instructions cost could be minimal
> without potiential data type conversion.
>
> Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
> ---
>  kernel/time/tick-sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
> index 6de959a..4d34309 100644
> --- a/kernel/time/tick-sched.h
> +++ b/kernel/time/tick-sched.h
> @@ -48,8 +48,8 @@ struct tick_sched {
>         unsigned long                   check_clocks;
>         enum tick_nohz_mode             nohz_mode;
>
> +       bool                            tick_stopped    : 1;
>         unsigned int                    inidle          : 1;
> -       unsigned int                    tick_stopped    : 1;
>         unsigned int                    idle_active     : 1;
>         unsigned int                    do_timer_last   : 1;
>         unsigned int                    got_idle_tick   : 1;

I don't think this is a good idea at all.

Please see https://lkml.org/lkml/2017/11/21/384 for example.

Thanks!
