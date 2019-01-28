Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B91BC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49402171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548716360;
	bh=koVSDUKtLDXHb+0bjzz/2+sTodPZKFu/W9UG13MdJoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JF+QI/BdgfbSl1q87IEtqN7axSroaWh112A2mDJS+1DgFEgCBT6hOi1ijxWym9R35
	 CwJbtiMrqxZNTF96xitoOrerOqfWuZH+rxeMuLtc7+f87RauJrZTCBJo23IEPydQM8
	 q319qovki5zWMfw3eSxncVoCmKuekF8AKvUgfxLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfA1W7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:59:18 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34717 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfA1W7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:59:17 -0500
Received: by mail-yw1-f65.google.com with SMTP id g75so7480202ywb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 14:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hIJpW7GMeiE3B4vNTAQ6Z5XtbYmf6DLwmTjd/UWH4Co=;
        b=XTIuEQhyPp+8X6R6TmA5450pqAEouS8UnzVO66rN8NF0wnKp/KW5pDk0RvzQkSkEmx
         w0lbDx1jMG+qUVex8CiwMXOkOPoI9VFKwDqDTv9UNLB7MM33VCO8HZFTZnPOO9d0ZtSa
         4Qtn+33zAXUiZlO+Srqxe4yPb/JEcuMF4Cf2cNlA9XK4bPZaIR8lyoz9l8lVpZPEUqOe
         L8wqvTKazZKa13wyywqRhhjk0N4FQLRqL1HMzKtgh+gSvTwsIA3xospexgn0+MSQCNIk
         9KcEb9eOud2IVukq1qYeEDJUMcCkGldhiUx8ayoE/NBjNm/2zK7vPdigmdQYFcV9dBR4
         xlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hIJpW7GMeiE3B4vNTAQ6Z5XtbYmf6DLwmTjd/UWH4Co=;
        b=FVO7+SSYBL2KazZLXYbPKnQb+1RvfN6BRNDdqG4gFsXCZJLJ/a9+eRvfA+aEouXa7n
         B4V5z6Be8EsTixBKFdQpCJSyH3iu+jTy23noUeTvl44yw6RtxxuUlir/2107NihRaJ2U
         YGyCQ2EN31B/DEFxNQFgsUpNzNsZkxdRH+VAqzpfMADXN/W4KkMONk1tl/9d4yt8/sca
         Hde+o2BtlzOzdoI58iwBwPdS+NCmwpUy1Q/Sqm671OLWWOOkSf7Tr1YXXLcdBSiVxxcm
         hlop6XsSTkC+STdX9Lqu/4b0ANhl+cyssRmKmwG5q4L1Ok2WbX7y4HZ70xCi08Avpel+
         8giQ==
X-Gm-Message-State: AJcUukdxm25rUdeypbc3xCYC4zblb74p3/tGcQR0mVmgG/S5oHiWhHtE
        3ZGjBBXVnMONgIjluZWjWDc=
X-Google-Smtp-Source: ALg8bN6DMm3zHygJtTEUx5P1qey1HbfhieULGAOMiAdyvNlcc3qUnBWb8fTgvrIwoorCY1nJXfyGPw==
X-Received: by 2002:a81:3594:: with SMTP id c142mr23621854ywa.234.1548716356317;
        Mon, 28 Jan 2019 14:59:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:31a1])
        by smtp.gmail.com with ESMTPSA id s185sm26391177yws.69.2019.01.28.14.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 14:59:15 -0800 (PST)
Date:   Mon, 28 Jan 2019 14:59:12 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: fix aggregation idle shut-off
Message-ID: <20190128225912.GV50184@devbig004.ftw2.facebook.com>
References: <20190116193501.1910-1-hannes@cmpxchg.org>
 <20190128140336.25854cb97c25924f4bfc26c7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128140336.25854cb97c25924f4bfc26c7@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew.

On Mon, Jan 28, 2019 at 02:03:36PM -0800, Andrew Morton wrote:
> > +#include "../workqueue_internal.h"
> 
> "Only to be included by workqueue and core kernel subsystems"
> 
> I'm not sure that psi qualifies.  Perhaps wq_worker_last_func() should
> be declared in include/linux/workqueue.h.
>
> And perhaps implemented there as well.  It's similar to
> current_wq_worker(), which is inlined and wq_worker_last_func() is
> small enough to justify inlining.

workqueue_internal.h is used mostly to expose some of the internal
details and hooks to scheduler code for concurrency management.  Most
of PSI is tracking state transitions on scheduling events (psi.c is
under kernel/sched/ for this reason), so it's mostly in line with how
the file was being used.

I think keeping it in workqueue_internal.h is better.  Please see
below.

> > +work_func_t wq_worker_last_func(struct task_struct *task)
> > +{
> > +	struct worker *worker = kthread_data(task);
> > +
> > +	return worker->last_func;
> > +}
> 
> The semantics are troublesome.  What guarantees that worker->last_func
> won't change under the caller's feet?  The caller should hold some lock
> (presumably worker->pool->lock) in order to stabilize the
> wq_worker_last_func() return value?
> 
> Also, the comment isn't really true - this is called from PSI, which is
> hardly "the scheduler"?

Hmm... This is the same way wq_worker_waking_up() and
wq_worker_sleeping() are synchronized.  The task being queried is
being scheduled in or out, so it can't change underneath and is in
line with other stuff in kernel_internal.h.

Thanks.

-- 
tejun
