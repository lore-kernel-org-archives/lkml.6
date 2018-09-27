Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC7AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524C62152C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BprosDKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524C62152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeI0KH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:07:57 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37870 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeI0KH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:07:57 -0400
Received: by mail-yw1-f65.google.com with SMTP id y14-v6so529003ywa.4;
        Wed, 26 Sep 2018 20:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPlnEKAjelnvqQsd+l+tKGOsoD5S4l5Zlwky2nsi8vQ=;
        b=BprosDKGYjY6BOl1a53QTcrp5r3Xt/cB4JrmcjY9r2PIY8t/i3eNIPLUHt8e1VYGt8
         fl1EON5bXYtUBuR5krygY9ACWYZmNAyPCdvz8BhvdkHsLt+j9coQVF8DOO9lXszSZLEp
         mvwH9KyjZ2OqL5rIESalU2RGlCf+kjnEU89gWw9YHrprXVGNv15Somt5KKmMFlDCyOY7
         Zqt1GTqIX/dR32BOoka9YCVct/vlJUIT52d5P0R0MtUQQ1gVccQqG3RFU9PXxwVqiR1S
         2FeFbG0vHk+MIuaVLVEdhDjkuJPNp4rRPDjAnRuHFQuaMnoLEkxmUPGftNyZiytHdzuN
         m40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPlnEKAjelnvqQsd+l+tKGOsoD5S4l5Zlwky2nsi8vQ=;
        b=acRHIaj1csGgueUwKYQhaQFwrozg0CkdoLryXAMEPSvJWAkj9EySqT0mhevcCbqYpS
         p7RekKjkfsveaohcrh+Zs95vQxBx1cyTHBrrTT5HLcccQ5VzELxWGnfslYCPYEj657e1
         WdOyghp0ngQdYndflQdUOLibznKKEDz/2t1fgzvQ2Hyz3QghA6fMoLwaOpE814Z1e0Ws
         biLKX/lgZi3jWzXe0WjqJeex6wGnnRqPJYmCpwD0WQZXsma42JzKcNm/x+QAWboJJ7h3
         RwOwYTqOAUusIT/GUgs/CZ6hSRRzWpkK6Lf3pYqHzf6Y77HaIbBXF+arsw06klilsrqr
         mYWg==
X-Gm-Message-State: ABuFfohZgX+6oVgSQz/3oKrB4b8fhd3ZdDbT3QdLieJB5fKynmiSNfQs
        5Kok0/vV/A7x3VOGpJEj32VuEjQqPbQRZFrvPX9OTQ==
X-Google-Smtp-Source: ACcGV63DFHQDt3PKWjp3+tCtayaL6HPgvc+oMrMZpIiM14UmqR1jt0Nqe4q0+ci0UPQ5IRJmdM4HGBdVah0pPtTPIp8=
X-Received: by 2002:a81:6554:: with SMTP id z81-v6mr4716481ywb.34.1538020308516;
 Wed, 26 Sep 2018 20:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000074e10d0576cc48f1@google.com> <CAOQ4uxik7QbQVBQbaPWCxPG90HuJK=T0yckoyfe5NjLHhg898Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxik7QbQVBQbaPWCxPG90HuJK=T0yckoyfe5NjLHhg898Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Sep 2018 06:51:37 +0300
Message-ID: <CAOQ4uxhuJ5r-7M0ngL-rnpMubtGJmuj7YQEHEwWKLj+nUuUpaA@mail.gmail.com>
Subject: Re: possible deadlock in ovl_write_iter
To:     syzbot+695726bc473f9c36a4b6@syzkaller.appspotmail.com,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC: fsdevel]

On Thu, Sep 27, 2018 at 6:48 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Sep 26, 2018 at 11:44 PM syzbot
> <syzbot+695726bc473f9c36a4b6@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    a38523185b40 erge tag 'libnvdimm-fixes-4.19-rc6' of git://..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=178f63fa400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=695726bc473f9c36a4b6
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+695726bc473f9c36a4b6@syzkaller.appspotmail.com
> >
> > Process accounting resumed
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 4.19.0-rc5+ #32 Not tainted
> > ------------------------------------------------------
> > overlayfs: option "workdir=./file1\" is useless in a non-upper mount, ignore
> > syz-executor1/7265 is trying to acquire lock:
> > 00000000fec87ddb (&ovl_i_mutex_key[depth]){+.+.}, at: inode_lock
> > include/linux/fs.h:738 [inline]
> > 00000000fec87ddb (&ovl_i_mutex_key[depth]){+.+.}, at:
> > ovl_write_iter+0x151/0xb00 fs/overlayfs/file.c:231
> >
> > but task is already holding lock:
> > 00000000998db2f0 (&acct->lock#2){+.+.}, at: acct_get kernel/acct.c:161
> > [inline]
> > 00000000998db2f0 (&acct->lock#2){+.+.}, at: slow_acct_process
> > kernel/acct.c:577 [inline]
> > 00000000998db2f0 (&acct->lock#2){+.+.}, at: acct_process+0x48b/0x875
> > kernel/acct.c:605
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #2 (&acct->lock#2){+.+.}:
> > overlayfs: at least 2 lowerdir are needed while upperdir nonexistent
> >         __mutex_lock_common kernel/locking/mutex.c:925 [inline]
> >         __mutex_lock+0x166/0x1700 kernel/locking/mutex.c:1072
> > kobject: 'kvm' (00000000bb4f2ec2): kobject_uevent_env
> >         mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
> >         acct_pin_kill+0x26/0x100 kernel/acct.c:173
> >         pin_kill+0x29d/0xab0 fs/fs_pin.c:50
> > kobject: 'kvm' (00000000bb4f2ec2): fill_kobj_path: path
> > = '/devices/virtual/misc/kvm'
> >         acct_on+0x64a/0x8c0 kernel/acct.c:254
> >         __do_sys_acct kernel/acct.c:286 [inline]
> >         __se_sys_acct kernel/acct.c:273 [inline]
> >         __x64_sys_acct+0xc2/0x1f0 kernel/acct.c:273
> >         do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > -> #1 (sb_writers#3){.+.+}:
> >         percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36
> > [inline]
> >         percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
> >         __sb_start_write+0x214/0x370 fs/super.c:1387
> >         sb_start_write include/linux/fs.h:1566 [inline]
> >         mnt_want_write+0x3f/0xc0 fs/namespace.c:360
> >         ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
> >         ovl_setattr+0x10b/0xaf0 fs/overlayfs/inode.c:30
> >         notify_change+0xbde/0x1110 fs/attr.c:334
> >         do_truncate+0x1bd/0x2d0 fs/open.c:63
> >         handle_truncate fs/namei.c:3008 [inline]
> >         do_last fs/namei.c:3424 [inline]
> >         path_openat+0x3762/0x5160 fs/namei.c:3534
> >         do_filp_open+0x255/0x380 fs/namei.c:3564
> > kobject: 'loop4' (0000000088f052bf): kobject_uevent_env
> >         do_sys_open+0x568/0x700 fs/open.c:1063
> >         ksys_open include/linux/syscalls.h:1276 [inline]
> >         __do_sys_creat fs/open.c:1121 [inline]
> >         __se_sys_creat fs/open.c:1119 [inline]
> >         __x64_sys_creat+0x61/0x80 fs/open.c:1119
> >         do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> > kobject: 'loop4' (0000000088f052bf): fill_kobj_path: path
> > = '/devices/virtual/block/loop4'
> >         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > -> #0
> > kobject: 'kvm' (00000000bb4f2ec2): kobject_uevent_env
> >   (&ovl_i_mutex_key[depth]){+.+.}:
> >         lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
> >         down_write+0x8a/0x130 kernel/locking/rwsem.c:70
> >         inode_lock include/linux/fs.h:738 [inline]
> >         ovl_write_iter+0x151/0xb00 fs/overlayfs/file.c:231
> > kobject: 'kvm' (00000000bb4f2ec2): fill_kobj_path: path
> > = '/devices/virtual/misc/kvm'
> >         call_write_iter include/linux/fs.h:1808 [inline]
> >         new_sync_write fs/read_write.c:474 [inline]
> >         __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
> >         __kernel_write+0x10c/0x370 fs/read_write.c:506
> >         do_acct_process+0x1144/0x1660 kernel/acct.c:520
> >         slow_acct_process kernel/acct.c:579 [inline]
> >         acct_process+0x6b1/0x875 kernel/acct.c:605
> >         do_exit+0x1aaf/0x2610 kernel/exit.c:857
> >         do_group_exit+0x177/0x440 kernel/exit.c:970
> >         get_signal+0x8b0/0x1980 kernel/signal.c:2513
> >         do_signal+0x9c/0x21e0 arch/x86/kernel/signal.c:816
> >         exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
> >         prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
> >         syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
> >         do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
> >         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > other info that might help us debug this:
> >
> > Chain exists of:
> >    &ovl_i_mutex_key[depth] --> sb_writers#3 --> &acct->lock#2
> >
>
> I am not sure this is the root cause, but there seems to be a locking order
> violation in code that replaces accounting file.
> If new file is on the same fs as old file, acct_pin_kill(old) will skip writing
> the file, because sb_writers is still already taken by acct_on().
> If new file is not on same fs as old file, this ordering violation creates
> an unneeded dependency between new_sb_writers and old_sb_writers,
> which may be later reported as possible deadlock.
>
> This could result in an actual deadlock if accounting file is replaced
> from file in overlayfs over "real fs" to file in "real fs".
> acct_on() takes freeze protection on "real fs" and tries to write to
> overlayfs file. overlayfs is not freeze protected so do_acct_process()
> can carry on with __kernel_write() to overlayfs file, which SHOULD
> take "real fs" freeze protection and deadlock.
> Ironically (or not) it doesn't deadlock because of a bug fixed with
> 898cc19d8af2 ovl: fix freeze protection bypass in ovl_write_iter()
> which is not upstream yet, so wasn't in the kernel that syzbot tested.
>
> Following untested patch should fix the alleged deadlock.
>
> Miklos,
>
> If you feel confident about this patch I can re-post it for you to add
> to next. Otherwise, as I didn't see Al around to comment on the patch,
> I will try to reproduce the deadlock.
>
> Thanks,
> Amir.
> ---
>
> diff --git a/kernel/acct.c b/kernel/acct.c
> index addf7732fb56..c09355a7ae46 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -251,8 +251,8 @@ static int acct_on(struct filename *pathname)
>         rcu_read_lock();
>         old = xchg(&ns->bacct, &acct->pin);
>         mutex_unlock(&acct->lock);
> -       pin_kill(old);
>         mnt_drop_write(mnt);
> +       pin_kill(old);
>         mntput(mnt);
>         return 0;
>  }
