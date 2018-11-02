Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAFAC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9609D2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kbEl8Ad6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9609D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeKBLFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 07:05:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44219 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeKBLFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 07:05:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id j13-v6so232947pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 19:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6ckdBY9QdiiV4QgcZZwzAy2V1WxPeL7xdb+J5A2C1HA=;
        b=kbEl8Ad69GQVITfWsVfjWwCqBCiZ2viJUUpOpEtTUgybnGiOB5s3Li37zOzX0onnHT
         CC3s7jycsdOMXrn2iK+0OoPV/N07oT1Aa9a35A95bR09RXcYqhCUObROWYdy/gmGZLak
         5ecC+XU3DP2imWXANGql8sjg3DWzFLI7pzUKys4SyRM/dYQf67c37WpGCbLEaJK8dGnP
         7y0cHTZe83+41788xGLO19lIVic8VKzBCFB2zzyLivAjiYBiGsrLAWwxNn9XNGkpLudy
         x6U6ot8PLEPFNUbG9ZOm64VDjnxXtl/Cy8wp0B6NlCenoxCuKF60/hodlPDOetzoci+n
         v84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ckdBY9QdiiV4QgcZZwzAy2V1WxPeL7xdb+J5A2C1HA=;
        b=dCITMYf3MM+0jN27HtqSOwhbEytA2gekTzY5wqiyoUWKfGnb7uvXTCd/prvXQKskFa
         bSd3ZCRlvwlVx6CWZBbdZ1LJInlpnbJneQ5RpPTPB1HLp3enTv45r4qseWdd2Rjo3KYM
         lZ0jhSTlX6iPFAIwG63kAdONDepy0npiN3OoVZJbdYU6qajWrbUBfTLczWZkOAqc1ZFg
         h4BgU5cPiKSrGDeZAlii4GtPVH5IHapv+tPzSNWRZm+bK1l2xaid5y/sR88xrYQsS2cy
         W+zeUntGRELvAV9sDnwAi3qeGNXqWPYWPi53j9SvoBJFZweDi7C4BG23A8ogKFYIISGf
         TtRw==
X-Gm-Message-State: AGRZ1gLdakIy58/hfV9iids0mGv+8JYMPZVWZT0fVCvH27JgLWY0JURq
        T55m+IGQarJzGhMj4NJDQ/iC0A==
X-Google-Smtp-Source: AJdET5cOWHehd37epdqC5LIU4QjsB7Feb93IBW8kaH74xByGCIEO4yfIWZeVGZEaoQHNXSGCxfCjSg==
X-Received: by 2002:a62:198c:: with SMTP id 134-v6mr2964855pfz.33.1541124019944;
        Thu, 01 Nov 2018 19:00:19 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c70-v6sm12395085pfg.97.2018.11.01.19.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 19:00:18 -0700 (PDT)
Subject: Re: [LKP] a518560778 [ 16.132179] BUG: KASAN: null-ptr-deref in
 brd_alloc
To:     Ming Lei <ming.lei@redhat.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
References: <20181102001957.GE24195@shao2-debian>
 <20181102005344.GD24769@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de15243e-1ee4-f17b-34f5-5901ce11b5da@kernel.dk>
Date:   Thu, 1 Nov 2018 20:00:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102005344.GD24769@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/18 6:53 PM, Ming Lei wrote:
> On Fri, Nov 02, 2018 at 08:19:57AM +0800, kernel test robot wrote:
>> Greetings,
>>
>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-linus
>>
>> commit a5185607787e030fcb0009194d3b12f8bcca59d6
>> Author:     Ming Lei <ming.lei@redhat.com>
>> AuthorDate: Wed Oct 31 16:40:50 2018 +0800
>> Commit:     Jens Axboe <axboe@kernel.dk>
>> CommitDate: Wed Oct 31 08:43:09 2018 -0600
>>
>>     block: brd: associate with queue until adding disk
>>     
>>     brd_free() may be called in failure path on one brd instance without
>>     the disk being added yet, so release handler of gendisk may free the
>>     associated request_queue early and cause the following use-after-free[1].
>>     
>>     This patch fixes this issue by associating gendisk with request_queue
>>     just before adding disk.
>>     
>>     [1] KASAN: use-after-free Read in del_timer_syncNon-volatile memory driver v1.3
>>     Linux agpgart interface v0.103
>>     [drm] Initialized vgem 1.0.0 20120112 for virtual device on minor 0
>>     usbcore: registered new interface driver udl
>>     ==================================================================
>>     BUG: KASAN: use-after-free in __lock_acquire+0x36d9/0x4c20
>>     kernel/locking/lockdep.c:3218
>>     Read of size 8 at addr ffff8801d1b6b540 by task swapper/0/1
>>     
>>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0+ #88
>>     Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>     Google 01/01/2011
>>     Call Trace:
>>       __dump_stack lib/dump_stack.c:77 [inline]
>>       dump_stack+0x244/0x39d lib/dump_stack.c:113
>>       print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
>>       kasan_report_error mm/kasan/report.c:354 [inline]
>>       kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
>>       __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>>       __lock_acquire+0x36d9/0x4c20 kernel/locking/lockdep.c:3218
>>       lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
>>       del_timer_sync+0xb7/0x270 kernel/time/timer.c:1283
>>       blk_cleanup_queue+0x413/0x710 block/blk-core.c:809
>>       brd_free+0x5d/0x71 drivers/block/brd.c:422
>>       brd_init+0x2eb/0x393 drivers/block/brd.c:518
>>       do_one_initcall+0x145/0x957 init/main.c:890
>>       do_initcall_level init/main.c:958 [inline]
>>       do_initcalls init/main.c:966 [inline]
>>       do_basic_setup init/main.c:984 [inline]
>>       kernel_init_freeable+0x5c6/0x6b9 init/main.c:1148
>>       kernel_init+0x11/0x1ae init/main.c:1068
>>       ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:350
>>     
>>     Reported-by: syzbot+3701447012fe951dabb2@syzkaller.appspotmail.com
>>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Sorry, my fault.
> 
> Jens, I just sent you V2 which fixes this issue, could you drop V1 from
> your for-linus and apply V2 against it?

Just did, dropped v1 and added v2 instead.

-- 
Jens Axboe

