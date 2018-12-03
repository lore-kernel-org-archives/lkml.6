Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB09C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0C520672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veLWbyqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0C520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbeLCOyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:54:37 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42801 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeLCOyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:54:36 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so10659007ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 06:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yiHp7VdNM8j2iZtw3XtXwebID+6t7QpZ5oGc6he441U=;
        b=veLWbyqXRlcfNShFI2kC7Zp7IQaytbyvLRjMo+JJvqzoXNZ8cK326q3kZ1uzs7a05G
         ewDWGk4gtN7seLt9iUpdMZX8HiVFf1tKLPRpDIz3o30+VTSW2Go9cGKN/PVj8+jOYlXd
         tJ7FNW1zUu5PqyptIRIOLAWgnBVOjXxfWJwLnndB1ii4swDnDmmqdX+krd5naDeIvEy6
         ZjT6MiOnzvuXXkwYq8sP9Dm+WeONlSs8KBP1E1EP9GOPHeNv6M9PbIFLVJ558uuQMcKe
         nNknhOaLdFhSTck00qQC5FYd53KZullUhP40pbY4dxDQXpwGh4AYktCQGxhDPG2AEqPA
         0zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yiHp7VdNM8j2iZtw3XtXwebID+6t7QpZ5oGc6he441U=;
        b=qadKimiA3ESNhS/IgkwBqvdT0/vYrJ6ExgWqaqZ4C8tithodKrOxXaD6i3UL09c2hF
         Pkkm/fJRHNQTjB9gooDfV1eSjHoAyTrh747XD3OiORJBjKR+ZRwSBnLNfT6uWbKKni/p
         L1T047gXuW+V9odUHGr/Fy/GQgfNLpXN/NJC7IAYxj8met9Oh3eh3YxApyUt5vAOx6Db
         5MCyKUHgkIpcxzJDhxntal7C5BE2zGCWhgLeetbenfSi/XKP3POv1wX0uJmRhv4KmzGd
         /QVM7X36aZ3wG1FptKbcFKogFP2P/92EtufJ3wb5GTB9mdbpT+nVGHZldejr71HSHiVe
         fL8A==
X-Gm-Message-State: AA+aEWaBuUv6LpuSq40fns0hMKP8Qm22dwii3l1xjp/qtaGaZxtbSLra
        guernBN8YdA/AyGdptWWiPcNTHfSxxcsughSiIWbXwctt4o=
X-Google-Smtp-Source: AFSGD/WZ4Q0FkjtobA8iBAQvnvN/GRA1Tnj23tDdFKaQ81OW8Oye7oRduPu/Wo3DsoS+ViC4iWp1hO3Kf+x7iyfnPM8=
X-Received: by 2002:a6b:fa0e:: with SMTP id p14mr7495772ioh.271.1543848797522;
 Mon, 03 Dec 2018 06:53:17 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004eade9057ba76eae@google.com> <621f7c52-de52-eb35-bf61-e839adee7ec9@colorfullife.com>
 <CACT4Y+ZStCdg6NhyYAtUZS07NWR=oJzdTZxpD+uyr=3SAVSmVw@mail.gmail.com> <3c159449-bcf9-759a-271c-4d4dd6f63802@colorfullife.com>
In-Reply-To: <3c159449-bcf9-759a-271c-4d4dd6f63802@colorfullife.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Dec 2018 15:53:06 +0100
Message-ID: <CACT4Y+YR_zvrS4tDTeZ6hy5HCzgiaZG8TLTUPgRMZHdxnpJP2w@mail.gmail.com>
Subject: Re: BUG: corrupted list in freeary
To:     manfred <manfred@colorfullife.com>
Cc:     syzbot <syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 9:22 PM Manfred Spraul <manfred@colorfullife.com> wrote:
>
> Hi Dmitry,
>
> On 11/30/18 6:58 PM, Dmitry Vyukov wrote:
> > On Thu, Nov 29, 2018 at 9:13 AM, Manfred Spraul
> > <manfred@colorfullife.com> wrote:
> >> Hello together,
> >>
> >> On 11/27/18 4:52 PM, syzbot wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    e195ca6cb6f2 Merge branch 'for-linus' of git://git.kernel...
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=10d3e6a3400000
> [...]
> >> Isn't this a kernel stack overrun?
> >>
> >> RSP: 0x..83e008. Assuming 8 kB kernel stack, and 8 kB alignment, we have
> >> used up everything.
> > I don't exact answer, that's just the kernel output that we captured
> > from console.
> >
> > FWIW with KASAN stacks are 16K:
> > https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/page_64_types.h#L10
> Ok, thanks. And stack overrun detection is enabled as well -> a real
> stack overrun is unlikely.
> > Well, generally everything except for kernel crashes is expected.
> >
> > We actually sandbox it with memcg quite aggressively:
> > https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L2159
> > But it seems to manage to either break the limits, or cause some
> > massive memory leaks. The nature of that is yet unknown.
>
> Is it possible to start from that side?
>
> Are there other syzcaller runs where the OOM killer triggers that much?

Lots of them:

https://groups.google.com/forum/#!searchin/syzkaller-upstream-moderation/lowmem_reserve
https://groups.google.com/forum/#!searchin/syzkaller-bugs/lowmem_reserve

But nobody got any hook on the reasons.


> >> - Which stress tests are enabled? By chance, I found:
> >>
> >> [  433.304586] FAULT_INJECTION: forcing a failure.^M
> >> [  433.304586] name fail_page_alloc, interval 1, probability 0, space 0,
> >> times 0^M
> >> [  433.316471] CPU: 1 PID: 19653 Comm: syz-executor4 Not tainted 4.20.0-rc3+
> >> #348^M
> >> [  433.323841] Hardware name: Google Google Compute Engine/Google Compute
> >> Engine, BIOS Google 01/01/2011^M
> >>
> >> I need some more background, then I can review the code.
> > What exactly do you mean by "Which stress tests"?
> > Fault injection is enabled. Also random workload from userspace.
> >
> >
> >> Right now, I would put it into my "unknown syzcaller finding" folder.
>
> One more idea: Are there further syzcaller runs that end up with
> 0x010000 in a pointer?

Hard to say. syzbot triggered millions of crashes. I can't say that I
remember this as distinctive pattern that come up before.

>  From what I see, the sysv sem code that is used is trivial, I don't see
> that it could cause the observed behavior.

I propose that we postpone further investigation of this until we have
a reproducer, or this happens more than once, or we gather some other
information.
Half of bugs are simple, so even for a crash happened once it makes
sense to spend 10 minutes looking at the code in case the root cause
is easy to spot. And hundreds of bugs were fixed this way. But I
assume you already did this.
The thing is that there are 100+ known bugs in kernel that lead to
memory corruptions:
https://syzkaller.appspot.com/#upstream-open
We try to catch them reliably with KASAN, but KASAN does not give 100%
guarantee. So if just one instance of a known bug gets unnoticed,
leads to a memory corruption, then later it can lead to an
unexplainable one-off crash like this. At this point higher ROI will
probably be from spending more time on hundreds of other known bugs
that have reproducers, happened lots of times, or just simpler. Once
we get rid of most of them, hopefully such unexplainable crashes will
go down too.
