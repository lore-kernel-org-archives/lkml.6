Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CABDECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97DB20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYHFcGBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97DB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbeGRR2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:28:01 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36750 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbeGRR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:28:01 -0400
Received: by mail-ua0-f196.google.com with SMTP id y8-v6so3353817uan.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S1Wj4ZSodaEhCeD5FPPsU4SVSPBUpXpAGbKAfHXmIw4=;
        b=sYHFcGBKM3ATe5CLmPhZYL3LrZ43FVr3SU7f/1f1GSZ//o1+Hc57U2SYWYWEqIbsF+
         2yob7ckfE4FvhMIfGD3ABqN/NJc1hocAzI3SSBdhYdaBXpJlfrHd4/dkTrdLxKRo/4wN
         EIDAC9vk/WvsDyzUCVr9ODGNW+VvMFrQXlCGvWbndE1gbk3i3sQkDv8j90LjvUhKY2DM
         XgLKP1CIDSU8LRhZd+9PWfbCG7SGXSE/sOAwAop3j/J6RRA1QofAzwXaUCajlzfZdI3Z
         syk1fj7qP74bljFflyAOElynfCLFu8J9i+PinpAMYagx5s5gsyhJu25PHRS62NC9/g+a
         O/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S1Wj4ZSodaEhCeD5FPPsU4SVSPBUpXpAGbKAfHXmIw4=;
        b=IAM6OZZUK6VFLAucDlcTqd93WXBdYKMafUsmdCZsphiEYJwwLo0p1P3+rDoMdgsHj+
         pqtSwxyRqpRpDeGXkh0qRSz8fy8s+taLEtTJTh8S3yg+ahmMJVEChPV/+92hpkhuKmeC
         0MLQagF7hN/YO3flMMj/411hP0dQL51wD50tj+c8dlJZc7z81tWlCOqxJSBw7V+9tRN+
         83Z8zvFJdvNJypz0xe+G1ig4hSRmdJhIxe/xJt3RodvOSDsbCdIyGTeV+CLWOLz4wmQM
         B2h0EdgLANLLZxShCoLxVxChbAEWgL250AQljsMLN7x73FM3tezpgIsCzNDNMTRYaVCx
         e+rg==
X-Gm-Message-State: AOUpUlEVk3XHefMn+4SKuzH8zh+h1NJ6lq7EQn9cXxHgRGRGlbY0ndgg
        FkEJcYtA/tFHQ68DOoc0OeoZKOVbF6YhpwATwG8=
X-Google-Smtp-Source: AAOMgpcnjSZTy16kFRMK0KflQyzW2ocYkhcyMycoHIzjjveyXnnpMUwk+ln1rcbEg1K07kpwS0bgjHqbaPQffe0haao=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr4410655uad.12.1531932551703;
 Wed, 18 Jul 2018 09:49:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 09:49:10
 -0700 (PDT)
In-Reply-To: <1531789154.18720.3.camel@arista.com>
References: <20180703225628.25684-1-dima@arista.com> <1531789154.18720.3.camel@arista.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 19:49:10 +0300
Message-ID: <CAHp75VdmQ1YLzWpYb7878zKOCCyOEicdLAtpohbmY2hL1h1RNg@mail.gmail.com>
Subject: Re: [PATCHv3] lib/ratelimit: Lockless ratelimiting
To:     Dmitry Safonov <dima@arista.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
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

On Tue, Jul 17, 2018 at 3:59 AM, Dmitry Safonov <dima@arista.com> wrote:
> I would be glad if someone helps/bothers to review the change :C
>

Perhaps Petr and / or Steven can help you.

> Thanks,
> Dmitry
>
> On Tue, 2018-07-03 at 23:56 +0100, Dmitry Safonov wrote:
>> Currently ratelimit_state is protected with spin_lock. If the .lock
>> is
>> taken at the moment of ___ratelimit() call, the message is suppressed
>> to
>> make ratelimiting robust.
>>
>> That results in the following issue issue:
>>       CPU0                          CPU1
>> ------------------           ------------------
>> printk_ratelimit()           printk_ratelimit()
>>         |                             |
>>   try_spin_lock()              try_spin_lock()
>>         |                             |
>> time_is_before_jiffies()          return 0; // suppress
>>
>> So, concurrent call of ___ratelimit() results in silently suppressing
>> one of the messages, regardless if the limit is reached or not.
>> And rc->missed is not increased in such case so the issue is covered
>> from user.
>>
>> Convert ratelimiting to use atomic counters and drop spin_lock.
>>
>> Note: That might be unexpected, but with the first interval of
>> messages
>> storm one can print up to burst*2 messages. So, it doesn't guarantee
>> that in *any* interval amount of messages is lesser than burst.
>> But, that differs lightly from previous behavior where one can start
>> burst=5 interval and print 4 messages on the last milliseconds of
>> interval + new 5 messages from new interval (totally 9 messages in
>> lesser than interval value):
>>
>>    msg0              msg1-msg4 msg0-msg4
>>     |                     |       |
>>     |                     |       |
>>  |--o---------------------o-|-----o--------------------|--> (t)
>>                           <------->
>>                        Lesser than burst
>>
>> Dropped dev/random patch since v1 version:
>> lkml.kernel.org/r/<20180510125211.12583-1-dima@arista.com>
>>
>> Dropped `name' in as it's unused in RATELIMIT_STATE_INIT()
>>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: "Theodore Ts'o" <tytso@mit.edu>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: intel-gfx@lists.freedesktop.org
>> Cc: dri-devel@lists.freedesktop.org
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  drivers/char/random.c            | 28 ++++++++-----------
>>  drivers/gpu/drm/i915/i915_perf.c |  8 ++++--
>>  fs/btrfs/super.c                 | 16 +++++------
>>  fs/xfs/scrub/scrub.c             |  2 +-
>>  include/linux/ratelimit.h        | 31 ++++++++++++---------
>>  kernel/user.c                    |  2 +-
>>  lib/ratelimit.c                  | 59 +++++++++++++++++++-----------
>> ----------
>>  7 files changed, 73 insertions(+), 73 deletions(-)
>>
>> diff --git a/drivers/char/random.c b/drivers/char/random.c
>> index cd888d4ee605..0be31b3eadab 100644
>> --- a/drivers/char/random.c
>> +++ b/drivers/char/random.c
>> @@ -439,10 +439,8 @@ static void _crng_backtrack_protect(struct
>> crng_state *crng,
>>  static void process_random_ready_list(void);
>>  static void _get_random_bytes(void *buf, int nbytes);
>>
>> -static struct ratelimit_state unseeded_warning =
>> -     RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
>> -static struct ratelimit_state urandom_warning =
>> -     RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
>> +static struct ratelimit_state unseeded_warning =
>> RATELIMIT_STATE_INIT(HZ, 3);
>> +static struct ratelimit_state urandom_warning =
>> RATELIMIT_STATE_INIT(HZ, 3);
>>
>>  static int ratelimit_disable __read_mostly;
>>
>> @@ -937,24 +935,22 @@ static void crng_reseed(struct crng_state
>> *crng, struct entropy_store *r)
>>       crng->init_time = jiffies;
>>       spin_unlock_irqrestore(&crng->lock, flags);
>>       if (crng == &primary_crng && crng_init < 2) {
>> +             unsigned int unseeded_miss, urandom_miss;
>> +
>>               invalidate_batched_entropy();
>>               numa_crng_init();
>>               crng_init = 2;
>>               process_random_ready_list();
>>               wake_up_interruptible(&crng_init_wait);
>>               pr_notice("random: crng init done\n");
>> -             if (unseeded_warning.missed) {
>> -                     pr_notice("random: %d get_random_xx
>> warning(s) missed "
>> -                               "due to ratelimiting\n",
>> -                               unseeded_warning.missed);
>> -                     unseeded_warning.missed = 0;
>> -             }
>> -             if (urandom_warning.missed) {
>> -                     pr_notice("random: %d urandom warning(s)
>> missed "
>> -                               "due to ratelimiting\n",
>> -                               urandom_warning.missed);
>> -                     urandom_warning.missed = 0;
>> -             }
>> +             unseeded_miss =
>> atomic_xchg(&unseeded_warning.missed, 0);
>> +             if (unseeded_miss)
>> +                     pr_notice("random: %u get_random_xx
>> warning(s) missed "
>> +                               "due to ratelimiting\n",
>> unseeded_miss);
>> +             urandom_miss = atomic_xchg(&urandom_warning.missed,
>> 0);
>> +             if (urandom_miss)
>> +                     pr_notice("random: %u urandom warning(s)
>> missed "
>> +                               "due to ratelimiting\n",
>> urandom_miss);
>>       }
>>  }
>>
>> diff --git a/drivers/gpu/drm/i915/i915_perf.c
>> b/drivers/gpu/drm/i915/i915_perf.c
>> index 019bd2d073ad..dcfba3023547 100644
>> --- a/drivers/gpu/drm/i915/i915_perf.c
>> +++ b/drivers/gpu/drm/i915/i915_perf.c
>> @@ -1295,6 +1295,7 @@ free_oa_buffer(struct drm_i915_private *i915)
>>  static void i915_oa_stream_destroy(struct i915_perf_stream *stream)
>>  {
>>       struct drm_i915_private *dev_priv = stream->dev_priv;
>> +     unsigned int msg_missed;
>>
>>       BUG_ON(stream != dev_priv->perf.oa.exclusive_stream);
>>
>> @@ -1317,9 +1318,10 @@ static void i915_oa_stream_destroy(struct
>> i915_perf_stream *stream)
>>
>>       put_oa_config(dev_priv, stream->oa_config);
>>
>> -     if (dev_priv->perf.oa.spurious_report_rs.missed) {
>> -             DRM_NOTE("%d spurious OA report notices suppressed
>> due to ratelimiting\n",
>> -                      dev_priv-
>> >perf.oa.spurious_report_rs.missed);
>> +     msg_missed = atomic_read(&dev_priv-
>> >perf.oa.spurious_report_rs.missed);
>> +     if (msg_missed) {
>> +             DRM_NOTE("%u spurious OA report notices suppressed
>> due to ratelimiting\n",
>> +                      msg_missed);
>>       }
>>  }
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 81107ad49f3a..ffab6c23bc50 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -177,14 +177,14 @@ static const char * const logtypes[] = {
>>   * messages doesn't cause more important ones to be dropped.
>>   */
>>  static struct ratelimit_state printk_limits[] = {
>> -     RATELIMIT_STATE_INIT(printk_limits[0],
>> DEFAULT_RATELIMIT_INTERVAL, 100),
>> -     RATELIMIT_STATE_INIT(printk_limits[1],
>> DEFAULT_RATELIMIT_INTERVAL, 100),
>> -     RATELIMIT_STATE_INIT(printk_limits[2],
>> DEFAULT_RATELIMIT_INTERVAL, 100),
>> -     RATELIMIT_STATE_INIT(printk_limits[3],
>> DEFAULT_RATELIMIT_INTERVAL, 100),
>> -     RATELIMIT_STATE_INIT(printk_limits[4],
>> DEFAULT_RATELIMIT_INTERVAL, 100),
>> -     RATELIMIT_STATE_INIT(printk_limits[5],
>> DEFAULT_RATELIMIT_INTERVAL, 100),
>> -     RATELIMIT_STATE_INIT(printk_limits[6],
>> DEFAULT_RATELIMIT_INTERVAL, 100),
>> -     RATELIMIT_STATE_INIT(printk_limits[7],
>> DEFAULT_RATELIMIT_INTERVAL, 100),
>> +     RATELIMIT_STATE_INIT(DEFAULT_RATELIMIT_INTERVAL, 100),
>> +     RATELIMIT_STATE_INIT(DEFAULT_RATELIMIT_INTERVAL, 100),
>> +     RATELIMIT_STATE_INIT(DEFAULT_RATELIMIT_INTERVAL, 100),
>> +     RATELIMIT_STATE_INIT(DEFAULT_RATELIMIT_INTERVAL, 100),
>> +     RATELIMIT_STATE_INIT(DEFAULT_RATELIMIT_INTERVAL, 100),
>> +     RATELIMIT_STATE_INIT(DEFAULT_RATELIMIT_INTERVAL, 100),
>> +     RATELIMIT_STATE_INIT(DEFAULT_RATELIMIT_INTERVAL, 100),
>> +     RATELIMIT_STATE_INIT(DEFAULT_RATELIMIT_INTERVAL, 100),
>>  };
>>
>>  void btrfs_printk(const struct btrfs_fs_info *fs_info, const char
>> *fmt, ...)
>> diff --git a/fs/xfs/scrub/scrub.c b/fs/xfs/scrub/scrub.c
>> index 58ae76b3a421..8b58b439694a 100644
>> --- a/fs/xfs/scrub/scrub.c
>> +++ b/fs/xfs/scrub/scrub.c
>> @@ -349,7 +349,7 @@ xfs_scrub_experimental_warning(
>>       struct xfs_mount        *mp)
>>  {
>>       static struct ratelimit_state scrub_warning =
>> RATELIMIT_STATE_INIT(
>> -                     "xfs_scrub_warning", 86400 * HZ, 1);
>> +                     86400 * HZ, 1);
>>       ratelimit_set_flags(&scrub_warning,
>> RATELIMIT_MSG_ON_RELEASE);
>>
>>       if (__ratelimit(&scrub_warning))
>> diff --git a/include/linux/ratelimit.h b/include/linux/ratelimit.h
>> index 8ddf79e9207a..f9a9386dd869 100644
>> --- a/include/linux/ratelimit.h
>> +++ b/include/linux/ratelimit.h
>> @@ -4,7 +4,6 @@
>>
>>  #include <linux/param.h>
>>  #include <linux/sched.h>
>> -#include <linux/spinlock.h>
>>
>>  #define DEFAULT_RATELIMIT_INTERVAL   (5 * HZ)
>>  #define DEFAULT_RATELIMIT_BURST              10
>> @@ -13,38 +12,39 @@
>>  #define RATELIMIT_MSG_ON_RELEASE     BIT(0)
>>
>>  struct ratelimit_state {
>> -     raw_spinlock_t  lock;           /* protect the
>> state */
>> +     atomic_t        printed;
>> +     atomic_t        missed;
>>
>>       int             interval;
>>       int             burst;
>> -     int             printed;
>> -     int             missed;
>>       unsigned long   begin;
>>       unsigned long   flags;
>>  };
>>
>> -#define RATELIMIT_STATE_INIT(name, interval_init, burst_init) {
>>       \
>> -             .lock           =
>> __RAW_SPIN_LOCK_UNLOCKED(name.lock),  \
>> +#define RATELIMIT_STATE_INIT(interval_init, burst_init) {
>> \
>>               .interval       = interval_init,
>> \
>>               .burst          = burst_init,
>>       \
>> +             .printed        = ATOMIC_INIT(0),
>> \
>> +             .missed         = ATOMIC_INIT(0),
>>       \
>>       }
>>
>>  #define RATELIMIT_STATE_INIT_DISABLED
>>       \
>> -     RATELIMIT_STATE_INIT(ratelimit_state, 0,
>> DEFAULT_RATELIMIT_BURST)
>> +     RATELIMIT_STATE_INIT(0, DEFAULT_RATELIMIT_BURST)
>>
>>  #define DEFINE_RATELIMIT_STATE(name, interval_init, burst_init)
>>       \
>>
>> \
>>       struct ratelimit_state name =
>>       \
>> -             RATELIMIT_STATE_INIT(name, interval_init,
>> burst_init)   \
>> +             RATELIMIT_STATE_INIT(interval_init, burst_init)
>>
>>  static inline void ratelimit_state_init(struct ratelimit_state *rs,
>>                                       int interval, int burst)
>>  {
>>       memset(rs, 0, sizeof(*rs));
>>
>> -     raw_spin_lock_init(&rs->lock);
>>       rs->interval    = interval;
>>       rs->burst       = burst;
>> +     atomic_set(&rs->printed, 0);
>> +     atomic_set(&rs->missed, 0);
>>  }
>>
>>  static inline void ratelimit_default_init(struct ratelimit_state
>> *rs)
>> @@ -53,16 +53,21 @@ static inline void ratelimit_default_init(struct
>> ratelimit_state *rs)
>>                                       DEFAULT_RATELIMIT_BURST);
>>  }
>>
>> +/*
>> + * Keeping It Simple: not reenterable and not safe for concurrent
>> + * ___ratelimit() call as used only by devkmsg_release().
>> + */
>>  static inline void ratelimit_state_exit(struct ratelimit_state *rs)
>>  {
>> +     int missed;
>> +
>>       if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE))
>>               return;
>>
>> -     if (rs->missed) {
>> +     missed = atomic_xchg(&rs->missed, 0);
>> +     if (missed)
>>               pr_warn("%s: %d output lines suppressed due to
>> ratelimiting\n",
>> -                     current->comm, rs->missed);
>> -             rs->missed = 0;
>> -     }
>> +                     current->comm, missed);
>>  }
>>
>>  static inline void
>> diff --git a/kernel/user.c b/kernel/user.c
>> index 36288d840675..a964f842d8f0 100644
>> --- a/kernel/user.c
>> +++ b/kernel/user.c
>> @@ -101,7 +101,7 @@ struct user_struct root_user = {
>>       .sigpending     = ATOMIC_INIT(0),
>>       .locked_shm     = 0,
>>       .uid            = GLOBAL_ROOT_UID,
>> -     .ratelimit      =
>> RATELIMIT_STATE_INIT(root_user.ratelimit, 0, 0),
>> +     .ratelimit      = RATELIMIT_STATE_INIT(0, 0),
>>  };
>>
>>  /*
>> diff --git a/lib/ratelimit.c b/lib/ratelimit.c
>> index d01f47135239..d9b749d40108 100644
>> --- a/lib/ratelimit.c
>> +++ b/lib/ratelimit.c
>> @@ -13,6 +13,18 @@
>>  #include <linux/jiffies.h>
>>  #include <linux/export.h>
>>
>> +static void ratelimit_end_interval(struct ratelimit_state *rs, const
>> char *func)
>> +{
>> +     rs->begin = jiffies;
>> +
>> +     if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
>> +             unsigned int missed = atomic_xchg(&rs->missed, 0);
>> +
>> +             if (missed)
>> +                     pr_warn("%s: %u callbacks suppressed\n",
>> func, missed);
>> +     }
>> +}
>> +
>>  /*
>>   * __ratelimit - rate limiting
>>   * @rs: ratelimit_state data
>> @@ -27,45 +39,30 @@
>>   */
>>  int ___ratelimit(struct ratelimit_state *rs, const char *func)
>>  {
>> -     unsigned long flags;
>> -     int ret;
>> -
>>       if (!rs->interval)
>>               return 1;
>>
>> -     /*
>> -      * If we contend on this state's lock then almost
>> -      * by definition we are too busy to print a message,
>> -      * in addition to the one that will be printed by
>> -      * the entity that is holding the lock already:
>> -      */
>> -     if (!raw_spin_trylock_irqsave(&rs->lock, flags))
>> +     if (unlikely(!rs->burst)) {
>> +             atomic_add_unless(&rs->missed, 1, -1);
>> +             if (time_is_before_jiffies(rs->begin + rs-
>> >interval))
>> +                     ratelimit_end_interval(rs, func);
>> +
>>               return 0;
>> +     }
>>
>> -     if (!rs->begin)
>> -             rs->begin = jiffies;
>> +     if (atomic_add_unless(&rs->printed, 1, rs->burst))
>> +             return 1;
>>
>>       if (time_is_before_jiffies(rs->begin + rs->interval)) {
>> -             if (rs->missed) {
>> -                     if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE))
>> {
>> -                             printk_deferred(KERN_WARNING
>> -                                             "%s: %d callbacks
>> suppressed\n",
>> -                                             func, rs->missed);
>> -                             rs->missed = 0;
>> -                     }
>> -             }
>> -             rs->begin   = jiffies;
>> -             rs->printed = 0;
>> -     }
>> -     if (rs->burst && rs->burst > rs->printed) {
>> -             rs->printed++;
>> -             ret = 1;
>> -     } else {
>> -             rs->missed++;
>> -             ret = 0;
>> +             if (atomic_cmpxchg(&rs->printed, rs->burst, 0))
>> +                     ratelimit_end_interval(rs, func);
>>       }
>> -     raw_spin_unlock_irqrestore(&rs->lock, flags);
>>
>> -     return ret;
>> +     if (atomic_add_unless(&rs->printed, 1, rs->burst))
>> +             return 1;
>> +
>> +     atomic_add_unless(&rs->missed, 1, -1);
>> +
>> +     return 0;
>>  }
>>  EXPORT_SYMBOL(___ratelimit);



-- 
With Best Regards,
Andy Shevchenko
