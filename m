Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81960C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384B520882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWB9Wm/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384B520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932632AbeGILCo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:02:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33656 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754438AbeGILCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:02:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so1149018pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cJiAMb6Q6DmV+Y69Ur6cz3hUb8brg/GrjRFg9kkI43o=;
        b=oWB9Wm/gY0DCEjJ+of4R8n2AUQyh3Z2z3sTvqsYOGVzjKQnH4GCmAHFl7YWFRzbpN2
         5s1E64z2tz4zLnJHX1G18AvnRRZ+9q6LgtsQxLcBPt6Enc9YsqKLxmEX/t9InDzOJXg+
         o9B1vSmrPZf/fvOnfBtfZ2OZwk27G+9Kwa/U2xIfi3I0UO4Qy53LLx/cZ8t206HqMJa4
         /n5vQvd1WbJH15ihuoxpNDAdfHJ8Q/MychT7Q3XpGQivfWusJHfrUDaJMVmNjrw7exoP
         X1O0JGQ9rq/dGgz2ZsDZFYZzmSYWL9qYG27X4/M6WLtAzUM6DpHxvbY1sNawj7HicHFa
         WALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cJiAMb6Q6DmV+Y69Ur6cz3hUb8brg/GrjRFg9kkI43o=;
        b=kBJl58XgGGHVmZpN9NTtyR4TVtMRh+ysr/KKRx0vds42njHP7DxknmFlBnmrjXRiY/
         FV0WgNzFD062TjCckqIMIzSowfF8RoDF4+rfqEHrhdy0MPY45PQ7UKZGcWzq7bR1irW8
         3vBezUMRvGwIXHL6x6VZJU/mHlytlQwAktduSixzKfAV9ZzHMa1uvjvNAQduj6twrf03
         FV49W9L0NCndEltCk74o8coG8QNpj7Xvtcm+JupG5/z2ZtYWS1+jnqe62UcKwpCY5aLB
         Z6I+VnZFG7xx85Sx7Z7rB8GOrZQmIs/VZX/3Sg+yMWelI+72Hnf4kUhOWT1ovcg91JVV
         CePQ==
X-Gm-Message-State: APt69E1jIRyklxKi8Viiw3Lm09oBaST9uE7DGghg5d0Ul4/rkfZag6w/
        6J3TiH1hQXweWKZ4GHK8LkhpvnMdz8hLxwdLZ+ZFLw==
X-Google-Smtp-Source: AAOMgpeR3CfgO2XAaTs0HDCFWV2iuHVxthHj/OCBI/YqDVqoq0I/Z+Og0Tyl0ulAQCqBlbFOcAlf7IAoxUvQjGO1TOM=
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr18162489pgu.96.1531134162032;
 Mon, 09 Jul 2018 04:02:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Mon, 9 Jul 2018 04:02:21
 -0700 (PDT)
In-Reply-To: <87y3ekafcw.fsf@ashishki-desk.ger.corp.intel.com>
References: <000000000000ccdf0605708a9ccc@google.com> <87y3ekafcw.fsf@ashishki-desk.ger.corp.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Jul 2018 13:02:21 +0200
Message-ID: <CACT4Y+Yd+8qSFZVU1LydP7gaRSRiZ7qTceri+TkVVCcpOeP+YA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in _free_event
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     syzbot <syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        jolsa@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 12:11 PM, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> syzbot <syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com> writes:
>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    b2d44d145d2a Merge tag '4.18-rc3-smb3fixes' of git://git.s..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=178cf50c400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a24c397a29ad22d86c98
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>
> Is there a chance of getting a reproducer for this one?

There is a chance. Frequently syzbot finds a reproducer after some
time. What's the chance in this case I don't know. Since it happened
only once so far, probably not too high.

But there seems to be a good hint in the KASAN report: task was freed
right inside of fork/copy_process, probably some error happened, but
it seems to have been registered in some global list already and
perf_release discovered it there. Does it make sense? Was it
registered? What should have been prevented the task alive at the time
of access?
