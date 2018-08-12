Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8CDC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168A9219C6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjfXHwSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168A9219C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeHLSsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 14:48:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35643 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeHLSsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 14:48:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so6493717wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7HBGepoZSobEplirni1bTS9RRqy0n0ImPx0/6DZ1yMY=;
        b=ZjfXHwSCpIMK4NY6x+2FBgy4n3qegNH0qS/rm+l5jS8m/q47DkXqz4QoHgvN5EN/ar
         jv52toc+jNyk6WuqQNqreQVKPdGVm91dVHl92vY/8T25vIfDjrauTZEI/KFuHL+ljjUS
         5Lj+MtDEMRFbaGTzYp/dyII7KjmATFmcS7uGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7HBGepoZSobEplirni1bTS9RRqy0n0ImPx0/6DZ1yMY=;
        b=L23TAovUQhG5e3RgQHeeM67r1ai3guurtudjVZAgHP9VVg7sLO6oYLV/5qfx6ZBoef
         miWHxqI+xD/AKvua7NUMl8DlrT4mXwDJhFOycbijuwUcbOPeQbvCGO9L9OHH1+8YKk+a
         +Yo7XOqKlX7pTktTHxPXbIE4QSBNMKVmbGLyow1Mu0DeWAxOvoxKDvPg4SdjfMBHQr8h
         qyNJJW01pWDdUGnAnWiWUFH43B9+oA9Zv/KpKEm2mJoPOHYeHsO41OllUNco1yfaVByw
         V+e11GtTX1kqopa0OASvOjlqjS5XfX3izPX6pYSKTFy3oJMGWtZta8EAg902yJnERBCD
         NF/w==
X-Gm-Message-State: AOUpUlH6H37UqZxDPARI3vP3DTyXRyGOekVCci9foniJEJkVyntFIj9Z
        9ilUHNoFQz2PW9JKhJ9K+XSI9g==
X-Google-Smtp-Source: AA+uWPw0SFiP2X+WnlM8TvHMQLXXB2U9uhu2lXjPR4kP/rWQqw7YKEuFleUruhTysMz6Mn+l9RCdJA==
X-Received: by 2002:a1c:bb86:: with SMTP id l128-v6mr5991553wmf.26.1534090191939;
        Sun, 12 Aug 2018 09:09:51 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id t6-v6sm7437369wmf.8.2018.08.12.09.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Aug 2018 09:09:51 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/5] Improvement stopping tick decision making in 'menu' idle governor
Date:   Mon, 13 Aug 2018 00:09:26 +0800
Message-Id: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found the CPU cannot stay in deepest idle state as expected with
running synthetic workloads with mainline kernel on Arm platform
(96boards Hikey620 with octa CA53 CPUs).

The main issue is the criteria for decision stopping tick; now
the criteria is checking expected interval is less than TICK_USEC, but
this doesn't consider the next tick detla is float due CPU randomly
eneters and exits idle states; furthermore, it's stick to checking
TICK_USEC as boundary for decision stopping tick, unfortunately this has
hole to select a shallow state with stopping tick, so the CPU stays in
shallow state for long time.

This patch series is to explore more reasonable making decision for
stopping tick and the most important fixing is to avoid powernightmares
issue after we apply these criterias for making decisions.  Patches
0001 ~ 0003 are used to refactor the variables and structures for more
readable code, it also provides a function menu_decide_stopping_tick()
which can be used to encapsulate the making decision logics.  The last
two patches are primary for improvement, patch 0004 'cpuidle: menu:
Don't stay in shallow state for a long time' introduces a new criteria
(it's a more strict criteria than before) for not stopping tick for
shallow state cases; patch 0005 is use the dynamic tick detla to replace
the static value TICK_USEC for decision if the tick is expired before or
after the prediction, according this comparison we can get conclusion if
need to stop tick or not.

With more accurate decision for stopping tick, one immediate benefit is
the CPUs have more chance to stay in deepest state, it also can avoid to
run tick unnecessarily and so avoid a shallower state introduced by tick
event.  For the testing result in below table, we can see the result
proves the improvement by better stopping tick decision making in this
patch series, we run the workload generated by rt-app (a single task
with period 5ms and duty cycle 1%/3%/5%/10%/20%/30%/40%), the total
running time is 60s.  We do statistics for all CPUs for all idle states
duration, the unit is second (s), for cases (dutycycle=1%/3%/5%/10%/20%)
we can see the shallow state C0/C1 duration are reduced and the time
has been moved to deepest state, so the deepest state C2 duration can
have improvement for ~9s to ~21s.  for cases (dutycycle=30%/40%) though
we can see the deepest state durations are parity between with and
without patch series, but it has a minor improvement for C1 state
duration by stealing C0 state duration.

Some notations are used in the table:

state: C0: WFI; C1: CPU OFF; C2: Cluster OFF

All testing cases have single task with 5ms period:

		 Without patches           With patches               Difference
            -----------------------  -----------------------   --------------------------
Duty cycle    C0     C1       C2       C0      C1      C2        C0        C1        C2
  1%        2.397  16.528  471.905   0.916    2.688  487.328   -1.481   -13.840   +15.422
  3%        3.957  20.541  464.434   1.510    2.398  485.914   -2.447   -18.143   +21.480
  5%        2.866   8.609  474.777   1.166    2.250  483.983   -1.699    -6.359    +9.205
 10%        2.893  28.753  453.277   1.147   14.134  469.190   -1.745   -14.618   +15.913
 20%        7.620  41.086  431.735   1.595   35.055  442.482   -6.024    -6.030   +10.747
 30%        4.394  38.328  431.442   1.964   40.857  430.973   -2.430    +2.529    -0.468
 40%        7.390  29.415  430.914   1.789   34.832  431.588   -5.600    +5.417    -0.673


P.s. for the testing, applied Rafael's patch 'cpuidle: menu: Handle
stopped tick more aggressively' [1] to avoid select unexpected shallow
state after tick has been stopped.

[1] https://lkml.org/lkml/2018/8/10/259

Leo Yan (5):
  cpuidle: menu: Clean up variables usage in menu_select()
  cpuidle: menu: Record tick delta value in struct menu_device
  cpuidle: menu: Provide menu_decide_stopping_tick()
  cpuidle: menu: Don't stay in shallow state for a long time
  cpuidle: menu: Change to compare prediction with tick delta

 drivers/cpuidle/governors/menu.c | 104 ++++++++++++++++++++++++++++-----------
 1 file changed, 76 insertions(+), 28 deletions(-)

-- 
2.7.4

