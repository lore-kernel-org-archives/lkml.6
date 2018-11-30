Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E53C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD0020867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB/75V07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD0020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLAK6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:58:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39357 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAK6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:58:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so3531303pld.6;
        Fri, 30 Nov 2018 15:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8wWgJ9mRatXUK5Ii2MmF/AjR4kqI/jk/sjBZOiW0lNk=;
        b=FB/75V07p4TGJd0um2iwcghXUClp+mgyExRg+GqzYv7+qUJSFl5f2LYgb5w2B0z0bY
         z6ZTJpki25OZwbXX9woJyB8ovQAwyzmGDiIXpUZEmkWxn40vjcYb7BIVLSUMj36YEFTU
         fxEnYULbK4m0yehe93ZlpIEfj/LDUwhHs23IiUPz1wMmmJmO6Anj97vHVhw34NhxQkJl
         oyL0TTX9IdqoRM/uHT5XTFVeWZ3bbWTrD6Mxp0/3y8tAV7VgP273RTAZ4IKCkF5QXQwl
         VhX1heKDXQoIS0kqx36r6XswVWZRVmneOkAYKRj5UAnhyM7vTw4paocU+MuAg/Uloxb5
         actA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8wWgJ9mRatXUK5Ii2MmF/AjR4kqI/jk/sjBZOiW0lNk=;
        b=ZZYRxrbnqBK2Uwro4E+1++nkPZkEKdspwdIrQENwoGKYOholixfwcMq2rx7pdfa526
         ENm1aa/mLJBLxSdCqr0G2+F9yYAnFG53wQVcTW6+MsRCCqu5mJqD6mEUtjsEFQhtu8QR
         HI1GJcW8xSN0STy1QMsMinABM8v0HJYQadAEd9m4KDQQn+L76sd4Z1yimRBTyLUCCZoZ
         7FEYFZYmRarH+8WCCMLMQjMZZrolBxv55ftowC+CNFNxXon4VLppgz5uombQoQZzOtsB
         3lhAas4JMnVR3qYJsOqrLWakgM+79Rgwo7S711shG97Bnh3VNUp673B9znEsC8fOYVDH
         EOYQ==
X-Gm-Message-State: AA+aEWaq+HMTbFg0VYgZ7LwW9eBKKXt3vjwoltAP5nZT152VC7glOUq+
        ApLOZ4NBlJEeUGFOZAJ8WIg=
X-Google-Smtp-Source: AFSGD/VFlnSyPjD9wK0QwIBnHHhZCTe/WSJdLBmv3xiYOD1x56AiAfO5eQi01OxnVaFsEt0GKicKqQ==
X-Received: by 2002:a17:902:6b87:: with SMTP id p7-v6mr7689298plk.282.1543621672975;
        Fri, 30 Nov 2018 15:47:52 -0800 (PST)
Received: from castle.tfbnw.net ([2620:10d:c090:180::1:2b61])
        by smtp.gmail.com with ESMTPSA id e188sm9556742pfg.130.2018.11.30.15.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:47:52 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v4 0/7] freezer for cgroup v2
Date:   Fri, 30 Nov 2018 15:47:38 -0800
Message-Id: <20181130234745.6756-1-guro@fb.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

freezer for cgroup v2

This patchset implements freezer for cgroup v2.

It provides similar functionality as v1 freezer, but the interface
conforms to the cgroup v2 interface design principles, and it
provides a better user experience: tasks can be killed, ptrace works,
there is no separate controller, which has to be enabled, etc.

Patches (1), (2) and (3) are some preparational work, patch (4) contains
the implementation, patch (5) is a small cgroup kselftest fix,
patch (6) covers freezer adds 6 new kselftests to cover the freezer
functionality. Patch (7) adds corresponding docs.

v4->v3:
  - fixed cgroup state transitions on task migration (by Tejun Heo)
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
 include/linux/cgroup-defs.h                   |  31 +
 include/linux/cgroup.h                        |  42 ++
 include/linux/sched.h                         |   2 +
 include/linux/sched/jobctl.h                  |   2 +
 include/linux/sched/signal.h                  |   3 +
 kernel/cgroup/Makefile                        |   4 +-
 kernel/cgroup/cgroup-internal.h               |   1 +
 kernel/cgroup/cgroup-v1.c                     |  16 -
 kernel/cgroup/cgroup.c                        | 151 +++-
 kernel/cgroup/freezer.c                       | 653 +++++++----------
 kernel/cgroup/legacy_freezer.c                | 481 ++++++++++++
 kernel/ptrace.c                               |   7 +
 kernel/signal.c                               |  58 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  85 ++-
 tools/testing/selftests/cgroup/cgroup_util.h  |   7 +
 tools/testing/selftests/cgroup/test_freezer.c | 685 ++++++++++++++++++
 19 files changed, 1811 insertions(+), 447 deletions(-)
 create mode 100644 kernel/cgroup/legacy_freezer.c
 create mode 100644 tools/testing/selftests/cgroup/test_freezer.c

-- 
2.17.2

