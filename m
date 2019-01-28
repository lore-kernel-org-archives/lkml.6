Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75431C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E7C2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2Nu9OJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfA1P7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:59:50 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46988 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbfA1P7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:59:46 -0500
Received: by mail-yw1-f65.google.com with SMTP id t13so6885875ywe.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yG+IPoHDMDTax/O7ZuXb5W3f6MupuLya0ZnIkWYX/6w=;
        b=Y2Nu9OJQzhF0nbbJyWful5kNWyBwddZ1f1VkAn29tp8WPoA3LQEpNLrXI0kn9uVKgy
         OlGZ5zSDZ626uxv8mP78Rj7AY2v4WkaCfuHsdJlBn+xXi/4FgKXoDRlJQ+mYBvaUcEBs
         /SM7LUD6MvsgbB1WryhJ8dhabqGvs4Z7Y6u8y+ALxnGe8PYsUrAJJ5Y/szN5wT1FRpNF
         mB6Q3M2uWHzBMJQYukDpHZlc+LY9Usy04PZ+TuJ6YRjmujaKDcTm2vvts6QrF8UMvKSD
         nwJH1risZ+AEEBgV+6YVoz9pRI6Oquh247133FVA/eaZMzmKJy+IaVYXqtOvdwRjrchm
         ysOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yG+IPoHDMDTax/O7ZuXb5W3f6MupuLya0ZnIkWYX/6w=;
        b=Ig7Rxo0x7XCO7P6JhVqoquyn4zRx/7TYqf3KYE296Jd1UVIFu/fbKCep7u/glvBAw9
         mDM6jP9PZLpVgBslqOWAo4eud6p2jGUjsrGjY8DfjJL/vjLzVCFY3iLGl5TiGbfNPtxN
         FZpwU9aay+OVRAPYqPsKwDiBhiW7dftG4XBeAvLF1QX4RYnCk5MDY210t7rEA12vGk0e
         LKHQnah2yxQjdfAfB7OvowrMG4e6sX9ocQcRpt/FgEKmZW3eruyclmWJIK9C1nds4SaT
         cbuAu/S398G5YEYaFg9I8jXumd4hCdqJuOeDO+nLM52UmrgpcCqnzM9ZzM2n//AO38uc
         folw==
X-Gm-Message-State: AJcUukfRJmuxuS2y3W21YYjLuh+4MkVQuPETu68hBDDa1BXbI/eC0Kpv
        JOKYl0KeowyHpKNS/7mgeuPXwzN6Km8p8ToUu9D65A==
X-Google-Smtp-Source: ALg8bN7fCDdqmT/Poi2kifvBPpqajT1d4G+DhyRvU7E2FrC8gKAWDBqOykP3e9SscAD5+1zazZ4ERAHo037J/PrOYpg=
X-Received: by 2002:a81:ee07:: with SMTP id l7mr21402528ywm.489.1548691184840;
 Mon, 28 Jan 2019 07:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20190123223144.GA10798@chrisdown.name> <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org> <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org> <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com> <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
In-Reply-To: <20190125182808.GL50184@devbig004.ftw2.facebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 28 Jan 2019 07:59:33 -0800
Message-ID: <CALvZod6LFY+FYfBcAX0kLxV5KKB1-TX2cU5EDyyyjvHOtuWWbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Fri, Jan 25, 2019 at 10:28 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Michal.
>
> On Fri, Jan 25, 2019 at 06:37:13PM +0100, Michal Hocko wrote:
> > > What if a user wants to monitor any ooms in the subtree tho, which is
> > > a valid use case?
> >
> > How is that information useful without know which memcg the oom applies
> > to?
>
> For example, a workload manager watching over a subtree for a job with
> nested memory limits set by the job itself.  It wants to take action
> (reporting and possibly other remediative actions) when something goes
> wrong in the delegated subtree but isn't involved in how the subtree
> is configured inside.
>

Why not make this configurable at the delegation boundary? As you
mentioned, there are jobs who want centralized workload manager to
watch over their subtrees while there can be jobs which want to
monitor their subtree themselves. For example I can have a job which
know how to act when one of the children cgroup goes OOM. However if
the root of that job goes OOM then the centralized workload manager
should do something about it. With this change, how to implement this
scenario? How will the central manager differentiates between that a
subtree of a job goes OOM or the root of that job? I guess from the
discussion it seems like the centralized manager has to traverse that
job's subtree to find the source of OOM.

Why can't we let the implementation of centralized manager easier by
allowing to configure the propagation of these notifications across
delegation boundary.

thanks,
Shakeel
