Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E92C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE162084C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCxkvSdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE162084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbeGHVMD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:12:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36828 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932760AbeGHVMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:12:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id u16-v6so12150340pfh.3;
        Sun, 08 Jul 2018 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MiuDxQuoVcfH2JTnWaBjZf6S7zPXEVJjU7IAcKLfYSA=;
        b=RCxkvSdjheHzwlwQCZS8FiK9k3PjLlkRexco/V3DTkGdRq1Rnc5BWlDeDLyM3zwOry
         egotrGVz306fPoPUUOueAT0Y/uOladicMMGw311pIJrMJKpG5JPl0OQhRWLB0Fd9BIXa
         3NV2zywWoTDJ/fCqLx7KRdRwb09vWIeiDWuxd4PI1RrWykA9D6u5f1L7FwHVZw+djycZ
         3TdG7iGfmVOGtmRSdlmUafHMnsjpsltDKCzfLri5mWN/Eb9TNEpAJPonBOFM2PDYGocJ
         bxvWdMe1zB2DtQo1L7PRVAxqT8tHhPsIgumpPN4fvSeRwMwv7uZn3dTZh/fs7cLXDYxV
         6KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MiuDxQuoVcfH2JTnWaBjZf6S7zPXEVJjU7IAcKLfYSA=;
        b=JXTZOaMmdggbZ3wd1l97VSGzEL4tMWI2LeMZTbh7CVIgTwZxwaa8VPou6BVcJhxcqO
         Fzhl50rMrrDZAawVVkCVf2m8Kr/j123ekaE0/Qy99d0g/ynW0WqAYzdPFIZc1qt1AKVT
         aYomF0qDAvhQhK20MPiZrpsQzP8OkajqB2Itbf5z2xIbn1pbtMib6iih4lJdhWljnPIj
         s+P/tGyg3bwuYJrY3ssEPTUcVY5kAfs0ay+j61HlZWCv+h4w0gVWCV6u8vt2olT3na+u
         JtfUCJVWQlIxpuzLqeLMZH479TU084HbaZ8WIqZUFkplRe4tzZsSki0+XmjPu5JPzEyd
         +qng==
X-Gm-Message-State: APt69E2cYe8RoEsKDC+SjKNFa6gGSfvANek3MkXeK+LNvisqYzuZ1Xdq
        0BaEAiTRipUu4FnJbE29n3U=
X-Google-Smtp-Source: AAOMgpcPb4U4bZ/YIwcIJqr2R6ApTiFSH37ns9r0xcgaS08+2IJAL9Dlkt+6YYATjTnPdJcGzcTWbQ==
X-Received: by 2002:a63:416:: with SMTP id 22-v6mr16624784pge.229.1531084321216;
        Sun, 08 Jul 2018 14:12:01 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id z20-v6sm4795171pfd.99.2018.07.08.14.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Jul 2018 14:12:00 -0700 (PDT)
Date:   Sun, 8 Jul 2018 14:11:59 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     syzbot <syzbot+0977fcb74b8a12a967b8@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: kernel BUG at fs/super.c:LINE!
Message-ID: <20180708211159.GA700@sol.localdomain>
References: <00000000000072ce39057072d272@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000072ce39057072d272@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 06:29:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    526674536360 Add linux-next specific files for 20180706
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1443b168400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
> dashboard link: https://syzkaller.appspot.com/bug?extid=0977fcb74b8a12a967b8
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=159481b2400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142bca2c400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0977fcb74b8a12a967b8@syzkaller.appspotmail.com
> 
> RBP: 0000000000000004 R08: 0000000020000180 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> Filesystem sysfs get_tree() didn't set fc->root
> ------------[ cut here ]------------
> kernel BUG at fs/super.c:1761!
> invalid opcode: 0000 [#1] SMP KASAN
> CPU: 1 PID: 4470 Comm: syz-executor042 Not tainted 4.18.0-rc3-next-20180706+
> #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:vfs_get_tree.cold.21+0x4f/0x60 fs/super.c:1756
> Code: 37 00 48 c1 e0 2a 48 89 da 48 c1 ea 03 80 3c 02 00 74 08 48 89 df e8
> 30 f0 f4 ff 48 8b 33 48 c7 c7 a0 5a f3 87 e8 05 36 9d ff <0f> 0b 4c 89 ef e8
> 17 f0 f4 ff eb c0 90 90 90 90 90 55 48 89 e5 53
> RSP: 0018:ffff8801aac07be0 EFLAGS: 00010286
> RAX: 000000000000002f RBX: ffffffff8906e5e0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81634381 RDI: 0000000000000001
> RBP: ffff8801aac07c10 R08: ffff8801a6cd6440 R09: ffffed003b5e4fc0
> R10: ffffed003b5e4fc0 R11: ffff8801daf27e07 R12: 0000000000000000
> R13: ffff8801bf72bdc8 R14: 0000000000000020 R15: ffff8801bf72bdd8
> FS:  0000000001bf0880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004b4f7c CR3: 00000001c4ae4000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  do_new_mount fs/namespace.c:2567 [inline]
>  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
>  ksys_mount+0x12d/0x140 fs/namespace.c:3105
>  __do_sys_mount fs/namespace.c:3119 [inline]
>  __se_sys_mount fs/namespace.c:3116 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440c89
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 bb 10 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffe59b66978 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffe59b66990 RCX: 0000000000440c89
> RDX: 0000000020000280 RSI: 00000000200000c0 RDI: 0000000020000000
> RBP: 0000000000000004 R08: 0000000020000180 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 07cdba975902c41a ]---
> RIP: 0010:vfs_get_tree.cold.21+0x4f/0x60 fs/super.c:1756
> Code: 37 00 48 c1 e0 2a 48 89 da 48 c1 ea 03 80 3c 02 00 74 08 48 89 df e8
> 30 f0 f4 ff 48 8b 33 48 c7 c7 a0 5a f3 87 e8 05 36 9d ff <0f> 0b 4c 89 ef e8
> 17 f0 f4 ff eb c0 90 90 90 90 90 55 48 89 e5 53
> RSP: 0018:ffff8801aac07be0 EFLAGS: 00010286
> RAX: 000000000000002f RBX: ffffffff8906e5e0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81634381 RDI: 0000000000000001
> RBP: ffff8801aac07c10 R08: ffff8801a6cd6440 R09: ffffed003b5e4fc0
> R10: ffffed003b5e4fc0 R11: ffff8801daf27e07 R12: 0000000000000000
> R13: ffff8801bf72bdc8 R14: 0000000000000020 R15: ffff8801bf72bdd8
> FS:  0000000001bf0880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004b4f7c CR3: 00000001c4ae4000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

This is a bug in "kernfs, sysfs, cgroup, intel_rdt: Support fs_context" from the
fs_context patch series.  Proposed fix is
https://patchwork.kernel.org/patch/10513375/ ("sysfs: check return value of
kernfs_get_tree()").  It might get folded into the original patch.

- Eric
