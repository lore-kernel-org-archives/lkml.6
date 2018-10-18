Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56725C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F0E2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0wBYNU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F0E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJROZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:25:49 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44305 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeJROZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:25:49 -0400
Received: by mail-yb1-f193.google.com with SMTP id x5-v6so11389208ybl.11;
        Wed, 17 Oct 2018 23:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWJXL+NQruBXPh8aEREKDwk9K/ZmS4o/Xi54dtd05wc=;
        b=g0wBYNU8uPUgJaBToKRiohqreDjFDd5FVHsFCMgOEpGHb2A01kPjyU0bV8FdGrd+lx
         Z52WDyTK0+whPtZfUF9RZnqdlUiAFI1MAg+XP2ETc9laX6LhpcdGAADBeJJlOlBgFoZG
         DE9fo3FyHde5CXgWzJkmXIMVQiofZWNDWEWYdanXg3R0xHrm+uz2sCvup96VI4xvPEBY
         g8OFFoiStjXXWCvzGUBFcNkt+NYHtUe951HtaHuZ/4nsKpui4q/NfzTNywUD2zAbyVSr
         ouaX5sXL6CnOQJHsSbk77J39RDP3NHLL4IQhaSBlU30gXtcW9Zzmv3r0nuL56up+tdj0
         U/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWJXL+NQruBXPh8aEREKDwk9K/ZmS4o/Xi54dtd05wc=;
        b=PIhBSbBV6ieRvkCEG+U5fdKAPqQWPwzOO4d0K+fODKg32TaUQS6L/Bj7TvZO3WmEfg
         uM7YmMiQ+j2hjCxEriWEVYVStUo8OTZQ4MfBLd/Z0Jin3n8bBtLXuZNRBYrvZp+6qu72
         HQDab2po7KXoU+JG/UtxTpDdQtHw7vhee9fEYDKPnsBSW45Ja3DvhEkW5S0vwq/e0u1N
         iPI4Xh6KfVpjT9XY6GDH3jy/4/59uz1xwni/p5Ahp9K4DJDeYeOx0hpRwwwbpF7RYwrb
         vnAfJ2QTBQbnCBNOHqtMQeeIJ0H6Vo+J1FWlw/xCtdF9FdKDmkhKGbf5aePmWZnVvtvx
         axww==
X-Gm-Message-State: ABuFfogveDET7OFxAD8TeiahQsqeCbtBw+f2biMEu6/wQXmO34/TMHNX
        lNUyZKsdoJWF5vd5SbtRZZ8F9yu+irJyuqB6mpeHqupS
X-Google-Smtp-Source: ACcGV60x8hML8tJLRyXoUd65n5BbuUHpl+pCSb0XEhHLHPvC/ofC5IM+xF359dXyWeKqceUEh4EvZotpgSwEIl+JIKk=
X-Received: by 2002:a25:5a0a:: with SMTP id o10-v6mr863562ybb.320.1539843982744;
 Wed, 17 Oct 2018 23:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000058404b0578797a9d@google.com>
In-Reply-To: <00000000000058404b0578797a9d@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Oct 2018 09:26:11 +0300
Message-ID: <CAOQ4uxjY1LpVKv1id6W-1nHaKC=RbG8HUkTvgGTdGo8MKwzSTw@mail.gmail.com>
Subject: Re: possible deadlock in ovl_copy_up_start
To:     syzbot+3ef5c0d1a5cb0b21e6be@syzkaller.appspotmail.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 7:48 AM syzbot
<syzbot+3ef5c0d1a5cb0b21e6be@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    c343db455eb3 Merge branch 'parisc-4.19-3' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=167d08ee400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b3f55cb3dfcc6c33
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ef5c0d1a5cb0b21e6be
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.

Reproducer is simple:
link a non-copied-up file into a non-copied-up parent:

~/unionmount-testsuite# ./run --ov -s
~/unionmount-testsuite# ln /mnt/a/foo100 /mnt/a/dir100/

>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3ef5c0d1a5cb0b21e6be@syzkaller.appspotmail.com
>

FYI, this is the fix:
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 276914ae3c60..e1a55ecb7aba 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -663,6 +663,10 @@ static int ovl_link(struct dentry *old, struct
inode *newdir,
        if (err)
                goto out_drop_write;

+       err = ovl_copy_up(new->d_parent);
+       if (err)
+               goto out_drop_write;
+
        if (ovl_is_metacopy_dentry(old)) {
                err = ovl_set_redirect(old, false);
                if (err)

> overlayfs: filesystem on './file0' not supported as upperdir
> XFS (loop3): unknown mount option [uid<00000000000000000000].
>
> kobject: 'loop2' (00000000ce85f3f9): kobject_uevent_env
> ============================================
> WARNING: possible recursive locking detected
> kobject: 'loop2' (00000000ce85f3f9): fill_kobj_path: path
> = '/devices/virtual/block/loop2'
> 4.19.0-rc8+ #65 Not tainted
> --------------------------------------------
> syz-executor2/8184 is trying to acquire lock:
> 00000000d7157f3f (&ovl_i_lock_key[depth]){+.+.}, at:
> ovl_copy_up_start+0x9c/0x2e0 fs/overlayfs/util.c:528
>
> but task is already holding lock:
> 000000006f802695 (&ovl_i_lock_key[depth]){+.+.}, at:
> ovl_nlink_start+0xe0/0x350 fs/overlayfs/util.c:771
>
> other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&ovl_i_lock_key[depth]);
>    lock(&ovl_i_lock_key[depth]);
>
>   *** DEADLOCK ***
>

Can someone tell me what the expected behavior of a nested
mutex_lock_interruptible(&lock); ?

Why does the reproducer only warn and not really deadlock.
It is because that is considered the lesser evil?
and obviously, then inner unlock releases the outer lock?

Thanks,
Amir.
