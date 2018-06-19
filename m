Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883E3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328A420836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZTeUUAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328A420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757195AbeFSLxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:53:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42752 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756535AbeFSLxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:53:52 -0400
Received: by mail-pl0-f67.google.com with SMTP id w17-v6so10837964pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 04:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GjrXQNm7sE+Qpnzqr/skk5TQjXw/nERfYNVAgoE2BIs=;
        b=aZTeUUAZJznfJw0XiFT6KNxxGmiEuKhrCGNRh4lv0ThiSCGRT66UePCfkl1Bq/4kTh
         IHTKqq+4TKlfndFp5muzInt4ofMAk6OC0EwF28jaFbWe2NQW2XJ+55tgJVtYONPaL4Mv
         kV0UfLk+6Tw5PIxFJq0olSvRgU2sDDPGKr2StJJpErO5qjGAZkFK4JF1rxKoO6HlH0W0
         I+i+/FRdvpxnVaDli2ja6LQDeUIR0QiU9jxzwsSWdDZpBHSitp2hexzu2u8OIZ05I9ps
         X1nGCbmuupKuHHkE3AELhGEkxiwKcgjNrnNjLfFv2mzxP22NmpQ0uMSjmHYzB7hNyLpq
         OF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GjrXQNm7sE+Qpnzqr/skk5TQjXw/nERfYNVAgoE2BIs=;
        b=fobDk6SReuQmhByr3+XobNitn/nbs/3/sFM8lnazmcmzHUQL9t8tkSQet4aNUngpB3
         TxRn86OUELlb5Cmy4T1DiN+1LmfWwX85e5Fn/P6zO59KdO8uyA5KzkEM2ogT1Woub+rm
         auB7ZQLOimBqaUgvzBa1ncx5gJGdiYQlm9EvvZDgv8vRxbvruoPGAdAgMeicsY9GTb3Q
         hhY7ziEXIf/bY4bl+UMIIAuI7oC6Y9kOYKyaJVPpyCbVTW/21UvLt4h7Kbgj2jNMeFML
         PS8YxFdbhuFcO6k8UvNR+rt+hmIkOf11T0h+q3jpLbSbae7wqsabTY/rHFdSMeZbar9l
         doXg==
X-Gm-Message-State: APt69E0nOQrSWv+lTOPElpjX/U66VMWLU6IeCta/6JzFp3aMf3HrkPDL
        W6yvoeuidsWPjq0asWJPXfFwlj2/XuEkI2l97muv4Q==
X-Google-Smtp-Source: ADUXVKKPo071xtAJlqCmMXd/BrKN+73KvyVqm8zzIk5gfNtxXx3PiL0c8zX8384+aFfXyXGe0IWTXr7ItSPg3L0WaWc=
X-Received: by 2002:a17:902:8491:: with SMTP id c17-v6mr18355388plo.97.1529409232104;
 Tue, 19 Jun 2018 04:53:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 19 Jun 2018 04:53:31
 -0700 (PDT)
In-Reply-To: <a274f8ff-989a-ccb8-3cc1-78fbdec0604a@I-love.SAKURA.ne.jp>
References: <001a113ed5540f411c0568cc8418@google.com> <a274f8ff-989a-ccb8-3cc1-78fbdec0604a@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Jun 2018 13:53:31 +0200
Message-ID: <CACT4Y+ZJTHfFOcbReD_nOYxvxaYcD2Sa=VToZL0RWYw1TemrPA@mail.gmail.com>
Subject: Re: INFO: task hung in __get_super
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 1:44 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> This bug report is getting no feedback, but I guess that this bug is in
> block or mm or locking layer rather than fs layer.
>
> NMI backtrace for this bug tends to report that sb_bread() from fill_super()
>  from mount_bdev() is stalling is the cause of keep holding s_umount_key for
> more than 120 seconds. What is strange is that NMI backtrace for this bug tends
> to point at rcu_read_lock()/pagecache_get_page()/radix_tree_deref_slot()/
> rcu_read_unlock() which is expected not to stall.
>
> Since CONFIG_RCU_CPU_STALL_TIMEOUT is set to 120 (and actually +5 due to
> CONFIG_PROVE_RCU=y) which is longer than CONFIG_DEFAULT_HUNG_TASK_TIMEOUT,
> maybe setting CONFIG_RCU_CPU_STALL_TIMEOUT to smaller values (e.g. 25) can
> give us some hints...

If an rcu stall is the true root cause of this, then I guess would see
"rcu stall" bug too. Rcu stall is detected after 120 seconds, but task
hang after 120-240 seconds. So rcu stall has much higher chances to be
detected. Do you see the corresponding "rcu stall" bug?

But, yes, we need to tune all timeouts. There is
https://github.com/google/syzkaller/issues/516 for this.
We also need "kernel/hung_task.c: allow to set checking interval
separately from timeout" to be merged:
https://groups.google.com/forum/#!topic/syzkaller/rOr3WBE-POY
as currently it's very hard to tune task hung timeout. But maybe we
will need similar patches for other watchdogs too if they have the
same problem.
