Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2829C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8FE20838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LlkNtnAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfBLOTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:19:13 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36946 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:19:12 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so7863052iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8DIinfz2LflwhAKrpZk1YkKL6zlEiyHEolwga3PuUQ=;
        b=LlkNtnAiozIEuX0c46N1+4hvU68CNp1I1zTgLzMf4u/Tj80LutWdTzi4GqXCwx9uIt
         dK4yhZ/Gq3dWrjEhGYUE/GQMSTzzicFCmxw1FBTfCu150yROMh09Hdl29QVerhIYxbp4
         a85ZK3wn77c3SSdCNa3Skx/UQkxGGG/3zSsfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8DIinfz2LflwhAKrpZk1YkKL6zlEiyHEolwga3PuUQ=;
        b=HtZ4UUBHk3ZW1fOl1AdTwu9wEeCzgjHdFlHZ9YrfIOn1GqSnF7FMVbNn9VSp4XoiW9
         7m2z/yDyIoyMxs2jDHgF6XFmGk+bNCyrlzstZjIwfgIarnSGiXbnDYJ9unk8E81ZCdxs
         m21i6TqRMXCUiXbwge9RHodCCU5eCub4YBLpHq7QyyoXab+2hfqE+qEdYJAY5NROGfkG
         f7zIkZCkTurvufkPNwujI9m1spGUuGSoF7C8M6PYNOx19wsfLw16KhIIcuWNDdRMhBnO
         l+fLB6ub03tDl5j1dtpOkL9t0noKVApwUaT12xwasejdlzlGRKm2/V9fDIaObNm8GZPA
         cLmQ==
X-Gm-Message-State: AHQUAuZwZnMS3MMDvfU2Gr3y+T1hdASzCMd0MA0NWWiwP7CW0gfD9pfX
        ljdTh1PNtuaHP6GMy8zyJAt/6BQRrsLUisNHr7fZ+bjj
X-Google-Smtp-Source: AHgI3IbOz80sLMMdfcXmz6SREdYgl5hSQNBDkcDne+a2NG+rVnqiyyAlIpnx00InPCGQOnrZKDv1lTYK4XkPZfUxfJQ=
X-Received: by 2002:a5d:8248:: with SMTP id n8mr2089840ioo.246.1549981151502;
 Tue, 12 Feb 2019 06:19:11 -0800 (PST)
MIME-Version: 1.0
References: <000000000000701c3305818e4814@google.com> <CAOQ4uxhhRs6kBH2rgbPyjd=tXoxxuJG76Y2vpCYmD0c0HzLwhA@mail.gmail.com>
 <CAJfpegvjLgXa1HOCZkz6RKup7UdioMGyY7W4miyqcRtn9PL4QA@mail.gmail.com>
 <CAJfpegsJo8X+efgWSa4QwSGpAGADpoossZZg=m7x5ApPXhxCoA@mail.gmail.com>
 <CAOQ4uxj0nKK1csWGxxLT-EvC3hv8Zz5-HpvMF_a2r2iVcLXt1A@mail.gmail.com>
 <CAJfpegsadeK=3EON9HgZ8rLCDWCJXR9QrXxA3ZZjdjzq6FDRjw@mail.gmail.com>
 <20190212111402.GU19029@quack2.suse.cz> <CAOQ4uxh_o53RimG-yKPYkN9sszQhwjQbmHw9pHc4kJU5MywMNA@mail.gmail.com>
In-Reply-To: <CAOQ4uxh_o53RimG-yKPYkN9sszQhwjQbmHw9pHc4kJU5MywMNA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 12 Feb 2019 15:19:00 +0100
Message-ID: <CAJfpegvt6eVhX8v5faMP76K0LEkqKFDQE8gyNOinxonRdjq3eA@mail.gmail.com>
Subject: Re: possible deadlock in pipe_lock (2)
To:     Amir Goldstein <amir73il@gmail.com>
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

On Tue, Feb 12, 2019 at 2:39 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > My other thought is that perhaps sb_start_write() should invoke
> > > s_ops->start_write() so that overlay can do the freeze protection on
> > > the upper early.
> >
> > So my understanding of overlayfs is pretty basic so I'm sorry if I miss
> > something. If I'm right, we have three superblocks here: ovl, upper, lower.
> > Now 'lower' is read-only so for freezing purposes we can just forget about
> > it. 'upper' is where the real changes are going into and 'ovl' is a wrapper
> > virtual superblock that handles merging of 'lower' and 'upper'. Correct so
> > far?
>
> Yes.
>
> >
> > And the problem seems to be that when you acquire freeze protection for the
> > 'ovl' superblock, you in fact want to acquire freeze protection for the
> > 'upper' (as 'ovl' is just virtual and has no disk state to protect). So I
>
> There are use case for freezing ovl (i.e. ovl snapshots) but it is not
> implemented
> at the moment.
>
> Overlayfs already gets upper freeze protection internally before any
> modification
> to upper.
> The problem that locking order of upper freeze is currently under overlay
> inode mutex. And that brings a problem with the above pipe case.
>
> > agree that a callback to allow overlayfs to acquire freeze protection on
> > 'upper' right away would be one solution. Or we could make s_writers a
> > pointer and redirect ovl->s_writers to upper->s_writers. Then VFS should do
> > the right thing from the start unless overlayfs calls back into operations
> > on 'upper' that will try to acquire the freeze protection again. Thoughts?
>
> Overlayfs definitely calls into operations on upper and upper certainly
> acquires several levels of s_writers itself.

sb_start_write() calls cannot be nested (for the same reason two
shared locks may be part of a deadlock), so this would mean having to
make sure that none of the code that overlay calls does
sb_start_write() itself.  Which means quite a bit of vfs api churn and
the associated pain...

> The problem with the proposal to change locking order to
> ovl freeze -> upper freeze -> ovl inode -> upper inode
> is that for some non-write operations (e.g. lookup, readdir)
> overlay may end up updating xattrs on upper, so will need
> to take upper freeze after ovl inode lock without ovl freeze
> being called by vfs.
>
> I suggested that we may use upper freeze trylock in those
> cases and skip xattr update if trylock fails.
>
> Not sure if my assumption is correct that this would be ok
> w.r.t locking rules?

Yes, using trylock is always deadlock free.

Thanks,
Miklos
