Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FD2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84D2218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hu8c64FW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfABOqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:46:45 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34822 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfABOqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:46:45 -0500
Received: by mail-io1-f68.google.com with SMTP id f4so6412772ion.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 06:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssOylOFcF/4KrKPUHFHedcc63NWFBF7CN1ijXigKLks=;
        b=Hu8c64FWXWCWtwxZ0SDsWoQ6Ffc0Wnxg4h0SXXIHS06rNFT+ggjOOqeIs18GADdMwX
         0VL9Wo7GjDUaivVN/6hvwbzXFVUuZm5jvU+jcihGQ7StX5k+4ienaF53vPT+/J5dIWJh
         /ubQ1KPC7yauZNyptLJDVXmwutvoPVdIK4M4jhMR3geQ/Dib1apPGJsyQ7axzzgLoVNg
         OKZxYhwyI/Fs8Io7oYqL20j/1HfVAlbd5wxijs4mR/ydarQGM7cc9IH/TyLbs0MS13Ai
         jjyYEq5Wt0JwgT3je9CnWZ1HY64y/u/JSakpOCftKt9vltL9XUg6p3RB5xL92Jdr6Lfn
         iVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssOylOFcF/4KrKPUHFHedcc63NWFBF7CN1ijXigKLks=;
        b=OTXIpZGw7AzraNGiOkEqp1lbEvlzeBE5bFs+yKm9ISfcBCHUa8VRVMVWAmhZb2UhCv
         /Nf6ZgYpBAn8lX81zPsjsA1wCwLwe5vSavK1aYZIB9yYjPHyeZ6Fj0ci6+auTxtqQtrL
         nnMNlreSD8Xr4g5VQlmF6XRDU9lL52QC1Y7ROt0wULuy2suTcmh04hPtiTj1f98Un+Nn
         BIn2cVUU8OBR8bijckgbGST54XNnvd/N6F7L4CPofxFqxYgO1cgnaEYeOPJY833DE04I
         AkwgSlmp9IVItz9TL9ALczutt1K6NyapU7uOwGaQD3pKV7+jsuTbbETZv6M9ewKuWquF
         5orQ==
X-Gm-Message-State: AJcUuke5x8ktK1gXxcGhtVuybwZkIDtsryVet3f79mT4YNvKWr7GVrIc
        wEvrGUHPWSyzUoSED1OoESu0v+KOUhWTQMjN2XKAbODm5pgUgg==
X-Google-Smtp-Source: ALg8bN6xvELljIEO7Hs5tNmXuelgU8TmJW4Oq6YeAmF6anfy2jeNK9LnsxyJsKk3jrRTIKBkjsopXw8a7FHZa8xRH7g=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr5006917ior.282.1546440403796;
 Wed, 02 Jan 2019 06:46:43 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009ce88d05714242a8@google.com> <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
 <9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp>
 <20180720130602.f3d6dc4c943558875a36cb52@linux-foundation.org>
 <a2df1f24-f649-f5d8-0b2d-66d45b6cb61f@i-love.sakura.ne.jp>
 <20180806100928.x7anab3c3y5q4ssa@quack2.suse.cz> <e8a23623-feaf-7730-5492-b329cb0daa21@i-love.sakura.ne.jp>
 <20190102144015.GA23089@quack2.suse.cz>
In-Reply-To: <20190102144015.GA23089@quack2.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Jan 2019 15:46:32 +0100
Message-ID: <CACT4Y+ZoVGsG=nDHffEMi-89AT6_0dzJB-zgT8xXTaMQ4JHgTQ@mail.gmail.com>
Subject: Re: INFO: task hung in generic_file_write_iter
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, jlayton@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tim.c.chen@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 3:40 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 28-12-18 22:34:13, Tetsuo Handa wrote:
> > On 2018/08/06 19:09, Jan Kara wrote:
> > > On Tue 31-07-18 00:07:22, Tetsuo Handa wrote:
> > >> On 2018/07/21 5:06, Andrew Morton wrote:
> > >>> On Fri, 20 Jul 2018 19:36:23 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> > >>>
> > >>>>>
> > >>>>> This report is stalling after mount() completed and process used remap_file_pages().
> > >>>>> I think that we might need to use debug printk(). But I don't know what to examine.
> > >>>>>
> > >>>>
> > >>>> Andrew, can you pick up this debug printk() patch?
> > >>>> I guess we can get the result within one week.
> > >>>
> > >>> Sure, let's toss it in -next for a while.
> > >>>
> > >>>> >From 8f55e00b21fefffbc6abd9085ac503c52a302464 Mon Sep 17 00:00:00 2001
> > >>>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > >>>> Date: Fri, 20 Jul 2018 19:29:06 +0900
> > >>>> Subject: [PATCH] fs/buffer.c: add debug print for __getblk_gfp() stall problem
> > >>>>
> > >>>> Among syzbot's unresolved hung task reports, 18 out of 65 reports contain
> > >>>> __getblk_gfp() line in the backtrace. Since there is a comment block that
> > >>>> says that __getblk_gfp() will lock up the machine if try_to_free_buffers()
> > >>>> attempt from grow_dev_page() is failing, let's start from checking whether
> > >>>> syzbot is hitting that case. This change will be removed after the bug is
> > >>>> fixed.
> > >>>
> > >>> I'm not sure that grow_dev_page() is hanging.  It has often been
> > >>> suspected, but always is proven innocent.  Lets see.
> > >>
> > >> syzbot reproduced this problem ( https://syzkaller.appspot.com/text?tag=CrashLog&x=11f2fc44400000 ) .
> > >> It says that grow_dev_page() is returning 1 but __find_get_block() is failing forever. Any idea?
> > >
> > > Looks like some kind of a race where device block size gets changed while
> > > getblk() runs (and creates buffers for underlying page). I don't have time
> > > to nail it down at this moment can have a look into it later unless someone
> > > beats me to it.
> >
> > I feel that the frequency of hitting this problem was decreased
> > by merging loop module's ioctl() serialization patches. But this
> > problem is still there, and syzbot got a new line in
> > https://syzkaller.appspot.com/text?tag=CrashLog&x=177f889f400000 .
> >
> >   [  615.881781] __loop_clr_fd: partition scan of loop5 failed (rc=-22)
> >   [  619.059920] syz-executor4(2193): getblk(): executed=cd bh_count=0 bh_state=29
> >   [  622.069808] syz-executor4(2193): getblk(): executed=9 bh_count=0 bh_state=0
> >   [  625.080013] syz-executor4(2193): getblk(): executed=9 bh_count=0 bh_state=0
> >   [  628.089900] syz-executor4(2193): getblk(): executed=9 bh_count=0 bh_state=0
> >
> > I guess that loop module is somehow related to this problem.
>
> I had a look into this and the only good explanation for this I have is
> that sb->s_blocksize is different from (1 << sb->s_bdev->bd_inode->i_blkbits).
> If that would happen, we'd get exactly the behavior syzkaller observes
> because grow_buffers() would populate different page than
> __find_get_block() then looks up.
>
> However I don't see how that's possible since the filesystem has the block
> device open exclusively and blkdev_bszset() makes sure we also have
> exclusive access to the block device before changing the block device size.
> So changing block device block size after filesystem gets access to the
> device should be impossible.

If this is that critical and impossible to fire, maybe it makes sense
to add a corresponding debug check to some code paths?
syzkaller will immediately catch any violations if they happen.


> Anyway, could you perhaps add to your debug patch a dump of 'size' passed
> to __getblk_slow() and bdev->bd_inode->i_blkbits? That should tell us
> whether my theory is right or not. Thanks!
