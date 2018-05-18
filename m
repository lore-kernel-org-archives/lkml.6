Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-463584-1526685052-2-1034496261939865269
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526685051; b=HOJhTRufLQaAjCFVAaa9co5eC6z0KisVxyiYlltlQb7bf3KcSG
    DNeQnkx/cQ26vrYSUeGnFGIPES+IEYeCQHtQaiU84zfl632bHG2GpLVIQQzj1Kbo
    Xl3tEGBen1nWNSDKbiocinogdTcrl+0bJpr83QgbCtfpVu88zA/vhUukhjEs0yzU
    C8VWYbi5bXlYB3sqxlvjTpEU4O1AnCz6JAztp9oRQTz9o2IR2txroxONOESgo1NZ
    0BEyXOuPCTHFlbcOhe5B4NUuQrgTnkNyWFfFaJ58aRATXG0nMqv3BARcUFWCR26L
    xMQuPUsofOUA8NuifzxPwXqbwEcXEU4yxEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526685051; bh=FRmxXNhoRlPv6+Qm1bRTxdRla2J8CWyc2jwf5Yq/LH
    E=; b=iMryOnc9dxIINVHzxnxQBrwMC9ULK3BllbH4QSK80Zz0+neHHhhEklAYQ5
    nokH5QlSukG3Skw9VBxxRnUtFdL35PkcOjymH25DBpN09pE5H3EGi0ZSTn8CUSjn
    GdQreEikBeSUnZsdKYxLryvDWvcGGvrspcyAAA7P5nS1bBhs9k8ykXey4lwMDkzl
    VwcEvk5uEdff2WJiEVxprKVPqzpiZdeJhxnyLqRy5U6F3KuMo78HJoMt1e5WPExU
    fgedF4YghCZU5EEJXKVSsdZN+sm1bx7ZnSNkIGQlILr36uJS6YAZbV2DTAF0JKn6
    4P4HdmBoCqzaVBHprze7PQBj1NUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=miWuirkl x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Qk4d7D/E;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=miWuirkl x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Qk4d7D/E;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIA4asi4d56GFIIlITofEb8xjW1KfwJRzKLehSBpg1BfbuNHwGMVv2XSyQZc/cPq72+0x+bEqwp8G7XSnkpSClhbrexYmFtsDXlZ1tvbjyYoR3IMrv58
    LWZFG/4+bECfNHy8QjIC27ZQqbj6l9ad6w4caVi0vEG/gahzfSrs24j5+ReDlvOr/sV0j18LNUwBDO8dwJZRmB91hgs/fFXotLDrDQHU1exCaBjmqkg187sq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=wijiZ99obDcA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=n2GhSfulAAAA:8
    a=AyX_f8N32-jFFo2C9FsA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=9NqWk_7B-uqI6kdQTXIl:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeERXKt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 19:10:49 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38228 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbeERXKr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 19:10:47 -0400
X-Google-Smtp-Source: AB8JxZozx8xmaED50bwzR9OCZui+t+Mu61byMjC3ZIpw64/HCwsvL9kF2tFn9u3FYD+9oDLYgZewmF/C7Ghscli8/yQ=
MIME-Version: 1.0
In-Reply-To: <CALCETrUDX=4FHU0e8SZ9Rr_AnAes+5jjzKCrrVmS1mddHQyeVQ@mail.gmail.com>
References: <20180517233510.24996-1-dima@arista.com> <1526600442.28243.39.camel@arista.com>
 <CALCETrUDX=4FHU0e8SZ9Rr_AnAes+5jjzKCrrVmS1mddHQyeVQ@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 19 May 2018 00:10:26 +0100
Message-ID: <CAJwJo6ZwEZiQYDQqLkfP0+mRgmc+X=H02M=fFZZykWN4A3s-FQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Drop TS_COMPAT on 64-bit exec() syscall
To: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>, izbyshev@ispras.ru,
        Alexander Monakov <amonakov@ispras.ru>,
        Borislav Petkov <bp@suse.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andy,

2018-05-18 23:03 GMT+01:00 Andy Lutomirski <luto@kernel.org>:
> On Thu, May 17, 2018 at 4:40 PM Dmitry Safonov <dima@arista.com> wrote:
>> Some selftests are failing, but the same way as before the patch
>> (ITOW, it's not regression):
>> [root@localhost self]# grep FAIL out
>> [FAIL]  Reg 1 mismatch: requested 0x0; got 0x3
>> [FAIL]  Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
>> 0xffffff425aadc0de
>> [FAIL]  Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
>> 0xffffff425aadc0de
>> [FAIL]  Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
>> 0xffffff425aadc0de
>
> Are you on AMD?  Can you try this patch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=c88aa6d53840e48970c54f9ef70c79415033b32d
>
> and give me a Tested-by if it fixes it for you?

Sure.
I'm on Intel actually:
cpu family    : 6
model        : 142
model name    : Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz

But I usually test kernels in VM. So, I use virt-manager as it's
easier to manage
multiple VMs. The thing is that I've chosen "Copy host CPU configuration"
and for some reason, I don't quite follow virt-manager makes model "Opteron_G4".
I'm on Fedora 27, virt-manager 1.4.3, qemu 2.9.1(qemu-2.9.1-2.fc26).
So, cpuinfo in VM says:
cpu family    : 21
model        : 1
model name    : AMD Opteron 62xx class CPU

What's worse than registers changes is that some selftests actually lead to
Oops's. The same reason for criu-ia32 fails.
I've tested so far v4.15 and v4.16 releases besides master (2c71d338bef2),
so it looks to be not a recent regression.

Full Oopses:
[  189.100174] BUG: unable to handle kernel paging request at 00000000417bafe8
[  189.100174] PGD 69ed4067 P4D 69ed4067 PUD 707fc067 PMD 6c535067 PTE 6991f067
[  189.100174] Oops: 0001 [#3] SMP NOPTI
[  189.100174] Modules linked in:
[  189.100174] CPU: 0 PID: 2443 Comm: sysret_ss_attrs Tainted: G
D           4.17.0-rc5+ #11
[  189.103187] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1.fc26 04/01/2014
[  189.103187] RIP: 0033:0x40085a
[  189.103187] RSP: 002b:00000000417bafe8 EFLAGS: 00000206
[  189.103187] RAX: 0000000000000000 RBX: 00000000000003e8 RCX: 0000000000000000
[  189.103187] RDX: 0000000000000000 RSI: 0000000000400830 RDI: 00000000417baff8
[  189.103187] RBP: 00000000417baff8 R08: 0000000000000000 R09: 0000000000000077
[  189.103187] R10: 0000000000000006 R11: 0000000000000000 R12: 00000000417ba000
[  189.103187] R13: 00007ffc05207840 R14: 0000000000000000 R15: 0000000000000000
[  189.103187] FS:  00007f98566ecb40(0000) GS:ffff9740ffc00000(0000)
knlGS:0000000000000000
[  189.103187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  189.103187] CR2: 00000000417bafe8 CR3: 0000000069dc4000 CR4: 00000000007406f0
[  189.103187] PKRU: 55555554
[  189.103187] RIP: 0x40085a RSP: 00000000417bafe8
[  189.103187] CR2: 00000000417bafe8
[  189.103187] ---[ end trace 8878c9a088d5f296 ]---
Killed
[  219.366814] BUG: unable to handle kernel paging request at 00000000ffd2874c
[  219.367040] PGD 69fbf067 P4D 69fbf067 PUD 69fa5067 PMD 69fa4067 PTE 6cb04067
[  219.367040] Oops: 0001 [#4] SMP NOPTI
[  219.367040] Modules linked in:
[  219.367040] CPU: 1 PID: 2497 Comm: test_syscall_vd Tainted: G
D           4.17.0-rc5+ #11
[  219.367040] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1.fc26 04/01/2014
[  219.367040] RIP: 0033:0x8048e9d
[  219.367040] RSP: 002b:00000000ffd2874c EFLAGS: 00000202
[  219.367040] RAX: 0000000008048778 RBX: 0000000000000000 RCX: 000000000000003f
[  219.367040] RDX: 0000000000000001 RSI: 00000000f7ff7b80 RDI: 0000000000000000
[  219.367040] RBP: 00000000ffd287c8 R08: 7f7f7f7f7f7f7f7f R09: 7f7f7f7f7f7f7f80
[  219.367040] R10: 7f7f7f7f7f7f7f81 R11: 7f7f7f7f7f7f7f82 R12: 7f7f7f7f7f7f7f83
[  219.367040] R13: 7f7f7f7f7f7f7f84 R14: 7f7f7f7f7f7f7f85 R15: 7f7f7f7f7f7f7f86
[  219.367040] FS:  0000000000000000(0000) GS:ffff9740ffd00000(0063)
knlGS:00000000f7fc6700
[  219.367040] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  219.367040] CR2: 00000000ffd2874c CR3: 000000006c4ca000 CR4: 00000000007406e0
[  219.367040] PKRU: 55555554
[  219.367040] RIP: 0x8048e9d RSP: 00000000ffd2874c
[  219.367040] CR2: 00000000ffd2874c
[  219.367040] ---[ end trace 8878c9a088d5f297 ]---
Killed

When I choose kvm64 (or qemu64) as CPU model, Oops's are gone, but
tests still fail with registers mismatch the same way.
Possibly, Oops's are qemu faults?

>
>> [FAIL]  f[u]comi[p] errors: 1
>> [FAIL]  fisttp errors: 1'
>
> I don't know about these.
>
>> [FAIL]  R8 has changed:0000000000000000
>> [FAIL]  R9 has changed:0000000000000000
>> [FAIL]  R10 has changed:0000000000000000
>> [FAIL]  R11 has changed:0000000000000000
>> [FAIL]  R8 has changed:0000000000000000
>> [FAIL]  R9 has changed:0000000000000000
>> [FAIL]  R10 has changed:0000000000000000
>> [FAIL]  R11 has changed:0000000000000000
>
> The patch that added these test lines was the same patch that should have
> made them pass.  Are you sure your tests match your running kernel?  You
> need commit 8bb2610bc4967f19672444a7b0407367f1540028.

Yeah, it is already in the last master.

> If you still have failures, can you send me the complete output from the
> test_syscall_vdso test?

So, with such possibly loosy qemu (mis-)configuration that I have,
with your patch
applied on the top of the last master, it fixes "Reg 15 mismatch".
Still see the following faults:

======./sigreturn_32========
[OK]    set_thread_area refused 16-bit data
[OK]    set_thread_area refused 16-bit data
[RUN]    Valid sigreturn: 64-bit CS (33), 32-bit SS (2b, GDT)
[FAIL]    Reg 1 mismatch: requested 0x0; got 0x3
    SP: 5aadc0de -> 5aadc0de
[RUN]    Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
    SP: 5aadc0de -> 5aadc0de
[OK]    all registers okay
[RUN]    Valid sigreturn: 16-bit CS (37), 32-bit SS (2b, GDT)
    SP: 5aadc0de -> 5aadc0de
[OK]    all registers okay
[RUN]    Valid sigreturn: 64-bit CS (33), 16-bit SS (3f)
    SP: 5aadc0de -> 5aadc0de
[OK]    all registers okay
--
[RUN]    Testing fcmovCC instructions
[OK]    fcmovCC
======./test_syscall_vdso_32========
[RUN]    Executing 6-argument 32-bit syscall via VDSO
[OK]    Arguments are preserved across syscall
[NOTE]    R11 has changed:0000000000200ed7 - assuming clobbered by SYSRET insn
[OK]    R8..R15 did not leak kernel data
[RUN]    Executing 6-argument 32-bit syscall via INT 80
[OK]    Arguments are preserved across syscall
[FAIL]    R8 has changed:0000000000000000
[FAIL]    R9 has changed:0000000000000000
[FAIL]    R10 has changed:0000000000000000
[FAIL]    R11 has changed:0000000000000000
[RUN]    Executing 6-argument 32-bit syscall via VDSO
[OK]    Arguments are preserved across syscall
[NOTE]    R11 has changed:0000000000200ed7 - assuming clobbered by SYSRET insn
[OK]    R8..R15 did not leak kernel data
[RUN]    Executing 6-argument 32-bit syscall via INT 80
[OK]    Arguments are preserved across syscall
[FAIL]    R8 has changed:0000000000000000
[FAIL]    R9 has changed:0000000000000000
[FAIL]    R10 has changed:0000000000000000
[FAIL]    R11 has changed:0000000000000000
[RUN]    Running tests under ptrace

Thanks,
             Dmitry
