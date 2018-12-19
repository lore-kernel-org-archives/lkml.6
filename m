Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBA7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDA521841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZelNFQ/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeLSN3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:29:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33186 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbeLSN3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:29:23 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so15624743ioi.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKXziJRCY841i1SuoWZPX2c/HR6yQ84M4KDu9k++eqg=;
        b=ZelNFQ/hC5yTRM8OZSDKVUaaY9kAsg3af3rETEeSP78Kv2a2rrIn4r7+OHAZ7MqO1s
         5BluB4OYV60+UWQH+kjxS1DqAdaKwcmM/unkHAn0KVgOamhkBL+qBWIhpaYl2pxqmXyA
         XmUwNx/gm4EazaNMVW7l0tUlrKOm/f6g260vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKXziJRCY841i1SuoWZPX2c/HR6yQ84M4KDu9k++eqg=;
        b=s8lS7oaveXjuI/MaeBo9HqrLYVWWpjO0ihS0pfRhrsMEdUYWv/BenAAf0BbeLfe/Eq
         0w3oBT71aiO8I1U8lI3dyZAAF8/t+hVrZofoxCLh9TdtT3hSZjV38HwGldntgREX/Md9
         rK4K8wcbfd1h+YApdEjzgz31jT+Prp4DffUwL4OAdqmfzmD/ihYI2nje55dUbIsKoXX9
         jGAj8ySeoy4xLPXfczTJFHWVuW97xuw7tRJk9tyNLkhJzLVDi9wnutPqg2mw6mu7tSfg
         6L4GYazMQEB3MOgoo3LX85z4+EPm88b1PxoKIptXA+HmWlpIr1+jyfnbvpOMMq36KvNe
         0Wog==
X-Gm-Message-State: AJcUukeoL6pZkqtEtTs2RNm6czxRXpuBvthHY8/gL4bAF8He9rpbR1jg
        pOw5GHj9Spr+wWgOHt+1RyLIUPPgvs7Y8+miTIkBAA==
X-Google-Smtp-Source: ALg8bN4UTxTdB+PbTcSPZKCzUcSYrKx2LEa0Ka8NwhaU6c8UWUjeOi0Z+a+JTcNxU+roPFrc8SK9Aikfg7PpxfflYH8=
X-Received: by 2002:a6b:6b01:: with SMTP id g1mr777535ioc.18.1545226161608;
 Wed, 19 Dec 2018 05:29:21 -0800 (PST)
MIME-Version: 1.0
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-4-git-send-email-vincent.guittot@linaro.org>
 <f6443ca2-3e82-d4eb-deb8-2aff44c618e2@arm.com> <CAKfTPtCJBGtmx7pQJCwhcMaxyXWoh04o_C+pR6z+YVykXwvv5Q@mail.gmail.com>
 <07400c1b-d9d7-7619-57fb-b09276d7da92@arm.com> <CAKfTPtA0HQL9xsMbAH-2u63XaEJ-4mwzdBzNzvVSA8_3XyQ89g@mail.gmail.com>
 <9b008c93-c78c-0761-5ac9-cc1c3806f24b@arm.com> <CAKfTPtDqtoUOnYMPhiAoG1Utc4YY+4Xm0=NgfzC7STWJDxiuYg@mail.gmail.com>
 <7a1aaf61-c352-69fc-b990-861bc2aef85b@arm.com>
In-Reply-To: <7a1aaf61-c352-69fc-b990-861bc2aef85b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Dec 2018 14:29:10 +0100
Message-ID: <CAKfTPtDk8z_aBapA3FM5Af1benOyqYYcTpMVWZ9KsjDP7wSJ4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/fair: fix unnecessary increase of balance interval
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 12:16, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 19/12/2018 08:27, Vincent Guittot wrote:
> [...]
> >> Wouldn't LBF_ALL_PINNED cover all relevant cases? It's set at the very top
> >> of the 'if (busiest->nr_running > 1)' block and cleared whenever we find
> >> at least one task we could pull, even if we don't pull it because of
> >> other reasons in can_migrate_task() (e.g. cache hotness).
> >>
> >> If we have LBF_SOME_PINNED but not LBF_ALL_PINNED, we currently don't
> >> increase the balance_interval, which is what we would want to maintain.
> >
> > But there are several other UC to do active migration and increase the interval
> > like all except running tasks are pinned
> >
>
> My point is that AFAICT the LBF_ALL_PINNED flag would cover all the cases
> we care about, although the one you're mentioning is the only one I can
> think of. In that case LBF_ALL_PINNED would never be cleared, so when we do
> the active balance we'd know it's because all other tasks were pinned so
> we should probably increase the interval (see last snippet I sent).

There are probably several other UC than the one mentioned below as
tasks can be discarded for several reasons.
So instead of changing for all UC by default, i would prefer only
change for those for which we know it's safe

>
> [...]
> >> So that's all the need_active_balance() cases except the last
> >> sd->nr_balance_failed one. I'd argue this could also be counted as a
> >> "good" reason to active balance which shouldn't lead to a balance_interval
> >> increase. Plus, it keeps to the logic of increasing the balance_interval
> >> only when task affinity gets in the way.
> >
> > But this is some kind of affinity, the hotness is a way for the
> > scheduler to temporarily pinned the task on a cpu to take advantage of
> > cache hotness.
> >
> > I would prefer to be conservative and only reset the interval when we
> > are sure that active load balance is really what we want to do.
> > Asym packing is one, we can add the misfit case and the move task on
> > cpu with more available capacity as well. For the other case, it's
> > less obvious and I would prefer to keep current behavior
> >
>
> Mmm ok so this one is kinda about semantics on what do we really consider
> as "pinning".
>
> If we look at the regular load_balance() path, if all tasks are cache hot
> (so we clear LBF_ALL_PINNED but don't pass can_migrate_task()) we won't
> increase the balance_interval. Actually, if we have !active_balance we'll
> reset it.
>
> Seeing as the duration of a task's cache hotness (default .5ms) is small
> compared to any balance_interval (1ms * sd_weight), IMO it would make sense
> to reset the interval for all active balance cases. On top of that, we
> would keep to the current logic of increasing the balance_interval *only*
> when task->cpus_allowed gets in the way.
