Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC91C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C4420657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmVI9isp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfAON7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:59:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45433 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfAON7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:59:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so1317903plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 05:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=f9WqDROnrnjpPZhi9d6w/I8lY7AeAtMl81necAoCy3E=;
        b=EmVI9ispTK87vtipVAbp/v9h+/CAVO64bhYYZGWL1Wco27j8exicJJW7AGZTfG6bxS
         rE+Bh4tnYnz1/z49QP3WfqppBD3swuonF8hMB3O3czYWe8YdJFxLDtDrLTXN5Ht9JCiP
         OPy21coeFkjUkKTY8tEy9XYCGi3J2Rl29atA1ZjtkghaGPw9cIIuaAtkPWyuoP0EjEHK
         5j7NdjeRc1pxTjvFdPvWzdqsF5wsBglvPKCsAUX88QSqJh01xlW8Qjigwfk7vCE6O2pR
         iSoBTvUbP6tiRWWYuOya8hLt68RaP0cpTwy0tXACMVKQO70cwq4rqnx3sOL7egbBds69
         8TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f9WqDROnrnjpPZhi9d6w/I8lY7AeAtMl81necAoCy3E=;
        b=AzwcxXnQIZfvH2eJCBmR/5CVStysWWNzrWAfLrvbR9RqOjudS2n2fEp3mSXSY3idqU
         1Xfh+jF+lZJzmy80gUaQoVMMep4DgO8YCpvLz5jcbkHaUljJX0dYQTCaaZuCpqvj+XXF
         8VF3ANj4nSBI6kUZWsa/7QKxXezVWgo4rjYaBDorrc/972lizE6mehB39FIEAi49AtqS
         RLRNOsY9nq7aBTmqdseK5J/BZ8nYJZdM0vcL9uNN6tO/VckAsCpCwvSe8JMH+GwsN4MY
         la/kjPu73QHPoB0F34t4hAT05DYvX7tlfiFYs/9ZT7jD0NvzX74m3OoYaKy7Iwoi6Q1x
         SpmQ==
X-Gm-Message-State: AJcUukflxrUXeygtPgxzJ20kD/ZeYCgO1bz0tiIKDjLKFOgaWHMztSjr
        vG5T8dyAx0QouWIsb6ACTPs=
X-Google-Smtp-Source: ALg8bN6Xv3qTYvSDqTVo4xWDh/W6M9xibL6wcFBjyrhVJhq5ObMbENTGCNC3UHUXcce74V28AuzVFQ==
X-Received: by 2002:a17:902:d202:: with SMTP id t2mr4291110ply.193.1547560761904;
        Tue, 15 Jan 2019 05:59:21 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([42.110.165.26])
        by smtp.gmail.com with ESMTPSA id n78sm5584315pfk.19.2019.01.15.05.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 05:59:21 -0800 (PST)
Date:   Tue, 15 Jan 2019 19:29:16 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, colin.king@canonical.com
Cc:     jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] tools/perf: Remove duplicate header
Message-ID: <20190115135916.GA3629@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate headers which are included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 tools/perf/builtin-stat.c     | 1 -
 tools/perf/tests/bp_account.c | 1 -
 tools/perf/util/dso.h         | 1 -
 tools/perf/util/zlib.c        | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d1028d7755bb..f919ffc4b3b3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -83,7 +83,6 @@
 #include <unistd.h>
 #include <sys/time.h>
 #include <sys/resource.h>
-#include <sys/wait.h>
 
 #include "sane_ctype.h"
 
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index a20cbc445426..57fc544aedb0 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -15,7 +15,6 @@
 #include <sys/mman.h>
 #include <linux/compiler.h>
 #include <linux/hw_breakpoint.h>
-#include <sys/ioctl.h>
 
 #include "tests.h"
 #include "debug.h"
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index c5380500bed4..722d67a407e2 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -8,7 +8,6 @@
 #include <sys/types.h>
 #include <stdbool.h>
 #include "rwsem.h"
-#include <linux/types.h>
 #include <linux/bitops.h>
 #include "map.h"
 #include "namespaces.h"
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 902ce6384f57..512ad7c09b13 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -6,7 +6,6 @@
 #include <sys/mman.h>
 #include <zlib.h>
 #include <linux/compiler.h>
-#include <unistd.h>
 
 #include "util/compress.h"
 #include "util/util.h"
-- 
2.17.1

