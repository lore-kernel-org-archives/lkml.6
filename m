Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14573C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEA2208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEA2208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeJCDwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:52:19 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50060 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeJCDwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:52:19 -0400
Received: by mail-io1-f69.google.com with SMTP id k9-v6so3581862iob.16
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f4Wv6fdzZ7OsXwmVEj24RRalY/9dIntl+gJveiTwpK8=;
        b=E9l6XOksnHhjzKKkrBEIKBTq+VrVdUfM3Y3Aoogn6Ie8ep93HI4RwSmuHj2hwTiqVT
         0fW5nxOcjg/NRqQDpM2Gevd559oOiuoBB/2xcj/AkqLolRgOQ0rrGXqTHsGuU+uUxgzT
         9qwD7Z1evDndwAPT03DPED8JfP2ErgyeokJNhLyDPnakiV/kvc/L2Y+V18FpaN/M1PM3
         b3a6XpUOcgOCfpZswwst9HEtfexWV3aCqaDU6MkisdfWuPwq7GW/QRWCMS7mav28JKsH
         fGl5nRiZkRkDCY4QlENqIPxRg+Bgb31qqhgMGhWj2FqF3EAcwIAehqdtXzS5UfFYNqn9
         AmYA==
X-Gm-Message-State: ABuFfog6sADT1O2NvmadozPCX+4gUiFsl5PrO47ExSm/a/SIWh0VpwX4
        VSBf2tQmx3N6GVKNoo98OByiEXFpDDT3nZdVhvfkTnLeYfC/
X-Google-Smtp-Source: ACcGV618MbT0uNWcijfIZQ8YK6L5eOhl2o/f9dnOsohY4PwwwKzEmrx/zT8A3IqDKTnwlRJBJsfoUCYn8dMr5u0giHJIIVuht/RF
MIME-Version: 1.0
X-Received: by 2002:a02:1c84:: with SMTP id c126-v6mr6189768jac.13.1538514423180;
 Tue, 02 Oct 2018 14:07:03 -0700 (PDT)
Date:   Tue, 02 Oct 2018 14:07:03 -0700
In-Reply-To: <000000000000d05a78056873bc47@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000acf9cc0577454de3@google.com>
Subject: Re: WARNING in kvm_arch_vcpu_ioctl_run (3)
From:   syzbot <syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, kernellwp@gmail.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    1d2ba7fee28b Merge tag 'fbdev-v4.19-rc7' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b019b9400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=760a73552f47a8cd0fd9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156ad231400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com

kvm: emulating exchange as write
WARNING: CPU: 1 PID: 10797 at arch/x86/kvm/x86.c:7925  
kvm_arch_vcpu_ioctl_run+0x1ca/0x16e0 arch/x86/kvm/x86.c:7925
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 10797 Comm: syz-executor4 Not tainted 4.19.0-rc6+ #264
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:kvm_arch_vcpu_ioctl_run+0x1ca/0x16e0 arch/x86/kvm/x86.c:7925
Code: 03 80 3c 02 00 0f 85 f0 13 00 00 4c 8b a3 18 2c 00 00 31 ff 4c 89 e6  
e8 74 96 6e 00 4d 85 e4 0f 84 fd 0a 00 00 e8 36 95 6e 00 <0f> 0b e8 2f 95  
6e 00 49 8d 7d 01 48 b8 00 00 00 00 00 fc ff df 48
RSP: 0018:ffff8801d7fff860 EFLAGS: 00010293
RAX: ffff8801c92de280 RBX: ffff8801c8fe0540 RCX: ffffffff81102b80
RDX: 0000000000000000 RSI: ffffffff8110204a RDI: 0000000000000005
RBP: ffff8801d7fff8d8 R08: ffff8801c92de280 R09: 1ffffffff1273955
R10: ffffed003b5e4732 R11: ffff8801daf23993 R12: 0000000000000001
R13: ffff8801c29a7000 R14: 0000000000000000 R15: ffff8801c8fe0618
  kvm_vcpu_ioctl+0x72b/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f51c3ee0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f51c3ee16d4
R13: 00000000004c003b R14: 00000000004d0108 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..

