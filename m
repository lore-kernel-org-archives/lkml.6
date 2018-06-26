Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD1AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CBC26CD2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buz+cTY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CBC26CD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752957AbeFZREh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:04:37 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40547 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbeFZREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:04:36 -0400
Received: by mail-ua0-f193.google.com with SMTP id j17-v6so4959980uap.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U76yXF9Dg0IJjSSkDJOxfLXCcEwp5CP3Vls3qzBk9wo=;
        b=buz+cTY4r8/ztECLIPyKYpeGAecadb1NxynfoEv3A9yiq6fVZ/JJjknZqtrBJLUWDU
         FecDQkNytrarZ5Y9EDkiVmveoDSPcL3EhN3byhY864aLyXEq9IFDYlubWl04+cRY28xW
         EMbNz9Mp9qjIEuY9xM3B/K5C2spA0MT6T3JRSLBg1jhYsuhFbrrJotLmGdjq2Dv8u9R1
         vaYdKdXjFPpVF99s7MVhhNyT9lER/02EMTmWlp1rtMs16XlvsDwcULPl6F1WDw23YVZh
         WZcW6sLNNpaqBOYMe3LJfLlSLzG3HDSp7cfDsYnYElOZidWGpPSe0633F/tDSDB3M+7B
         R58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U76yXF9Dg0IJjSSkDJOxfLXCcEwp5CP3Vls3qzBk9wo=;
        b=PPkc4DOJaPALnnx9YzWD2NABBYxoZAp1K5/jm+HK/YORDkhwGZSGF5XcVL8NT4io0t
         86WcBdxI9yrhAx0rs5eGOwoe5u9AGwrTvhUSc98m6jvKckt8GQhd0W8FLSI2rQBz7Ee/
         ykVID3c6DbN1qRdlmCnPyXUDe9VMlOOu4nl33VlEI8JdFumDiwvSDyeYXudkhd/5Qqzg
         asOiBT87nVSNvUm2FcoHqtigb2a6tAnjrFpiVI48v59/WX26fONHMXkNcobeD74s3T89
         b98aLa90hZeTomOzq/FWLhc5nJOxLHqziIDMwcbYzTndW1aVa5/0nQlh7eM6gPlaXLw8
         gqPQ==
X-Gm-Message-State: APt69E10mjlARI2bfrNV7z8ThApwPtJOkj5b94zkHI2l8SpVwbxjsjk/
        CdW9DEbcIiF+IkqJGIx2LxCOIomYWlajO+XkOlBhcw==
X-Google-Smtp-Source: AAOMgpeilKYi/fAlvG5hIUOIJAihNR+sDnu/KISNtQr+YkyesXFvywyhnd+c4WARsZ25ZhhsjuXLWnfqL2SlV/5RAKM=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr1505346uae.199.1530032675270;
 Tue, 26 Jun 2018 10:04:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 10:04:34
 -0700 (PDT)
In-Reply-To: <20180626162438.16306-1-dima@arista.com>
References: <20180626162438.16306-1-dima@arista.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 20:04:34 +0300
Message-ID: <CAHp75VchWpr+76rBCmXctpYi5a06pr-MT==FrNDy03g=boxfog@mail.gmail.com>
Subject: Re: [PATCHv2] lib/ratelimit: Lockless ratelimiting
To:     Dmitry Safonov <dima@arista.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 7:24 PM, Dmitry Safonov <dima@arista.com> wrote:
> Currently ratelimit_state is protected with spin_lock. If the .lock is
> taken at the moment of ___ratelimit() call, the message is suppressed to
> make ratelimiting robust.
>
> That results in the following issue issue:
>       CPU0                          CPU1
> ------------------           ------------------
> printk_ratelimit()           printk_ratelimit()
>         |                             |
>   try_spin_lock()              try_spin_lock()
>         |                             |
> time_is_before_jiffies()          return 0; // suppress
>
> So, concurrent call of ___ratelimit() results in silently suppressing
> one of the messages, regardless if the limit is reached or not.
> And rc->missed is not increased in such case so the issue is covered
> from user.
>
> Convert ratelimiting to use atomic counters and drop spin_lock.
>
> Note: That might be unexpected, but with the first interval of messages
> storm one can print up to burst*2 messages. So, it doesn't guarantee
> that in *any* interval amount of messages is lesser than burst.
> But, that differs lightly from previous behavior where one can start
> burst=5 interval and print 4 messages on the last milliseconds of
> interval + new 5 messages from new interval (totally 9 messages in
> lesser than interval value):
>
>    msg0              msg1-msg4 msg0-msg4
>     |                     |       |
>     |                     |       |
>  |--o---------------------o-|-----o--------------------|--> (t)
>                           <------->
>                        Lesser than burst

>  #define RATELIMIT_STATE_INIT(name, interval_init, burst_init) {                \
> -               .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),  \

name is now redundant, isn't it?

>                 .interval       = interval_init,                        \
>                 .burst          = burst_init,                           \
> +               .printed        = ATOMIC_INIT(0),                       \
> +               .missed         = ATOMIC_INIT(0),                       \
>         }
>
>  #define RATELIMIT_STATE_INIT_DISABLED                                  \
> @@ -42,9 +41,10 @@ static inline void ratelimit_state_init(struct ratelimit_state *rs,
>  {
>         memset(rs, 0, sizeof(*rs));
>
> -       raw_spin_lock_init(&rs->lock);
>         rs->interval    = interval;
>         rs->burst       = burst;
> +       atomic_set(&rs->printed, 0);
> +       atomic_set(&rs->missed, 0);

Can it be

*rs = RATELIMIT_STATE_INIT(interval, burst);

?

(Yes, the '(struct ratelimit_state)' has to be added to macro to allow this)

>  }


>  static inline void ratelimit_state_exit(struct ratelimit_state *rs)
>  {
> +       int missed;
> +
>         if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE))
>                 return;
>
> -       if (rs->missed) {
> +       if ((missed = atomic_xchg(&rs->missed, 0)))

Perhaps

missed = ...
if (missed)

?

>                 pr_warn("%s: %d output lines suppressed due to ratelimiting\n",
> -                       current->comm, rs->missed);
> -               rs->missed = 0;
> -       }
> +                       current->comm, missed);
>  }

> +static void ratelimit_end_interval(struct ratelimit_state *rs, const char *func)
> +{
> +       rs->begin = jiffies;
> +
> +       if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {

> +               unsigned missed = (unsigned)atomic_xchg(&rs->missed, 0);
> +
> +               if (missed)
> +                       pr_warn("%s: %u callbacks suppressed\n", func, missed);

Instead of casting, perhaps

int missed = ...

I think you already has a guard against going it below zero. Or I
missed something?

> +       }
> +}

-- 
With Best Regards,
Andy Shevchenko
