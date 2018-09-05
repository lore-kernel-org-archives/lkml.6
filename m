Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EE6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2032075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo61KTEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2032075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeIEXfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:35:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39122 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeIEXfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:35:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so7173231lji.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyLEKxT2jEEkFxW9J9G+TEhF3g1oXeb1eZGUvckkaH8=;
        b=fo61KTECyxa1kUneZqk6vRKNpwuDRfHE6YSmMoMzvmEGOZXLdfSi6Q9ML5sxhf0pcp
         4NgT5ImFcQmD7YK8xkMXnRDGHElFHZzmzf7NwdJ9/3TLQc9MwcunUdUbfZ4DgyF26Xp9
         pcLx84LzcPVmj9BxWFKA5r5QrBU4NmI9A1HZQcBQXKNasyjFgF9PrMD0NLDsDpRSZMgB
         9HPZROw9T5b02rO9Ds7E9QThYgbt//ONB5v3HJCF+OSl+U2q2GOktazzKKeE+bKNm2RF
         p/Cn43b5fd1OqP7LVcSkaleLJyTxbgltlZnSZBL4iqTFni1ryChgfVs3YoskawXCj87F
         myVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyLEKxT2jEEkFxW9J9G+TEhF3g1oXeb1eZGUvckkaH8=;
        b=GqwHm4g+NrDnLA7loN/23683j1qyFB0ljwxH+TNBHkE7IOkfTFdbXsqZss4A1gO+Y+
         AwdH7WVNnPvCpFqT/r1uOVi2dj0Q0B0RDv7iFbLuML4cqXo0PHk/mqUTN9nedN98FT68
         4jhyVlWIj0SEtsCn5jIIIIStPpEzTCJEeyncS9MQIBRMGth1Z2LBVt0y0EZlgQiHzs35
         co2uKB25zZ4gVbNyewCSrxnyEo1dy+o08rXCFGD28oVR9qDPhKkJN3h8gxaskcp7tAzu
         HEJa6AA1uOuQmqCC8Yn93zszmWRwscKJGnNunXoObYKWA63lD2c66PMpZ9XW9xeBy4Vw
         UsTg==
X-Gm-Message-State: APzg51APurS3Dmx02Q/NidB6hi8nZk4TtToGEpaDMZQgjDob5VnGwxUp
        zchGnwu7eoSMHHGzLjKRTVLXyxmNEiIx1FD2Q9c=
X-Google-Smtp-Source: ANB0Vdb1ko48uPs81AkdLaa15rhftQKtpm+ldrikHIZgmdd98Ajn4w6teBcUP9VXSID8epFHtpcBc5sGynHBgubX/2k=
X-Received: by 2002:a2e:860d:: with SMTP id a13-v6mr1778802lji.43.1536174252194;
 Wed, 05 Sep 2018 12:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004f6b5805751a8189@google.com> <20180905085545.GD24902@quack2.suse.cz>
In-Reply-To: <20180905085545.GD24902@quack2.suse.cz>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 6 Sep 2018 00:37:06 +0530
Message-ID: <CAFqt6zaeOzrzMCqtnv=3gF4+K9HGtbB0C7bOeE+6YmBvvxBaxQ@mail.gmail.com>
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

Looking into existing code block_page_mkwrite() returns 0, not VM_FAULT_LOCKED
in true path and this patch doesn't change any existing behaviour of
block_page_mkwrite()
except adding one new input parameter to return err value to caller function.

-int ext4_page_mkwrite(struct vm_fault *vmf)
+vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)

+       err = 0;
+       ret = block_page_mkwrite(vma, vmf, get_block, &err);
        if (!ret && ext4_should_journal_data(inode)) {
                if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
                          PAGE_SIZE, NULL, do_journal_get_write_access)) {
                        unlock_page(page);
-                       ret = VM_FAULT_SIGBUS;

I think, this part has created problem where page_mkwrite()
end up with returning 0.

Correct me if I am wrong.
