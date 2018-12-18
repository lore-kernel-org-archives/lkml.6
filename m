Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF81C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0671D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1uJjG3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeLRLB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:01:58 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38052 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:01:58 -0500
Received: by mail-yb1-f196.google.com with SMTP id d187so6307174ybb.5;
        Tue, 18 Dec 2018 03:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrDYjLJE/eObSfRG+eHRnEGE2/PnjT9mNuj07G9Ehmk=;
        b=J1uJjG3eEa85kwaf/O4gdR62fXmX3Ni//gK7nPWd8mbbtWzIIZvfMPgV1L5LKa0ZAh
         dJafmeh8whdWzJS5RGYMKI01RbSTSnisPf+FI52oJT4jDOaHeVdOIHLaxFdfgL+mXIXd
         VG+9AkoLO1i5I1PoU+q+NYBY9IZ0WAqFxinmCOydIR1Nlh2cUL5eZQ52jkAeHbOu0T98
         3eT6pIPeC6OZGeKgqhINhX4wXeEudUX5kFp2F7jk7ffFNQY752sbTPDlYvdBAsCa47Ed
         3t+MYDBJFATB4QN6OYjYeE3BA0wxKmy6tnRTC+ZgeFQ6Lp8X+HKRUFm91p1ZJnNnVQwj
         vhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrDYjLJE/eObSfRG+eHRnEGE2/PnjT9mNuj07G9Ehmk=;
        b=nOt72M05UJu3R3fW2UoNH24YXZhzCOaq9Eg+jkkiQ76x+HBSWPRf+pZSoPPrjt8es/
         d4MGd/4CIU2Slveytq78GQEF2GSUV3Y5rAYAv9NPwX9hV2m5wbEAeFNqlFy9hO1omGrq
         0TwIy2V6ylb/FtSrVzepOObuCZnUMMLK+i8k6cHava4wwHrg4b3s8oMXVFwYB/PUBHkW
         cxp+EQpo3DQTiBASRlGCKUhB8YrdbxGZLGooNis746XQkbUpfqSvkeyMXhiHy++UbIfb
         J+LG0StxYZCX5tbPXfZGqAVhmVJsQqR/KGERh53BNY+rF6WjECRwlMiE1wYC5HVrd+we
         S3RQ==
X-Gm-Message-State: AA+aEWb2LDzQkXqIYHZQ+EvyYqzL7G53MSbwTmu7DmgS9wEFnyGQAiRM
        HrxzAwenaJiklL3LJpIE9XNE6CZ4/Evkc/rjPu4=
X-Google-Smtp-Source: AFSGD/VwTMLvPwy7j+/b73LoLqCDrp6akA1oj45RE6h0lz6BrznJL0owgvzbmSkps/11w25+rKzjThWF756V3FAxtoE=
X-Received: by 2002:a25:ff01:: with SMTP id c1-v6mr16732816ybe.325.1545130916994;
 Tue, 18 Dec 2018 03:01:56 -0800 (PST)
MIME-Version: 1.0
References: <00000000000051e9c2057d31a563@google.com> <20181217072144.GQ2217@ZenIV.linux.org.uk>
 <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
In-Reply-To: <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Dec 2018 13:01:45 +0200
Message-ID: <CAOQ4uxjEMppLA64pncx5YJdvYgzkgCP9y9NHndYGp3=Y+jFpwg@mail.gmail.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:43 PM Ian Kent <raven@themaw.net> wrote:
>
> On Mon, 2018-12-17 at 07:21 +0000, Al Viro wrote:
> > On Sun, Dec 16, 2018 at 10:11:04PM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13706347400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > >
> > >  slab_pre_alloc_hook mm/slab.h:423 [inline]
> > >  slab_alloc mm/slab.c:3365 [inline]
> > >  kmem_cache_alloc+0x2c4/0x730 mm/slab.c:3539
> > >  __d_alloc+0xc8/0xb90 fs/dcache.c:1599
> > > ------------[ cut here ]------------
> > > kernel BUG at fs/inode.c:1566!
> > >  d_alloc_anon fs/dcache.c:1698 [inline]
> > >  d_make_root+0x43/0xc0 fs/dcache.c:1885
> > >  autofs_fill_super+0x6f1/0x1c30 fs/autofs/inode.c:273
> >
> > Huh?  BUG is in iput(), AFAICS, so the stack trace is rather misreported.
> > iput() can be called by d_make_root(), provided that dentry allocation
> > fails.  So the most straightforward interpretation would be that we
> > had an allocation failure (injected?), followed by iput() of the inode
> > passed to d_make_root().  Which happened to find I_CLEAR in ->i_state
> > of that inode somehow, which should be impossible short of seriously
> > buggered inode refcounting somewhere - the inode has just been returned
> > by new_inode(), which clears i_state, and it would have to have passed
> > clear_inode() (i.e. has been through inode eviction) since then...
>
> Sorry Al, that's my bad.
>
> See https://www.ozlabs.org/~akpm/mmotm/broken-out/autofs-fix-possible-inode-leak-in-autofs_fill_super.patch
>
> I think this will fix it, I'll forward it to Andrew if you agree:
>
> autofs - fix handling of d_make_root() return in autofs_fill_super()

You realize you can just revert that patch.
d_make_root() can take NULL inode as argument.
At the very least, please mention the offending commit with Fixes tag.

Thanks,
Amir.

>
> From: Ian Kent <raven@themaw.net>
>
> A previous change to handle a possible inode leak in autofs_fill_super()
> added an iput() on d_make_root() failure but d_make_root() already puts
> the passed in inode on failure.
>
> Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/autofs/inode.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index 501833cc49a8..953f76b95172 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -271,7 +271,7 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
>         }
>         root = d_make_root(root_inode);
>         if (!root)
> -               goto fail_iput;
> +               goto fail_ino;
>         pipe = NULL;
>
>         root->d_fsdata = ino;
> @@ -347,8 +347,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
>  fail_dput:
>         dput(root);
>         goto fail_free;
> -fail_iput:
> -       iput(root_inode);
>  fail_ino:
>         autofs_free_ino(ino);
>  fail_free:
>
