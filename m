Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5B8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842382183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aom3GFDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfBTQC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:02:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36362 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfBTQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:02:58 -0500
Received: by mail-it1-f195.google.com with SMTP id h6so16714218itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVdWa/EVeEyM0iEtxo0SV7bu2zmMgxHW1yOyVqHvTxo=;
        b=aom3GFDqWPCjilIxW+ZkDyNNTQisUwWZulAGaPs4j51i6Jcwm3kNB13jnqdtqQU578
         60SwZQMveWd4P++4YObRWu770NFG5Imip2LcQXJ/5IQag0MoqxuMSJN++UHgTkSnFb39
         cKVm297QLVnWp2Azw61Gs4fXFS6jRl0Aifi8z71QEMfh+lKk54Evz1An6x7w0IO9lQfY
         k0vf2oyjvbtgFl/0+Mi2JQdwYXbLdhqlbnqilybi6X92CTUynrTvhnv1RIIBWL7jwRKu
         rz8G76dQRdN2pVx0N2pCShq3taoCRvKmBMBJXA/foV3Yn51JU5i4E+fqGt0eOUtM7H46
         dUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVdWa/EVeEyM0iEtxo0SV7bu2zmMgxHW1yOyVqHvTxo=;
        b=MAItzDH8pqwJIAP9RxG0spj/0lMNMyYfsUHjV7zz+sGMXeAC3PKwos8kIzxw6Y17AU
         9KK6TEd4huPqB0GHM00khKq6IjA65mUhzzkeuVPXD/8LgVAn9kiQ9BaYtt8+9+sBkO3I
         +gbgylv9fGtxvclid/4DAGJGQledINHOJrGP+iVwfeso8M6AzSObOdvKuGUKRtCscEXj
         qivwW7AiCepd3RRe+OGZiNp0V/hBsAWuAjCSqPJmN1Nls0de/8YfFisBYRZV2S5eQGxc
         lycIV/2gAI3Q+rBj5opY5+QnYh5CHBKET/u/fDV/dUYXw4iu3mEiUaiLe/n+K3MRFiUI
         uhjg==
X-Gm-Message-State: AHQUAuZBCKlT7R07d+au1bztIHQxmrjcCgSnMq2FAaEfgN60Wy7UTwYK
        MQslnO0Mjp0TLc+q4TMrP2NJXmdttJz0lTckjA1MAQ==
X-Google-Smtp-Source: AHgI3IavQjNZizLFq2wcMla+XeMCelxxm5j0yZGUAL2RB8LzwvkJhkUZDWhDh1sKgFIQn21rLJSOiMALsr/IdGBCcbg=
X-Received: by 2002:a02:9089:: with SMTP id x9mr17429383jaf.72.1550678577068;
 Wed, 20 Feb 2019 08:02:57 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a22cb205738f0f76@google.com>
In-Reply-To: <000000000000a22cb205738f0f76@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Feb 2019 17:02:46 +0100
Message-ID: <CACT4Y+Y3FK1ZFXVzc06Th2pe7CE+b6FyHa-xBS66we8_-GBYeg@mail.gmail.com>
Subject: Re: KASAN: invalid-free in fscache_free_cookie
To:     syzbot <syzbot+c441f41d7e2f04ef32d2@syzkaller.appspotmail.com>,
        v9fs-developer@lists.sourceforge.net,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 5:26 PM syzbot
<syzbot+c441f41d7e2f04ef32d2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    31130a16d459 Merge tag 'for-linus-4.19-rc1-tag' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16676be2400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e8d52931cda051de
> dashboard link: https://syzkaller.appspot.com/bug?extid=c441f41d7e2f04ef32d2
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c441f41d7e2f04ef32d2@syzkaller.appspotmail.com
>
> RDX: 0000000020000380 RSI: 0000000020000c80 RDI: 0000000000000000
> RBP: 00000000009300a0 R08: 0000000020000cc0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
> R13: 00000000004d2768 R14: 00000000004c7be5 R15: 000000000000001f
> ==================================================================
> BUG: KASAN: double-free or invalid-free in fscache_free_cookie+0x230/0x280
> fs/fscache/cookie.c:67

This seems to have been fixed by something (in 9p?). Last happened 4
months ago. Candidate for closure as obsolete.



> CPU: 0 PID: 19158 Comm: syz-executor4 Not tainted 4.18.0+ #190
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>   print_address_description+0x6c/0x20b mm/kasan/report.c:256
>   kasan_report_invalid_free+0x64/0xa0 mm/kasan/report.c:336
>   __kasan_slab_free+0x150/0x170 mm/kasan/kasan.c:501
>   kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>   __cache_free mm/slab.c:3498 [inline]
>   kfree+0xd9/0x260 mm/slab.c:3813
>   fscache_free_cookie+0x230/0x280 fs/fscache/cookie.c:67
>   fscache_alloc_cookie+0x74c/0x880 fs/fscache/cookie.c:202
>   __fscache_acquire_cookie+0x230/0xb00 fs/fscache/cookie.c:303
>   fscache_acquire_cookie include/linux/fscache.h:338 [inline]
>   v9fs_cache_session_get_cookie+0xc4/0x270 fs/9p/cache.c:73
>   v9fs_session_init+0x1013/0x1a80 fs/9p/v9fs.c:464
>   v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
>   mount_fs+0xae/0x328 fs/super.c:1277
>   vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1046
>   vfs_kern_mount fs/namespace.c:1036 [inline]
>   do_new_mount fs/namespace.c:2542 [inline]
>   do_mount+0x581/0x30e0 fs/namespace.c:2872
>   ksys_mount+0x12d/0x140 fs/namespace.c:3088
>   __do_sys_mount fs/namespace.c:3102 [inline]
>   __se_sys_mount fs/namespace.c:3099 [inline]
>   __x64_sys_mount+0xbe/0x150 fs/namespace.c:3099
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457089
> Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f7c72566c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f7c725676d4 RCX: 0000000000457089
> RDX: 0000000020000380 RSI: 0000000020000c80 RDI: 0000000000000000
> RBP: 00000000009300a0 R08: 0000000020000cc0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
> R13: 00000000004d2768 R14: 00000000004c7be5 R15: 000000000000001f
>
> Allocated by task 17919:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>   set_track mm/kasan/kasan.c:460 [inline]
>   kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>   __do_kmalloc mm/slab.c:3718 [inline]
>   __kmalloc+0x14e/0x760 mm/slab.c:3727
>   kmalloc include/linux/slab.h:518 [inline]
>   kzalloc include/linux/slab.h:707 [inline]
>   fscache_set_key fs/fscache/cookie.c:101 [inline]
>   fscache_alloc_cookie+0x701/0x880 fs/fscache/cookie.c:171
>   __fscache_acquire_cookie+0x230/0xb00 fs/fscache/cookie.c:303
>   fscache_acquire_cookie include/linux/fscache.h:338 [inline]
>   v9fs_cache_session_get_cookie+0xc4/0x270 fs/9p/cache.c:73
>   v9fs_session_init+0x1013/0x1a80 fs/9p/v9fs.c:464
>   v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
>   mount_fs+0xae/0x328 fs/super.c:1277
>   vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1046
>   vfs_kern_mount fs/namespace.c:1036 [inline]
>   do_new_mount fs/namespace.c:2542 [inline]
>   do_mount+0x581/0x30e0 fs/namespace.c:2872
>   ksys_mount+0x12d/0x140 fs/namespace.c:3088
>   __do_sys_mount fs/namespace.c:3102 [inline]
>   __se_sys_mount fs/namespace.c:3099 [inline]
>   __x64_sys_mount+0xbe/0x150 fs/namespace.c:3099
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 17919:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>   set_track mm/kasan/kasan.c:460 [inline]
>   __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>   kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>   __cache_free mm/slab.c:3498 [inline]
>   kfree+0xd9/0x260 mm/slab.c:3813
>   fscache_free_cookie+0x230/0x280 fs/fscache/cookie.c:67
>   fscache_cookie_put+0x39d/0x850 fs/fscache/cookie.c:889
>   __fscache_relinquish_cookie+0x494/0x911 fs/fscache/cookie.c:846
>   fscache_relinquish_cookie include/linux/fscache.h:367 [inline]
>   v9fs_cache_session_put_cookie+0x46/0x90 fs/9p/cache.c:87
>   v9fs_session_close+0xf4/0x420 fs/9p/v9fs.c:498
>   v9fs_kill_super+0x4e/0xa0 fs/9p/vfs_super.c:233
>   deactivate_locked_super+0x97/0x100 fs/super.c:326
>   v9fs_mount+0x461/0x900 fs/9p/vfs_super.c:214
>   mount_fs+0xae/0x328 fs/super.c:1277
>   vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1046
>   vfs_kern_mount fs/namespace.c:1036 [inline]
>   do_new_mount fs/namespace.c:2542 [inline]
>   do_mount+0x581/0x30e0 fs/namespace.c:2872
>   ksys_mount+0x12d/0x140 fs/namespace.c:3088
>   __do_sys_mount fs/namespace.c:3102 [inline]
>   __se_sys_mount fs/namespace.c:3099 [inline]
>   __x64_sys_mount+0xbe/0x150 fs/namespace.c:3099
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff8801d8a4a000
>   which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 0 bytes inside of
>   64-byte region [ffff8801d8a4a000, ffff8801d8a4a040)
> The buggy address belongs to the page:
> page:ffffea0007629280 count:1 mapcount:0 mapping:ffff8801dac00340 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea0007234b88 ffffea00072fb488 ffff8801dac00340
> raw: 0000000000000000 ffff8801d8a4a000 0000000100000020 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8801d8a49f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8801d8a49f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8801d8a4a000: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>                     ^
>   ffff8801d8a4a080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>   ffff8801d8a4a100: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ==================================================================
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000a22cb205738f0f76%40google.com.
> For more options, visit https://groups.google.com/d/optout.
