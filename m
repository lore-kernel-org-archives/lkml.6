Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE73C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB7F2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB7F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIFNY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:24:26 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:51332 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeIFNY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:24:26 -0400
Received: by mail-io0-f199.google.com with SMTP id w23-v6so10204200iob.18
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 01:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tSS3P9B38ngz9oihEtP9NQe4bRb7PgrcV2hlLK7blcU=;
        b=gxMf/YHIEpJ9VEZwSZDm4bd/A3YT2O7mZcOK4NP3/V9W92ZuHMgfmQnQvzL4NydahO
         sQzDw+XQXArTR08PY1Rnaw8oClySw7/ByJBLcUeCA94c3iTKUXBpAQW+GCNNagPXBMZJ
         GuWyddki4Bu9wD/Sjh/oIl7uRF7Y59bn3LEQKBrVdgE9+ygm42eq+ytKlppn/g9H2dS6
         UGI+MAClsA4CZD+KPyQHMuidBh1/YhhBnz8N7rvBwTSIQB0y2txmobP9A7FdvMW+J80f
         7JcWxIgZOTQLnYnsoYWtVAffAV311AR90rWwBBApkYs8XCUaJHt6uQCq87I0pquZ7hi9
         2ehg==
X-Gm-Message-State: APzg51DHOm1Z1b3LJhIYX7R2XcM0t2ERpndIp6H+CHJphi5QgpeSZeAO
        kbx9I+BYPF3JAYWHUAIbQzf3XvJ6EiVAXtE8DAJzItB/vsyA
X-Google-Smtp-Source: ANB0VdYh118qri2bIp8IHPUQXv/fCaSA9W2pvRRwNJ7ZyjkXLmzhJ/L1YvUS+FkeKM3h2QWQzrNk1kFbHJr667dWEtdkOr/ELa7O
MIME-Version: 1.0
X-Received: by 2002:a24:27d0:: with SMTP id g199-v6mr1892686ita.23.1536223802184;
 Thu, 06 Sep 2018 01:50:02 -0700 (PDT)
Date:   Thu, 06 Sep 2018 01:50:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006602605752ffa1a@google.com>
Subject: general protection fault in tcp_cleanup_ulp
From:   syzbot <syzbot+0b3ccd4f62dac2cf3a7d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b36fdc6853a3 Merge tag 'gpio-v4.19-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1589eb7a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
dashboard link: https://syzkaller.appspot.com/bug?extid=0b3ccd4f62dac2cf3a7d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0b3ccd4f62dac2cf3a7d@syzkaller.appspotmail.com

ISOFS: Unable to identify CD-ROM format.
ISOFS: Unable to identify CD-ROM format.
ISOFS: Unable to identify CD-ROM format.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 27135 Comm: syz-executor0 Not tainted 4.19.0-rc2+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:tcp_cleanup_ulp+0xbe/0x140 net/ipv4/tcp_ulp.c:131
Code: 02 00 0f 85 8a 00 00 00 49 8b 9c 24 88 06 00 00 e8 b7 f8 cd fb 48 8d  
7b 38 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
51 48 8b 7b 38 e8 93 5c c2 fb 4c 89 ea 48 b8 00 00
RSP: 0018:ffff8801c754fb80 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90001ed8000
RDX: 0000000000000007 RSI: ffffffff85aed689 RDI: 0000000000000038
RBP: ffff8801c754fba0 R08: 1ffff10038ea9f3c R09: ffffed003b6246de
R10: 0000000000000003 R11: 0000000000000001 R12: ffff8801d7db0440
R13: ffff8801d7db0ac8 R14: ffffffff819162e0 R15: dffffc0000000000
FS:  00007fb062d18700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe020cfbf0 CR3: 00000001ad873000 CR4: 00000000001426e0
Call Trace:
  smap_release_sock+0x2e5/0x380 kernel/bpf/sockmap.c:1474
  sock_map_delete_elem+0x3e9/0x5a0 kernel/bpf/sockmap.c:1813
  map_delete_elem+0x32e/0x4e0 kernel/bpf/syscall.c:882
  __do_sys_bpf kernel/bpf/syscall.c:2366 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2334 [inline]
  __x64_sys_bpf+0x342/0x510 kernel/bpf/syscall.c:2334
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb062d17c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fb062d186d4 RCX: 0000000000457099
RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cb908 R14: 00000000004c32ca R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
---------------------------------
CPU:1 [LOST 1631 EVENTS]
syz-exec-9417    1...2 282913244us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913249us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913254us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913260us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913265us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913270us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913275us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913280us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913285us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913290us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913295us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913313us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913318us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913323us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913327us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913332us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913337us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913342us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913347us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913363us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913368us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913387us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913392us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913409us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913414us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913419us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913424us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913428us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913434us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913439us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913444us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913449us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913454us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913459us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913464us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913469us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913474us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913479us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913484us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913488us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913493us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913498us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913503us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913508us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913513us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913518us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913523us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913528us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913533us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913538us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913543us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913548us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913553us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913558us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913563us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913568us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913573us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913578us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913583us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913588us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913593us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913598us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913603us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913608us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913613us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913617us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913622us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913628us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913633us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913637us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913642us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913647us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913659us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913665us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913670us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913675us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913680us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913685us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913690us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913695us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913700us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913705us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913710us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913715us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913720us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913725us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913730us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913735us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913740us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913745us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913750us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913755us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913760us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913764us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913769us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913774us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913779us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913784us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913789us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913794us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913799us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913804us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913811us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913816us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913821us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913826us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913831us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913836us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913841us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913846us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913851us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913856us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913861us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913866us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913871us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913876us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913881us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913885us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913890us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913895us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913905us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913910us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913915us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913920us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913931us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282913936us : 0: u00000000a32ec4ab	
syz-exec-9417    1.N.2 282914013us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914059us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914065us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914069us : 0: u00000000a32ec4ab	
syz-exec-9417    1.N.2 282914133us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914255us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914261us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914266us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914271us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914276us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914281us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914286us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914291us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914295us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914300us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914304us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914308us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914313us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914317us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914321us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914326us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914331us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914336us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914341us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914346us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914351us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914356us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914361us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914366us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914370us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914375us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914380us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914385us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914390us : 0: u00000000a32ec4ab	
syz-exec-9417    1...2 282914395us : 0: u00000000a32ec4ab	
---------------------------------
---[ end trace 9de9b5e392d96e98 ]---
RIP: 0010:tcp_cleanup_ulp+0xbe/0x140 net/ipv4/tcp_ulp.c:131
Code: 02 00 0f 85 8a 00 00 00 49 8b 9c 24 88 06 00 00 e8 b7 f8 cd fb 48 8d  
7b 38 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
51 48 8b 7b 38 e8 93 5c c2 fb 4c 89 ea 48 b8 00 00
RSP: 0018:ffff8801c754fb80 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90001ed8000
RDX: 0000000000000007 RSI: ffffffff85aed689 RDI: 0000000000000038
RBP: ffff8801c754fba0 R08: 1ffff10038ea9f3c R09: ffffed003b6246de
R10: 0000000000000003 R11: 0000000000000001 R12: ffff8801d7db0440
R13: ffff8801d7db0ac8 R14: ffffffff819162e0 R15: dffffc0000000000
FS:  00007fb062d18700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe020cfbf0 CR3: 00000001ad873000 CR4: 00000000001426e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
