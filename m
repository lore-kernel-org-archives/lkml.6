Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14029C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D532086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PHe2ve0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D532086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeIJOn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:43:57 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32948 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIJOn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:43:57 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so38969346oip.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=okCZjwxpi5Smv3VWgJl/+SHcHoAleOu5aO+k645KKm4=;
        b=PHe2ve0JuKk65iMxmkvAweaa9jH+oKwDtXuUaY6JtmQ6E++WZ3O6ntDQJ3Xf0kAvy/
         l+GaTjtmxcl16Nfu1APaU3VbOhv+tzIBertKziq51TDbojsOtvNEAW1epxiW9GOczin/
         EsRC+AWcgp6lwerTQElCKaB0BrkpEdLhgTsKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=okCZjwxpi5Smv3VWgJl/+SHcHoAleOu5aO+k645KKm4=;
        b=aqkSagzDJJlTvGAY1Q66TyPhPpFozuCu+jysW4BkY5XEsGWvPGCqzbPhWbjTbgoNPK
         ZlRwCq78KaELeonTlNYme7edieWlwNiksx/FHJAhwmFzq5ia2c71dD+6kDhzlYT3dVji
         OzqGxYS9RP6Copnl88ci2Oe/qmFOWG1p63UhWqZ0KmRfRto+MfctERpEpqbjomP0bJET
         WANOyaF0M8VJODWh5Tyd+uBE8jMP7Hl4o9JppJFnFtZEHdCm+QY1X1axupB0OJLYU83V
         hVNb4dQMiAepzQLCUUs+mqBwRccbwGcyPrawTEIRTwikSSFZu7CWoJw4Efxo8UxUwtiQ
         SWCg==
X-Gm-Message-State: APzg51D/8aLdkb4Bt90pcg6oruFNfa3jM5oUzofYA2Oqvhl/k/xNx9xZ
        mBtP0roc3FwH4ow68kO3Xtar/CSfuHthmPL1yMsD6w==
X-Google-Smtp-Source: ANB0VdaSBifKiK7JS8X/BT+uX8e1aR5R/YcJzEcQOb9fpjWiIJG7DIijbyHLaQaEHI0INa724Q4EsScBT3SwJMdafeQ=
X-Received: by 2002:a54:4017:: with SMTP id x23-v6mr8462856oie.25.1536573044440;
 Mon, 10 Sep 2018 02:50:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:24a3:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 02:50:43
 -0700 (PDT)
X-Originating-IP: [94.21.245.65]
In-Reply-To: <CACT4Y+bhGKrHk_BB4g9nDtRYD9VaaPyBTRxTo98r1BufAh6Z8A@mail.gmail.com>
References: <00000000000024df4605757495a8@google.com> <CAJfpegsqsESUft-azOkirq9363nUXM=Sx4YMX6XVQxquEbjS7Q@mail.gmail.com>
 <CACT4Y+bhGKrHk_BB4g9nDtRYD9VaaPyBTRxTo98r1BufAh6Z8A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 10 Sep 2018 11:50:43 +0200
Message-ID: <CAJfpegs72smmBfLdAwaOgQsLGsfdvWATv9BaNVvb0o4KdY3shA@mail.gmail.com>
Subject: Re: possible deadlock in free_ioctx_users
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com>,
        bcrl <bcrl@kvack.org>, linux-aio <linux-aio@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:43 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Sep 10, 2018 at 11:28 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> On Sun, Sep 9, 2018 at 8:41 PM, syzbot
>> <syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    f8f65382c98a Merge tag 'for-linus' of git://git.kernel.org..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=113260ae400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=d86c4426a01f60feddc7
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120baa9e400000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13979cbe400000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com
>>>
>>> random: sshd: uninitialized urandom read (32 bytes read)
>>> random: sshd: uninitialized urandom read (32 bytes read)
>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>
>>> ========================================================
>>> WARNING: possible irq lock inversion dependency detected
>>> 4.19.0-rc2+ #229 Not tainted
>>> --------------------------------------------------------
>>> swapper/0/0 just changed the state of lock:
>>> 00000000c02bddef (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq
>>> include/linux/spinlock.h:354 [inline]
>>> 00000000c02bddef (&(&ctx->ctx_lock)->rlock){..-.}, at:
>>> free_ioctx_users+0xbc/0x710 fs/aio.c:603
>>> but this lock took another, SOFTIRQ-unsafe lock in the past:
>>>  (&fiq->waitq){+.+.}
>>>
>>>
>>> and interrupts could create inverse lock ordering between them.
>>>
>>>
>>> other info that might help us debug this:
>>>  Possible interrupt unsafe locking scenario:
>>>
>>>        CPU0                    CPU1
>>>        ----                    ----
>>>   lock(&fiq->waitq);
>>>                                local_irq_disable();
>>>                                lock(&(&ctx->ctx_lock)->rlock);
>>>                                lock(&fiq->waitq);
>>>   <Interrupt>
>>>     lock(&(&ctx->ctx_lock)->rlock);
>>
>> Fuse device doesn't support AIO ops.  So false positive, AFAICS.
>
> Hi Miklos,
>
> We still need to annotate this. How?

Good question.

Isn't lockdep assuming too much here?  It hasn't shown that that
ctx_lock instance was actually called from interrupt context, has it?

Thanks,
Miklos
