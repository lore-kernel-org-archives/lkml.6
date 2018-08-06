Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BABC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AF5219F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1U/xzsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AF5219F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbeHFM2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:28:47 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:54959 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeHFM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:28:47 -0400
Received: by mail-it0-f45.google.com with SMTP id s7-v6so16676988itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oY2RMSgzbkL8TYkYJGoPtvwTWFi7kvp0dN42o5kek3s=;
        b=h1U/xzsQGTTAV+HX6grbDoZ4T+5r1zCnf2Avyl7dbIJAr0vTmC80rwZ+KT/t6nKOrD
         7bR7XAar2htGiF6/w46ZZyMY6nVJgbR8TikgnzaqDbgbv5XXzLt7Bhc5P7JjQe4eSdxi
         NK2zEuiI1VY8iahsCH565kPM4LjHIG2rqfnAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oY2RMSgzbkL8TYkYJGoPtvwTWFi7kvp0dN42o5kek3s=;
        b=Q8qxJKKJPteUtXxE4maJk1G3ICMU7KGqu2w/5n+M7k+5ILylNsNxn5xKWqZPCW6jz/
         yM687rSJMpea6nOozg8m2WuCmSa5nVwKJ/lZ2IGxFFNn7/8KiLjYAzGPv1c8M8DFP9JX
         mIhJTtWmMvwLd07aeVi3J5PFu7aXKeoIwpURGUuU6l67t9lnzmdoE7UHaYt9gabxolOf
         r/fsuW+eMVrABHijDLCqzrw1BGkArF1pgIrH0UegaElpEUIrzFdmvqT9zyWFwdTzQ54M
         ENAbY+WBYckzD9MsbG5k+Yjuiyn9g0zVpx7+R+QEwbXQzsGaZk8R10utKvSPOVDUat/7
         1g3g==
X-Gm-Message-State: AOUpUlHZaVdGUq1y7ht0/W8JGlOOHarzxzfz+fScYg3uZfHBHmnSemx8
        5TEcxNDlp3ferxA1L01zhSdrWM5CPZ4m9oeKyf4yag==
X-Google-Smtp-Source: AA+uWPx7Mkt/bhDaYHFf0Zj/YNKx6ZmsQo2mYVP8WpPVSewGp6KS9241zvvmGuYJbfbV2MA3LGGI/6P11ijOIBWypxk=
X-Received: by 2002:a24:55cd:: with SMTP id e196-v6mr4776529itb.8.1533550824345;
 Mon, 06 Aug 2018 03:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <1530699470-29808-13-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtDUa7nARKxT+hR_ci3J_exE85sZFT1oEM84akZ+i_-UgA@mail.gmail.com>
 <20180706143139.GE8596@e105550-lin.cambridge.arm.com> <CAKfTPtB1YGoYwNyXXs5_+0Lc3KiDZ1g=5nXsa_Y03pJEbQ+jgg@mail.gmail.com>
 <fd8c6bc2-3a1c-3572-7082-bc51c8f87ae9@arm.com>
In-Reply-To: <fd8c6bc2-3a1c-3572-7082-bc51c8f87ae9@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 6 Aug 2018 12:20:13 +0200
Message-ID: <CAKfTPtA3_yBf-NjPJcZUw=ijhq-HBa0A9U=Djcc_K1XQz45EPQ@mail.gmail.com>
Subject: Re: [PATCHv4 12/12] sched/core: Disable SD_PREFER_SIBLING on
 asymmetric cpu capacity domains
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Tue, 31 Jul 2018 at 14:33, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi,
>
> On 31/07/18 13:17, Vincent Guittot wrote:
> > On Fri, 6 Jul 2018 at 16:31, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> >>
> >> On Fri, Jul 06, 2018 at 12:18:17PM +0200, Vincent Guittot wrote:
> >>> [...]
> >>
> >> Scheduling one task per cpu when n_task == n_cpus on asymmetric
> >> topologies is generally broken already and this patch set doesn't fix
> >> that problem.
> >>
> >> SD_PREFER_SIBLING might seem to help in very specific cases:
> >> n_litte_cpus == n_big_cpus. In that case the little group might
> >> classified as overloaded. It doesn't guarantee that anything gets pulled
> >> as the grp_load/grp_capacity in the imbalance calculation on some system
> >> still says the little cpus are more loaded than the bigs despite one of
> >> them being idle. That depends on the little cpu capacities.
> >>
> >> On systems where n_little_cpus != n_big_cpus SD_PREFER_SIBLING is broken
> >> as it assumes the group_weight to be the same. This is the case on Juno
> >> and several other platforms.
> >>
> >> IMHO, SD_PREFER_SIBLING isn't the solution to this problem. It might
> >
> > I agree but this patchset creates a regression in the scheduling behavior
> >
> >> help for a limited subset of topologies/capacities but the right
> >> solution is to change the imbalance calculation. As the name says, it is
> >
> > Yes that what does the prototype that I came with.
> >
> >> meant to spread tasks and does so unconditionally. For asymmetric
> >> systems we would like to consider cpu capacity before migrating tasks.
> >>
> >>> When running the tests of your cover letter, 1 long
> >>> running task is often co scheduled on a big core whereas short pinned
> >>> tasks are still running and a little core is idle which is not an
> >>> optimal scheduling decision
> >>
> >> This can easily happen with SD_PREFER_SIBLING enabled too so I wouldn't
> >> say that this patch breaks anything that isn't broken already. In fact
> >> we this happening with and without this patch applied.
> >
> > At least for the use case  above, this doesn't happen when
> > SD_PREFER_SIBLING is set
> >
>
> On my HiKey960 I can see coscheduling on a big CPU while a LITTLE is free
> with **and** without SD_PREFER_SIBLING. Having it set only means that in
> some cases the imbalance will be re-classified as group_overloaded instead
> of group_misfit_task, so we'll skip the misfit logic when we shouldn't (this
> happens on Juno for instance).

Can you give more details about your test case ?

>
> It does nothing for the "1 task per CPU" problem that Morten described above.
> When you have this little amount of tasks, load isn't very relevant, but it
> skews the load-balancer into thinking the LITTLE CPUs are more busy than
> the bigs even though there's an idle one in the lot.
>
> >>
> >> Morten
