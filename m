Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F82AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E942087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XsZMoIKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E942087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeJKWpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:45:33 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39950 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbeJKWpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:45:33 -0400
Received: by mail-it1-f195.google.com with SMTP id i191-v6so13705306iti.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrR0pJitVRPOfkbOsDjuzimhHomks2pZIbrrpQ2iMM8=;
        b=XsZMoIKGSY/upkqiLcF6FWvO0uecXXQpfemBfykwjGnYLEE1VQBJX1vzUP5M7rG1L7
         ziZDu1uSV4k/PefJA2aBKLFbh55IRqwAKKDM1Ysd903Hfd7kuifAmO+P9MBvR6qDl1rd
         cFF6uCJ0sjzHDDyIyF0eqKoTJ74TIVj0WW1HwUxXsgAw/gvxeDaSkK+exNMCjOgeahMF
         nfGb0vWDDxfargc1wMEG4WZaUAdk0LUJAWmXbFEw+bCO3V6Ctvme+oalEinBzMCoDt2O
         Ju6jkzUPSTx/unZ4jI60JujleX6iU82Vj2D01H+yUKuqKPOYO84hX6s7CE2THiUE1lJo
         EbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrR0pJitVRPOfkbOsDjuzimhHomks2pZIbrrpQ2iMM8=;
        b=P8F4kVpe6TbaUvh5e8NJ6jW/S4ErB/rx1fwHJH3RJ1okUShLbXqX4V5JUKVU52WNAo
         cWRtSs4xj3CYdPNPvlfQimhg+S/CTglHY8IZK5d97BqSMeK3+ZiPdgL6YKluy3z60kZY
         iXUuBYWbHfpkcvZygfblA1/jIzryUbGozggWDy5U8fpLm/XRnzlIL19hdkI55PhNfa5h
         BMSEv83OOlTweyD8slkrwOAFrdUa9EaHZDbDJRTJFzwnSJBMfVjoiG5q6YKh2K1N/IfA
         lFqFzkYu0CdYBmch7PkW89iRl+IsU2p4Dr6P3HBYpfPfxottQO/i6G+zrIq3z9YHY4l2
         URQA==
X-Gm-Message-State: ABuFfoh+X865+tDAqJK1pHDtQRZiMk36qPvolOpaegiiHJpbrHbReQLA
        4JHsC+JfYpt+gRfJDY1I2gsxOwJFk1AdHYdhiu8FMg==
X-Google-Smtp-Source: ACcGV62AmTl1txtTR8+xB1t5K5PCD+PBHwI/w+I006ZyD6gibKLMuIvTRnDwuIaDxVqhapPOkwiOS/zPVVh0JwAcOwY=
X-Received: by 2002:a02:6c15:: with SMTP id w21-v6mr1676181jab.132.1539271075591;
 Thu, 11 Oct 2018 08:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181011003336.168941-1-edumazet@google.com> <20181011073133.GZ5663@hirez.programming.kicks-ass.net>
In-Reply-To: <20181011073133.GZ5663@hirez.programming.kicks-ass.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 11 Oct 2018 08:17:44 -0700
Message-ID: <CANn89iJFXfwFDm8x1ukfk=HL2rxMYEz5MCcCzrs0TfJ56QbBNA@mail.gmail.com>
Subject: Re: [PATCH] x86/tsc: use real seqcount_latch in cyc2ns_read_begin()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 12:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 10, 2018 at 05:33:36PM -0700, Eric Dumazet wrote:
> > While looking at native_sched_clock() disassembly I had
> > the surprise to see the compiler (gcc 7.3 here) had
> > optimized out the loop, meaning the code is broken.
> >
> > Using the documented and approved API not only fixes the bug,
> > it also makes the code more readable.
> >
> > Replacing five this_cpu_read() by one this_cpu_ptr() makes
> > the generated code smaller.
>
> Does not for me, that is, the resulting asm is actually larger

[resent in non html]

I counted the number of bytes of text, and really the after my patch
code size is smaller.

%gs prefixes are one-byte, but the 32bit offsets are adding up.

Prior version (with resinstaed loop, thanks to one  smp_rmb()

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index b52bd2b6cdb443ba0c89d78aaa52b02b82a10b6e..d4ad30bbaa0cc8bf81da0272829da26f229734bf
100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -71,7 +71,7 @@ void cyc2ns_read_begin(struct cyc2ns_data *data)
  data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
  data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
  data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
-
+ smp_rmb();
  } while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
 }


Total length : 0xA7 bytes

00000000000002a0 <native_sched_clock>:
     2a0: 4c 8d 54 24 08        lea    0x8(%rsp),%r10
     2a5: 48 83 e4 f0          and    $0xfffffffffffffff0,%rsp
     2a9: 41 ff 72 f8          pushq  -0x8(%r10)
     2ad: 55                    push   %rbp
     2ae: 48 89 e5              mov    %rsp,%rbp
     2b1: 41 52                push   %r10
     2b3: e9 60 00 00 00        jmpq   318 <native_sched_clock+0x78>
     2b8: 0f 31                rdtsc
     2ba: 48 c1 e2 20          shl    $0x20,%rdx
     2be: 48 09 c2              or     %rax,%rdx
     2c1: 49 89 d2              mov    %rdx,%r10
     2c4: 49 c7 c1 00 00 00 00 mov    $0x0,%r9
2c7: R_X86_64_32S .data..percpu..shared_aligned
     2cb: 65 8b 05 00 00 00 00 mov    %gs:0x0(%rip),%eax        # 2d2
<native_sched_clock+0x32>
2ce: R_X86_64_PC32 .data..percpu..shared_aligned+0x1c
     2d2: 89 c1                mov    %eax,%ecx
     2d4: 83 e1 01              and    $0x1,%ecx
     2d7: 48 c1 e1 04          shl    $0x4,%rcx
     2db: 4c 01 c9              add    %r9,%rcx
     2de: 65 48 8b 79 08        mov    %gs:0x8(%rcx),%rdi
     2e3: 65 8b 31              mov    %gs:(%rcx),%esi
     2e6: 65 8b 49 04          mov    %gs:0x4(%rcx),%ecx
     2ea: 65 44 8b 05 00 00 00 mov    %gs:0x0(%rip),%r8d        # 2f2
<native_sched_clock+0x52>
     2f1: 00
2ee: R_X86_64_PC32 .data..percpu..shared_aligned+0x1c
     2f2: 44 39 c0              cmp    %r8d,%eax
     2f5: 75 d4                jne    2cb <native_sched_clock+0x2b>
     2f7: 89 f6                mov    %esi,%esi
     2f9: 48 89 f0              mov    %rsi,%rax
     2fc: 49 f7 e2              mul    %r10
     2ff: 48 0f ad d0          shrd   %cl,%rdx,%rax
     303: 48 d3 ea              shr    %cl,%rdx
     306: f6 c1 40              test   $0x40,%cl
     309: 48 0f 45 c2          cmovne %rdx,%rax
     30d: 48 01 f8              add    %rdi,%rax
     310: 41 5a                pop    %r10
     312: 5d                    pop    %rbp
     313: 49 8d 62 f8          lea    -0x8(%r10),%rsp
     317: c3                    retq
     318: 48 69 05 00 00 00 00 imul   $0x3d0900,0x0(%rip),%rax
# 323 <native_sched_clock+0x83>
     31f: 00 09 3d 00
31b: R_X86_64_PC32 jiffies_64-0x8
     323: 41 5a                pop    %r10
     325: 48 ba 00 b8 64 d9 45 movabs $0xffc2f745d964b800,%rdx
     32c: f7 c2 ff
     32f: 5d                    pop    %rbp
     330: 49 8d 62 f8          lea    -0x8(%r10),%rsp
     334: 48 01 d0              add    %rdx,%rax
     337: c3                    retq

New version (my cleanup patch)

Total length = 0x91 bytes

00000000000002a0 <native_sched_clock>:
     2a0: 4c 8d 54 24 08        lea    0x8(%rsp),%r10
     2a5: 48 83 e4 f0          and    $0xfffffffffffffff0,%rsp
     2a9: 41 ff 72 f8          pushq  -0x8(%r10)
     2ad: 55                    push   %rbp
     2ae: 48 89 e5              mov    %rsp,%rbp
     2b1: 41 52                push   %r10
     2b3: e9 59 00 00 00        jmpq   311 <native_sched_clock+0x71>
     2b8: 0f 31                rdtsc
     2ba: 48 c1 e2 20          shl    $0x20,%rdx
     2be: 48 09 c2              or     %rax,%rdx
     2c1: 49 89 d1              mov    %rdx,%r9
     2c4: 49 c7 c0 00 00 00 00 mov    $0x0,%r8
2c7: R_X86_64_32S .data..percpu..shared_aligned
     2cb: 65 4c 03 05 00 00 00 add    %gs:0x0(%rip),%r8        # 2d3
<native_sched_clock+0x33>
     2d2: 00
2cf: R_X86_64_PC32 this_cpu_off-0x4
     2d3: 41 8b 40 20          mov    0x20(%r8),%eax
     2d7: 89 c6                mov    %eax,%esi
     2d9: 83 e6 01              and    $0x1,%esi
     2dc: 48 c1 e6 04          shl    $0x4,%rsi
     2e0: 4c 01 c6              add    %r8,%rsi
     2e3: 8b 3e                mov    (%rsi),%edi
     2e5: 8b 4e 04              mov    0x4(%rsi),%ecx
     2e8: 48 8b 76 08          mov    0x8(%rsi),%rsi
     2ec: 41 3b 40 20          cmp    0x20(%r8),%eax
     2f0: 75 e1                jne    2d3 <native_sched_clock+0x33>
     2f2: 48 89 f8              mov    %rdi,%rax
     2f5: 49 f7 e1              mul    %r9
     2f8: 48 0f ad d0          shrd   %cl,%rdx,%rax
     2fc: 48 d3 ea              shr    %cl,%rdx
     2ff: f6 c1 40              test   $0x40,%cl
     302: 48 0f 45 c2          cmovne %rdx,%rax
     306: 48 01 f0              add    %rsi,%rax
     309: 41 5a                pop    %r10
     30b: 5d                    pop    %rbp
     30c: 49 8d 62 f8          lea    -0x8(%r10),%rsp
     310: c3                    retq
     311: 48 69 05 00 00 00 00 imul   $0x3d0900,0x0(%rip),%rax
# 31c <native_sched_clock+0x7c>
     318: 00 09 3d 00
314: R_X86_64_PC32 jiffies_64-0x8
     31c: 41 5a                pop    %r10
     31e: 48 ba 00 b8 64 d9 45 movabs $0xffc2f745d964b800,%rdx
     325: f7 c2 ff
     328: 5d                    pop    %rbp
     329: 49 8d 62 f8          lea    -0x8(%r10),%rsp
     32d: 48 01 d0              add    %rdx,%rax
     330: c3                    retq
     331:
