Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35CCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B59D21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cvmd0VNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeLRNTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:19:16 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38217 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeLRNTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:19:16 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so4170312ith.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qO6CnQKCYs65/W6hQYHrGYILyLIVxUEjRluasjk/3I=;
        b=Cvmd0VNsxSA0Wfd1Mmz0ZCVB5c1NBXtZvJcXcnLY1ln433YEAgko7/Jh3oc+h1WZ22
         DsAm7lZ9O9VyrZjSpBi4+b/QWO14HvOHTqcXtLBl9XAkVupezBBC9pOCwxK3gHZbabqt
         2jnnGoj3cGFliAC8KTh9c2vpbSqKKfccv4SFsHbVeKMvKHOikwaoOYnyaQyfEJ4QpXAs
         /LlJJLDX/BnUHJOciv8SidWONwGZqZdTHPHnX3yJ8N3cGFjIHnSGtzWckXSvlRHT+0ZX
         jb357EVgEJMBD+/KBrsdfduuqKCwMz19ErcwkKliSwc6ZJL9GKdvusS336HFcTzp7V/9
         5i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qO6CnQKCYs65/W6hQYHrGYILyLIVxUEjRluasjk/3I=;
        b=np7ZGsn2yQ5u9iZvezh4ofDitWf1oTNL6ZRqVpWkFTMNfYf+XF6rUrk+Zy4lE2YXEA
         DONiSAu/mpjqiuGxxvSDWmdAplF1yoL0tuFY2VnEPlQ594zP6ZA0kjmEat+phcKF2ORK
         Msa6C4TTSk5WYqX5ejWEKhvex76/CdO86/qKdhB16FvrtXdKV3iioZhyQnIwDasY5GH3
         UH0td4grW2gDseU9uhP182lkpzeJfCtpYZUNOwubqOYlPtkIcqDTszqGBBTAwNBIMA5i
         byE3G7jkXBjNS1PUH9b4+W7rZ3+tBQg5IxgD/xdXo9CYXt7PUboZ5DsjGq9vJSyLtdhx
         lJ9A==
X-Gm-Message-State: AA+aEWbQIeJJMx8gntNUFD7pnDe6WREuCjtx/hnPNfs3jmUzDdjRN9tS
        93LC5skZ17LG0JCjRftShLEY/7Vy3HFsGGDttuVXTw==
X-Google-Smtp-Source: AFSGD/WexWk+VQlQQmc7VX1ZyZqGgKRDlB5Yc9BeLRgn3QepV17Xqnv1fxZKe+rruUzi6DQHR/bBpntsI7EIOuXf4j8=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr2618493iti.166.1545139154628;
 Tue, 18 Dec 2018 05:19:14 -0800 (PST)
MIME-Version: 1.0
References: <00000000000051e9c2057d31a563@google.com> <20181217072144.GQ2217@ZenIV.linux.org.uk>
 <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
 <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
 <CACT4Y+a+UAFqOvd8BJ4KB0+48NhoKf0717hdY6XHEcvwG7DJkQ@mail.gmail.com> <8917bbe175172b4fd9c9f92bf2a52443eb2b1827.camel@themaw.net>
In-Reply-To: <8917bbe175172b4fd9c9f92bf2a52443eb2b1827.camel@themaw.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 18 Dec 2018 14:19:03 +0100
Message-ID: <CACT4Y+b7zU9Zp2jcXs6bZ_=abi-udPpbQ54XUHqAiMpbmWszvg@mail.gmail.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 1:42 PM Ian Kent <raven@themaw.net> wrote:
>
> On Tue, 2018-12-18 at 13:27 +0100, Dmitry Vyukov wrote:
> > On Tue, Dec 18, 2018 at 12:35 PM Ian Kent <raven@themaw.net> wrote:
> > >
> > > On Tue, 2018-12-18 at 18:42 +0800, Ian Kent wrote:
> > > > On Mon, 2018-12-17 at 07:21 +0000, Al Viro wrote:
> > > > > On Sun, Dec 16, 2018 at 10:11:04PM -0800, syzbot wrote:
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    d14b746c6c1c Add linux-next specific files for
> > > > > > 20181214
> > > > > > git tree:       linux-next
> > > > > > console output:
> > > > > > https://syzkaller.appspot.com/x/log.txt?x=13706347400000
> > > > > > kernel config:
> > > > > > https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
> > > > > > dashboard link:
> > > > > > https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > > > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > > > syz repro:
> > > > > > https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > > > > > C reproducer:
> > > > > > https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> > > > > >
> > > > > > IMPORTANT: if you fix the bug, please add the following tag to the
> > > > > > commit:
> > > > > > Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > > > > >
> > > > > >  slab_pre_alloc_hook mm/slab.h:423 [inline]
> > > > > >  slab_alloc mm/slab.c:3365 [inline]
> > > > > >  kmem_cache_alloc+0x2c4/0x730 mm/slab.c:3539
> > > > > >  __d_alloc+0xc8/0xb90 fs/dcache.c:1599
> > > > > > ------------[ cut here ]------------
> > > > > > kernel BUG at fs/inode.c:1566!
> > > > > >  d_alloc_anon fs/dcache.c:1698 [inline]
> > > > > >  d_make_root+0x43/0xc0 fs/dcache.c:1885
> > > > > >  autofs_fill_super+0x6f1/0x1c30 fs/autofs/inode.c:273
> > > > >
> > > > > Huh?  BUG is in iput(), AFAICS, so the stack trace is rather
> > > > > misreported.
> > > > > iput() can be called by d_make_root(), provided that dentry allocation
> > > > > fails.  So the most straightforward interpretation would be that we
> > > > > had an allocation failure (injected?), followed by iput() of the inode
> > > > > passed to d_make_root().  Which happened to find I_CLEAR in ->i_state
> > > > > of that inode somehow, which should be impossible short of seriously
> > > > > buggered inode refcounting somewhere - the inode has just been returned
> > > > > by new_inode(), which clears i_state, and it would have to have passed
> > > > > clear_inode() (i.e. has been through inode eviction) since then...
> > > >
> > > > Sorry Al, that's my bad.
> > > >
> > > > See
> > > >
> https://www.ozlabs.org/~akpm/mmotm/broken-out/autofs-fix-possible-inode-leak-in-autofs_fill_super.patch
> > > >
> > > > I think this will fix it, I'll forward it to Andrew if you agree:
> > >
> > > Actually, looking at it again the above patch is plain not needed,
> > > dropping it and updating the patch which follows it in the series
> > > is what needs to be done.
> > >
> > > Andrew, what should I do to make this easiest for you to handle,
> > > a respost with v2 in the subject of the patch affected by dropping
> > > the above patch?
> > >
> > > Or I could repost the series with above patch dropped and the affected
> > > patch corrected?
> >
> > Hi Ian,
> >
> > If you going to amend any commits, please add:
> >     Tested-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > otherwise:
> >     Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
>
> I was thinking about how to handle loosing that information.
>
> I don't think this amounts amending commits since Andrews mmotm is
> based on patch series so dropping a patch and updating patches before
> being merged won't capture this.
>
> Adding the "Tested-by" attribution to the updated patch prior to syzbot
> actually performing the test might be ok since it will get tested along
> the way. Although the problem patch itself won't exist any more so ... ?

I am a bit lost.
There should be some patch that will fix this (new or amended). Either
that patch needs to include Reporter/Tested-by tag, or we will need to
tell syzbot about the fix manually with the "#syz fix:" command.

> OTOH, if I repost the series I think I can send them to syzbot for testing
> before forwarding to Andrew (I've done something like that before but can't
> remember how now) and add the attribution to the series.
>
> But this all depends on what is best for Andrew and what Al would like to
> see done.
