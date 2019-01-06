Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB1BC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CF320663
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MK+m7w1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfAFNYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 08:24:37 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52374 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfAFNYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 08:24:36 -0500
Received: by mail-it1-f193.google.com with SMTP id g76so7358696itg.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 05:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A94FPMFmRCu34mADbdoh8iPEP0sj3Yw4xbl5b2Pzpt8=;
        b=MK+m7w1ftHUz4uzw6nibC38wTZ3HmdrCwFfq1n+Uz5n80s5SoomwCpHce3AhkAQaHt
         sfe3TsWB7DxlXxvh8Pt14lrqsPZAFa7roYBnd0XeKNseRo3cmuYfvtgwpKCo/rD7Luah
         29gri9qDksgZWH/co8X4/+kv4aHsu3eaemQy9WZvEmJd/cQlUIrrLKlO/K8zH1p5t0YM
         OnrGNgu7KjYM/iXuaO8KUSvGwa0vS6uiG8BpEA3WTNvm2H6QU/MdjMaHFsJVuUZkhx9v
         VYt88mgP2I6yIawysVo4z2IIhCgAj+fvwrYLP5V/HrMNW7bVd1NzqCYQzhdxaIgJRiXV
         G3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A94FPMFmRCu34mADbdoh8iPEP0sj3Yw4xbl5b2Pzpt8=;
        b=FfB7viVSmJ7a4WgFqOrxIQOnf3p1OlrWj6w97vyn+VHHXe+OVRI+UNa7oUJMODADiv
         aSE0Rn+z1djxrBlh50ajo7rpKvhTfelOfM9AEw/AGCcdj751kwdpykaHlZipgQaLUy1g
         dInhSv+PACXRcujQqO68JWuZPiZHjYWrbXV6adGCkYKpwfXxxZ4cI4sd5xq8zTVJtkEA
         /ybd0uDXMzQNUNYFaDoSW74uuw35urVXxiuoxJtb378Wp9Hjmvtf16fPOBYHHuXyFMQe
         DFBBP6mym5nguap/jqw42g+0+HZjWldb2FazbjND1GeXqEWd2KKrpmDhdtc70GswPPBA
         7+pQ==
X-Gm-Message-State: AJcUukcpMTReqEpPepjALrOUs/NSdoIAoYJw/1xjrgujJIDnw8+vmPlr
        9C2tHyH6LZJamc8/ietEzQhJHOzJsq8/Ax+CLiU+oQ==
X-Google-Smtp-Source: ALg8bN6JdQi0jEz8r5GHyCJfoQpsXYffmxwDe5Z++UDHkQR+iNNc4bjjg8mcrIi//WD4TVaottwtiKWu5D4PHJctsfw=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr4793104iti.166.1546781074476;
 Sun, 06 Jan 2019 05:24:34 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007beca9057e4c8c14@google.com> <CACT4Y+Yx4BJw=F_PMx9a8AjPKzEwhzLnzt9K-dgkBoNkKQj2+g@mail.gmail.com>
 <ef2508c9-d069-2143-09a6-a90b9ef12568@I-love.SAKURA.ne.jp>
 <CACT4Y+YYwYDnqFmMwfSg6UNXnrbh46bo0jp7ijbej8nkDDmBXQ@mail.gmail.com>
 <eeb95c52-5bf8-d3ce-d32b-269aa86bcd93@i-love.sakura.ne.jp> <8cdbcb63-d2f7-cace-0eda-d73255fd47e7@i-love.sakura.ne.jp>
In-Reply-To: <8cdbcb63-d2f7-cace-0eda-d73255fd47e7@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 6 Jan 2019 14:24:23 +0100
Message-ID: <CACT4Y+Y5cdD=optF2k4a0W7vriVnzmzLU0SPGEJoOHRMi_bsZA@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in ndisc_alloc_skb
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 11:49 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/01/03 2:06, Tetsuo Handa wrote:
> > On 2018/12/31 17:24, Dmitry Vyukov wrote:
> >>>> Since this involves OOMs and looks like a one-off induced memory corruption:
> >>>>
> >>>> #syz dup: kernel panic: corrupted stack end in wb_workfn
> >>>>
> >>>
> >>> Why?
> >>>
> >>> RCU stall in this case is likely to be latency caused by flooding of printk().
> >>
> >> Just a hypothesis. OOMs lead to arbitrary memory corruptions, so can
> >> cause stalls as well. But can be what you said too. I just thought
> >> that cleaner dashboard is more useful than a large assorted pile of
> >> crashes. If you think it's actionable in some way, feel free to undup.
> >>
> >
> > We don't know why bpf tree is hitting this problem.
> > Let's continue monitoring this problem.
> >
> > #syz undup
> >
>
> A report at 2019/01/05 10:08 from "no output from test machine (2)"
> ( https://syzkaller.appspot.com/text?tag=CrashLog&x=1700726f400000 )
> says that there are flood of memory allocation failure messages.
> Since continuous memory allocation failure messages itself is not
> recognized as a crash, we might be misunderstanding that this problem
> is not occurring recently. It will be nice if we can run testcases
> which are executed on bpf-next tree.

What exactly do you mean by running test cases on bpf-next tree?
syzbot tests bpf-next, so it executes lots of test cases on that tree.
One can also ask for patch testing on bpf-next tree to test a specific
test case.
