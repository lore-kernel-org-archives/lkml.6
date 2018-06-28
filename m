Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3BCC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C6126E35
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZiZS4Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C6126E35
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeF1F1g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:27:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33238 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeF1F1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:27:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so2055473pfi.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 22:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FzVnE7nkeULXC4juOZIHAezpUQumztgUhe4DNhxuQU0=;
        b=dZiZS4GlMCGnZWpmjmPcYjWWKxsKnzjROkkaiW5KcheEfj046I7kcHg2XnV4ZFwTGa
         sqegGOLzEtv2q3pyQfhfOmbG4eleNIMpBc9orKhgShgs+SY1lPz9Kn498N+GIznsIKf+
         KRChxiAP2gbmOwvnLdCXFI6NxaelcyZZ+3dlCldEzEaqJ0JPye1ywpHBJbomt4GyCs4v
         WoxmZgm2Yl4ZTi5/AZUPaimDkfzrUvBUEqQS8zvWEwaQeEJcrR+rcAX/w4x9vHaWkxEo
         9MXpITENlUaY5XVKDoaAxEE7QgNaoihWS65AfU3gytx+qEWb0ns1bmaEP1g4FcOv6Jfa
         Bo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FzVnE7nkeULXC4juOZIHAezpUQumztgUhe4DNhxuQU0=;
        b=BHJWJeOdXiXnNx/vdY1qGXBtMk7wRUKF1wUzIyAq2wOVEqBW5VOZgfvbg+qvBBmef0
         AhHf0ZXF1ocuFn6EFNeOAIsODI4A54PQKnRJE7KgXUgU0kZWGLEo59Wc476JSuaE2L9Y
         RM/MDDVCkYZbT6BjcBoBytU4YVj6MCRzAzAqS9CbUb3EYY+Zler5ONqO7UfaHzFAqfu/
         W9GmZ37bP6L0pNfpc3Vvz/J28Y5dXNMFLrBE76TlGNURm/bP8krrf+ZEe1nAfWVTRuxT
         WQkTe25zQFAm1w1SGP6e5n3rr8fInlEtLcpIeU0ibwqSN7sTOxTP0fT4axjhZpKGafRI
         xiCQ==
X-Gm-Message-State: APt69E0/p8orXdg8n9gpXR0AztbGRiU5jcuVR+CRvb7S/epaVJcM69Cs
        qpjfZIG9z/2NR6Gx0gaIUFh2fBHIgJNbAUk0a7C08WqMDU3F2ZOWU3mSbUWOXCPOu9lDHw3vIRh
        cPnd00awqc3XJqXarBRNtIiZvoVCDTZ4=
X-Google-Smtp-Source: AAOMgpeYn0OsrZQSl2fRLINuJ3we7ahWWsbobsZZyY3h8tHVrRU+AAiLeZ/uxt0QdOmTiLW1Cn273P6lc6a+rHLGNpE=
X-Received: by 2002:a65:490d:: with SMTP id p13-v6mr7418372pgs.84.1530163653933;
 Wed, 27 Jun 2018 22:27:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 27 Jun 2018 22:27:13
 -0700 (PDT)
In-Reply-To: <00000000000037b58a0569c49b70@google.com>
References: <883d24f79ad8fd475f0569a39ba6@google.com> <00000000000037b58a0569c49b70@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Jun 2018 07:27:13 +0200
Message-ID: <CACT4Y+bnUNtn3jO5fYMB5dSqA=vbc8KfnTmbajA6SYKex4KFoQ@mail.gmail.com>
Subject: Re: general protection fault in vmx_vcpu_run
To:     syzbot <syzbot+cc483201a3c6436d3550@syzkaller.appspotmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 3:07 AM, syzbot
<syzbot+cc483201a3c6436d3550@syzkaller.appspotmail.com> wrote:
> syzbot has found reproducer for the following crash on upstream commit
> 1bad9ce155a7c010a9a5f3261ad12a6a8eccfb2c (Fri Apr 13 19:27:11 2018 +0000)
> Merge tag 'sh-for-4.17' of git://git.libc.org/linux-sh
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=cc483201a3c6436d3550
>
> So far this crash happened 4 times on upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6257386297753600
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=4808329293463552
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=4943675322793984
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-5947642240294114534
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+cc483201a3c6436d3550@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.

#syz dup: BUG: unable to handle kernel paging request in vmx_vcpu_run


> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 6472 Comm: syzkaller667776 Not tainted 4.16.0+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:vmx_vcpu_run+0x95f/0x25f0 arch/x86/kvm/vmx.c:9746
> RSP: 0018:ffff8801c95bf368 EFLAGS: 00010002
> RAX: ffff8801b44df6e8 RBX: ffff8801ada0ec40 RCX: 1ffff100392b7e78
> RDX: 0000000000000000 RSI: ffffffff81467b15 RDI: ffff8801ada0ec50
> RBP: ffff8801b44df790 R08: ffff8801c4efe780 R09: fffffbfff1141218
> R10: fffffbfff1141218 R11: ffffffff88a090c3 R12: ffff8801b186aa90
> R13: ffff8801ae61e000 R14: dffffc0000000000 R15: ffff8801ae61e3e0
> FS:  00007fa147982700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 00000001d780d000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> Code: 8b a9 68 03 00 00 4c 8b b1 70 03 00 00 4c 8b b9 78 03 00 00 48 8b 89
> 08 03 00 00 75 05 0f 01 c2 eb 03 0f 01 c3 48 89 4c 24 08 59 <0f> 96 81 88 56
> 00 00 48 89 81 00 03 00 00 48 89 99 18 03 00 00
> RIP: vmx_vcpu_run+0x95f/0x25f0 arch/x86/kvm/vmx.c:9746 RSP: ffff8801c95bf368
> ---[ end trace ffd91ebc3bb06b01 ]---
> Kernel panic - not syncing: Fatal exception
> Shutting down cpus with NMI
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000037b58a0569c49b70%40google.com.
>
> For more options, visit https://groups.google.com/d/optout.
