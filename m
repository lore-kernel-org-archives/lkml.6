Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83418C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1181206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2zKW+jI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbeLNOb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:31:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40593 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeLNOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:31:57 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so9521655ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 06:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4Jzwgst8CyPAaVUjt045hsr4zqPqrq2fKdym2xJMs4=;
        b=f2zKW+jI/2BIO0E7wlvLD8pwcwEV9zIWdfnx3j0yuCrENpAuDQzGxZAp+FjVbKWqi9
         2shFNjjPesjgbXOAR5La4eqbSa69amhykaIFNS3TkdjiuJ15gc3FAjESOCHxKPdPwMj+
         CKXxE5mZM8mDNScYH+j0gOtnyfFBnI6xGfQlXKHbJDANo7FHvbn9Fg1nqRzUrmsflkFW
         Lrf6utLhT3ObxqUkxyyyG2A8FYjv4IP2XFStOwwyq5qTmIS++IlZD74IjRFQiA6Aqmwp
         iKNkmAeMnjnz9z/6RRJs19kQ3IPwUpcYhWxK4c0K4EPzuRIFxm2EfDqXto6nR2KzGSWk
         I6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4Jzwgst8CyPAaVUjt045hsr4zqPqrq2fKdym2xJMs4=;
        b=HEMRytVA41VJfOdnbctX9bXJkoDzpG+0QjN9FSCuYy/XYVqvwPySSFjd6E+0hBTsjI
         nBqvLOzvoY+kceTUItHXvimeVV+HWl4IeHxwGyleYLIaz/3KzgJqU21M2az60ob6Skd8
         6MSagJrleArawQOT5eUgoAhIaBDEyEVLMZdoYW5cwvNN/O1cgLtlHxPhtt+31R1Cvy4N
         YYtDmm3LhKLtebU34aG/mA+AvYvfLZ6aj5kx5cRelZz5ZoMuvH3tmLY+5uKXSTMVz//W
         pbxmB/7PhT0NI+5N9CkPTLF47T9eRPnCUONL7vYNqeT+9ZwzQIJyDplH0exZ/FcuJK76
         L0fQ==
X-Gm-Message-State: AA+aEWbPL5fpt7pKCdzJ+xP+uy92wOLQ1WEp7+4qHNaWhyVkGMJcpL6d
        oZ1lQnb6VFZHL6KMhv1S2r2yEbhIWP/a5vHRqNNRc/30P/w=
X-Google-Smtp-Source: AFSGD/VFexjQziu6RBJS4hSHy5tgWdTl4CRUHmnNcJL0PHxWomMm3Q839r0Pg4ZHe2Eke94thXn/n+j0eZcrTYhDXJs=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr2970627itl.144.1544797915850;
 Fri, 14 Dec 2018 06:31:55 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004ea80b057cfae21e@google.com> <CACT4Y+Z+AhQxf6=ecOkX1bOU5h7kMHYnR6CAhBv9eO5jQVeG3g@mail.gmail.com>
 <20181214132836.GE5343@dhcp22.suse.cz> <CACT4Y+aXFXnObgC-7NVe87-1bbqs2oNBBXe2mrfshLKnFqkTGA@mail.gmail.com>
 <20181214135419.GG5343@dhcp22.suse.cz>
In-Reply-To: <20181214135419.GG5343@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 14 Dec 2018 15:31:44 +0100
Message-ID: <CACT4Y+b1Qc069LO25JhJh51zTAMBL6t_E7LRZiSPi8FP0v+zUQ@mail.gmail.com>
Subject: Re: general protection fault in watchdog
To:     Michal Hocko <mhocko@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Cc:     syzbot <syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        rafael.j.wysocki@intel.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vkuznets@redhat.com, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 2:54 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 14-12-18 14:42:33, Dmitry Vyukov wrote:
> > On Fri, Dec 14, 2018 at 2:28 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Fri 14-12-18 14:11:05, Dmitry Vyukov wrote:
> > > > On Fri, Dec 14, 2018 at 1:51 PM syzbot
> > > > <syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=16aca143400000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7713f3aa67be76b1552c
> > > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1131381b400000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bae593400000
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > Reported-by: syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
> > > >
> > > > +linux-mm for memcg question
> > > >
> > > > What the repro does is effectively just
> > > > setsockopt(EBT_SO_SET_ENTRIES). This eats all machine memory and
> > > > causes OOMs. Somehow it also caused the GPF in watchdog when it
> > > > iterates over task list, perhaps some scheduler code leaves a dangling
> > > > pointer on OOM failures.
> > > >
> > > > But what bothers me is a different thing. syzkaller test processes are
> > > > sandboxed with a restrictive memcg which should prevent them from
> > > > eating all memory. do_replace_finish calls vmalloc, which uses
> > > > GFP_KERNEL, which does not include GFP_ACCOUNT (GFP_KERNEL_ACCOUNT
> > > > does). And page alloc seems to change memory against memcg iff
> > > > GFP_ACCOUNT is provided.
> > > > Am I missing something or vmalloc is indeed not accounted (DoS)? I see
> > > > some explicit uses of GFP_KERNEL_ACCOUNT, e.g. the one below, but they
> > > > seem to be very sparse.
> > > >
> > > > static void *seq_buf_alloc(unsigned long size)
> > > > {
> > > >      return kvmalloc(size, GFP_KERNEL_ACCOUNT);
> > > > }
> > > >
> > > > Now looking at the code I also don't see how kmalloc(GFP_KERNEL) is
> > > > accounted... Which makes me think I am still missing something.
> > >
> > > You are not missing anything. We do not account all allocations and you
> > > have to explicitly opt-in by __GFP_ACCOUNT. This is a deliberate
> > > decision. If the allocation is directly controlable by an untrusted user
> > > and the memory is associated with a process life time then this looks
> > > like a good usecase for __GFP_ACCOUNT. If an allocation outlives a
> > > process then there the flag should be considered with a great care
> > > because oom killer is not able to resolve the memcg pressure and so the
> > > limit enforcement is not effective.
> >
> > Interesting.
> > I understand that namespaces, memcg's and processes (maybe even
> > threads) can have arbitrary overlapping. But I naively thought that in
> > canonical hierarchical cases it should all somehow work.
> > Question 1: is there some other, stricter sandboxing mechanism?
>
> I do not think so
>
> > We try
> > to sandbox syzkaller processes with everything available , because
> > these OOMs usually leads either to dead machines or hang/stall false
> > positives, which are nasty.
>
> Which is a useful test on its own. If you are able to trigger the global
> OOM from a restricted environment then you have a good candidate to
> consider a new __GFP_ACCOUNT user.
>
> > Question 2: this is a simple DoS vector, right? If I put a container
> > into a 1MB memcg, it can still eat arbitrary amount of non-pagable
> > kernel memory?
>
> As I've said. If there is a direct vector to allocated an unbounded
> amount of memory from the userspace (trusted users aside) then yes this
> sounds like a DoS to me.

+netfilter maintainers for this easy DoS vector
short story: vmalloc in do_replace_finish allows unbounded memory
allocation not accounted to memcg

Looks pretty unbounded:

[  763.451796] syz-executor681: vmalloc: allocation failure, allocated
1027440640 of 1879052288 bytes, mode:0x6000c0(GFP_KERNEL),
nodemask=(null)

But how does this play with what you said about memory outliving
process? Netfilter tables can definitely outlive the process, they are
attached to net ns.

Also, am I reading this correctly that potentially thousands of kernel
memory allocations need to be converted to ACCOUNT? I mean for small
ones we maybe care less, but they _should_ be accounted. They can also
build up, or just simply allow small repeated allocations.

GFP_KERNEL Referenced in 11070 files:
https://elixir.bootlin.com/linux/latest/ident/GFP_KERNEL

GFP_KERNEL_ACCOUNT Referenced in 19 files:
https://elixir.bootlin.com/linux/latest/ident/GFP_KERNEL_ACCOUNT
