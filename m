Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0D5C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F35520665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F35520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeJWSfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:35:48 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:32775 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeJWSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:35:48 -0400
Received: by mail-it1-f198.google.com with SMTP id i15-v6so9102426itb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=C4ui9YmlqmRwNxsJReaFsIULnXZTCyutxLq6PhSYhrQ=;
        b=XjNMOAzvxQy51JBhodknwnvI36kw/vm96o2cOu8QA0gtjPQJDFV6ughPJu9wJ3DG69
         wmTzDjHJYoLOCYU/0qKepk3YeVrvqu3rNZlAnNadYLZa9+3fd2Pi6ro8CG8TzusrBuVI
         PqN9avzqEvV4dgjGFZOYVrs/NjUq3BVpf/kmOU/vs/T9C8SEWhXT4PSPN+6LGWE8l4S7
         F6BoC209RZeTE2u1F7K5sPsLHOE4MMXlHRxUWigp/VlgCR+zbEACMlKkZtkAGTfYCm8W
         UYyiTfsKWbariaGxm0gm2CFHyeuNgR+joxglcKUrzDkDcm/sXzPBSkJaYTnK5b+C7wl4
         DwYA==
X-Gm-Message-State: ABuFfohw6GQ4XYxL4+hF5Xe6fln+5kuWDAI2WcaTaLWL8+fQKVdXKKWX
        M1h3JWNewFBZhIUjCCzIQmuztxBw05oo8nNytXpItcUT4GCZ
X-Google-Smtp-Source: ACcGV62KhuvfdO43PK5QN5N/P9q0Hfa/UAqHoJIuFEPJUkzEx1A3/85pRKewm77K9IvozZ1kQZXbmVPMmIBQAOLgS36LFJrKoxCp
MIME-Version: 1.0
X-Received: by 2002:a02:56d0:: with SMTP id u77-v6mr41186089jad.18.1540289582701;
 Tue, 23 Oct 2018 03:13:02 -0700 (PDT)
Date:   Tue, 23 Oct 2018 03:13:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dc2420578e29de3@google.com>
Subject: BUG: please report to dccp@vger.kernel.org => prev = 2, last = 2 at net/dccp/ccids/lib/packet_history.c:LINE/tfrc_rx_his
From:   syzbot <syzbot+e786ba000564d103a6fe@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dccp@vger.kernel.org, garsilva@embeddedor.com,
        gerrit@erg.abdn.ac.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ca9eb48fe01f Merge tag 'regulator-v5.0' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1482a939400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=963b24abf3f7c2d8
dashboard link: https://syzkaller.appspot.com/bug?extid=e786ba000564d103a6fe
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e786ba000564d103a6fe@syzkaller.appspotmail.com

input: syz0 as /devices/virtual/input/input6
BUG: please report to dccp@vger.kernel.org => prev = 2, last = 2 at  
net/dccp/ccids/lib/packet_history.c:425/tfrc_rx_hist_sample_rtt()
CPU: 1 PID: 18 Comm: ksoftirqd/1 Not tainted 4.19.0+ #298
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b6 lib/dump_stack.c:113
  tfrc_rx_hist_sample_rtt.cold.3+0x54/0x5c  
net/dccp/ccids/lib/packet_history.c:422
  ccid3_hc_rx_packet_recv+0x5c4/0xeb0 net/dccp/ccids/ccid3.c:767
  ccid_hc_rx_packet_recv net/dccp/ccid.h:185 [inline]
  dccp_deliver_input_to_ccids+0xf0/0x280 net/dccp/input.c:180
  dccp_rcv_established+0x87/0xb0 net/dccp/input.c:378
  dccp_v4_do_rcv+0x153/0x180 net/dccp/ipv4.c:656
  sk_backlog_rcv include/net/sock.h:931 [inline]
  __sk_receive_skb+0x3e5/0xec0 net/core/sock.c:473
  dccp_v4_rcv+0x10f9/0x1f58 net/dccp/ipv4.c:877
  ip_local_deliver_finish+0x2e9/0xda0 net/ipv4/ip_input.c:215
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_rcv+0xed/0x600 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4913
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5023
  process_backlog+0x218/0x6f0 net/core/dev.c:5829
  napi_poll net/core/dev.c:6249 [inline]
  net_rx_action+0x7c5/0x1950 net/core/dev.c:6315
  __do_softirq+0x30c/0xb03 kernel/softirq.c:292
  run_ksoftirqd+0x94/0x100 kernel/softirq.c:653
  smpboot_thread_fn+0x68b/0xa00 kernel/smpboot.c:164
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
net_ratelimit: 18 callbacks suppressed
dccp_close: ABORT with 105978 bytes unread
input: syz0 as /devices/virtual/input/input7
input: syz0 as /devices/virtual/input/input8
dccp_close: ABORT with 52730 bytes unread
input: syz0 as /devices/virtual/input/input9
dccp_close: ABORT with 105978 bytes unread
dccp_close: ABORT with 105978 bytes unread
dccp_close: ABORT with 77306 bytes unread
dccp_close: ABORT with 89594 bytes unread
input: syz0 as /devices/virtual/input/input10
input: syz0 as /devices/virtual/input/input11
input: syz0 as /devices/virtual/input/input12
input: syz0 as /devices/virtual/input/input13
input: syz0 as /devices/virtual/input/input14
input: syz0 as /devices/virtual/input/input15
input: syz0 as /devices/virtual/input/input16
input: syz0 as /devices/virtual/input/input17
input: syz0 as /devices/virtual/input/input18


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
