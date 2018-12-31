Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA88C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4AD20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lL9PqDvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeLaIYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:24:30 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52003 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeLaIY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 03:24:29 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so35213422ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/dJbjiOAY3ymU6pajADp9+hSys+HJ1L9NBPmb3INQs=;
        b=lL9PqDvSoOx02XKuKc4YXYvZEjuWMuahfKL9/Xlz+0U/k9gTkaDk+cOWtoH04IgSmI
         6+tiQ+AC5KSIHUJhvxrLuW51jmhUH/fp2d6d2IdQqYmm7tzVKr+uUTGPjrm2BxV9mxgx
         U5XykdJaTfL4SbVPowXm1de5Add8k69pE+f1VJEf3jVHdF9CWVnkAhzrkL5S07Hk7qZS
         0VKs3/9VHcOojv1drHai35XhpBT3rppyZakSOnZ16wmPCBPCw4S3J6YiJXoFP4nYoj3f
         izS9l3vG2opYLcvP8qVG/JCooLA5ZOCLL3mvAUeYr7rfOtsRodvRuqV8QHrc0vfnpbmI
         aUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/dJbjiOAY3ymU6pajADp9+hSys+HJ1L9NBPmb3INQs=;
        b=WFBQy87QaHvYhk2triAV3PJghegxjQw/9cSsGW+gasZERvxGH1vmg5DFtiaenPmQbo
         R25jDK968Or4wyarmbC3X/ROTubKvakcgXtZrB1SPoMJk2N5fcfrIQugZxk+SmBZ5ZMY
         wn0FveL2X0FJ08v1ydp3Ag8gHXS+vietzfeKR2omDu73YsdBeRWlPkiWdVkpDPnY3Rcs
         K/3BdAQN8EEHfZ8mpbirXYaokTXdQ7vcs4kjJprCZvxOB1SraCUMF3d1ajFq3232UEQq
         exOkpueMJsybtaOESZSOauLS+zCzi5vc+7JaHeIvrO2azgfnv5Y9Av7XHCgEUGK0QxUg
         9xJQ==
X-Gm-Message-State: AJcUukd63psQEvSNjL9K0CKtTfjdIZ+ZYQ5Ek/qjunSiY6JBSL599HBs
        vKEdYu5TAxZkT/Xp2q9QdrTFGGA3+tNfI24KZ/pGNQ==
X-Google-Smtp-Source: AFSGD/WAXRR32TGOAsq8ckXtNG4WI9cS6EgN+hAJoP8QpGjd2i1aJD1h4MIBx0fPKKhWRr2JmBQqnyNtZYsKApO51K0=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr20595383itl.144.1546244667674;
 Mon, 31 Dec 2018 00:24:27 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007beca9057e4c8c14@google.com> <CACT4Y+Yx4BJw=F_PMx9a8AjPKzEwhzLnzt9K-dgkBoNkKQj2+g@mail.gmail.com>
 <ef2508c9-d069-2143-09a6-a90b9ef12568@I-love.SAKURA.ne.jp>
In-Reply-To: <ef2508c9-d069-2143-09a6-a90b9ef12568@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 31 Dec 2018 09:24:16 +0100
Message-ID: <CACT4Y+YYwYDnqFmMwfSg6UNXnrbh46bo0jp7ijbej8nkDDmBXQ@mail.gmail.com>
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

On Mon, Dec 31, 2018 at 9:17 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2018/12/31 16:49, Dmitry Vyukov wrote:
> > On Mon, Dec 31, 2018 at 8:42 AM syzbot
> > <syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    ef4ab8447aa2 selftests: bpf: install script with_addr.sh
> >> git tree:       bpf-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=14a28b6e400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=7e7e2279c0020d5f
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=ea7d9cb314b4ab49a18a
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com
> >
> > Since this involves OOMs and looks like a one-off induced memory corruption:
> >
> > #syz dup: kernel panic: corrupted stack end in wb_workfn
> >
>
> Why?
>
> RCU stall in this case is likely to be latency caused by flooding of printk().

Just a hypothesis. OOMs lead to arbitrary memory corruptions, so can
cause stalls as well. But can be what you said too. I just thought
that cleaner dashboard is more useful than a large assorted pile of
crashes. If you think it's actionable in some way, feel free to undup.
