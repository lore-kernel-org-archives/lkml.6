Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46889C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00ADB2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cam9woCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00ADB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeIEOT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:19:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34634 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbeIEOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:19:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id c29-v6so5467801lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4FxzqIDECjKswC7wHjlECrCGqb8yk3FQYXmpTswoUU=;
        b=Cam9woClpOE4CjQlDi4rWgWRP/RsJdeyjH12gBFxhOD7wPCakn9gPvw4X4PMMXyNw/
         jkXBkUpH4R2FS+HrZdAOfshaEvfFiVaBJ+dr+1D+mNwuZyuO4zC94lv8OJBLeLZRbYsi
         d5vtKjy15In0CIAIbedbCSAsY49u8lIqP8RjGnBhaGFIAV8bzHp90n2z6DlDGgOeUPZ5
         LtbogklaQ1eRNX9siekFr9616TF8T17Ur+ynX8umwS+px5Cwj7t3rNvkUBkQa3rLkegR
         V064GuCcyA4Q6OWSPMe7APiCqwxHit4JqTP2caMwi0oj5w7EXApv7bD1c0UU+bHwxPLt
         NGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4FxzqIDECjKswC7wHjlECrCGqb8yk3FQYXmpTswoUU=;
        b=STgyyb1D7ps02hs6GP9E6vzrcdVazdFQlGQf8ecVhiJFd1dmIRVnJG9di4ZEVPD3X1
         XCpdeP9jDPYZruYEkM6Zy3WycW4l4YEHgaaBdCMeHKBh8uAwL0KCUwSMu/bQHJHebbBk
         OySJLdACglyy1oMhM4Nzr0K59lkU/8ybLHJGw5kzfPWZ7pKh4bZr/W+kzyA8HBe8mjzm
         Pr0qL+1SDFTCGobKdhrEDGDey8pPdJHZuq1bzVQnd3dtAN+caK4/0qgEihCM2HAMnFby
         EKqQPtOxuuMSlN2GBa1f4VTOjxRTInOCX5IOUdMPX2WO+wIphPHzPecnYOIHq4+noMTW
         bKEg==
X-Gm-Message-State: APzg51Ak/Dy8x/37KPWbaS2QoP9SgXR35G8+k0KbzYfk8ghQxgRcQ1te
        0v/Wqr9IpIFDyVkpLaYJUZxdwaGNI5OeJ1Vn4VbRmKz/
X-Google-Smtp-Source: ANB0VdZW88q+sr9ztfikO42WHjp80PclOZmezaQ90IBtCAQfZFaledPbuQak29mJunt5wHGpmV7xBvnknA1tWBG7XV8=
X-Received: by 2002:a19:6f0a:: with SMTP id k10-v6mr16681697lfc.143.1536141028905;
 Wed, 05 Sep 2018 02:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004f6b5805751a8189@google.com> <20180905085545.GD24902@quack2.suse.cz>
In-Reply-To: <20180905085545.GD24902@quack2.suse.cz>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 5 Sep 2018 15:20:16 +0530
Message-ID: <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com>
Subject: Re: linux-next test error
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com,
        ak@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com, tim.c.chen@linux.intel.com,
        zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 2:25 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 05-09-18 00:13:02, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    387ac6229ecf Add linux-next specific files for 20180905
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=149c67a6400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad5163873ecfbc32
> > dashboard link: https://syzkaller.appspot.com/bug?extid=87a05ae4accd500f5242
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com
> >
> > INFO: task hung in do_page_mkwriteINFO: task syz-fuzzer:4876 blocked for
> > more than 140 seconds.
> >       Not tainted 4.19.0-rc2-next-20180905+ #56
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > syz-fuzzer      D21704  4876   4871 0x00000000
> > Call Trace:
> >  context_switch kernel/sched/core.c:2825 [inline]
> >  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
> >  schedule+0xfb/0x450 kernel/sched/core.c:3517
> >  io_schedule+0x1c/0x70 kernel/sched/core.c:5140
> >  wait_on_page_bit_common mm/filemap.c:1100 [inline]
> >  __lock_page+0x5b7/0x7a0 mm/filemap.c:1273
> >  lock_page include/linux/pagemap.h:483 [inline]
> >  do_page_mkwrite+0x429/0x520 mm/memory.c:2391
>
> Waiting for page lock after ->page_mkwrite callback. Which means
> ->page_mkwrite did not return VM_FAULT_LOCKED but 0. Looking into
> linux-next... indeed "fs: convert return type int to vm_fault_t" has busted
> block_page_mkwrite(). It has to return VM_FAULT_LOCKED and not 0 now.
> Souptick, can I ask you to run 'fstests' for at least common filesystems
> like ext4, xfs, btrfs when you change generic filesystem code please? That
> would catch a bug like this immediately. Thanks.
>

"fs: convert return type int to vm_fault_t" is still under
review/discusson and not yet merge
into linux-next. I am not seeing it into linux-next tree.Can you
please share the commit id ?
