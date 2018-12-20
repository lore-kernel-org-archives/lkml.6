Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF11C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BD82176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbeLTKzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:55:05 -0500
Received: from mail-oi1-f197.google.com ([209.85.167.197]:45754 "EHLO
        mail-oi1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbeLTKzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:55:04 -0500
Received: by mail-oi1-f197.google.com with SMTP id 73so852603oii.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 02:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ydty51tXu1GhbE294ste5gWWq8Vljd5m8gU35u9wExc=;
        b=nCYWh305DgdBA84L34AX99bHxsTL2x0GLqPWvquTIu+7ujSkPg1kCnZedyG/3StFkk
         Q28yOnqDTOyGWeP/44XXub61GGmcARqd6vCPP5kQA+rcmrrUJWTvxiKCfw6mIopWWeHz
         R0GLlc+4r2hP1WMUHwDoWHIIo8d/RAJdQcUC9UYnVUgjvkKfJdctJn5HrEQXnF5cYMoW
         2ksdsT6oCx9yNf18NB18TZCi+YQKbxeNJ6n/KZCdftLykrVaH0BwlH9hy6L4yoBSZH37
         3rgn+2CG/qMJ/RCSwFopTO9NZYnP0YgYWKSoPIeQe/lXgDFdzEWDR/yQt841yvYyWbn5
         WpSg==
X-Gm-Message-State: AA+aEWYhznRCtniytAifXWwr3UMAmysk2H5+ZJsUXrYUxdvQWSnNwE2x
        Vpykihf5xGvft46ZlKYPrkfeGG8x/kDXiiCqitf70Hn+Rg/Q
X-Google-Smtp-Source: AFSGD/UJAAldmhd1sGRuIc0nPNKavmglPe23ZS22PJ35/C8TolVncWwPEdGJ0H33Tlw6aTrHO9i2aNEBZGoabx/DL0QNfibEFfg1
MIME-Version: 1.0
X-Received: by 2002:a05:6830:13ca:: with SMTP id e10mr21378501otq.19.1545303303281;
 Thu, 20 Dec 2018 02:55:03 -0800 (PST)
Date:   Thu, 20 Dec 2018 02:55:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007664bf057d71f6d7@google.com>
Subject: BUG: please report to dccp@vger.kernel.org => prev = 10, last = 10 at net/dccp/ccids/lib/packet_history.c:LINE/tfrc_rx_h
From:   syzbot <syzbot+3c8a843d9de82272915b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dccp@vger.kernel.org, gerrit@erg.abdn.ac.uk,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6531e115b7ab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b0bd5d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=3c8a843d9de82272915b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3c8a843d9de82272915b@syzkaller.appspotmail.com

bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.
BUG: please report to dccp@vger.kernel.org => prev = 10, last = 10 at  
net/dccp/ccids/lib/packet_history.c:425/tfrc_rx_hist_sample_rtt()
CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.20.0-rc6+ #374
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  tfrc_rx_hist_sample_rtt.cold.3+0x54/0x5c  
net/dccp/ccids/lib/packet_history.c:422
  ccid3_hc_rx_packet_recv+0x5c4/0xeb0 net/dccp/ccids/ccid3.c:767
  ccid_hc_rx_packet_recv net/dccp/ccid.h:185 [inline]
  dccp_deliver_input_to_ccids+0xf0/0x280 net/dccp/input.c:180
  dccp_rcv_established+0x87/0xb0 net/dccp/input.c:378
  dccp_v4_do_rcv+0x153/0x180 net/dccp/ipv4.c:656
  sk_backlog_rcv include/net/sock.h:932 [inline]
  __sk_receive_skb+0x3e5/0xec0 net/core/sock.c:473
  dccp_v4_rcv+0x10f9/0x1f58 net/dccp/ipv4.c:877
  ip_local_deliver_finish+0x2e9/0xda0 net/ipv4/ip_input.c:215
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip_rcv+0xed/0x600 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4946
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5056
  process_backlog+0x24e/0x7a0 net/core/dev.c:5864
  napi_poll net/core/dev.c:6287 [inline]
  net_rx_action+0x7fa/0x19b0 net/core/dev.c:6353
  __do_softirq+0x308/0xb7e kernel/softirq.c:292
  run_ksoftirqd+0x5e/0x100 kernel/softirq.c:654
  smpboot_thread_fn+0x68b/0xa00 kernel/smpboot.c:164
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
IPVS: ftp: loaded support on port[0] = 21
dccp_close: ABORT with 36864 bytes unread
bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.
IPVS: ftp: loaded support on port[0] = 21
bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
IPVS: ftp: loaded support on port[0] = 21
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
IPVS: ftp: loaded support on port[0] = 21
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.
IPVS: ftp: loaded support on port[0] = 21
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
IPVS: ftp: loaded support on port[0] = 21
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
IPVS: ftp: loaded support on port[0] = 21
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
IPVS: ftp: loaded support on port[0] = 21
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
IPVS: ftp: loaded support on port[0] = 21
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.
IPVS: ftp: loaded support on port[0] = 21
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as  
long as lo is part of bond bond0
bond0: lo is up - this may be due to an out of date ifenslave
A link change request failed with some changes committed already. Interface  
lo may have been left with an inconsistent configuration, please check.


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
