Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDA8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EB8223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smwTSRBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EB8223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeKMI7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:59:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39590 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeKMI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:59:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so4725867pgv.6;
        Mon, 12 Nov 2018 15:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tzEE9rZVbKHCXTNXEZ/y2fzBVHQSTX20LWGYSOiRuao=;
        b=smwTSRBdi+IKkbeaEOondPeeZiVEo9frr7KziK9Eg9Ccqpo6K3Bv/C2/6ffkigvtXF
         LUDI0eypzr272BqwdO3aHkj+Y7LExdfVQNJ+V00SumkOIHL7PlMvLc/tHxP5ohoo1rOx
         4hDabA4RlJQoqLMLdy0dWWopAWQJEQjtE3KKoJyjRx/PSWJr1HFTPPxKW4MB1O9blrpc
         DlOlK+67yDIow25KgCsJpFDK60FqzSg4ipk3mMRS96/WJ6OWIQr96RGZD/Ey1o9Vlw5V
         tk6FAufXHVy7GOxdLiUUvcKDrO1FkDbrqI5yrAl4ophMeNc3Mh6gmSmw6NWZqBLKahiK
         4VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tzEE9rZVbKHCXTNXEZ/y2fzBVHQSTX20LWGYSOiRuao=;
        b=n8PgDbvi/FwqGWaVUN0cjHhuWeTGT3qzJ8IeYlHr+GFuhv7WkXFRR+2QdZGhtGJia3
         FbfVNs29D7V35YcfhXAOiB25cDMTHp9YEqpDo7k55QxmNQX6zhXqSF7j19951CE4xRuX
         7kkDUX4V5hJVc+/X2NHJ7IJTnRxLcbq9jFU/Rgj1ZQeOrYnMAEB/JY8FGn3cEoNDecIR
         Cff1h1jxSTXC5T0+Ha/ln4UPD6KdqUv8ky4y5sZqjdza2uSFJQsDrvgeVFTMMqqsNeSn
         A2PpYCzxJ9lT3oRejZC/rb9j2t5CKR3b3CznqwglSN0trhlD4E5MiKihlfHk9B+GOHJZ
         DeRQ==
X-Gm-Message-State: AGRZ1gKr48Sv2THg/tSLpGG+LpA0xIGakBuTPwD+zWuKGUl7RasYG4y6
        z6qorRcwT6klP59AkbMOPeU=
X-Google-Smtp-Source: AJdET5dNte46LxM+grTilg7B2QZulSZ4DyJFKt+hUGskJhBh2S5bY66e3j8xkiRRkdrFJCjhpfSBUQ==
X-Received: by 2002:a63:dc0c:: with SMTP id s12mr2555444pgg.398.1542063864667;
        Mon, 12 Nov 2018 15:04:24 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:c2f7])
        by smtp.gmail.com with ESMTPSA id f64sm7192327pfh.0.2018.11.12.15.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 15:04:24 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 0/6] freezer for cgroup v2
Date:   Mon, 12 Nov 2018 15:04:15 -0800
Message-Id: <20181112230422.5911-1-guro@fb.com>
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

Patches (1) and (2) are some preparational work, patch (3) contains
the implementation, patch (4) is a small cgroup kselftest fix,
patch (5) covers freezer adds 6 new kselftests to cover the freezer
functionality. Patch (6) adds corresponding docs.

v2->v1:
  - fixed locking aroung calling cgroup_freezer_leave()
  - added docs

Roman Gushchin 
  cgroup: rename freezer.c into legacy_freezer.c
  cgroup: implement __cgroup_task_count() helper
  cgroup: cgroup v2 freezer
  kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
  kselftests: cgroup: add freezer controller self-tests
  cgroup: document cgroup v2 freezer interface

 Documentation/admin-guide/cgroup-v2.rst       |  26 +
 include/linux/cgroup-defs.h                   |  33 +
 include/linux/cgroup.h                        |  42 ++
 include/linux/sched.h                         |   5 +-
 include/linux/sched/jobctl.h                  |   5 +-
 kernel/cgroup/Makefile                        |   4 +-
 kernel/cgroup/cgroup-internal.h               |   1 +
 kernel/cgroup/cgroup-v1.c                     |  16 -
 kernel/cgroup/cgroup.c                        | 132 +++-
 kernel/cgroup/freezer.c                       | 590 +++++----------
 kernel/cgroup/legacy_freezer.c                | 481 ++++++++++++
 kernel/ptrace.c                               |   6 +
 kernel/signal.c                               |  54 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  85 ++-
 tools/testing/selftests/cgroup/cgroup_util.h  |   7 +
 tools/testing/selftests/cgroup/test_freezer.c | 685 ++++++++++++++++++
 18 files changed, 1724 insertions(+), 451 deletions(-)
 create mode 100644 kernel/cgroup/legacy_freezer.c
 create mode 100644 tools/testing/selftests/cgroup/test_freezer.c

-- 
2.17.2

