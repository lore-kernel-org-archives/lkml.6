Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE554C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DD320840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="pESG6EOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DD320840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeKITrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:47:48 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40258 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbeKITrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:47:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so909518lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=KzX024M40PbC6BUh7TovZhJtomkbtGDXgz8VhHi+56E=;
        b=pESG6EOJSA29bvX2rkY3UE3LgYqi4hzlUj9fRnFyYaKmhbGhzocc2kdYDKq2+UDz5U
         XCV5LsO4vejjfqu7kb/8UtLaOLpu0Y9FjrrtFlCrA2I+CK6JRRFadkjGzr4rX/ykGMea
         KwTWypYFUgkWZn3WhaEe5Xzz15UHp97IPBV9Sl4xIpc3/IZeHddf2fEIrTjkl71ecRIy
         d85ymko3dPdoOaZZiU5kzODd7JWzKsfQDCi0FwbY9KmTaUnmjgkv54lWyAciq2uyqNb5
         X5VWVmOZXto5y+BzopkunIbJqmAI1TZ/RFLLP11b1TtNlh7a01/yzZhidJUmJx9q+t08
         k2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KzX024M40PbC6BUh7TovZhJtomkbtGDXgz8VhHi+56E=;
        b=EZz3LzcQs/I39gQHd9qE9/9ccy7CmRrx5rotHXDonYKxGvd1m/J4FXq0I08v0K4tg4
         ikT1U2Lop2X1tXgQ7ZZh1fOaKxMzaf3CfG/PU0xu14JrruPGuoq4oH3xfa+iHMBX/2vF
         UjmrgMRdGvRzKytK0jdXG23n4B2BlpyzyYTnOOJcBWMYTWplJcb8+4cXnJraT/IS/+Is
         4an58N8d1EdI+4FZC7/ejae2xbrwDOLuPaofrhFOiMhKhjMhOldbUnkFGRoCwgM6PmOd
         /O798+09q7EIeUv16/BlIEIJwC3mPh6oRigsMf8h+HzDFryL9u61cg69U2HIS3pdn7TR
         TTwg==
X-Gm-Message-State: AGRZ1gKJnGFA+KKReCXg9mphiMKhUxQq21HFhCOl/8tfuRCsK5jMcohr
        5fFHZLOf+LRGpP1s1Oa356wIjIG0miAVEA==
X-Google-Smtp-Source: AJdET5flwKWAVIwY5fkFfvm+cSyjN1xVs4jf1uJSDYI8ukqbqjNslbeek0em5rC781MdduI8JRRWtQ==
X-Received: by 2002:a19:ca51:: with SMTP id h17mr4645108lfj.126.1541758072105;
        Fri, 09 Nov 2018 02:07:52 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:07:51 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>
Subject: [PATCH 00/17] Backport rt/deadline crash and the ardous story of FUTEX_UNLOCK_PI to 4.4
Date:   Fri,  9 Nov 2018 11:07:28 +0100
Message-Id: <1541758065-10952-1-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Austad <haustad@cisco.com>

Short story:

The following patches are needed on a 4.4 kernel to avoid
Oops in the scheduler when a sched_rr and sched_deadline task contends
on the same futex (with PI).

Longer story:

On one of our arm64 systems, we occasionally crash with an Oops in the
scheduler with the following backtrace.

[<ffffffc0000ee398>] enqueue_task_dl+0x1f0/0x420
[<ffffffc0000d0f14>] activate_task+0x7c/0x90
[<ffffffc0000edbdc>] push_dl_task+0x164/0x1c8
[<ffffffc0000edc60>] push_dl_tasks+0x20/0x30
[<ffffffc0000cc00c>] __balance_callback+0x44/0x68
[<ffffffc000d2c018>] __schedule+0x6f0/0x728
[<ffffffc000d2c278>] schedule+0x78/0x98
[<ffffffc000d2e76c>] __rt_mutex_slowlock+0x9c/0x108
[<ffffffc000d2e9d0>] rt_mutex_slowlock+0xd8/0x198
[<ffffffc0000f7f28>] rt_mutex_timed_futex_lock+0x30/0x40
[<ffffffc00012c1a8>] futex_lock_pi+0x200/0x3b0
[<ffffffc00012cf84>] do_futex+0x1c4/0x550
[<ffffffc00012d92c>] compat_SyS_futex+0x10c/0x138
[<ffffffc00008504c>] __sys_trace_return+0x0/0x4

This seems to be the same bug Xuneli Pang triggered and fixed in
e96a7705e7d3 "sched/rtmutex/deadline: Fix a PI crash for deadline
tasks". As noted by Peter Zijlstra in the previous attempt, this fix
requires a few other patches, most notably the FUTEX_UNLOCK_PI series
[1]

Testing this on a dual-core VM I have not been able to reproduce the
same crash, but pi_stress (part of the rt-test suite) reveals that
vanilla 4.4.162 behaves rather badly with a mix of deadline and
sched_(rr|fifo) tasks:

time pi_stress --rr --mlockall --sched id=high,policy=deadline,runtime=100000,deadline=200000,period=200000
Starting PI Stress Test
Number of thread groups: 1
Duration of test run: infinite
Number of inversions per group: unlimited
     Admin thread SCHED_RR priority 4
1 groups of 3 threads will be created
      High thread SCHED_DEADLINE runtime 100000 deadline 200000 period 200000
       Med thread SCHED_RR priority 2
       Low thread SCHED_RR priority 1
Current Inversions: 141627
WATCHDOG triggered: group 0 is deadlocked!
reporter stopping due to watchdog event
Stopping test
Terminated

real    0m26.291s
user    0m0.148s
sys     0m18.819s

With this series applied, the test ran for ~4.5 hours and again for 129
minutes (when I remembered to time it) before crashing:

time pi_stress --rr --mlockall --sched id=high,policy=deadline,runtime=100000,deadline=200000,period=200000
Starting PI Stress Test
Number of thread groups: 1
Duration of test run: infinite
Number of inversions per group: unlimited
     Admin thread SCHED_RR priority 4
1 groups of 3 threads will be created
      High thread SCHED_DEADLINE runtime 100000 deadline 200000 period 200000
       Med thread SCHED_RR priority 2
       Low thread SCHED_RR priority 1
Current Inversions: 51985223
WATCHDOG triggered: group 0 is deadlocked!
reporter stopping due to watchdog event
Stopping test
Terminated

real    129m38.807s
user    0m59.084s
sys     109m53.666s


So clearly not perfect, but a *lot* better.

The same series on our vendor-4.4 kernel moves pi_stress up from ~30
seconds before deadlock up to the same level as the VM (the test is
still going as of this writing).

I suspect other users of 4.4 would benefit from having these patches
backported, so tag them for stable. I assume 4.9 and 4.14 could benefit
as well, but I have not had time to look into those.

1) https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1359667.html

Peter Zijlstra (13):
  futex: Cleanup variable names for futex_top_waiter()
  futex: Use smp_store_release() in mark_wake_futex()
  futex: Remove rt_mutex_deadlock_account_*()
  futex,rt_mutex: Provide futex specific rt_mutex API
  futex: Change locking rules
  futex: Cleanup refcounting
  futex: Rework inconsistent rt_mutex/futex_q state
  futex: Pull rt_mutex_futex_unlock() out from under hb->lock
  futex,rt_mutex: Introduce rt_mutex_init_waiter()
  futex,rt_mutex: Restructure rt_mutex_finish_proxy_lock()
  futex: Rework futex_lock_pi() to use rt_mutex_*_proxy_lock()
  futex: Futex_unlock_pi() determinism
  futex: Drop hb->lock before enqueueing on the rtmutex

Thomas Gleixner (2):
  rtmutex: Make wait_lock irq safe
  futex: Rename free_pi_state() to put_pi_state()

Xunlei Pang (2):
  rtmutex: Deboost before waking up the top waiter
  sched/rtmutex/deadline: Fix a PI crash for deadline tasks

 include/linux/init_task.h       |   1 +
 include/linux/sched.h           |   2 +
 include/linux/sched/rt.h        |   1 +
 kernel/fork.c                   |   1 +
 kernel/futex.c                  | 532 ++++++++++++++++++++++++++--------------
 kernel/locking/rtmutex-debug.c  |   9 -
 kernel/locking/rtmutex-debug.h  |   3 -
 kernel/locking/rtmutex.c        | 406 ++++++++++++++++++------------
 kernel/locking/rtmutex.h        |   2 -
 kernel/locking/rtmutex_common.h |  24 +-
 kernel/sched/core.c             |   2 +
 11 files changed, 620 insertions(+), 363 deletions(-)

-- 
2.7.4

