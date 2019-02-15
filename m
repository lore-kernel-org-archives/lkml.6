Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17EFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707EF21927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMK5tZd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391216AbfBOQDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:03:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39903 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfBOQDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:03:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so17306797otl.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQ8zJ4anEmJxTlDcKWED0D8GmxDA1bsgSe6R3t3u3dM=;
        b=SMK5tZd+xHhif8/wZTEZltb4tZjHIV59VOol6opYpTZDe3xTZA9If5sRdVe7TfOxJw
         5bcWdzBpD1l39Fwysh1QaLiSL6xwnnvuOHhEfyy3m/41viCHMZH5gg69iVg+HUaJDR82
         ZeFwJ4meF9TksgTr0HplAqO2Z+p+lDdmLCWVMPCZicEdl8u7zv8mjMjgEm0vk9MycVWQ
         BVz/eP0vzTeALA+sRi4cRTmsmvRHu7Rv9qBpGkSU/+kgq8tcf5MWkYZcRC7qZLwoz3XT
         8Bzw0nEFM2vYquQ2WVngSYNzHNau51L8hkc/HfeiX94lVBphbn+vrU91glkhlXINrIpr
         vaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQ8zJ4anEmJxTlDcKWED0D8GmxDA1bsgSe6R3t3u3dM=;
        b=MuHjyROxdMWgkYAy2V8Nzv3p9m+2QALn2ff8oSjUmytZrN6cJlx1kkYxbJB1RsXY3C
         FnvJ1nW5pKvuXZLCl72MOl3CM7oFKCE8Ed0ErjJ19reAOFfxtc1iTtRusZ1pwb68Ad5M
         yp9YcZojwaXgcPbcBTNXt4hmxoIVIgZ3FIqmxDn/6GSDBxxh5pW2zZxdVlqo18w4I94N
         fmJ0kAih0DIDpJg/rHJDCtOEhjSorBj1LpBXFqiU+O0P0cMNR423d9EFHLtkTymZrEKm
         508X2T899BbPd26wMs4lQaZ4NSsHiDiQnGVESRYMG/pGKE8ZFrR0QiXoIxeql18g+nZp
         POcw==
X-Gm-Message-State: AHQUAubblIpgjI0uCLUS522chUfOZaGRKXui3O3idvUpi9miuGBgRPve
        JfImQ0g/kEg9fq1XTpd0d5WyIuRJlMpr8OWaXzL/wg==
X-Google-Smtp-Source: AHgI3IYzfSq1fRvYCjjgJpuSHm/DDMcQPkIQTzEIXZRzPA3mGmyuxUdfz+zSOIc7bgbF4txI7dw7Jx9UBt22hafimCg=
X-Received: by 2002:a05:6830:14d6:: with SMTP id t22mr6490741otq.255.1550246588758;
 Fri, 15 Feb 2019 08:03:08 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c13ce50577db36cc@google.com> <073dedee-62df-9c67-1742-8de1e6c9502a@redhat.com>
 <CACT4Y+Ys3E7Au6-wZ7DFi+yxu0sJ_Gi_6jgBHWGTQ9YNDnjE=g@mail.gmail.com>
In-Reply-To: <CACT4Y+Ys3E7Au6-wZ7DFi+yxu0sJ_Gi_6jgBHWGTQ9YNDnjE=g@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 15 Feb 2019 17:02:42 +0100
Message-ID: <CAG48ez3gk8d7qm1JiQyEZLbt85Ax7uqd=vQoxL=h_dAcQ1WWKA@mail.gmail.com>
Subject: Re: WARNING: refcount bug in kvm_vm_ioctl
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Fri, Feb 15, 2019 at 4:40 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Oct 11, 2018 at 4:18 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 10/10/2018 09:58, syzbot wrote:
> > >  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
> > >  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
> > > RIP: 0010:refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
> > >  kvm_get_kvm arch/x86/kvm/../../../virt/kvm/kvm_main.c:766 [inline]
> > >  kvm_ioctl_create_device arch/x86/kvm/../../../virt/kvm/kvm_main.c:2924
> > >  kvm_vm_ioctl+0xed7/0x1d40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3114
> > >  vfs_ioctl fs/ioctl.c:46 [inline]
> > >  file_ioctl fs/ioctl.c:501 [inline]
> > >  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
> > >  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
> > >  __do_sys_ioctl fs/ioctl.c:709 [inline]
> > >  __se_sys_ioctl fs/ioctl.c:707 [inline]
> > >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
> > >  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> > >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > The trace here is fairly simple, but I don't understand how this could
> > happen.
> >
> > The kvm_get_kvm is done within kvm_ioctl_create_device, which is called
> > from ioctl; the last reference cannot disappear inside a ioctl, because:
> >
> > 1) kvm_ioctl is called from vfs_ioctl, which does fdget and holds the fd
> > reference until after kvm_vm_ioctl returns
> >
> > 2) the file descriptor holds one reference to the struct kvm*, and this
> > reference is not released until kvm_vm_release is called by the last
> > fput (which could be fdput's call to fput if the process has exited in
> > the meanwhile)
> >
> > 3) for completeness, in case anon_inode_getfd fails, put_unused_fd will
> > not invoke the file descriptor's ->release callback (in this case
> > kvm_device_release).
> >
> > CCing some random people to get their opinion...
> >
> > Paolo
>
>
> Jann, is it what you fixed in "kvm: fix kvm_ioctl_create_device()
> reference counting (CVE-2019-6974)"?
> If so, we need to close the syzbot bug.
>
>
> > > # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> > > #{"threaded":true,"collide":true,"repeat":true,"procs":6,"sandbox":"none","fault_call":-1,"tun":true,"tmpdir":true,"cgroups":true,"netdev":true,"resetnet":true,"segv":true}
> > > r0 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000380)='/dev/kvm\x00', 0x0, 0x0)
> > > r1 = syz_open_dev$dspn(&(0x7f0000000100)='/dev/dsp#\x00', 0x3fe, 0x400)
> > > r2 = ioctl$KVM_CREATE_VM(r0, 0xae01, 0x0)

Here we create a VM fd...

> > > perf_event_open(&(0x7f0000000040)={0x1, 0x70, 0x0, 0x0, 0x0, 0x0, 0x0, 0x50d}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> > > mincore(&(0x7f0000ffc000/0x1000)=nil, 0x1000, &(0x7f00000003c0)=""/4096)
> > > setrlimit(0x0, &(0x7f0000000000))
> > > readahead(r1, 0x3, 0x9a6)
> > > ioctl$KVM_CREATE_DEVICE(r2, 0xc00caee0, &(0x7f00000002c0)={0x4})

... and here we do the KVM_CREATE_DEVICE ioctl with type==KVM_DEV_TYPE_VFIO.

So that far it looks exactly like CVE-2019-6974. But CVE-2019-6974
also requires that someone calls close() on the file descriptor of the
newly created device very quickly, before the ioctl is able to
increment the refcount further, and I don't see anything like that
here. Is there a chance that syzkaller called close() on a file
descriptor while the ioctl() was still running without saying so here
(potentially through dup2() or something like that)?

It would be helpful if we could see the backtrace of how the refcount
was dropped to zero...

> > > setsockopt$inet_sctp6_SCTP_FRAGMENT_INTERLEAVE(r1, 0x84, 0x12, &(0x7f00000001c0)=0x9, 0x4)
