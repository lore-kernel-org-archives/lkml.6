Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA18C31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9995320880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ovavreme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfAUHOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:14:03 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33208 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfAUHOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:14:02 -0500
Received: by mail-yw1-f68.google.com with SMTP id p65so7690585ywe.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyipLOZTSIwpZWsR1TcE0z4tQjeXZYKEV1wzcg4NrdU=;
        b=Ovavreme06i/tytbU8X7EJC4RV8sMcflD5xhosuyrSWqXc5eM8szEctbmKg9M8LNKO
         aGWQ/xCrNFp00v4VVDGlrSp5ZJdOv6vieT/xlAUKbKPx2yN1vNDJ4iIxj5U936gukCoY
         U9GgQD2k1/pm7VBpzCy0Pe2TCP+E8h22TCV01Fy/em6ASXf5FXqEWUh1YfPaHys/CMq1
         RGaGlIbSDi2TTl6ckosGRJIH3lHT83h1ZzX5z67li1hUGBhnx+A3/slKkvkMPZnCGMg+
         UfjYti0gPSaUYxN1VhlPkjC4XW9A36VerlF7d4Tk9cGFLaTLRlwo8tOika7BfzZhp5MZ
         WT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyipLOZTSIwpZWsR1TcE0z4tQjeXZYKEV1wzcg4NrdU=;
        b=kRclXEFQt7hwirZQy5w8xRU5UtC01VCszzPUKk7KcTgcOlQbINQgIkn5XTfUXYqAWP
         PYPwIsVgvw04u2oOIxpjBb4uxjT5PWragMz7FRJcvDPNnWyKQWhslB2ibrQK7XTO8Mh/
         29UR9JIkJYB2Z4H/YZ8K08J8rSBn3ndrni77WU5cAe6KU5J4M/3OHuMFcfji//LfMN3Q
         2vZPpt0pe2jwMdIm4cosMotyCthrb5JZ9iQDKinGBPlK8AVXc4nF9nqp7aAG49rXUhd6
         S9FMr9ZADfwqMm1vAo5PZgfbCNVAlv9Q3PyP+pDTO/+ukJtCQ4yA7EXB7jDm19Un70we
         DPpg==
X-Gm-Message-State: AJcUukc+Lkb/P0LFIfx+nlTT1ij9IYYHgmnZ+Yquk/+nFn/BANNY4DMh
        GRBRxHsUrbQvVvEepq37b1MtO2YodnamPxTPiDQk1WrQ+Lg=
X-Google-Smtp-Source: ALg8bN7duwdDk5JK1h87DBVWJL+DtD+PdtVzIgEpXIJiCrqL5BteFdBGwjM7HQJUFjBIQLleYVSCz88/LiMRLWbUtB4=
X-Received: by 2002:a81:60c4:: with SMTP id u187mr25686411ywb.345.1548015796908;
 Sun, 20 Jan 2019 12:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20190119005022.61321-1-shakeelb@google.com> <02f74c47-4f35-3d59-f767-268844cb875e@i-love.sakura.ne.jp>
In-Reply-To: <02f74c47-4f35-3d59-f767-268844cb875e@i-love.sakura.ne.jp>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 20 Jan 2019 12:23:06 -0800
Message-ID: <CALvZod4h7ouNE7p2ouTix9uK3XLUvP6UYNDPEkR-y5PZRJRDnw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm, oom: fix use-after-free in oom_kill_process
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 7:35 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/01/19 9:50, Shakeel Butt wrote:
> > On looking further it seems like the process selected to be oom-killed
> > has exited even before reaching read_lock(&tasklist_lock) in
> > oom_kill_process(). More specifically the tsk->usage is 1 which is due
> > to get_task_struct() in oom_evaluate_task() and the put_task_struct
> > within for_each_thread() frees the tsk and for_each_thread() tries to
> > access the tsk. The easiest fix is to do get/put across the
> > for_each_thread() on the selected task.
>
> Good catch. p->usage can become 1 while printk()ing a lot at dump_header().
>
> > @@ -981,6 +981,13 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
> >        * still freeing memory.
> >        */
> >       read_lock(&tasklist_lock);
> > +
> > +     /*
> > +      * The task 'p' might have already exited before reaching here. The
> > +      * put_task_struct() will free task_struct 'p' while the loop still try
> > +      * to access the field of 'p', so, get an extra reference.
> > +      */
> > +     get_task_struct(p);
> >       for_each_thread(p, t) {
> >               list_for_each_entry(child, &t->children, sibling) {
> >                       unsigned int child_points;
> > @@ -1000,6 +1007,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
> >                       }
> >               }
> >       }
> > +     put_task_struct(p);
>
> Moving put_task_struct(p) to after read_unlock(&tasklist_lock) will reduce
> latency of a write_lock(&tasklist_lock) waiter.
>
> >       read_unlock(&tasklist_lock);
> >
> >       /*
> >
>
> By the way, p->usage is already 1 implies that p->mm == NULL due to already
> completed exit_mm(p). Then, process_shares_mm(child, p->mm) might fail to
> return true for some of children. Not critical but might lead to unnecessary
> oom_badness() calls for child selection. Maybe we want to use same logic
> __oom_kill_process() uses (i.e. bail out if find_task_lock_mm(p) failed)?

Thanks for the review. I am thinking of removing the whole children
selection heuristic for now.

Shakeel
