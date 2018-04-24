Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3120174-1524577678-2-5317966639135530894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524577677; b=RYACxg7vVROfUstLK49D6sSi2UzZfZ5V7bVq2O+KqZA8HqK4Pk
    ztkf5s8f8ElJyudRVAYS0pBabKNvNygSmAI10JN+3XB+As6wo2YppCzVz/h7JwY3
    NmcYDVa9730x2cbEHlXahenHAxAO59O8tkDonuUfCwOTaLAcgc/fL7IjTMpa3Ckm
    DJgUHrsHr0mk84WjYzn32fFOWkUH2gIpMTrNtYEaCbXbgrNcbi56pyw9LBO2vVGX
    qKMvv4d+U9T2kc9cgK8LE53o/Oc+164290NBBStSYhQrkZu4vR8QQHQiNxP+b6+0
    r1qo+taQMBbwaQH5N02nfDy1e4zvG8kurQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:reply-to:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type
    :sender:list-id; s=fm2; t=1524577677; bh=8uPyzpXfY1BoQbPsDxTDeUz
    K+Ac6Nx2grc9lblM0Uuo=; b=R56ClnwVbMEuSCLHwDoN0Imm+g2HNj4DAJ8YUw1
    0hKx9nwuU6M/ybuCqBfh1NuTc9+VYtOg4CFpT/ZgOR6uPsbTMw7wFV2DA55QS1n8
    iAG/0tIX9XlZpTVZVJaaLK4mjVgHce7U5GdFVavdLnu4Rbtox7YuVmCAmZeVXk6l
    3ScsblO2apwr8zvutrRcsiKH3EJbglz38Ks2FaBCTFZzj++SdY00sRO+KvZXMX+J
    jVE/3tpuy4gcHMPhCJ0wRV4i9uIbg3qX9UY61pX2grEePPey0tR7wliXpe4oQArl
    ziaVg/3ON9rLvjWYogZX3jw5lnsTg3Ua9UdJmuhfYXxN2pQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ngg5Bujk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=isXehpGc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ngg5Bujk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=isXehpGc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPvjvxRcTPtX1yd1/Uy7GeZmP+YxkW54N8Xp2uKZHjyxpsKr3R7Y+flgk3NSXWNF4U6tPsHVjehiSH8jCM719DyfCRuPv3HSmueyb2N2WW/wqNjluZJn
    iYBeFyilnD7ql5bLDvtK/0NJYqd+/cRtlvdRvxr7EmUgVNHX2EwT4i8RH97B4KFSpLllSkvqx3X2LkS7P3wM+JEM8biN0XntSnywY6YDtzOWPjyxY/bfmzQO
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IzEFBFVBfwYA:10 a=IkcTkHD0fZMA:10
    a=x7bEGLp0ZPQA:10 a=Qtx8U6EcU7sA:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8
    a=Z4Rwk6OoAAAA:8 a=Twlkf-z8AAAA:8 a=gu6fZOg2AAAA:8 a=NEAV23lmAAAA:8
    a=VwQbUJbxAAAA:8 a=dkiO8vEnA_QhHKtsUDcA:9 a=QEXdDO2ut3YA:10 a=mFt2QXyYVLUA:10
    a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=-74SuR6ZdpOK_LpdRCUo:22 a=2RSlZUUhi9gRBrsHwhhZ:22
    a=AjGcO6oz07-iQ99wixmX:22 a=4riroR3Ex10hVRXakXrT:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758193AbeDXNrb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 09:47:31 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33154 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758152AbeDXNq4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 24 Apr 2018 09:46:56 -0400
X-Google-Smtp-Source: AIpwx4/F8Y5M7YXIvDdP/friE5Gvwi0HRs6wNkCtc+MpkmVDED9UOAn9JcO9KPwIVK+ZkkTGTzVWLT+fgjG6ZoYS1IA=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CA+icZUUvV0wLs4795zZz3AxG1ccHaCNwhU1nYQu-DTpohVEMPQ@mail.gmail.com>
References: <CA+icZUUvV0wLs4795zZz3AxG1ccHaCNwhU1nYQu-DTpohVEMPQ@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 24 Apr 2018 15:46:53 +0200
Message-ID: <CA+icZUXo4THf+fcx6wC_Q45p=_e1xpj=pFwNBjeoO1iQVb8YNA@mail.gmail.com>
Subject: Re: Clang and X86-EFlags (was Re: [PATCH] usbhid: Fix lockdep
 unannotated irqs-off warning)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        David Laight <David.Laight@aculab.com>,
        Jiri Kosina <jikos@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Hordijk <hoffbrinkle@hotmail.com>, chandlerc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 3:28 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Mon, Jun 27, 2016 at 10:14 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Mon, Jun 27, 2016 at 12:50 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>
>>> $ objdump -S clang-eflag.o
>>>
>>> clang-eflag.o:     file format elf64-x86-64
>>>
>>>
>>> Disassembly of section .text:
>>>
>>> 0000000000000000 <bar>:
>>>    0:   55                      push   %rbp
>>>    1:   48 89 e5                mov    %rsp,%rbp
>>>    4:   53                      push   %rbx
>>>    5:   50                      push   %rax
>>>    6:   e8 00 00 00 00          callq  b <bar+0xb>
>>>    b:   ff 0d 00 00 00 00       decl   0x0(%rip)        # 11 <bar+0x11>
>>>   11:   9c                      pushfq
>>>   12:   5b                      pop    %rbx
>>>   13:   e8 00 00 00 00          callq  18 <bar+0x18>
>>>   18:   b8 01 00 00 00          mov    $0x1,%eax
>>>   1d:   53                      push   %rbx
>>>   1e:   9d                      popfq
>>>   1f:   75 07                   jne    28 <bar+0x28>
>>
>>
>> Yeah, the above is pure garbage.
>>
>>> So, the issue is still alive.
>>>
>>> What do you mean by "for the kernel we at a minimum need a way to
>>> disable that code generation"?
>>> Can this be fixed in the Linux-kernel?
>>
>> No. This will never be fixed in the kernel. It's a compiler bug.
>>
>> The compiler generates shit code. It's absolutely atrociously bad even
>> if you ignore any kernel issues, because that kind of code just
>> performs badly (the compiler should have used "setcc" or something
>> similar to just set the comparison value, not save and restore eflags.
>>
>> And quite frankly, any compiler writer that thinks it is good code is
>> not somebody I want touching a compiler that the kernel depends on
>> anyway.
>>
>> But it is not just bad code for the kernel, it's actively buggy code,
>> since it corrupts the IF.
>>
>> Until this gets fixed in LLVM, there's no way in hell that we will
>> ever have a kernel compiled with that piece of shit.
>>
>> Really. If the LLVM developers cannot fix their crap code generation,
>> it's not worth touching that shit with a ten-foot pole.
>>
>> I'd love to be able to compile the kernel with LLVM, but the fact that
>> the broken eflags code apparently _still_ hasn't been fixed makes me
>> just go "not worth it".
>>
>> And if the LLVM developers don't see this as an obvious bug, it's even
>> less worth it - because that shows not just that the compiler is
>> broken, but that the developers involved with it are broken too.
>>
>>                   Linus
>
> [ Changed Subject ]
> [ CC Matthias ]
> [ CC Michael test-case ]
> [ CC Chandler ]
>
> Hi Linus,
>
> Matthias pointed me in [0] to [1] in the LLVM-BTS.
>
> ...and I tried again the test-case from Michael from [3] "[LLVMdev]
> optimizer clobber EFLAGS"...
>
> ...with clang-7 (version:
> 7~svn330207-1~exp1+0~20180417201234.1709~1.gbp6fb10d) from
> <https://apt.llvm.org/>.
>
> [ TEST-CASE ]
>
> [ clang-eflag.c ]
> #include <stdlib.h>
> #include <stdbool.h>
>
> void foo(void);
> int a;
>
> int bar(void)
> {
>          foo();
>
>          bool const zero = a -= 1;
>
>          asm volatile ("" : : : "cc");
>          foo();
>
>          if (zero) {
>                  return EXIT_FAILURE;
>          }
>
>          foo();
>
>          return EXIT_SUCCESS;
> }
> - EOF -
>
> $ clang-7 -O2 -c -o clang-eflag.o clang-eflag.c
>
> [ OBJDUMP ]
>
> $ objdump -S clang-eflag.o
>
> clang-eflag.o:     file format elf64-x86-64
>
>
> Disassembly of section .text:
>
> 0000000000000000 <bar>:
>    0:   53                      push   %rbx
>    1:   e8 00 00 00 00          callq  6 <bar+0x6>
>    6:   83 05 00 00 00 00 ff    addl   $0xffffffff,0x0(%rip)        #
> d <bar+0xd>
>    d:   0f 95 c3                setne  %bl
>   10:   e8 00 00 00 00          callq  15 <bar+0x15>
>   15:   b8 01 00 00 00          mov    $0x1,%eax
>   1a:   f6 c3 ff                test   $0xff,%bl
>   1d:   74 02                   je     21 <bar+0x21>
>   1f:   5b                      pop    %rbx
>   20:   c3                      retq
>   21:   e8 00 00 00 00          callq  26 <bar+0x26>
>   26:   31 c0                   xor    %eax,%eax
>   28:   5b                      pop    %rbx
>   29:   c3                      retq
>
> Does this now look good?
>
> Thanks.
>
> Kind regards,
> - Sedat -
>
> [0] https://marc.info/?l=linux-kernel&m=152450535720279&w=2
> [1] https://bugs.llvm.org/show_bug.cgi?id=36028
> [2] http://lists.llvm.org/pipermail/llvm-dev/2015-July/088766.html
> [3] https://marc.info/?l=linux-kernel&m=152457089205170&w=2

For the sake of completeness the two fixes in LLVM upstream.

>From [4]:

Chandler Carruth 2018-04-09 23:41:58 PDT

This should finally be resolved in its entirety with r329657 (and r329673).

"[x86] Introduce a pass to begin more systematically fixing PR36028
and similar issues"
https://github.com/llvm-mirror/llvm/commit/21a0c18174343502c9f2b546a01333d1c351d9c0
svn -r329657

"[x86] Model the direction flag (DF) separately from the rest of EFLAGS."
https://github.com/llvm-mirror/llvm/commit/9f8f7c5e8ab12afcc92f51d0ed596ac0867eb0fa
svn-r329673

- Sedat -

[4] https://bugs.llvm.org/show_bug.cgi?id=36028#c2
