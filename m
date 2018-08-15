Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06586C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDE92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McIMlyn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDE92146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeHOWxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:53:36 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:37201 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeHOWxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:53:36 -0400
Received: by mail-it0-f42.google.com with SMTP id h20-v6so3576390itf.2;
        Wed, 15 Aug 2018 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SkjWjVnLNZVZiv8Pu7OMsqt9oozmDAl2VHB9l8rhyo0=;
        b=McIMlyn7rCTQG2bXQhnlO0fJKGUEgyO8FllRA0wVUt/amRIvOnkrEt9kAmxs1i9GkN
         MRuaRyQDcPaG2QKrBwS7OqWcKjoIxDp1IfwLOrZrh2AN5+soQNP8gSgyE2n04lICdT2D
         ZRZBwwfwyPSvarccS84AQCw/wv1Hxr27+bnKZvX3p2dwvRR5BSRfPHsb1thOaxdxag4b
         FVNAnajPvR7LmYGvd/F1RvbgBKt6RYE5y5oPvhtFhCDIhlJu8bcioc2oiKCtczfnqeKv
         Rwtt6XFWXAfjAdBw1/xwAzDdQ48Cekfu8JZr8Iq94ymEbtH6OZG1C/rGUjRYIlGFffZR
         5AJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SkjWjVnLNZVZiv8Pu7OMsqt9oozmDAl2VHB9l8rhyo0=;
        b=tHQXyrKmX4SkJKIrhXxV/UhQ4G+geo6VosX2xYIS0Rnw5Mk8AT4Ty43kvWGfNNAusq
         HXa36K63LxomM5T2UlLmF/xcDPtkCz7tjwdl3L6x8wn81kJrA7vHiCTX6pdrAKYErHx9
         /Kbhr8bTdIQOP4wrSJj1QR2iVBP4uEkbL/TOm1K0LNzdT6VcpILM+kyJspHpCFFLdNpL
         1N/ZWf38w9cu43eNWZ7M4GfRtVDjkvGMi8JYCtXtfTMYSY9NMy4o/0JOypzXF2DFT3gi
         ZRrCmfoZuTSvUcDMMEibQ1LcUnpo/P9JJ+yRZJKeVttUSy7lqr2QfJkugMoAdJ2iyfja
         nj3w==
X-Gm-Message-State: AOUpUlEg5oWy9D7OlOxPJ/XDc+gFEOrDl1wrH9KpOt3LSBsp3SG0TJlP
        nXsXqANjBfwDjBQfGfSey38/K6UYf8OjXsuWUGXKQJ7K
X-Google-Smtp-Source: AA+uWPwxkAigur65yNL3F3ssCnNxsHytOwm+nmmm/d/zfpPVMSb9/vDoIvK8veWGQrxjYfPnSI5vywlVnt7slk3Dkio=
X-Received: by 2002:a24:6c8a:: with SMTP id w132-v6mr19551160itb.141.1534363200149;
 Wed, 15 Aug 2018 13:00:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:3a18:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 12:59:59
 -0700 (PDT)
From:   Debabrata Banerjee <dbavatar@gmail.com>
Date:   Wed, 15 Aug 2018 15:59:59 -0400
Message-ID: <CAATkVEwKyUHWktL5PZ7Dqry_DQk9XSXzFg0s24XcUT2ftm=ZSA@mail.gmail.com>
Subject: deadlock in wbt_wait()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I've found a problem with wbt code, appears like when
switching elevators any blk requests that got throttled never wake up
after the change. You can easily reproduce this by running some dd
writers, and then switching between noop and cfq repeatedly. You
should get a hung dd task with a stack similar to what's below.
Attempting a patch to wake up waiters during a change, but nothing
working yet. Confused by why we're calling wbt_disable_default(q) in
cfq/bfq elevators only, as opposed to something generically from
elevator_switch() (looking at 4.14.59).

[<ffffffff82095632>] io_schedule+0x12/0x40
[<ffffffff823a7b47>] wbt_wait+0x1a7/0x360
[<ffffffff82374c49>] blk_queue_bio+0xf9/0x3e0
[<ffffffff82373050>] generic_make_request+0x100/0x280
[<ffffffff8237323c>] submit_bio+0x6c/0x140
[<ffffffffa01d8b88>] ext4_io_submit+0x48/0x60 [ext4]
[<ffffffffa01c098f>] ext4_writepages+0x68f/0xe40 [ext4]
[<ffffffff821782aa>] do_writepages+0x1a/0x60
[<ffffffff8216a1c7>] __filemap_fdatawrite_range+0xa7/0xe0
[<ffffffffa01af8e2>] ext4_release_file+0x72/0xc0 [ext4]
[<ffffffff821ee5e5>] __fput+0xa5/0x220
[<ffffffff820880a0>] task_work_run+0x80/0xa0
[<ffffffff820016e0>] exit_to_usermode_loop+0xb0/0xc0
[<ffffffff82001d24>] do_syscall_64+0x104/0x120
[<ffffffff82800081>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[<ffffffffffffffff>] 0xffffffffffffffff

Actually if I run this test enough times sometimes I get a panic, I
assume that's due to some disk completion arriving in the wrong place,
maybe not related to wbt.

[  804.546000] RIP: 0010:run_timer_softirq+0xf2/0x1d0
[  804.551163] RSP: 0018:ffff88105f443f00 EFLAGS: 00010002
[  804.556753] RAX: 00000001003e0002 RBX: ffff88085782de90 RCX: ffff88085782de90
[  804.564269] RDX: ffff88105f443f00 RSI: ffff88105f4596a8 RDI: ffff88105f443f08
[  804.571781] RBP: 0000000000000000 R08: ffff88105f459958 R09: ffff88105f443f08
[  804.579297] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88105f459680
[  804.586819] R13: ffff88105f443f00 R14: 0000000000000000 R15: ffff88105f4596f0
[  804.594314] FS:  0000000000000000(0000) GS:ffff88105f440000(0000)
knlGS:0000000000000000
[  804.603102] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  804.609196] CR2: 00000001003e000a CR3: 000000000300a001 CR4: 00000000001606e0
[  804.616684] Call Trace:
[  804.619520]  <IRQ>
[  804.621913]  ? timerqueue_add+0x54/0x80
[  804.626105]  ? enqueue_hrtimer+0x38/0x90
[  804.630379]  __do_softirq+0xf1/0x296
[  804.634323]  irq_exit+0x76/0x80
[  804.637830]  smp_apic_timer_interrupt+0x70/0x130
[  804.642827]  apic_timer_interrupt+0x7d/0x90
[  804.647379]  </IRQ>
