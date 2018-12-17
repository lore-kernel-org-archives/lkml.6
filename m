Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5601C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDC520874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5LPYNtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeLQKIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:08:44 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52605 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLQKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:08:43 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so17913873itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 02:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYU3/niVEdCI4A/m0yKlw7r5wxDKAgJQR0NJd9gNFbY=;
        b=r5LPYNtJDudm1AeWBPk6yECpFJFOZeRj4UULJBSPiYHyCEeTgegG34uMrQEMVBTEcI
         ecxVDLVI+TbmZfiiunZkjgTPPfJ61UxWjE5XFt42UpTFwB8S/iG4lnTCIe0Y5lN4nJ1Y
         aynaiikgLL1iKdtm2ap38YZlqKLwCX3BkSAOwzXW9LEzgnl0FnnHh++IWr0F2G891xmf
         SGZ9PyGv/sNXTfYS4//sCZy0sYZuTuX2n/CDxR2cWI99jx/b6yzHNsJUbFVoXeSQjega
         EbsdxnDXJ2tVyzAOu4OkIFq67qXNo/REQXQyq89KLtmNxtvkvOKL2GnJG3Ejin8NCWcH
         YnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYU3/niVEdCI4A/m0yKlw7r5wxDKAgJQR0NJd9gNFbY=;
        b=MrSbE2GHkwmQNaHZ6mW+SLNqHYMSXYodC99/TT7v/FGPAH1pEZgOnCaFnbng0TNE8z
         YpwKE5por6xxS4MLPyCGPPGA6sY8fOJ/zM+uJxnuo1h3EETad0QK6hPFRxo74SngRNmY
         SWYL0rEXnndzuFbytfBwbbN35HmmirpVqd9ZDujr7dO63OO35OqzhENcPsM7Z/Uaph5M
         YWccIzEW7AAR8y2T0YcvhJkLUA3FHuSe8HBREyCl+5WWPwE2XTVsHSgAXTFaZu05yf3V
         RGKMVt5QWhtestPStw3Ji+DHYgxp8RKHFXHhntmeoqvBBhKC9cWmjK3/bHDRExKKF8Pp
         LXmg==
X-Gm-Message-State: AA+aEWbr7+8ErtQOkK/MIFVzLCysUoczCxQCqvA9rZNkzGtO1dJgMh4F
        Yr4wxE1JKqZAhGChbNH6a6q7m40kjJ7zILKOwsFD1g==
X-Google-Smtp-Source: AFSGD/VyAwWtIYPKDxHmMir+SVcGHqTJP6OzkPhr8i5SP7sxqgiUkAZvgidCOQ2rHztPb/l7dd+TrWtkBnxNxy8MYRM=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr10255055itl.144.1545041322440;
 Mon, 17 Dec 2018 02:08:42 -0800 (PST)
MIME-Version: 1.0
References: <00000000000051e9c2057d31a563@google.com> <20181217072144.GQ2217@ZenIV.linux.org.uk>
In-Reply-To: <20181217072144.GQ2217@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Dec 2018 11:08:31 +0100
Message-ID: <CACT4Y+Zeyfd693tMa4eTqSWYCBK+55_Lt3tzk2MckFa2KoFGuw@mail.gmail.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 8:21 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Dec 16, 2018 at 10:11:04PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13706347400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> >
> >  slab_pre_alloc_hook mm/slab.h:423 [inline]
> >  slab_alloc mm/slab.c:3365 [inline]
> >  kmem_cache_alloc+0x2c4/0x730 mm/slab.c:3539
> >  __d_alloc+0xc8/0xb90 fs/dcache.c:1599
> > ------------[ cut here ]------------
> > kernel BUG at fs/inode.c:1566!
> >  d_alloc_anon fs/dcache.c:1698 [inline]
> >  d_make_root+0x43/0xc0 fs/dcache.c:1885
> >  autofs_fill_super+0x6f1/0x1c30 fs/autofs/inode.c:273
>
> Huh?  BUG is in iput(), AFAICS, so the stack trace is rather misreported.

Yes, it's a known problem that kernel is generally incapable of
producing parsable crash reports. I think Tetsuo is working on a
solution, but it takes very large amount of discussions and months of
time.

> iput() can be called by d_make_root(), provided that dentry allocation
> fails.  So the most straightforward interpretation would be that we
> had an allocation failure (injected?), followed by iput() of the inode
> passed to d_make_root().  Which happened to find I_CLEAR in ->i_state
> of that inode somehow, which should be impossible short of seriously
> buggered inode refcounting somewhere - the inode has just been returned
> by new_inode(), which clears i_state, and it would have to have passed
> clear_inode() (i.e. has been through inode eviction) since then...

Yes, there are injected failures in the log.
And the repro says:

#{..."fault":true,"fault_call":1,"fault_nth":36 ...}
mkdir(&(0x7f0000000140)='./file0\x00', 0x0)
mount(0x0, &(0x7f0000000100)='./file0\x00',
&(0x7f0000000180)='autofs\x00', 0x0, 0x0)

Since the repro is single-threaded, I would expect that the bug is
directly on the error handling path of the failure allocation.
