Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D623C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EACE206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZ/XAtgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EACE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbeG0DFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:05:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44077 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbeG0DFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:05:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so1598713pls.11;
        Thu, 26 Jul 2018 18:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6OoCU4gvbuZ/lvBw3q96FLsiKMPPZwHaU/oVeaLz6mI=;
        b=sZ/XAtgxTOpEJah47Z76DiVgW4/udL5ej/SuvTjJuFLzTZMmMAhZIle/lXduAaib2t
         BreSv/RO064h3O+kJWP+4toGaINiWnjUNw8ujZk03Pj9LuUWgLLwIeBi/TM8AezUboAF
         eOaBpYXWzPmQRvzTi+n1dhi6e9rM1vMvGNa12cp+YTl6wshtH3SVVjm1bObPnCyQZF2X
         YrR0Ug5vf2+fVay+JaybJfi6eQu4UDGa0xZDO5QDQA3B09Whh1tZeSOLdKcIgXezN4s0
         W51+OKVsaRe86KK7mjdkjNeBIE3DqKbqP9IDYiQBDKRw/a37dTyNanvUdTn5esY6g6S0
         KqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6OoCU4gvbuZ/lvBw3q96FLsiKMPPZwHaU/oVeaLz6mI=;
        b=k8pXYt6dQnEGRqbdrrP1gUwIabHKJU2HjpDUCQ76QcZmGjwwYBNXYuQp4m5LBIGd+w
         +ZMyqr6KOTiQ7c1bycppKB8oIpjRLID7GEXIH6SLkNyfi8AGA8e9MC28MsI2nJg33Y0d
         yy8slYKi0yyjTVebIw/7CeuVXXStHnmoqMe4FE8M8zLbyKAJAJXAfkCUjuRcAHgDRTFe
         yAEi0QVojMTu6Ba1Ka4y4ADNo9lW86QmJbixcLMx8uVMED3Vjc0H85jnklh6SZdf4FOK
         ZDpl5gNepJQpk/MS2nG8z9yBsXAtkSG9MGm9epWHD+RtGN/mIaHZM2j1dyVRFewg9i+s
         lNqQ==
X-Gm-Message-State: AOUpUlFawXPVcHy3ii0MXkDpmS190NoE4djJiwV1+JZp/x13T1cUiIQz
        6cZJk/e3Nte44LK85xusSOY=
X-Google-Smtp-Source: AAOMgpd9CQdJcx6sW84gI6otmUpB/3GhnPBB4/Np2gQL7sfiZY82n2vsyq8hIpROTsmXznjYXiKUYg==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr4077037plb.108.1532655971213;
        Thu, 26 Jul 2018 18:46:11 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id w70-v6sm3448327pgd.18.2018.07.26.18.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 18:46:10 -0700 (PDT)
Date:   Fri, 27 Jul 2018 10:46:06 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     jikos@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lifeasageek@gmail.com, kt0755@gmail.com
Subject: WARNING: possible recursive locking detected
Message-ID: <20180727014606.GA2786@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting the crash: WARNING: possible recursive locking detected

This crash has been found in v4.18 using a modified version of
Syzkaller, which focus on exploring hard-to-reach coverages.

C repro code:
https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/repro-8659a5.c
Kernel config:
https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/config-8659a5

Crash log:
============================================
WARNING: possible recursive locking detected
4.18.0-rc4 #1 Not tainted
--------------------------------------------
kworker/u4:3/1039 is trying to acquire lock:
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: start_flush_work kernel/workqueue.c:2888 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: flush_work+0x316/0x690 kernel/workqueue.c:2917

but task is already holding lock:
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: __write_once_size include/linux/compiler.h:215 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: set_work_data kernel/workqueue.c:617 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: process_one_work+0x857/0x1a30 kernel/workqueue.c:2124

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((wq_completion)"floppy");
  lock((wq_completion)"floppy");

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by kworker/u4:3/1039:
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: __write_once_size include/linux/compiler.h:215 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: 0000000060a8cf4f ((wq_completion)"floppy"){+.+.}, at: process_one_work+0x857/0x1a30 kernel/workqueue.c:2124
 #1: 000000002682ab21 (floppy_work){+.+.}, at: process_one_work+0x88e/0x1a30 kernel/workqueue.c:2128

stack backtrace:
CPU: 0 PID: 1039 Comm: kworker/u4:3 Not tainted 4.18.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: floppy floppy_work_workfn
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x122/0x198 lib/dump_stack.c:113
 print_deadlock_bug kernel/locking/lockdep.c:1765 [inline]
 check_deadlock kernel/locking/lockdep.c:1809 [inline]
 validate_chain kernel/locking/lockdep.c:2405 [inline]
 __lock_acquire+0xfd2/0x39f0 kernel/locking/lockdep.c:3435
 lock_acquire+0x170/0x510 kernel/locking/lockdep.c:3924
 start_flush_work kernel/workqueue.c:2889 [inline]
 flush_work+0x33b/0x690 kernel/workqueue.c:2917
 __cancel_work_timer+0x298/0x3a0 kernel/workqueue.c:2989
 cancel_work_sync+0x1c/0x20 kernel/workqueue.c:3025
 cancel_activity drivers/block/floppy.c:1003 [inline]
 fd_watchdog+0xfe/0x160 drivers/block/floppy.c:1014
 setup_rw_floppy+0x76a/0xa80 drivers/block/floppy.c:1512
 seek_floppy drivers/block/floppy.c:1608 [inline]
 floppy_ready+0x4dd/0x18f0 drivers/block/floppy.c:1920
 floppy_start+0x250/0x2d0 drivers/block/floppy.c:1936
 floppy_work_workfn+0x1a/0x20 drivers/block/floppy.c:977
 process_one_work+0x98d/0x1a30 kernel/workqueue.c:2153
 worker_thread+0x8f/0xcf0 kernel/workqueue.c:2296
 kthread+0x3d5/0x4b0 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
