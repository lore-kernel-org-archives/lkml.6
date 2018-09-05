Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6EAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BA62075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SP/GRRQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BA62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeIEOXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:23:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37965 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeIEOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:23:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id t84-v6so1332671pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8N0ZEb7OC350uTqQodFtEtKtgJXAZGTVVMz3CHFh6nE=;
        b=SP/GRRQtSh502yGI84TvMnExZE9IAgoDIzLma1MzeTaz9HrDSmB+CEe73tJvnriyUM
         Tblkv4R+QzPkQlSlLdsaA9QkD2fPvueqeJ6HsotjpZIkDeYRq8GyYdl1FZbSVn4eeviY
         yf4uf/ZSdv6/I8EhdeNiBTayJH0UuB4p/MtN6UALahYpjxNFLrt0olS/jg0eNlRg8jni
         DvcLYauojyMfpX4dzUN2uXIjVwODSoDvTZ4bdOxtsT5hU5NClhhC6WrZTfXZ9HEe8Oql
         /481eqPeCzhZ7ryWXI0yODjx364C/o4s/QgV1N221S8tOxMdXCz4IHrCLJ7S3GqXPM0Y
         yntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8N0ZEb7OC350uTqQodFtEtKtgJXAZGTVVMz3CHFh6nE=;
        b=gZ8WCmM5M5ANX5JDOwEw4INl83L1JcqrtZXcBJapqHuwCLG5onsFI1zeq2zUAkgfAC
         RcItHdLj/DtsM7WG8HffCJR1QqOBLMsGjpQJIJQVFdxN54S+k9/dLcEjbGpUrZf42sCD
         jYPn7/KDAWWSrQHt2g3BN8qPzHWu3k7cuYmWNgXxepLRGe+JSgRr0QtEd2+QYqjUqvSr
         2hXFE/nc1LzDMkKybyiWHFC0N2VsnF+lh9vARxvp6fNqHXgR+bBNoPntHu1Xz4qKWKoL
         OhKllkRNTXsnofAmCnvenPC1kEcqmFBju/AMGqZ14mb5AoJ6+jjwH30Sxw9piTjfIw2C
         42aQ==
X-Gm-Message-State: APzg51BAoyLa1BcMTEGXq08+A9gZ50FgYiGJo8rdgvckH5nhDO2ld+d/
        RG9qyjuGv717MqD5x9EvawC6uLiF6kfCxKHdNjCDGQ==
X-Google-Smtp-Source: ANB0VdYlOZE/PoLbj5m3HKSdE60uKld21QYGNliuwrIC2VVDggaisgU8zkCe0szsASCKEF2PfCXryQIrD7C+q5PK/7E=
X-Received: by 2002:a63:8e4a:: with SMTP id k71-v6mr35686365pge.45.1536141227492;
 Wed, 05 Sep 2018 02:53:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 5 Sep 2018 02:53:26
 -0700 (PDT)
In-Reply-To: <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com>
References: <0000000000004f6b5805751a8189@google.com> <20180905085545.GD24902@quack2.suse.cz>
 <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 5 Sep 2018 11:53:26 +0200
Message-ID: <CACT4Y+ZREcbum7An1Y7dby3SNQOzXvt50OaOqizXfLCXa19F6Q@mail.gmail.com>
Subject: Re: linux-next test error
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tim.c.chen@linux.intel.com, zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 11:50 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Wed, Sep 5, 2018 at 2:25 PM Jan Kara <jack@suse.cz> wrote:
>>
>> On Wed 05-09-18 00:13:02, syzbot wrote:
>> > Hello,
>> >
>> > syzbot found the following crash on:
>> >
>> > HEAD commit:    387ac6229ecf Add linux-next specific files for 20180905
>> > git tree:       linux-next
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=149c67a6400000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad5163873ecfbc32
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=87a05ae4accd500f5242
>> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> >
>> > Unfortunately, I don't have any reproducer for this crash yet.
>> >
>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com
>> >
>> > INFO: task hung in do_page_mkwriteINFO: task syz-fuzzer:4876 blocked for
>> > more than 140 seconds.
>> >       Not tainted 4.19.0-rc2-next-20180905+ #56
>> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> > syz-fuzzer      D21704  4876   4871 0x00000000
>> > Call Trace:
>> >  context_switch kernel/sched/core.c:2825 [inline]
>> >  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
>> >  schedule+0xfb/0x450 kernel/sched/core.c:3517
>> >  io_schedule+0x1c/0x70 kernel/sched/core.c:5140
>> >  wait_on_page_bit_common mm/filemap.c:1100 [inline]
>> >  __lock_page+0x5b7/0x7a0 mm/filemap.c:1273
>> >  lock_page include/linux/pagemap.h:483 [inline]
>> >  do_page_mkwrite+0x429/0x520 mm/memory.c:2391
>>
>> Waiting for page lock after ->page_mkwrite callback. Which means
>> ->page_mkwrite did not return VM_FAULT_LOCKED but 0. Looking into
>> linux-next... indeed "fs: convert return type int to vm_fault_t" has busted
>> block_page_mkwrite(). It has to return VM_FAULT_LOCKED and not 0 now.
>> Souptick, can I ask you to run 'fstests' for at least common filesystems
>> like ext4, xfs, btrfs when you change generic filesystem code please? That
>> would catch a bug like this immediately. Thanks.
>>
>
> "fs: convert return type int to vm_fault_t" is still under
> review/discusson and not yet merge
> into linux-next. I am not seeing it into linux-next tree.Can you
> please share the commit id ?

syzbot gave commit id in the report (see above)
