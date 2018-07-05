Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A78DC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FA62401D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/gYHxB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FA62401D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeGEFdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:33:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45792 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeGEFdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:33:17 -0400
Received: by mail-pf0-f196.google.com with SMTP id y24-v6so4365657pfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hNy3y6hSoKtRxwz40g3WTllU2ikmvzQiZZfIMtePj0A=;
        b=S/gYHxB0NPPRQBpnqEy/gNgI0jp9OwEj+xkEDuaYKiAshAT5rQiY6rgXMDwe7SxxYn
         kkTSA/lQLrnWSkntnRhQ1BDKq1mohEvlIjGLsZXZ0FUP3asyiszI7kqUnxSQJCp0SN/y
         5kGYDTocBaPDuvTD1eOQmxe1NybMCvd6R2cZ2/2oJ97QECpUJmWJg8Q68CjMD33xVm/C
         omx109B/npn+O+GzHs7j4FkaIF/7eI12g39lDT+1xLDbypt4k4FGWK0QAqYZ80b+dqp5
         HHpM07MCKnfMCiyIrNMxeiK1jEoC6gPmspQHmNb41ERtb8XRA4Dw6X4WqapPtxH/Ybni
         nl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hNy3y6hSoKtRxwz40g3WTllU2ikmvzQiZZfIMtePj0A=;
        b=VzdwZgz9FCVrsfhhq8yIQb943lQkVDo70ytHb5otiRi95yKA9jnQQhILEuTiJQbRXL
         IR7lLNJV3YTUOewgPj1FnjGg9AmDgrCvEUW2OELVARUB2hSm+tSbtv0n/Wab8TWTDDLK
         YqzspvhPEMn1kClHuKSpi3jwQEAuYjlWHgH0BVZA6VTOHIUGIUr/qLi2c08qwAoOhRR0
         m+T6s/au1Yuliv1FwSFLRzoJBBNUAudaMQng63xpOUybdNiEV2w8PLoDq8Zv7qBtSJQe
         CDUVVVpsBUWlXuAYtWNr/UrBPMkVwhwb/mm96dcCXkzLs73xiHVlLalFHkEJcZGzd1UR
         6VAg==
X-Gm-Message-State: APt69E0uROElA6GGUtF/25wKgr5SQ4Ogbte/KPx5bk60KaPJCtbvzLKY
        0vtKslWaAfNuMfJkHaxAG3HL/NBtmCkqFXTFYJE89g==
X-Google-Smtp-Source: AAOMgpc081AtAZUp1bIwV0eksQQaKYApaUvwjWnmk31ogyg1BqQcI343ePGJBiGv8ZlPUfWqms3mgcPseHXDHOkaLm8=
X-Received: by 2002:a63:501c:: with SMTP id e28-v6mr4251197pgb.114.1530768796288;
 Wed, 04 Jul 2018 22:33:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 4 Jul 2018 22:32:55
 -0700 (PDT)
In-Reply-To: <1530732704.23804.8.camel@amazon.de>
References: <883d24f79ad8fd475f0569a39ba6@google.com> <00000000000037b58a0569c49b70@google.com>
 <CACT4Y+bnUNtn3jO5fYMB5dSqA=vbc8KfnTmbajA6SYKex4KFoQ@mail.gmail.com>
 <CALMp9eSDP3XRMU-ZvSPRqgyQrtOCajz90HyQ8GM7Mg2oNuBAHw@mail.gmail.com>
 <1530346163.13559.75.camel@amazon.de> <1530732704.23804.8.camel@amazon.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Jul 2018 07:32:55 +0200
Message-ID: <CACT4Y+a86Of9E2oUus=pQKJuhjVEjZ7sFGUsJ=Y31zpae8fE-Q@mail.gmail.com>
Subject: Re: general protection fault in vmx_vcpu_run
To:     "Raslan, KarimAllah" <karahmed@amazon.de>
Cc:     "jmattson@google.com" <jmattson@google.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "syzbot+cc483201a3c6436d3550@syzkaller.appspotmail.com" 
        <syzbot+cc483201a3c6436d3550@syzkaller.appspotmail.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 9:31 PM, Raslan, KarimAllah <karahmed@amazon.de> wrote:
> Dmitry,
>
> Can you share the host kernel version?
>
> I can not reproduce any of these crash signatures and I think it's
> really a nested virtualization bug. So I will need the exact host
> kernel version as well.
>
> I am currently getting all sorts of:
>
> "KVM: entry failed, hardware error 0x7"
>
> ... instead of the crash signatures that you are posting.


Hi Raslan,

The tested kernel runs as GCE VM.
Jim, how can we describe the host kernel for GCE? Potentially only we
can debug this.


> On Sat, 2018-06-30 at 08:09 +0000, Raslan, KarimAllah wrote:
>> Looking also at the other crash [0]:
>>
>>         msr_bitmap = to_vmx(vcpu)->loaded_vmcs->msr_bitmap;
>> ffffffff811f65b7:       e8 44 cb 57 00          callq  ffffffff81773100
>> <__sanitizer_cov_trace_pc>
>> ffffffff811f65bc:       48 8b 54 24 08          mov    0x8(%rsp),%rdx
>> ffffffff811f65c1:       48 b8 00 00 00 00 00    movabs
>> $0xdffffc0000000000,%rax
>> ffffffff811f65c8:       fc ff df
>> ffffffff811f65cb:       48 c1 ea 03             shr    $0x3,%rdx
>> ffffffff811f65cf:       80 3c 02
>> 00             cmpb   $0x0,(%rdx,%rax,1)        <- fault here.
>> ffffffff811f65d3:       0f 85 36 19 00 00       jne    ffffffff811f7f0f
>> <vmx_vcpu_run+0x236f>
>>
>> %rdx should contain a pointer to loaded_vmcs. It is directly loaded
>> from the stack [0x8(%rsp)]. This same stack location was just used
>> before the inlined assembly for VMRESUME/VMLAUNCH here:
>>
>>         vmx->__launched = vmx->loaded_vmcs->launched;
>> ffffffff811f639f:       e8 5c cd 57 00          callq  ffffffff81773100
>> <__sanitizer_cov_trace_pc>
>> ffffffff811f63a4:       48 8b 54 24 08          mov    0x8(%rsp),%rdx
>> ffffffff811f63a9:       48 b8 00 00 00 00 00    movabs
>> $0xdffffc0000000000,%rax
>> ffffffff811f63b0:       fc ff df
>> ffffffff811f63b3:       48 c1 ea 03             shr    $0x3,%rdx
>> ffffffff811f63b7:       80 3c 02
>> 00             cmpb   $0x0,(%rdx,%rax,1)        <- used here.
>>
>> ... and this stack location was never touched by anything in between!
>> So something must have corrupted the stack itself not really the
>> kvm_vc
>> pu struct.
>>
>> Obviously the inlined assembly block is using the stack as well, but I
>> can not see anything that would cause this corruption there.
>>
>> That being said, looking at the %rsp and %rbp values that are dumped
>> in the stack trace:
>>
>> RSP: ffff8801b7d7f380
>> RBP: ffff8801b8260140
>>
>> ... they are almost 4.8 MiB apart! Should not these two register be a
>> bit closer to each other? :)
>>
>> So 2 possibilities here:
>>
>> 1- %rsp is wrong
>>
>> That would explain why the loaded_vmcs was NULL. However, it is a bit
>> harder to understand how it became wrong! It should have been restored
>> during the VMEXIT from the HOST_RSP value in the VMCS!
>>
>> Is this a nested setup?
>>
>> 2- %rbp is wrong
>>
>> That would also explain why the loaded_vmcs was NULL. Whatever
>> corrupted the stack that caused loaded_vmcs to be NULL could have also
>> corrupted the %rbp saved in the stack. That would mean that it happened
>> during a function call. All function calls that happened between the
>> point when the stack was sane (just before the "asm" block for
>> VMLAUNCH) and the crash-site are only kcov related. Looking at kcov, I
>> can not see where the stack would get corrupted though! Obviously
>> another source of corruption can be a completely unrelated thread
>> directly corruption this thread's memory.
>>
>> Maybe it would be easier to just try to repro it first and see which
>> one is true (if at all).
>>
>> [0] https://syzkaller.appspot.com/bug?extid=cc483201a3c6436d3550
>>
>>
>> On Thu, 2018-06-28 at 10:18 -0700, Jim Mattson wrote:
>> >
>> >   22: 0f 01 c3              vmresume
>> >   25: 48 89 4c 24 08        mov    %rcx,0x8(%rsp)
>> >   2a: 59                    pop    %rcx
>> >
>> > <rip>:
>> >   2b: 0f 96 81 88 56 00 00 setbe  0x5688(%rcx)
>> >   32: 48 89 81 00 03 00 00 mov    %rax,0x300(%rcx)
>> >   39: 48 89 99 18 03 00 00 mov    %rbx,0x318(%rcx)
>> >
>> > %rcx should be pointing to the vcpu_vmx structure, but it's not even
>> > canonical: 1ffff10035842e78.
>> >
> Amazon Development Center Germany GmbH
> Berlin - Dresden - Aachen
> main office: Krausenstr. 38, 10117 Berlin
> Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
> Ust-ID: DE289237879
> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
