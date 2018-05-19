Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-675029-1526695558-2-8347804272962043811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526695558; b=XQZIeijOPcrHey8B+W1Ge6YC4qgrMBsulU98bBBowao0drI/JE
    B/eHIm12S/BVHFm5lQfvBQgZk2vUK06FJgY1e5bL2snR9YWnsFAFklHSyySzizPR
    hdqlTOrwRDjLMgCHOn+HZHfN8yTEnDVJlKa/iEATtVOPDK8sGb+iwnKKtQ4xppUe
    8hn90sHyS1dz0GuHWqosoSmuwjejB00Pt9TsZoIgdFdAVQ5nHnc41A5KGEwP/OZg
    Lhy0u2nfUC8H6grXqLK9AQC5PVzmlHVAyZ/abr98cCVV73u6w3T+k8zlrIvVL4pb
    uggms4nHCoFBpG2uPzSW0tOuebSX26RbsPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526695558;
    bh=pXAeSfIJshoZAYTQCIPEypuWgRoBvRk0kCsr4ULOhbs=; b=C1VV/RakSLgF
    xKIbk+ybdtIX+OX1PFkPvGy1VYa31JA/nhNCZyYmXE3TyMxiAcRH2BzOquf2yHCX
    HFFTIee8BJlaAItsA3VyxYPJeTZX74JGF2/jJ+agaDffOOu5bPgQlFh2Y1dECd/+
    6fmeyzQLp6xm4CeHYxVb0x+VHB8Zvt0B6iXEuoEzl777YtG0qaTI8Vz9H19NE5Av
    56OX8fixvPX1lP+w+20hOxi9kh+2B+xTZKAj/uSlgC+dKYf31WFJ6kCEbiNS14yU
    NShhUsMv6XgtdpyBPxHjWyObPJpQGmqGZ/HrFyCEcWVpg13XFYPvPP6EH/kKC/N4
    8M0k2MpBvw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ITVL7VcJ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ITVL7VcJ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOz8c2jqjq4BWkReTebHIWQ6aBVuiL82UJkvg3tRVqb/jgYhJ2cx825wxtPOf64jiZxOuuFmKnP4MXVWozuPZh2RlN8JxI4dUWBTSAWa1MTzhQymrDx5
    ugjRaOWsNOW446ogPLf4lG5UamUyX7RcjyRGdlSJcM/3J/0dtkG87SVJx/LBK2q/L7gHlO1ghr+dzogQlXV740hfey11WAo83+5Yh6yYNt125gbWWsXK+0s5
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=n2GhSfulAAAA:8 a=LIV0wJlGq43SWQ0mTCwA:9
    a=btMbG4J4DjbYdCFa:21 a=9hkMAjSTJMe3efvi:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=9NqWk_7B-uqI6kdQTXIl:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbeESCFz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 22:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbeESCFm (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 22:05:42 -0400
X-Google-Smtp-Source: AB8JxZorqGi85CO8r9YYNxE7QijtZIXLoOiMTo6qaQvbJPcE5bTVtKAygFrpgBszuDDyVW098xg9d1f/ozDcP6KWcO8=
MIME-Version: 1.0
References: <20180517233510.24996-1-dima@arista.com> <1526600442.28243.39.camel@arista.com>
 <CALCETrUDX=4FHU0e8SZ9Rr_AnAes+5jjzKCrrVmS1mddHQyeVQ@mail.gmail.com> <CAJwJo6ZwEZiQYDQqLkfP0+mRgmc+X=H02M=fFZZykWN4A3s-FQ@mail.gmail.com>
In-Reply-To: <CAJwJo6ZwEZiQYDQqLkfP0+mRgmc+X=H02M=fFZZykWN4A3s-FQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 18 May 2018 19:05:28 -0700
X-Gmail-Original-Message-ID: <CALCETrXV1Dnpms2_naBsY=pwFOFtBs4gWVpobHivbzJA=4GR_A@mail.gmail.com>
Message-ID: <CALCETrXV1Dnpms2_naBsY=pwFOFtBs4gWVpobHivbzJA=4GR_A@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Drop TS_COMPAT on 64-bit exec() syscall
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        Dmitry Safonov <dima@arista.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On May 18, 2018, at 4:10 PM, Dmitry Safonov <0x7f454c46@gmail.com> wrote:

> Hi Andy,

> 2018-05-18 23:03 GMT+01:00 Andy Lutomirski <luto@kernel.org>:
>>> On Thu, May 17, 2018 at 4:40 PM Dmitry Safonov <dima@arista.com> wrote:
>>> Some selftests are failing, but the same way as before the patch
>>> (ITOW, it's not regression):
>>> [root@localhost self]# grep FAIL out
>>> [FAIL]  Reg 1 mismatch: requested 0x0; got 0x3
>>> [FAIL]  Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
>>> 0xffffff425aadc0de
>>> [FAIL]  Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
>>> 0xffffff425aadc0de
>>> [FAIL]  Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
>>> 0xffffff425aadc0de

>> Are you on AMD?  Can you try this patch:


https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=3D=
x86/fixes&id=3Dc88aa6d53840e48970c54f9ef70c79415033b32d

>> and give me a Tested-by if it fixes it for you?

> Sure.
> I'm on Intel actually:
> cpu family    : 6
> model        : 142
> model name    : Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz

> But I usually test kernels in VM. So, I use virt-manager as it's
> easier to manage
> multiple VMs. The thing is that I've chosen "Copy host CPU configuration"
> and for some reason, I don't quite follow virt-manager makes model
"Opteron_G4".
> I'm on Fedora 27, virt-manager 1.4.3, qemu 2.9.1(qemu-2.9.1-2.fc26).
> So, cpuinfo in VM says:
> cpu family    : 21
> model        : 1
> model name    : AMD Opteron 62xx class CPU

What does guest cpuinfo say for vendor_id?

There are multiple potential screwups here.

1. (What I *thought* was going on) AMD CPUs have screwy IRET behavior
that=E2=80=99s different from Intel=E2=80=99s, and the test case was defini=
tely wrong. But
KVM has no way to influence it.  Are you sure you=E2=80=99re using KVM and =
not QEMU
TCG? Anyway, the IRET thing is minor compared to your other problems, so
let=E2=80=99s try to fix them first.

2. Compat fast syscalls are wildly different on AMD and Intel. Because of
this issue, QEMU with KVM is supposed to always report the real vendor_id
no matter -cpu asks for.  If we get the wrong vendor_id, then we=E2=80=99re=
 at the
mercy of KVM=E2=80=99s emulation and performance will suck.  On older kerne=
ls, this
would cause hideous kernel crashes.  On new kernels, I would expect it to
merely crash 32-bit user programs or be slow.

> What's worse than registers changes is that some selftests actually lead
to
> Oops's. The same reason for criu-ia32 fails.
> I've tested so far v4.15 and v4.16 releases besides master (2c71d338bef2)=
,
> so it looks to be not a recent regression.

> Full Oopses:
> [  189.100174] BUG: unable to handle kernel paging request at
00000000417bafe8
> [  189.100174] PGD 69ed4067 P4D 69ed4067 PUD 707fc067 PMD 6c535067 PTE
6991f067
> [  189.100174] Oops: 0001 [#3] SMP NOPTI

Whoa there!  0001 means a failed *kernel* access.

> [  189.100174] Modules linked in:
> [  189.100174] CPU: 0 PID: 2443 Comm: sysret_ss_attrs Tainted: G

Was this sysret_ss_attrs_32 or sysret_ss_attrs_64?

> D           4.17.0-rc5+ #11
> [  189.103187] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1.fc26 04/01/2014
> [  189.103187] RIP: 0033:0x40085a

The oops was caused from CPL 3 at what looks like a totally sensible user
address.  Can you disassemble the offending binary and tell me what the
code at 0x40085a is?

> [  189.103187] RSP: 002b:00000000417bafe8 EFLAGS: 00000206
> [  189.103187] RAX: 0000000000000000 RBX: 00000000000003e8 RCX:
0000000000000000
> [  189.103187] RDX: 0000000000000000 RSI: 0000000000400830 RDI:
00000000417baff8
> [  189.103187] RBP: 00000000417baff8 R08: 0000000000000000 R09:
0000000000000077
> [  189.103187] R10: 0000000000000006 R11: 0000000000000000 R12:
00000000417ba000
> [  189.103187] R13: 00007ffc05207840 R14: 0000000000000000 R15:
0000000000000000
> [  189.103187] FS:  00007f98566ecb40(0000) GS:ffff9740ffc00000(0000)
> knlGS:0000000000000000
> [  189.103187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

CS here is the value of CS that the *kernel* has, so 0x10 is normal.

> [  189.103187] CR2: 00000000417bafe8 CR3: 0000000069dc4000 CR4:
00000000007406f0

CR2 is in user space.

So the big question is: what happened here?  Why did the CPU (or emulated
CPU) attempt a privileged access to a user address while running user code?
