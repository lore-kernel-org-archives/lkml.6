Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE688C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5B420874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="mLYiKW1h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jP7wiDCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeLRLxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:53:06 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42185 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbeLRLxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:53:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D7668239D8;
        Tue, 18 Dec 2018 06:53:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 18 Dec 2018 06:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        k1URkLMilTORRvmyT3aus3YXsvZd4MDzGIHk0AG/NxQ=; b=mLYiKW1hmT3FzgnO
        z4sGTe/576kKtRrofFLNTZpHUCXTWVgA+ug+TG0jfp+9uZLJrQzD9EJ7V1AUpMQR
        sxYfn1uk6A3iM8MoCvPAVdSXgy8dtmmbtvdVOHZSlCtATx2qz+tuhWOD/ApKPmHa
        MZWzdE/dVEb4rHWtCVTU/Wx8eK0MqlQBjbB9agr9W1R1s2HU7YusMT59LhlsSYq0
        Fl+za14HX5XpdDzO7XjCa+AKKyA0cdEKtLnc+LageUA1auRDZEroMvDDUEjTBxBc
        7yIE9HP3uFA2adTyIH+BQYBjxh9n7Ygb/fMDFemR60ERy26rIFAHgu0PbWLKXA4L
        TZgR+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=k1URkLMilTORRvmyT3aus3YXsvZd4MDzGIHk0AG/N
        xQ=; b=jP7wiDCqltV35fZPcP6a9m+zuHpw74TvKEPJhfS0wmHIEzRsw+7pTPLkw
        iFX4TOxiLhqd5JyOVrwZtIyWKHS2CLjVFDCsFZo2rXBbYlgl+9RSueSmDArjDoBr
        CzoS1YSfc2S9CbU8bBJTYj/Kyo0UZMcApkGAQ7eYfW62aSayzxXv9p3XjEKmwOPn
        B+TCEOpFHxiUpJ9bHbo/fn6sSjGRZaenJt9JoloWUQMwvAyeXIg1PXfdejjKJqNQ
        UxvCaQjTqlO1Zh1B5xnNprk/t2Tq0YAkGrrL6hHjjLl30T1atWzA/HAyxIPnAzJB
        w5f4wvgeXpIEctJ+sNvNmoFuMwK+w==
X-ME-Sender: <xms:oN8YXGkmdOD_hGc6tFD6Q8a07v6MRaxdua9zlInOKJ8R9NSCelR83Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeiiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomh
    grihhnucdlgeelmdenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecu
    hfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuff
    homhgrihhnpegrphhpshhpohhtrdgtohhmpdhoiihlrggsshdrohhrghenucfkphepuddu
    kedrvddtledrudekhedrudegudenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:oN8YXPvtLoDinhnBXQ9qWx6sg-ebNn35mO0PwyWzatoClO6N_LXoDg>
    <xmx:oN8YXJNsrKkRaiDes5KsoL58gzIB2dYS22ShUth0CzKM_Rx6xwUyRQ>
    <xmx:oN8YXINNxSjFM_S2jVpB6cJufYM4Rce_nF1SUE9fVoBku4kxHwGLqQ>
    <xmx:oN8YXIkVqAh2ZJfPvBi3rCA0aDpMvikqfs3-Z2fAAqFIBKnCKwPDXg>
Received: from localhost (unknown [118.209.185.141])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0766310331;
        Tue, 18 Dec 2018 06:53:00 -0500 (EST)
Message-ID: <7c4a27571a51bf8e3f9ed4a35de34f9b3661f908.camel@themaw.net>
Subject: Re: kernel BUG at fs/inode.c:LINE!
From:   Ian Kent <raven@themaw.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Date:   Tue, 18 Dec 2018 19:52:56 +0800
In-Reply-To: <CAOQ4uxjEMppLA64pncx5YJdvYgzkgCP9y9NHndYGp3=Y+jFpwg@mail.gmail.com>
References: <00000000000051e9c2057d31a563@google.com>
         <20181217072144.GQ2217@ZenIV.linux.org.uk>
         <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
         <CAOQ4uxjEMppLA64pncx5YJdvYgzkgCP9y9NHndYGp3=Y+jFpwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 13:01 +0200, Amir Goldstein wrote:
> On Tue, Dec 18, 2018 at 12:43 PM Ian Kent <raven@themaw.net> wrote:
> > 
> > On Mon, 2018-12-17 at 07:21 +0000, Al Viro wrote:
> > > On Sun, Dec 16, 2018 at 10:11:04PM -0800, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot found the following crash on:
> > > > 
> > > > HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=13706347400000
> > > > kernel config:  
> > > > https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
> > > > dashboard link: 
> > > > https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > syz repro:      
> > > > https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> > > > 
> > > > IMPORTANT: if you fix the bug, please add the following tag to the
> > > > commit:
> > > > Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > > > 
> > > >  slab_pre_alloc_hook mm/slab.h:423 [inline]
> > > >  slab_alloc mm/slab.c:3365 [inline]
> > > >  kmem_cache_alloc+0x2c4/0x730 mm/slab.c:3539
> > > >  __d_alloc+0xc8/0xb90 fs/dcache.c:1599
> > > > ------------[ cut here ]------------
> > > > kernel BUG at fs/inode.c:1566!
> > > >  d_alloc_anon fs/dcache.c:1698 [inline]
> > > >  d_make_root+0x43/0xc0 fs/dcache.c:1885
> > > >  autofs_fill_super+0x6f1/0x1c30 fs/autofs/inode.c:273
> > > 
> > > Huh?  BUG is in iput(), AFAICS, so the stack trace is rather misreported.
> > > iput() can be called by d_make_root(), provided that dentry allocation
> > > fails.  So the most straightforward interpretation would be that we
> > > had an allocation failure (injected?), followed by iput() of the inode
> > > passed to d_make_root().  Which happened to find I_CLEAR in ->i_state
> > > of that inode somehow, which should be impossible short of seriously
> > > buggered inode refcounting somewhere - the inode has just been returned
> > > by new_inode(), which clears i_state, and it would have to have passed
> > > clear_inode() (i.e. has been through inode eviction) since then...
> > 
> > Sorry Al, that's my bad.
> > 
> > See 
> > https://www.ozlabs.org/~akpm/mmotm/broken-out/autofs-fix-possible-inode-leak-in-autofs_fill_super.patch
> > 
> > I think this will fix it, I'll forward it to Andrew if you agree:
> > 
> > autofs - fix handling of d_make_root() return in autofs_fill_super()
> 
> You realize you can just revert that patch.
> d_make_root() can take NULL inode as argument.
> At the very least, please mention the offending commit with Fixes tag.

Thanks Amir, I did get that after looking again once the panic
of my stupid mistake passed, ;)

> 
> Thanks,
> Amir.
> 
> > 
> > From: Ian Kent <raven@themaw.net>
> > 
> > A previous change to handle a possible inode leak in autofs_fill_super()
> > added an iput() on d_make_root() failure but d_make_root() already puts
> > the passed in inode on failure.
> > 
> > Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/autofs/inode.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> > index 501833cc49a8..953f76b95172 100644
> > --- a/fs/autofs/inode.c
> > +++ b/fs/autofs/inode.c
> > @@ -271,7 +271,7 @@ int autofs_fill_super(struct super_block *s, void *data,
> > int silent)
> >         }
> >         root = d_make_root(root_inode);
> >         if (!root)
> > -               goto fail_iput;
> > +               goto fail_ino;
> >         pipe = NULL;
> > 
> >         root->d_fsdata = ino;
> > @@ -347,8 +347,6 @@ int autofs_fill_super(struct super_block *s, void *data,
> > int silent)
> >  fail_dput:
> >         dput(root);
> >         goto fail_free;
> > -fail_iput:
> > -       iput(root_inode);
> >  fail_ino:
> >         autofs_free_ino(ino);
> >  fail_free:
> > 

