Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C71C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DEA2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FnJvJabA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeLSPyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:54:17 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34896 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeLSPyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:54:14 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so10045018itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PtiwN4t4ouN3o2d4izuqMve9Ku6kp2950kAl+vfjZY4=;
        b=FnJvJabAG/eLGytkhB9TSf/XWqWH0tAVLJNq5Rd7KZbH8Mqf3fvV3QkXl9X2qPyhHd
         jOr+SDXKHz5xB6Ba4vDlI1pLgoLr0zlD8CUdvLW6usieh1HkU8tG0rF/E4s52YT/9vDo
         pYrsWPEIzsYwHjx2dwl1JwQzjBoD+vQeURwnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PtiwN4t4ouN3o2d4izuqMve9Ku6kp2950kAl+vfjZY4=;
        b=Gcydd4CkfAPgVNIEenRMQtFukrfJN6qvnGGBt9WdvvvmqVbr2hnwvNBkVygI4OQ3fb
         yV3OTWtLvb6zXgN0dJaMLzvjpjdTWRBsgLvZMkWh0jLQuwHKcN5lvoYJIU4N64uM4muD
         EKZpYFo/sNlpPL6Ynyp22+kGxJI2JNIX3nVloRCm3q/NPhb9bWCcCUhzcbelDYVYIwH9
         G9t10vSkD+IuIq9HFsnNfdUiyrxu359Fk5wBvm74ggHuG6QbDnzEVmIbzG3ZqekZhuNY
         H2uP77HEbx+pM3VEXHbR4ZEBk4qR7Fo1s3rXEY7+pXxUJMZKY37YiKuoEz1jLhOqAd3i
         jgjw==
X-Gm-Message-State: AA+aEWaafHjuBrB0dhgAC5ASUmglc8a0opmqD06ySHyQAzku1rgHTb2+
        g0FpafrnqzlKIEC+bfXFDVP+NqdzidbZAAwTC4uL1Q==
X-Google-Smtp-Source: AFSGD/XzRG8uewGYJm4wmk401llNFADoR0noqoV0aB3G8q6YqFBF50BzzfSMA2Gqb/YHoXPQ6ZfDGqq7rDmbS8RhX/s=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr6940174itk.114.1545234853410;
 Wed, 19 Dec 2018 07:54:13 -0800 (PST)
MIME-Version: 1.0
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-2-git-send-email-vincent.guittot@linaro.org>
 <f2619d92-7367-abd4-97e8-e0f4e7cc96eb@arm.com> <CAKfTPtAEi=EBmSUEcYmkfSZVkBviQaJaqZXvt-=XbsgZs5t_OA@mail.gmail.com>
 <4de22c37-fe65-4f5f-929b-320c663ee8b6@arm.com> <CAKfTPtAprHq4YYdJ1gnuoAcNiVFpFPnxYv_=RS6pXs8aYpjcuA@mail.gmail.com>
 <8ea1a96c-c2e0-cc3f-1cec-444706383e77@arm.com> <CAKfTPtCVqSYOC_GUdBm8_5KNMNEwXdf77mXL4SDB4_G5_iE0iA@mail.gmail.com>
 <f48118ab-8782-a096-9299-58c6b8d384bb@arm.com> <CAKfTPtDwUqf1tKxOkJ-rU2FHUL63=smEtCRu5dqwYZC7zjvtJw@mail.gmail.com>
 <913b1033-cc8e-d109-6096-c3a73ec0c87c@arm.com>
In-Reply-To: <913b1033-cc8e-d109-6096-c3a73ec0c87c@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Dec 2018 16:54:02 +0100
Message-ID: <CAKfTPtBuv-72b6rMBNfA_5THWvVm5jxGGPkSAc6LVK5+6X8eAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/fair: fix rounding issue for asym packing
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

On Wed, 19 Dec 2018 at 16:30, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 19/12/2018 15:20, Vincent Guittot wrote:
> [...]
> >> Oh yes, I never said it didn't work - I was doing some investigation on
> >> the reason as to why we'd need this fix, because it's wasn't explicit from
> >> the commit message.
> >>
> >> The rounding errors are countered by the +1, yes, but I'd rather remove
> >> the errors altogether and go for the snippet I suggested in my previous
> >> reply.
> >
> > except that you don't always want to migrate all group load.
> > I prefer keeping current algorithm and fix it for now. Trying "new"
> > thing can come in a 2nd step
>
> We already set the imbalance as the whole group load, we just introduce
> rounding errors inbetween. As I've already said:
>
> in update_sg_lb_stats() we do:
>
>         sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
>
> and in check_asym_packing() we do:
>
>         env->imbalance = DIV_ROUND_CLOSEST(
>                 sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
>                 SCHED_CAPACITY_SCALE)
>
> So we end up with something like:
>
>                     group_load * SCHED_CAPACITY_SCALE * group_capacity
>         imbalance = --------------------------------------------------
>                             group_capacity * SCHED_CAPACITY_SCALE
>
> Which we could reduce down to:
>
>         imbalance = group_load

ah yes, i thought the nr_running was involved but it's not the case.
This looks better indeed

>
> and not get any rounding errors.
