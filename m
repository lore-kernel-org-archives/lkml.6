Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506EBC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F379C20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F379C20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeIBXpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 19:45:53 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:41520 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeIBXpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 19:45:53 -0400
Received: by mail-it0-f71.google.com with SMTP id w132-v6so10455227ita.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 12:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OZJ2a25Kd0L8pkoufkzehn91cP+LPTT6K9itiUzu7s4=;
        b=YdGWqUv0/JZbDY3KBiZc6gfTxBCBrLbAjcMZSoF3Ch6QrCKz4JCiMbHNtCX7uWFzqf
         AGb//uEPoWI3B6Jab1wQtZUyyuh3T/ikHdj5Yk7n+l7qqqjq/0u3vYGQGhC44iF0VJ4f
         idAOyYALSZzKZ0f/rxmiBTWd+maWvQBYCm8yGULXZ2knOzFHMRX+lQ9PcZHxDSENGNGs
         rB6rhCahBvJTq4/BK516xqIoXZzesOqX0ZxRmxWIAu7LN+aH/dxD0iFAFXLXg46DS7Og
         OJzfcT8RLMBhLMzmO14TO+vdIcb9phvtQb9au6wwGhMFueErAKVFfY4VCv9zXTJ6ju1N
         BP6w==
X-Gm-Message-State: APzg51BIWqkc00q8equNg3xdZa3EUm7kOzdGICPAI9r8kr0iBMC3yIf1
        B9+3h1m9w+p3wjVqNSxICrStgG1bYjYC/EayguspTua8lP4w
X-Google-Smtp-Source: ANB0VdYkHT2emST1wZ4gqrrsR1PZ7Hrx8gdXRaTuJciDPPV+srnb7DsYdBDdOcddBAyK9uFRNmu2gcvzsX/doYBxKEw4pQOtkwlp
MIME-Version: 1.0
X-Received: by 2002:a02:9526:: with SMTP id y35-v6mr10350677jah.16.1535916543763;
 Sun, 02 Sep 2018 12:29:03 -0700 (PDT)
Date:   Sun, 02 Sep 2018 12:29:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000feece60574e86f8d@google.com>
Subject: KMSAN: uninit-value in snd_midi_event_encode_byte
From:   syzbot <syzbot+194dffdb8b22fc5d207a@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2dca2cbde67a kmsan: fix build warnings with CONFIG_KMSAN=n
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=1660ef6a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=820d6393634b55e3
dashboard link: https://syzkaller.appspot.com/bug?extid=194dffdb8b22fc5d207a
compiler:       clang version 8.0.0 (trunk 339414)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+194dffdb8b22fc5d207a@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in snd_midi_event_encode_byte+0x569/0xff0  
sound/core/seq/seq_midi_event.c:195
CPU: 0 PID: 1623 Comm: kworker/0:1H Not tainted 4.19.0-rc1+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_highpri snd_vmidi_output_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x14b/0x190 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  snd_midi_event_encode_byte+0x569/0xff0 sound/core/seq/seq_midi_event.c:195
  snd_vmidi_output_work+0x34e/0x5b0 sound/core/seq/seq_virmidi.c:161
  process_one_work+0x1605/0x1f40 kernel/workqueue.c:2153
  worker_thread+0x11a2/0x2590 kernel/workqueue.c:2296
  kthread+0x465/0x4a0 kernel/kthread.c:247
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:271 [inline]
  kmsan_internal_chain_origin+0x128/0x210 mm/kmsan/kmsan.c:573
  __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:482
  __snd_rawmidi_transmit_peek sound/core/rawmidi.c:1103 [inline]
  snd_rawmidi_transmit+0xa75/0xbf0 sound/core/rawmidi.c:1228
  snd_vmidi_output_work+0x2ac/0x5b0 sound/core/seq/seq_virmidi.c:159
  process_one_work+0x1605/0x1f40 kernel/workqueue.c:2153
  worker_thread+0x11a2/0x2590 kernel/workqueue.c:2296
  kthread+0x465/0x4a0 kernel/kthread.c:247
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:181
  kmsan_kmalloc+0x98/0x100 mm/kmsan/kmsan_hooks.c:91
  __kmalloc_node+0x7bf/0x11c0 mm/slub.c:3828
  kmalloc_node include/linux/slab.h:555 [inline]
  kvmalloc_node+0x19d/0x3e0 mm/util.c:423
  kvmalloc include/linux/mm.h:577 [inline]
  snd_rawmidi_runtime_create sound/core/rawmidi.c:132 [inline]
  open_substream+0x3c8/0xaa0 sound/core/rawmidi.c:276
  rawmidi_open_priv+0x347/0x1000 sound/core/rawmidi.c:327
  snd_rawmidi_open+0x7d4/0x1120 sound/core/rawmidi.c:424
  soundcore_open+0x9be/0xa60 sound/sound_core.c:597
  chrdev_open+0xc26/0xdb0 fs/char_dev.c:417
  do_dentry_open+0xc9d/0x1660 fs/open.c:771
  vfs_open+0xaf/0xe0 fs/open.c:880
  do_last fs/namei.c:3418 [inline]
  path_openat+0x17a6/0x67c0 fs/namei.c:3534
  do_filp_open+0x259/0x610 fs/namei.c:3564
  do_sys_open+0x630/0x940 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0xf2/0x130 fs/open.c:1076
  do_syscall_64+0x15b/0x220 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
