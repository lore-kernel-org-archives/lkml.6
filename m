Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7BFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EB82098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="b3vEr0nS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EB82098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeHVXYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:24:34 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44072 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbeHVXYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:24:32 -0400
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so5254609oih.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=49cAt8veSOAu4YR7sklw17uRrQXNRXpX1RtDRxlQSfs=;
        b=b3vEr0nSlC2MKr1U9fnZjKwCGqFOCL7lojerUEa5mLzT5wV6ro9JlotCvmMTw1DZBT
         xgtJfiRh51YLdCseSmCTHgFVHPloVChTBxbSYpz+zaPn9ozzUiz9DhjsWluP/H7/0et/
         oJnHLzHA9Zh4vyLpREpEZ/5RCXn0HOCQD+Q2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=49cAt8veSOAu4YR7sklw17uRrQXNRXpX1RtDRxlQSfs=;
        b=TD9GtBm44EgmPUGrG0cyVeP8qUYjitL7ldT/0Cmsyv0HT1/2TegM2U2KtihnnScw2r
         SPh833UpvaSLBf+6hpIVsc9zY+ARiNGN9T4xqO/MMkDjMC5TbWh1Fk4iaF7Ng1ER/kbS
         rnaX0Ngvd8Ty2/bsCxVNmlID8CpCfb+ioiHcpI3rA6mora8VCdthbyJkJpgckZMyRGwO
         WqKPqbPKVZplEFT3uC88nvwzMBVOFsXj8/krtNPCayntUgTwijWjxePuS8fH++jjz1ez
         dKLKePZK/jw0TsCd/bmBbQMspI6Lyd0/n20gK0aJYSiKZcHGq4lm38cHRb4JNLbDDf7y
         QSmg==
X-Gm-Message-State: APzg51Al8MeFWLVgEyY3qrJHZyz/b5vYpejW2Imh1Bt2RyFWpHIBLO7t
        nRM0RBBXREfrhF3Bl/kR/jWeHddEdEFPGYKbjRpEJQ==
X-Google-Smtp-Source: ANB0VdY4eAfrcReucPsxtvPTl7sdtuXQ2dn/GSc4gn1A3I/wd+0Hi+k8ffOITHTznn5uSY/dxASeqb0AwI7GkcceUlE=
X-Received: by 2002:aca:e8c9:: with SMTP id f192-v6mr5019785oih.87.1534967896115;
 Wed, 22 Aug 2018 12:58:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 12:58:15
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CA+55aFzd53LwrBfvdtKx7e_bQPhzsKEvCME1rGbrrY4pG94d=Q@mail.gmail.com>
References: <20180822085522.GA14354@veci.piliscsaba.redhat.com> <CA+55aFzd53LwrBfvdtKx7e_bQPhzsKEvCME1rGbrrY4pG94d=Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 22 Aug 2018 21:58:15 +0200
Message-ID: <CAJfpegsZUxZXQSHZoy0=9iqB6jRL0ZOtFGnSqT4FrzT8K2mcbQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: set I_CREATING on inode being created
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 4:53 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Aug 22, 2018 at 1:55 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> +       spin_lock(&inode->i_lock);
>> +       inode->i_state |= I_CREATING;
>> +       spin_unlock(&inode->i_lock);
>> +
>
> Why is that spinlock protection there?
>
> Isn't this a new inode that cannot possibly be reached any other way yet?

new_inode() puts it on sb->s_inodes list, so it *is* reachable.
Following operate on s_inodes:

- evict_inodes() called from generic_shutdown_super(): a) we shouldn't
get here while in creation, b) it's careful to not touch inodes with
non-zero refcount

- invalidate_inodes(), called from block devices, so it doesn't apply
to overlayfs, also it skips inodes with non-zero refcount

- iterate_bdevs(), operates on blockdev_superblock

- fsnotify_unmount_inodes() called from generic_shutdown_super(): we
shouldn't get here while in creation,

- add_dquot_ref(), remove_dquot_ref(): not quite sure what these do,
but quotas are not (yet) supported on overlayfs

So looks like we are safe without a spinlock.

And there's another, more fundamental reason: if anything starts
messing with i_state of an inode that is not yet even had its state
changed to I_NEW, then lots of filesystems are in trouble.

> NOTE! This is a question. Maybe there is something I missed, and there
> *are* other ways to reach that inode. But if that's true, isn't it
> already too late to set I_CREATING?

No, it's not too late, I_CREATING can be set anytime up to
inode_insert5(), which is the first one to actually look at that flag.

> So I'd like some clarification on this point before applying it. It's
> possible that the spinlock is required, I just want to understand why.

I added the spinlock, because it's cheap (new_inode() already pulls it
into L1 cache) and because it's much harder to prove that lockless one
is correct than just adding that locking.

Thanks,
Miklos
