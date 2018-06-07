Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eaUmFmRrGVu3QwAAmS7hNA
	; Thu, 07 Jun 2018 17:29:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4ABB0608B8; Thu,  7 Jun 2018 17:29:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SORTED_RECIPS autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AD2D5601B4;
	Thu,  7 Jun 2018 17:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD2D5601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753785AbeFGR3F (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:29:05 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:55831 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753420AbeFGR3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:29:03 -0400
Received: by mail-io0-f197.google.com with SMTP id a10-v6so7907607iod.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SnpyGzOAjsUmFoYKV7YOFiVjxVy1qE9EEnle3AuBVKM=;
        b=Rk+bE44/57HdWKiQrvCC/MfOXElJOA5gI2Qar0c6qOP/TVvNZDQYmCNZ4zr5f3enBa
         WTLeXEG+ViBYW12B2lvj6mebJVqbO+SVsJkxeFvvvggAB21+nnNS0Fxvl49YxgwISS40
         q/QB2pBvp9+suBribOD1JOpUAERLf4kjJnDuowXvED1DxEX229+tJyDdxN8Y6Ml0pBXa
         K17S6iH82jmoyc8p5YyzryeulA1luPR8RAkAOB1CNBpUZfFuCQBWiyG2uTv31u+SveHh
         gywZ+iuhIrXfb/jMb8h/OJzukQ3O76jmehFHfT9/HLwvLz0v01Q0vGI+H8jH5v6dleoC
         7n7g==
X-Gm-Message-State: APt69E19R7Qiq9M9fu626eG7h+L0BMFZHff/4xsQBR+4+vi37/u0fw5F
        xOZ6qKotsLK+2IFr1pn7oG5Uc4NjvUwW4VfSzB+bCf3zCVln
X-Google-Smtp-Source: ADUXVKIjFcHDcIugqNS627Zn6WmG7r8PO/BE3spgV0490vdhI/KpkeXdXQTAf5CJEc3rFzG/XkAlbaYl4VROZ2IuIkRBJezIH0xf
MIME-Version: 1.0
X-Received: by 2002:a6b:dc01:: with SMTP id s1-v6mr1215073ioc.111.1528392542988;
 Thu, 07 Jun 2018 10:29:02 -0700 (PDT)
Date: Thu, 07 Jun 2018 10:29:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a3b5b056e109e42@google.com>
Subject: KMSAN: uninit-value in ebt_stp_mt_check (2)
From: syzbot <syzbot+da4494182233c23a5fcf@syzkaller.appspotmail.com>
To: bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, fw@strlen.de, kadlec@blackhole.kfki.hu,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        stephen@networkplumber.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c6a6aed994b6 kmsan: remove dead code to trigger syzbot build
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=17bde74f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
dashboard link: https://syzkaller.appspot.com/bug?extid=da4494182233c23a5fcf
compiler:       clang version 7.0.0 (trunk 334104)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+da4494182233c23a5fcf@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in ebt_stp_mt_check+0x24b/0x450  
net/bridge/netfilter/ebt_stp.c:162
CPU: 0 PID: 12006 Comm: syz-executor7 Not tainted 4.17.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x149/0x260 mm/kmsan/kmsan.c:1084
  __msan_warning_32+0x6e/0xc0 mm/kmsan/kmsan_instr.c:620
  ebt_stp_mt_check+0x24b/0x450 net/bridge/netfilter/ebt_stp.c:162
  xt_check_match+0x1438/0x1650 net/netfilter/x_tables.c:506
  ebt_check_match net/bridge/netfilter/ebtables.c:372 [inline]
  ebt_check_entry net/bridge/netfilter/ebtables.c:702 [inline]
  translate_table+0x4e88/0x6120 net/bridge/netfilter/ebtables.c:943
  do_replace_finish+0x1258/0x2ea0 net/bridge/netfilter/ebtables.c:999
  do_replace+0x719/0x780 net/bridge/netfilter/ebtables.c:1138
  do_ebt_set_ctl+0x2ab/0x3c0 net/bridge/netfilter/ebtables.c:1517
  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
  nf_setsockopt+0x47c/0x4e0 net/netfilter/nf_sockopt.c:115
  ip_setsockopt+0x24b/0x2b0 net/ipv4/ip_sockglue.c:1251
  udp_setsockopt+0x108/0x1b0 net/ipv4/udp.c:2416
  sock_common_setsockopt+0x13b/0x170 net/core/sock.c:3039
  __sys_setsockopt+0x496/0x540 net/socket.c:1903
  __do_sys_setsockopt net/socket.c:1914 [inline]
  __se_sys_setsockopt net/socket.c:1911 [inline]
  __x64_sys_setsockopt+0x15c/0x1c0 net/socket.c:1911
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4559f9
RSP: 002b:00007f45b9246c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f45b92476d4 RCX: 00000000004559f9
RDX: 0000000000000080 RSI: 0000000000000000 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000300 R09: 0000000000000000
R10: 0000000020000480 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c0d6d R14: 00000000004d07c8 R15: 0000000000000000

Local variable description: ----mtpar.i@translate_table
Variable was created at:
  translate_table+0xbb/0x6120 net/bridge/netfilter/ebtables.c:831
  do_replace_finish+0x1258/0x2ea0 net/bridge/netfilter/ebtables.c:999
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
