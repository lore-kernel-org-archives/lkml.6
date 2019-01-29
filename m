Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4064FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1394921873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTMYdsjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfA2SFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:05:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40112 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfA2SFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:05:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so18752289wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+ap6Bq9i9Bosxjv/aC11VsPIK0N0Zh2bt/qMaK7RFo=;
        b=pTMYdsjVGlPjGB46EzZOJP2ZzDqCQrAqtMKteb4meGoxCxhdPbKwQR1sea+cC+6KTW
         G+seq4FJVEvK5CRhVUtH84btkAFM7Xc4jxG+SDLF8sUlDknTuC2WFvELFSNqQRh3hYCG
         CvcEgmI2ubiEKT3037EZFz8oCFJ9h2vrXZeY/DN5KatkMVTeIUt85CojWalyztZWPCu9
         5UNFCramOZsutLuabzLGoYyV22vjYFlPJrv+sIbEz+foWtJ/T43QYM6ELa5elREGVVhI
         DNszJWv4OwXbAtfHWrgmqegPvT7xs193W6REmvUd1rwEKb5NxMrkXxmOSbFn7DV+Sf2Z
         wrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+ap6Bq9i9Bosxjv/aC11VsPIK0N0Zh2bt/qMaK7RFo=;
        b=BWgnLCMy94qb5DcZVM1kqxjZqTNk1kxCb7f7OaqIwanXRuWmni9BviP5PNs8662dpV
         u58oLNW6CsHe0FOY4zNTI5CPQItfNu5tu5in9zNSdsqs+aoYSwEbBtRhq9+dnCESHvcl
         Umzxkz/Ke+owuoK1BT/HnIDiyopnS5lV7S1MS9VwF2b9TOQZxaf4injG2ZloPaVkxui9
         PPwH3GPafQCsLiaBKuUqmbAUmV4gP2PnpB+h3f7UTbtW0bBWDDUh601PA3QcZFD+YRfa
         ZWiLq6I1qZONmC7V6OvNOVobtXB7n+abHo7kRiutCiwtbLM++8i2AxbXKJ+pVgymVVr4
         CbrA==
X-Gm-Message-State: AJcUukf5KKybc6Mh8UHf8uSdqa5wxWLnpHYMNXbHxRNRbDlZwmXVxd1y
        z6MtD9GQEqoOGGKBCNIE5rVJGIJHMkvJK6bT8C4ynQ==
X-Google-Smtp-Source: ALg8bN7LYSdl+dRdBBbTvxW1GBHoyD6o/TBUVTnGWPtKZpAzgWSqhyM1ZtFKfRYRVtnOYo2pX0CGBDOWEMoPtBdoZiE=
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr20579255wmc.133.1548785118461;
 Tue, 29 Jan 2019 10:05:18 -0800 (PST)
MIME-Version: 1.0
References: <20190124211518.244221-1-surenb@google.com> <20190124211518.244221-6-surenb@google.com>
 <20190129104431.GJ28467@hirez.programming.kicks-ass.net>
In-Reply-To: <20190129104431.GJ28467@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 29 Jan 2019 10:05:07 -0800
Message-ID: <CAJuCfpH3k0rrZZw_HhrjXYuFX31p283qg_5vQEnyd_wAMaxbqA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] psi: introduce psi monitor
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

Thanks for review Peter!

On Tue, Jan 29, 2019 at 2:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 24, 2019 at 01:15:18PM -0800, Suren Baghdasaryan wrote:
> >  static void psi_update_work(struct work_struct *work)
> >  {
> >       struct delayed_work *dwork;
> >       struct psi_group *group;
> > +     bool first_pass = true;
> > +     u64 next_update;
> > +     u32 change_mask;
> > +     int polling;
> >       bool nonidle;
> > +     u64 now;
> >
> >       dwork = to_delayed_work(work);
> >       group = container_of(dwork, struct psi_group, clock_work);
> >
> > +     now = sched_clock();
> > +
> > +     mutex_lock(&group->update_lock);
>
> actually acquiring a mutex can take a fairly long while; would it not
> make more sense to take the @now timestanp _after_ it, instead of
> before?

Yes, that makes sense. As long as *now* is set before the *retry*
label, otherwise the retry mechanism would get even more complicated
to understand with floating *now* timestamp. Will move the assignment
right after the mutex_lock()

> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
