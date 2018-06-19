Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F376C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC70E20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQd09y7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC70E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030547AbeFSSvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:51:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41115 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030407AbeFSSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:51:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11-v6so299145pff.8;
        Tue, 19 Jun 2018 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kgEfJ2gvxgL6GMTXjxZYLJbWHw4bkMVrdfl/26fUXK0=;
        b=ZQd09y7cKNLdB9IR+z0TtgaywEFnCATnoSK3UV6lklVF5zyxzQUpeakLseGMZiuoxa
         J/SLgBvK2ABnXlOQBrxILo3d3QnxPjjrIom9SiwjseauPI79tsMLugUq1DERFSvItHzD
         lmlKUO3UndQStfMz5gk3rTCwtlstN4I57jT6KdG4jdbawuqDgs74VYTgDsaje+Lpi44m
         eTTjA/eJoSn5YFqGIFxoqa+pPfsNnPWA9EOsi9itT/DqGAqoMAn9iqKHk+fk8Kk3c7Xu
         nMn2LvhCGe4NZ4dxAEJLsu6AqFZN7fAabC/dOqigd/TzxHPbZZP6fwnmZIq1IRmfzwGf
         c4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kgEfJ2gvxgL6GMTXjxZYLJbWHw4bkMVrdfl/26fUXK0=;
        b=cM4lem1hSjDhSbmk9gFArC6iNHx7lkIr8KRGYjfiwT5huCpXDTyusJgvTPdcf4O1Mr
         WXIKaOZ6kZj52nFIUQ6FYBFdTdSa1TyveCBYocIUDLDIRL8Jqn0jQ6r0mF1aIbJMsrSL
         cBnS1wIM3M8Vdb7acUzmLrKBNzrVo2SOsnwUZfXKiCYWbrkpfz2ifzieCj+WhJffHPKC
         sR1YVl5+qTIJVE8gcuI/8gL5BiDhnSG4oe/zmpswNpTDz6jFztL5n50/2tyImtQwbqo3
         v5OSyJYHFk3ELz9hj1OczJWmf/bGuQNN0jKOeefL3C855+FFefXMp5g6hkTz0PkV4vsQ
         DK0A==
X-Gm-Message-State: APt69E2q4pYjlKbvLY52GDkIsLfu6/ZpzQrWkIbeSqxEA6g/C5PaMnup
        7NPRWIVYo1DSNctLXPQFRD1GHBKMd5Y=
X-Google-Smtp-Source: ADUXVKLvwFPoJ/UHVZgdNjcR7l6dIX3ofY9SOpkz6ji8fnrvEACZihgL2HRRjol2/N0PEBKiWDaTaA==
X-Received: by 2002:a62:5911:: with SMTP id n17-v6mr19299817pfb.162.1529434275144;
        Tue, 19 Jun 2018 11:51:15 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id c4-v6sm286581pgv.86.2018.06.19.11.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:51:13 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:51:11 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     syzbot <syzbot+c382812c78d98ecd9fb8@syzkaller.appspotmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rydberg@bitmath.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in input_alloc_absinfo
Message-ID: <20180619185111.GK71788@dtor-ws>
References: <000000000000fe1d2b056e997e1f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fe1d2b056e997e1f@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 05:47:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=1775bae7800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=c382812c78d98ecd9fb8
> compiler:       clang version 7.0.0 (trunk 329391)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13b31ae7800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1733255b800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c382812c78d98ecd9fb8@syzkaller.appspotmail.com
> 
> RBP: 00000000006cb018 R08: 0000000000000001 R09: 00007ffe93080031
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> ------------[ cut here ]------------
> input_alloc_absinfo(): kcalloc() failed?
> WARNING: CPU: 1 PID: 4498 at drivers/input/input.c:487
> input_alloc_absinfo+0x183/0x190 drivers/input/input.c:487
> Kernel panic - not syncing: panic_on_warn set ...

Hmm, so there is not really a problem as far as I am concerned. We do
generate a warning if we can't allocate memory for absinfo,  as this is
really unexpected, but the case is handled properly by the callers so
there is no reason for us to go belly up here.

> 
> CPU: 1 PID: 4498 Comm: syz-executor465 Not tainted 4.16.0+ #87
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
>  panic+0x39d/0x940 kernel/panic.c:183
>  __warn+0x40f/0x580 kernel/panic.c:547
>  report_bug+0x72a/0x880 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:179 [inline]
>  do_error_trap+0x1aa/0x600 arch/x86/kernel/traps.c:297
>  do_invalid_op+0x46/0x50 arch/x86/kernel/traps.c:316
>  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
> RIP: 0010:input_alloc_absinfo+0x183/0x190 drivers/input/input.c:487
> RSP: 0018:ffff88019651faa8 EFLAGS: 00010282
> RAX: 0000000000000028 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: aaaaaaaaaaaab000 RDI: ffffea0000000000
> RBP: ffff88019651fae0 R08: 0000000001080020 R09: 0000000000000002
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8801a19ec140 R14: ffff88019796e198 R15: 0000000000000000
>  uinput_abs_setup drivers/input/misc/uinput.c:507 [inline]
>  uinput_ioctl_handler+0x38a2/0x39f0 drivers/input/misc/uinput.c:1035
>  uinput_ioctl+0x9a/0xb0 drivers/input/misc/uinput.c:1047
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0xaf0/0x2440 fs/ioctl.c:686
>  SYSC_ioctl+0x1d2/0x260 fs/ioctl.c:701
>  SyS_ioctl+0x54/0x80 fs/ioctl.c:692
>  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> RIP: 0033:0x440429
> RSP: 002b:00007ffe9308d2b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440429
> RDX: 0000000000000000 RSI: 0000000040005504 RDI: 0000000000000003
> RBP: 00000000006cb018 R08: 0000000000000001 R09: 00007ffe93080031
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

Thanks.

-- 
Dmitry
