Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABF6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66130218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAfGh3aL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfBLNjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:39:54 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:43773 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbfBLNjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:39:52 -0500
Received: by mail-yb1-f178.google.com with SMTP id s76so1010867ybs.10;
        Tue, 12 Feb 2019 05:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5TOuGrQ+VF3jI2wWFU64HANCazjU6JKCsapIQL56xg=;
        b=oAfGh3aLezK+RVJXZn6zTbeshDTDat0dXxk/X9zW1pd2GvsWmzH78H+fPY9lQjeXPt
         wDrm0RoP3xr87E1fyaYRHNh38eLeKKZi/Yqte4ykcBj8yzyBMBUozceXJiy8z4L6b1oA
         2SGiP5tZ1MBKmZQ+m19TpMCHHEd/2Z042fQe1X6zjsKqxJfHKG3q3w5ODHApLvrn80c2
         YUf1FLVNBwwrq/femw8V5bd8PC9vLTI43whNX2lHOCiSh0auHdW7D/zhx5uEwfUasymy
         bkNf6TELtqrGgqQuETdQWLz63KWUx2vpXD6+7Zfl6g+hqf9vmvVxlgA3P0C3E+FNqwVZ
         H3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5TOuGrQ+VF3jI2wWFU64HANCazjU6JKCsapIQL56xg=;
        b=aBf7fvOKproEjMG3dgV+clxxND2AXFPHHQWxQrRIFHEtmGh0l6U8RDZ+sj7i6sE3Xg
         Oe5x9tIj2miGfoTmIUngjpx0v/mSEe/Gqmfu3utiNpNVxJrownkso2tSBkdSvJ2kNqTs
         2F4Suu8cnd7yrx8F8gIbbwvZbiyZoZfcLlkfll3iIJ53dhJMSy17FfHR1EauqqyaSkXZ
         KC95Q1FoadM89amwAonvlVX3XVxfSqDMdJsyAuQtILO/jYka3gnfqmJprIoShUulA6UX
         gsrLiPnWEF1ABwrifSr7iQFnBOVzVzaONi5zxmk4f2hX6Lvae5omHYGJhPI+4D1ZbbbX
         MSLQ==
X-Gm-Message-State: AHQUAubgsr+v6ifOmnpLIMPhhbeTpP6SwE+a20ZTLbXy9iyUX5Dveq/Y
        RfjcAPgg3bZtGpjxrKvppVd+ZBezbvc09UKC1Fw=
X-Google-Smtp-Source: AHgI3Ia9/vs3cHZOOMkwQ1aJlrxBfnpq1E/fcnxXUc5OwQn5/IRfqmYfCSuMQknyM+j8myneQLFubcqLa+WsNhnQGnM=
X-Received: by 2002:a25:1488:: with SMTP id 130mr2931126ybu.507.1549978790150;
 Tue, 12 Feb 2019 05:39:50 -0800 (PST)
MIME-Version: 1.0
References: <000000000000701c3305818e4814@google.com> <CAOQ4uxhhRs6kBH2rgbPyjd=tXoxxuJG76Y2vpCYmD0c0HzLwhA@mail.gmail.com>
 <CAJfpegvjLgXa1HOCZkz6RKup7UdioMGyY7W4miyqcRtn9PL4QA@mail.gmail.com>
 <CAJfpegsJo8X+efgWSa4QwSGpAGADpoossZZg=m7x5ApPXhxCoA@mail.gmail.com>
 <CAOQ4uxj0nKK1csWGxxLT-EvC3hv8Zz5-HpvMF_a2r2iVcLXt1A@mail.gmail.com>
 <CAJfpegsadeK=3EON9HgZ8rLCDWCJXR9QrXxA3ZZjdjzq6FDRjw@mail.gmail.com> <20190212111402.GU19029@quack2.suse.cz>
In-Reply-To: <20190212111402.GU19029@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 Feb 2019 15:39:38 +0200
Message-ID: <CAOQ4uxh_o53RimG-yKPYkN9sszQhwjQbmHw9pHc4kJU5MywMNA@mail.gmail.com>
Subject: Re: possible deadlock in pipe_lock (2)
To:     Jan Kara <jack@suse.cz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+31d8b84465a7cbfd8515@syzkaller.appspotmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > My other thought is that perhaps sb_start_write() should invoke
> > s_ops->start_write() so that overlay can do the freeze protection on
> > the upper early.
>
> So my understanding of overlayfs is pretty basic so I'm sorry if I miss
> something. If I'm right, we have three superblocks here: ovl, upper, lower.
> Now 'lower' is read-only so for freezing purposes we can just forget about
> it. 'upper' is where the real changes are going into and 'ovl' is a wrapper
> virtual superblock that handles merging of 'lower' and 'upper'. Correct so
> far?

Yes.

>
> And the problem seems to be that when you acquire freeze protection for the
> 'ovl' superblock, you in fact want to acquire freeze protection for the
> 'upper' (as 'ovl' is just virtual and has no disk state to protect). So I

There are use case for freezing ovl (i.e. ovl snapshots) but it is not
implemented
at the moment.

Overlayfs already gets upper freeze protection internally before any
modification
to upper.
The problem that locking order of upper freeze is currently under overlay
inode mutex. And that brings a problem with the above pipe case.

> agree that a callback to allow overlayfs to acquire freeze protection on
> 'upper' right away would be one solution. Or we could make s_writers a
> pointer and redirect ovl->s_writers to upper->s_writers. Then VFS should do
> the right thing from the start unless overlayfs calls back into operations
> on 'upper' that will try to acquire the freeze protection again. Thoughts?

Overlayfs definitely calls into operations on upper and upper certainly
acquires several levels of s_writers itself.

The problem with the proposal to change locking order to
ovl freeze -> upper freeze -> ovl inode -> upper inode
is that for some non-write operations (e.g. lookup, readdir)
overlay may end up updating xattrs on upper, so will need
to take upper freeze after ovl inode lock without ovl freeze
being called by vfs.

I suggested that we may use upper freeze trylock in those
cases and skip xattr update if trylock fails.

Not sure if my assumption is correct that this would be ok
w.r.t locking rules?
Not sure if we can get away with trylock in all the cases that
we need to modify upper.

Thanks,
Amir.
