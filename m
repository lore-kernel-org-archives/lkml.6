Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DB1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15098208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15098208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbeGPXnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 19:43:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60930 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbeGPXnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 19:43:47 -0400
Received: from mail-oi0-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1ffCgz-0003X4-BO
        for linux-kernel@vger.kernel.org; Mon, 16 Jul 2018 23:14:09 +0000
Received: by mail-oi0-f72.google.com with SMTP id p11-v6so48285673oih.17
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 16:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sQgLkfZv1x5d9eY0EqtlNlknmmlr8OugG0X0palV0Y0=;
        b=Z+XD5WiG9Z85WmnSgA/R1acvEiFhdiqwNpmOIETxKNghvVV7425waF2MwRjR/hF/8B
         LvOtzpCWJoLtyuxEZXuy0QVl6LE4GJBYdXNOtUh5pntET4k8bNha/vE+8/su/V6QoL7V
         CDSqB6hsUl9W1NkqAPeNmvg/PfeOmLHHKNed77vDjMpYqstLqAYM29Kngk4NaCKswWb3
         sICp6T2xRtr/s6uRzkTGwrU7QSsFFsoXaRKsWzgy1QAkBRt53fHrWmNDy571iiOSNtSx
         8LuIPdz8mhOEwioUm8lZpFB3xRHA/IXqZRK7PXYFG1QhDVhsf/JGAHX5jdtfiv+9SWK/
         wWmg==
X-Gm-Message-State: AOUpUlFoPZyotFQJuaxktkLcJgM3GZLp8upkZlfrbxDcyt0iZQHnODJH
        puX0/+ye3upmhI8u9cttdlitEsgipHQtOOgWAX0bV4/sle77PYpydwbV0v8zkRC5dT91iRihNQ5
        NplZKYc8bXHuLt02KzYc2RiP2fzq7cje3aAcW20aXfgzmXLqYk1aVQbUYOA==
X-Received: by 2002:aca:52d1:: with SMTP id g200-v6mr1397699oib.134.1531782847464;
        Mon, 16 Jul 2018 16:14:07 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpe3JUdWLH6eGU+ivLIxu18xo1kpTT3qQ0xbo70q+7WLDucpPbH7YrMpNPHyWfAqSl6cbPgG0u1DOLN/HxCg1AE=
X-Received: by 2002:aca:52d1:: with SMTP id g200-v6mr1397684oib.134.1531782847174;
 Mon, 16 Jul 2018 16:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180706174324.GA3049@xps13.dannf> <20180707041018.GB3546@thunk.org>
 <20180710165143.GA20459@xps13.dannf> <20180710204329.GB20459@xps13.dannf>
 <b39169ad-2237-0a4f-e3d1-afc51ac10fa5@canonical.com> <20180712230826.GB28610@thunk.org>
 <CALdTtns1yL6z3mvWF70bXvpB0hXFgfRxdTg+sBTMzJKG7L7prA@mail.gmail.com>
In-Reply-To: <CALdTtns1yL6z3mvWF70bXvpB0hXFgfRxdTg+sBTMzJKG7L7prA@mail.gmail.com>
From:   dann frazier <dann.frazier@canonical.com>
Date:   Mon, 16 Jul 2018 17:13:56 -0600
Message-ID: <CALdTtntvwdL02Nn69-QQ8EwKChoVJ-3FXqfNh+po_RZji76KQQ@mail.gmail.com>
Subject: Re: [Bisect] ext4_validate_inode_bitmap:98: comm stress-ng: Corrupt
 inode bitmap
To:     "Theodore Ts'o" <tytso@mit.edu>, Ike Pan <ike.pan@canonical.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanaijie@huawei.com, Colin King <colin.king@canonical.com>,
        Kamal Mostafa <kamal.mostafa@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 5:21 AM dann frazier <dann.frazier@canonical.com> wrote:
>
> On Thu, Jul 12, 2018 at 5:08 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > >
> > > Review console log and on each run I have filesystem rebuild. The problem
> > > is that mke2fs I am using is 1.44.3-rc2. I am now reseting the environment
> > > and re-test.
> > >
> >
> > Could it be that you saw the error in ext4_validate_block_bitmap()?
>
> Looks like it. From Ike's report:
>
> # grep EXT4 d05-4-ipmi.log
> [ 26.215587] EXT4-fs (sdb2): mounted filesystem with ordered data
> mode. Opts: (null)
> [ 29.844105] EXT4-fs (sdb2): re-mounted. Opts: errors=remount-ro
> [ 3586.211348] EXT4-fs error (device sda2):
> ext4_validate_block_bitmap:383: comm stress-ng: bg 4705: bad block
> bitmap checksum
> [ 8254.776992] EXT4-fs error (device sda2):
> ext4_validate_block_bitmap:383: comm stress-ng: bg 4193: bad block
> bitmap checksum
>
> I've ran my test case for several days w/ just the inode bitmap fix
> and haven't been able to reproduce it - but perhaps that's just the
> nature of the chdir test.

hey Ted,

Turns out the stress-ng 'mknod' test and - less reliably - the
'dentry' test can tickle the "bad block bitmap checksum" bug pretty
easily. stress-ng wasn't *detecting* the error, but Colin has just
released a new version that does. We've been running with your updated
patch on 3 machines for several iterations, and have not seen another
occurrence.

  -dann

> > The patch which I sent Dann only fixed the problem for inode bitmaps;
> > I noticed today that we need to fix it for block allocation bitmaps as
> > well.
>
> I've also now ran several iterations w/ the block bitmap fix as well,
> and still no problems, so:
>
> Tested-by: dann frazier <dann.frazier@canonical.com>
>
> > commit 8d5a803c6a6ce4ec258e31f76059ea5153ba46ef
> > Author: Theodore Ts'o <tytso@mit.edu>
> > Date:   Thu Jul 12 19:08:05 2018 -0400
> >
> >     ext4: check for allocation block validity with block group locked
> >
> >     With commit 044e6e3d74a3: "ext4: don't update checksum of new
> >     initialized bitmaps" the buffer valid bit will get set without
> >     actually setting up the checksum for the allocation bitmap, since the
> >     checksum will get calculated once we actually allocate an inode or
> >     block.
> >
> >     If we are doing this, then we need to (re-)check the verified bit
> >     after we take the block group lock.  Otherwise, we could race with
> >     another process reading and verifying the bitmap, which would then
> >     complain about the checksum being invalid.
> >
> >     https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1780137
> >
> >     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> >     Cc: stable@kernel.org
>
> Would it also make sense to add the following?
>
> Fixes: 044e6e3d74a3 ("ext4: don't update checksum of new initialized bitmaps")
>
>   -dann
>
> > diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> > index e68cefe08261..aa52d87985aa 100644
> > --- a/fs/ext4/balloc.c
> > +++ b/fs/ext4/balloc.c
> > @@ -368,6 +368,8 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
> >                 return -EFSCORRUPTED;
> >
> >         ext4_lock_group(sb, block_group);
> > +       if (buffer_verified(bh))
> > +               goto verified;
> >         if (unlikely(!ext4_block_bitmap_csum_verify(sb, block_group,
> >                         desc, bh))) {
> >                 ext4_unlock_group(sb, block_group);
> > @@ -386,6 +388,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
> >                 return -EFSCORRUPTED;
> >         }
> >         set_buffer_verified(bh);
> > +verified:
> >         ext4_unlock_group(sb, block_group);
> >         return 0;
> >  }
> > diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> > index fb83750c1a14..e9d8e2667ab5 100644
> > --- a/fs/ext4/ialloc.c
> > +++ b/fs/ext4/ialloc.c
> > @@ -90,6 +90,8 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
> >                 return -EFSCORRUPTED;
> >
> >         ext4_lock_group(sb, block_group);
> > +       if (buffer_verified(bh))
> > +               goto verified;
> >         blk = ext4_inode_bitmap(sb, desc);
> >         if (!ext4_inode_bitmap_csum_verify(sb, block_group, desc, bh,
> >                                            EXT4_INODES_PER_GROUP(sb) / 8)) {
> > @@ -101,6 +103,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
> >                 return -EFSBADCRC;
> >         }
> >         set_buffer_verified(bh);
> > +verified:
> >         ext4_unlock_group(sb, block_group);
> >         return 0;
> >  }
