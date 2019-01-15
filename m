Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C64520866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYgcVZN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfAOWZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:25:52 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36981 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfAOWZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:25:52 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so92897iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 14:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iR2ByECA/bbnX5KUprJV3Dyc8DZlZ+AXTN6R/ayDlrI=;
        b=LYgcVZN6nPZLEWsnBYxY75oCWkENxMVB/0cvWm5XrH9zbXn8+P9sdr8oyLYRu/3+dp
         0/x2cFCJSJOEy3PTKSyu8P3XkbjdwaPTmKMucDEXEWrS0IqFBdRbMFz/CI+RtrL1bhaE
         HjLbWIfJJk69IoSmc3GDfse6GgDhBi0qVl2FLg+qQbs9YRXfw+tLrCwYJpN5hDu6T9iZ
         U4wjYW1LwSL1iRTwuDgTBzrjHvjkp4wSML729i+CkZZq7sPJfqRj9eJaIhnOoPFKV29a
         N6TzsCYPKdY0ZWuv1w2NBa4nIob0LMqLSyMokQGL1pOFyLrHEhz7GM67tCKHgL7Gj2eI
         Q8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iR2ByECA/bbnX5KUprJV3Dyc8DZlZ+AXTN6R/ayDlrI=;
        b=mluvxjJVoTHE58lV43EGPoITBBr5fw3MpBG+DWnzaus/imn5wkNq0cBFYN1hdI7aZt
         BNP+j9roTynPZUd87+RkOh1uq3sVKjglwb1S4kXPsVrKQMz+ptBHqeoXx8aCaDxtqSiN
         ArQ5JuvQkG9aXuipIlvo4EDFysoQ/m+80upTzfWnPj8Vy8qNJKCU+PKZ9lKy5iWe338b
         p2+fcxrxFTjRWVGBO26NNrBA7RXE0l8lGnkD1o1Q6xbTe4FHI2ZR+qWMyuhI6mnk0Zms
         sMNt/zEqBhlUJzMjeBaB+2WEk0dvnmqHAfkcvykSBKsaWQC0dbtCx6eXnTg2s1RHMI/V
         mZ5g==
X-Gm-Message-State: AJcUukfkTlTQb7Lq7qxivEwC6zsg0CZD0SCqxoaEfvxllk3XRHlqa4NC
        F13+6srLy3x009tOidofkcu5XFROtNk8xFZZnNU=
X-Google-Smtp-Source: ALg8bN5o2xLV3i5s5aOU3Hk41GGDZo+02mlUHueCCWNTPgGwdBK7ctHrc6WJv66qyjGoZGjpwTSHbc1yS1np9x7LqX4=
X-Received: by 2002:a24:c705:: with SMTP id t5mr3810156itg.60.1547591150972;
 Tue, 15 Jan 2019 14:25:50 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Tue, 15 Jan 2019 17:25:39 -0500
Message-ID: <CAEAjamuh=cR4ggb1qJkqcN5v4naK7vo+V57den5=BL0ky+anug@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in fs/f2fs/extent_cache.c
To:     jaegeuk@kernel.org, yuchao0@huawei.com
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug in linux-4.20.2: "UBSAN: Undefined behaviour in
fs/f2fs/extent_cache.c"

kernel config: https://kt0755.github.io/etc/config_v4.20_stable
repro: https://kt0755.github.io/etc/repro.4a3e7.c (f2fs is mounted on
/mnt/f2fs/)

This arose in f2fs_update_extent_tree_range (fs/f2fs/extent_cache.c:605).
It seems that, for some reason, its last argument became "24"
although that was supposed to be bool type.

=========================================
UBSAN: Undefined behaviour in fs/f2fs/extent_cache.c:605:4
load of value 24 is not a valid value for type '_Bool'
CPU: 0 PID: 6774 Comm: syz-executor5 Not tainted 4.20.2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xb1/0x118 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 __ubsan_handle_load_invalid_value+0x17a/0x1be lib/ubsan.c:457
 f2fs_update_extent_tree_range+0x1d4a/0x1d50 fs/f2fs/extent_cache.c:605
 f2fs_update_extent_cache+0x2b6/0x350 fs/f2fs/extent_cache.c:804
 f2fs_update_data_blkaddr+0x61/0x70 fs/f2fs/data.c:656
 f2fs_outplace_write_data+0x1d6/0x4b0 fs/f2fs/segment.c:3140
 f2fs_convert_inline_page+0x86d/0x2060 fs/f2fs/inline.c:163
 f2fs_convert_inline_inode+0x6b5/0xad0 fs/f2fs/inline.c:208
 f2fs_preallocate_blocks+0x78b/0xb00 fs/f2fs/data.c:982
 f2fs_file_write_iter+0x31b/0xf40 fs/f2fs/file.c:3062
 call_write_iter include/linux/fs.h:1857 [inline]
 new_sync_write fs/read_write.c:474 [inline]
 __vfs_write+0x538/0x6e0 fs/read_write.c:487
 vfs_write+0x1b3/0x520 fs/read_write.c:549
 ksys_write+0xde/0x1c0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x7e/0xc0 fs/read_write.c:607
 do_syscall_64+0xbe/0x4f0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1ea15edc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f1ea15ee6cc RCX: 00000000004497b9
RDX: 0000000000001000 RSI: 0000000020000140 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000bb50 R14: 00000000006f4bf0 R15: 00007f1ea15ee700
=========================================

Thanks,
Kyungtae Kim
