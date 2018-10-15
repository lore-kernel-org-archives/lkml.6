Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B0FC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DA22064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hx4MPXWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DA22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeJOVIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:08:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46165 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOVIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:08:21 -0400
Received: by mail-io1-f67.google.com with SMTP id t7-v6so14206540ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=4aUzjaxNYkcYTXbHmuc8pJnNSU3fFclijODpUGO9Htw=;
        b=Hx4MPXWzU4qWNyotYs4TbXYbhjFQg4whrV5qpyPvJXMjk708GBxjcqm6i6O9SknsB7
         HNuii0i5COoRXLj91/3SHLIXc1XIB+4ynJZ5LH6W5/TPzEtj2ggl5s3eoO/ufA9uqS99
         PMAMRMClsYDiEt47Lemc+3X2pozDX6ZdPhVK4rW45knQRYa9V88tzAcBYZSFHgNKnfD3
         stuBhufzUxSQ3lNtcbkIzo+UOaMFIQbZVKRzjjy8jUUR+6aq8IqKiw+pqsxDbJbD1TIR
         eOKt5h1M3JAUwV4vzxlieORuonVk1cUCpoP8GNOdkdBR0gpiXHn81f0UtGf0K2Fcb3tf
         z6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=4aUzjaxNYkcYTXbHmuc8pJnNSU3fFclijODpUGO9Htw=;
        b=Pgq6ikCT+Mrwb1/uE0Co27oNsciNbJsPWoI9HP0+3ETFUZqtue9K5H3dqlJq8hMgxS
         eFt0GNz+9u0qpnElWTIlUk9L+N9QrSEwTZopodu4tvlNs0catXZrJ8akutieveAEGGww
         hGQJSu3MFtHlUU4GhvgUBZokyAIfO+NAYSoxGK4TOI3oovw0GZc4Kz388KPnA9Ea00g7
         VHPj4VvTlX0hT7Be4zSPM2VFYDoX07kPWwZS+SXFJmlMSNsrYn5DIcql76keOMngNjoG
         wQj5XFchSAVDxnTf3urCbAxYfStEGT3zLh7Vf+N6DEJ4KMLQ7gf+fCOOQQnTLYLJJ0cW
         oqEA==
X-Gm-Message-State: ABuFfoiskIGqB3ky3LHJOfFn9mCbORBxPAl5LR5XCeU+qWy2WPLqSAQ5
        SfDekn7MScxvWw4O7aPeD1J/YinBfkWxRf2Bxc252Q==
X-Google-Smtp-Source: ACcGV635N0pE2Kib8M7J9D7MeHxD3Aql86PmO2FK8xdpt8xfAOvUCsFOwSvgHJ7QlOtjxX9ZgMRRCYZGoPHBWXTF8c8=
X-Received: by 2002:a6b:6201:: with SMTP id f1-v6mr6414102iog.11.1539609782561;
 Mon, 15 Oct 2018 06:23:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 06:22:42
 -0700 (PDT)
In-Reply-To: <20181009013425.GB3369@thunk.org>
References: <0000000000002753c60577b9f707@google.com> <CACT4Y+bdR3ch9q_FCND4YmqjunYBVbEk3n167DT0r0GqzVKL-g@mail.gmail.com>
 <20181009013425.GB3369@thunk.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Oct 2018 15:22:42 +0200
Message-ID: <CACT4Y+a08tYAgXKEiTO+A-RDrSNk-RdhDxvGCM6bAbk5bckH6A@mail.gmail.com>
Subject: Re: WARNING in ext4_invalidatepage
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 3:34 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Mon, Oct 08, 2018 at 06:29:54PM +0200, Dmitry Vyukov wrote:
>>
>> The program that triggered it did the following:
>>
>> 05:23:28 executing program 5:
>> r0 = creat(&(0x7f00000001c0)='./file0\x00', 0x0)
>> socketpair$unix(0x1, 0x1, 0x0, &(0x7f0000000380)={0xffffffffffffffff,
>> <r1=>0xffffffffffffffff})
>> write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000240)={0x0, 0x18,
>> 0xfa00, {0x0, &(0x7f0000000200)}}, 0x20)
>
> This looks like it's doing an ioctl-like thing which is now restricted
> to root --- it looks like people can do arbitrary stupid things with
> it?
>
> https://www.openwall.com/lists/oss-security/2016/05/09/11
>
>> ioctl$PERF_EVENT_IOC_ENABLE(r1, 0x8912, 0x400200)
>> ioctl$EXT4_IOC_SETFLAGS(r0, 0x4008660f, &(0x7f0000000000)=0x4000)
>
> Um, this doesn't seem to correspond to the stack trace:
>
>> >  do_invalidatepage mm/truncate.c:165 [inline]
>> >  truncate_cleanup_page+0x5ac/0xa90 mm/truncate.c:187
>> >  truncate_inode_page+0x107/0x1a0 mm/truncate.c:229
>> >  truncate_inode_pages_range+0x1382/0x2d50 mm/truncate.c:451
>> >  truncate_inode_pages+0x24/0x30 mm/truncate.c:478
>> >  swap_inode_boot_loader fs/ext4/ioctl.c:123 [inline]
>> >  ext4_ioctl+0x1e3b/0x4210 fs/ext4/ioctl.c:865
>> >  vfs_ioctl fs/ioctl.c:46 [inline]
>> >  file_ioctl fs/ioctl.c:501 [inline]
>> >  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>> >  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>> >  __do_sys_ioctl fs/ioctl.c:709 [inline]
>> >  __se_sys_ioctl fs/ioctl.c:707 [inline]
>> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>> >  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> This looks like the program that triggered the crash was running
> EXT4_IOC_SWAP_BOOT.  It may have been racing against something that's
> was using RDMA, but that's not clear at all, since the write command
> appears to be some weird ioctl-like interface that requires root.
>
> It's too bad that syzbot wasn't able to come up with a clean
> reproducer.  I've been doing some work to robustify the
> EXT4_IOC_SWAP_ROOT.  If we had a reproducer I'd see if this patch
> would address it.
>
>         http://patchwork.ozlabs.org/patch/978083/



Hi Ted,

The RDMA thing seems to be red-herring, as it writes RDMA command into
a normal local file. These commands will only take effect if written
to /dev/infiniband/rdma_cm file.

Now that you mention EXT4_IOC_SWAP_BOOT, I think I looked at the wrong
program, there is a subsequent one that does ioctl(0x6611) where
0x6611 is in fact EXT4_IOC_SWAP_BOOT. So I think it's this one:

05:23:28 executing program 5:
r0 = creat(&(0x7f00000001c0)='./file0\x00', 0x0)
socketpair$unix(0x1, 0x1, 0x0, &(0x7f0000000380)={0xffffffffffffffff,
<r1=>0xffffffffffffffff})
write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000240)={0x0, 0x18,
0xfa00, {0x0, &(0x7f0000000200)}}, 0x20)
ioctl$PERF_EVENT_IOC_ENABLE(r1, 0x8912, 0x400200)
ioctl$EXT4_IOC_SETFLAGS(r0, 0x6611, &(0x7f0000000000)=0x4000)


I've tried to manually reply this program and the whole log too, but
it does not reproduce. This may be related to the fact that filesystem
accumulates too much global state, so probably first relevant part
happened long time ago, and then second relevant part happened later
and triggered the warning. But just re-doing the second part does not
reproduce the bug.
Unfortunately it's the reality of kernel testing. Maybe syzbot will
come up with repro later, or maybe we will see that it does not happen
anymore (fixed by your patch) and we will close it then.



>> > WARNING: CPU: 1 PID: 17203 at fs/ext4/inode.c:3353
>> > ext4_invalidatepage+0x1c7/0x5b0 fs/ext4/inode.c:3353
>> > Kernel panic - not syncing: panic_on_warn set ...
>> >
>> > CPU: 1 PID: 17203 Comm: syz-executor5 Not tainted 4.19.0-rc6+ #48
>> > kobject: 'loop3' (000000002393f9b0): kobject_uevent_env
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> > Google 01/01/2011
>> > Call Trace:
>> >  __dump_stack lib/dump_stack.c:77 [inline]
>> >  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>> > kobject: 'loop3' (000000002393f9b0): fill_kobj_path: path =
>> > '/devices/virtual/block/loop3'
>> >  panic+0x238/0x4e7 kernel/panic.c:184
>> >  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>> >  report_bug+0x254/0x2d0 lib/bug.c:186
>> >  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>> >  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>> >  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>> >  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
>> > RIP: 0010:ext4_invalidatepage+0x1c7/0x5b0 fs/ext4/inode.c:3353
>> > Code: 80 3c 02 00 0f 85 a7 03 00 00 4d 8b 6d 00 31 ff 49 c1 ed 11 41 83 e5
>> > 01 4c 89 ee e8 43 ea 67 ff 4d 85 ed 74 07 e8 09 e9 67 ff <0f> 0b e8 02 e9 67
>> > ff 8b b5 34 ff ff ff 44 89 fa 4c 89 e7 e8 91 3a
>> > RSP: 0018:ffff88018590ec78 EFLAGS: 00010212
>> > RAX: 0000000000040000 RBX: 1ffff10030b21d91 RCX: ffffc9000dae4000
>> > RDX: 0000000000000ece RSI: ffffffff8216ec87 RDI: 0000000000000007
>> > RBP: ffff88018590ed50 R08: ffff880183018300 R09: fffff94000ceffc6
>> > R10: fffff94000ceffc6 R11: ffffea000677fe33 R12: ffffea000677fe00
>> > R13: 0000000000000001 R14: ffffea000677fe08 R15: 0000000000001000
>> >  do_invalidatepage mm/truncate.c:165 [inline]
>> >  truncate_cleanup_page+0x5ac/0xa90 mm/truncate.c:187
>> >  truncate_inode_page+0x107/0x1a0 mm/truncate.c:229
>> >  truncate_inode_pages_range+0x1382/0x2d50 mm/truncate.c:451
>> >  truncate_inode_pages+0x24/0x30 mm/truncate.c:478
>> >  swap_inode_boot_loader fs/ext4/ioctl.c:123 [inline]
>> >  ext4_ioctl+0x1e3b/0x4210 fs/ext4/ioctl.c:865
>> >  vfs_ioctl fs/ioctl.c:46 [inline]
>> >  file_ioctl fs/ioctl.c:501 [inline]
>> >  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>> >  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>> >  __do_sys_ioctl fs/ioctl.c:709 [inline]
>> >  __se_sys_ioctl fs/ioctl.c:707 [inline]
>> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>> >  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> > RIP: 0033:0x457579
>> > Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> > 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> > RSP: 002b:00007fa151655c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
>> > RDX: 0000000020000000 RSI: 0000000000006611 RDI: 0000000000000006
>> > RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
>> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa1516566d4
>> > R13: 00000000004bf60e R14: 00000000004cf4a8 R15: 00000000ffffffff
>> > Kernel Offset: disabled
>> > Rebooting in 86400 seconds..
>> >
>> >
>> > ---
>> > This bug is generated by a bot. It may contain errors.
>> > See https://goo.gl/tpsmEJ for more information about syzbot.
>> > syzbot engineers can be reached at syzkaller@googlegroups.com.
>> >
>> > syzbot will keep track of this bug report. See:
>> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> > syzbot.
