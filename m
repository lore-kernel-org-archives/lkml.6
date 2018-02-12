Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932873AbeBLIIC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:08:02 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55871 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeBLIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:08:01 -0500
X-Google-Smtp-Source: AH8x227pxKFJ4Lff4CjrKuDkPiqYnK1EUvPz2rCJn4QHvRfxak/rQWpOdSPj4vujEoyUaGZdhp9fgQ==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Cc: morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 0/3] sched: Update blocked load
Date: Mon, 12 Feb 2018 09:07:51 +0100
Message-Id: <1518422874-13216-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset applies on top of Peter's sched/esting branch minus the last 2 commit:
56eb46798b33 ("sched: Clean up nohz enter/exit")

v3:
- add memory barrier
- add comments

v2:
- minor naming updates

Vincent Guittot (3):
  sched: Stop nohz stats when decayed
  sched: reduce the periodic update duration
  sched: update blocked load when newly idle

 kernel/sched/fair.c  | 227 +++++++++++++++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h |   1 +
 2 files changed, 193 insertions(+), 35 deletions(-)

-- 
2.7.4
