Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-842278-1517530914-2-7371070329446087499
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  FSL_HELO_FAKE 3.2, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_HI -5, SORTED_RECIPS 2.499, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517530914; b=LMTWN9xh2NujGU+OMPAKVZWNrHlg+ixPhdXAXy4zB5A/zTe
    K3MizsvZlNuI2EdX1HVjcr2Ezpf/XmzQnfjvZdGurYu5tZhElgeZalXPYcCHXmmJ
    LWSDNrsLNFEK1ZIM98lVniNxDEd3dptvoJVo7/T5VTR3RlKab96bvOae6aSg6jcH
    VkILGGrcm9zJX7mNg2fkzitsbpyuZe54tvG9MjqBD/GZrH4cFJ2Mgyq8YcFKQmRw
    Z8OCaeo/lS1Th1VVAemL+c4Q9gL8KcPPEwrY4S5iKcjSmAAogOBydbv/4owh6fv6
    n0sQFm13MAqUgU3gZ8sEOAt9PD08ZocFt5lrH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517530914; bh=tpvFekA5xNtvrqUVyZIG7L2VWP
    o4kGguwN5nl/8Uxdg=; b=VIjpzmaxp5yfhWLNLU9eCXFSQ8u2/6itqQkIslocyo
    +CyUy5718TQObg35DHyhQnQum96mSptqt2MMqV4kMKejWuM/ep0ZmWJ68kJTcHH8
    FdPZfdwF/wzcNIQkWnitrHv7tKkBp2l0JaOyMpth3kYd4+veK6j6R1+L7pIWc29V
    LiG9tzGh06F6oRl/9myknf68cGuHfmRK0DI8LdB/DXGDFeNBW3VnAs5VWnkCgcSb
    8xUxfaJ8BqfQPa6yWGxwkgFhSBCf9vzlWQHduwPkKmHQ1SakBvBdS74xRf/7ohk6
    P7YxVBBEG5+cMOvoFw29cEvue24uK/e9r+idNfnrcV/w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ibeDI0go x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S2C/PyeE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ibeDI0go x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S2C/PyeE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeBBAVt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 19:21:49 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:40345 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeBBAVs (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Feb 2018 19:21:48 -0500
X-Google-Smtp-Source: AH8x227m+tE0KUSGT72bnUlV7Z0CBqA6oVZ8FUDOvFhAsvE7vC3WecAu4Wc3e6e5mgxhJAiXJw+kKg==
Date: Thu, 1 Feb 2018 16:21:44 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+50d191d34989b5aa28596b0a2cb20c96f3ca4650@syzkaller.appspotmail.com>
Cc: felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
        krinkin.m.u@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tiwai@suse.de, vskrishn@codeaurora.org
Subject: Re: WARNING in usb_submit_urb
Message-ID: <20180202002144.y5jyqvpqiiuw4kf2@gmail.com>
References: <94eb2c1fae04f3526c055d66d147@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c1fae04f3526c055d66d147@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Nov 07, 2017 at 08:11:13AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 36ef71cae353f88fd6e095e2aaa3e5953af1685d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 2986 at drivers/usb/core/urb.c:498
> usb_submit_urb+0xeb9/0x10f0 drivers/usb/core/urb.c:497
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 3 PID: 2986 Comm: syzkaller630695 Not tainted 4.14.0-rc5-next-20171018+
> #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:16 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:52
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1c4/0x1e0 kernel/panic.c:546
>  report_bug+0x211/0x2d0 lib/bug.c:183
>  fixup_bug+0x40/0x90 arch/x86/kernel/traps.c:177
>  do_trap_no_signal arch/x86/kernel/traps.c:211 [inline]
>  do_trap+0x260/0x390 arch/x86/kernel/traps.c:260
>  do_error_trap+0x120/0x390 arch/x86/kernel/traps.c:297
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:310
>  invalid_op+0x18/0x20 arch/x86/entry/entry_64.S:905
> RIP: 0010:usb_submit_urb+0xeb9/0x10f0 drivers/usb/core/urb.c:497
> RSP: 0018:ffff880039ddf3f0 EFLAGS: 00010286
> RAX: 0000000000000022 RBX: ffff88006ab64f00 RCX: 0000000000000000
> RDX: 0000000000000022 RSI: 1ffff100073bbe3e RDI: ffffed00073bbe72
> RBP: ffff880039ddf448 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000002 R14: ffff88006b5d72c0 R15: 000000000000007f
>  proc_do_submiturb+0x1f53/0x3860 drivers/usb/core/devio.c:1778
>  proc_submiturb_compat+0x528/0x7e0 drivers/usb/core/devio.c:1999
>  usbdev_do_ioctl+0x1632/0x3670 drivers/usb/core/devio.c:2475
>  usbdev_ioctl+0x25/0x30 drivers/usb/core/devio.c:2552
>  vfs_ioctl fs/ioctl.c:45 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:685
>  SYSC_ioctl fs/ioctl.c:700 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
>  entry_SYSCALL_64_fastpath+0x1f/0xbe
> RIP: 0033:0x439089
> RSP: 002b:00007ffd7d8a88b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 0000000000439089
> RDX: 0000000020274ffa RSI: 00000000802c550a RDI: 0000000000000003
> RBP: 0000000000000082 R08: 00000000000000fb R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000401ce0 R14: 0000000000401d70 R15: 0000000000000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

No longer seeing this.  It seems to have been fixed by commit 446f666da9f01, so
telling syzbot so that it can start reporting similar bugs again:

#syz fix: USB: usbfs: Filter flags passed in from user space

- Eric
