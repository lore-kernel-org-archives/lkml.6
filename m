Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3123C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB3125311
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csKlrC0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB3125311
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeFXUyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 16:54:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35467 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeFXUyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 16:54:37 -0400
Received: by mail-lf0-f65.google.com with SMTP id i15-v6so12849281lfc.2;
        Sun, 24 Jun 2018 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gduUVBGQO9m7egdelHCr13qJar1MlKEdX2jvrOg7xjE=;
        b=csKlrC0vURxiJITKsMOZpKPXoi6SEg/KsBT/bxKUhzG+ZQ8489D6X7GzzCdRyC9Xnm
         QuZt8D8daSmiWqY/1f4n/FLd1BFHYp3gkP6O7svW9z1j6SvyQZjnvOpnwvrghG9MScF2
         wbZfRZ0JSQlR9xj8vUytlsT/nal61t2ZEb/rtlqdePw45QABetSR2GLHni/0ixJDVu55
         qip6uN4Q2EA9vrdFrdWeYkS3PU3Ul9v3v5T2w3IC7lxdPzZV+Ay5cALRn5lH6TclEhLi
         1cSxfWBw6P1WiMS5ajpBra4U373424D/C8u11iUU8xXRtolVPqkyDZGuzGf0msubxQE9
         TXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gduUVBGQO9m7egdelHCr13qJar1MlKEdX2jvrOg7xjE=;
        b=sEzJyRz78Uya/ViH3VNcTokjbJZK/ttJoDvWdhbv9AwyGBJJSbjzAX50mGGXW7Gyig
         53dwlX08a0qQAfXOki18/KazwjTXZT/CR+aeYgsKxnSutCvDHIcMhnTIH9pPFFU+ZeW4
         RlkWPjAkKC1OhACdLMl51/OY927J46JLB+XyB+5jdc3Jm329UtauJMj8860nicwtdo0I
         42pk35FM7zWwO8waBHD+7lUrGmICZ8GATBnl9hZWcLK1BPeWOutqkSKwLBgCauBvHiPK
         kL5yGoVJxsO9Rgu7EgJckmFD2wpBFIcBLXz6RKekJ0j9y+ofaL0IUx9lP7lFVVlxuvf3
         sDQQ==
X-Gm-Message-State: APt69E0w5fc/N5Rq2VR2N9v1xsg5XN4AMulXcwbmylskHE/aw5XKNQRk
        cJ0BwRStYZLqAIB+pef3Iy06mH8iU7HwI77g8pQ=
X-Google-Smtp-Source: ADUXVKLFb7gp6EVL//xi3Amh6hAHOsKs6kHZHpSMs4tP90HyWK1tB7vpLoIQKu2N9Ngw3PzaIB9qFtL+IsgGTx9j84Q=
X-Received: by 2002:a19:9d92:: with SMTP id g140-v6mr1612868lfe.85.1529873675562;
 Sun, 24 Jun 2018 13:54:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:5119:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 13:54:35
 -0700 (PDT)
From:   shankarapailoor <shankarapailoor@gmail.com>
Date:   Sun, 24 Jun 2018 13:54:35 -0700
Message-ID: <CAB+yDaahqHTh7Mka5e28iMhdBnCegXisK5xiv_0jDrYS9qhvSw@mail.gmail.com>
Subject: WARNING in btrfs_destroy_inode
To:     Chris Mason <clm@fb.com>, jbacik@fb.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using Syzkaller to fuzz linux 4.18.0-rc1 with btrfs and found the
following WARNING crash. I have a C program that reproduces it here:
https://pastebin.com/bBzmrGFH

WARNING: CPU: 1 PID: 12788 at fs/btrfs/inode.c:9288
btrfs_destroy_inode+0x545/0x720  fs/btrfs/inode.c:9288

Kernel panic - not syncing: panic_on_warn set ...CPU: 1 PID: 12788
Comm: syz-executor5 Not tainted 4.18.0-rc1+ #35
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
Call Trace:
   __dump_stack lib/dump_stack.c:77 [inline] dump_stack+0x148/0x1b5
lib/dump_stack.c:113
   panic+0x200/0x42c kernel/panic.c:184
   __warn+0x1ea/0x200 kernel/panic.c:536
   report_bug+0x1f4/0x2b0 lib/bug.c:186
   fixup_bug.part.10+0x37/0x80 arch/x86/kernel/traps.c:178
   fixup_bug arch/x86/kernel/traps.c:248 [inline]
   do_error_trap+0x288/0x2e0 arch/x86/kernel/traps.c:296
   do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
    invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:btrfs_destroy_inode+0x545/0x720 fs/btrfs/inode.c:9288
Code: ff e8 4f 6c 52 ff 0f 0b e9 ed fb ff ff e8 43 6c 52 ff 0f 0b e9
c8 fc ff ff e8 37 6c 52 ff 0f 0b e9 f2 fc ff ff e8 2b 6c 52 ff <0f> 0b
e9 93 fb ff ff e8 1f 6c 52 ff 0f 0b e9 38 fc ff ff e8 13 6c
RSP: 0018:ffff880091287c68 EFLAGS: 00010293
RAX: ffff88009d0a8340 RBX: ffff8800a65c36a8 RCX: ffffffff820ef895
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8800a65c3598
RBP: ffff880091287cb0 R08: ffffed00169d02bf R09: 0000000000000001
R10: ffffed00169d02be R11: ffff8800b4e815f7 R12: ffff8800a65c3240
R13: ffff8800b448c1c0 R14: ffff8800a65c3878 R15: ffffffff855cbc40
    destroy_inode+0xc3/0x120 fs/inode.c:267
    evict+0x3d4/0x620 fs/inode.c:575
    iput_final fs/inode.c:1506 [inline]
    iput+0x4e8/0x760 fs/inode.c:1532
    do_unlinkat+0x398/0x670 fs/namei.c:4079
    __do_sys_unlink fs/namei.c:4120 [inline]
    __se_sys_unlink fs/namei.c:4118 [inline]
    __x64_sys_unlink+0x42/0x50 fs/namei.c:4118
    do_syscall_64+0xda/0x560 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455757
Code: 0f 1f 00 b8 58 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 bd bc fb
ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d
01 f0 ff ff 0f 83 9d bc fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffe629f058 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000455757
RDX: 0000000002980a13 RSI: 00007fffe629f0f0 RDI: 00007fffe629f0f0
RBP: 00007fffe62a0e00 R08: 0000000000000000 R09: 000000000000000a
R10: 0000000000000005 R11: 0000000000000202 R12: 0000000002980940
R13: 0000000000000000 R14: 0000000000000117 R15: 000000000008e36d


My kernel configs: https://pastebin.com/KFcaLxhj

Please let me know if I can provide more information.

-- 
Regards,
Shankara Pailoor
