Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E3FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881F22081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThrKgFfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881F22081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeKERSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:18:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51729 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeKERST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:18:19 -0500
Received: by mail-it1-f193.google.com with SMTP id h13so11445137itl.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 23:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i28DBGLbaF8ntoHzdw8vDZ+cVJIJP2mTvCsI6lWVOGE=;
        b=ThrKgFfSjkTvfECIstDh2dKajWTD6wHDAxBGurID3/xY5yfOlStR9FKvd2KaE7R+BE
         fi7BrzjJzfDCWJ2diqpsBEYQ65fV0rAItHLnPznF6la9LZYOl/ZKLmgn3frIeWYjeUSj
         Fy4zzMXBre0tM6qn2QR+PjbVQpStuXwl1sl/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i28DBGLbaF8ntoHzdw8vDZ+cVJIJP2mTvCsI6lWVOGE=;
        b=ca7GVF73I2txgaVJjYosaRVa+VgEpUjehVT9g1tEeYmMDaAkMqQKb32AsTmN/W+rpw
         LMWJ/nEOqTs7+YN/JC/ZcSthL9GHWEilntIpWl3DdPzj/g2Ojmml/8iWvbgffbfDkkz/
         /ZJWITomDiEx2N9MwKPrqDEk7aMM7iB05SqqAq4LyuhJmRbDhd2WM5uX/ndVIxbJU4Br
         C2efGOPOBtSvVJ/mkou7hhwt9BVS2wCvD5Lsou3Lil6RbV//bbCm9D/0hQ+qYgwAZxqy
         lxnH/Z60673/OWflNs3iMycICecA4bndjTm9yDWFfoasF5YGNKxrkRjHGcwGdQaEBHcV
         rGcw==
X-Gm-Message-State: AGRZ1gI1kh90CRM9Jvjd+Ov7rPnLqOABWZPa8CpA4pxzbArFC7jjv+Db
        98dzTySNdDjmiQsl2PMMrgKd9Rgto0rfT6jvzf89CQ==
X-Google-Smtp-Source: AJdET5cALfm2g7iXG/WaZviQXuzNzXO0RBimIZXutc1zUaFrapoG7btfC8d/16lPnzif4Ap1+ZC9w/0YLdYml21RpOM=
X-Received: by 2002:a24:c983:: with SMTP id h125-v6mr5885654itg.152.1541404793402;
 Sun, 04 Nov 2018 23:59:53 -0800 (PST)
MIME-Version: 1.0
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
 <6d0b324e-5e26-a510-9bcd-97f475e515ed@arm.com> <CAKfTPtAPsq3fYrLEX7otQ+6Wy5JrQsYG8nLnEWT+09JBi=iKnQ@mail.gmail.com>
 <145bfbd2-f07f-6312-ca2f-029a5301fb15@arm.com>
In-Reply-To: <145bfbd2-f07f-6312-ca2f-029a5301fb15@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 5 Nov 2018 08:59:42 +0100
Message-ID: <CAKfTPtDVuOJbovFo+7Xucavom-F7nhGxp=y7YMkQUR3y8fDVGg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 at 10:38, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 10/31/18 10:18 AM, Vincent Guittot wrote:
> > Hi Dietmar,
> >
> > On Wed, 31 Oct 2018 at 08:20, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 10/26/18 6:11 PM, Vincent Guittot wrote:
> >>
> >> [...]
> >>
> >>>    static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
> >>>    static unsigned long task_h_load(struct task_struct *p);
> >>> @@ -764,7 +763,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
> >>>                         * such that the next switched_to_fair() has the
> >>>                         * expected state.
> >>>                         */
> >>> -                     se->avg.last_update_time = cfs_rq_clock_task(cfs_rq);
> >>> +                     se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
> >>>                        return;
> >>>                }
> >>>        }
> >>
> >> There is this 1/cpu scaling of se->avg.util_sum (running_sum) in
> >> update_tg_cfs_runnable() so it can be used to calculate
> >> se->avg.runnable_load_sum (runnable_sum). I guess with your approach
> >> this should be removed.
> >
> > Yes good catch
>
> Another thing, since you do not need the cpu parameter in
> accumulate_sum() anymore, you could also get rid of it in
> ___update_load_sum() and further in __update_load_avg_blocked_se(),
> __update_load_avg_cfs_rq() and __update_load_avg_se().

yes, I have to clean interface from reference to cpu

>
> Nitpick: The function header of update_cfs_rq_load_avg() mentions '@now:
> current time, as per cfs_rq_clock_task()' ... should mention
> cfs_rq_clock_pelt() instead.

ok

>
> [...]
