Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBEDC65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729AD2147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729AD2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJFUBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 16:01:16 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35250 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeJFUBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 16:01:16 -0400
Received: by mail-io1-f72.google.com with SMTP id z20-v6so14873744ioh.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 05:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CgDDlag2mILzaxWDlqtppDT4aDbp/sWrE6BCLhwHGWM=;
        b=kupiPeWKEusj6hN807QAMND3xLUDpKy7thgM5qRnosh5q0BfF0VegCIBMwxF1okbBR
         fDO5FVZSL+EoOTFDhjZ5exq0CohGJwG4ElaBehyvxhpBI7yfD1FZHBirAqDy4M13rcnV
         /jvEP64Aq+mZYlE7AHbEoaCWWtqT1WXj8AikbRlZcovw7ptwaxqWfQxtPelhwvLdw+Ui
         uMJReD7O+rDSBckvAbpMilGffknT901vGPVU8IzV445ss/yJrmPHEkNAeisga4NoHZIe
         LCu1mc7rjDIM0jy5RLedgtZAZfvPeIU317KQ/YF9C/jUFDNT+EJj6R9rJqdLUzQJ9Tb/
         KyMw==
X-Gm-Message-State: ABuFfog82mDjnc43KEhIMDmvDAOUSjzXb9hvC0tOwJZWDa6WF0cgLtgd
        vj92apZRsPuS+E7gvaoD1CddYdIgbxMaHhmWqfAnr1RQZ9PI
X-Google-Smtp-Source: ACcGV62Ow7vOAxFul3wCtG3zP4M+Shjc65j6gaQF59cx6xuqnS0+xsfhCeZU2dBduY75ozmWmmXpOgy8IWDSMcsWUf8wG/EJyMnY
MIME-Version: 1.0
X-Received: by 2002:a24:4f46:: with SMTP id c67-v6mr11472243itb.23.1538830683208;
 Sat, 06 Oct 2018 05:58:03 -0700 (PDT)
Date:   Sat, 06 Oct 2018 05:58:03 -0700
In-Reply-To: <0000000000004f7eb00570be9f92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e04c305778ef053@google.com>
Subject: Re: WARNING in port_delete
From:   syzbot <syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com>
To:     alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org,
        colin.king@canonical.com, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    091a1eaa0e30 Merge branch 'akpm'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16623e59400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c8abb920efa77bace9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102e2c91400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 23693 at sound/core/seq/seq_ports.c:275  
port_delete+0x177/0x1b0 sound/core/seq/seq_ports.c:275
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 23693 Comm: syz-executor0 Not tainted 4.19.0-rc6+ #47
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
kobject: 'loop1' (00000000baf940ef): kobject_uevent_env
kobject: 'loop1' (00000000baf940ef): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:port_delete+0x177/0x1b0 sound/core/seq/seq_ports.c:275
Code: e7 99 fb 45 85 e4 75 14 e8 66 e6 99 fb 48 89 df e8 ee 29 dd fb 31 c0  
5b 41 5c 5d c3 e8 52 e6 99 fb 0f 0b eb e3 e8 49 e6 99 fb <0f> 0b eb 9b e8  
a0 55 dd fb eb bd e8 99 55 dd fb e9 77 ff ff ff e8
RSP: 0018:ffff8801a7477890 EFLAGS: 00010293
RAX: ffff8801a84e05c0 RBX: ffff8801cf0be4c0 RCX: ffffffff85e4eee1
RDX: 0000000000000000 RSI: ffffffff85e4ef47 RDI: 0000000000000005
RBP: ffff8801a74778a0 R08: ffff8801a84e05c0 R09: 00000000deede79a
R10: 00000000da8ba726 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8801cf0be510 R14: 1ffff10034e8ef20 R15: ffff8801cb447b00
  snd_seq_delete_port+0x3cb/0x4a0 sound/core/seq/seq_ports.c:303
  snd_seq_ioctl_delete_port+0xba/0x190 sound/core/seq/seq_clientmgr.c:1324
  snd_seq_kernel_client_ctl+0x15a/0x190 sound/core/seq/seq_clientmgr.c:2353
  snd_seq_event_port_detach+0xfc/0x170 sound/core/seq/seq_ports.c:705
  delete_port+0x7d/0xc0 sound/core/seq/oss/seq_oss_init.c:354
  snd_seq_oss_release+0xf2/0x130 sound/core/seq/oss/seq_oss_init.c:433
  odev_release+0x52/0x70 sound/core/seq/oss/seq_oss.c:153
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f85fa204c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000457579
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f85fa2056d4
R13: 00000000004ef912 R14: 00000000004cc460 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..

