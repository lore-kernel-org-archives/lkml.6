Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932731AbeBLO7N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:59:13 -0500
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:44148 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932386AbeBLO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:58:59 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/4] Reduce migrations due to load imbalance and process exits
Date: Mon, 12 Feb 2018 14:58:53 +0000
Message-Id: <20180212145857.8056-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series was motivated by the fact that higher migrations were
observed than expected. The first two patches are minor cleanups. The third
patch avoids migrations on wakeup when two CPUs are equally loaded which
is particularly important in the case where the measured load is 0. The last
patch avoids cross-node migrations of a parent process when the child exits.
Overall, there is a minor boost in performance on some workloads with the
details included in the changelogs.

The series was tested based on Linus's tree during the 4.16 merge window
as of Feb 8th but applies cleanly to 4.16-rc1.

 kernel/sched/fair.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.15.1
