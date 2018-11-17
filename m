Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E6C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB802089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDlJVH/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB802089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbeKQKxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:53:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44721 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQKxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:53:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id b81-v6so11653250pfe.11;
        Fri, 16 Nov 2018 16:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sJCmN87GOMtrEMXquC7JcDyvMaVa3PWfwko+KjgM5Bg=;
        b=rDlJVH/5Y506158JOjpZezHMToVw4YyZvjtrQ14KUJaG1DRLpVyVRo6kFJrwyt6eLU
         /40IroVzhihiYQt26ePxF+TtFkNcs3ElHyN118Gzp9dO86tUridOdz2ViJVqUSoZHyGh
         Dr5cR8SgWrjU7UaqqvIg0enuCBxLXP329pqT/5rDV0BTWwPNh1tKc3YSS8/dQKtllBoz
         f13QTlDgH4Tv4XjK1eLd2jHOORxb7u+V3SZUoKhUhc0toMJH1KFhcAOdlYlNzxioaKW/
         nKsOsZaArN6EJWp2Gbwx+5NHVAZ0ADJi2VHrHAa8Y8O2IsoySdkpxbWIbqkxgXahQEyf
         Ec1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sJCmN87GOMtrEMXquC7JcDyvMaVa3PWfwko+KjgM5Bg=;
        b=kuDKRTNijoFh/F2qhxiVyurqKUu55wJDCYliw88V6RNyO7DJGW2wTtrxZfePJFF2Cs
         s83JN53vqTqigwqhs0PvABJmPSSAtojuFm2v9aymjeabWgAzXRu+tqUvlXpCzLFeF7gL
         latz9aRm5n7sjFKwKTJjeeRlLbsiwHTyjtiU9NOs7IKYEfy1lb6VeFFmWmaD6F3OFC07
         juO1Va/QajEYV4GnatGG30KjDqDf64FWV7STpJG4rl2heEVlxG21LsCEiV/9gJLWWTUk
         OhBY4HunBiHCljmATDZpaLNFZeCBXATUES7basccx5mZjuV3niXCeI0BduTXKo6ujYmC
         gPCQ==
X-Gm-Message-State: AGRZ1gItQqepjQdJtGOPCooRFWf9KbwVBR8/t8HXx3Kh6+N1oFnprgsX
        0Y+OHqXi0zWf6BzUvxK3IMw=
X-Google-Smtp-Source: AJdET5emwcmRkduhFg5IXm5gigO2PCYB85t2sICxGQNtWss63mdkAJiQ0HuUDuuCUAfFKDL3KaZj9w==
X-Received: by 2002:a63:9402:: with SMTP id m2mr11510541pge.93.1542415114970;
        Fri, 16 Nov 2018 16:38:34 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::4:2b73])
        by smtp.gmail.com with ESMTPSA id f6sm1981177pfg.188.2018.11.16.16.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 16:38:33 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 0/7] freezer for cgroup v2
Date:   Fri, 16 Nov 2018 16:38:23 -0800
Message-Id: <20181117003830.15344-1-guro@fb.com>
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

 Documentation/admin-guide/cgroup-v2.rst       |  26 +
 include/linux/cgroup-defs.h                   |  31 +
 include/linux/cgroup.h                        |  42 ++
 include/linux/sched.h                         |   2 +
 include/linux/sched/jobctl.h                  |   2 +
 include/linux/sched/signal.h                  |   2 +
 kernel/cgroup/Makefile                        |   4 +-
 kernel/cgroup/cgroup-internal.h               |   1 +
 kernel/cgroup/cgroup-v1.c                     |  16 -
 kernel/cgroup/cgroup.c                        | 165 ++++-
 kernel/cgroup/freezer.c                       | 641 ++++++----------
 kernel/cgroup/legacy_freezer.c                | 481 ++++++++++++
 kernel/ptrace.c                               |   7 +
 kernel/signal.c                               |  57 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  85 ++-
 tools/testing/selftests/cgroup/cgroup_util.h  |   7 +
 tools/testing/selftests/cgroup/test_freezer.c | 685 ++++++++++++++++++
 19 files changed, 1804 insertions(+), 453 deletions(-)
 create mode 100644 kernel/cgroup/legacy_freezer.c
 create mode 100644 tools/testing/selftests/cgroup/test_freezer.c

-- 
2.17.2

