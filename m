Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96302C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F5F2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hYNIx/+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfBLDVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:21:32 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44021 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBLDVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 22:21:32 -0500
Received: by mail-wr1-f47.google.com with SMTP id r2so994862wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 19:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hLXs27rPVddlIN2Y+VY1rZ6x4qsTrdDdtBkRfaDycQ8=;
        b=hYNIx/+fk/bGYAS2+WwLqvKoiPxJutjp2NNdAaH4IO5Xft3SQgLmo0/0W+iOst95ce
         NN6FRvJppnNOMFp8cVcbTseaUPEeAKgKGFlZI2Ff2Vq2o/hIj0tRcEnsZQ2xW7epHxKo
         c6adUEh13UoF2lC9nQ7e2Y18JYHddeupS/B/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hLXs27rPVddlIN2Y+VY1rZ6x4qsTrdDdtBkRfaDycQ8=;
        b=gBk8kzEru4FN3/KTTI0GJEwrkj5iFb1/bOEsVvWCfIr462gfgoeZg/BhVFZokYGeEG
         9ljN+/VeyeIt5eexZAK6CevFpj4RS46vqx0ynQCFdvImRdAWo8mHxxDzcjzakI/BtKrd
         QdhYAnSPU7Jaf7VZPsuMJRNkGeiiyhtimT9SZSkbpUUjQkyrxyBDIK/Be2AqUHWkZbid
         kfv7ttj86czJQv88hMpzbJkw8fSDZy29JsTLLawj0UnxilJNPfOfspkgG4HR4epyK9AI
         NGJM00A/THaiI7a1qUDwQExYO4UB+f96NH/axCYVlnklKSKK+RZvdA+yZ08g8can3Rla
         7gHw==
X-Gm-Message-State: AHQUAuZ8+gvws7CXov8Ek2WdAYiqkLxaOaH9nANVSTZD/P5oSQD8pyeu
        Ayyvx0qOJuz4NMmhIkGos/T8hw==
X-Google-Smtp-Source: AHgI3IYQlZs1R9XBHjuFplPiz6hJrtSGlTv38M2J/qPbf6gBkDJIx5iGwneN1TqZFFM3tfFYBQ9npA==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr1027963wrt.241.1549941689950;
        Mon, 11 Feb 2019 19:21:29 -0800 (PST)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id k126sm2200699wme.27.2019.02.11.19.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 19:21:29 -0800 (PST)
Date:   Tue, 12 Feb 2019 04:21:21 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some swap
 operations
Message-ID: <20190212032121.GA2723@andrea>
References: <20190211083846.18888-1-ying.huang@intel.com>
 <20190211190646.j6pdxqirc56inbbe@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211190646.j6pdxqirc56inbbe@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	if (!si)
> > +		goto bad_nofile;
> > +
> > +	preempt_disable();
> > +	if (!(si->flags & SWP_VALID))
> > +		goto unlock_out;
> 
> After Hugh alluded to barriers, it seems the read of SWP_VALID could be
> reordered with the write in preempt_disable at runtime.  Without smp_mb()
> between the two, couldn't this happen, however unlikely a race it is?
> 
> CPU0                                CPU1
> 
> __swap_duplicate()
>     get_swap_device()
>         // sees SWP_VALID set
>                                    swapoff
>                                        p->flags &= ~SWP_VALID;
>                                        spin_unlock(&p->lock); // pair w/ smp_mb
>                                        ...
>                                        stop_machine(...)
>                                        p->swap_map = NULL;
>         preempt_disable()
>     read NULL p->swap_map


I don't think that that smp_mb() is necessary.  I elaborate:

An important piece of information, I think, that is missing in the
diagram above is the stopper thread which executes the work queued
by stop_machine().  We have two cases to consider, that is,

  1) the stopper is "executed before" the preempt-disable section

	CPU0

	cpu_stopper_thread()
	...
	preempt_disable()
	...
	preempt_enable()

  2) the stopper is "executed after" the preempt-disable section

	CPU0

	preempt_disable()
	...
	preempt_enable()
	...
	cpu_stopper_thread()

Notice that the reads from p->flags and p->swap_map in CPU0 cannot
cross cpu_stopper_thread().  The claim is that CPU0 sees SWP_VALID
unset in (1) and that it sees a non-NULL p->swap_map in (2).

I consider the two cases separately:

  1) CPU1 unsets SPW_VALID, it locks the stopper's lock, and it
     queues the stopper work; CPU0 locks the stopper's lock, it
     dequeues this work, and it reads from p->flags.

     Diagrammatically, we have the following MP-like pattern:

	CPU0				CPU1

	lock(stopper->lock)		p->flags &= ~SPW_VALID
	get @work			lock(stopper->lock)
	unlock(stopper->lock)		add @work
	reads p->flags 			unlock(stopper->lock)

     where CPU0 must see SPW_VALID unset (if CPU0 sees the work
     added by CPU1).

  2) CPU0 reads from p->swap_map, it locks the completion lock,
     and it signals completion; CPU1 locks the completion lock,
     it checks for completion, and it writes to p->swap_map.

     (If CPU0 doesn't signal the completion, or CPU1 doesn't see
     the completion, then CPU1 will have to iterate the read and
     to postpone the control-dependent write to p->swap_map.)

     Diagrammatically, we have the following LB-like pattern:

	CPU0				CPU1

	reads p->swap_map		lock(completion)
	lock(completion)		read completion->done
	completion->done++		unlock(completion)
	unlock(completion)		p->swap_map = NULL

     where CPU0 must see a non-NULL p->swap_map if CPU1 sees the
     completion from CPU0.

Does this make sense?

  Andrea
