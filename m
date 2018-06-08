Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +L1OACZyGlvlPgAAmS7hNA
	; Fri, 08 Jun 2018 12:10:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DA77C607E4; Fri,  8 Jun 2018 12:10:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DB8nxl3M"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2731B60290;
	Fri,  8 Jun 2018 12:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2731B60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeFHMKL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:10:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50765 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeFHMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:10:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so2957180wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vbhgMfzpfyXqpeuKcH2hfSW0FIaUSCWC2+g0Qhxz8Ac=;
        b=DB8nxl3MF9ah4NNbEP88TImGgEDsi/0Jf0YBtGLQxZyaU1E2g0UsbRhi6WN73hZUvd
         WNZjtsY1lPp1LVDC56ERXMbwgcUCASI2RB1iFNPJ0/Qft9T4zFza4gAHr4ALHiodUmai
         of7qJBmy7tX1mi67mLvfQgPdwnyLCKfeKJBbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vbhgMfzpfyXqpeuKcH2hfSW0FIaUSCWC2+g0Qhxz8Ac=;
        b=gHRLZC2rt5eUp+0fe9IIVfyxpmDcM4OrgMQspBdx/JbmMj+BgLx9LvJoLPlEUCMpSL
         KP+QD8+xLdWgPRcbx5Fi6g6N79/ZcowqmVOXs7hz6nDLM2uoeapor4Pzbn3V5VjgFUct
         AmhFZieLc5D0UlVCmoOL2EF6NpJ/TTYDXx05O7m80qxhfDvZXoRmqtRrYY9AgMeHyMds
         ioIntDwHhhnxnJ82/FkypRNI9vnFgLjoeZ7Rx7Wy+qMLopcmB4jqw7v1aWYxrtWhsGR/
         hjmoNxe5pg2mEicDEBMg+mTT9UzBhsT1LW9CnY41D3M2/uSjuqY3MV6sQTUI4rqCbVGU
         4Z4A==
X-Gm-Message-State: APt69E29nU+6xFneRxv8m3a0MQzBum9EOUz8H6AEuEt8OPpFmDxWFgWo
        PA3OxkepC4q1evGsKIW52XYB1w==
X-Google-Smtp-Source: ADUXVKJtK3xTP93GNc+YYkIFot7fT8F0VFIaw2BncP3UwckqjL19k0Uh5Wd/mMmZyIPq3wVKUofSxg==
X-Received: by 2002:a1c:c241:: with SMTP id s62-v6mr1508597wmf.112.1528459808213;
        Fri, 08 Jun 2018 05:10:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c67:7ea:9f4d:8968])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1546003wmh.22.2018.06.08.05.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 05:10:07 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 00/11] track CPU utilization
Date: Fri,  8 Jun 2018 14:09:43 +0200
Message-Id: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset initially tracked only the utilization of RT rq. During
OSPM summit, it has been discussed the opportunity to extend it in order
to get an estimate of the utilization of the CPU.

- Patches 1,2 move pelt code in a dedicated file and remove some blank lines
  
- Patches 3-4 add utilization tracking for rt_rq.

When both cfs and rt tasks compete to run on a CPU, we can see some frequency
drops with schedutil governor. In such case, the cfs_rq's utilization doesn't
reflect anymore the utilization of cfs tasks but only the remaining part that
is not used by rt tasks. We should monitor the stolen utilization and take
it into account when selecting OPP. This patchset doesn't change the OPP
selection policy for RT tasks but only for CFS tasks

A rt-app use case which creates an always running cfs thread and a rt threads
that wakes up periodically with both threads pinned on same CPU, show lot of 
frequency switches of the CPU whereas the CPU never goes idles during the 
test. I can share the json file that I used for the test if someone is
interested in.

For a 15 seconds long test on a hikey 6220 (octo core cortex A53 platfrom),
the cpufreq statistics outputs (stats are reset just before the test) : 
$ cat /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans
without patchset : 1230
with patchset : 14

If we replace the cfs thread of rt-app by a sysbench cpu test, we can see
performance improvements:

- Without patchset :
Test execution summary:
    total time:                          15.0009s
    total number of events:              4903
    total time taken by event execution: 14.9972
    per-request statistics:
         min:                                  1.23ms
         avg:                                  3.06ms
         max:                                 13.16ms
         approx.  95 percentile:              12.73ms

Threads fairness:
    events (avg/stddev):           4903.0000/0.00
    execution time (avg/stddev):   14.9972/0.00

- With patchset:
Test execution summary:
    total time:                          15.0014s
    total number of events:              7694
    total time taken by event execution: 14.9979
    per-request statistics:
         min:                                  1.23ms
         avg:                                  1.95ms
         max:                                 10.49ms
         approx.  95 percentile:              10.39ms

Threads fairness:
    events (avg/stddev):           7694.0000/0.00
    execution time (avg/stddev):   14.9979/0.00

The performance improvement is 56% for this use case.

- Patches 5-6 add utilization tracking for dl_rq in order to solve similar
  problem as with rt_rq. Nevertheless, we keep using dl bandwidth as default
  level of requirement for dl tasks. The dl utilization is used to check that
  the CPU is not overloaded which is not always reflected when using dl
  bandwidth

- Patches 7-8 add utilization tracking for interrupt and use it select OPP
  A test with iperf on hikey 6220 gives: 
    w/o patchset	    w/ patchset
    Tx 276 Mbits/sec        304 Mbits/sec +10%
    Rx 299 Mbits/sec        328 Mbits/sec +09%
    
    8 iterations of iperf -c server_address -r -t 5
    stdev is lower than 1%
    Only WFI idle state is enable (shallowest arm idle state)

- Patches 9 uses rt, dl and interrupt utilization in the scale_rt_capacity()
  and remove  the use of sched_rt_avg_update.

- Patches 10 removes the unused sched_avg_update code

- Patch 11 removes the unused sched_time_avg_ms

Change since v4:
- add support of periodic update of blocked utilization
- rebase on lastest tip/sched/core

Change since v3:
- add support of periodic update of blocked utilization
- rebase on lastest tip/sched/core

Change since v2:
- move pelt code into a dedicated pelt.c file
- rebase on load tracking changes

Change since v1:
- Only a rebase. I have addressed the comments on previous version in
  patch 1/2


Vincent Guittot (11):
  sched/pelt: Move pelt related code in a dedicated file
  sched/pelt: remove blank line
  sched/rt: add rt_rq utilization tracking
  cpufreq/schedutil: use rt utilization tracking
  sched/dl: add dl_rq utilization tracking
  cpufreq/schedutil: use dl utilization tracking
  sched/irq: add irq utilization tracking
  cpufreq/schedutil: take into account interrupt
  sched: use pelt for scale_rt_capacity()
  sched: remove rt_avg code
  proc/sched: remove unused sched_time_avg_ms

 include/linux/sched/sysctl.h     |   1 -
 kernel/sched/Makefile            |   2 +-
 kernel/sched/core.c              |  38 +---
 kernel/sched/cpufreq_schedutil.c |  46 ++++-
 kernel/sched/deadline.c          |   8 +-
 kernel/sched/fair.c              | 403 +++++----------------------------------
 kernel/sched/pelt.c              | 393 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/pelt.h              |  72 +++++++
 kernel/sched/rt.c                |  15 +-
 kernel/sched/sched.h             |  68 +++++--
 kernel/sysctl.c                  |   8 -
 11 files changed, 621 insertions(+), 433 deletions(-)
 create mode 100644 kernel/sched/pelt.c
 create mode 100644 kernel/sched/pelt.h

-- 
2.7.4
