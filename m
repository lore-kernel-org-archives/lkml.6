Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941A8C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDD02077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDD02077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeIESZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:25:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:59860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbeIESZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:25:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D87AAD66;
        Wed,  5 Sep 2018 13:55:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C37121E3606; Wed,  5 Sep 2018 15:55:32 +0200 (CEST)
Date:   Wed, 5 Sep 2018 15:55:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com,
        ak@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com, tim.c.chen@linux.intel.com,
        zwisler@kernel.org
Subject: Re: linux-next test error
Message-ID: <20180905135532.GE24902@quack2.suse.cz>
References: <0000000000004f6b5805751a8189@google.com>
 <20180905085545.GD24902@quack2.suse.cz>
 <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 15:20:16, Souptick Joarder wrote:
> On Wed, Sep 5, 2018 at 2:25 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 05-09-18 00:13:02, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    387ac6229ecf Add linux-next specific files for 20180905
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=149c67a6400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad5163873ecfbc32
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=87a05ae4accd500f5242
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com
> > >
> > > INFO: task hung in do_page_mkwriteINFO: task syz-fuzzer:4876 blocked for
> > > more than 140 seconds.
> > >       Not tainted 4.19.0-rc2-next-20180905+ #56
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > syz-fuzzer      D21704  4876   4871 0x00000000
> > > Call Trace:
> > >  context_switch kernel/sched/core.c:2825 [inline]
> > >  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
> > >  schedule+0xfb/0x450 kernel/sched/core.c:3517
> > >  io_schedule+0x1c/0x70 kernel/sched/core.c:5140
> > >  wait_on_page_bit_common mm/filemap.c:1100 [inline]
> > >  __lock_page+0x5b7/0x7a0 mm/filemap.c:1273
> > >  lock_page include/linux/pagemap.h:483 [inline]
> > >  do_page_mkwrite+0x429/0x520 mm/memory.c:2391
> >
> > Waiting for page lock after ->page_mkwrite callback. Which means
> > ->page_mkwrite did not return VM_FAULT_LOCKED but 0. Looking into
> > linux-next... indeed "fs: convert return type int to vm_fault_t" has busted
> > block_page_mkwrite(). It has to return VM_FAULT_LOCKED and not 0 now.
> > Souptick, can I ask you to run 'fstests' for at least common filesystems
> > like ext4, xfs, btrfs when you change generic filesystem code please? That
> > would catch a bug like this immediately. Thanks.
> >
> 
> "fs: convert return type int to vm_fault_t" is still under
> review/discusson and not yet merge
> into linux-next. I am not seeing it into linux-next tree.Can you
> please share the commit id ?

As Ted wrote, it is currently commit
83c0adddcc6ed128168e7b87eaed0c21eac908e4, and it came from mm tree. But the
commit ID is going to change tomorrow since linux-next is rebuilt every
day... I'm not sure how that patch got to mm tree. That's a question for
Andrew but you should have been notified about that by his mailing
machinery.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
