Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D27C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5332086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zr5apeb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5332086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeIJO5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:57:35 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38369 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeIJO5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:57:34 -0400
Received: by mail-io0-f196.google.com with SMTP id y3-v6so151501ioc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 03:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/xUu7u6g6nMLkUgxb4rUbhPm2CU+c5aV2ky3Qv0ymyc=;
        b=Zr5apeb6p4rHnmpi1U5i0XKxMEQlxO94tCXsU5IZqq7bjqhx+V3oFn0vaTwnotSEKe
         d4HPsxnWKDBrXvCgtXpfwn1BpH9dzCwG6W6wqxE00j3XpLGyqXPq+o+S2CHVsqvHKhqf
         f3uiu6QNome92+CrcrXIDvywkC48qLZteZMk7c9xYcKt4nfwcild5GtnQb91rT+lzfTu
         SjV4ivI9QNdwi1MPXKdmi76tua529LC/Q9K5Rgeebm3fG2Vyy7zhASd7PQY2nRE/9kzo
         ehYp2bJVRhuaP6Aq3CLOTGAZUmsQ9SsHnAiTt4sJQ3nJoMK5r5JAjQoC7X3RTCe6QBbi
         NQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/xUu7u6g6nMLkUgxb4rUbhPm2CU+c5aV2ky3Qv0ymyc=;
        b=aP1kJjOqMF6BpV1cfIuI8IOcnQWoRV/jyJLGsDRbn7VBfw0CqrrVScy6SSkAE681XV
         l2h+CNvs+SwFFFHgwm00D4V/MESJVsbxZA56l5GdSN+/1CbsN+fTw6MNjhTIsxzAGpL3
         dfmVMPy1CEB6uPxqCHLuKq8CaYnZArdCs0KMrg0/a0PqUgkaGk78pSVvik19ShYWVJEw
         UTlJIKlDHdm/WZOCDesd0QFOKqLHKPQNvoSgsthI2PLQ8d9CLZVj+Y5GM/h89LvYfF18
         iDhaCelhub3iY2eG59yIfJb3/fSIPWL+P6J6T4T0guh6J/15mmwxum1TXPvchhs9xDZ3
         8Puw==
X-Gm-Message-State: APzg51DhqpimvZRdX3ZU5yNboL5iLeJgfsBGLw+mJYFlyp+ERzfy9+OJ
        b34TQ+qxs9x7x8Ng4SaZDL0vguuwAygJ2Z1Q3yvRlQ==
X-Google-Smtp-Source: ANB0VdZXgAu0mC3pqiRUqoYQvN8KNyM0BHcDeFs5hhqOpPuBec5AJo35qJYkTKo6Fb23kZO04QdbtNk1/aO+xZCFQIQ=
X-Received: by 2002:a6b:f316:: with SMTP id m22-v6mr14788337ioh.271.1536573857448;
 Mon, 10 Sep 2018 03:04:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 03:03:56
 -0700 (PDT)
In-Reply-To: <CAJfpegs72smmBfLdAwaOgQsLGsfdvWATv9BaNVvb0o4KdY3shA@mail.gmail.com>
References: <00000000000024df4605757495a8@google.com> <CAJfpegsqsESUft-azOkirq9363nUXM=Sx4YMX6XVQxquEbjS7Q@mail.gmail.com>
 <CACT4Y+bhGKrHk_BB4g9nDtRYD9VaaPyBTRxTo98r1BufAh6Z8A@mail.gmail.com> <CAJfpegs72smmBfLdAwaOgQsLGsfdvWATv9BaNVvb0o4KdY3shA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 10 Sep 2018 12:03:56 +0200
Message-ID: <CACT4Y+aEv1M+HOdsY88coKBQ=PpAS8sC+o9mOfkRCOQ-uVagKg@mail.gmail.com>
Subject: Re: possible deadlock in free_ioctx_users
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
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

On Mon, Sep 10, 2018 at 11:50 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Mon, Sep 10, 2018 at 11:43 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Mon, Sep 10, 2018 at 11:28 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>> On Sun, Sep 9, 2018 at 8:41 PM, syzbot
>>> <syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com> wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    f8f65382c98a Merge tag 'for-linus' of git://git.kernel.org..
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=113260ae400000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=d86c4426a01f60feddc7
>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120baa9e400000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13979cbe400000
>>>>
>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>> Reported-by: syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com
>>>>
>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>>
>>>> ========================================================
>>>> WARNING: possible irq lock inversion dependency detected
>>>> 4.19.0-rc2+ #229 Not tainted
>>>> --------------------------------------------------------
>>>> swapper/0/0 just changed the state of lock:
>>>> 00000000c02bddef (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq
>>>> include/linux/spinlock.h:354 [inline]
>>>> 00000000c02bddef (&(&ctx->ctx_lock)->rlock){..-.}, at:
>>>> free_ioctx_users+0xbc/0x710 fs/aio.c:603
>>>> but this lock took another, SOFTIRQ-unsafe lock in the past:
>>>>  (&fiq->waitq){+.+.}
>>>>
>>>>
>>>> and interrupts could create inverse lock ordering between them.
>>>>
>>>>
>>>> other info that might help us debug this:
>>>>  Possible interrupt unsafe locking scenario:
>>>>
>>>>        CPU0                    CPU1
>>>>        ----                    ----
>>>>   lock(&fiq->waitq);
>>>>                                local_irq_disable();
>>>>                                lock(&(&ctx->ctx_lock)->rlock);
>>>>                                lock(&fiq->waitq);
>>>>   <Interrupt>
>>>>     lock(&(&ctx->ctx_lock)->rlock);
>>>
>>> Fuse device doesn't support AIO ops.  So false positive, AFAICS.
>>
>> Hi Miklos,
>>
>> We still need to annotate this. How?
>
> Good question.
>
> Isn't lockdep assuming too much here?  It hasn't shown that that
> ctx_lock instance was actually called from interrupt context, has it?

+lockdep maintainers for lockdep false positive and how to annotate it

Full reports are available here:
https://syzkaller.appspot.com/bug?extid=d86c4426a01f60feddc7
