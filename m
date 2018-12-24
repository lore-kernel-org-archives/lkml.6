Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8731AC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CFA217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545691516;
	bh=iE26Z3EimONb51Thsh/E7y6IZ4ueUjdNBqxYNKcwchc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kklbfNSw9fk+mItNwtiwOkRLIP8lDko3rYny/vH4lUu3cJmf1uU/rszbBK8kQOKsZ
	 pc09j6c0SxZ1r8jClNphQ4NLJC6ooV8+9z1yjfXNZ9eZ8SW5I0f23hPunXYyub1tuP
	 LYfvehsF8KOwXai1chegkeW6L8CKJGyQQHMnGohA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbeLXWpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:45:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35508 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXWpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:45:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so12609670wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gl6Y/elZ4BndNa/PvtotNl3UENnbeY0A1lVsqYcHJCw=;
        b=bRja+VhP20G5wgOIpDuIta7yRzmJbOrwX3TpF5Fy4Lh4NQDQwdNvHHmA46qDIHPY85
         kQtCgBOEqO+2+GExZZqfdUgslyeVpgfWqONdxOcnaQIhSqUDAT2GdqTD1fMLxbNpb87g
         RzSXnGZWpRR/uBn9ueUbqSaYxTFizZGCzmZYCSjVIIuRdijjABxQC0QtlcGoS10ZxPiB
         VXiTvk90R8ZV1Hm2/7RC1xl0ouY9Jekgq//eelKu9txXI351ZSuGSjuIkez8H6Xon2N+
         YmOJf7GPknQfM40ebgn5ybP8KE6q9PZYJdNbx7CeaSwIPd35P9220skpWjnffZbvB2YM
         iDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=gl6Y/elZ4BndNa/PvtotNl3UENnbeY0A1lVsqYcHJCw=;
        b=nIlzTPnA8ZcZrCUUtY4XJ6JTVidrvDh+mIfSWBZQnXLGM5jx3LLLbCMgFrmuSymMt5
         GfSiL4CxYEiAYrwFUHelbod8bXHbRUoRjtls+SCp0yPiWRLZapqPo3dnIKDB3q9JFF62
         TPNBhg1wTufNZW2fWOnyPpaY1GKMap30y5Cpm0Q/CUVEZf+N2vObYJeYetL9b3CwgHTg
         YkLQ+gMeE0Wd9fmdMzRfo6awxKhmXorTdrGLXxSpNB5xJt5LxyzLSO+mHIdRhKVhl21Q
         DgEky9l7gg+IzCDpYolCc4Q5hWVYSX2GRh1w+xRE/BAHO4PIgIBr83svklTDEbBy3qnM
         VrPg==
X-Gm-Message-State: AJcUukc7bH09DBe2BCSE7SRDs1l069dbLVqM8A+va95LDJpYcvC2RK/k
        yIuEK8VDgL7bjS21huhhoMo=
X-Google-Smtp-Source: ALg8bN6MpIN582pu0M4g1xMOfXfKwWinUaTIy4k3AADGGnaPNMGiuK/TlFWiBanez/CmFENtnWb6OQ==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr13195397wrd.294.1545691512523;
        Mon, 24 Dec 2018 14:45:12 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d16sm16206675wru.52.2018.12.24.14.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 14:45:11 -0800 (PST)
Date:   Mon, 24 Dec 2018 23:45:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler changes for v4.21
Message-ID: <20181224224509.GA67077@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

   # HEAD: 732cd75b8c920d3727e69957b14faa7c2d7c3b75 sched/fair: Select an energy-efficient CPU on task wake-up

The main changes in this cycle were:

 - Introduce "Energy Aware Scheduling" - by Quentin Perret. This is a 
   coherent topology description of CPUs in cooperation with the PM 
   subsystem, with the goal to schedule more energy-efficiently on 
   assymetric SMP platform - such as waking up tasks to the more 
   energy-efficient CPUs first, as long as the system isn't 
   oversubscribed.

   For details of the design, see:

      https://marc.info/?l=linux-kernel&m=153243513908731&w=2

 - Misc cleanups and smaller enhancements.

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      sched: Fix various typos in comments

Morten Rasmussen (1):
      sched/fair: Add over-utilization/tipping point indicator

Muchun Song (2):
      sched/core: Introduce set_next_task() helper for better code readability
      sched/fair: Make some variables static

Patrick Bellasi (2):
      sched/fair: Mask UTIL_AVG_UNCHANGED usages
      sched/fair: Add lsub_positive() and use it consistently

Quentin Perret (11):
      sched/topology: Relocate arch_scale_cpu_capacity() to the internal header
      sched/cpufreq: Prepare schedutil for Energy Aware Scheduling
      PM: Introduce an Energy Model management framework
      sched/topology: Reference the Energy Model of CPUs when available
      sched/topology: Add lowest CPU asymmetry sched_domain level pointer
      sched/topology: Disable EAS on inappropriate platforms
      sched/topology: Make Energy Aware Scheduling depend on schedutil
      sched/toplogy: Introduce the 'sched_energy_present' static key
      sched/fair: Clean-up update_sg_lb_stats parameters
      sched/fair: Introduce an energy estimation helper function
      sched/fair: Select an energy-efficient CPU on task wake-up

Valentin Schneider (2):
      sched/fair: Clean up load_balance() condition
      sched/fair: Don't increase sd->balance_interval on newidle balance

Vincent Guittot (1):
      sched/topology: Remove the ::smt_gain field from 'struct sched_domain'

Viresh Kumar (2):
      sched/core: Create task_has_idle_policy() helper
      sched/core: Clean up the #ifdef block in add_nr_running()

Yangtao Li (1):
      sched/core: Remove unnecessary unlikely() in push_*_task()


 drivers/cpufreq/cpufreq.c        |   1 +
 include/linux/cpufreq.h          |   8 +
 include/linux/energy_model.h     | 187 +++++++++++++++++++
 include/linux/sched.h            |   4 +-
 include/linux/sched/cpufreq.h    |   6 +
 include/linux/sched/isolation.h  |   4 +-
 include/linux/sched/mm.h         |   2 +-
 include/linux/sched/stat.h       |   2 +-
 include/linux/sched/topology.h   |  17 +-
 kernel/power/Kconfig             |  15 ++
 kernel/power/Makefile            |   2 +
 kernel/power/energy_model.c      | 201 ++++++++++++++++++++
 kernel/sched/core.c              |   6 +-
 kernel/sched/cpufreq_schedutil.c |  90 +++++++--
 kernel/sched/cputime.c           |   2 +-
 kernel/sched/deadline.c          |  25 ++-
 kernel/sched/debug.c             |   2 +-
 kernel/sched/fair.c              | 385 +++++++++++++++++++++++++++++++++------
 kernel/sched/isolation.c         |  14 +-
 kernel/sched/rt.c                |  28 ++-
 kernel/sched/sched.h             |  97 +++++++---
 kernel/sched/topology.c          | 231 ++++++++++++++++++++++-
 22 files changed, 1179 insertions(+), 150 deletions(-)
 create mode 100644 include/linux/energy_model.h
 create mode 100644 kernel/power/energy_model.c
