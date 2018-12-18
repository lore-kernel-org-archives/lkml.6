Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C66DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1997E21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Gvik/lzo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xqL6NQzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeLROko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:40:44 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37437 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbeLROkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:40:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 56DE2235BB;
        Tue, 18 Dec 2018 09:40:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 18 Dec 2018 09:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        hglcjg+ALO2lcb3PhwvgYMAXNT2wOZhb9ZXsoiJvtv8=; b=Gvik/lzoZtk0CSBq
        +6CrfIVZSCr5EFekXQamMJ/JzmlKBK9rplMc+44jmM0sTItEffCX3NGP3+g30s1+
        cyXKkLzKNixMVBPnRU2Qt8EV0U1WPHHj7Y3s89k35tO1SnJP7h+eCdSYrJlbkreF
        J3Z+F4e23mNZh6m7HsqFN1+S2tkHLZeIQPNuEiB8HiBxDV2Eq2bwzfX3GK/3tJNg
        +VutcRoFH0/QmW+LadgeJ2czLydeeO+Y6P/2ySHqdmW3xIRTh73MaNzMCoEn/4n0
        QzTCB4X4w0V/1thtTluqvUYLfe/duBGi5H50IJJsDm1xnydrZgtzT0TlD9u74yZF
        D6PPpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=hglcjg+ALO2lcb3PhwvgYMAXNT2wOZhb9ZXsoiJvt
        v8=; b=xqL6NQzBwMjOXtpBpTrpsW7UaQChYjMllFLFeYowcasRcBL7OhLmNqNJk
        3BlePcsMMjkYh1+un6jsOqbI5Y0aHYIlOO+cM0wLFgI7aA8Js4wCpYYFAUKyi/eO
        HSE+9sonSgAogtuIVn5Z1xg9lGDzKiwUnLHkW7I2VKAz3GWBfVqGLqEnDmAy1nbP
        NA1sBMGLz0EyuDDZhWxDSe73qO7oyhohW/wrfSMiK3NSmAPlD9Z5XD38CjiL4bd7
        H63nVlpGPeTLqC4QLY9e4IYUNf63j+M96IL+KKBBgxN9TsUlqFrr/pvK0gjA6YX4
        Od/pWFtefxfwaSeSqcllyAFvnIhfw==
X-ME-Sender: <xms:6QYZXBt2slkhqjD_3gJIy-LKTW0cKlIdfTSkRm0HGXumq4_NN0k_qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeikedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomh
    grihhnucdlgeelmdenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecu
    hfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuff
    homhgrihhnpegrphhpshhpohhtrdgtohhmpdhoiihlrggsshdrohhrghenucfkphepuddu
    kedrvddtledrudekhedrudegudenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:6QYZXEtilJXtoI8DYxA0m_4_sIx8gGeBi-QRMpO-h0m1MxLNj3Dbcg>
    <xmx:6QYZXOHe4kDohCZE7M2dcahlyxPn-XDQU6fks7ntYWrap8XvePVHYg>
    <xmx:6QYZXLj5Pfmuw4XJjHomyrhtL56IwA33LT-7sqJxhA0SNwzo8mlkvg>
    <xmx:6gYZXDzHiroiqqlMsHdyNy04DPQoXCNl0yPCnHHdFXGPAFiPYzj5Vw>
Received: from localhost (unknown [118.209.185.141])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB1FD1026D;
        Tue, 18 Dec 2018 09:40:38 -0500 (EST)
Message-ID: <71040d877679690375cea73177c5c095ab4f9b00.camel@themaw.net>
Subject: Re: kernel BUG at fs/inode.c:LINE!
From:   Ian Kent <raven@themaw.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Tue, 18 Dec 2018 22:40:36 +0800
In-Reply-To: <CACT4Y+b7zU9Zp2jcXs6bZ_=abi-udPpbQ54XUHqAiMpbmWszvg@mail.gmail.com>
References: <00000000000051e9c2057d31a563@google.com>
         <20181217072144.GQ2217@ZenIV.linux.org.uk>
         <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net>
         <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
         <CACT4Y+a+UAFqOvd8BJ4KB0+48NhoKf0717hdY6XHEcvwG7DJkQ@mail.gmail.com>
         <8917bbe175172b4fd9c9f92bf2a52443eb2b1827.camel@themaw.net>
         <CACT4Y+b7zU9Zp2jcXs6bZ_=abi-udPpbQ54XUHqAiMpbmWszvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 14:19 +0100, Dmitry Vyukov wrote:
> On Tue, Dec 18, 2018 at 1:42 PM Ian Kent <raven@themaw.net> wrote:
> > 
> > On Tue, 2018-12-18 at 13:27 +0100, Dmitry Vyukov wrote:
> > > On Tue, Dec 18, 2018 at 12:35 PM Ian Kent <raven@themaw.net> wrote:
> > > > 
> > > > On Tue, 2018-12-18 at 18:42 +0800, Ian Kent wrote:
> > > > > On Mon, 2018-12-17 at 07:21 +0000, Al Viro wrote:
> > > > > > On Sun, Dec 16, 2018 at 10:11:04PM -0800, syzbot wrote:
> > > > > > > Hello,
> > > > > > > 
> > > > > > > syzbot found the following crash on:
> > > > > > > 
> > > > > > > HEAD commit:    d14b746c6c1c Add linux-next specific files for
> > > > > > > 20181214
> > > > > > > git tree:       linux-next
> > > > > > > console output:
> > > > > > > https://syzkaller.appspot.com/x/log.txt?x=13706347400000
> > > > > > > kernel config:
> > > > > > > https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
> > > > > > > dashboard link:
> > > > > > > https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > > > > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > > > > syz repro:
> > > > > > > https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > > > > > > C reproducer:
> > > > > > > https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> > > > > > > 
> > > > > > > IMPORTANT: if you fix the bug, please add the following tag to the
> > > > > > > commit:
> > > > > > > Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > > > > > > 
> > > > > > >  slab_pre_alloc_hook mm/slab.h:423 [inline]
> > > > > > >  slab_alloc mm/slab.c:3365 [inline]
> > > > > > >  kmem_cache_alloc+0x2c4/0x730 mm/slab.c:3539
> > > > > > >  __d_alloc+0xc8/0xb90 fs/dcache.c:1599
> > > > > > > ------------[ cut here ]------------
> > > > > > > kernel BUG at fs/inode.c:1566!
> > > > > > >  d_alloc_anon fs/dcache.c:1698 [inline]
> > > > > > >  d_make_root+0x43/0xc0 fs/dcache.c:1885
> > > > > > >  autofs_fill_super+0x6f1/0x1c30 fs/autofs/inode.c:273
> > > > > > 
> > > > > > Huh?  BUG is in iput(), AFAICS, so the stack trace is rather
> > > > > > misreported.
> > > > > > iput() can be called by d_make_root(), provided that dentry
> > > > > > allocation
> > > > > > fails.  So the most straightforward interpretation would be that we
> > > > > > had an allocation failure (injected?), followed by iput() of the
> > > > > > inode
> > > > > > passed to d_make_root().  Which happened to find I_CLEAR in
> > > > > > ->i_state
> > > > > > of that inode somehow, which should be impossible short of seriously
> > > > > > buggered inode refcounting somewhere - the inode has just been
> > > > > > returned
> > > > > > by new_inode(), which clears i_state, and it would have to have
> > > > > > passed
> > > > > > clear_inode() (i.e. has been through inode eviction) since then...
> > > > > 
> > > > > Sorry Al, that's my bad.
> > > > > 
> > > > > See
> > > > > 
> > 
> > 
https://www.ozlabs.org/~akpm/mmotm/broken-out/autofs-fix-possible-inode-leak-in-autofs_fill_super.patch
> > > > > 
> > > > > I think this will fix it, I'll forward it to Andrew if you agree:
> > > > 
> > > > Actually, looking at it again the above patch is plain not needed,
> > > > dropping it and updating the patch which follows it in the series
> > > > is what needs to be done.
> > > > 
> > > > Andrew, what should I do to make this easiest for you to handle,
> > > > a respost with v2 in the subject of the patch affected by dropping
> > > > the above patch?
> > > > 
> > > > Or I could repost the series with above patch dropped and the affected
> > > > patch corrected?
> > > 
> > > Hi Ian,
> > > 
> > > If you going to amend any commits, please add:
> > >     Tested-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > > otherwise:
> > >     Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > 
> > I was thinking about how to handle loosing that information.
> > 
> > I don't think this amounts amending commits since Andrews mmotm is
> > based on patch series so dropping a patch and updating patches before
> > being merged won't capture this.
> > 
> > Adding the "Tested-by" attribution to the updated patch prior to syzbot
> > actually performing the test might be ok since it will get tested along
> > the way. Although the problem patch itself won't exist any more so ... ?
> 
> I am a bit lost.
> There should be some patch that will fix this (new or amended). Either
> that patch needs to include Reporter/Tested-by tag, or we will need to
> tell syzbot about the fix manually with the "#syz fix:" command.

One of the patches that I forwarded to Andrew was plain wrong, it isn't
actually needed so it needs to be dropped altogether (this one caused
the breakage). Doing so then requires a minor (unrelated) change to the
next of my patches in the series I sent.

Andrew forwards certain patches in his patch queue to to the linux-next
tree. I'm not sure if that is done via a cumulative pull request or via
actual patches.

Whether dropping a patch from Andrews mmotm tree when forwarding his
patch queue to linux-next requires a revert patch rather than just
omitting the dropped patch (which would carry the annotation) or not
I don't know, we'll have to wait and see what Andrew would like me to
do.

> 
> > OTOH, if I repost the series I think I can send them to syzbot for testing
> > before forwarding to Andrew (I've done something like that before but can't
> > remember how now) and add the attribution to the series.
> > 
> > But this all depends on what is best for Andrew and what Al would like to
> > see done.

