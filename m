Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeCXQvk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 12:51:40 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39470 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbeCXQvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 12:51:38 -0400
X-Google-Smtp-Source: AG47ELtYYiBQfz5tng6CSgMXzHkdRkup2a+H1Tn1Rvvc21f3tMU1YItAohrAIoNxC5p5Gg4w2rApmA==
From: Tejun Heo <tj@kernel.org>
To: hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com
Cc: guro@fb.com, riel@surriel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCHSET] mm, memcontrol: Implement memory.swap.events
Date: Sat, 24 Mar 2018 09:51:25 -0700
Message-Id: <20180324165127.701194-1-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset implements memory.swap.events which contains max and
fail events so that userland can monitor and respond to swap running
out.  It contains the following two patches.

 0001-mm-memcontrol-Move-swap-charge-handling-into-get_swa.patch
 0002-mm-memcontrol-Implement-memory.swap.events.patch

This patchset is on top of the "cgroup/for-4.17: Make cgroup_rstat
available to controllers" patchset[1] and "mm, memcontrol: Make
cgroup_rstat available to controllers" patchset[2] and also available
in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-memcg-swap.events

diffstat follows.

 Documentation/cgroup-v2.txt |   16 ++++++++++++++++
 include/linux/memcontrol.h  |    5 +++++
 mm/memcontrol.c             |   25 +++++++++++++++++++++++++
 mm/shmem.c                  |    4 ----
 mm/swap_slots.c             |   10 +++++++---
 mm/swap_state.c             |    3 ---
 6 files changed, 53 insertions(+), 10 deletions(-)

Thanks.

--
tejun

[1] http://lkml.kernel.org/r/20180323231313.1254142-1-tj@kernel.org
[2] http://lkml.kernel.org/r/20180324160901.512135-1-tj@kernel.org
