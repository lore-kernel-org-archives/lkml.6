Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961D2C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8E621473
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 16:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dL/DckBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8E621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeIWWcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 18:32:01 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40808 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeIWWcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 18:32:00 -0400
Received: by mail-it1-f193.google.com with SMTP id h23-v6so7654524ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d7/iOYyXx4a0cn8mFjuMxNglWgCdCbkWVKz9DOM0/Z0=;
        b=dL/DckBN/VDw5ZZYa0iUQBbooF6C01ttVcuzrcjA3iZirVF5xVLB27qfZEKOd57cMT
         wjt5dkICzJSUx1N/FQrl4F8+hTreYjr/V+BL2b8+SfVzYj7ry1O4cHojG3Uv9A/ReF7k
         CIXiDm41rY5//7FqG8eUap678jH3FyuJEjgv7wT2pNiLNjX0IpRZxixzHkVwHFjHzyIX
         c7+fgHYxHwrsA1tMBnOdruLnqPAXTBUjYBwRm1kxVVePAfLYnEM9u9DKPiPf+jP1nIi9
         b/heTyqv56mkvakbHGpuYtI4SslG2FxzX2oROdXdPv/QPeE4do2lNIPIiO4Lk1IA+n7v
         mu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d7/iOYyXx4a0cn8mFjuMxNglWgCdCbkWVKz9DOM0/Z0=;
        b=PjrwcImurkSpOOBSHhZ9IL9wp/fhJaNAwdAmCvVJ45qczK5DCPwzI16y+4A58bc+Z0
         ueiM6mhUQjIxocumxh+x2oOCnP3ccELD4DlApbY61ViF0+XOgbd0/eM6zXZNF9nSPgHm
         kE/a4/yhzL+Ms8G9RukfoWQG8i2LfQkimPTbavqs8e9Vt5gtRTkw43u598spcMlA17V6
         vZRrLllXqI9IXBSdSW8q/rqdA4iGM+/FWbnphePwL5OpfO8GKQq76/ME0V/VMktX8REa
         yzI0g/hLJkmh9LfsmCjFKrF5XSwa1qEOiJiWzIQz7sv0pLVg/OgnwIXeNxkV0/NPqfZq
         yM6Q==
X-Gm-Message-State: APzg51CVZF4AY11ZZkembv+IysJuwklW3dnf88nq37JFW4H+HNkpCrOq
        afng9042egsDmjpHSQgLQh175nJ3hIiDgNN9xueteA==
X-Google-Smtp-Source: ANB0VdYuTO+kSxiFMC7CvxC6/gN+zsuT3biMiwUQfdsyElRRIakAgXus/B8XlLP3WIdN86jvFqjSpLAaFV6Yd+ARgsw=
X-Received: by 2002:a02:88f7:: with SMTP id b52-v6mr6349985jak.25.1537720438006;
 Sun, 23 Sep 2018 09:33:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 09:33:37
 -0700 (PDT)
In-Reply-To: <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
References: <000000000000e5f76c057664e73d@google.com> <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 23 Sep 2018 18:33:37 +0200
Message-ID: <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 7:52 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Sep 21, 2018 at 10:24 AM syzbot
> <syzbot+87829a10073277282ad1@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    234b69e3e089 ocfs2: fix ocfs2 read block panic
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=131f761a400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
>> dashboard link: https://syzkaller.appspot.com/bug?extid=87829a10073277282ad1
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126ca61a400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119d6511400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+87829a10073277282ad1@syzkaller.appspotmail.com
>>
>> input: syz0 as /devices/virtual/input/input25382
>> WARNING: CPU: 0 PID: 11238 at mm/slab_common.c:1031 kmalloc_slab+0x56/0x70
>> mm/slab_common.c:1031
>> Kernel panic - not syncing: panic_on_warn set ...
>
> This is coming from:
>
> commit 6286ae97d10ea2b5cd90532163797ab217bfdbdf
> Author: Christoph Lameter <cl@linux.com>
> Date:   Fri May 3 15:43:18 2013 +0000
>
>    slab: Return NULL for oversized allocations
>
>    The inline path seems to have changed the SLAB behavior for very large
>    kmalloc allocations with  commit e3366016 ("slab: Use common
>    kmalloc_index/kmalloc_size functions"). This patch restores the old
>    behavior but also adds diagnostics so that we can figure where in the
>    code these large allocations occur.
>
>    Reported-and-tested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>    Signed-off-by: Christoph Lameter <cl@linux.com>
>    Link: http://lkml.kernel.org/r/201305040348.CIF81716.OStQOHFJMFLOVF@I-love.SAKURA.ne.jp
>    [ penberg@kernel.org: use WARN_ON_ONCE ]
>    Signed-off-by: Pekka Enberg <penberg@kernel.org>
>
> You'll have to convince Cristoph that WARN_ON_ONCE() there is evil and
> has to be eradicated so that KASAN can run (but then we'd not know
> easily that some allocation failed because it was too big and never
> had a chance of succeeding vs. ordinary memory failure).
>
> Can I recommend that maybe you introduce infrastructure for
> panic_on_warn to ignore certain "well known" warnings?

Hi Christoph,

What was the motivation behind that WARNING about large allocations in
kmalloc? Why do we want to know about them? Is the general policy that
kmalloc calls with potentially large size requests need to use NOWARN?
If this WARNING still considered useful? Or we should change it to
pr_err?
