Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7653ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC592206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzw9j8nI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC592206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbeGRM0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:26:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43456 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbeGRM0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:26:37 -0400
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so1922920plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nJ8xUMrtsu71vTqLm97Ih1DZVLy+uRghU/x77OrKaLo=;
        b=lzw9j8nIYsk8CpDHB4N7yO7IAR7imIhUComfZu3A7dqOds1zqpH7Cm6tKK11of04Lq
         G4tcjrYxStFGRdRNgI/dcyBYstGpjGi2eV/SRdkyjCNqgRIk187KIKdnd8nlOIvWymvN
         XaIQiAjoqGiRhw91gd9FNb0rSJm663gXzmQeZjvJ4aOoVh8GPd2bdRBbjpeCjm+4mHjB
         HSNoGHXImSt0zvqnvqCTnMup8mQLrrt1ypMk7+lhoS6C2xhvCxISR1vHUWIwlYF/DBVy
         0Kv9RDtfDKm6TL+R8RhBu97ru8RBMEpyz5lTwywpJFBH02u9aDB0ff44ScicseC4vOqZ
         ZsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nJ8xUMrtsu71vTqLm97Ih1DZVLy+uRghU/x77OrKaLo=;
        b=nI8+w2DMtyGWipe+aVGU4YO7efANNXTPGQn9E7gQsQEn+o4eRQL7VmGxZkt0ADQtyP
         PFzA8fsfxcYIPHHiXxz6/WrIE6YJcvWyluhNRzMv3IaG7tZkYTmlRKX7/+qrGs3OH+bE
         Vr4L56Fu+7ff5lYAQy73SLsoxJMRnajMib6Lui2Ppd70JLjGP8Xt/x0KvyPpZr4GYeAI
         cvvEiuohsT8t7SbS0tqTbP+PgPGQBAgmosCFKDIpwXW1gR9nlXdFi27szQLqtiCaa9QW
         CuJtpgZREXPQ86CrgFHIEf/CE2OmEdWTsu4RPYbvyDpiTKUQn4Vnu2ZI0n60lOiCI4Gv
         cEUw==
X-Gm-Message-State: AOUpUlFwzHHwVNtiHnyOlaVSXRtvhntiierpprmzAeIZJ39MUIo+8TnD
        Wpy8hJnNpdDIognERhc4h2zyQ+ltvp/BXXOS1ifuhg==
X-Google-Smtp-Source: AAOMgpcUMDpg6sDvWnVXApMMTMug5o+8A7gRbxWLJyJFTeCsj3BkOgVUyFVzp5a9vMgxVC7T6RiS5kRVPCBCI6EMD1s=
X-Received: by 2002:a17:902:d710:: with SMTP id w16-v6mr5646435ply.93.1531914544662;
 Wed, 18 Jul 2018 04:49:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 18 Jul 2018 04:48:44
 -0700 (PDT)
In-Reply-To: <5a44c756-2056-97cd-48e2-1f1585eb231e@I-love.SAKURA.ne.jp>
References: <000000000000a88a2e056c2b67a0@google.com> <5a44c756-2056-97cd-48e2-1f1585eb231e@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Jul 2018 13:48:44 +0200
Message-ID: <CACT4Y+ajax9tQefJnTttZkThKxiuQ+rAZ_DO1yPkYDMGcE-uNA@mail.gmail.com>
Subject: Re: INFO: task hung in ext4_direct_IO
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+45843822635038f93354@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 5:11 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/05/14 23:36, syzbot wrote:
>> Call Trace:
>>  context_switch kernel/sched/core.c:2859 [inline]
>>  __schedule+0x801/0x1e30 kernel/sched/core.c:3501
>>  schedule+0xef/0x430 kernel/sched/core.c:3545
>>  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
>>  rwsem_down_read_failed+0x350/0x5e0 kernel/locking/rwsem-xadd.c:286
>>  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
>>  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
>>  down_read+0xbd/0x1b0 kernel/locking/rwsem.c:26
>>  inode_lock_shared include/linux/fs.h:723 [inline]
>>  ext4_direct_IO_read fs/ext4/inode.c:3828 [inline]
>>  ext4_direct_IO+0x653/0x2110 fs/ext4/inode.c:3865
>>  generic_file_read_iter+0x510/0x2f00 mm/filemap.c:2341
>>  ext4_file_read_iter+0x18b/0x3c0 fs/ext4/file.c:77
>>  call_read_iter include/linux/fs.h:1778 [inline]
>>  generic_file_splice_read+0x552/0x910 fs/splice.c:307
>>  do_splice_to+0x12e/0x190 fs/splice.c:880
>>  splice_direct_to_actor+0x268/0x8d0 fs/splice.c:952
>>  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
>>  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
>>  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
>>  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
>>  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
>>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> This resembles
>
> Call Trace:
>  context_switch kernel/sched/core.c:2848 [inline]
>  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
>  schedule+0xef/0x430 kernel/sched/core.c:3549
>  __rwsem_down_write_failed_common+0x919/0x15d0 kernel/locking/rwsem-xadd.c:566
>  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
>  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
>  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
>  down_write+0xa2/0x120 kernel/locking/rwsem.c:72
>  inode_lock include/linux/fs.h:713 [inline]
>  ext4_file_write_iter+0x303/0x1420 fs/ext4/file.c:235
>  call_write_iter include/linux/fs.h:1784 [inline]
>  new_sync_write fs/read_write.c:474 [inline]
>  __vfs_write+0x64d/0x960 fs/read_write.c:487
>  vfs_write+0x1f8/0x560 fs/read_write.c:549
>  ksys_pwrite64+0x174/0x1a0 fs/read_write.c:652
>  __do_sys_pwrite64 fs/read_write.c:662 [inline]
>  __se_sys_pwrite64 fs/read_write.c:659 [inline]
>  __x64_sys_pwrite64+0x97/0xf0 fs/read_write.c:659
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> in the report below.
>
>   INFO: task hung in ext4_file_write_iter
>   https://syzkaller.appspot.com/bug?id=c7370ffdecb4c7c7a24a50e17acaf102850d43ab
>
> But I have no idea why usual file write causes problems.
>
> Since there is LOOP_CHANGE_FD request in the console output, maybe it is better to
> try 170785a9cc72e8e1 ("loop: add recursion validation to LOOP_CHANGE_FD") now
> and see whether it helps?


Let's do:

#syz dup: INFO: task hung in ext4_file_write_iter

just to clean the dashboard a bit.
