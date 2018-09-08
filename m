Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104D2C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ED220844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="M/TXEt6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ED220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbeIHSnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:43:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35271 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeIHSnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:43:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id f62-v6so9752618qke.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 06:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tNhc0/JjyRNrzIYdBdnJuEx9d95qC9QN8zWJmY7pBCA=;
        b=M/TXEt6DmRh2mNy/+4inFNWdGuwJsnPoU0QijOE4I2QuT2qLaLIIWVgUU8qBJJm8lG
         MHwEzBUsxJq9J0VsJEszshI3mxBxWig4dMN6oE4FYwppyD2xVOWTqJHYL5h4Qh/vL8bQ
         IMLA9MWp0iVOlDrXVvKlzgIbOEQI0xa15WGWmewEGv4+C7thZI8G1dKBhofmC2fCbeTk
         cGlde/I91VnnrFMBZcCPZebSHl6P7snwXaxLe6ymPUBPL8qscpZQmwIaJgEExgP0oZND
         QEl9vbfREnG2W1SvKzmbjUbXaOYz7HlZfY+EXjJLjH2lU0IanjJvS+YLgbWj4iOCB6Z1
         Moqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tNhc0/JjyRNrzIYdBdnJuEx9d95qC9QN8zWJmY7pBCA=;
        b=YjYiljODKu4SGvK7fWP0EKP47NV9W0/t/xB1UnKYw+a9QCOg51UT6KyxFoKlth2TzC
         y0inwEvnPQm49pMPZgbBtXc2Ac6jbs8Ezf6bHdn3tLO3Ma4wmEdnDlxMPBXDMiDYQSWJ
         vDIU2QY2G6GpI79WfyO5mvSJG0gZA5SgzvW2Azok89o5rPo0idlvlP1KzVYsdm+DdAhV
         uStp4JdRrnTFW98SyhxtAf7hn6So3jaRn4jsgtTKc6QXSJA/CB17/Vwxyz9vEMI8DIym
         kRXoRbFyqLpsdu+ABuoyYFv667ZSe8SZ7JF+2rvDmvJOlAgofEixXyB4FjuC6O55+Lpx
         e0Sw==
X-Gm-Message-State: APzg51Czh3NeX3x3EFOP/bQhh5dv/sfSKl/hQ+pP2W6VMMrXzUTfmzr1
        2pEV2tKSIu8XCWmIQuPjdMCQRA==
X-Google-Smtp-Source: ANB0VdYpr8RBhjUhrnIk3Cv/UuusGl+S7MJ67MU+nnA+6YJgP4BR2aZie++qCIYfMjpV/NNPYdiIFw==
X-Received: by 2002:a37:cc59:: with SMTP id r86-v6mr9497677qki.272.1536415050991;
        Sat, 08 Sep 2018 06:57:30 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id h132-v6sm1420005qke.51.2018.09.08.06.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 06:57:29 -0700 (PDT)
Date:   Sat, 8 Sep 2018 09:57:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: print proper OOM header when no eligible
 victim left
Message-ID: <20180908135728.GA17637@cmpxchg.org>
References: <20180821160406.22578-1-hannes@cmpxchg.org>
 <b94f9964-c785-20c1-34af-e9013770b89a@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94f9964-c785-20c1-34af-e9013770b89a@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 10:36:06PM +0900, Tetsuo Handa wrote:
> On 2018/08/22 1:04, Johannes Weiner wrote:
> > When the memcg OOM killer runs out of killable tasks, it currently
> > prints a WARN with no further OOM context. This has caused some user
> > confusion.
> > 
> > Warnings indicate a kernel problem. In a reported case, however, the
> > situation was triggered by a non-sensical memcg configuration (hard
> > limit set to 0). But without any VM context this wasn't obvious from
> > the report, and it took some back and forth on the mailing list to
> > identify what is actually a trivial issue.
> > 
> > Handle this OOM condition like we handle it in the global OOM killer:
> > dump the full OOM context and tell the user we ran out of tasks.
> > 
> > This way the user can identify misconfigurations easily by themselves
> > and rectify the problem - without having to go through the hassle of
> > running into an obscure but unsettling warning, finding the
> > appropriate kernel mailing list and waiting for a kernel developer to
> > remote-analyze that the memcg configuration caused this.
> > 
> > If users cannot make sense of why the OOM killer was triggered or why
> > it failed, they will still report it to the mailing list, we know that
> > from experience. So in case there is an actual kernel bug causing
> > this, kernel developers will very likely hear about it.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/memcontrol.c |  2 --
> >  mm/oom_kill.c   | 13 ++++++++++---
> >  2 files changed, 10 insertions(+), 5 deletions(-)
> > 
> 
> Now that above patch went to 4.19-rc3, please apply below one.
> 
> From eb2bff2ed308da04785bcf541dd3f748286bfa23 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 8 Sep 2018 22:26:28 +0900
> Subject: [PATCH] mm, oom: Don't emit noises for failed SysRq-f.
> 
> Due to commit d75da004c708c9fc ("oom: improve oom disable handling") and
> commit 3100dab2aa09dc6e ("mm: memcontrol: print proper OOM header when
> no eligible victim left"), all
> 
>   kworker/0:1 invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=-1, oom_score_adj=0
>   (...snipped...)
>   Out of memory and no killable processes...
>   OOM request ignored. No task eligible
> 
> lines are printed.

This doesn't explain the context, what you were trying to do here, and
what you expected to happen. Plus, you (...snipped...) the important
part to understand why it failed in the first place.

> Let's not emit "invoked oom-killer" lines when SysRq-f failed.

I disagree. If the user asked for an OOM kill, it makes perfect sense
to dump the memory context and the outcome of the operation - even if
the outcome is "I didn't find anything to kill". I'd argue that the
failure case *in particular* is where I want to know about and have
all the information that could help me understand why it failed.

So NAK on the inferred patch premise, but please include way more
rationale, reproduction scenario etc. in future patches. It's not at
all clear *why* you think it should work the way you propose here.
