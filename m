Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13107C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43002190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKYxrcqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfBORNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:13:05 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53155 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfBORNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:13:05 -0500
Received: by mail-it1-f193.google.com with SMTP id r11so25784054itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W9ZMbNm3tadltx0gpX2Ghh7zmbeYYzk4f9wYUWZfxlg=;
        b=iKYxrcqEeUf7DRr/r4K1Axc4X51/k0jpAMEwLnSDHM2aon4l/JguGmNxziD92H/Pjh
         Y0S0Uf2C9VSxAA1mEV4NSAVwrW6IMN3w6dFGcPON9/5VFPO03/GzMevkak3k5v9wAeuC
         WdXMaqua5+TAW+0qHrnMPD4EFAieyBhwRc/NAN39OwyWr32CEijaSIFogg2NKezSbk69
         2QGw5yAXlxCDXStcp1JC3LKGEv23yE5cjDWudUZo2XI0nlsslkH2nIfwGbe3fYKE4Ck2
         yJTQ2H59LMCkKEMAmKxqeRsjyX6+g+avbZ1i68mGsDoSQTK8Lt438Xm4ChiWwo+eoht+
         F2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9ZMbNm3tadltx0gpX2Ghh7zmbeYYzk4f9wYUWZfxlg=;
        b=Yym3vFop60uA3obzRZPCdOSPyX/vxGZeKtUlLa4glkIkn6taThax2YVHxt7MAp9qrw
         v5UPqx5IvwUzBEJ1L4vUPCj7YGyG+sRHNMVSilXI7UzMrKCoPh1DmxxN8WQlnRwJsO5P
         6w8cOk0/VSeHJHS1DysG10f95UQfeiFm/g2SyVvIyFN4ilz7iTGJ66PnfPqT13gWGe2D
         ZsscOEe2Cg8EGo4XOPx23CRLJHER5mLSrBrNNiEMm5GOTQzB1Vnk0xNu9qcKObjX/5SD
         4pEv0yPgOEOaU0PGDnimPx8JIODMRIO65dOvldV8ouSwAKRxtAn/kZrltay/jVTZMuQ0
         +Gng==
X-Gm-Message-State: AHQUAubrecRa/0QrUYmewjrDGwQi5b6m1vBX1NJQfT+C09zpoQldS3Ld
        srL4+krGsbEeo5m88i8bBp3UFiHvL7KrrnoKHUvHYA==
X-Google-Smtp-Source: AHgI3IbKNjrrsjUyjmZV++eTatmpwgpkwX095RBzIOtOzg+N70GpBHLGZakdKMkqB/IyQ5Dg34eQUnPPfUiGzuIVzfw=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr5592316ioc.282.1550250783698;
 Fri, 15 Feb 2019 09:13:03 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c13ce50577db36cc@google.com> <073dedee-62df-9c67-1742-8de1e6c9502a@redhat.com>
 <CACT4Y+Ys3E7Au6-wZ7DFi+yxu0sJ_Gi_6jgBHWGTQ9YNDnjE=g@mail.gmail.com>
 <CAG48ez3gk8d7qm1JiQyEZLbt85Ax7uqd=vQoxL=h_dAcQ1WWKA@mail.gmail.com>
 <CACT4Y+YvJeF1UakSjAPDcT1L1NYhczi6QacWA41tdSny_9ZZpg@mail.gmail.com> <CAG48ez0ZR6EoG2hortM-73a1H7TL58nXNLthn5yMwz5KuMHWUg@mail.gmail.com>
In-Reply-To: <CAG48ez0ZR6EoG2hortM-73a1H7TL58nXNLthn5yMwz5KuMHWUg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 15 Feb 2019 18:12:52 +0100
Message-ID: <CACT4Y+Y2WaxO4PUYo854uOJPfd3AanftBaU-zbn=4uzBUUdNKw@mail.gmail.com>
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

On Fri, Feb 15, 2019 at 6:10 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Feb 15, 2019 at 5:45 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Fri, Feb 15, 2019 at 5:03 PM Jann Horn <jannh@google.com> wrote:
> > >
> > > On Fri, Feb 15, 2019 at 4:40 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > On Thu, Oct 11, 2018 at 4:18 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > > On 10/10/2018 09:58, syzbot wrote:
> > > > > >  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
> > > > > >  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
> > > > > > RIP: 0010:refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
> > > > > >  kvm_get_kvm arch/x86/kvm/../../../virt/kvm/kvm_main.c:766 [inline]
> > > > > >  kvm_ioctl_create_device arch/x86/kvm/../../../virt/kvm/kvm_main.c:2924
> > > > > >  kvm_vm_ioctl+0xed7/0x1d40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3114
> > > > > >  vfs_ioctl fs/ioctl.c:46 [inline]
> > > > > >  file_ioctl fs/ioctl.c:501 [inline]
> > > > > >  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
> > > > > >  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
> > > > > >  __do_sys_ioctl fs/ioctl.c:709 [inline]
> > > > > >  __se_sys_ioctl fs/ioctl.c:707 [inline]
> > > > > >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
> > > > > >  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> > > > > >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > >
> > > > > The trace here is fairly simple, but I don't understand how this could
> > > > > happen.
> > > > >
> > > > > The kvm_get_kvm is done within kvm_ioctl_create_device, which is called
> > > > > from ioctl; the last reference cannot disappear inside a ioctl, because:
> > > > >
> > > > > 1) kvm_ioctl is called from vfs_ioctl, which does fdget and holds the fd
> > > > > reference until after kvm_vm_ioctl returns
> > > > >
> > > > > 2) the file descriptor holds one reference to the struct kvm*, and this
> > > > > reference is not released until kvm_vm_release is called by the last
> > > > > fput (which could be fdput's call to fput if the process has exited in
> > > > > the meanwhile)
> > > > >
> > > > > 3) for completeness, in case anon_inode_getfd fails, put_unused_fd will
> > > > > not invoke the file descriptor's ->release callback (in this case
> > > > > kvm_device_release).
> > > > >
> > > > > CCing some random people to get their opinion...
> > > > >
> > > > > Paolo
> > > >
> > > >
> > > > Jann, is it what you fixed in "kvm: fix kvm_ioctl_create_device()
> > > > reference counting (CVE-2019-6974)"?
> > > > If so, we need to close the syzbot bug.
> > > >
> > > >
> > > > > > # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> > > > > > #{"threaded":true,"collide":true,"repeat":true,"procs":6,"sandbox":"none","fault_call":-1,"tun":true,"tmpdir":true,"cgroups":true,"netdev":true,"resetnet":true,"segv":true}
> > > > > > r0 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000380)='/dev/kvm\x00', 0x0, 0x0)
> > > > > > r1 = syz_open_dev$dspn(&(0x7f0000000100)='/dev/dsp#\x00', 0x3fe, 0x400)
> > > > > > r2 = ioctl$KVM_CREATE_VM(r0, 0xae01, 0x0)
> > >
> > > Here we create a VM fd...
> > >
> > > > > > perf_event_open(&(0x7f0000000040)={0x1, 0x70, 0x0, 0x0, 0x0, 0x0, 0x0, 0x50d}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> > > > > > mincore(&(0x7f0000ffc000/0x1000)=nil, 0x1000, &(0x7f00000003c0)=""/4096)
> > > > > > setrlimit(0x0, &(0x7f0000000000))
> > > > > > readahead(r1, 0x3, 0x9a6)
> > > > > > ioctl$KVM_CREATE_DEVICE(r2, 0xc00caee0, &(0x7f00000002c0)={0x4})
> > >
> > > ... and here we do the KVM_CREATE_DEVICE ioctl with type==KVM_DEV_TYPE_VFIO.
> > >
> > > So that far it looks exactly like CVE-2019-6974. But CVE-2019-6974
> > > also requires that someone calls close() on the file descriptor of the
> > > newly created device very quickly, before the ioctl is able to
> > > increment the refcount further, and I don't see anything like that
> > > here. Is there a chance that syzkaller called close() on a file
> > > descriptor while the ioctl() was still running without saying so here
> > > (potentially through dup2() or something like that)?
> >
> > Yes, all fd's are closed at the end of the test:
> > https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L2561-L2568
>
> Can that happen before the ioctl() has finished?

Yes, ioctl runs in a separate thread.
