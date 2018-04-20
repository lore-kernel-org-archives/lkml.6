Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeDTX7E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 19:59:04 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:40571 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbeDTX7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 19:59:03 -0400
X-Google-Smtp-Source: AIpwx494W3/Wf1yck/+v0zekH8dPOP5Z1IUw/DH6+j3riT+P8x/XqgPZn6dNBG3HxStZBcISQN4yvJWhfPxMC0JtTliJFcqUeyiO
MIME-Version: 1.0
Date: Fri, 20 Apr 2018 16:59:02 -0700
In-Reply-To: <000000000000d71bf6056a34b628@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed9844056a507832@google.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free
From: syzbot <syzbot+2dfb68e639f0621b19fb@syzkaller.appspotmail.com>
To: ddstreet@ieee.org, dvyukov@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on  
https://github.com/google/kmsan.git/master commit
48c6a2b0ab1b752451cdc40b5392471ed1a2a329 (Mon Apr 16 08:42:26 2018 +0000)
mm/kmsan: fix origin calculation in kmsan_internal_check_memory
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=2dfb68e639f0621b19fb

So far this crash happened 180 times on  
https://github.com/google/kmsan.git/master, net-next, upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4936564132020224
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5817131010621440
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6313498770407424
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=6627248707860932248
compiler: clang version 7.0.0 (trunk 329391)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2dfb68e639f0621b19fb@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
device bridge_slave_1 left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_0 left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
unregister_netdevice: waiting for lo to become free. Usage count = 3
