Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AC6C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E182083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLCYxi3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E182083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeLGUPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:15:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42259 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeLGUPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:15:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so2176264pga.9;
        Fri, 07 Dec 2018 12:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kgzafWSB1mVEChz4YZIBR4ca68MW5UetsrrL1D6H/2o=;
        b=lLCYxi3QAVOQwiwiUoB3BkACgAIi0jyTHnWxMpFslTXOrH+g6BRE/MbBDYZU+0Vlg8
         vb8Up+FEqncnzrY9NnY5v+KNfAOk7j3W1HfpjQ1CnQ1OHdUm9Oek7O8YyCQf29ykxNj3
         WjTTXTiam3J27y6cYU/7BMBUppvpO3y31IRErC2cNjFm3Jo9fUTp1Wc+Ysfn8C0Sphes
         VgtSDYCm6Mc21CpujJX0gVbs/7lrClRsm/IMpIMZ0LYuHdZQP5T1s1ebAu0enl8rnrLi
         6If+BnhBqxa/dy8OAPpTd/ef5g5C5t+ejKYaiZIcYKODegQA3k1mBL/yWlEsvQStB/xH
         ulYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kgzafWSB1mVEChz4YZIBR4ca68MW5UetsrrL1D6H/2o=;
        b=NTtVmz3L56g+XRfpz1EaXjeYCmUk0cDCW8/pP0ZD3P3Lvq+dlIekhosQm0zjTx80Sw
         coqDxUbtlc2rjR5HsENKwm+zxMTrgS15n29TML+2nWKBoLWBB3CCoo5dYQk+UM6BRlBh
         MOwqqp9w1Sg+QcqUFV8XLa3YYDHmYuHShjOjJwjg5X5kqne4KkQlkvbtK4kppCaw6MCZ
         oqD3btq2VlBuqI7Hg1yY8rVr33FYWTk65L9/mNT8FQpIrJBDwJxQm2wuiR1hkVGm1YIu
         /2tAzP94WUvVqxaGqkozu9k3WGdl1FDO+MhNcpXfWSZVXu1VgKKEX4bV88wkwrJKV/rD
         HVMw==
X-Gm-Message-State: AA+aEWYysZfEHlg+bkw3+BfjzNEDcqQWkO2QVmkKK4ZunYTMzpOg5Uh1
        JebsuNcSjYNf6jOsqhgZGJY=
X-Google-Smtp-Source: AFSGD/VZBFdd4HUZSa8YanaYPf8IjQh24kzKR50EoG7PORPdwgyn/4Kap8jZ8atd1fIKBVfz8lqWPQ==
X-Received: by 2002:a62:6408:: with SMTP id y8mr3572195pfb.202.1544213734806;
        Fri, 07 Dec 2018 12:15:34 -0800 (PST)
Received: from castle.thefacebook.com ([2620:10d:c090:200::6:d83b])
        by smtp.gmail.com with ESMTPSA id q75sm5870898pfa.38.2018.12.07.12.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 12:15:34 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v5 0/7] freezer for cgroup v2
Date:   Fri,  7 Dec 2018 12:15:24 -0800
Message-Id: <20181207201531.1665-1-guro@fb.com>
X-Mailer: git-send-email 2.17.2
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
 include/linux/cgroup.h                        |  42 ++
 include/linux/sched.h                         |   2 +
 include/linux/sched/jobctl.h                  |   2 +
 include/linux/sched/signal.h                  |   3 +
 kernel/cgroup/Makefile                        |   4 +-
 kernel/cgroup/cgroup-internal.h               |   1 +
 kernel/cgroup/cgroup-v1.c                     |  16 -
 kernel/cgroup/cgroup.c                        | 145 +++-
 kernel/cgroup/freezer.c                       | 634 ++++++----------
 kernel/cgroup/legacy_freezer.c                | 481 ++++++++++++
 kernel/signal.c                               |  55 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  85 ++-
 tools/testing/selftests/cgroup/cgroup_util.h  |   7 +
 tools/testing/selftests/cgroup/test_freezer.c | 685 ++++++++++++++++++
 18 files changed, 1794 insertions(+), 431 deletions(-)
 create mode 100644 kernel/cgroup/legacy_freezer.c
 create mode 100644 tools/testing/selftests/cgroup/test_freezer.c

-- 
2.17.2

