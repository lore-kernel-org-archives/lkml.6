Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020D3ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C16320882
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C16320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeIOHuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:50:17 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44404 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeIOHuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 03:50:16 -0400
Received: by mail-io1-f70.google.com with SMTP id s15-v6so10658363iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 19:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Dj532GjVQwc3MdK0cDcXC38OqgNT18UxRd6V1B+Bl70=;
        b=BJvqWh6kOKqIHeHu+onKmBjhhi2MnlTy+7FNpURUY5GgiZL92XbLRAdCGQedcaGnFw
         BXrvhEFJ64TClMIfHuiGvFRrdKuX4CvDxB+60KOQp+/H6hZnLVSZ7bVlqBm9Da0KKpDN
         vzAV32+vszQ/sdldmfhWnEo+QxuOrXxOzNG9fa3HuLmXVMWM8B0f89CXiF65pQP3E+rf
         rsJHpPW4Pb1bOUVFH54/exjTYJbo6ro3eGJVhu3PMQxnLt9rF8d89/1RQTmRCuf2h/vf
         lvOjDEXhVslfJ/cHR0wZQuK1FatJ7v9/GJerQe5x7pXPz9dC/ERAlXKnxFfzV1CXYKat
         qp7Q==
X-Gm-Message-State: APzg51ASfaj1S/DpleLSssnetsrMh9nBacqvA1AnDA7IAA0UwfN0/hwc
        GUHH2v8dUknBMZ5nd02VFU3Z18D6QPAdzfvIfZE8VG/GBS5w
X-Google-Smtp-Source: ANB0VdZJWj9V852P9qiGq8wEJZIDWJJsnWwUEf7zkmdqUakkG+3XuYiT7bPBPshGzb//HlTlRUSIxrwSORNkKHgmSYBhzH/zx8F+
MIME-Version: 1.0
X-Received: by 2002:a5e:c90c:: with SMTP id z12-v6mr11501390iol.36.1536978782990;
 Fri, 14 Sep 2018 19:33:02 -0700 (PDT)
Date:   Fri, 14 Sep 2018 19:33:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006364200575dfc280@google.com>
Subject: INFO: task hung in fsnotify_connector_destroy_workfn (2)
From:   syzbot <syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    11da3a7f84f1 Linux 4.19-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141ffbca400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=6fb572170402d311dd39
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a60ae400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com

hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
INFO: task kworker/u4:1:23 blocked for more than 140 seconds.
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
       Not tainted 4.19.0-rc3+ #231
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u4:1    D20760    23      2 0x80000000
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
Workqueue: events_unbound fsnotify_connector_destroy_workfn
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
Call Trace:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  schedule+0xfe/0x460 kernel/sched/core.c:3517
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  schedule_timeout+0x1cc/0x260 kernel/time/timer.c:1780
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x427/0x8a0 kernel/sched/completion.c:136
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  __synchronize_srcu+0x184/0x230 kernel/rcu/srcutree.c:934
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  synchronize_srcu_expedited kernel/rcu/srcutree.c:959 [inline]
  synchronize_srcu+0x356/0x5ab kernel/rcu/srcutree.c:1010
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  fsnotify_connector_destroy_workfn+0x44/0xa0 fs/notify/mark.c:174
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  kthread+0x35a/0x420 kernel/kthread.c:246
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
INFO: task kworker/u4:5:2763 blocked for more than 140 seconds.
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
       Not tainted 4.19.0-rc3+ #231
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
kworker/u4:5    D
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
13912  2763      2 0x80000000
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
Workqueue: events_unbound fsnotify_mark_destroy_workfn
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
Call Trace:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  schedule+0xfe/0x460 kernel/sched/core.c:3517
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  schedule_timeout+0x1cc/0x260 kernel/time/timer.c:1780
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x427/0x8a0 kernel/sched/completion.c:136
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  __synchronize_srcu+0x184/0x230 kernel/rcu/srcutree.c:934
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  synchronize_srcu+0x440/0x5ab kernel/rcu/srcutree.c:1012
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  fsnotify_mark_destroy_workfn+0x1be/0x510 fs/notify/mark.c:772
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  kthread+0x35a/0x420 kernel/kthread.c:246
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0

Showing all locks held in the system:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
3 locks held by kworker/0:0/5:
3 locks held by kworker/1:0/19:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
2 locks held by kworker/u4:1/23:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #0:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
00000000a4cafcdc
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
(wq_completion)"events_unbound"
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
){+.+.}
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
, at: __write_once_size include/linux/compiler.h:215 [inline]
, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
, at: atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
, at: atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
, at: set_work_data kernel/workqueue.c:617 [inline]
, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
, at: process_one_work+0xb43/0x1b90 kernel/workqueue.c:2124
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #1: 00000000dfade95d
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (connector_reaper_work){+.+.}, at: process_one_work+0xb9a/0x1b90  
kernel/workqueue.c:2128
5 locks held by kworker/u4:3/80:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #0:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
000000009a5c59fb
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  ((wq_completion)"%s""netns"){+.+.}, at: __write_once_size  
include/linux/compiler.h:215 [inline]
  ((wq_completion)"%s""netns"){+.+.}, at: arch_atomic64_set  
arch/x86/include/asm/atomic64_64.h:34 [inline]
  ((wq_completion)"%s""netns"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  ((wq_completion)"%s""netns"){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:59 [inline]
  ((wq_completion)"%s""netns"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  ((wq_completion)"%s""netns"){+.+.}, at: set_work_pool_and_clear_pending  
kernel/workqueue.c:644 [inline]
  ((wq_completion)"%s""netns"){+.+.}, at: process_one_work+0xb43/0x1b90  
kernel/workqueue.c:2124
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  #1:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
00000000191741b6
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
net_cleanup_work){+.+.}
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: process_one_work+0xb9a/0x1b90 kernel/workqueue.c:2128
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  #2:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
0000000081d8c4f5
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
pernet_ops_rwsem
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
){++++}
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
, at: cleanup_net+0x13f/0xb10 net/core/net_namespace.c:518
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #3:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
00000000cfddf12a
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
rtnl_mutex
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
){+.+.}, at: rtnl_lock+0x17/0x20 net/core/rtnetlink.c:77
  #4:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
00000000adc11da2
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
rcu_preempt_state.exp_mutex){+.+.}, at: exp_funnel_lock  
kernel/rcu/tree_exp.h:297 [inline]
rcu_preempt_state.exp_mutex){+.+.}, at:  
_synchronize_rcu_expedited+0x562/0xfd0 kernel/rcu/tree_exp.h:667
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
1 lock held by khungtaskd/954:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  #0: 00000000665b7ca6 (
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
rcu_read_lock
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
){....}, at: debug_show_all_locks+0xd0/0x424 kernel/locking/lockdep.c:4436
2 locks held by kworker/u4:5/2763:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  #0:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
00000000a4cafcdc
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
(wq_completion)"events_unbound"
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
){+.+.}
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
, at: __write_once_size include/linux/compiler.h:215 [inline]
, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
, at: atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
, at: atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
, at: set_work_data kernel/workqueue.c:617 [inline]
, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
, at: process_one_work+0xb43/0x1b90 kernel/workqueue.c:2124
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #1:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
0000000015cd874b
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
(reaper_work).work
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
){+.+.}
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: process_one_work+0xb9a/0x1b90 kernel/workqueue.c:2128
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
3 locks held by kworker/0:2/2911:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #0:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
0000000001d6b697
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
(wq_completion)"%s"("ipv6_addrconf")
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
){+.+.}
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: __write_once_size include/linux/compiler.h:215 [inline]
, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
, at: atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
, at: atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
, at: set_work_data kernel/workqueue.c:617 [inline]
, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
, at: process_one_work+0xb43/0x1b90 kernel/workqueue.c:2124
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  #1:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
00000000c720eac4
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
(work_completion)(&(&ifa->dad_work)->work)
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
){+.+.}
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
, at: process_one_work+0xb9a/0x1b90 kernel/workqueue.c:2128
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #2:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
00000000cfddf12a
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
rtnl_mutex
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
){+.+.}
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: rtnl_lock+0x17/0x20 net/core/rtnetlink.c:77
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
2 locks held by getty/5305:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  #0:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
000000005215db21
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
&tty->ldisc_sem
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
){++++}
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  #1:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
000000001f1b258b
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
&ldata->atomic_read_lock
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
){+.+.}
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
2 locks held by getty/5306:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  #0:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
000000005e69ee83
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
&tty->ldisc_sem
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
){++++}
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000000b35791 (&ldata->atomic_read_lock
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
){+.+.}
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
2 locks held by getty/5307:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #0:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
00000000a3e5fdcd
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
&tty->ldisc_sem
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
){++++}
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
000000001af5ef30
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  (&ldata->atomic_read_lock){+.+.}
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
2 locks held by getty/5308:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #0:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
000000008ef488bc
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
&tty->ldisc_sem
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
){++++}
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #1:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
000000007a5cab3d
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (&ldata->atomic_read_lock
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
){+.+.}
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
2 locks held by getty/5309:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #0:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
0000000008bab84e
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
&tty->ldisc_sem
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
){++++}
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  #1:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
000000003db87bad
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
&ldata->atomic_read_lock
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
){+.+.}, at: n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
2 locks held by getty/5310:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  #0:
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
00000000c01f0bf4
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
&tty->ldisc_sem
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
){++++}
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
, at: ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  #1:
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
00000000590d31e5
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
hid-generic 0000:0000:0000.0005: unknown main item tag 0x0
hid-generic 0000:0000:0000.0006: unknown main item tag 0x0
  (
hid-generic 0000:0000:0000.0006: unknown main item tag

---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
