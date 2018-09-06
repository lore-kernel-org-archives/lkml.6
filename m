Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4EDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6DB2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ7+TU3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6DB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeIFQh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:37:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34745 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeIFQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:37:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id c29-v6so8854550lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 05:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=puVROpDm6YLMlP25+xOMoqNoD4VFlV3xP/zUL7OM/1o=;
        b=IJ7+TU3k31NEfcr0CuSBPgtqyZ1lERk7q2hhlSk0A/gBZX73Mn/1tG5BMNO75O799E
         VCMc2SbQa3jnsK52mrZ5kAUziaB9FEAg5sxpGBzfxeTvutRYwOdKWnMNi5U/Zg0lxXFK
         EczNUxLj2B6SwwS2woKxJbDsevnhMI/6rhmhYiPa5ZOYSAt+jvopYKRSjvvEvzfLjsw6
         uH2DyA8J9aoS/XxZFFcmVmcKu2viBPKoIf+I8eNC8fui1MJYjcRieufVKfCShtZfCiyz
         C6gKbAkVHYUeJ/5tx7RBjoCEQm7pVN4Cnla7nngPgUKQ5QTWkmYW9vs13c8Nw45oVpKx
         9aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puVROpDm6YLMlP25+xOMoqNoD4VFlV3xP/zUL7OM/1o=;
        b=haNVYKUrr/AnQpa2zQmQQLAMjlvAJwPVKJC701/x5gH0NAFqan8i6cv98Onezp8otF
         /JEzPlWJ3whLCIAwNmZfZtLe5fsOyyMr4APvUN54CmedYVLSbhSVWNjRBMffKBtCxmL8
         rjqaIT4AKNF8gYXWwLoHo0wGlVLQ5eDdVuB8Wazg4psYwa21J/mBuTYoZC5POiHR7kZY
         A33H2Fsy8TkV+RNHgAhOSZjzPdvhIfxFEe35ttwcSoe9wwElh43aPU2KYWE8a0UCeCH2
         2/KXcaqiG3WisSX+Yzqx3O4jLmiiFd83HLK9VwKa8tpkc4hsFSBg/QtIFTlzfCRU5Ie7
         5yBg==
X-Gm-Message-State: APzg51ADE58tt2/xyTmgtoIliDO3LxPX+T62XySb+bV0EXeeJAw+V4g8
        e5MS7FiDM+JFq99+P7ZaQdRa7MGdKFzT3w2XjB8=
X-Google-Smtp-Source: ANB0VdYWdjIxp/QZswWKHaNV2EWLmpXyF7AdQsfFYtJaMWI648t0dRFOSC0kGJPw0wWObWW2qf2gGfK3L91JP8P9jR4=
X-Received: by 2002:a19:4e4e:: with SMTP id c75-v6mr1744702lfb.116.1536235334732;
 Thu, 06 Sep 2018 05:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004f6b5805751a8189@google.com> <20180905085545.GD24902@quack2.suse.cz>
 <CAFqt6zaeOzrzMCqtnv=3gF4+K9HGtbB0C7bOeE+6YmBvvxBaxQ@mail.gmail.com> <20180906081253.GB19319@quack2.suse.cz>
In-Reply-To: <20180906081253.GB19319@quack2.suse.cz>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 6 Sep 2018 17:32:02 +0530
Message-ID: <CAFqt6zbVRV7Zsr2icJLZ+hX1RXObMJ5Zgf31ZAZTyjQyzAnuqw@mail.gmail.com>
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

On Thu, Sep 6, 2018 at 1:42 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 06-09-18 00:37:06, Souptick Joarder wrote:
> > On Wed, Sep 5, 2018 at 2:25 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 05-09-18 00:13:02, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    387ac6229ecf Add linux-next specific files for 20180905
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=149c67a6400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad5163873ecfbc32
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=87a05ae4accd500f5242
> > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > >
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com
> > > >
> > > > INFO: task hung in do_page_mkwriteINFO: task syz-fuzzer:4876 blocked for
> > > > more than 140 seconds.
> > > >       Not tainted 4.19.0-rc2-next-20180905+ #56
> > > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > syz-fuzzer      D21704  4876   4871 0x00000000
> > > > Call Trace:
> > > >  context_switch kernel/sched/core.c:2825 [inline]
> > > >  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
> > > >  schedule+0xfb/0x450 kernel/sched/core.c:3517
> > > >  io_schedule+0x1c/0x70 kernel/sched/core.c:5140
> > > >  wait_on_page_bit_common mm/filemap.c:1100 [inline]
> > > >  __lock_page+0x5b7/0x7a0 mm/filemap.c:1273
> > > >  lock_page include/linux/pagemap.h:483 [inline]
> > > >  do_page_mkwrite+0x429/0x520 mm/memory.c:2391
> > >
> > > Waiting for page lock after ->page_mkwrite callback. Which means
> > > ->page_mkwrite did not return VM_FAULT_LOCKED but 0. Looking into
> > > linux-next... indeed "fs: convert return type int to vm_fault_t" has busted
> > > block_page_mkwrite(). It has to return VM_FAULT_LOCKED and not 0 now.
> > > Souptick, can I ask you to run 'fstests' for at least common filesystems
> > > like ext4, xfs, btrfs when you change generic filesystem code please? That
> > > would catch a bug like this immediately. Thanks.
> >
> > Looking into existing code block_page_mkwrite() returns 0, not VM_FAULT_LOCKED
> > in true path and this patch doesn't change any existing behaviour of
> > block_page_mkwrite()
> > except adding one new input parameter to return err value to caller function.
>
> Yeah, you are right and this confused me. In your version
> block_page_mkwrite() returns block_page_mkwrite_return(err1) in case of
> error but 0 in case of success and the caller - ext4_page_mkwrite() - then
> uses block_page_mkwrite_return() again if block_page_mkwrite() returned 0.
> So I agree the code path I pointed out won't result in returning 0 instead
> of VM_FAULT_LOCKED but the calling convention is really very confusing.
>
> > -int ext4_page_mkwrite(struct vm_fault *vmf)
> > +vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
> >
> > +       err = 0;
> > +       ret = block_page_mkwrite(vma, vmf, get_block, &err);
> >         if (!ret && ext4_should_journal_data(inode)) {
> >                 if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
> >                           PAGE_SIZE, NULL, do_journal_get_write_access)) {
> >                         unlock_page(page);
> > -                       ret = VM_FAULT_SIGBUS;
> >
> > I think, this part has created problem where page_mkwrite()
> > end up with returning 0.
>
> So this branch is definitely wrong but I somewhat doubt it's the one we've
> taken - this can happen only in case of IO error.

Looking into the patch, this is only part of code where page_mkwrite()
end up with returning 0.
