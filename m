Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9005C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A73214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jkjd48l8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A73214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbeKVFdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:33:01 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35068 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731406AbeKVFdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:33:01 -0500
Received: by mail-yb1-f196.google.com with SMTP id z2-v6so2635894ybj.2;
        Wed, 21 Nov 2018 10:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4oYS75YM4IWbVPPXD2djKR3FyB+TT4dtQ9+y5k60DBI=;
        b=Jkjd48l8j8Wh9lqGjPEcIl0iW3kMjIc2agzRnAeDB3LcpGqJyGLMkkGGBThEhli4iC
         Tk4rZZzTmPKec7GszWY0GAciKFhdpZXlaovSeL3Xlwz4yIiN6lDC0g89D29O42/d+wDX
         co0hq60SMDyEY2A+vL8TsBvec9iJaNxXz0pbaC6suwlkfxhQ+PjtcG/x8PBSRV9OSrve
         LS3uz8s0mguyXOPtn7BlSTXfajXzh0ahdI2wUyerM9gu6gPWqtphDA7jGzH/+JjPVrNf
         o8c+lRWDKVoi1+A2aXtGLXiW788mYDwekqJ+nWw3FBjNVzP9Ocd0G8+kSMxaNYmIN2Bc
         gsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4oYS75YM4IWbVPPXD2djKR3FyB+TT4dtQ9+y5k60DBI=;
        b=SZCrnUccbp6yt8avKCOHPJrXCvspTE2siUyODBD8a0SEdWdahfwi03dwqCIBGwHwMz
         hE9C1YF7VSpZqj0cW/XaKisn0J3+8zR7yscwe/Q18pd2oxUWxCJfhykwI9yxIQGEDPGV
         pNeGR3UKH28iiS/00LE9A7q7+1usjTGi5o6pnbzQcHh1ktEunR3EBUva8UnqhlC2GZ5b
         /S1H/8QrE1RQuyIezul1dEzgV/mwS9oMd6xSUMsZ+7gvAF77/bXws3MYfVZjNqnT5Kym
         cWVD57OFfm1vFAkxoLURBwdU0kiTM5wIlInLeUSXnY1USssEKGIHss2Hb83RmTgAUbSx
         4bqg==
X-Gm-Message-State: AA+aEWYfikyYuCxDFTtn5XtGkeOZ6lQ1L/n+CFrpfBw6JUmNSJWF+Ga5
        MF2JzqC+kjQeVUzbc0ObqmcDZ5A8ta4eFksUNBA=
X-Google-Smtp-Source: AFSGD/W9usZ5njaFiURpl1khfqrGJctdgrvk4bW/RYyUfQEJFdr9AYcIb+8AQK2yFoFmmsepgDYnzgpkrVK/1t3Pqkc=
X-Received: by 2002:a25:ca96:: with SMTP id a144-v6mr3901961ybg.507.1542826648841;
 Wed, 21 Nov 2018 10:57:28 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d03eea0571adfe83@google.com> <000000000000a8e163057b2f2ddf@google.com>
In-Reply-To: <000000000000a8e163057b2f2ddf@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Nov 2018 20:57:17 +0200
Message-ID: <CAOQ4uxhAwdaZnPLX6+qYWaNL6NHQDMptx5TMyzo3B7CCcgWTjg@mail.gmail.com>
Subject: Re: possible deadlock in mnt_want_write
To:     syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 8:33 PM syzbot
<syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a1426d400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
> dashboard link: https://syzkaller.appspot.com/bug?extid=ae82084b07d0297e566b
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1632326d400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a16ed5400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com
>
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.20.0-rc1-next-20181109+ #110 Not tainted
> ------------------------------------------------------
> syz-executor599/5968 is trying to acquire lock:
> 00000000e42cbf00 (sb_writers#3){.+.+}, at: sb_start_write
> include/linux/fs.h:1607 [inline]
> 00000000e42cbf00 (sb_writers#3){.+.+}, at: mnt_want_write+0x3f/0xc0
> fs/namespace.c:359
>
> but task is already holding lock:
> 00000000166f985a (&iint->mutex){+.+.}, at: process_measurement+0x438/0x1bf0
> security/integrity/ima/ima_main.c:224
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&iint->mutex){+.+.}:
>         __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>         __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
>         mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
>         process_measurement+0x438/0x1bf0
> security/integrity/ima/ima_main.c:224
>         ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
>         do_last fs/namei.c:3422 [inline]
>         path_openat+0x134a/0x5150 fs/namei.c:3534
>         do_filp_open+0x255/0x380 fs/namei.c:3564
>         do_sys_open+0x568/0x700 fs/open.c:1063
>         __do_sys_open fs/open.c:1081 [inline]
>         __se_sys_open fs/open.c:1076 [inline]
>         __x64_sys_open+0x7e/0xc0 fs/open.c:1076
>         do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> -> #0 (sb_writers#3){.+.+}:
>         lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
>         percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36
> [inline]
>         percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
>         __sb_start_write+0x214/0x370 fs/super.c:1564
>         sb_start_write include/linux/fs.h:1607 [inline]
>         mnt_want_write+0x3f/0xc0 fs/namespace.c:359
>         ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
>         ovl_open_maybe_copy_up+0x12c/0x190 fs/overlayfs/copy_up.c:888
>         ovl_open+0xb3/0x260 fs/overlayfs/file.c:123
>         do_dentry_open+0x499/0x1250 fs/open.c:771
>         vfs_open fs/open.c:880 [inline]
>         dentry_open+0x143/0x1d0 fs/open.c:896
>         ima_calc_file_hash+0x324/0x570

I suppose ima_calc_file_hash opens the file with write flags
and cause overlay to try to copy up which takes mnt_want_write().
Why does IMA need to open the file with write flags?

Isn't this commit supposed to prevent that:
a408e4a86b36 ima: open a new file instance if no read permissions

Thanks,
Amir.
