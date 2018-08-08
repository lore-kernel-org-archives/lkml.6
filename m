Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C633C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE76221721
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeMhzx1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE76221721
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeHHH57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:57:59 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38353 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHHH57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:57:59 -0400
Received: by mail-ua0-f193.google.com with SMTP id o11-v6so1096621uak.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 22:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fuFGJTwobW7U1ZIvZwW5qIhH/Zcagoxv4fUF36W0zoY=;
        b=OeMhzx1g1sdD25Q6h81BFqBrLjyq7G6wbupgXrJY2GLbR3BoKpNml7GRQ5FaL00Ka6
         MjeRAc3uS+TowYhggnpgzou/Z4cIztOYBkdIayIy6iGp/CC4bLgZtJrnio64trUu3C1x
         S/DkKRXSiNJ/j87HInJUnuXJjmtg7rmXk+JTD+qlv9ZMMTfIyTDqu9H52w9idNWy3a9z
         8+YYsoqWbnB06UEmwDZ0qfhLx/0Mpv+iCHExyM08TCqRKDT6mq4VLnT9fyzd+DA7Y7Kl
         ub3RWHFgvMJNU+0WBAZTvs2TxeS3fViNsubh8YGdtLU3EplGXo8d9DMBltXB28Dqjeuq
         4C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuFGJTwobW7U1ZIvZwW5qIhH/Zcagoxv4fUF36W0zoY=;
        b=rqcxURN24fGCgQ55nqkHCQYsNKYzDvHBP+TEd3UEOyf/J8PtZNCWygPiCAhL4+4UHd
         oFND6vlBkOsw1HV88RuqnJ5CEah0QmF7am4TRX7y8qoCrMF7nY/JRxXQS5oaccHYI1Pf
         HbLBsszPSK4j/da5yjTK4deZutfe+7MFPAiaUTbgSDRMGJG+RfYSJ/RV7F4aIgPhH21J
         kA/7McPsn5b/NvsaLpIrw2/u6sIrFovZ9TOwpzxK+8Uicu6rqaKsyAOU0m+raH4Agelb
         YSsvtvREJKH7EjA1KMAzTqTlS4IKuPu4pnROUFUe6yAzCrpHi4qHEutz94QDX7nJSWLW
         ISOg==
X-Gm-Message-State: AOUpUlGFPsWM4SkoL+XOTBuNHircD0IL3EnRLeSBajXJraAtFp6jZ99/
        /fPCoXP1KgXwSajZMUsKhY4VnAfTV5dl5CB3yLME5w==
X-Google-Smtp-Source: AA+uWPwdP0jii0prPdFH+BcZLuoid/ztOSG5YoRRJKa1h4wXJhwWhD0CVquVoiHUZddwZzQUctgRH+KvAxo8D2cQjuc=
X-Received: by 2002:a9f:3ed9:: with SMTP id n25-v6mr934291uaj.25.1533706802317;
 Tue, 07 Aug 2018 22:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <20180808111224.52a451d9@canb.auug.org.au>
In-Reply-To: <20180808111224.52a451d9@canb.auug.org.au>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 7 Aug 2018 22:39:50 -0700
Message-ID: <CALvZod4CAA50sPB1V9bZVOZ__rOT=Ys8tLv+m-S-kP3NLubSqQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] Introduce lockless shrink_slab()
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        josh@joshtriplett.org, Steven Rostedt <rostedt@goodmis.org>,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Hugh Dickins <hughd@google.com>, shuah@kernel.org,
        robh@kernel.org, ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>, jbacik@fb.com,
        Ingo Molnar <mingo@kernel.org>, mhiramat@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 6:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Kirill,
>
> On Tue, 07 Aug 2018 18:37:19 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >
> > After bitmaps of not-empty memcg shrinkers were implemented
> > (see "[PATCH v9 00/17] Improve shrink_slab() scalability..."
> > series, which is already in mm tree), all the evil in perf
> > trace has moved from shrink_slab() to down_read_trylock().
> > As reported by Shakeel Butt:
> >
> >      > I created 255 memcgs, 255 ext4 mounts and made each memcg create a
> >      > file containing few KiBs on corresponding mount. Then in a separate
> >      > memcg of 200 MiB limit ran a fork-bomb.
> >      >
> >      > I ran the "perf record -ag -- sleep 60" and below are the results:
> >      > +  47.49%            fb.sh  [kernel.kallsyms]    [k] down_read_trylock
> >      > +  30.72%            fb.sh  [kernel.kallsyms]    [k] up_read
> >      > +   9.51%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
> >      > +   1.69%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
> >      > +   1.35%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_protected
> >      > +   1.05%            fb.sh  [kernel.kallsyms]    [k] queued_spin_lock_slowpath
> >      > +   0.85%            fb.sh  [kernel.kallsyms]    [k] _raw_spin_lock
> >      > +   0.78%            fb.sh  [kernel.kallsyms]    [k] lruvec_lru_size
> >      > +   0.57%            fb.sh  [kernel.kallsyms]    [k] shrink_node
> >      > +   0.54%            fb.sh  [kernel.kallsyms]    [k] queue_work_on
> >      > +   0.46%            fb.sh  [kernel.kallsyms]    [k] shrink_slab_memcg
> >
> > The patchset continues to improve shrink_slab() scalability and makes
> > it lockless completely. Here are several steps for that:
>
> So do you have any numbers for after theses changes?
>

I will do the same experiment as before with these patches sometime
this or next week.

BTW Kirill, thanks for pushing this.

regards,
Shakeel
