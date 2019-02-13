Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC886C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792E321904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RASr9l+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392480AbfBMQMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:12:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41026 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392351AbfBMQMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:12:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so1328853pgq.8;
        Wed, 13 Feb 2019 08:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rN64V8TVzMywWOA7X78a4hZlVGfg5aH6uD5jKqx2bEk=;
        b=RASr9l+8GpaGGRereDdQ4KH2IhYE7fnkA1wMMzGk1mBpMNk1DB3ga7SYQv4CYxN1sB
         bXhFbtgWUCgBqkymz60Wyrhq4yL+6YUmq63OoAbo0VV2lxLGC3MxBlXcGWX3d4uUS65z
         RmC0pZyHLr5PtTC1RymtJt+nZFk56gpT9j0P6a0V+6MCGxXIB60cYAAtmUOJ+uPVKf0g
         4+Vy/23Pn189kIjKCb467HZqU94s4yyBLRnxL/s2hMHZnT15GNKXOw5KrBVHTnICQuIP
         hgnjds32XySVDQlznAvgNg221Wvz0mX5oB8BwZ7k9mvY/LojnLtOr/R7/uluwNRCD9By
         NOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rN64V8TVzMywWOA7X78a4hZlVGfg5aH6uD5jKqx2bEk=;
        b=cqWwpEzBO0a6opXjIZBnzQIKYHM2YJ1dJgTODaH1Wr0eMH5uOO9xhicBZofyzolMnB
         zKEpOxYKQL1FjdQOLUrLs1zSHvEcH5xBSj02OiKJHZ/AJV73uiwZWc3NON8xtgnsWD3x
         jjiz14idZhs2xTg0unuKAhnQImFtJ+9ibY8MgZ2oioH8YK6Uo7D5GyfoiuJUG2xJBtyf
         z4EuwL+YITdaHsMydZvA+kbMODKnP3F6wywZeyTlRvlZVrJN4tfPqaSAT1iQ7ehrsX4G
         fiQAgsx2QU8geygFca9u+t1KZ0yvHTZq6RhXxDXbCXf+yrovN+tel3V/un/JrgY3rrxN
         W8iA==
X-Gm-Message-State: AHQUAuZ8vrW2vhQ6+3s59p8wCtMvi1J8Qk4wsW7z8r+90loIU1ysh4tJ
        TRQl4F4bCOY0nwZ4ZSjut0RzND21fmZdjEmHJLY=
X-Google-Smtp-Source: AHgI3Ia8o1CMb59z78a+AuN6hjumIEdhQs3+oVn/HVGVrH8JO/M7DFW4/YUIEr/gGeQ/9DMeku1Yk0cfLYFLft53Hn8=
X-Received: by 2002:a63:730c:: with SMTP id o12mr1147499pgc.270.1550074325710;
 Wed, 13 Feb 2019 08:12:05 -0800 (PST)
MIME-Version: 1.0
References: <5c3763f1.1c69fb81.f2570.4457@mx.google.com> <CAFqt6zawA928gHRtSiKbBC0QcXxZs3U-rZdDF1yyaLjdTHqgFQ@mail.gmail.com>
 <CAJr6mf02+B4BrWC8AyLCXNu5wE8u5MPfWC4WrgrJ_9B6Z9DMbQ@mail.gmail.com>
In-Reply-To: <CAJr6mf02+B4BrWC8AyLCXNu5wE8u5MPfWC4WrgrJ_9B6Z9DMbQ@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 13 Feb 2019 21:41:54 +0530
Message-ID: <CAJr6mf16=VY0GsM=Btjb5x4WE21bFdZhRsregwCjdg3YJ_-xFA@mail.gmail.com>
Subject: Re: [PATCH] fs/block_dev.c: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 7:56 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> On Wed, Jan 16, 2019 at 5:46 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Thu, Jan 10, 2019 at 8:55 PM Sabyasachi Gupta
> > <sabyasachi.linux@gmail.com> wrote:
> > >
> > > Remove linux/dax.h which is included more than once.
> > >
> > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >
> > Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
> >
> If no further comment, can we get this patch in queue for 5.1 ?

If no further comment, can we get this patch in queue for 5.1 ?

> > > ---
> > >  fs/block_dev.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > > index cdda48f..8abcdb6 100644
> > > --- a/fs/block_dev.c
> > > +++ b/fs/block_dev.c
> > > @@ -29,7 +29,6 @@
> > >  #include <linux/namei.h>
> > >  #include <linux/log2.h>
> > >  #include <linux/cleancache.h>
> > > -#include <linux/dax.h>
> > >  #include <linux/badblocks.h>
> > >  #include <linux/task_io_accounting_ops.h>
> > >  #include <linux/falloc.h>
> > > --
> > > 2.7.4
> > >
