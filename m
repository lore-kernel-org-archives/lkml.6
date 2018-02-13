Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934193AbeBMKb3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:31:29 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33462 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933849AbeBMKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:31:25 -0500
X-Google-Smtp-Source: AH8x2265x6ZYWWukHIiQWHICcfH7Hw/qRfA4hk38eaAFVCYip+zjJEIpMbqW27Z+usVuxuCa+b/uLg==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Cc: morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 0/3] sched: Update blocked load
Date: Tue, 13 Feb 2018 11:31:16 +0100
Message-Id: <1518517879-2280-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset applies on top of Peter's sched/esting branch minus the last 2 commit:
56eb46798b33 ("sched: Clean up nohz enter/exit")

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
