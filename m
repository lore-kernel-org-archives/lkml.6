Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C20DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A44F214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2Egdtpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeLRBKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:10:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45888 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeLRBKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:10:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so14003716wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 17:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWqTg7e7BySNj9lmjGI7lNLIjnRegZYKQ+my+yKGfqs=;
        b=S2EgdtpyJLHPh2GZK2JRSXX2DuPbm4Qa8TB+iKtlgxbHhbVIJOfJR+VQ7xFKBBziQr
         vjjazB7I+4dLyyswD3fy+9bSCL5llq+20jnJ1Qa7oFlnhTP/3HGph75JlcvgwZ7+6IZJ
         1s/b3UYNLpenPmORnuzkDmSfiuRODv7l0zt7vQT1ed9PGwj7X3zvF/aIiyvh119ZkM6R
         WbFTiU56mQLwJRANDgm+/i22iIe8nwVZrsGkDAjFlBYL4utfVJnfyQDkHG6lWx5x+CqR
         eK2RWXHiY7x5TpCWK/8chwBirg0TbkUQLBdgJeUedmLxWEbLlEjOvZGBzF/32lZcWE9P
         gE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWqTg7e7BySNj9lmjGI7lNLIjnRegZYKQ+my+yKGfqs=;
        b=OPuJVS7PWWSPtJO+/Yui1s/UF8j0/FdUJ9f/Lh+nLFhG5FbaTysNGwtZ1oJOnlDsUy
         EtsIZydeeJcEEJxXyJjYxmAl+Ax5xkKUv4KkfvW8E7/TL+ylXDAFG+wxmNoGPdR+YxN1
         npPkB2BBobpN9xcFdYYSlKKVC3flykhpPp0CZr21POZTTI1egs9Z8yK0aNZJIzHV/kT9
         LFq2FIqH1VkyLevMqsXYPmSuHyEBfb0aYHP4e2e4ko++yiXDqgUlzVKtWJXcz3A9awqZ
         14iJJNJipoL5bPuOGs3zaHiW+Hkb5n1tsalz3tixIotswz/QYITAmYhupnwqXP69KyqD
         3k1g==
X-Gm-Message-State: AA+aEWYD4Cb0a7aafx1zMGU23C4SL9ZiXaCXpr/+6NSR48CG7om4xORX
        NFPObVCflKeA9Wdh1SDX9VtJwMiJCbVtMFNx1WuQsQ==
X-Google-Smtp-Source: AFSGD/VT3pIKnE0DRGrrGHZB2VCknrdKnps22jRzBKpnof5dKPwDOO5H1ALImO4mKVuYTU16c6KEhrrTFmNFlhUiHbk=
X-Received: by 2002:adf:ee07:: with SMTP id y7mr13108042wrn.187.1545095412728;
 Mon, 17 Dec 2018 17:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20181214171508.7791-1-surenb@google.com> <20181214171508.7791-4-surenb@google.com>
 <20181217145754.GB2218@hirez.programming.kicks-ass.net>
In-Reply-To: <20181217145754.GB2218@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 Dec 2018 17:10:01 -0800
Message-ID: <CAJuCfpFtqd=RDDW_U5HFXuAZzNh6F+Enrjz3P4jZg=hvyH9RwQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] psi: eliminate lazy clock mode
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

On Mon, Dec 17, 2018 at 6:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Dec 14, 2018 at 09:15:05AM -0800, Suren Baghdasaryan wrote:
> > Eliminate the idle mode and keep the worker doing 2s update intervals
> > at all times.
>
> That sounds like a bad deal.. esp. so for battery powered devices like
> say Andoird.
>
> In general the push has been to always idle everything, see NOHZ and
> NOHZ_FULL and all the work that's being put into getting rid of any and
> all period work.

Thanks for the feedback Peter! The removal of idle mode is unfortunate
but so far we could not find an elegant solution to handle 3 states
(IDLE / REGULAR / POLLING) without additional synchronization inside
the hotpath. The issue, as I remember it, was that while scheduling a
regular update inside psi_group_change() (IDLE to REGULAR transition)
we might override an earlier update being scheduled inside
psi_update_work(). I think we can solve that by using
mod_delayed_work_on() inside psi_update_work() but I might be missing
some other race. I'll discuss this again with Johannes and see if we
can synchronize all states using only atomic operations on clock_mode.

> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
