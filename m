Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABF4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36982064D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ow/wJMRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36982064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeGUBQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 21:16:11 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33672 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbeGUBQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 21:16:11 -0400
Received: by mail-it0-f66.google.com with SMTP id y124-v6so6547323itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 17:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LVWyZ+MgKn+7Bsoyeo8qY34s+y6YancMwuntpY4XE2E=;
        b=Ow/wJMRVLc5SFvIFhipnUnkgD4XOiF6nlxtoLOtfX0gV0KKSCG1dYjnXEr9nya8oO0
         HILqwZhI0fA+8mNZ4CJMm3bV2MmZf2+BA3y+/v3uBYLjOe9+U3prjRPpA1lN2fNRI3Gt
         h6WbNABS7QRXcOWnLEYazGNVj05aR8QLaSGAKNFYAxsXTl4cvfhq2MLXwnAE5VaAQtHj
         poLZgOVBzRoxHJ+ZrRjeMq9CRYECdWsEOWNsb5KUNGPTK8nDPjBrXaXvzFGUgUkGwBu6
         mOxX1rzOXB8FYeX4fQSn5e8Aa+pYZjWtwjtGpa/n/5bzRdsrlR6SUqPWQ6IGtlviuVh+
         nbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LVWyZ+MgKn+7Bsoyeo8qY34s+y6YancMwuntpY4XE2E=;
        b=Cupy6EdRH5M/9/iVnSkUqeu8Ep4UpYqjQICPT8pw6irEIMGj4JI4k1rMVOQGYJcKc0
         YdBdmFUnlEPNgIRe5CFgEMkjXfSa1UQZi+6Lb7TtAYx8ew+NTFfGlBpbx4Ls5J2Vuyh+
         /4vGJJ6Yw/x9JXcyWef7ptvDNf23DP+DLDFnMo56bFeQq+Z6YqyeWHqsyrFx0X8sFfcu
         5BOjxi1kwXWPvGaaOx1i+/3OHfPKs3IU2qcllBBxPQymwkGnc2t9pOGOCn5scK+fqXbk
         jHmWiHBYw3tDhOxmyBiutA0QaBvekJYqKNhCgcZZtu5MepmszyK3Nxk8S47ZBkC3XQZp
         zWSQ==
X-Gm-Message-State: AOUpUlE9mXsS3LEXR+WokfK9WE5X6t0lpUF/B8N/JRAMAXEsPROcUCjc
        Dc/jgPwTeaI6s+JxBdSCt0iIGbjJkY8fP6TlyUXMNw==
X-Google-Smtp-Source: AAOMgpeKqr4mlnpWlTXbWFdHFcWssoq406AACQmj5i3/OXRUanz0LA7473txND02oN6wNppJQpab0SM3Ui98nLzab0E=
X-Received: by 2002:a02:5952:: with SMTP id p79-v6mr3626391jab.129.1532132732577;
 Fri, 20 Jul 2018 17:25:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 17:25:31
 -0700 (PDT)
In-Reply-To: <20180720151156.GA31421@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-3-patrick.bellasi@arm.com> <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
 <20180720151156.GA31421@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 Jul 2018 17:25:31 -0700
Message-ID: <CAJuCfpGvpX5U9rED+vX=wW624GLZo8f=-2kOLGrY1UJSEXRh6g@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] sched/core: uclamp: map TASK's clamp values into
 CPU's clamp groups
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On Fri, Jul 20, 2018 at 8:11 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> Hi Suren,
> thanks for the review, all good point... some more comments follow
> inline.
>
> On 19-Jul 16:51, Suren Baghdasaryan wrote:
>> On Mon, Jul 16, 2018 at 1:28 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>
> [...]
>
>> > +/**
>> > + * uclamp_group_available: checks if a clamp group is available
>> > + * @clamp_id: the utilization clamp index (i.e. min or max clamp)
>> > + * @group_id: the group index in the given clamp_id
>> > + *
>> > + * A clamp group is not free if there is at least one SE which is sing a clamp
>>
>> Did you mean to say "single clamp"?
>
> No, it's "...at least one SE which is USING a clamp value..."
>
>> > + * value mapped on the specified clamp_id. These SEs are reference counted by
>> > + * the se_count of a uclamp_map entry.
>> > + *
>> > + * Return: true if there are no SE's mapped on the specified clamp
>> > + *         index and group
>> > + */
>> > +static inline bool uclamp_group_available(int clamp_id, int group_id)
>> > +{
>> > +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
>> > +
>> > +       return (uc_map[group_id].value == UCLAMP_NONE);
>>
>> The usage of UCLAMP_NONE is very confusing to me. It was not used at
>> all in the patch where it was introduced [1/12], here it's used as a
>> clamp value and in uclamp_group_find() it's used as group_id. Please
>> clarify the usage.
>
> Yes, it's meant to represent a "clamp not valid" condition, whatever
> it's a "clamp group" or a "clamp value"... perhaps the name can be
> improved.
>
>> I also feel UCLAMP_NONE does not really belong to
>> the uclamp_id enum because other elements there are indexes in
>> uclamp_maps and this one is a special value.
>
> Right, it looks a bit misplaced, I agree. I think I tried to set it
> using a #define but there was some issues I don't remember now...
> Anyway, I'll give it another go...
>
>
>> IMHO if both *group_id*
>> and *value* need a special value (-1) to represent
>> unused/uninitialized entry it would be better to use different
>> constants. Maybe UCLAMP_VAL_NONE and UCLAMP_GROUP_NONE?
>
> Yes, maybe we can use a
>
>    #define UCLAMP_NOT_VALID -1
>
> and get rid the confusing enum entry.
>
> Will update it on v3.
>

Sounds good to me.

>> > +}
>
> [...]
>
>> > +/**
>> > + * uclamp_group_find: finds the group index of a utilization clamp group
>> > + * @clamp_id: the utilization clamp index (i.e. min or max clamping)
>> > + * @clamp_value: the utilization clamping value lookup for
>> > + *
>> > + * Verify if a group has been assigned to a certain clamp value and return
>> > + * its index to be used for accounting.
>> > + *
>> > + * Since only a limited number of utilization clamp groups are allowed, if no
>> > + * groups have been assigned for the specified value, a new group is assigned
>> > + * if possible. Otherwise an error is returned, meaning that an additional clamp
>> > + * value is not (currently) supported.
>> > + */
>> > +static int
>> > +uclamp_group_find(int clamp_id, unsigned int clamp_value)
>> > +{
>> > +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
>> > +       int free_group_id = UCLAMP_NONE;
>> > +       unsigned int group_id = 0;
>> > +
>> > +       for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
>> > +               /* Keep track of first free clamp group */
>> > +               if (uclamp_group_available(clamp_id, group_id)) {
>> > +                       if (free_group_id == UCLAMP_NONE)
>> > +                               free_group_id = group_id;
>> > +                       continue;
>> > +               }
>> > +               /* Return index of first group with same clamp value */
>> > +               if (uc_map[group_id].value == clamp_value)
>> > +                       return group_id;
>> > +       }
>> > +       /* Default to first free clamp group */
>> > +       if (group_id > CONFIG_UCLAMP_GROUPS_COUNT)
>>
>> Is the condition above needed? I think it's always true if you got here.
>> Also AFAIKT after the for loop you can just do:
>>
>> return (free_group_id != UCLAMP_NONE) ? free_group_id : -ENOSPC;
>
> Yes, you right... the code above can be simplified!
>
>>
>> > +               group_id = free_group_id;
>> > +       /* All clamp group already track different clamp values */
>> > +       if (group_id == UCLAMP_NONE)
>> > +               return -ENOSPC;
>> > +       return group_id;
>> > +}
>
> [...]
>
>> > +static inline void uclamp_group_put(int clamp_id, int group_id)
>> > +{
>> > +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
>> > +       unsigned long flags;
>> > +
>> > +       /* Ignore SE's not yet attached */
>> > +       if (group_id == UCLAMP_NONE)
>> > +               return;
>> > +
>> > +       /* Remove SE from this clamp group */
>> > +       raw_spin_lock_irqsave(&uc_map[group_id].se_lock, flags);
>> > +       uc_map[group_id].se_count -= 1;
>>
>> If uc_map[group_id].se_count was 0 before decrement you end up with
>> se_count == -1 and no reset for the element.
>
> Well... this should never happen, otherwise the refcounting is not
> working as expected.
>
> Maybe we can add (at least) a debug check and warning, something like:
>
> #ifdef SCHED_DEBUG
>         if (unlikely(uc_map[group_id].se_count == 0)) {
>                 WARN(1, "invalid clamp group [%d:%d] refcount\n",
>                                 clamp_id, group_id);
>                 uc_map[group_id].se_count = 1;
>         }
> #endif
>
>> > +       if (uc_map[group_id].se_count == 0)
>> > +               uclamp_group_reset(clamp_id, group_id);
>> > +       raw_spin_unlock_irqrestore(&uc_map[group_id].se_lock, flags);
>> > +}
>> > +
>
> [...]
>
>> >  static inline int __setscheduler_uclamp(struct task_struct *p,
>> >                                         const struct sched_attr *attr)
>> >  {
>> > +       struct uclamp_se *uc_se;
>> > +       int retval = 0;
>> > +
>> >         if (attr->sched_util_min > attr->sched_util_max)
>> >                 return -EINVAL;
>> >         if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
>> >                 return -EINVAL;
>> >
>> > -       p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
>> > -       p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
>> > +       mutex_lock(&uclamp_mutex);
>> > +
>> > +       /* Update min utilization clamp */
>> > +       uc_se = &p->uclamp[UCLAMP_MIN];
>> > +       retval |= uclamp_group_get(p, UCLAMP_MIN, uc_se,
>> > +                                  attr->sched_util_min);
>> > +
>> > +       /* Update max utilization clamp */
>> > +       uc_se = &p->uclamp[UCLAMP_MAX];
>> > +       retval |= uclamp_group_get(p, UCLAMP_MAX, uc_se,
>> > +                                  attr->sched_util_max);
>> > +
>> > +       mutex_unlock(&uclamp_mutex);
>> > +
>> > +       /*
>> > +        * If one of the two clamp values should fail,
>> > +        * let the userspace know.
>> > +        */
>> > +       if (retval)
>> > +               return -ENOSPC;
>>
>> Maybe a minor issue but this failure is ambiguous. It might mean:
>> 1. no clamp value was updated
>> 2. UCLAMP_MIN was updated but UCLAMP_MAX was not
>> 3. UCLAMP_MAX was updated but UCLAMP_MIN was not
>
> That's right, I put a bit of thought on that me too but at the end
> I've been convinced that the possibility to use a single syscall to
> set both clamps at the same time has some benefits for user-space.
>
> Maybe the current solution can be improved by supporting an (optional)
> strict semantic with an in-kernel roll-back in case one of the two
> uclamp_group_get should fail.
>
> The strict semantic with roll-back could be controller via an
> additional flag, e.g. SCHED_FLAG_UTIL_CLAMP_STRICT.
>
> When the flag is set, either we are able to set both the attributes or
> we roll-back. Otherwise, when the flag is not set, we keep the current
> behavior. i.e. we set what we can and report an error to notify
> userspace that one constraints was not enforced.
>
> The following snippet should implement this semantics:
>
> ---8<---
>
> /* Uclamp flags */
> #define SCHED_FLAG_UTIL_CLAMP_STRICT    0x11 /* Roll-back on failure */
> #define SCHED_FLAG_UTIL_CLAMP_MIN       0x12 /* Update util_min */
> #define SCHED_FLAG_UTIL_CLAMP_MAX       0x14 /* Update util_max */
> #define SCHED_FLAG_UTIL_CLAMP           ( \
>                 SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)
>

Having ability to update only min or only max this way might be indeed
very useful.
Instead of rolling back on failure I would suggest to check both
inputs first to make sure there won't be any error before updating.
This would remove the need for SCHED_FLAG_UTIL_CLAMP_STRICT (which I
think any user would want to set to 1 anyway).
Looks like uclamp_group_get() can fail only if uclamp_group_find()
fails to find a slot for uclamp_value or a free slot. So one way to do
this search before update is to call uclamp_group_find() for both
UCLAMP_MIN and UCLAMP_MAX beforehand and if they succeed then pass
obtained next_group_ids into uclamp_group_get() to avoid doing the
same search twice. This requires some refactoring of
uclamp_group_get() but I think the end result would be a cleaner and
more predictable solution.

> static inline int __setscheduler_uclamp(struct task_struct *p,
>                                         const struct sched_attr *attr)
> {
>         unsigned int uclamp_value_old = 0;
>         unsigned int uclamp_value;
>         struct uclamp_se *uc_se;
>         int retval = 0;
>
>         if (attr->sched_util_min > attr->sched_util_max)
>                 return -EINVAL;
>         if (attr->sched_util_max > 100)
>                 return -EINVAL;
>
>         mutex_lock(&uclamp_mutex);
>
>         if (!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN))
>                 goto set_util_max;
>
>         uc_se = &p->uclamp[UCLAMP_MIN];
>         uclamp_value = scale_from_percent(attr->sched_util_min);
>         if (uc_se->value == uclamp_value)
>                 goto set_util_max;
>
>         /* Update min utilization clamp */
>         uclamp_value_old = uc_se->value;
>         retval |= uclamp_group_get(p, NULL, UCLAMP_MIN, uc_se, uclamp_value);
>         if (retval &&
>             attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_STRICT)
>                 goto exit_failure;
>
> set_util_max:
>
>         if (!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX))
>                 goto exit_done;
>
>         uc_se = &p->uclamp[UCLAMP_MAX];
>         uclamp_value = scale_from_percent(attr->sched_util_max);
>         if (uc_se->value == uclamp_value)
>                 goto exit_done;
>
>         /* Update max utilization clamp */
>         if (uclamp_group_get(p, NULL, UCLAMP_MAX,
>                              uc_se, uclamp_value))
>                 goto exit_rollback;
>
> exit_done:
>         mutex_unlock(&uclamp_mutex);
>         return retval;
>
> exit_rollback:
>         if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
>             attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_STRICT) {
>                 uclamp_group_get(p, NULL, UCLAMP_MIN,
>                                  uc_se, uclamp_value_old);
>         }
> exit_failure:
>         mutex_unlock(&uclamp_mutex);
>
>         return -ENOSPC;
> }
>
> ---8<---
>
>
> Could that work better?
>
> The code is maybe a bit more convoluted... but perhaps it can be
> improved by encoding it in a loop.
>
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
