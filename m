Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A75C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310D22086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310D22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389038AbeKPGxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:53:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32911 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeKPGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:53:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id c206so12370490oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yVyF/ws4RHBj3HydxKj0vc+iizg+wC+4cDdvRaocRc=;
        b=OW1LOCBUK95gvGWe9s50awOZNcoQKHWKoPWSrD4MQMC1yfV3PafDf5wqwqXb6yCDp2
         RC5HQvwOmUtYkyAFDQSHkF7WxBqgQ/GK/e8EH3OPP7wk3ZGQ+FtzuPC6gUOGKBNlhtL2
         vMW/uJDMJoY4WwBXagi9sjWCnk61vsnvyKWRnmPPX1pZ66Q8JzBxZ6TEgfI8O6nOiFmg
         ZIQNeVK7v1IhKTPoodko4w1Z/bMD08XezfUkjETZS3nowfXfHAOJChDDduGoibHWK8iI
         TVfJ6jD8553TWVoK0HgJZdvN1QtTpoKk4qZY7XfrjwYladLb1hbJDL0LDaKdZYT3BVAA
         epJw==
X-Gm-Message-State: AGRZ1gJBwzTyNtvyvjMTnTm9IGgBBkUYt6d05kcwmJ1baWJ3vyKK76Jd
        j/xBC9R0xqXcqEDH4dgb79GtW2cKyyAhfVuq5LX1pg==
X-Google-Smtp-Source: AJdET5fp7UaysxH1H0pxa1Gu4qBGOmLNF+5Z/vditnnfuJQHWKe1EYbfZy3g6y7sVq2vjGAO/2kTJLNBv6MoRuylMkw=
X-Received: by 2002:aca:3785:: with SMTP id e127-v6mr4717540oia.147.1542314670245;
 Thu, 15 Nov 2018 12:44:30 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU6P0HdDWGMmsjyArQ746N7RBE3qMVq3aZgkfGjb153yJw@mail.gmail.com>
 <CAHk-=wi1f2tTnHe_DoMBsoj7v38G746Kk=tpouGg0_Y3fUFqKA@mail.gmail.com>
 <CAHc6FU5vaPLF8kcTAnHGHPkJQMf7GwMOX3YOg=DC=XFHrYPmdg@mail.gmail.com> <CAHk-=wgxioabke99QwPvMJ0YJ8of0vyAT4Rxw3zoNvgjn0Y_kg@mail.gmail.com>
In-Reply-To: <CAHk-=wgxioabke99QwPvMJ0YJ8of0vyAT4Rxw3zoNvgjn0Y_kg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 15 Nov 2018 21:44:17 +0100
Message-ID: <CAHc6FU7oZnb+-gwiAp5KRz1y1FEF-P6rMkSEhb9jC5eJ1_+U9Q@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2: 4.20 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 at 19:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Nov 15, 2018 at 12:20 PM Andreas Gruenbacher
> <agruenba@redhat.com> wrote:
> >
> > I guess rebasing the for-next branch onto something more recent to
> > avoid the back-merge in the first place will be best, resulting in a
> > cleaner history.
>
> Rebases aren't really any better at all.
>
> If you have a real *reason* for a merge, do the merge. But then the
> reason should be clearly stated in the merge commit. Not just some
> random undocumented merge message. Tell why some other branch was
> relevant to your fix and needed to be pulled in.
>
> Better yet, don't do either merges or rebases.

Ok, I've changed the merge commit as follows now:

    Merge tag 'v4.20-rc1'

    Pull in the gfs2 fixes that went into v4.19-rc8:

      gfs2: Fix iomap buffered write support for journaled files
      gfs2: Fix iomap buffered write support for journaled files (2)

    Without these two commits, the following fix would cause conflicts.

So merging v4.19-rc8 would have been sufficient. v4.20-rc1 is what I
ended up testing, though.

Are you okay with that now?

Thanks,
Andreas

--

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
tags/gfs2-4.20.fixes3

for you to fetch changes up to 01ed1606d30966dc8fa255a941b2fc42d4e308a1:

  gfs2: Fix iomap buffer head reference counting bug (2018-11-15 21:31:58 +0100)

----------------------------------------------------------------
Fix two bugs leading to leaked buffer head references:

  gfs2: Put bitmap buffers in put_super
  gfs2: Fix iomap buffer head reference counting bug

And one bug leading to significant slow-downs when deleting large files:

  gfs2: Fix metadata read-ahead during truncate (2)

----------------------------------------------------------------
Andreas Gruenbacher (4):
      gfs2: Put bitmap buffers in put_super
      gfs2: Fix metadata read-ahead during truncate (2)
      Merge tag 'v4.20-rc1'
      gfs2: Fix iomap buffer head reference counting bug

 fs/gfs2/bmap.c | 54 +++++++++++++++++++++++++++---------------------------
 fs/gfs2/rgrp.c |  3 ++-
 2 files changed, 29 insertions(+), 28 deletions(-)
