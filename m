Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120A2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF33820856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tagNIWif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF33820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbeGWRmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:42:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36662 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388561AbeGWRmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:42:12 -0400
Received: by mail-it0-f66.google.com with SMTP id p81-v6so2142431itp.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sdbfCyumuNwhTC4R0PdOaII7r9U+SGWFspa0HltxNwE=;
        b=tagNIWifk/AOkrifmcKC7Y9sVITfcrWY/nR9A7vPGmdSnUMG1VUQrwL8iyD0uR9g4S
         14qJJlz/upnWsJ172WJ4pwoKLBiyYwGGxOCrduD2+C3hL5SXghvPbWpnk3DGuxQGWKvo
         xFffpdGAMQB58hW6ouerwE4np3u+90CF07BOx63SG90HcIIOmTsmGiBcZdlGjPdWo6CH
         23ZgyJt/hJ43rBpJnCAGqbmzf3gln8Q7cqmPLTRcBxag1VrN6swKLqSlTiKDx5eUOMBy
         TCtlF1beUCrDRF0W9m7Qn8Qm6APAZ6m0qZq83oVVIOGTR9mcGb3GkDCMmWHzQePxdJkn
         v4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sdbfCyumuNwhTC4R0PdOaII7r9U+SGWFspa0HltxNwE=;
        b=DkD59jppM413SdOELiJQY9RoL9nS8bTDUgZ0ia/3RZtl9qdAHUqZGR+h9lURvnWzNc
         vU2pDeSeSQvs9PByHyd7PuTsYcrUY7usTUNGv+7D0UQAredciQXz8XGaxrnA4ipE1YU4
         XYKuyItqXrlLJ/HA4NMpOKQEWSCz1dk45Kxl845nd02E5rP04mUd/u+K6QU7nFlvKSnC
         DARsvDt+6dW46Ft6XobUk6bHNuBEVIQ8JjIv9zcL6KLwk6dlgoKW/kawl1FrC2QBYGz+
         9FUVBxoQI2mg9FXeOaLEPdsUAYQmcfmpbY8fQji2h0xiubO5qOdwD1S6LkMe1s/1Laro
         k7Gg==
X-Gm-Message-State: AOUpUlF1qLSOW8l23s+kmLi0cXnovBtUuAmRdPs6jwubj931LWIQoCh3
        cohXOuAMLHKSxi3aCejdWE6qoI26tTWau+AzQM4vDg==
X-Google-Smtp-Source: AAOMgpdtK9c5VCq001AOx/A2yMa3KcKwALGd2WzPBNIVcHFZY1JggQBFXmeKk7gTRlfwXCULX1pIUTjf6uw/vmQCwBw=
X-Received: by 2002:a02:5952:: with SMTP id p79-v6mr11817860jab.129.1532364008981;
 Mon, 23 Jul 2018 09:40:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 09:40:08
 -0700 (PDT)
In-Reply-To: <20180723150249.GD2683@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-8-patrick.bellasi@arm.com> <CAJuCfpH6CsDVG35Z3NV87mUgJW9TmoCuOs8GeW2TEqkP0K0f9g@mail.gmail.com>
 <20180723150249.GD2683@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Jul 2018 09:40:08 -0700
Message-ID: <CAJuCfpG7vmOJZOuZBqy7G3b-ovXeLmPVB9pBaj=XKviOZ7PWzA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] sched/core: uclamp: enforce last task UCLAMP_MAX
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

On Mon, Jul 23, 2018 at 8:02 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 20-Jul 18:23, Suren Baghdasaryan wrote:
>> Hi Patrick,
>
> Hi Sure,
> thank!
>
>> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>
> [...]
>
>> > @@ -977,13 +991,21 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
>> >         uc_grp = &rq->uclamp.group[clamp_id][0];
>> >         uc_grp[group_id].tasks += 1;
>> >
>> > +       /* Force clamp update on idle exit */
>> > +       uc_cpu = &rq->uclamp;
>> > +       clamp_value = p->uclamp[clamp_id].value;
>> > +       if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {
>>
>> The condition below is not needed because UCLAMP_FLAG_IDLE is set only
>> for UCLAMP_MAX clamp_id, therefore the above condition already covers
>> the one below.
>
> Not really, this function is called two times, the first time to
> update UCLAMP_MIN and a second time to update UCLAMP_MAX.
>
> For both clamp_id we want to force update uc_cpu->value[clamp_id],
> thus the UCLAMP_FLAG_IDLE flag has to be cleared only the second time.
>
> Maybe I can had the following comment to better explain the reason of
> the check:
>
>                 /*
>                  * This function is called for both UCLAMP_MIN (before) and
>                  * UCLAMP_MAX (after). Let's reset the flag only the when
>                  * we know that UCLAMP_MIN has been already updated.
>                  */
>

Ah, my bad. I missed the fact that uc_cpu->flags is shared for both
UCLAMP_MIN and UCLAMP_MAX. It's fine the way it originally was. Thanks
for explanation!

>> > +               if (clamp_id == UCLAMP_MAX)
>> > +                       uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;
>> > +               uc_cpu->value[clamp_id] = clamp_value;
>> > +               return;
>> > +       }
>
> [...]
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
