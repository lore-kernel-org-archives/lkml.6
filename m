Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2942C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C818218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfAWTtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:49:05 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:53779 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAWTtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:49:05 -0500
Received: by mail-it1-f197.google.com with SMTP id i12so548845ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 11:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sXb1jIfDTRvw1g8a613u9RzCOhGJsCGv6nIfK4YAHps=;
        b=lHQrd4OrCEK734BQ2OYHDJCZhZRjr7CS0nuQZ4/lpJ0D578V8htTvA3uADgy9Im5cG
         srhW9tdakLJ63uajnR1hgpt5cDPFrNtlVX2ETpt8jHGhOGdKJHTJVK8SrxNRIGoByZ4R
         vLs16sN71qMHZJ1w6C2oLdfRXc+GJ5S65Mmqki/80KpE5YRuFRYIHXw0dapn2SIqQouH
         3wY89VD3ZvZzVxhbPsqQEYWB7MtW1jAh46qScr6B6k16Xne5VLlpZ7bJKCg3VVNw1udI
         5DDEc7/JQOtlTBtcb0M8hBKxXaSQW54izDZWAUahC7A1PvJTGchen9zz4N0fqbqCW2Nc
         pNMg==
X-Gm-Message-State: AHQUAuaamvOoNcdNemIUkpOuJ9SLTllAdfwujQ/931ozBSbgvgrRpBu5
        OAAMbaIwTOEmY1Lr1I0JDrXo1mj+bNG6HmvIYyfegEHCNq1y
X-Google-Smtp-Source: ALg8bN539rbBlT2G5yKyMht7wmg7Rx+s/tyZF1ZdpexJQcqMY6NkLh1zzLVyKIczRSBhoUXLGzHt7pv6G0r6zvbXGKez8CCAXsw0
MIME-Version: 1.0
X-Received: by 2002:a24:5dd4:: with SMTP id w203mr3143563ita.8.1548272944070;
 Wed, 23 Jan 2019 11:49:04 -0800 (PST)
Date:   Wed, 23 Jan 2019 11:49:04 -0800
In-Reply-To: <0000000000000cf22a058011d494@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8cd0d05802562d2@google.com>
Subject: Re: general protection fault in nf_ct_gre_keymap_flush
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

syzbot has found a reproducer for the following crash on:

HEAD commit:    5b74ce505631 Add linux-next specific files for 20190123
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1137e1b7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4d5d672c7c71240
dashboard link: https://syzkaller.appspot.com/bug?extid=fcee88b2d87f0539dfe9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165f80c0c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fcee88b2d87f0539dfe9@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8342 Comm: syz-executor2 Not tainted 5.0.0-rc3-next-20190123 #18
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:nf_ct_gre_keymap_flush+0xb9/0x2f0  
net/netfilter/nf_conntrack_proto_gre.c:65
Code: 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 0f 85 2b 02 00 00 4c 8b bb f8 16  
00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 fc 01 00 00 4c 3b bd 68 ff ff ff 4d 8b 27 0f 84
RSP: 0018:ffff8880743eeef8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888074c10240 RCX: 0000000000000000
RDX: 1ffffffff146dff2 RSI: 0000000000000004 RDI: ffff8880743eee60
RBP: ffff8880743eefa8 R08: 1ffff1100e87ddcc R09: ffffed100e87ddcd
R10: ffffed100e87ddcc R11: 0000000000000003 R12: dffffc0000000000
R13: ffff8880743ef0b8 R14: ffff888074c11938 R15: 0000000000000000
FS:  00007f7ceb928700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000000a089b000 CR4: 00000000001406e0
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
  copy_namespaces+0x3ff/0x4d0 kernel/nsproxy.c:165
  copy_process+0x4a2d/0x8890 kernel/fork.c:1920
  _do_fork+0x1a9/0x1170 kernel/fork.c:2227
  __do_sys_clone kernel/fork.c:2334 [inline]
  __se_sys_clone kernel/fork.c:2328 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2328
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458099
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7ceb927c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000458099
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000070024103
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7ceb9286d4
R13: 00000000004be480 R14: 00000000004ce960 R15: 00000000ffffffff
Modules linked in:
---[ end trace cdb65ca986e98ff1 ]---
RIP: 0010:nf_ct_gre_keymap_flush+0xb9/0x2f0  
net/netfilter/nf_conntrack_proto_gre.c:65
Code: 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 0f 85 2b 02 00 00 4c 8b bb f8 16  
00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 fc 01 00 00 4c 3b bd 68 ff ff ff 4d 8b 27 0f 84
RSP: 0018:ffff8880743eeef8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888074c10240 RCX: 0000000000000000
RDX: 1ffffffff146dff2 RSI: 0000000000000004 RDI: ffff8880743eee60
RBP: ffff8880743eefa8 R08: 1ffff1100e87ddcc R09: ffffed100e87ddcd
R10: ffffed100e87ddcc R11: 0000000000000003 R12: dffffc0000000000
R13: ffff8880743ef0b8 R14: ffff888074c11938 R15: 0000000000000000
FS:  00007f7ceb928700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000000a089b000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

