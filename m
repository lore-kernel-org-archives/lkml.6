Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E928C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AE820874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhJjSQ1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbeLQNa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:30:27 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45702 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732530AbeLQNa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:30:27 -0500
Received: by mail-yb1-f196.google.com with SMTP id r11so5043778ybp.12;
        Mon, 17 Dec 2018 05:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wmm05wj/yZ0eiNyNmeUQvKXh+/hX4Wo7jCHpp7C1ik=;
        b=QhJjSQ1wUQBugxGht+bKDa874osLiI6zalYoxREy3ZdLlU24//2TFFnAwGRNa0QU6N
         0hLRcJUOtEv/hxI1Xnf1XKcpbQepmM+GBAKH+LO5IRJ/8Uunv2pazwjOHsXSB683wq8D
         PHYXBvO8LmiCIgcRbn2bWYSTqTMeLpSnIcVU3J0Na5GPQfVFE3lDQHGZ3Rb5E8iVNW93
         QW4NRGgnlzpibW0ehzXhGlXPnBD+Wbl94gQ7dvIdQHqDEMyX97yt3aoI65bFgmW2fn9u
         XGZ1ZX3OHykZ1WTHGouB4XOUf5IuwTz+4HFI8PAznQC96ajsrIQuubTMrFlc+8TWfBs/
         d42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wmm05wj/yZ0eiNyNmeUQvKXh+/hX4Wo7jCHpp7C1ik=;
        b=ssha1nGPZ0hZHnHw8GGqtlJz5Asi3T2fdjyyehm101GiBEklykpLsYOOeQNlYW3jgr
         EPLuVOu3i1wr8UL042nh4mdu34LocNvwh0Nb/Sk/2vxBKXaKR9fpz7m3cu8eUTmWeCcc
         vijmse0bwan68RXROi47LVQD/67uyC59b1RxL0vnZWugq+8QPj/J3afTnZb4ImynLtYH
         qOxKT3F8cNGd62dxjYDC3LIzmht6Yp697v2h6iPMpruo0VOnX6iDKuwlbNw9nglc5JE8
         sEy9fcVmxYykLFB4OzpF4VJB/vk8dM/E1FAbNtCTPkXeMFz/xP/dn7b5SSyaDD830HhW
         Fpzg==
X-Gm-Message-State: AA+aEWb038wcU/9fc19/PTTPUE4FgRlR8OSc/+PGt6Yfo8rXSDtAZMq8
        kbmOMZwYM8Jr/3vVEm8mCsGsFMBEQUUdhebJDDmOLw==
X-Google-Smtp-Source: AFSGD/XGyulHPWf99qEq/i200I6/UA/fJu4iBIpCoCHdvSqsCiViUfaV2Ucud2N2bumxXGSwMRrpkMm3u2IiNR0QYk4=
X-Received: by 2002:a25:7685:: with SMTP id r127mr13218160ybc.507.1545053426332;
 Mon, 17 Dec 2018 05:30:26 -0800 (PST)
MIME-Version: 1.0
References: <000000000000064bcf057a59e3b9@google.com> <00000000000058055a057d14a1f4@google.com>
 <CAOQ4uxgcxGXcCiC02UJrvwkCjiXERJxuNvoG_mfLga7Am3c5GA@mail.gmail.com> <CACT4Y+YHK0rOtYZEDzzVLjNP6XHOiG=SXHMR7SicU01Vu_ivtA@mail.gmail.com>
In-Reply-To: <CACT4Y+YHK0rOtYZEDzzVLjNP6XHOiG=SXHMR7SicU01Vu_ivtA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Dec 2018 15:30:14 +0200
Message-ID: <CAOQ4uxg6HNyK9_j7A2SarJaSnVViR_c07_1CKGwD0Vr89571sQ@mail.gmail.com>
Subject: Re: WARNING in ovl_instantiate
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:47 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sun, Dec 16, 2018 at 6:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sat, Dec 15, 2018 at 9:34 PM syzbot
> > <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has found a reproducer for the following crash on:
> > >
> > > HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=143f9a15400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=9c69c282adc4edd2b540
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6e543400000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com
> > >
> > > overlayfs: filesystem on './file0' not supported as upperdir
> > > overlayfs: filesystem on './file0' not supported as upperdir
> > > overlayfs: filesystem on './file0' not supported as upperdir
> > > overlayfs: filesystem on './file0' not supported as upperdir
> > > overlayfs: filesystem on './file0' not supported as upperdir
> > > WARNING: CPU: 1 PID: 28918 at fs/overlayfs/dir.c:263
> > > ovl_instantiate+0x369/0x400 fs/overlayfs/dir.c:263
> >
> > Looks like some corner case race when using same dir as upper and lower.
> > Doesn't look like a critical issue, I just don't know how to explain
> > getting to this
> > state. Couldn't reproduce on my target machine.
> >
> > It would have been interesting for me to see the strace of the repro threads
> > when that WARN happens. I wonder if anyone else has already asked for it and
> > how hard would it be to make that information available with the bug report.
>
> Hi Amir,
>
> By strace you mean return values of syscalls, or something else?
>

I do mean return values.
Some of the commands in the repro are obviously going to fail and
some will fail conditionally depending on who wins the race.
It could have been good for analysis of the bug to know when the
race happened which syscall sequence took place.

> We had only 1 strace-related request, and it was related to better
> static decoding of inputs rather then dynamic behavior:
> https://github.com/google/syzkaller/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+strace
>
> I don't immediately see how to capture runtime behavior. It would work
> if we dump everything onto console right away. But this will produce
> tons of output (really lots). And that output will be intermixed
> across parallel processes. And it will be hard to understand which
> exactly syscalls participated in the process that provoked the crash.
> Or maybe it's exactly syscalls from several processes interacted. Lots
> of output can also slow down and perturb execution.

Yeh, I figured. Maybe the return values of syscalls is something that syzkaller
should cache and in case of failure, report recent run sequences in format
similar to the repro program. Just a though. Much easier said than done.

>
> But meanwhile I was able to reproduce this on the first run within 4
> minutes. Maybe you need to wait longer, it does not happen
> immediately.

Oh! I wonder if this type of information, how long or how many repeats before
crash happens is available in the bug report and I missed it - if not, could be
useful to add it.

Anyway, The reason that WARN_ON is there is because I wasn't sure
if that could happen. Apparently it can with this weird setup. Once I am able to
understand how it happens most likely the result will be to covert the WARN_ON
to pr_warn. User anyway gets an error, so there is probably nothing to
worry about
(famous last words).

Thanks,
Amir.
