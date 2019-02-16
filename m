Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AA8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06C2222D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCyhGjUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfBPG2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 01:28:42 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50754 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfBPG2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 01:28:42 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so29523459iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 22:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbjFJ152ZPD3ir80yGRZREZI/XxhVIU1iQJ+AWxOaoY=;
        b=fCyhGjUicb6exKU3TSGhS301TpcY7BL+rp+Pwb3ZKIWV4ocTI5Du5mDjdGwp/kwW2Z
         +KXPLUrSs809YX3aQ3jlFTrmcBIwJT1nt2dWns2KNHYeBiX9/k7QrIrbPD8Qfn8+gGy4
         hd6XdU8D2e5XvXQsbBkbSe0l/IbyLN7lGeiO/AuH11sVFGseoUbpOE95pCmukx0gInQt
         +qaJqxCwHeAtcJiBpzXTd7dHIsvomvumqOfa+Ri0Ln5o1QRL//r9tfi/ZAx1dUwGTpOU
         /xFd13i8VM92QRk4V+/ozEnzHvpu/0A0z50pFjPzXR/u0EDld9MpjMldKmTRpqPWIcUv
         ytlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbjFJ152ZPD3ir80yGRZREZI/XxhVIU1iQJ+AWxOaoY=;
        b=qgc+5gQtfWYb6akOkrSjUcFkrpAoszZf7FUaZOMxsbasFVv29GYHgssYKos4kTMuOR
         aGbRhwprU4mmxOn21a/DcVf8JREmPKT2qXFFEslCr2mOLrOdtivr6juJoSho8l5Nex7M
         NE9s2NSHL82DBzYNy3U2pm8VAGKQ2tvHavpv98LPeogPIxe4X8LdLxjcUHQ/Pg9Z6O8y
         F2DAkgc3N07D+P1qW+2hIzsuMvbmFmO6vOTjOL3G3lqLfOx+oRKBr9nYTw8UPGXgo5w9
         igt/DLK0IdyXpAULDGDQLNMn25jo61gx6vnGKru93mOoD0vIGbto52wYgsMXhOD3aYJ8
         2PVA==
X-Gm-Message-State: AHQUAuZit7fqPOfHj0oWFkWK/oXFci2dNRc7Ynxpo4wti58mm2OqRa7c
        KHUkLmR9SpqM4QRzMjIOqzRhZz1lx2CTJdRD14ianQ==
X-Google-Smtp-Source: AHgI3Ial0TjFMObkr9EE0HMuQ4v/bv9FaIics4LODD898rGXYxDSOtOBQ/voHRB2TRRQ09OX0NarMHVFaEfKaJ9exMs=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr6988212ioc.282.1550298520426;
 Fri, 15 Feb 2019 22:28:40 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c13ce50577db36cc@google.com> <073dedee-62df-9c67-1742-8de1e6c9502a@redhat.com>
 <CACT4Y+Ys3E7Au6-wZ7DFi+yxu0sJ_Gi_6jgBHWGTQ9YNDnjE=g@mail.gmail.com>
 <CAG48ez3gk8d7qm1JiQyEZLbt85Ax7uqd=vQoxL=h_dAcQ1WWKA@mail.gmail.com>
 <CACT4Y+YvJeF1UakSjAPDcT1L1NYhczi6QacWA41tdSny_9ZZpg@mail.gmail.com>
 <CAG48ez0ZR6EoG2hortM-73a1H7TL58nXNLthn5yMwz5KuMHWUg@mail.gmail.com>
 <CACT4Y+Y2WaxO4PUYo854uOJPfd3AanftBaU-zbn=4uzBUUdNKw@mail.gmail.com> <CAG48ez3Zt1JQJT5qw-CxU=10_61_bmg5r9=7y4_E5zpip9Y5wg@mail.gmail.com>
In-Reply-To: <CAG48ez3Zt1JQJT5qw-CxU=10_61_bmg5r9=7y4_E5zpip9Y5wg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 16 Feb 2019 07:28:27 +0100
Message-ID: <CACT4Y+YTpeuq=L4gF_PwM0kYGtOrDuG4O0wVBH9ExX3V8=8XyQ@mail.gmail.com>
Subject: Re: WARNING: refcount bug in kvm_vm_ioctl
To:     Jann Horn <jannh@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        syzbot <syzbot+6df4d24a0a50fd5d1a08@syzkaller.appspotmail.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 6:22 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Feb 15, 2019 at 6:13 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Fri, Feb 15, 2019 at 6:10 PM Jann Horn <jannh@google.com> wrote:
> > > On Fri, Feb 15, 2019 at 5:45 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > On Fri, Feb 15, 2019 at 5:03 PM Jann Horn <jannh@google.com> wrote:
> > > > > On Fri, Feb 15, 2019 at 4:40 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > > On Thu, Oct 11, 2018 at 4:18 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > > > > On 10/10/2018 09:58, syzbot wrote:
> > > > > > > >  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
> > > > > > > >  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
> > > > > > > > RIP: 0010:refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
> > > > > > > >  kvm_get_kvm arch/x86/kvm/../../../virt/kvm/kvm_main.c:766 [inline]
> > > > > > > >  kvm_ioctl_create_device arch/x86/kvm/../../../virt/kvm/kvm_main.c:2924
> > > > > > > >  kvm_vm_ioctl+0xed7/0x1d40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3114
> > > > > > > >  vfs_ioctl fs/ioctl.c:46 [inline]
> > > > > > > >  file_ioctl fs/ioctl.c:501 [inline]
> > > > > > > >  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
> > > > > > > >  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
> > > > > > > >  __do_sys_ioctl fs/ioctl.c:709 [inline]
> > > > > > > >  __se_sys_ioctl fs/ioctl.c:707 [inline]
> > > > > > > >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
> > > > > > > >  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> > > > > > > >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > > > >
> > > > > > > The trace here is fairly simple, but I don't understand how this could
> > > > > > > happen.
> > > > > > >
> > > > > > > The kvm_get_kvm is done within kvm_ioctl_create_device, which is called
> > > > > > > from ioctl; the last reference cannot disappear inside a ioctl, because:
> > > > > > >
> > > > > > > 1) kvm_ioctl is called from vfs_ioctl, which does fdget and holds the fd
> > > > > > > reference until after kvm_vm_ioctl returns
> > > > > > >
> > > > > > > 2) the file descriptor holds one reference to the struct kvm*, and this
> > > > > > > reference is not released until kvm_vm_release is called by the last
> > > > > > > fput (which could be fdput's call to fput if the process has exited in
> > > > > > > the meanwhile)
> > > > > > >
> > > > > > > 3) for completeness, in case anon_inode_getfd fails, put_unused_fd will
> > > > > > > not invoke the file descriptor's ->release callback (in this case
> > > > > > > kvm_device_release).
> > > > > > >
> > > > > > > CCing some random people to get their opinion...
> > > > > > >
> > > > > > > Paolo
> > > > > >
> > > > > >
> > > > > > Jann, is it what you fixed in "kvm: fix kvm_ioctl_create_device()
> > > > > > reference counting (CVE-2019-6974)"?
> > > > > > If so, we need to close the syzbot bug.
> > > > > >
> > > > > >
> > > > > > > > # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> > > > > > > > #{"threaded":true,"collide":true,"repeat":true,"procs":6,"sandbox":"none","fault_call":-1,"tun":true,"tmpdir":true,"cgroups":true,"netdev":true,"resetnet":true,"segv":true}
> > > > > > > > r0 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000380)='/dev/kvm\x00', 0x0, 0x0)
> > > > > > > > r1 = syz_open_dev$dspn(&(0x7f0000000100)='/dev/dsp#\x00', 0x3fe, 0x400)
> > > > > > > > r2 = ioctl$KVM_CREATE_VM(r0, 0xae01, 0x0)
> > > > >
> > > > > Here we create a VM fd...
> > > > >
> > > > > > > > perf_event_open(&(0x7f0000000040)={0x1, 0x70, 0x0, 0x0, 0x0, 0x0, 0x0, 0x50d}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> > > > > > > > mincore(&(0x7f0000ffc000/0x1000)=nil, 0x1000, &(0x7f00000003c0)=""/4096)
> > > > > > > > setrlimit(0x0, &(0x7f0000000000))
> > > > > > > > readahead(r1, 0x3, 0x9a6)
> > > > > > > > ioctl$KVM_CREATE_DEVICE(r2, 0xc00caee0, &(0x7f00000002c0)={0x4})
> > > > >
> > > > > ... and here we do the KVM_CREATE_DEVICE ioctl with type==KVM_DEV_TYPE_VFIO.
> > > > >
> > > > > So that far it looks exactly like CVE-2019-6974. But CVE-2019-6974
> > > > > also requires that someone calls close() on the file descriptor of the
> > > > > newly created device very quickly, before the ioctl is able to
> > > > > increment the refcount further, and I don't see anything like that
> > > > > here. Is there a chance that syzkaller called close() on a file
> > > > > descriptor while the ioctl() was still running without saying so here
> > > > > (potentially through dup2() or something like that)?
> > > >
> > > > Yes, all fd's are closed at the end of the test:
> > > > https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L2561-L2568
> > >
> > > Can that happen before the ioctl() has finished?
> >
> > Yes, ioctl runs in a separate thread.
>
> Alright, then yes, it looks like the same bug.

Let's mark is as fixed then:

#syz fix:
kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

> Since the root cause wasn't identified from the original syzkaller
> report, I wonder whether it would make sense to add infrastructure
> that makes it easier to identify the root cause from a syzkaller
> report; here are some random ideas:
>
>  - A comment at the end of the syzkaller reproducer that lists
> interesting syscalls that are performed implicitly, in particular
> close(3..30). Without that information, the race isn't really visible
> here.

It would definitely be useful to produce C reproducers in more cases.
That's lingua franca of bug reporting.
All info is in the repro, but I am not sure it's possible to compress
it to something much more compact without losing information. That's
several KLOC of complex C code, not just "close(3..30)", also all of
syscall arguments and data and control flow, etc, which is naturally
represented by the C code which is already available.
Also this case is quite special, there is generally no other single
report to match with.


>  - A config option that allows recording (subsets of) stacks, PIDs,
> and cpu numbers in every function that modifies a refcount, and can
> dump the last N such records when a refcount detects an error. This
> would probably be helpful for figuring out refcounting bugs, but I
> don't actually know how many of the bugs syzkaller finds are
> refcounting-related - if it's not a lot, this might not be worth the
> effort.
