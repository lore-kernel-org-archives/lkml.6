Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D863DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4AF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="g08yOayA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNXttDOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeLRLfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:35:06 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38399 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbeLRLfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:35:06 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AB47F236CA;
        Tue, 18 Dec 2018 06:35:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 18 Dec 2018 06:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        roTxGBo5vsIxNuEAXDNgMvoMCdkvUuloVGKuG+rNJ3w=; b=g08yOayAiPj25/vB
        ZIJYqsRhZdM059vXu3lZ5UL3S5OEwfITs2jmcVhqzNUbipeRxXiApHeH6tI5PjVb
        2vbkg5W+dBhnyZuQnCoB1tp/4jRx/9UAkdp0TrPFUuFDJuxwBq+Ds1LUtQfgWGah
        O+oiaAI/cqkWTrp4FzW3ykJy4Vs/PWHXjDs/vflQYWiUyBNjBQLJRxmMk0bAJtc6
        fAy08iU6G6Dxn+kZtddQh/qK+Neh9/xfT/nOBBnTbnvZU1xfqA8ncbjZNR1aLRQB
        CJ9PL1R2SoBWe1AjSTECtvMxLPrQ+JShiEy9Eq4/BHRc/YRRIRuAEnu0G2ljHX9Q
        osmH7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=roTxGBo5vsIxNuEAXDNgMvoMCdkvUuloVGKuG+rNJ
        3w=; b=RNXttDOktvGeHy0EvYOyCL5C3isVVsR17TI6KihS4VrXYj2hQ82j4wXkI
        NhI0gsT72/9eyzpcvb7hhGc/B77YPLBnRI/EJwnYLYp3yBIWixzI2nCBuzQ+3z84
        ADDDNJPbbW0FjZQPJxdZy17iLzYfEPDgRXdvsbL7SW8GlfLCTpgQ08qoA8tCZc2H
        vdgUsqhIAbtcDptFTEQXeVYscTrEmlAVoaERoy6sNyrWemYwOC7FYdKEJYTNkGBv
        GFGmMB7JeY7CBrxFTYNY1DY7JX2SqTraTEIKF3vU4q/RXi1OqbUwHWYK/zcUC0jQ
        cyTi26aoolWPQyShmjUzqZZ/RKv6g==
X-ME-Sender: <xms:aNsYXGNhvzdPXecCyDJ5oUb5KLdLoYU3jihvPm-zKdbctPTNpwCMKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeiiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomh
    grihhnucdlgeelmdenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecu
    hfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuff
    homhgrihhnpegrphhpshhpohhtrdgtohhmpdhoiihlrggsshdrohhrghenucfkphepuddu
    kedrvddtledrudekhedrudegudenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:aNsYXIStGKSZLzbR-r94FTMnmN-CNo81hgA9uamEQauLGYZ7AjZWZA>
    <xmx:aNsYXJFnqG4e_VQXm4aTQZCtqaCllEnW1etcrwDeMK9gqdDFDrVCMA>
    <xmx:aNsYXJ4IpLBlMQp9bsGZXX0qW9eE50pIS8xRY6rtr4jGPbMCji5wig>
    <xmx:aNsYXBHzLFhzbKF38GD_Ed3otmi6vwlhVLe_xaqMYUxAz4bpyQFYGw>
Received: from localhost (unknown [118.209.185.141])
        by mail.messagingengine.com (Postfix) with ESMTPA id 671831026D;
        Tue, 18 Dec 2018 06:35:01 -0500 (EST)
Message-ID: <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
Subject: Re: kernel BUG at fs/inode.c:LINE!
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        DmitryVyukov <dvyukov@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Date:   Tue, 18 Dec 2018 19:34:57 +0800
In-Reply-To: <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
References: <00000000000051e9c2057d31a563@google.com>
         <20181217072144.GQ2217@ZenIV.linux.org.uk>
         <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 18:42 +0800, Ian Kent wrote:
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
> > > dashboard link: 
> > > https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
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
> See 
> https://www.ozlabs.org/~akpm/mmotm/broken-out/autofs-fix-possible-inode-leak-in-autofs_fill_super.patch
> 
> I think this will fix it, I'll forward it to Andrew if you agree:

Actually, looking at it again the above patch is plain not needed,
dropping it and updating the patch which follows it in the series
is what needs to be done.

Andrew, what should I do to make this easiest for you to handle,
a respost with v2 in the subject of the patch affected by dropping
the above patch?

Or I could repost the series with above patch dropped and the affected
patch corrected?

> 
> autofs - fix handling of d_make_root() return in autofs_fill_super()
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
> @@ -271,7 +271,7 @@ int autofs_fill_super(struct super_block *s, void *data,
> int silent)
>  	}
>  	root = d_make_root(root_inode);
>  	if (!root)
> -		goto fail_iput;
> +		goto fail_ino;
>  	pipe = NULL;
>  
>  	root->d_fsdata = ino;
> @@ -347,8 +347,6 @@ int autofs_fill_super(struct super_block *s, void *data,
> int silent)
>  fail_dput:
>  	dput(root);
>  	goto fail_free;
> -fail_iput:
> -	iput(root_inode);
>  fail_ino:
>  	autofs_free_ino(ino);
>  fail_free:
> 

