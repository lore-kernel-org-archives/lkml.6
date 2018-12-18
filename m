Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D981C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0B52145D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3yIC1z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeLRBWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:22:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40074 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeLRBWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:22:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so380398wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 17:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFGWv6X8z3NwFialNaeSsACmFB5fqtUuW9oC4mugWj4=;
        b=l3yIC1z24v0r3Yyxrmq1CCmwuEpPGGLweeNlEXuGnjDG//zHj98KJs+aO07RlEWBJu
         EV91sC4cK59Ckg3Dws+kWuu4UFAIjAkw0VnO1ND8uINmrTH5BvLLqNQkhtg81i8LypjB
         KDXThdLTJoDH/kvvlzp/npeS4W63wz3InzwaXy2BIv83yINt9LwsktznaONO7pjFocSS
         TQAST/KPYuCDPGYTmFRXaJbnXYZ7CLeAwBnTCL1irL8YTL+7pPzVqT4t5Srl5QtOnK9R
         fyhyHFu7pmHzLq7eUhESXu5N88IaFh9VOF1AfVUmQ9waNF38I/Lne4mUwBs4lKQswV9j
         oloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFGWv6X8z3NwFialNaeSsACmFB5fqtUuW9oC4mugWj4=;
        b=Qq6S6wv00RLXrx01SWbcITzuyM77LYoi/WpdxZEwOdt4rg4PvgtvqSOiVUZyeKYJow
         SF871x6+7bYENiPaL7ubL/m+W79E5VqiXik5zzCiaxNRb6/nUbsfnrckoFhGpWZS+EEa
         A+GIyGCguTAjwwWYLDLUrCi39fpq1dLP7HGyCyQjhvDRixEFNMuu5qVEUi8sohW7eDGM
         M7SBVeWupRNL8KAQXCC6JCnPWqaT7DhM81gWcdK1QkyjM5JOmJc5j5K0HRSFFPsNkbDT
         /2En4mndnRIDZKJEMTJPgOoSC8YKMr0vUuO7Uc9f9oyuvefJtDrCdNwHRe6ph5wQ2unW
         0uhQ==
X-Gm-Message-State: AA+aEWZYWcbELUu009POjMpnLCCJiOoTnK3JROq++lsDQxItKPoqSEML
        XmLgQgcVdsiT8NPnM8MXDZ1+f0V6aBhswqKigSCluA==
X-Google-Smtp-Source: AFSGD/Vt9bgOssRGjNM9g+zQkLmLmYp5ME/owlqbM1CoOLLX7DTPeAXAfe9QJ6+u0RyB5DzFmI7RL5z9zjuXz+1kFIg=
X-Received: by 2002:a1c:6442:: with SMTP id y63mr1042938wmb.143.1545096166849;
 Mon, 17 Dec 2018 17:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20181214171508.7791-1-surenb@google.com> <20181214171508.7791-7-surenb@google.com>
 <20181217162713.GE2218@hirez.programming.kicks-ass.net>
In-Reply-To: <20181217162713.GE2218@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 Dec 2018 17:22:35 -0800
Message-ID: <CAJuCfpFp7v4oc9LL0TVMiYavOMOvDs5y=kQ8S7URtKojkWmH7Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] psi: introduce psi monitor
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        dennis@kernel.org, Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 8:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Dec 14, 2018 at 09:15:08AM -0800, Suren Baghdasaryan wrote:
> > @@ -358,28 +526,23 @@ static void psi_update_work(struct work_struct *work)
> >  {
> >       struct delayed_work *dwork;
> >       struct psi_group *group;
> > +     u64 next_update;
> >
> >       dwork = to_delayed_work(work);
> >       group = container_of(dwork, struct psi_group, clock_work);
> >
> >       /*
> > +      * Periodically fold the per-cpu times and feed samples
> > +      * into the running averages.
> >        */
> >
> > +     psi_update(group);
> >
> > +     /* Calculate closest update time */
> > +     next_update = min(group->polling_next_update,
> > +                             group->avg_next_update);
> > +     schedule_delayed_work(dwork, min(PSI_FREQ,
> > +             nsecs_to_jiffies(next_update - sched_clock()) + 1));
>
> See, so I don't at _all_ like how there is no idle option..

Copy that. Will see what we can do to bring it back.
Thanks!

> >  }
>
>
> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
