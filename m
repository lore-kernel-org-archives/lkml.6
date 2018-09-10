Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85084C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394952086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eg4DYcG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394952086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeIJOhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:37:03 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53520 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeIJOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:37:03 -0400
Received: by mail-it0-f65.google.com with SMTP id p79-v6so28667427itp.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YBt2LLg3d5Qo0TxZy9S5pEDXQ5aB88QJQEYbY43HYbk=;
        b=Eg4DYcG5H+Jqu/jgbv5bmFsSxte9WYzzMgjHTRY6nc+OEKpIbhzsP83wN0GdBnCqqQ
         +Xi/LjnUHHrpNmpgFydJE2dfR5ljVALGJHmP8dEMVxdA13efczwGcjAVH2X6ztcSi5p/
         OBesMJIuFY3wZAk/Bje/dddTq0bki2ab3TrBkFBhYKuqKPnmSONybJ9Wepzp7gCzNOZ9
         G4vGIsDU7wkmfhA0hqzFzld3MC8w9C59F8jV7igHVv+BaL1UDpdn1GViQH7bMD65nnks
         112K8JiccGjwOFWQ/Jce0CutF7xFoK6IRtJ3C+hZrM2akqYiRtLjx7WAy40SuUKWW0ZG
         cNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YBt2LLg3d5Qo0TxZy9S5pEDXQ5aB88QJQEYbY43HYbk=;
        b=XZXpTAPg/1iC76ipn23239co3qm5+GOW3U0lm9h/LKArL2xmmINmMoc7eMAqmrPayu
         VwPgxZFIhQIxiC+qNB8/JFKhC14MXAL44lFvBsXFwRvKZ4fB93Q7ARh1/whG07cXW8/t
         LA8LVWx5fIj2p90Hk/TXaPDQL1552b0RBt+JITBNfkpr4d78MCcks7h0mCmEGI273By3
         hV4Xu7xO7Kjd3WDrv27ZGnkmobG/jagQFFqG5L5zj3CjKLGC7lujPXYmIXRdflAPo7H/
         Fxkh/vJcSNLT8t35wR93x6IQBEzbMV+Kz920tKbw+AcNp92buMHPwFau0+MiPucdA/F5
         eY9g==
X-Gm-Message-State: APzg51COugfVyFHJJNJexbZ6UND932VwNkT88CcwfKFnYbE3KYJYBLHj
        yplArBpujFxB0DKbR8koRsP4b/fYUnSOkcFQDyu1bw==
X-Google-Smtp-Source: ANB0VdYT6GS3SiUmeZhbcEFAVDKLdRIOCeXyIESzP8XdFggIE97xaNRmHSaWi+393t2dh8dckJ9Dk8HKCWuuHmImzO8=
X-Received: by 2002:a24:ef43:: with SMTP id i64-v6mr16696191ith.47.1536572631532;
 Mon, 10 Sep 2018 02:43:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 02:43:31
 -0700 (PDT)
In-Reply-To: <CAJfpegsqsESUft-azOkirq9363nUXM=Sx4YMX6XVQxquEbjS7Q@mail.gmail.com>
References: <00000000000024df4605757495a8@google.com> <CAJfpegsqsESUft-azOkirq9363nUXM=Sx4YMX6XVQxquEbjS7Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 10 Sep 2018 11:43:31 +0200
Message-ID: <CACT4Y+bhGKrHk_BB4g9nDtRYD9VaaPyBTRxTo98r1BufAh6Z8A@mail.gmail.com>
Subject: Re: possible deadlock in free_ioctx_users
To:     Miklos Szeredi <miklos@szeredi.hu>
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

On Mon, Sep 10, 2018 at 11:28 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Sun, Sep 9, 2018 at 8:41 PM, syzbot
> <syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    f8f65382c98a Merge tag 'for-linus' of git://git.kernel.org..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=113260ae400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d86c4426a01f60feddc7
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120baa9e400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13979cbe400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com
>>
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>>
>> ========================================================
>> WARNING: possible irq lock inversion dependency detected
>> 4.19.0-rc2+ #229 Not tainted
>> --------------------------------------------------------
>> swapper/0/0 just changed the state of lock:
>> 00000000c02bddef (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq
>> include/linux/spinlock.h:354 [inline]
>> 00000000c02bddef (&(&ctx->ctx_lock)->rlock){..-.}, at:
>> free_ioctx_users+0xbc/0x710 fs/aio.c:603
>> but this lock took another, SOFTIRQ-unsafe lock in the past:
>>  (&fiq->waitq){+.+.}
>>
>>
>> and interrupts could create inverse lock ordering between them.
>>
>>
>> other info that might help us debug this:
>>  Possible interrupt unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(&fiq->waitq);
>>                                local_irq_disable();
>>                                lock(&(&ctx->ctx_lock)->rlock);
>>                                lock(&fiq->waitq);
>>   <Interrupt>
>>     lock(&(&ctx->ctx_lock)->rlock);
>
> Fuse device doesn't support AIO ops.  So false positive, AFAICS.

Hi Miklos,

We still need to annotate this. How?
