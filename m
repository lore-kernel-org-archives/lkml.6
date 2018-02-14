Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031312AbeBNP0y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:26:54 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50200 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031243AbeBNP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:26:51 -0500
X-Google-Smtp-Source: AH8x2262uIOjOdsMV5elGDB55/FIvz3yIf39JrZjhVelWGIZIhBXWYY2+Yfc539wihGzRh8+UgTSaw==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Cc: morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 0/3] sched: Update blocked load
Date: Wed, 14 Feb 2018 16:26:43 +0100
Message-Id: <1518622006-16089-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset applies on top of Peter's sched/esting branch minus the last 2 commit:
56eb46798b33 ("sched: Clean up nohz enter/exit")

v5:
- fix wrong test condition in the newly idle case
- fix some typos

v4:
- fixed some compilation issues raised by kbuild
- update comments
- reorder condition tests for calling _nohz_idle_balance in newly_idle case
  in order to make it more readable

v3:
- add memory barrier
- add comments

v2:
- minor naming updates

Vincent Guittot (3):
  sched: Stop nohz stats when decayed
  sched: reduce the periodic update duration
  sched: update blocked load when newly idle

 kernel/sched/fair.c  | 453 ++++++++++++++++++++++++++++++++++-----------------
 kernel/sched/sched.h |   1 +
 2 files changed, 305 insertions(+), 149 deletions(-)

-- 
2.7.4
