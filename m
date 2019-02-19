Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0518C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944E32147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeDz3BpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfBSWDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:03:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41460 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfBSWDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:03:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so10751532pgq.8;
        Tue, 19 Feb 2019 14:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6E4heah3RkEK0Ib7PIsaMfwndGngevIShogBrVDAzDI=;
        b=EeDz3BpBfxyGezTJ65HiBAAgewbd2TF+nZMSaMFCSp+E8KPcByoWZVNyCt5M7fvr+p
         JnI41QsWbXCP7L+rJt3QJLp+Uxc/Gss96uLJdhzi0cwenqSYVuF+SrLYhI3B8wbxcV3u
         KuSm4bLN5/UMO/s5iXBnIV1UVDwfUUqc9SHFMJfBPo/awVpYROCaXx48yhxNKrCGmiL3
         QQU1v5Tx+M7eG26lExcT+Lu6ZtnUwh9BY5aISmks6LArbo2UCFzAYy4GAvBuD+uEt7El
         D5ZV/fmKjWIcm16l3s2pLtybna1VnZfjmPfG9MTUWaPLa7YGv7OyPgY6FcryecYHg42w
         ZHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6E4heah3RkEK0Ib7PIsaMfwndGngevIShogBrVDAzDI=;
        b=QPUV7rtOqu1P//zaQmEz8flSrgCNAirl21t3PHVVARQJP5T88CebK7DsO+Lb7IjmF7
         1enCt0wviPst+NRtFFR/y0KppqFg3QP7GlRstUrh/JDfL2spSq4C4PK0bV1kKNC19StZ
         ZHz41nzMAlNsF21mb9JEeNib/RjzTQsUTl/XQ0zt8Gx3ridXJqaQugsoCGllZQ8sr9/E
         T5WPOCnuPlKjb+1fjityd61okL5+o7hsQaqZ7cJmNX9AhfhYFjVE0ua2HjO1ir1gk3m/
         O9kn3D96kNwqodMRYhBbUZhhVB++CcSxvIhkZGSpmvQmkF0FPlyyq4sTyDDMIQ2Dzozs
         89pw==
X-Gm-Message-State: AHQUAuawTmm6jM5orZelxIi9CoOeh06+TRKP9bmoisfFZ1AkZ6Xu5JvT
        J8LhOxQwd40j2H0rBokhAOuRJ5r5AeI=
X-Google-Smtp-Source: AHgI3IZNCP7IN+43JijzbvowXJ37CaFI3wlt3iaIWe8iIXK0FL8ewoewVENVNHQuAt+4hTKqXo+1nQ==
X-Received: by 2002:a65:6642:: with SMTP id z2mr19314786pgv.196.1550613779463;
        Tue, 19 Feb 2019 14:02:59 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:161b])
        by smtp.gmail.com with ESMTPSA id e6sm33539779pfe.59.2019.02.19.14.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 14:02:56 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v8 0/7] freezer for cgroup v2
Date:   Tue, 19 Feb 2019 14:02:45 -0800
Message-Id: <20190219220252.4906-1-guro@fb.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements freezer for cgroup v2.

It provides similar functionality as v1 freezer, but the interface
conforms to the cgroup v2 interface design principles, and it
provides a better user experience: tasks can be killed, ptrace works,
there is no separate controller, which has to be enabled, etc.

Patches (1), (2) and (3) are some preparational work, patch (4) contains
the implementation, patch (5) is a small cgroup kselftest fix,
patch (6) covers freezer adds 6 new kselftests to cover the freezer
functionality. Patch (7) adds corresponding docs.

v8->v7:
  - reworked/simplified cgroup frozen task accounting by merging nr_stopped
  and nr_frozen and removing nr_tasks_to_freeze
  - don't notify the parent process if the child is going from the stopped
  to the frozen state

v7->v6:
  - handle properly the case, when a task is both stopped and frozen
  - check for CGRP_FREEZE instead of CGRP_FROZEN in cgroup_exit()
  - minor cosmetic changes and rebase

v6->v5:
  - reverted to clear TIF_SIGPENDING with additional checks before schedule(),
  as proposed by Oleg Nesterov
  - made cgroup v2 freezer working with the system freezer (by using
  freezable_schedule())
  - make freezer working with SIGSTOPped and PTRACEd tasks
  - added tests to cover freezing a cgroup with SIGSTOPped and PTRACEd tasks

v5->v4:
  - rewored cgroup state transition code (suggested by Tejun Heo)
  - look at JOBCTL_TRAP_FREEZE instead of task->frozen in
    recalc_sigpending(), check for task->frozen and JOBCTL_TRAP_FREEZE
    in signal_pending_state() (suggested by Oleg Nesterov)
  - some cosmetic changes in signal.c (suggested by Oleg Nesterov)
  - cleaned up comments

v4->v3:
  - reading nr_descendants doesn't require taking css_set_lock anymore
  - fixed docs based on Mike Rapoport's feedback
  - fixed double irq lock found by Dan Carpenter

v3->v2:
  - dropped TASK_FROZEN for now, frozen tasks are put into TASK_INTERRUPTIBLE
  state; it's probably not the final version, but the API question can be
  discussed separately
  - don't clear TIF_SIGPENDING before going to sleep, instead add
  task->frozen check in signal_pending_state() and recalc_sigpending()
  - cgroup-level counter are now synchronized using css_set_lock,
  which simplified the whole code (e.g. per-cgroup works were removed)
  - the amount of comments increased significantly
  - many other improvements incorporating feedback from Tejun and Oleg

v2->v1:
  - fixed locking aroung calling cgroup_freezer_leave()
  - added docs

Roman Gushchin (7):
  cgroup: rename freezer.c into legacy_freezer.c
  cgroup: implement __cgroup_task_count() helper
  cgroup: protect cgroup->nr_(dying_)descendants by css_set_lock
  cgroup: cgroup v2 freezer
  kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
  kselftests: cgroup: add freezer controller self-tests
  cgroup: document cgroup v2 freezer interface

 Documentation/admin-guide/cgroup-v2.rst       |  27 +
 include/linux/cgroup-defs.h                   |  33 +
 include/linux/cgroup.h                        |  42 +
 include/linux/sched.h                         |   2 +
 include/linux/sched/jobctl.h                  |   2 +
 kernel/cgroup/Makefile                        |   4 +-
 kernel/cgroup/cgroup-internal.h               |   1 +
 kernel/cgroup/cgroup-v1.c                     |  16 -
 kernel/cgroup/cgroup.c                        | 142 ++-
 kernel/cgroup/freezer.c                       | 608 +++++--------
 kernel/cgroup/legacy_freezer.c                | 481 ++++++++++
 kernel/signal.c                               |  84 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  85 +-
 tools/testing/selftests/cgroup/cgroup_util.h  |   7 +
 tools/testing/selftests/cgroup/test_freezer.c | 842 ++++++++++++++++++
 17 files changed, 1943 insertions(+), 436 deletions(-)
 create mode 100644 kernel/cgroup/legacy_freezer.c
 create mode 100644 tools/testing/selftests/cgroup/test_freezer.c

-- 
2.20.1

