Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07736C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB56C2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8MulWPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfASS4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:56:13 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53298 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfASS4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:56:12 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so11380503ita.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 10:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+aQOdUEc3nDsLw9NcDs2uIvxlNB2RqHrVYuVoO7b0I=;
        b=A8MulWPAydTSPp0lACyhyF15aR1D+X5nXft2Q56tM69Ibd4EpefYJNFiBDhASfaRKo
         4yac2lWTf8lZF7H+PWMlnkMqqlWjjw2jy6naj5h6UHIyVQ1tKA39FDpGeRNpwd4INLXe
         OUkqogIPDexsxAVaWUkm9LwmR3ofgqPj19f9337u5S7U0PXVMSDRfLHaGqcu2daApfzK
         8evHadmzEm19pTZ/zVmv8CAUKVMqrdwG7o/WNawfcA0YZEnSZqX4fVHya85lI3tJuV2Y
         SBbUdMgt8pga0E5Lr+b1EXGRBl//3iWAWEjNxY7C4JmJQrSXhTv+qBwuZiI2wj8eaQY0
         FXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+aQOdUEc3nDsLw9NcDs2uIvxlNB2RqHrVYuVoO7b0I=;
        b=s3naHbIpTjPO3w02okMtHjp3z+f+oO5geCFOwNwY8wnIzVNDDcyPTLosNCQcwnfmy0
         AJdGHGh1Hn/BGUd7JR5FwcO8QkyK6qBZBfRiFmPV0gaaGjf8rIYbmf3lDnBX8ex6xrQe
         9k0c1PP2Vq9sgAHbzSGo5ZIiiAYBTA9GqpwiGCw2BhLOVEb5nfih51KAwFN7CnTFhunl
         qVwTmUoR9epp8KDthq4pkGysxOYgePv8aSvuExjVSH+LUa/vzlGVIg2+R8Gjatx3YC5O
         2/2pNHiJe8BKqIzwgtiY3FRsDR3kw8MQOgEM6HbD1UigrFercIp08IRveybOXPxa26gc
         5UuQ==
X-Gm-Message-State: AJcUukebn5HzbmhFBY8vteFErZ7O9ONeKsNqAOYkkuDEIPND0nMcAJzH
        eQKZsy51Y56EQxawIQC6rRfqAiF49M5IeiJANhOLgA==
X-Google-Smtp-Source: ALg8bN7KSE802pwfz4Ny11jvaSzBxo/BKEqi3FBcL/zJSsjIta5zOGSN3N5chzNpOVNpV18sGlrvwqj5peYEUFrEJeM=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr12042534itl.144.1547924171517;
 Sat, 19 Jan 2019 10:56:11 -0800 (PST)
MIME-Version: 1.0
References: <94eb2c0810d04f5a46055ffc71aa@google.com> <CACT4Y+Y6UhNQOc7VUPgvXZ3yGPusjg2WJ9-OXMCRGM2Q1bx7ZQ@mail.gmail.com>
 <6012a726-069a-13a5-9c8d-6a11730d8414@I-love.SAKURA.ne.jp>
 <468f7418-a02d-79cc-3d94-91bbe146567e@I-love.SAKURA.ne.jp>
 <20180406121411.GJ4082@hirez.programming.kicks-ass.net> <201804062255.HEJ82361.FJOFHVtSLOMOQF@I-love.SAKURA.ne.jp>
 <20180406154343.GK4082@hirez.programming.kicks-ass.net> <20180406155905.GA11697@vader>
In-Reply-To: <20180406155905.GA11697@vader>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 19 Jan 2019 19:56:00 +0100
Message-ID: <CACT4Y+ZaL=zPbb-r7PKvOsY8aBRiMEEHMc+-HVGm+dRTax+DfA@mail.gmail.com>
Subject: Re: INFO: task hung in lo_ioctl
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@fb.com>,
        syzbot 
        <bot+abdba5bc6de135d7622f00756da97998425b6de5@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        Hannes Reinecke <hare@suse.de>, shli@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, knikanth@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 5:59 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Fri, Apr 06, 2018 at 05:43:43PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 06, 2018 at 10:55:03PM +0900, Tetsuo Handa wrote:
> > > Peter Zijlstra wrote:
> > > > On Fri, Apr 06, 2018 at 09:04:18PM +0900, Tetsuo Handa wrote:
> > >
 > > +       /* Temporary hack for handling lock imbalance. */
> > > > > +       if (__mutex_owner(&lo->lo_ctl_mutex) == current)
> > > > > +               mutex_unlock(&lo->lo_ctl_mutex);
> > > >
> > > > ARGGH.. you didn't read the comment we put on that?
> > > >
> > >
> > > Commit 5b52330bbfe63b33 ("audit: fix auditd/kernel connection state tracking")
> > > is using __mutex_owner(). ;-)
> >
> > That got removed and the warning added.
>
> Seems easy enough to fix without resorting to __mutex_owner() (untested):
>
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 264abaaff662..cee258d12a1e 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1300,12 +1300,13 @@ loop_get_status_old(struct loop_device *lo, struct loop_info __user *arg) {
>  static int
>  loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
>         struct loop_info64 info64;
> -       int err = 0;
> +       int err;
>
> -       if (!arg)
> -               err = -EINVAL;
> -       if (!err)
> -               err = loop_get_status(lo, &info64);
> +       if (!arg) {
> +               mutex_unlock(&lo->lo_ctl_mutex);
> +               return -EINVAL;
> +       }
> +       err = loop_get_status(lo, &info64);
>         if (!err && copy_to_user(arg, &info64, sizeof(info64)))
>                 err = -EFAULT;
>
>
> I'll test it and send it up when I get into the office.


Was this ever submitted? Or some other fix for this?

The bug is still open, but last happened 289 days ago:
https://syzkaller.appspot.com/bug?id=608144371e7fc2cb6285b9ed871fb1eb817a61ce

But it also has 10 duplicates, some of which happened much more recently.
If a fix was submitted, but Reported-by tag wasn't added this open bug
can now mask lots of other new bugs.
