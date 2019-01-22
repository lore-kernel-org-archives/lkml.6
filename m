Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A96CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF6820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfAVU3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:29:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:53171 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVU3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:29:05 -0500
Received: by mail-it1-f200.google.com with SMTP id o205so14571895itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 12:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Q9cpvbPwxLlHWgAj1QTgyW8ET3cYp4gShFpDaXuxYZ4=;
        b=lkyPNTiGoa5UEqzu5qfBAE4n09yY1bA6YacrWzwY4CXrUWc9Jhnn/xMzxdOSQro6xa
         tKwCn6zAcuQUTTvniwy3LH53yf97kcyGOM2wykBfI6/kOGyc778GmEmjIWsW49UYvQvb
         1T+tJ6+cVbGlIEn0PrIU/qnMpwD34Fzvb59+FUad+jHp5dt8g3pteFb/vVxwucvCWIMM
         fo4uZEtjYZu7ogvvYK6wIlNYoTr8ZLcBU8o0FPt2PeUUA+JXoC2ytrQjzrV57m18lYP+
         9GgU45+goUgQIKlVifXjSmRPPR6MuQpVZRZN1tFoInjw+JSD1/eNkgE5kZ9t2mL9RKBl
         4HjQ==
X-Gm-Message-State: AHQUAuaxZHNp6zWapHEMLZN6Bj4DVb2YfUT7stEGNri024t7OGv07q4Z
        p7mJQ0yVYSSbWIwSLVvj8BKVCjq7snBGnQzHLFbavX2Tkq3J
X-Google-Smtp-Source: ALg8bN7t6+4mSn81XQAA9PfnM2ejbXIQ+sRWLGzT/xRFmQhqFM6mtNhORaNlOJjxtqkaVuxGpxb/8C7Z8d47iCb7FK+KOUqjJOsM
MIME-Version: 1.0
X-Received: by 2002:a24:4e83:: with SMTP id r125mr36121ita.6.1548188943968;
 Tue, 22 Jan 2019 12:29:03 -0800 (PST)
Date:   Tue, 22 Jan 2019 12:29:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cf22a058011d494@google.com>
Subject: general protection fault in nf_ct_gre_keymap_flush
From:   syzbot <syzbot+fcee88b2d87f0539dfe9@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@blackhole.kfki.hu, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5b22549b8c00 Add linux-next specific files for 20190122
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11e6d908c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d3270828ee2eb2f
dashboard link: https://syzkaller.appspot.com/bug?extid=fcee88b2d87f0539dfe9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fcee88b2d87f0539dfe9@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 25155 Comm: syz-executor3 Not tainted 5.0.0-rc3-next-20190122  
#17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:nf_ct_gre_keymap_flush+0xb9/0x2f0  
net/netfilter/nf_conntrack_proto_gre.c:65
Code: 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 0f 85 2b 02 00 00 4c 8b bb f8 16  
00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 fc 01 00 00 4c 3b bd 68 ff ff ff 4d 8b 27 0f 84
RSP: 0018:ffff88804b687698 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88804a121840 RCX: 0000000000000000
RDX: 1ffffffff146dfc2 RSI: 0000000000000004 RDI: ffff88804b687600
RBP: ffff88804b687748 R08: 1ffff110096d0ec0 R09: ffffed10096d0ec1
R10: ffffed10096d0ec0 R11: 0000000000000003 R12: dffffc0000000000
R13: ffff88804b687858 R14: ffff88804a122f38 R15: 0000000000000000
FS:  00007f1b18c8e700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000070a158 CR3: 00000000a5f04000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  nf_conntrack_proto_pernet_fini+0x16/0x1a  
net/netfilter/nf_conntrack_proto.c:617
  nf_conntrack_cleanup_net_list+0x204/0x330  
net/netfilter/nf_conntrack_core.c:2183
  nf_conntrack_cleanup_net+0x1c5/0x270 net/netfilter/nf_conntrack_core.c:2156
  nf_conntrack_pernet_init net/netfilter/nf_conntrack_standalone.c:1122  
[inline]
  nf_conntrack_pernet_init+0xc3f/0xf00  
net/netfilter/nf_conntrack_standalone.c:1091
  ops_init+0x109/0x5d0 net/core/net_namespace.c:129
  setup_net+0x38f/0x940 net/core/net_namespace.c:314
  copy_net_ns+0x2ae/0x4b0 net/core/net_namespace.c:437
  create_new_namespaces+0x4ce/0x930 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:206
  ksys_unshare+0x6d7/0xfb0 kernel/fork.c:2550
  __do_sys_unshare kernel/fork.c:2618 [inline]
  __se_sys_unshare kernel/fork.c:2616 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2616
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458099
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1b18c8dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000458099
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1b18c8e6d4
R13: 00000000004c6d60 R14: 00000000004dc280 R15: 00000000ffffffff
Modules linked in:
---[ end trace 88887a1b76d6af3e ]---
RIP: 0010:nf_ct_gre_keymap_flush+0xb9/0x2f0  
net/netfilter/nf_conntrack_proto_gre.c:65
Code: 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 0f 85 2b 02 00 00 4c 8b bb f8 16  
00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 fc 01 00 00 4c 3b bd 68 ff ff ff 4d 8b 27 0f 84
RSP: 0018:ffff88804b687698 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88804a121840 RCX: 0000000000000000
RDX: 1ffffffff146dfc2 RSI: 0000000000000004 RDI: ffff88804b687600
RBP: ffff88804b687748 R08: 1ffff110096d0ec0 R09: ffffed10096d0ec1
R10: ffffed10096d0ec0 R11: 0000000000000003 R12: dffffc0000000000
R13: ffff88804b687858 R14: ffff88804a122f38 R15: 0000000000000000
FS:  00007f1b18c8e700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000070a158 CR3: 00000000a5f04000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
