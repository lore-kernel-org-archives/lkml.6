Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9427BECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C50208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C50208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeGMJPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:15:45 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:43903 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeGMJPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:15:45 -0400
Received: by mail-it0-f71.google.com with SMTP id n68-v6so6926668ite.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 02:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bIdGZxvCK8dwBjDxfE4ZW9xugihCxIRrSHtdhi+CS9w=;
        b=r/qhTuYrLCmrJ/cxGUDpBkQ2v/9eKoueOWwH77nqA9Yyx3ZhRRsx6HQBVqZFZlVENM
         RC+IwTu71D7qAp3m/y5SMwYHmoCUQM3KqrgrF3aI9LUylA0It2FJorVe7lujIEWLfa4n
         9aWl9cOQ+vcc35+U1pKUSAoLYyncl/hJcwp18gwfAHifIC/8zitTAsdnC0Mw5mmIBlQU
         eBEYRmfx2WT2ejnPzbTGuNonyS7l6xwOl1+bAz38RpFRbisGOR/4JQ12Qmx0o9WER+E1
         MJOmkoLEH3AoGx/0RYgCfIIT+J0IBAFlTDdTz4/w/ssD9JSzJwR2lffIT7QrcYq6s9Vz
         MfCA==
X-Gm-Message-State: AOUpUlHJ/MDgmj/giFDs2+pw3LhRXLnXUdt8mgvdMA/IVnuGYh+/JB/B
        WrJccI2np0mXYsyAKTCY9zEliTZIxqxiZ0v1IBDCM3q3a1Or
X-Google-Smtp-Source: AAOMgpfyg05rof9qum65UV0dXX6jJ7VI1MlJPa6qKbwmYuz1z7Q5Syc1ZF1RP9kaXvht2ow/5WNGe3nE7oK95he1luyFOOJZpBB/
MIME-Version: 1.0
X-Received: by 2002:a02:760c:: with SMTP id z12-v6mr2336090jab.33.1531472521908;
 Fri, 13 Jul 2018 02:02:01 -0700 (PDT)
Date:   Fri, 13 Jul 2018 02:02:01 -0700
In-Reply-To: <000000000000483ec605708a998d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6dc900570ddbbe8@google.com>
Subject: Re: general protection fault in kfree (2)
From:   syzbot <syzbot+1ff9d2e170913c4ef264@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    3ee15ba60e6b Add linux-next specific files for 20180712
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d3652c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe1c3df2c7c0c81
dashboard link: https://syzkaller.appspot.com/bug?extid=1ff9d2e170913c4ef264
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10d9d1a4400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10657794400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1ff9d2e170913c4ef264@syzkaller.appspotmail.com

FS-Cache: O-cookie c=00000000bfe1c402 [p=00000000445b4196 fl=222 nc=0 na=1]
FS-Cache: O-cookie d=00000000a5eb7aa3 n=000000005d36a973
kasan: CONFIG_KASAN_INLINE enabled
FS-Cache: O-key=[10] '
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 4474 Comm: syz-executor242 Not tainted  
4.18.0-rc4-next-20180712+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
34
RIP: 0010:virt_to_head_page include/linux/mm.h:638 [inline]
RIP: 0010:virt_to_cache mm/slab.c:399 [inline]
RIP: 0010:kfree+0xa0/0x260 mm/slab.c:3809
Code:
32
82 cb 01 00
39
00 48 ba 00 00
34
00 80 ff 77
36
00 00 48 01
39
c2 48 89 df
35
48 b8 00 00 00
31
00 00 ea ff
35
ff 48 c1 ea
35
0c 48 c1 e2
'
06 48 01 c2 <48>
FS-Cache: N-cookie c=00000000525aeed3 [p=00000000445b4196 fl=2 nc=0 na=1]
8b 42 08 a8 01
FS-Cache: N-cookie d=00000000a5eb7aa3 n=000000003a05f34d
48 8d 48 ff 48
FS-Cache: N-key=[10] '
0f 45 d1 4c 8b
34
6a 18 49 63 75
32
74
RSP: 0018:ffff8801b105f5d0 EFLAGS: 00010003
39
RAX: ffffea0000000000 RBX: f780d0382154ac00 RCX: 1ffff1003620bed8
RDX: 03ddef20e0855280 RSI: ffffffff87700e50 RDI: f780d0382154ac00
RBP: ffff8801b105f5f0 R08: ffff8801ade02380 R09: ffffed003620bdf8
34
R10: ffffed0039d876c0 R11: 0000000000000001 R12: 0000000000000282
R13: ffffffff87700e8a R14: ffff8801b105f740 R15: ffff8801ce4c0540
FS:  00007feab2d14700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
36
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f32b40b0000 CR3: 00000001c4338000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
39
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
35
  p9_client_version net/9p/client.c:1010 [inline]
  p9_client_create+0xfea/0x1770 net/9p/client.c:1070
31
35
35
'
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  legacy_get_tree+0x118/0x440 fs/fs_context.c:659
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445b59
Code: e8 bc e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 0e fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007feab2d13da8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006dac3c RCX: 0000000000445b59
RDX: 0000000020000180 RSI: 0000000020000140 RDI: 0000000000000000
RBP: 00000000006dac38 R08: 0000000020000300 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0031656c69662f2e
R13: 6f6c3d6568636163 R14: 64663d736e617274 R15: 0000000000000001
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace bacf24c1f955b911 ]---
general protection fault: 0000 [#2] SMP KASAN
CPU: 1 PID: 4472 Comm: syz-executor242 Tainted: G      D            
4.18.0-rc4-next-20180712+ #6
RIP: 0010:virt_to_head_page include/linux/mm.h:638 [inline]
RIP: 0010:virt_to_cache mm/slab.c:399 [inline]
RIP: 0010:kfree+0xa0/0x260 mm/slab.c:3809
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Code:
RIP: 0010:virt_to_head_page include/linux/mm.h:638 [inline]
RIP: 0010:virt_to_cache mm/slab.c:399 [inline]
RIP: 0010:kfree+0xa0/0x260 mm/slab.c:3809
82
Code:
cb
82
01
cb
00
01
00
00
48
00
ba
48
00 00
ba
00
00
80
00
ff
00
77
80
00
ff
00
77
48
00 00
01
48
c2
01
48
c2
89
48
df
89
48
df
b8
48
00
b8
00
00
00
00
00
00
00
00
ea
00
ff
ea
ff
ff
48
ff
c1
48
ea
c1
0c
ea
48
0c
c1
48
e2
c1
06
e2
48
06
01
48
c2
01
<48>
c2
8b
<48>
42
8b
08
42
a8
08
01
a8
48
01
8d
48
48
8d
ff
48
48
ff
0f
48
45
0f
d1
45
4c
d1
8b
4c
6a
8b
18
6a
49
18
63
49
75
63
74
75
74
RSP: 0018:ffff8801b105f5d0 EFLAGS: 00010003
RSP: 0018:ffff8801b3db75d0 EFLAGS: 00010003
RAX: ffffea0000000000 RBX: f780d0382154ac00 RCX: 1ffff1003620bed8
RDX: 03ddef20e0855280 RSI: ffffffff87700e50 RDI: f780d0382154ac00
RAX: ffffea0000000000 RBX: afd91d4db7636200 RCX: 1ffff100367b6ed8
RBP: ffff8801b105f5f0 R08: ffff8801ade02380 R09: ffffed003620bdf8
RDX: 02bf505536dd8d80 RSI: ffffffff87700e50 RDI: afd91d4db7636200
R10: ffffed0039d876c0 R11: 0000000000000001 R12: 0000000000000282
RBP: ffff8801b3db75f0 R08: ffff8801ad62a300 R09: ffffed00367b6df8
R13: ffffffff87700e8a R14: ffff8801b105f740 R15: ffff8801ce4c0540
R10: ffffed0039d876e0 R11: 0000000000000001 R12: 0000000000000282
FS:  00007feab2d14700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
R13: ffffffff87700e8a R14: ffff8801b3db7740 R15: ffff8801aa0a03c0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
FS:  00007feab2d14700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CR2: 00007f32b40b0000 CR3: 00000001c4338000 CR4: 00000000001406f0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
CR2: 00007f32b40b0000 CR3: 00000001c0acc000 CR4: 00000000001406e0
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000

