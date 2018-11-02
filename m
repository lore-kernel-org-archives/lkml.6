Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7FEC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C962082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwGL4kCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C962082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeKCEcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:32:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37330 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbeKCEcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:32:50 -0400
Received: by mail-io1-f68.google.com with SMTP id k17-v6so2149379ioc.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ca+UIDJf72iGf10Ck1hFnmZSm4E/6PjFLdtKZpGv4D0=;
        b=cwGL4kCfbYQe+61YPfksFPefhYj6CaRIMkjVes+RXTt+fbcpBUVKT0UuSN8Xo/Ya8x
         7y10e1I8UQkzs43xl+JBTvlO9+yX4oND65OOahw03gDmxQU4I+73+osqCOQoTaaMIUQs
         nN2GjF4/F0suBRs1oMbdgQRXGhSFlhwfNVxnMwNbt34sP7xvGEzFFEA10lcGT0ZKfj+m
         JQROXf3nB0FdKdoiJUO4MM7cR1ZzlxUBskbCynmpqIXKWc8rcZ/D/cEvTSNSo0WIStRV
         uzewwzNhANibqDbLoAjCFbJBVVYGU4ZnEogM39E7vo79LSC7yQ2uj9wAOgUejqSrokPF
         Nh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ca+UIDJf72iGf10Ck1hFnmZSm4E/6PjFLdtKZpGv4D0=;
        b=MjCANHNbn26O40CgfjsOcJzmG/YodxBONzVJl0ZNb409krgRzz8Ec5YW5t4df74ZIA
         OeM1YkaQpIjMHZ0E/quFprV97taRsKUP6KBHbD60DPPdi8rj7zL0Jc9gwx0KAYJFU83V
         DaY5Yg6YYcVewdv978SM2ZO+/uBGyCtsj9AUQ8G8z2T9VFj+MSDG1I6X/ETG9RMV+e8H
         0RpapLKLmhapHQNulQN8Ic6121TiLHAQ5G9teVg3L4XgEk0gFpqi5sf93HZQrFylEoUK
         0f9kefF6hOObrsJ9apYDoUcSRz8fed11ODRjmwKSSl0k9T/dUel0EZsrPYAkSpRSGT70
         YNOA==
X-Gm-Message-State: AGRZ1gLhsabBGw96vmvvOqtqPxFoHlmdOGUEcrPcWOaqZKjUvlGXIgRO
        QUysYIbr13oX7JrNoVCx3gEJaKKMfjaLxvOkn7LxKA==
X-Google-Smtp-Source: AJdET5fXL0+XYvt/6/s/az/O8WFlxb48+WYQekJRSGV7J9mlCnjBRX/FlCLzNqfJGPgSXBiuSiZFs0JJKqOttfj7F10=
X-Received: by 2002:a6b:620d:: with SMTP id f13-v6mr1176140iog.11.1541186665494;
 Fri, 02 Nov 2018 12:24:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:b01b:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 12:24:05 -0700 (PDT)
In-Reply-To: <4871d3cc-769e-b65a-8c05-bfaf6e6fdc69@I-love.SAKURA.ne.jp>
References: <000000000000f961390571457196@google.com> <4871d3cc-769e-b65a-8c05-bfaf6e6fdc69@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 2 Nov 2018 20:24:05 +0100
Message-ID: <CACT4Y+Y0OjxACZNKpKpaJRjAAdwjozkR9PEti6Y+KhO4pRev+A@mail.gmail.com>
Subject: Re: INFO: task hung in lo_release
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+a4e4a2663a21c3c3c2b1@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 4:28 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/07/18 21:46, syzbot wrote:
>> Showing all locks held in the system:
>> 1 lock held by khungtaskd/902:
>>  #0: 000000004f60bbd2 (rcu_read_lock){....}, at: debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4461
>> 1 lock held by rsyslogd/4455:
>>  #0: 0000000086a2d206 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200 fs/file.c:766
>> 2 locks held by getty/4545:
>>  #0: 00000000ece833eb (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 00000000536bed00 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4546:
>>  #0: 00000000180e8f60 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 000000008efac671 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4547:
>>  #0: 00000000ca308631 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 000000007c05fef3 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4548:
>>  #0: 000000009d93809c (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 000000004c489ffa (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4549:
>>  #0: 00000000ec3b322c (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 00000000107aeb96 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4550:
>>  #0: 000000006d1a7b96 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 00000000564c003d (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by getty/4551:
>>  #0: 000000003cba543a (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>>  #1: 00000000149a289b (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
>> 2 locks held by syz-executor6/4597:
>>  #0: 0000000033676c6d (&bdev->bd_mutex){+.+.}, at: __blkdev_put+0xc2/0x830 fs/block_dev.c:1780
>>  #1: 00000000127b5bfb (loop_index_mutex){+.+.}, at: lo_release+0x1f/0x1f0 drivers/block/loop.c:1675
>> 2 locks held by blkid/18494:
>>  #0: 000000000efc6462 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x13c0 fs/block_dev.c:1463
>>  #1: 00000000127b5bfb (loop_index_mutex){+.+.}, at: lo_open+0x1b/0xb0 drivers/block/loop.c:1632
>> 1 lock held by syz-executor5/18515:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_control_ioctl+0x91/0x540 drivers/block/loop.c:1999
>> 1 lock held by syz-executor1/18498:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_control_ioctl+0x91/0x540 drivers/block/loop.c:1999
>> 1 lock held by syz-executor3/18521:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_control_ioctl+0x91/0x540 drivers/block/loop.c:1999
>> 2 locks held by syz-executor3/18522:
>>  #0: 00000000399ff791 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x13c0 fs/block_dev.c:1463
>>  #1: 00000000127b5bfb (loop_index_mutex){+.+.}, at: lo_open+0x1b/0xb0 drivers/block/loop.c:1632
>> 1 lock held by syz-executor4/18506:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_control_ioctl+0x91/0x540 drivers/block/loop.c:1999
>> 1 lock held by syz-executor0/18508:
>> 1 lock held by syz-executor7/18507:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_control_ioctl+0x91/0x540 drivers/block/loop.c:1999
>> 1 lock held by syz-executor2/18514:
>>  #0: 000000000efc6462 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x13c0 fs/block_dev.c:1463
>> 1 lock held by blkid/18513:
>>  #0: 0000000033676c6d (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x13c0 fs/block_dev.c:1463
>> 1 lock held by blkid/18520:
>>  #0: 00000000127b5bfb (loop_index_mutex){+.+.}, at: loop_probe+0x82/0x1d0 drivers/block/loop.c:1979
>> 1 lock held by blkid/18524:
>>  #0: 00000000399ff791 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x13c0 fs/block_dev.c:1463
>
> Dmitry, it is impossible to check what these lock holders are doing without dump of these threads
> (they are not always TASK_UNINTERRUPTIBLE waiters; e.g. PID=18508 is TASK_RUNNING with a lock held).

I know. One day I will hopefully get to implementing dump collection...

> Jens, when can we start testing "[PATCH v3] block/loop: Serialize ioctl operations." ?

Was that merged? If we have a potential fix, merging it may be the
simplest way to address it without debugging.
I see that this "[v4] block/loop: Serialize ioctl operations." still
has "State: New":
https://patchwork.kernel.org/patch/10612217/
