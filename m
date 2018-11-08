Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D9BECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8785820827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvkLkTNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8785820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeKIFxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:53:12 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44664 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeKIFxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:53:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id n12so28764009qkh.11;
        Thu, 08 Nov 2018 12:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AVWov9oTOLa0o8ptLdw/1Bm5RUGAQRjdANBdPA/XZu4=;
        b=hvkLkTNKujjz1aQzDBYFbCmLaXzD+yTIu3FChGLjWGDvmmiNsi9heX0jIAjT15BS9e
         qKlaAeXp4T4btrSWM15KEdJKp8CtS99coEP4tLaSKhKL6+ipdm6Ke4lrmRWjIHaRA0wD
         X0zzHC9bsfBQkKi4rsmrTCaUy13i0XJ4f2rSJ2APnyN43mS/LxB69+tZT63X3qzD23Ce
         XgMe/aKfRN/dHFy6rFrOTGaTAHLfq8DHnfaVsPIsJj43R3qUQQJi44+egSm9cEtEBgfe
         H/4R1JDfWvj0ep/0w+9hfNC0ngqCm0AKDbmLJ642Q/r1oX7fAyAqIx4LMULrd9+RuNP5
         sE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AVWov9oTOLa0o8ptLdw/1Bm5RUGAQRjdANBdPA/XZu4=;
        b=jk3r1hNugdG2Qxa8g0jjJIUnIT3PoQKGHNxhSTjCn/TllfIc/O9UK0dfH0jLguBo9/
         r7WxhXAYhAPA2b+C1Zw3nglUBO82BBNVuGXeVOxF2Z3UiknHEqc8RQCyEtl1rvex/xga
         95V/5kVOthLuwpMkQ6h0t8X27RRErTfegACmoIPYa08zg+r+qZMlrN+2QLO49ImNHW06
         LXkrlwa1c4FVdASiXcN4vHV9A9U4nDWkMikXRgABOdd41C55i0Iw7Amu4hwcMkzdpWx8
         QF23uBUBAw4+JKJzFrn4NGnwpZeke1OJX5lMoY8Da9MwmPgi+fjmz/uuTvgbhGOyTjFt
         x6bA==
X-Gm-Message-State: AGRZ1gJvIx5lClECqlShwvglYrriY4OYJwD8Uwz+I+qMU0FchZwQtzXb
        Mmi2J+4+8lfRMef95WNqOFmztybPUvM=
X-Google-Smtp-Source: AJdET5fu9WEkqkI5ksSrZq6NjXQ9y3clnycPoIV4NKIYxJO1bcQJiu3aX1PfU0snmKoKRetm4x/gYw==
X-Received: by 2002:a37:9b82:: with SMTP id d124mr5613161qke.172.1541708167466;
        Thu, 08 Nov 2018 12:16:07 -0800 (PST)
Received: from castle.thefacebook.com ([2620:10d:c091:200::4:4cb1])
        by smtp.gmail.com with ESMTPSA id k38sm3399381qkh.72.2018.11.08.12.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 12:16:06 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH 0/5] freezer for cgroup v2
Date:   Thu,  8 Nov 2018 15:15:55 -0500
Message-Id: <20181108201600.9129-1-guro@fb.com>
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
functionality.

Roman Gushchin (5):
  cgroup: rename freezer.c into legacy_freezer.c
  cgroup: implement __cgroup_task_count() helper
  cgroup: cgroup v2 freezer
  kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
  kselftests: cgroup: add freezer controller self-tests

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
 kernel/signal.c                               |  51 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  85 ++-
 tools/testing/selftests/cgroup/cgroup_util.h  |   7 +
 tools/testing/selftests/cgroup/test_freezer.c | 685 ++++++++++++++++++
 17 files changed, 1695 insertions(+), 451 deletions(-)
 create mode 100644 kernel/cgroup/legacy_freezer.c
 create mode 100644 tools/testing/selftests/cgroup/test_freezer.c

-- 
2.17.2

