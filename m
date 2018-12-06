Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D92C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065EB20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inCNwoaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065EB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbeLFAWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:22:10 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44526 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFAWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:22:10 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so16105078lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 16:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lU+KJ32LvrRCha6GyVutzWlNczJ6WLBFRPG8vIcvH9w=;
        b=inCNwoaS6JMyL6uIaV6kRbDdQK+Yd1sMPYoSTR7A4cagLFY8eTea27aRL7IC6p7wua
         rCpEp3nz/vIRRDAgf65d5k/vipSJjC4XAyP8TR8dAntduSGl1L0dtTfJoFHAXpIlXAYQ
         8SEMFG0jrHvX/WUoHjYxnvbejBW+MjrqGh0isspcV03gemMjozP1j3X0kziLfuSOq9Xa
         tdPv+HO+MsseTWmhNRw+9l5zB/V6B3Gk6JEN3M9JHu4JIaNToAbzAQxHso2qaFVay30S
         ya0rYAgu45FbKxKJOmsATa0qTPX3YMqIgHzGbYU5yG8lh4IuwWiReVcZu4ZgqX0nVCra
         lk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lU+KJ32LvrRCha6GyVutzWlNczJ6WLBFRPG8vIcvH9w=;
        b=VufEs7BEnQ1qbXxJRrAxeu+I7N6VYGMzegwuLdsTn3tJPOld4Gg+jGglJybtKYce4G
         T9Hbc+mYGthRddsV6ggZ33zQmKfMlKCzOXoiT8mKk4QXg2WhpPyCkY+9W894YEavW2bR
         ViTb1TcqcEMiDEdJeUt1XPVc2bdgPKsHR+BKozZlrE3AVqdAmpg4DdgYa3WmmShm7y/h
         JGKhPTMg5gAt3cbZkGtGukfo45zFvEpaXt58lMf3fH7s2lngN8v1MZknbw117RcXV/c1
         eqY7e9DGQKgH+lh6SvT/0O3Z6G3nx0IKZd7WyE9md70ZRuw/CFUk87/NI+vxI8DS1vlC
         lmgg==
X-Gm-Message-State: AA+aEWYjkqW1YY0Dv/Nx58nZI8m79YtpN1XULdIxsVZvEIqx+mls/45I
        s2B+NNCQwX4psyhS1tujP5Qhg6sa0MbnO1HuzvhIpg==
X-Google-Smtp-Source: AFSGD/WgIBFAgfE1C+Uf/l1Jy4OSjeKQukTpHhXh5/DvOnXOz1/Msx/3SdrdutHPV9oO1AuzhFeP1oQTnEWZ3MfiNas=
X-Received: by 2002:a19:1cb:: with SMTP id 194mr15423340lfb.61.1544055727271;
 Wed, 05 Dec 2018 16:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20181205211601.75856-1-tkjos@google.com> <20181205220035.GX2217@ZenIV.linux.org.uk>
In-Reply-To: <20181205220035.GX2217@ZenIV.linux.org.uk>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 5 Dec 2018 16:21:55 -0800
Message-ID: <CAHRSSEwpYw312kBU4WGHs_P+xqx8cP+iripYVHxpV6pJBbH9Mw@mail.gmail.com>
Subject: Re: [PATCH v2] binder: fix use-after-free due to fdget() optimization
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>,
        Jann Horn <jannh@google.com>, Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 2:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Dec 05, 2018 at 01:16:01PM -0800, Todd Kjos wrote:
> > 44d8047f1d87a ("binder: use standard functions to allocate fds")
> > exposed a pre-existing issue in the binder driver.
> >
> > fdget() is used in ksys_ioctl() as a performance optimization.
> > One of the rules associated with fdget() is that ksys_close() must
> > not be called between the fdget() and the fdput(). There is a case
> > where this requirement is not met in the binder driver (and possibly
> > other drivers) which results in the reference count dropping to 0
> > when the device is still in use. This can result in use-after-free
> > or other issues.
> >
> > This was observed with the following sequence of events:
> >
> > Task A and task B are connected via binder; task A has /dev/binder open at
> > file descriptor number X. Both tasks are single-threaded.
> >
> > 1. task B sends a binder message with a file descriptor array
> >    (BINDER_TYPE_FDA) containing one file descriptor to task A
> > 2. task A reads the binder message with the translated file
> >    descriptor number Y
> > 3. task A uses dup2(X, Y) to overwrite file descriptor Y with
> >    the /dev/binder file
> > 4. task A unmaps the userspace binder memory mapping; the reference
> >    count on task A's /dev/binder is now 2
> > 5. task A closes file descriptor X; the reference count on task
> >    A's /dev/binder is now 1
> > 6. task A forks off a child, task C, duplicating the file descriptor
> >    table; the reference count on task A's /dev/binder is now 2
> > 7. task A invokes the BC_FREE_BUFFER command on file descriptor X
> >    to release the incoming binder message
> > 8. fdget() in ksys_ioctl() suppresses the reference count increment,
> >    since the file descriptor table is not shared
> > 9. the BC_FREE_BUFFER handler removes the file descriptor table
> >    entry for X and decrements the reference count of task A's
> >    /dev/binder file to 1
> > 10.task C calls close(X), which drops the reference count of
> >    task A's /dev/binder to 0 and frees it
> > 11.task A continues processing of the ioctl and accesses some
> >    property of e.g. the binder_proc => KASAN-detectable UAF
> >
> > Fixed by using get_file() / fput() in binder_ioctl().
>
> Note that this patch does *not* remove the nasty trap caused by the garbage
> in question - struct file can be freed before we even return from
> ->unlocked_ioctl().  Could you describe in details the desired behaviour
> of this interface?

The ioctl(BC_FREE_BUFFER) frees the buffer memory associated with a
transaction that has completed processing in userspace. If the buffer
contains an FDA object (file-descriptor array), then it closes all of the
fds passed in the transaction using ksys_close(). In the case with the
issue, the fd associated with the binder driver has been passed in the
array. Since the fdget() optimization didn't increment the reference, this
makes us vulnerable to the UAF described above since the rules for
fdget() are being violated (ksys_close()). This change did prevent the
final close during the handling of BC_FREE_BUFFER, but as you point
out, may still result in the final close being processed prematurely after
the new fput() (no observed negative side-effects right now, but agreed
this could be an issue).

>
> How about grabbing the references to all victims (*before* screwing with
> ksys_close()), sticking them into a structure with embedded callback_head
> and using task_work_add() on it, the callback doing those fput()?
>
> The callback would trigger before the return to userland, so observable
> timing of the final close wouldn't be changed.  And it would avoid the
> kludges like this.

I'll rework it according to your suggestion. I had hoped to do this in a way
that doesn't require adding calls to non-exported functions since we are
trying to clean up binder (I hear you snickering) to be a better citizen and
not rely on internal functions that drivers shouldn't be using. I presume
there are no plans to export task_work_add()...

>
> Of course, the proper fix would require TARDIS and set of instruments for
> treating severe case of retrocranial inversion, so that this "ABI" would've
> never existed, but...

There are indeed many things about the binder interface we'd do differently
if we had the chance to start over...

-Todd
