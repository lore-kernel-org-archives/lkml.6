Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759E9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AC521A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eickXS0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfBKNIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:08:14 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45602 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKNIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:08:14 -0500
Received: by mail-yw1-f68.google.com with SMTP id d190so4122095ywd.12;
        Mon, 11 Feb 2019 05:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6gP1nxweVNamMHo13Xt13dUc8s463gbzDwu4nEPUCc=;
        b=eickXS0P0Oi2eR/vu8HMvWXFAHCSS/hH7ohEiYSEeHDtmJkpqgibHgzLI22X0hKj+s
         eWt5YcX8GTQrSb+MFA51MZ0V0Dj3mjI9Td9TNdV9bdYhbtwjIVcBih0ElY2fY2KKB79q
         M45BxpYrTOO2vuQjotx+sqjU+k7bBXK3fbjvboFDSlE4G6tXVbwm6ezQHk7CqJYDna1Z
         Jzb1kWviyaLTq8x/lTTjhjf4j08cB2M1yl3mozbZi+JHHn6bTSajJetvFlrqHZmI0Kjk
         V1rRiXC4R0br+Qm6EajtrGpxupmT/5eWvC08OMQ4UoWOrEPig6jNx6cOWqZ5wRNSsBa9
         pH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6gP1nxweVNamMHo13Xt13dUc8s463gbzDwu4nEPUCc=;
        b=nkWAgR0CmeCJX07JWjcNdlFaudL+F1Kt2cWPPV79Q/B87a4WubiTlOKq+9E2P0wwFv
         tF5BbxFhNlNtk9WKCusKYghx+p/snNV3xDc0nOsC9AKVGUW5JOiZMqWSae3lOwBFgzml
         uQhdKQOtB5AU4igsGohpvDFVfLZ/muIvP37EJNLLt5/HGd6qWmhTr+cqtEWzOOWRLiqu
         T1PtN6KkrmxDyN3xsjdDU7h4CgiXfQQTEygIy9v54f7WfV+oKFd8zbiSfi21pZWuDcjI
         IfAAJyjHm2x+eZeQIYNXHmsK6SdevgN32413Bl8UEn800XKFOTAyCsMBQghppqNcrPJx
         EciQ==
X-Gm-Message-State: AHQUAuY75xLip73bfPFQl2V6OrngUuLXNmmrr8cxvXAtwlpGsXF4/Z1Y
        jj02QvMPPmVCC8PR1kkJOiPiP5HpEtjgwlBTbRw=
X-Google-Smtp-Source: AHgI3IYamxTS6n3At0IR8R8gCmkIV16zLL3IuO7sK6fbS6TkDM+F3RgAgfrCP4tmiZvbO3cK9Ds+UM5Cd3MBWcFz/6k=
X-Received: by 2002:a81:1b4b:: with SMTP id b72mr7247973ywb.211.1549890492718;
 Mon, 11 Feb 2019 05:08:12 -0800 (PST)
MIME-Version: 1.0
References: <000000000000701c3305818e4814@google.com> <CAOQ4uxhhRs6kBH2rgbPyjd=tXoxxuJG76Y2vpCYmD0c0HzLwhA@mail.gmail.com>
 <CAJfpegvjLgXa1HOCZkz6RKup7UdioMGyY7W4miyqcRtn9PL4QA@mail.gmail.com> <CAJfpegsJo8X+efgWSa4QwSGpAGADpoossZZg=m7x5ApPXhxCoA@mail.gmail.com>
In-Reply-To: <CAJfpegsJo8X+efgWSa4QwSGpAGADpoossZZg=m7x5ApPXhxCoA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 11 Feb 2019 15:08:01 +0200
Message-ID: <CAOQ4uxj0nKK1csWGxxLT-EvC3hv8Zz5-HpvMF_a2r2iVcLXt1A@mail.gmail.com>
Subject: Re: possible deadlock in pipe_lock (2)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jan Kara <jack@suse.cz>,
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

On Mon, Feb 11, 2019 at 2:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Feb 11, 2019 at 1:06 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Feb 11, 2019 at 8:38 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Sun, Feb 10, 2019 at 8:23 PM syzbot
> > > <syzbot+31d8b84465a7cbfd8515@syzkaller.appspotmail.com> wrote:
> >
> > > > -> #1 (&ovl_i_mutex_key[depth]){+.+.}:
> > > >         down_write+0x38/0x90 kernel/locking/rwsem.c:70
> > > >         inode_lock include/linux/fs.h:757 [inline]
> > > >         ovl_write_iter+0x148/0xc20 fs/overlayfs/file.c:231
> > > >         call_write_iter include/linux/fs.h:1863 [inline]
> > > >         new_sync_write fs/read_write.c:474 [inline]
> > > >         __vfs_write+0x613/0x8e0 fs/read_write.c:487
> > > > kobject: 'loop4' (000000009e2b886d): kobject_uevent_env
> > > >         __kernel_write+0x110/0x3b0 fs/read_write.c:506
> > > >         write_pipe_buf+0x15d/0x1f0 fs/splice.c:797
> > > >         splice_from_pipe_feed fs/splice.c:503 [inline]
> > > >         __splice_from_pipe+0x39a/0x7e0 fs/splice.c:627
> > > >         splice_from_pipe+0x108/0x170 fs/splice.c:662
> > > >         default_file_splice_write+0x3c/0x90 fs/splice.c:809
> >
> > Irrelevant to the lockdep splat, but why isn't there an
> > ovl_splice_write() that just recurses into realfile->splice_write()?
> > Sounds like a much more efficient way to handle splice read and
> > write...
> >
> > [...]
> >
> > > Miklos,
> > >
> > > Its good that this report popped up again, because I went to
> > > look back at my notes from previous report [1].
> > > If I was right in my previous analysis then we must have a real
> > > deadlock in current "lazy copy up" WIP patches. Right?
> >
> > Hmm, AFAICS this circular dependency translated into layman's terms:
> >
> > pipe lock -> ovl inode lock  (splice to ovl file)
> >
> > ovl inode lock -> upper freeze lock (truncate of ovl file)
> >
> > upper freeze lock -> pipe lock (splice to upper file)
>
> So what can we do with this?
>
> The "freeze lock -> inode lock" dependency is fixed.   This is
> reversed in overlay to "ovl inode lock -> upper freeze lock", which is
> okay, because this is a nesting that cannot be reversed.   But in
> splice the pipe locks comes in between: "freeze lock -> pipe lock ->
> inode lock" which breaks this nesting direction and creates a true
> reverse dependency between ovl inode lock and upper freeze lock.
>
> The only way I see this could be fixed is to move the freeze lock
> inside the pipe lock.  But that would mean splice/sendfile/etc could
> be frozen with the pipe lock held.  It doesn't look nice.
>
> Any other ideas?
>

[CC Jan]

I think we are allowed to file_start_write_trylock(upper)
before ovl_inode_lock(). This in ONLY needed to cover the corner
case of upper being frozen in between "upper freeze lock -> pipe lock"
and thread B being in between "ovl inode lock -> upper freeze lock".
Is it OK to return a transient error in this corner copy up case?

Thanks,
Amir.
