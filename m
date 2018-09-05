Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C001C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5232086B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oSQNQw//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5232086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeIEO2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:28:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41783 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeIEO1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:27:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so3208178pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n55PppqpqKeXzNB/P/Vxe/ZJ5eYaOuZhB/tQDCbBJM4=;
        b=oSQNQw//ts2v8+j+zica8DpktqUWSAcSir1hQgvNWAW7C85gsbvBdrO3CAF3eeGYRY
         xd90e5JOvorPEa7fOZOzV8BJdFSjphVqGHyajd92ChqfDgOEh7grcyQQJYNQjSGJ9ZAl
         fy+OQNZ8W8KrVKaL4sj4o4kfAlvSTrSHnkWtizz4wjXf01EIGvMdcY5mlguxfKwFXCyT
         Zy/y3wYZ/NYkhyGUqZ8/0wk4g25yAmyj1ZNU9WDlLwkDQFgFh7VtMXbc47bgeEpgUICR
         bk9/UPVk5zM0Cv8yYLx2jxRuBHJf3CMJvc8bUP9g70IFE3USu+smpqt1+Sn3olnltTrT
         vyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n55PppqpqKeXzNB/P/Vxe/ZJ5eYaOuZhB/tQDCbBJM4=;
        b=XjgRK94RQf/fC0Q2V2d6/MsNnaGtN2TKAEsmtMB8y/QucpPCDHrd7eJCemvcHWggk3
         qqnJ/f+pWrzGX0GzCDhBywyW/itJwdWvDn3aZ6ZbLokBNf1VtfWNWc2SdYhiKGub36mm
         ewWx55a0BRa7GZst3CcfYI/4p5xWelE0b45K6sxt9mk0378KMEhBo/d+c2WBX14O1mEU
         XZ4lwSfJpBcyq541GlL4+n1c8z3ivu1+yDUVDdNXpxbuby8/ejeEGE9aykdGZuMuegBy
         uS4Tt6CA6sQKvHpkkDxqKJSqO7Afe5nbbYi35+yMK/qFx9Q45c6q6ba7VgLkSbvgTj9/
         ltDQ==
X-Gm-Message-State: APzg51DKz/nyKJlARozIhvqIJtCB36UbWShcl3sIMmSX8w87LZSqHaCO
        tOH4+XH20ylAhTu6ag3HT+JDBRX0qDJYdn8ZBblP6g==
X-Google-Smtp-Source: ANB0VdaBq/3MKKw/m9o8w3EI3naLgWeIUmOEhLnRanY8VgHc5s99+rIqdQJnOGNolFFBJWRgulfj/G3YJPtG66OQEtk=
X-Received: by 2002:a63:9c19:: with SMTP id f25-v6mr35880052pge.447.1536141496108;
 Wed, 05 Sep 2018 02:58:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 5 Sep 2018 02:57:55
 -0700 (PDT)
In-Reply-To: <CACT4Y+ZREcbum7An1Y7dby3SNQOzXvt50OaOqizXfLCXa19F6Q@mail.gmail.com>
References: <0000000000004f6b5805751a8189@google.com> <20180905085545.GD24902@quack2.suse.cz>
 <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com> <CACT4Y+ZREcbum7An1Y7dby3SNQOzXvt50OaOqizXfLCXa19F6Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 5 Sep 2018 11:57:55 +0200
Message-ID: <CACT4Y+ZdySFy4_Knxek_OTrUxNQr8mvwCVoZb_pKAQ2e=Cw2yQ@mail.gmail.com>
Subject: Re: linux-next test error
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tim.c.chen@linux.intel.com, zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 11:53 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Sep 5, 2018 at 11:50 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> On Wed, Sep 5, 2018 at 2:25 PM Jan Kara <jack@suse.cz> wrote:
>>>
>>> On Wed 05-09-18 00:13:02, syzbot wrote:
>>> > Hello,
>>> >
>>> > syzbot found the following crash on:
>>> >
>>> > HEAD commit:    387ac6229ecf Add linux-next specific files for 20180905
>>> > git tree:       linux-next
>>> > console output: https://syzkaller.appspot.com/x/log.txt?x=149c67a6400000
>>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad5163873ecfbc32
>>> > dashboard link: https://syzkaller.appspot.com/bug?extid=87a05ae4accd500f5242
>>> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> >
>>> > Unfortunately, I don't have any reproducer for this crash yet.
>>> >
>>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> > Reported-by: syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com
>>> >
>>> > INFO: task hung in do_page_mkwriteINFO: task syz-fuzzer:4876 blocked for
>>> > more than 140 seconds.
>>> >       Not tainted 4.19.0-rc2-next-20180905+ #56
>>> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>> > syz-fuzzer      D21704  4876   4871 0x00000000
>>> > Call Trace:
>>> >  context_switch kernel/sched/core.c:2825 [inline]
>>> >  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
>>> >  schedule+0xfb/0x450 kernel/sched/core.c:3517
>>> >  io_schedule+0x1c/0x70 kernel/sched/core.c:5140
>>> >  wait_on_page_bit_common mm/filemap.c:1100 [inline]
>>> >  __lock_page+0x5b7/0x7a0 mm/filemap.c:1273
>>> >  lock_page include/linux/pagemap.h:483 [inline]
>>> >  do_page_mkwrite+0x429/0x520 mm/memory.c:2391
>>>
>>> Waiting for page lock after ->page_mkwrite callback. Which means
>>> ->page_mkwrite did not return VM_FAULT_LOCKED but 0. Looking into
>>> linux-next... indeed "fs: convert return type int to vm_fault_t" has busted
>>> block_page_mkwrite(). It has to return VM_FAULT_LOCKED and not 0 now.
>>> Souptick, can I ask you to run 'fstests' for at least common filesystems
>>> like ext4, xfs, btrfs when you change generic filesystem code please? That
>>> would catch a bug like this immediately. Thanks.
>>>
>>
>> "fs: convert return type int to vm_fault_t" is still under
>> review/discusson and not yet merge
>> into linux-next. I am not seeing it into linux-next tree.Can you
>> please share the commit id ?
>
> syzbot gave commit id in the report (see above)

-mawilcox@microsoft.com as I getting bounces from mail server
