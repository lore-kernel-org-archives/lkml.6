Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A2EC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D127720823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFXz6VS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfAUH7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:59:00 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35744 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfAUH65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:58:57 -0500
Received: by mail-yb1-f195.google.com with SMTP id h81so6515073ybg.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEpEYG/0P2v/J4M7joVpRo9Cq+8rhRHs87h/EEaaWhM=;
        b=wFXz6VS4TmhgouhKBWxlxWByBoXZkf2HrzTbE8WN+Dj7vO9iNqt2PlNf79wXHK6K7t
         DqkIk4JyhQKnE6i7KrzX9ckrklJya/+NOLgw6TcbN3fdRLrm5B+opnxsMvyCNI3qESWz
         UasD7zjHsyPwMupwmGDJay/h1cV6OK0mht750/xWv2LLUKRdkwDJcfxBocsHdXWpi4Vx
         RH+dYE8wwc8HwH/iNVsBkP+2C0kdSGi+BA8lOoFFNJL+D+QNBabJ/OP8FMyz9SjTC0ar
         WKpzWQD1y0jIZg6taiGQavg38enlOwwjUjSU5BeCv4Du/5BFak3bl7t3TBnPL6d8fybZ
         qlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEpEYG/0P2v/J4M7joVpRo9Cq+8rhRHs87h/EEaaWhM=;
        b=YdWEvuPXu0Or5DDTSD/gUtWzXweGm63uaH1V64g0/OQ49Bzy1MxFWwsWRghnmolGNJ
         BR3YN0DRxhDCgVjwY7cTuw+ywj4RVkxxY4RMIzjXq2NAwJkvXFQk1u1iZ00s/z4f5Xq3
         oGNK5U8cXrhDS1DAcrWm6NUC1LJBiic0GX64IQl8csKEFNYkcgHbf5niyagcaPmGFPiQ
         bvUtCmBINwblG5F1+Kst24vT3nltLO6WoMTxxVH/N4qVwuH1iF6Q4xHhsSTJQyNLmJXm
         kRnPbF383fdS2Yj26ScHzb7NfOIGkqcARaGJoH3QS78f+GxQ/RXEzmvnR2WKjvp654n9
         +ABQ==
X-Gm-Message-State: AJcUukcxv2SjJEiGl4IlztHncG2sQ+ui4fKtPhVCth0vdTaLfdMiaW0A
        cLa2O8FM+xxJu9XCXkr1vA3LZLayspUyOJdFMqBHDrelnhk=
X-Google-Smtp-Source: ALg8bN4Lc5AT3/6z9ICm7STuaFDqZ6qlHNK6fPVkuyjZ6PjVk+EDgjzdCnz979HSopmOCPxFgAo2eCAoW6/FLGjpCD8=
X-Received: by 2002:a25:5d7:: with SMTP id 206mr14246404ybf.164.1548015668260;
 Sun, 20 Jan 2019 12:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20190119005022.61321-1-shakeelb@google.com> <20190119015843.GB15935@castle.DHCP.thefacebook.com>
In-Reply-To: <20190119015843.GB15935@castle.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 20 Jan 2019 12:20:57 -0800
Message-ID: <CALvZod6zRy69bHoXvEWED28OFZ8u4o8JBAL7nyjKMmUjBb5n4w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm, oom: fix use-after-free in oom_kill_process
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:58 PM Roman Gushchin <guro@fb.com> wrote:
>
> Hi Shakeel!
>
> >
> > On looking further it seems like the process selected to be oom-killed
> > has exited even before reaching read_lock(&tasklist_lock) in
> > oom_kill_process(). More specifically the tsk->usage is 1 which is due
> > to get_task_struct() in oom_evaluate_task() and the put_task_struct
> > within for_each_thread() frees the tsk and for_each_thread() tries to
> > access the tsk. The easiest fix is to do get/put across the
> > for_each_thread() on the selected task.
>
> Please, feel free to add
> Reviewed-by: Roman Gushchin <guro@fb.com>
> for this part.
>

Thanks.

> >
> > Now the next question is should we continue with the oom-kill as the
> > previously selected task has exited? However before adding more
> > complexity and heuristics, let's answer why we even look at the
> > children of oom-kill selected task? The select_bad_process() has already
> > selected the worst process in the system/memcg. Due to race, the
> > selected process might not be the worst at the kill time but does that
> > matter matter? The userspace can play with oom_score_adj to prefer
> > children to be killed before the parent. I looked at the history but it
> > seems like this is there before git history.
>
> I'd totally support you in an attempt to remove this logic,
> unless someone has a good example of its usefulness.
>
> I believe it's a very old hack to select children over parents
> in case they have the same oom badness (e.g. share most of the memory).
>
> Maybe we can prefer older processes in case of equal oom badness,
> and it will be enough.
>
> Thanks!

I am thinking of removing the whole logic of selecting children.

Shakeel
