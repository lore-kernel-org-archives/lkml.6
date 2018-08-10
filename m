Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5547EC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0781F223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/YsD6BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0781F223F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeHJL7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:59:34 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42685 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeHJL7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:59:34 -0400
Received: by mail-io0-f195.google.com with SMTP id n18-v6so7113016ioa.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFusjVxECGoron62r/H+rHpDlXwPMZk8NPJCaimLVy8=;
        b=Y/YsD6BXzEZjI4SIx5fuvq4FQbr3DU8PGY1svzyaWm0Kh9KvtqDZt25dLEZxw51x2r
         lo7vPP+2RNJaXHBTqlwTcINhNWUaZUG/ti4MXlQGQBYfvJoWFio2wAbhG46DGJgypbz5
         I/4Hpy8+tq9XdsJHj8aWiomVYxHdICoxs79d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFusjVxECGoron62r/H+rHpDlXwPMZk8NPJCaimLVy8=;
        b=t1vZNgXGNOdNxJjmosiPm/7tQp/Ra7bYn160/liHe83IJckHhQ3UVdDljS7bKBydQn
         Hb/frTcJOubb3mQfIHRJy0rhtHHHL58cpb3/fhfcUyx9dRWqQzcoBC2w0rh7lsCgM77p
         Kz7vTMgomrGX+wAWN4roIcEiZwH0ZtXpx9rwS4O0QGY+aDEhkdi6O391A/0aSCfHRN39
         UvIqkBxgZkBcNwt2EbsOCSfbAn+OMgeMjzI2/M/O2cMusPbFRfuFrFCL9HShBP61A2zm
         x7HxoshI/I5tDgKlwQ4NtHbhb+Osjdu2qa3xPP18QhJRUUCgiAl6DZE1vMz+IVxkGaMo
         kjSQ==
X-Gm-Message-State: AOUpUlHw41biTr/8RTVAu8ui1bmH6FzjNXkobNqJKU5eZiAp3IGMAV9b
        ypg/JZNGo0wY331IWrCQ6Pgc6AcLioGRgJaioyIziw==
X-Google-Smtp-Source: AA+uWPzGtRu+XI+6o0GIniVKXU2IdoGfdnJ993NNbdymcGWNez4l9nEaDd54mzG9g8frEL5b9XTNJGohTqnBXd9Hf30=
X-Received: by 2002:a5e:8341:: with SMTP id y1-v6mr4386960iom.183.1533893429655;
 Fri, 10 Aug 2018 02:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <1530699470-29808-13-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtDUa7nARKxT+hR_ci3J_exE85sZFT1oEM84akZ+i_-UgA@mail.gmail.com>
 <20180706143139.GE8596@e105550-lin.cambridge.arm.com> <CAKfTPtB1YGoYwNyXXs5_+0Lc3KiDZ1g=5nXsa_Y03pJEbQ+jgg@mail.gmail.com>
 <fd8c6bc2-3a1c-3572-7082-bc51c8f87ae9@arm.com> <CAKfTPtA3_yBf-NjPJcZUw=ijhq-HBa0A9U=Djcc_K1XQz45EPQ@mail.gmail.com>
 <b7c78d65-ab85-36ce-6da6-d10e5113c4a3@arm.com>
In-Reply-To: <b7c78d65-ab85-36ce-6da6-d10e5113c4a3@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 10 Aug 2018 11:30:18 +0200
Message-ID: <CAKfTPtCfzpbcxzbMiOxd3kXWaES2+ai6vUEXET0++5W-mWDUdA@mail.gmail.com>
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

On Mon, 6 Aug 2018 at 12:53, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi,
>
> On 06/08/18 11:20, Vincent Guittot wrote:
> > Hi Valentin,
> >
> > On Tue, 31 Jul 2018 at 14:33, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> Hi,
> >>
> >> On 31/07/18 13:17, Vincent Guittot wrote:
> >> [...]
> >>>>
> >>>> This can easily happen with SD_PREFER_SIBLING enabled too so I wouldn't
> >>>> say that this patch breaks anything that isn't broken already. In fact
> >>>> we this happening with and without this patch applied.
> >>>
> >>> At least for the use case  above, this doesn't happen when
> >>> SD_PREFER_SIBLING is set
> >>>
> >>
> >> On my HiKey960 I can see coscheduling on a big CPU while a LITTLE is free
> >> with **and** without SD_PREFER_SIBLING. Having it set only means that in
> >> some cases the imbalance will be re-classified as group_overloaded instead
> >> of group_misfit_task, so we'll skip the misfit logic when we shouldn't (this
> >> happens on Juno for instance).
> >
> > Can you give more details about your test case ?
> >
>
> I've been running the same test case as presented in the cover letter on
> my HiKey960 but with sched_switch tracing and with no tasksets. I've just
> re-run the testcase with tasksets and I get similar results (i.e. a big
> with coscheduling while a LITTLE is free) with or without the flag.
>
> >>
> >> It does nothing for the "1 task per CPU" problem that Morten described above.
> >> When you have this little amount of tasks, load isn't very relevant, but it
> >> skews the load-balancer into thinking the LITTLE CPUs are more busy than
> >> the bigs even though there's an idle one in the lot.

ok. I meant  that without misfit patch, SD_PREFER_SIBLING ensures 1
task per CPU and no co scheduling. But co scheduling appears with
misfit task patchset

Vincent
> >>
> >>>>
> >>>> Morten
