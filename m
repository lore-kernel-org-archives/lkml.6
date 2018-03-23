Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeCWXNV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 19:13:21 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42817 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeCWXNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 19:13:19 -0400
X-Google-Smtp-Source: AG47ELtrHKnmOrx65UqGveQ1Qqy1l9X3rmJyp+BcRfuwPZjxluk/+90rloEfQgP4AoNSu4VNUx/VHw==
From: Tejun Heo <tj@kernel.org>
To: lizefan@huawei.com, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, guro@fb.com,
        kernel-team@fb.com
Subject: [PATCHSET] cgroup/for-4.17: Make cgroup_rstat available to controllers
Date: Fri, 23 Mar 2018 16:13:05 -0700
Message-Id: <20180323231313.1254142-1-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

cgroup has scalable recursive stat mechanism implemented in
kernel/stat.c.  It's currently only used to track cpu consumptions and
difficult to use outside of cgroup core.  This patchset generalizes
the mechanism and exposes it as cgroup_rstat so that controllers can
use it.

This patchset contains the following eight patches.  A follow-up
patchset will add usages.

 0001-cgroup-Rename-kernel-cgroup-stat.c-to-kernel-cgroup-.patch
 0002-cgroup-Rename-stat-to-rstat.patch
 0003-cgroup-Distinguish-base-resource-stat-implementation.patch
 0004-cgroup-Reorganize-kernel-cgroup-rstat.c.patch
 0005-cgroup-Factor-out-and-expose-cgroup_rstat_-interface.patch
 0006-cgroup-Replace-cgroup_rstat_mutex-with-a-spinlock.patch
 0007-cgroup-Add-cgroup_subsys-css_rstat_flush.patch
 0008-cgroup-Add-memory-barriers-to-plug-cgroup_rstat_upda.patch

This patchset is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-cgroup_rstat

diffstat follows.

 include/linux/cgroup-defs.h     |   50 ++--
 include/linux/cgroup.h          |   12 -
 kernel/cgroup/Makefile          |    2 
 kernel/cgroup/cgroup-internal.h |   11 -
 kernel/cgroup/cgroup.c          |   29 ++
 kernel/cgroup/rstat.c           |  410 ++++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/stat.c            |  338 --------------------------------
 7 files changed, 477 insertions(+), 375 deletions(-)

Thanks.

--
tejun
