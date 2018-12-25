Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8D0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 12:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E822177E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 12:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeLYMhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 07:37:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:34564 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeLYMhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 07:37:06 -0500
Received: by mail-it1-f198.google.com with SMTP id x17so3222231ita.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 04:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ShXajhXb8fTzlQvf8EA7nTJ7hfdz6rvjJkWspYmXiQ0=;
        b=URJauxKJzkhEhCvO260GebGCI4y0qgMOe7zs8kerpwwqwstHGSzsf27AM4JGlwz35h
         kiEzxSq0AxLT98PdNsQWrcEaDgWEYsNBSqZx28ZKdVuzYeYnQ/xA7Xr2x9qLAPzEGas9
         NtwUtjBa23PzpUQc6wRSqVHWl2W9RwaTIRDhD1hirh/A+twt6JvLTmc4+YrP+BVW4Ga/
         nNPdoc516o1BP+FmXcpDpiekbX6X+9y6+5e7YUNuLn8JCxQzWMqfOjoa+FYm052bY0fD
         yaLjJSMi1XaHx87Nzw2LUYJ4jftnQCau1IT2G3OFg2tHVkm0oVXBWVBYbVH0KqoKu69x
         vuHQ==
X-Gm-Message-State: AA+aEWaCCEtR/i3EgIiLb1i6RKnO1iEwW3Z3VWVRkYDa26KwvbT2zjfI
        YLYmssMVsiwHso1N6M72JCdnZfsinoT1E83BXXJ6xBoH1lf2
X-Google-Smtp-Source: AFSGD/XQEcGaqUE74QIKYsHfcteV8IgSshiDhS/9/ISHNG5rJ4t7RFO566MhgRkjRLvnZkfeMfo2XS19dUaTqf+SrC/Zd9b1zM35
MIME-Version: 1.0
X-Received: by 2002:a24:7381:: with SMTP id y123mr11856337itb.32.1545741424894;
 Tue, 25 Dec 2018 04:37:04 -0800 (PST)
Date:   Tue, 25 Dec 2018 04:37:04 -0800
In-Reply-To: <0000000000005b7c64057ba003fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ba970057dd7f809@google.com>
Subject: Re: BUG: unable to handle kernel paging request in tpg_fill_plane_buffer
From:   syzbot <syzbot+aa8212f63ea8ffaf3bfa@syzkaller.appspotmail.com>
To:     bwinther@cisco.com, hverkuil-cisco@xs4all.nl, hverkuil@xs4all.nl,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    6a1d293238c1 Add linux-next specific files for 20181224
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17afe9c7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9369d117d073843
dashboard link: https://syzkaller.appspot.com/bug?extid=aa8212f63ea8ffaf3bfa
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0363b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aa8212f63ea8ffaf3bfa@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
BUG: unable to handle kernel paging request at ffffc900073cf340
#PF error: [WRITE]
PGD 1da93a067 P4D 1da93a067 PUD 1da93b067 PMD 1bad61067 PTE 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 10163 Comm: vivid-000-vid-c Not tainted  
4.20.0-rc7-next-20181224 #188
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:memcpy_erms+0x6/0x10 arch/x86/lib/memcpy_64.S:55
Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3  
48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f  
80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
kobject: 'loop0' (00000000cecb8b38): kobject_uevent_env
RSP: 0018:ffff8881d455f4f8 EFLAGS: 00010246
RAX: ffffc900073cf340 RBX: 00000000000000f8 RCX: 00000000000000f8
RDX: 00000000000000f8 RSI: ffffc90001da3000 RDI: ffffc900073cf340
RBP: ffff8881d455f518 R08: fffff52000e79e87 R09: fffff52000e79e87
R10: fffff52000e79e86 R11: ffffc900073cf437 R12: ffffc900073cf340
R13: ffffc90001da3000 R14: dffffc0000000000 R15: ffff8881cb5a5e60
FS:  0000000000000000(0000) GS:ffff8881dac00000(0000) knlGS:0000000000000000
kobject: 'loop0' (00000000cecb8b38): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900073cf340 CR3: 00000001c0ef1000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  memcpy include/linux/string.h:352 [inline]
  tpg_fill_plane_pattern drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:2382  
[inline]
  tpg_fill_plane_buffer+0x193f/0x44c0  
drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:2481
  vivid_fillbuff+0x1c87/0x6620  
drivers/media/platform/vivid/vivid-kthread-cap.c:467
  vivid_thread_vid_cap_tick  
drivers/media/platform/vivid/vivid-kthread-cap.c:718 [inline]
  vivid_thread_vid_cap+0xf00/0x2ce0  
drivers/media/platform/vivid/vivid-kthread-cap.c:836
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
CR2: ffffc900073cf340
---[ end trace 5df23b5ab40374c3 ]---
RIP: 0010:memcpy_erms+0x6/0x10 arch/x86/lib/memcpy_64.S:55
Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3  
48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f  
80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
RSP: 0018:ffff8881d455f4f8 EFLAGS: 00010246
RAX: ffffc900073cf340 RBX: 00000000000000f8 RCX: 00000000000000f8
RDX: 00000000000000f8 RSI: ffffc90001da3000 RDI: ffffc900073cf340
RBP: ffff8881d455f518 R08: fffff52000e79e87 R09: fffff52000e79e87
R10: fffff52000e79e86 R11: ffffc900073cf437 R12: ffffc900073cf340
R13: ffffc90001da3000 R14: dffffc0000000000 R15: ffff8881cb5a5e60
FS:  0000000000000000(0000) GS:ffff8881dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900073cf340 CR3: 00000001c0ef1000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

