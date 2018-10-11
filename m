Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDFCC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BC4204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/OvfZ1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BC4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeJLCId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:08:33 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54749 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeJLCId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:08:33 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so15044531ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kaesTxCo7jWvu0OL6EVvdBgHkRmTqZ9R5DeztH7EjxM=;
        b=e/OvfZ1idKey0QpaEPhdlhT8RBWTyBKIf0KNSXNDwRSIBQxWXEdpH9O3Dbx8cCqgNg
         Q/mshXoc8VbtIN6C7WXQWpLJjVe/KvarOnfAV5sc7hOh3eVtWJD5pUwLZQosEYq3T/ug
         ifOPn8IKWMJnthSE9KjyxyDHYydUvP1HNDtHVFFF5Jfi0HiWbVkF8LRJd/+4gavg7tuI
         8/q8iH/j0dADvkjgYGMPtOwpGQCsCvP8Umj00HNXkuoeDB8hNTZoQsbzPvUNp2KNtqdD
         c0S1+G0iWmnXGrIKYVslVss/TbkBDeVNKXivUJgBb0IwsEHvq5AIiuvnWrMQAYY8gzbs
         LcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kaesTxCo7jWvu0OL6EVvdBgHkRmTqZ9R5DeztH7EjxM=;
        b=XoJXKNRUdBYD9Ao34zmwq672CyvcmIzGSLCdcBQym2u7R86iVZR6zrGi5M0L/HXH99
         yATCqZ9Q1qP+1pF3l74LcFRB6qD32jKA0zqvMduCrvWOXSSWCi9eqSYVDJjk86BC6clH
         jVWhqJMjMPedu9yRfKPx6MPXsSHlRHcLkkQncYviZgoCf11GQIuPH9EqqS5opicbVhvq
         oR1k8sAnk9J2aI6cy5ktEDfFqbapVRpFvnZWESk8sRkQXR9soh2rPYJiytpP4Lfs+U/c
         1hKdr2u79ruVS8HJCVki4VmSmYSjU6H+5fIlR0URfmdCu2AcNzlKoRw00aephiMxv9SI
         MlAQ==
X-Gm-Message-State: ABuFfojuLnK+JNznVNAbg5ia/H8uRLBpRbp5Q8jiLPH5rGj+fZVw7OsT
        W/YLMqz8VP9+3ppB1KkdR1077lHySN/5Hd3kIlNvvw==
X-Google-Smtp-Source: ACcGV62tTEX+hPrz0iMBnLszBMxQDmrTw7z4mY3n0ySRkjXvoergDNvLeTNW++u8PwdB8yxEs+dtyebruRTqsRIs2ak=
X-Received: by 2002:a24:f584:: with SMTP id k126-v6mr2142809ith.166.1539283206262;
 Thu, 11 Oct 2018 11:40:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 11:39:45
 -0700 (PDT)
In-Reply-To: <CACT4Y+Yz=JPLGeGT+=8CpD-O2+9nL_UbZ9ptTSEcVoeg+YPTJQ@mail.gmail.com>
References: <000000000000c13ce50577db36cc@google.com> <073dedee-62df-9c67-1742-8de1e6c9502a@redhat.com>
 <CACT4Y+Yz=JPLGeGT+=8CpD-O2+9nL_UbZ9ptTSEcVoeg+YPTJQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Oct 2018 20:39:45 +0200
Message-ID: <CACT4Y+bWPwVkfKj+v0w5xCOsU1ZSMboW3mwr0eT5m+pOdv=c3A@mail.gmail.com>
Subject: Re: WARNING: refcount bug in kvm_vm_ioctl
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     syzbot <syzbot+6df4d24a0a50fd5d1a08@syzkaller.appspotmail.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 8:23 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Oct 11, 2018 at 4:17 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 10/10/2018 09:58, syzbot wrote:
>>>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>>>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
>>> RIP: 0010:refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
>>>  kvm_get_kvm arch/x86/kvm/../../../virt/kvm/kvm_main.c:766 [inline]
>>>  kvm_ioctl_create_device arch/x86/kvm/../../../virt/kvm/kvm_main.c:2924
>>>  kvm_vm_ioctl+0xed7/0x1d40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3114
>>>  vfs_ioctl fs/ioctl.c:46 [inline]
>>>  file_ioctl fs/ioctl.c:501 [inline]
>>>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>>>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>>>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>>>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>>>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> The trace here is fairly simple, but I don't understand how this could
>> happen.
>>
>> The kvm_get_kvm is done within kvm_ioctl_create_device, which is called
>> from ioctl; the last reference cannot disappear inside a ioctl, because:
>>
>> 1) kvm_ioctl is called from vfs_ioctl, which does fdget and holds the fd
>> reference until after kvm_vm_ioctl returns
>>
>> 2) the file descriptor holds one reference to the struct kvm*, and this
>> reference is not released until kvm_vm_release is called by the last
>> fput (which could be fdput's call to fput if the process has exited in
>> the meanwhile)
>>
>> 3) for completeness, in case anon_inode_getfd fails, put_unused_fd will
>> not invoke the file descriptor's ->release callback (in this case
>> kvm_device_release).
>>
>> CCing some random people to get their opinion...
>>
>> Paolo
>>
>>> # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
>>> #{"threaded":true,"collide":true,"repeat":true,"procs":6,"sandbox":"none","fault_call":-1,"tun":true,"tmpdir":true,"cgroups":true,"netdev":true,"resetnet":true,"segv":true}
>>> r0 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000380)='/dev/kvm\x00', 0x0, 0x0)
>>> r1 = syz_open_dev$dspn(&(0x7f0000000100)='/dev/dsp#\x00', 0x3fe, 0x400)
>>> r2 = ioctl$KVM_CREATE_VM(r0, 0xae01, 0x0)
>>> perf_event_open(&(0x7f0000000040)={0x1, 0x70, 0x0, 0x0, 0x0, 0x0, 0x0, 0x50d}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
>>> mincore(&(0x7f0000ffc000/0x1000)=nil, 0x1000, &(0x7f00000003c0)=""/4096)
>>> setrlimit(0x0, &(0x7f0000000000))
>>> readahead(r1, 0x3, 0x9a6)
>>> ioctl$KVM_CREATE_DEVICE(r2, 0xc00caee0, &(0x7f00000002c0)={0x4})
>>> setsockopt$inet_sctp6_SCTP_FRAGMENT_INTERLEAVE(r1, 0x84, 0x12, &(0x7f00000001c0)=0x9, 0x4)
>
>
> Looking at crash rate and dates here:
> https://syzkaller.appspot.com/bug?id=2b9fab00a235b50a34adbc35adc236f7dbe490fd
> https://syzkaller.appspot.com/bug?id=d6e4dd59a9b708895738b9cc59e6bdcb3a43ff14
>
> It looks like something that reached upstream tree yesterday.
> However, there is one outliner: 2018/09/30 08:58. So either that one
> crash was something else, or syzkaller learned how to reproduce it
> more often...
> But maybe if you know some recent suspect patch that touched that
> area, that may be the easiest way to localize the bug.

I can't reproduce it locally qemu on top of 4.17.17 host kernel, at
least easily. What are the chances this is provoked by L0 kernel
(syzbot also runs in VMs)?
