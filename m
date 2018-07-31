Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2FFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C5F208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5jD5jnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C5F208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbeGaN5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:57:43 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54775 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731812AbeGaN5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:57:42 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so4104530itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4t7P4h/HAZl40W4Wqv2p6kIrOQJrTuNKRArebvuQZw=;
        b=M5jD5jnujpH46pfjb0WNs1864FMh4JWQfGxDW2RRZ45A0fclFiit+WLsHowDPrgj6U
         V/riA4bWk8sOjN+dyfMnf+5NnVndS6fpufGYGabH9OK3v6UDwSf/rXAZmZVjpApoOwV2
         if7aY3aet68amQWZ/Z8/+r13eNU2sktsuwYeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4t7P4h/HAZl40W4Wqv2p6kIrOQJrTuNKRArebvuQZw=;
        b=VTshYlLk/nZ39yZSpnEuRSXw1rr1hU9esG8fJgAHUi525PNu6yLQt6HRGVyTQv9OMp
         qO63sAid8kO6mzoQ9fo2Hi1IwA8gqDvf1mfV5LS0gE83rkvPYb53hmBxK14w7K8x89Db
         VUv44nTowNJIMERoKpbtwYFeM6DjjCYka3/Lves2/RtBZDI8NWsS0+nG9zPLtB6hGCUb
         ID7rS/yEc4z8LCfZqSKEwGyCgsr2zV9LfIHtI7SwqLVEnO7GdsZVh7ZqqRbNX+7mE6F6
         AVuogz1bcNxDjHkFDlffh2Ma6+JhaGhEk4GkjBq5Cl1eb6erdBaADhWaYCLWQjNXJ7gS
         XIcQ==
X-Gm-Message-State: AOUpUlEH8wiJSRx2tgHjnHTY8CALIeVvCKCziGmAzrJzGGLID5lv9xB4
        thzgcVfrupnoIeLt1MJsVaOH6TR4GdnMP+sZWhCcGQ==
X-Google-Smtp-Source: AAOMgpdIGIz9koaowe9kDoQZN4ZPsjDvqW28ujgd9ZeQWg8lBahwQ58Rw6Sb7flbE7RHf1/vCCukrZ/QzF1DA9zGJm4=
X-Received: by 2002:a24:55cd:: with SMTP id e196-v6mr2605184itb.8.1533039458585;
 Tue, 31 Jul 2018 05:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <1530699470-29808-13-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtDUa7nARKxT+hR_ci3J_exE85sZFT1oEM84akZ+i_-UgA@mail.gmail.com> <20180706143139.GE8596@e105550-lin.cambridge.arm.com>
In-Reply-To: <20180706143139.GE8596@e105550-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 31 Jul 2018 14:17:27 +0200
Message-ID: <CAKfTPtB1YGoYwNyXXs5_+0Lc3KiDZ1g=5nXsa_Y03pJEbQ+jgg@mail.gmail.com>
Subject: Re: [PATCHv4 12/12] sched/core: Disable SD_PREFER_SIBLING on
 asymmetric cpu capacity domains
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 at 16:31, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>
> On Fri, Jul 06, 2018 at 12:18:17PM +0200, Vincent Guittot wrote:
> > On Wed, 4 Jul 2018 at 12:18, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> > >
> > > The 'prefer sibling' sched_domain flag is intended to encourage
> > > spreading tasks to sibling sched_domain to take advantage of more caches
> > > and core for SMT systems. It has recently been changed to be on all
> > > non-NUMA topology level. However, spreading across domains with cpu
> > > capacity asymmetry isn't desirable, e.g. spreading from high capacity to
> > > low capacity cpus even if high capacity cpus aren't overutilized might
> > > give access to more cache but the cpu will be slower and possibly lead
> > > to worse overall throughput.
> > >
> > > To prevent this, we need to remove SD_PREFER_SIBLING on the sched_domain
> > > level immediately below SD_ASYM_CPUCAPACITY.
> >
> > This makes sense. Nevertheless, this patch also raises a scheduling
> > problem and break the 1 task per CPU policy that is enforced by
> > SD_PREFER_SIBLING.
>
> Scheduling one task per cpu when n_task == n_cpus on asymmetric
> topologies is generally broken already and this patch set doesn't fix
> that problem.
>
> SD_PREFER_SIBLING might seem to help in very specific cases:
> n_litte_cpus == n_big_cpus. In that case the little group might
> classified as overloaded. It doesn't guarantee that anything gets pulled
> as the grp_load/grp_capacity in the imbalance calculation on some system
> still says the little cpus are more loaded than the bigs despite one of
> them being idle. That depends on the little cpu capacities.
>
> On systems where n_little_cpus != n_big_cpus SD_PREFER_SIBLING is broken
> as it assumes the group_weight to be the same. This is the case on Juno
> and several other platforms.
>
> IMHO, SD_PREFER_SIBLING isn't the solution to this problem. It might

I agree but this patchset creates a regression in the scheduling behavior

> help for a limited subset of topologies/capacities but the right
> solution is to change the imbalance calculation. As the name says, it is

Yes that what does the prototype that I came with.

> meant to spread tasks and does so unconditionally. For asymmetric
> systems we would like to consider cpu capacity before migrating tasks.
>
> > When running the tests of your cover letter, 1 long
> > running task is often co scheduled on a big core whereas short pinned
> > tasks are still running and a little core is idle which is not an
> > optimal scheduling decision
>
> This can easily happen with SD_PREFER_SIBLING enabled too so I wouldn't
> say that this patch breaks anything that isn't broken already. In fact
> we this happening with and without this patch applied.

At least for the use case  above, this doesn't happen when
SD_PREFER_SIBLING is set

>
> Morten
