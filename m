Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBF0C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886AF204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpMQoEkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886AF204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeJLBdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:33:43 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50764 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbeJLBdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:33:43 -0400
Received: by mail-it1-f196.google.com with SMTP id k206-v6so8789364ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6iv9pjJqyXxpCov0Aj33kLxYNeDF0PBwr+kZy2t85fg=;
        b=LpMQoEkzwLJPjFoonA0GJ/6/y3T9nrDNm4e0WZLYzDhyLmppY1Jz7xLPfi+BibpbTo
         4EH289WCp8ppjIU+10LTrrUiLVVoo6rqJkX/9umotGuZTr9hLz3WGl553ABL0J+tFXvB
         qTJgzNIpI0/U4deHJx0bfiBD2FRNHVlcEbvHR8Eu6A1xz9xOm4lvFJ5syeytgJpO4Vz/
         c+2clizhitBlAGc9LfPw1JAw2qlhzLgLKQJouwzAqvr0f1GQ/VjPS5OCawZ6uHq0chw0
         Qis+UFClVmCP5BjIxdGKV8Dd98OyO21omJHhP6sVYnAWSbg2uwzgNA3TLVTI07adlsrc
         ztXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6iv9pjJqyXxpCov0Aj33kLxYNeDF0PBwr+kZy2t85fg=;
        b=LMcAxAIDVnxSQw2ocFNspdqiT7CLtsJoGoHLVb+88aF+H4x6Nwg+36fjS3emsqcokq
         GXrUOyuX7SFhdeHqWzQyWqdJzzd6O7Eu5G+oaudk/JlQ/FZdissAS/YVAV6c1Mm2YzZ1
         /laZ5LeoFqiztsV6fVAf3IXetmnbz5Xi6FoLqJrczGhQmmYVOes/+fWNXPJar2isLZoR
         NNVvmX5bcWy7v6mjKAsF6ErXeWQwqf/ghITvub2qjE5rlElojUL43o+4pWgsFfqUtHFF
         oLH8YBC+/uApJEbDBUGnwtsF3omH+5NRNz7oSEdZQ+vL2JTfsBMNQzGfZsh4zV5C9wne
         ppnw==
X-Gm-Message-State: ABuFfohtkYFyxYwkf2WBbJFmkSJ6hWWdC01fKbm3GGVAJeZrGShClUCt
        obOnx8nCploqDsnfV9BmEXtCIflc2uuKO7yNvI2vCA==
X-Google-Smtp-Source: ACcGV60OS91obWHLMCkspt1Jt7avidRmFw6c8kjcz3EoKA92jt6SGRdbjgx9/zOXR0P1N9UdQf7Qnl67h6nd7bqca3M=
X-Received: by 2002:a24:24c9:: with SMTP id f192-v6mr1974518ita.144.1539281123327;
 Thu, 11 Oct 2018 11:05:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 11:05:02
 -0700 (PDT)
In-Reply-To: <44d8f927-85bb-cde5-1ddc-93da5ea048ae@redhat.com>
References: <0000000000004ab2c40577db2115@google.com> <c4d02cc1-0298-533d-bc07-bb4195c2eea9@huawei.com>
 <44d8f927-85bb-cde5-1ddc-93da5ea048ae@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Oct 2018 20:05:02 +0200
Message-ID: <CACT4Y+Y267HH=JXLJzwLOD4Q7A=ah39UwbeEA9wa_dR8NWNrnA@mail.gmail.com>
Subject: Re: kernel BUG at arch/x86/kvm/x86.c:LINE! (2)
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Du Changbin <duchangbin3@huawei.com>,
        syzbot <syzbot+f9b42efadea9f5453100@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>, changbin.du@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 4:32 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 11/10/2018 04:57, Du Changbin wrote:
>> I think the issue is that using vmx instructions after vmx off. The
>> scenario is:
>> 1. kernel is rebooting and vmx is turned off by notification handler
>> kvm_reboot(),
>>    and 'kvm_rebooting' is set.
>> 2. But there is a pending KVM_CREATE_VCPU ioctl which will invoke
>> vmcs_clear()->
>>    ____kvm_handle_fault_on_reboot()->kvm_spurious_fault()->BUG().
>>
>> Need to improve the handler for such case so won't hang kernel.
>
> Why would the kernel be rebooting, given the reproducer (listed below my
> signature, or at https://syzkaller.appspot.com/x/repro.c?x=131e37c9400000)?
>
> I think this is a duplicate of
>
>    WARNING: refcount bug in kvm_vm_ioctl
>    BUG: unable to handle kernel paging request in
> refcount_inc_not_zero_checked
>
> In all cases the refcounts seem to be broken, and kvm_destroy_kvm is
> called prematurely (which in this case results in hardware_disable_all
> being called, so that the vmclear fails).
>
> Dmitry, have such bugs been reported for subsystems other than KVM?

We have _all_ types of bugs reported in _all_ subsystems. So you need
to be more precise :)

You can see all currently open bugs here:
https://syzkaller.appspot.com/#upstream

And here you can search over reports:
https://groups.google.com/forum/#!forum/syzkaller-bugs

E.g.:
https://groups.google.com/forum/#!searchin/syzkaller-bugs/refcount_inc_not_zero_checked

We had this recently, which is task_struct refcount bug:
https://syzkaller.appspot.com/bug?id=e1854417677586ce3d00f498f19816cb4fd15676
but this seems to be related to rdma. And repro for this bug only
deals with kvm. So my guess would be that this is a different bug in
kvm.
If you can reproduce it, then perhaps logging all refcount operation
on the thing will help to find whoever releases a ref it does not own.


> Paolo
>
> #syz dup: WARNING: refcount bug in kvm_vm_ioctl
>
>> # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
>> #{"threaded":true,"repeat":true,"procs":6,"sandbox":"","fault_call":-1,"tmpdir":true}
>> r0 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000080)='/dev/kvm\x00', 0x0, 0x0)
>> r1 = ioctl$KVM_CREATE_VM(r0, 0xae01, 0x0)
>> r2 = ioctl$KVM_CREATE_VCPU(r1, 0xae41, 0x0)
>> ioctl$KVM_SET_VCPU_EVENTS(r2, 0x4040aea0, &(0x7f0000000000)={0x5, 0x7, 0x40, 0x0, 0x0, 0x0, 0x0, 0x492, 0x5, 0x1, 0xffff, 0x0, 0x0, 0xef, 0x100000000, 0x0, 0x100})
>> ioctl$KVM_SET_USER_MEMORY_REGION(r1, 0x4020ae46, &(0x7f0000000040)={0x0, 0x0, 0x0, 0x2000, &(0x7f0000ffe000/0x2000)=nil})
>> ioctl$KVM_SET_SREGS(r2, 0x4138ae84, &(0x7f00000003c0)={{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, 0x8005001f, 0x0, 0x0, 0x28, 0x0, 0x6500})
>> ioctl$KVM_RUN(r2, 0xae80, 0x0)
