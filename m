Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E92BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04078206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04078206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeIZUhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:37:16 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:59524 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeIZUhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:37:15 -0400
Received: by mail-it1-f198.google.com with SMTP id a10-v6so3433900itc.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bA7SQ2zouu6VY9TFoTxktO/MzJFIciD8ymCX4TGnI+A=;
        b=cLeXwzcoUiLwGEIh7YnNkurOlzc1dq3CNfr8J5lmxLjBNWPUVakVf1hAZG/p7LQwHk
         +9BmkD/YQMZZvuJqPMNQge2D40IcGP9NL3vEr6OtbO1Vxk6+/GemSSVBp348F0vt/7xh
         u989yr/OyWTkzqB02ewLJgVE6xYZg3to+sdR19zOOnbMEYHrPxAzfwHtIg5r/pjsvLNk
         vQrfAC0XF1pQpXTbmwESNrHAa99llehGMgsijMvgFnzxlzJxqXnmbqy9ch0IZM31NJMg
         ry98TgVqBtPqKxDPCcwTiuzsxMH+kog6CT5PWNvJ13xHFit8Na4CzAvjZxh1IhkrwDrA
         8xPQ==
X-Gm-Message-State: ABuFfojcxQrI+dF2D4yuZcHmeBEZPM0mPzl3wD6xEXKYDqrbgXr4JmzC
        sGzCwH6+jg5nH1abl+6AGLFMUmWTmoYZYZ0AAFBVoBQ5sni5
X-Google-Smtp-Source: ACcGV61IlNIH2HfIhHZIYCGJmIYaUffhWZX50+nEt+eN4m/3h5M4DmRNxscYqZ02HhbXvLpD/dIt45sQjaNPS5wteczvl2+Tr+sg
MIME-Version: 1.0
X-Received: by 2002:a24:2193:: with SMTP id e141-v6mr4562671ita.2.1537971842852;
 Wed, 26 Sep 2018 07:24:02 -0700 (PDT)
Date:   Wed, 26 Sep 2018 07:24:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e2e530576c6f9ce@google.com>
Subject: KMSAN: uninit-value in __dev_mc_add
From:   syzbot <syzbot+001516d86dbe88862cec@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sunlw.fnst@cn.fujitsu.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eb2e67596de2 kmsan: minor code cleanup
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=136e3b11400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94a9ed72288f7fef
dashboard link: https://syzkaller.appspot.com/bug?extid=001516d86dbe88862cec
compiler:       clang version 8.0.0 (trunk 339414)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+001516d86dbe88862cec@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in memcmp+0x11d/0x180 lib/string.c:863
CPU: 0 PID: 14033 Comm: kworker/0:3 Not tainted 4.19.0-rc4+ #58
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x2f6/0x430 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:917
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:500
  memcmp+0x11d/0x180 lib/string.c:863
  __hw_addr_add_ex net/core/dev_addr_lists.c:61 [inline]
  __dev_mc_add+0x215/0x8c0 net/core/dev_addr_lists.c:670
  dev_mc_add+0x6d/0x80 net/core/dev_addr_lists.c:687
  igmp6_group_added+0x2c8/0xaa0 net/ipv6/mcast.c:676
  __ipv6_dev_mc_inc+0xf4b/0x1270 net/ipv6/mcast.c:934
  ipv6_dev_mc_inc+0x70/0x80 net/ipv6/mcast.c:941
  addrconf_join_solict net/ipv6/addrconf.c:2098 [inline]
  addrconf_dad_begin net/ipv6/addrconf.c:3879 [inline]
  addrconf_dad_work+0x437/0x29b0 net/ipv6/addrconf.c:4006
  process_one_work+0x197f/0x2490 kernel/workqueue.c:2153
  worker_thread+0x1f6a/0x2b00 kernel/workqueue.c:2296
  kthread+0x59c/0x5d0 kernel/kthread.c:247
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416

Local variable description: ----buf@igmp6_group_added
Variable was created at:
  igmp6_group_added+0x46/0xaa0 net/ipv6/mcast.c:664
  __ipv6_dev_mc_inc+0xf4b/0x1270 net/ipv6/mcast.c:934
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
