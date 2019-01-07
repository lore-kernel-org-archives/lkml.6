Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39660C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B31217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfAGJzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:55:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:59877 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfAGJzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:55:05 -0500
Received: by mail-it1-f198.google.com with SMTP id t143so129241itc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dBXCjKumw5OrThEiciM0fAIp/mNCMD4qUAXvDB/GpYE=;
        b=YYlofnHEAPMtmWvflTbnwigDOX/FAbHJKLb7SEgPmHWgMdZWK+sjlBrwhnNPJqYmzF
         719m34JGr8vlkUDwhGLF03vczRwXwiD04VkdnFhyICkSnMa/BP0Odau5D10FC9yFKmxl
         7KjCBrYUBGNJNeY+N3cxtFbbTXBsl6K5hWWa46YDw1tdETgv24nkgXOxkzrrCBgaurXF
         VlOD19lcJaegCIOdot5sVZdfwnfQPx/+ovM14K+muSMcaeGEyl95gKdl4eGl0avUiuYF
         b3tdBuhQZjq8bOD269jWAyEcgBGE0qIca/AwNvGh1QHALwL1/mnb3lwhDyyB10ezgvcy
         Fk0Q==
X-Gm-Message-State: AA+aEWatGeuXWfd4DthQ7rSom2AdNisohwnzBdxrh2sfYvj1fWt19Ftk
        V7Tc9r6vfJHghA7B6E+SFVlMkF2xoBiG2YSsStG99uaZIgmN
X-Google-Smtp-Source: AFSGD/UuWZQZuHB4pin+QjykX9datWO+LlxBuIWW4/69vr/0J1Rku1G/9VJ0rEyCY2oY0O5mkGyQTuCXcy4LvJROCdxMfoHbfk05
MIME-Version: 1.0
X-Received: by 2002:a02:241e:: with SMTP id f30mr47435729jaa.11.1546854903971;
 Mon, 07 Jan 2019 01:55:03 -0800 (PST)
Date:   Mon, 07 Jan 2019 01:55:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012073a057edb3996@google.com>
Subject: KASAN: null-ptr-deref Write in dst_release
From:   syzbot <syzbot+1f4f4025b8564c8da9d4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15c947e7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=1f4f4025b8564c8da9d4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1f4f4025b8564c8da9d4@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
Enabling of bearer <udp:syz0> rejected, failed to enable media
Enabling of bearer <udp:syz0> rejected, failed to enable media
==================================================================
BUG: KASAN: null-ptr-deref in atomic_sub_return  
include/asm-generic/atomic-instrumented.h:305 [inline]
BUG: KASAN: null-ptr-deref in dst_release net/core/dst.c:186 [inline]
BUG: KASAN: null-ptr-deref in dst_release+0x2a/0xb0 net/core/dst.c:181
Write of size 4 at addr 000000000000013c by task kworker/u4:1/21

CPU: 1 PID: 21 Comm: kworker/u4:1 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  kasan_report_error mm/kasan/report.c:352 [inline]
  kasan_report mm/kasan/report.c:412 [inline]
  kasan_report.cold+0x19f/0x2ba mm/kasan/report.c:396
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x123/0x190 mm/kasan/kasan.c:267
  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
  atomic_sub_return include/asm-generic/atomic-instrumented.h:305 [inline]
  dst_release net/core/dst.c:186 [inline]
  dst_release+0x2a/0xb0 net/core/dst.c:181
  dst_cache_destroy net/core/dst_cache.c:164 [inline]
  dst_cache_destroy+0xd3/0x1b0 net/core/dst_cache.c:156
  ip_tunnel_dev_free+0x25/0x60 net/ipv4/ip_tunnel.c:970
  netdev_run_todo+0x647/0xae0 net/core/dev.c:8885
  rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:117
  ip_tunnel_delete_nets+0x4df/0x6d0 net/ipv4/ip_tunnel.c:1083
  ipip_exit_batch_net+0x23/0x30 net/ipv4/ipip.c:663
  ops_exit_list.isra.0+0x105/0x160 net/core/net_namespace.c:156
  cleanup_net+0x51d/0xb10 net/core/net_namespace.c:551
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
