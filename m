Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A601CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D802077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D802077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeIFMzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:55:20 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:57742 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeIFMzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:55:20 -0400
Received: by mail-it0-f72.google.com with SMTP id e6-v6so11262705itc.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 01:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=peSZ2dhR9PHQkvcEFt8LyPSg2Wty/ErBz2nF44IfNwk=;
        b=IO/xFgFZ/YhOaojFnYw3zt+tQajf2yTSumef1IbZUde3OQuyoieQyO3D+kr/hMFsm/
         7JZUyuu149HXVPM0SapCmFxHjNJz7yA8pXsEPbSKUwG8hxoS8MSkbgzomO2FERSBnBm0
         gLt7isHnFLdxCVTT2nwSr1MLfgHiganoZU4copCfDVF/YZ+ZHHydOaVfvjJIzaoIQiua
         HEai1DuskCVEjMXMcrRxqVCoI8nPXv9Du5dwgQ9+dUC1+uxcBAxpU451NQyksG1pBRBr
         aLMK4pFwxmc2BrftCrQzzPvzfW0KRJUC4P9McOKC61YIo3o4HCjzHvbH9H7AskrojPUu
         rGjw==
X-Gm-Message-State: APzg51CsuHta9X1A9C5w+kLlGZt829944TcbX0GG9ifyz4HhqJVTkJaN
        eBmaCA79lzprRQIALQ7y/Ykic8yF+ZV3pRZDEo9Yz5abK8wK
X-Google-Smtp-Source: ANB0Vda/6SbAOy2Veqi8bXGZJ/Oj6y6rfF7mCqTLKuTrYtZgA2gQLGvkPUn7JZ7mY4sqwih6R+4qpMUgXwVGpEYU8UFGfK8uTaNi
MIME-Version: 1.0
X-Received: by 2002:a24:56ce:: with SMTP id o197-v6mr1800792itb.32.1536222063262;
 Thu, 06 Sep 2018 01:21:03 -0700 (PDT)
Date:   Thu, 06 Sep 2018 01:21:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006082bd05752f92bb@google.com>
Subject: linux-next boot error (2)
From:   syzbot <syzbot+762a577f56cfb1574647@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, alexander.levin@verizon.com,
        dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, luc.vanoostenryck@gmail.com,
        nikolaus.voss@loewensteinmedical.de, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    509d1f0c294a Add linux-next specific files for 20180906
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=157b857a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a648893bbc933
dashboard link: https://syzkaller.appspot.com/bug?extid=762a577f56cfb1574647
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+762a577f56cfb1574647@syzkaller.appspotmail.com

kernel panic: VFS: Unable to mount root fs on unknown-block(8,1) driver: sd
   0801         2096128 sda1 24d8ab2f-01

1f00             128 mtdblock0
  (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on  
unknown-block(8,1)
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc2-next-20180906+ #60
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  mount_block_root+0x61f/0x71f init/do_mounts.c:442
  mount_root+0x2d0/0x317 init/do_mounts.c:562
  prepare_namespace+0x26c/0x2ab init/do_mounts.c:621
  kernel_init_freeable+0x590/0x5ae init/main.c:1163
  kernel_init+0x11/0x1b3 init/main.c:1063
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
