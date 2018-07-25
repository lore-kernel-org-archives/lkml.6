Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F73FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1CD20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUH3cgTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1CD20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbeGYNOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:14:21 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:46032 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeGYNOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:14:21 -0400
Received: by mail-lf1-f49.google.com with SMTP id j143-v6so5235838lfj.12;
        Wed, 25 Jul 2018 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AaP34x4Vk+eRl5V+yBlS8HMeX0his/41m3Sj+Tt2r3o=;
        b=kUH3cgTCU7l2+nw+p4Y3DO0G+UVJhcbXfzFUStWWbXdh1OxqnUncBWUFQDiq3cGLLB
         pX+NpOcuITeIsq8kTfM9seigRnGeHCo8NdisRiXxu4GOgo8i7PQvGNfWJKRYwngxyp42
         CKMXkaoT5JIx85XhiGot/BlyRMhL0QjYwwEbynujzbeCDfL8iODrN03r6EF1ru5YpKG4
         a/83CTHOyDsXijg1Foz9Epmlkj8ZVmtlu88TRk6DBjALd0kOk0bid+ysnAXeDaItAhI9
         sY4cQr+nN89peNdnrMIpiYo6gWIaZh+Crdy1Q+mnTOm25fJZydau4oOzPSwkBPjVMI3e
         bgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AaP34x4Vk+eRl5V+yBlS8HMeX0his/41m3Sj+Tt2r3o=;
        b=HY9wxMJl3giWII2xaiwGU9SirfAu8dZFsi4yT5P8E0OYC4TSc8TXUSrzzBJJ8wF36d
         jY7hd3u6SWahJ0NpxqWfYQmdGmdjoomPEX4Wk1/yhmL/EYo12YCKalYQVlxfn55oZP/C
         dhI6TANL6nczOCB2s7lD+1UPyuqhmrxDCXdPdhUyhJAjbS6ctTIGnHy/26HdcyFi369w
         QOkyP3ifHKelGXSzkbRETc6s4zE5x0GMLvm3LcSowGe5dmIHEk1m9mnud7OLkWtbcpbg
         cVNnE6R+Y4/tZqrJN7GaZDdv2iEkO2XMtnLOAPLw3fKhK97FW+Xhk08LwuVB0kD8J+tE
         UISw==
X-Gm-Message-State: AOUpUlGjFjfyxmwy2Wr6AUF3IVAfHBzv61pAC+ewDxpfqx7jx6CHFmwV
        h6TQHwqJlIc33InwLCDzZRekJFq9KiJTOabG+2zH5vGsFiT3Pg==
X-Google-Smtp-Source: AAOMgpcKJG50Z0Lc3d8HGGo97wsfAebForJt7e/JyqfClPtoF846kvVxuJM7CTrV5//ItZ2hwLhRXnu4fe56bvh0Yg8=
X-Received: by 2002:a19:3b11:: with SMTP id i17-v6mr12278825lfa.146.1532520176303;
 Wed, 25 Jul 2018 05:02:56 -0700 (PDT)
MIME-Version: 1.0
From:   Ilya Plenne <libbkmz.dev@gmail.com>
Date:   Wed, 25 Jul 2018 15:01:54 +0300
Message-ID: <CAC1xz-R3PEEUdVQ9mONaO+ko=JEUUiO-GzPH4=E4aXWM1n2eKw@mail.gmail.com>
Subject: Why inode number is zero in writeback?
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm researching linux kernel. Right now only for v3.10.61, it's just
proof of concept.

I need to pass-through some hints to hardware about what kind of data
in particular WRITE\READ operation. E.g. read inodes bitmap or write
journal block or write user data or something else...
I'm assuming that at driver level I can reach bio struct from
request_queue struct just for now. For testing purposes I'm using
virtio_blk driver under qemu.

Here what I have done:

1. I've created FS with this command: mkfs.ext4 -b 4096 -E
lazy_itable_init=0,lazy_journal_init=0 -m 0 /dev/vda
2. I've mounted it using this command: mount -o
rw,nosuid,nodev,discard,noauto_da_alloc,data=ordered /dev/vda /mnt
3. Added breakpoint in virtio_blk.c:377 and will skip writes related to journal
4. Execute this dd command: dd if=/dev/urandom of=/mnt/foo2 bs=764 count=34
5. Wait for breakpoint hit and will analyze backtrace under writeback subsystem.

Here is the backtrace:

#0  virtblk_request (q=0x87ab8000) at drivers/block/virtio_blk.c:377
#1  0x801c0b4c in __blk_run_queue_uncond (q=<optimized out>) at
block/blk-core.c:312
#2  __blk_run_queue (q=0x87ab8000) at block/blk-core.c:329
#3  0x801c0c94 in queue_unplugged (q=0x87ab8000, depth=<optimized
out>, from_schedule=<optimized out>) at block/blk-core.c:2920
#4  0x801c3a98 in blk_flush_plug_list (plug=<optimized out>,
from_schedule=false) at block/blk-core.c:3030
#5  0x801c3d9c in blk_finish_plug (plug=0x8785fd8c) at block/blk-core.c:3037
#6  0x80091644 in generic_writepages (mapping=<optimized out>,
wbc=0x8785fde0) at mm/page-writeback.c:1910
#7  0x80092a88 in do_writepages (mapping=<optimized out>,
wbc=<optimized out>) at mm/page-writeback.c:1923
#8  0x800e7084 in __writeback_single_inode (inode=0x8740c290,
wbc=0x8785fde0) at fs/fs-writeback.c:454
#9  0x800e7360 in writeback_sb_inodes (sb=0x87811000, wb=0x87ab81b0,
work=0x8785fea4) at fs/fs-writeback.c:678
#10 0x800e757c in __writeback_inodes_wb (wb=0x1 <__vectors_start>,
work=0x3ff) at fs/fs-writeback.c:723
#11 0x800e7760 in wb_writeback (wb=0x87ab81b0, work=0x8785fea4) at
fs/fs-writeback.c:854
#12 0x800e838c in wb_check_old_data_flush (wb=<optimized out>) at
fs/fs-writeback.c:969
#13 wb_do_writeback (wb=0x87ab81b0, force_wait=0) at fs/fs-writeback.c:1010
#14 0x800e848c in bdi_writeback_workfn (work=0x87ab81bc) at
fs/fs-writeback.c:1040
#15 0x80039d34 in process_one_work (worker=0x87816180,
work=0x87ab81bc) at kernel/workqueue.c:2189
#16 0x8003a40c in worker_thread (__worker=0x1 <__vectors_start>) at
kernel/workqueue.c:2313
#17 0x8003f714 in kthread (_create=0x87845e20) at kernel/kthread.c:200
#18 0x8000dfb8 in ret_from_fork () at arch/arm/kernel/entry-common.S:91

Ok, here we go... At frame #8 we have not optimized inode variable for
inspection:
p (*inode)->i_ino
$7 = 0

Can anyone explain me what this inode is about? Where can I found
information regarding this kind of inodes? And how can I track the
inode number for writeback operations?




PS. That's my first email in linux kernel mailing list... I'm sorry if
I have done something wrong
