Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C593EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78211217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Ayj2piWh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aULoWEZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLRMm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:42:59 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37191 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbeLRMm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:42:58 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8854022110;
        Tue, 18 Dec 2018 07:42:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 18 Dec 2018 07:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        aryWdZNMI+AI1imKr/+4y1z2zJ/1Jnauf0hsXpFvqF8=; b=Ayj2piWhjvBqX5Ew
        3qWqCqT8kuBJYG5TgdXCmBBYAkQ7qKMlzuWckxeRMnZgfRrWC8az5pI/C9+emkrY
        nfxrHyS3q8bdZ8FcmIR4vikIyG54yhAIxLrLM3DTv+2+zkWQ2WexfnOEoruwrvjy
        8pqpSLVeaGT5uY5JEa75cRDPdiI+cSITNzA3IeU26/SUBtLQfhzbkiG+uw/6MgaY
        Y5asMjliMeGQp8i9RTb2vezF7DhPJvy3VI5kqUx0jJ1CgF1oFf/U85gpF003bAuO
        /NpQ/ic56iaCLOdouMZgh0N/6pFbUFCyiuCN7KYszrQu1rZc5VIKz+07TxYzXkK9
        Wh4x0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=aryWdZNMI+AI1imKr/+4y1z2zJ/1Jnauf0hsXpFvq
        F8=; b=aULoWEZXzKkIYYoUMfEF77WdA2UWKSj04v1+MptSmbigUC7RNxOIw8Sh3
        9KfEYEeP8nvamlcRlwAUP1qA37QeiNESS+piAmtRJ6ibgFj57KxvSS7Alyx6cbzJ
        a0QvOLl5DKony56B5gCB9pec1+NRW/BU7nUrr0X5ITzdw6rM4SSJqWyptZ8h+Qhq
        kQ8+pO6OCVHrgBfaFwmxTmH5k5xWJysQkx/sfTi64d2aeytwdgmL8+uimn6a4fSZ
        ujgR2319nb0Z6n2ou9cKECEB/KTGy+jVtvZ1OZeEfMmWqpOseoIsK2DWOouFygYM
        kZIt5lxI5ncaLS1FabRxCfhB+MKzQ==
X-ME-Sender: <xms:UOsYXPq1Np3QklpE9at7vlv9PeT99zjqXzitbcgzbRjmFNXRitYfow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeijedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomh
    grihhnucdlgeelmdenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecu
    hfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuff
    homhgrihhnpegrphhpshhpohhtrdgtohhmpdhoiihlrggsshdrohhrghenucfkphepuddu
    kedrvddtledrudekhedrudegudenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:UOsYXD-Slx8-5H9YGxa5hWrkFcQyIQnfSo8B7cHti0EqE9Vr6iP-bw>
    <xmx:UOsYXEZY4l2HH1uo5pvV2jsWSJSj9IjAt5szpxGcPUKCepzhJgk9aA>
    <xmx:UOsYXN2VJjVYnaq6VmR3TH1l1u1ssG_jeEADtkVbidoPARlFtoFHMQ>
    <xmx:UesYXGzSryrUtBQ6jtip7QicYi0DrKxbYZJGO-aO8ZMr3sFKL5IQyQ>
Received: from localhost (unknown [118.209.185.141])
        by mail.messagingengine.com (Postfix) with ESMTPA id 05DF3E436E;
        Tue, 18 Dec 2018 07:42:53 -0500 (EST)
Message-ID: <8917bbe175172b4fd9c9f92bf2a52443eb2b1827.camel@themaw.net>
Subject: Re: kernel BUG at fs/inode.c:LINE!
From:   Ian Kent <raven@themaw.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Tue, 18 Dec 2018 20:42:50 +0800
In-Reply-To: <CACT4Y+a+UAFqOvd8BJ4KB0+48NhoKf0717hdY6XHEcvwG7DJkQ@mail.gmail.com>
References: <00000000000051e9c2057d31a563@google.com>
         <20181217072144.GQ2217@ZenIV.linux.org.uk>
         <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
         <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
         <CACT4Y+a+UAFqOvd8BJ4KB0+48NhoKf0717hdY6XHEcvwG7DJkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 13:27 +0100, Dmitry Vyukov wrote:
> On Tue, Dec 18, 2018 at 12:35 PM Ian Kent <raven@themaw.net> wrote:
> > 
> > On Tue, 2018-12-18 at 18:42 +0800, Ian Kent wrote:
> > > On Mon, 2018-12-17 at 07:21 +0000, Al Viro wrote:
> > > > On Sun, Dec 16, 2018 at 10:11:04PM -0800, syzbot wrote:
> > > > > Hello,
> > > > > 
> > > > > syzbot found the following crash on:
> > > > > 
> > > > > HEAD commit:    d14b746c6c1c Add linux-next specific files for
> > > > > 20181214
> > > > > git tree:       linux-next
> > > > > console output: 
> > > > > https://syzkaller.appspot.com/x/log.txt?x=13706347400000
> > > > > kernel config:  
> > > > > https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
> > > > > dashboard link:
> > > > > https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > > syz repro:      
> > > > > https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > > > > C reproducer:   
> > > > > https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> > > > > 
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the
> > > > > commit:
> > > > > Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > > > > 
> > > > >  slab_pre_alloc_hook mm/slab.h:423 [inline]
> > > > >  slab_alloc mm/slab.c:3365 [inline]
> > > > >  kmem_cache_alloc+0x2c4/0x730 mm/slab.c:3539
> > > > >  __d_alloc+0xc8/0xb90 fs/dcache.c:1599
> > > > > ------------[ cut here ]------------
> > > > > kernel BUG at fs/inode.c:1566!
> > > > >  d_alloc_anon fs/dcache.c:1698 [inline]
> > > > >  d_make_root+0x43/0xc0 fs/dcache.c:1885
> > > > >  autofs_fill_super+0x6f1/0x1c30 fs/autofs/inode.c:273
> > > > 
> > > > Huh?  BUG is in iput(), AFAICS, so the stack trace is rather
> > > > misreported.
> > > > iput() can be called by d_make_root(), provided that dentry allocation
> > > > fails.  So the most straightforward interpretation would be that we
> > > > had an allocation failure (injected?), followed by iput() of the inode
> > > > passed to d_make_root().  Which happened to find I_CLEAR in ->i_state
> > > > of that inode somehow, which should be impossible short of seriously
> > > > buggered inode refcounting somewhere - the inode has just been returned
> > > > by new_inode(), which clears i_state, and it would have to have passed
> > > > clear_inode() (i.e. has been through inode eviction) since then...
> > > 
> > > Sorry Al, that's my bad.
> > > 
> > > See
> > > 
https://www.ozlabs.org/~akpm/mmotm/broken-out/autofs-fix-possible-inode-leak-in-autofs_fill_super.patch
> > > 
> > > I think this will fix it, I'll forward it to Andrew if you agree:
> > 
> > Actually, looking at it again the above patch is plain not needed,
> > dropping it and updating the patch which follows it in the series
> > is what needs to be done.
> > 
> > Andrew, what should I do to make this easiest for you to handle,
> > a respost with v2 in the subject of the patch affected by dropping
> > the above patch?
> > 
> > Or I could repost the series with above patch dropped and the affected
> > patch corrected?
> 
> Hi Ian,
> 
> If you going to amend any commits, please add:
>     Tested-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> otherwise:
>     Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com

I was thinking about how to handle loosing that information.

I don't think this amounts amending commits since Andrews mmotm is
based on patch series so dropping a patch and updating patches before
being merged won't capture this.

Adding the "Tested-by" attribution to the updated patch prior to syzbot
actually performing the test might be ok since it will get tested along
the way. Although the problem patch itself won't exist any more so ... ?

OTOH, if I repost the series I think I can send them to syzbot for testing
before forwarding to Andrew (I've done something like that before but can't
remember how now) and add the attribution to the series.

But this all depends on what is best for Andrew and what Al would like to
see done.

> 
> Thanks
> 
> > > autofs - fix handling of d_make_root() return in autofs_fill_super()
> > > 
> > > From: Ian Kent <raven@themaw.net>
> > > 
> > > A previous change to handle a possible inode leak in autofs_fill_super()
> > > added an iput() on d_make_root() failure but d_make_root() already puts
> > > the passed in inode on failure.
> > > 
> > > Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > ---
> > >  fs/autofs/inode.c |    4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> > > index 501833cc49a8..953f76b95172 100644
> > > --- a/fs/autofs/inode.c
> > > +++ b/fs/autofs/inode.c
> > > @@ -271,7 +271,7 @@ int autofs_fill_super(struct super_block *s, void
> > > *data,
> > > int silent)
> > >       }
> > >       root = d_make_root(root_inode);
> > >       if (!root)
> > > -             goto fail_iput;
> > > +             goto fail_ino;
> > >       pipe = NULL;
> > > 
> > >       root->d_fsdata = ino;
> > > @@ -347,8 +347,6 @@ int autofs_fill_super(struct super_block *s, void
> > > *data,
> > > int silent)
> > >  fail_dput:
> > >       dput(root);
> > >       goto fail_free;
> > > -fail_iput:
> > > -     iput(root_inode);
> > >  fail_ino:
> > >       autofs_free_ino(ino);
> > >  fail_free:
> > > 

