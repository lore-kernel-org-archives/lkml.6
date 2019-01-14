Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBE6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C032086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPM3ObqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfANPNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:13:21 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37531 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfANPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:13:20 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so12567173iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMCXzL11zZdJVKGyjjgOTE2yfPh/IHwve6ZGuNPVeTI=;
        b=bPM3ObqZ7wNRQqHo6udocbzvBUUad2nKKUo94fqLj7tpcYeG3CF497NhOlrAERaRoz
         gCBfS3MDDnAzBavn9qiqznvU1n+2Ps1r4qqzlwr+yw+fBfb5xQCYwEA33J2jashiT/+S
         irKDIFk5W0eyGgOi4CPttgiqkElju67Z8vViXu25y80cxW4HDVJYbrCErp48dFZde98d
         SlFF09tkBq0cwQhnQd0vVXyuQtErt+NI7KSCvxBPNPGk71hWKAfVRvY/z1FHHyn9oVnk
         SQnbn9BxjRyqvxrTmnPMta40Nt7JJ9AZDj4GktaOwRFLeN1c8z8UOI/vqn8oy8Xnf6QZ
         uRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMCXzL11zZdJVKGyjjgOTE2yfPh/IHwve6ZGuNPVeTI=;
        b=QxmNhPkttj5QYwYPkDWQFRvmRHd/NtETf4rqCkLBYCgBD8cUdLuR/wGJ7cSPYcF+Bt
         e54ysiKVc/i6hMxO4oAcPh9n4A62wZjU4sMKlKsioSMwPYsXZukEDUxBTdNpEm14fBc9
         Pew+xujh1PMjzOzzQn55G0sXP8T1y6W87g1ihQiu7+rsPpbTf87WyKklE4UVgi5rSrYk
         pFpZCP0L6oHoAXl3e6q+KCNeAYGvTgRKnlItbjkJ9JnGGcuvmN6U3zab1pLrx1lQSwqq
         nEZtsOPr17G3/creKsCPaLYwwxy0l3/NA/phS6THvSH7ZHeYQ5Go6qnDgYqEsbKV6ocT
         rIyw==
X-Gm-Message-State: AJcUukdDqxwKm8uhdJSZrVYij8v1tbOBDrFVPk7ccI9aswsx6yQWKzRF
        Q6w92m6vwXZcZRdAvmfWyEiVdhE01J7NyySRYTnV6g==
X-Google-Smtp-Source: ALg8bN5WvRBfsqOLCDSOWVe3ja+2vFpW/mx+e9eVUh4JxAQUQhx81xNKLW2YjG5ZKS+d5NNirpMkehWjvNXHgdehtyY=
X-Received: by 2002:a02:97a2:: with SMTP id s31mr17110047jaj.82.1547478799163;
 Mon, 14 Jan 2019 07:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20180720130602.f3d6dc4c943558875a36cb52@linux-foundation.org>
 <a2df1f24-f649-f5d8-0b2d-66d45b6cb61f@i-love.sakura.ne.jp>
 <20180806100928.x7anab3c3y5q4ssa@quack2.suse.cz> <e8a23623-feaf-7730-5492-b329cb0daa21@i-love.sakura.ne.jp>
 <20190102144015.GA23089@quack2.suse.cz> <275523c6-f750-44c2-a8a4-f3825eeab788@i-love.sakura.ne.jp>
 <20190102172636.GA29127@quack2.suse.cz> <bf209c90-3624-68cd-c0db-86a91210f873@i-love.sakura.ne.jp>
 <20190108112425.GC8076@quack2.suse.cz> <CACT4Y+bxUJ-6dLch+orY0AcjrvJhXq1=ELvHciX5M-gd5bdPpA@mail.gmail.com>
 <20190109133006.GG15397@quack2.suse.cz> <CACT4Y+bTos-xu42v4D_5JCkymjPsEFM3hiYydmnXV4fpV=sRoQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bTos-xu42v4D_5JCkymjPsEFM3hiYydmnXV4fpV=sRoQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Jan 2019 16:13:08 +0100
Message-ID: <CACT4Y+ZWQdzUPPwb8_KtMSwrjb_209TcN5hbUzNbUKN7dmx6oA@mail.gmail.com>
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
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tim.c.chen@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 4:11 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jan 9, 2019 at 2:30 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 08-01-19 12:49:08, Dmitry Vyukov wrote:
> > > On Tue, Jan 8, 2019 at 12:24 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Tue 08-01-19 19:04:06, Tetsuo Handa wrote:
> > > > > On 2019/01/03 2:26, Jan Kara wrote:
> > > > > > On Thu 03-01-19 01:07:25, Tetsuo Handa wrote:
> > > > > >> On 2019/01/02 23:40, Jan Kara wrote:
> > > > > >>> I had a look into this and the only good explanation for this I have is
> > > > > >>> that sb->s_blocksize is different from (1 << sb->s_bdev->bd_inode->i_blkbits).
> > > > > >>> If that would happen, we'd get exactly the behavior syzkaller observes
> > > > > >>> because grow_buffers() would populate different page than
> > > > > >>> __find_get_block() then looks up.
> > > > > >>>
> > > > > >>> However I don't see how that's possible since the filesystem has the block
> > > > > >>> device open exclusively and blkdev_bszset() makes sure we also have
> > > > > >>> exclusive access to the block device before changing the block device size.
> > > > > >>> So changing block device block size after filesystem gets access to the
> > > > > >>> device should be impossible.
> > > > > >>>
> > > > > >>> Anyway, could you perhaps add to your debug patch a dump of 'size' passed
> > > > > >>> to __getblk_slow() and bdev->bd_inode->i_blkbits? That should tell us
> > > > > >>> whether my theory is right or not. Thanks!
> > > > > >>>
> > > > >
> > > > > Got two reports. 'size' is 512 while bdev->bd_inode->i_blkbits is 12.
> > > > >
> > > > > https://syzkaller.appspot.com/text?tag=CrashLog&x=1237c3ab400000
> > > > >
> > > > > [  385.723941][  T439] kworker/u4:3(439): getblk(): executed=9 bh_count=0 bh_state=0 bdev_super_blocksize=512 size=512 bdev_super_blocksize_bits=9 bdev_inode_blkbits=12
> > > > > (...snipped...)
> > > > > [  568.159544][  T439] kworker/u4:3(439): getblk(): executed=9 bh_count=0 bh_state=0 bdev_super_blocksize=512 size=512 bdev_super_blocksize_bits=9 bdev_inode_blkbits=12
> > > >
> > > > Right, so indeed the block size in the superblock and in the block device
> > > > gets out of sync which explains why we endlessly loop in the buffer cache
> > > > code. The superblock uses blocksize of 512 while the block device thinks
> > > > the set block size is 4096.
> > > >
> > > > And after staring into the code for some time, I finally have a trivial
> > > > reproducer:
> > > >
> > > > truncate -s 1G /tmp/image
> > > > losetup /dev/loop0 /tmp/image
> > > > mkfs.ext4 -b 1024 /dev/loop0
> > > > mount -t ext4 /dev/loop0 /mnt
> > > > losetup -c /dev/loop0
> > > > l /mnt
> > > > <hangs>
> > > >
> > > > And the problem is that LOOP_SET_CAPACITY ioctl ends up reseting block
> > > > device block size to 4096 by calling bd_set_size(). I have to think how to
> > > > best fix this...
> > > >
> > > > Thanks for your help with debugging this!
> > >
> > > Wow! I am very excited.
> > > We have 587 open "task hung" reports, I suspect this explains lots of them.
> > > What would be some pattern that we can use to best-effort distinguish
> > > most manifestations? Skimming through few reports I see "inode_lock",
> > > "get_super", "blkdev_put" as common indicators. Anything else?
> >
> > Well, there will be always looping task with __getblk_gfp() on its stack
> > (which should be visible in the stacktrace generated by the stall
> > detector). Then there can be lots of other processes getting blocked due to
> > locks and other resources held by this task...
>
>
> Once we have a fix, I plan to do a sweep over existing open "task
> hung" reports and dup lots of them onto this one. Probably preferring
> to over-sweep rather then to under-sweep because there are too many of
> them and lots does not seem to be actionable otherwise.
> Tetsuo, do you have comments before I start?

Also, is it possible to add some kind of WARNING for this condition?
Taking into account how much effort it too to debug, looks like a
useful check. Or did I ask this already...
