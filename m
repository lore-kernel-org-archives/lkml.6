Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1739C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D62020672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IpX7xQhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D62020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeKZWOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:14:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37869 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeKZWOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:14:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so6040899pge.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 03:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lbcHjmRHOZ8i9kgVT+7xnTpXgIMdWRMHmgAhb0nftFY=;
        b=IpX7xQhlpIp8uTK0U230tWBYBAOdvdBEUzP0zkOY1808uNdQLJmk5ihomY7FtA6dsC
         ytyT86CV3StEOPW+Y0G9dt9QMrrJadPSVnEAgiac/NJ7pEp9mISXwyp2HOevlpJ4awoH
         TbgsNAVd+VCfXcZO8gzShqag+Csc60AKzPGoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lbcHjmRHOZ8i9kgVT+7xnTpXgIMdWRMHmgAhb0nftFY=;
        b=csWgrZA+WasVSHW40yyDwr0oDg3F10TwSERFGjdTfAkZR006BvievtGgSsVCwDYEDI
         7s/6qV6B++ZutxUIWQqGXs/BklIhzw4+kq7uMN6zDuyugYDv8DMFnY1BtZiAvoNuf90i
         WMw7JyCpTySwh7e1/xTwLge2B2SRet9HMG6OadMfm+8neTooeniwhOD5J99usXC/Nw5d
         STcKfLq1MhJX+XgKUDEGiQS5+cYvLUbp6YgfVZK/umSh7vN3BIcCAb0vyn7PlrZm3BXu
         BTJ2F245Bww3nFuCBdDQOkyjEezG6ORvcujkONoIxOXhRa3wKqPTEEBzjBOKsQ5gglpz
         Z62w==
X-Gm-Message-State: AA+aEWb0R9YeGUQ6s9jEbgIYlYbR1reaF0tiamUtf8W0GJdOc/AGYXV9
        frwe/tFySMoGpV23lWIiKCrBXhbDKMM=
X-Google-Smtp-Source: AFSGD/Xou55bajDCZTGRABCYWy6rhSs+Kt29WHBE/NCQeGBq/LOEqynAxDGL2LipPFxTvlApeny+1g==
X-Received: by 2002:a63:e615:: with SMTP id g21mr24770067pgh.290.1543231263133;
        Mon, 26 Nov 2018 03:21:03 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id m129-v6sm11780pfm.78.2018.11.26.03.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 03:21:02 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com
Subject: [RFC][PATCH 0/2] sched: Power optimizations with SCHED_IDLE
Date:   Mon, 26 Nov 2018 16:50:22 +0530
Message-Id: <cover.1543229820.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The intention behind sending this series is to get some initial feedback
on the idea of specially handling CPUs which only have SCHED_IDLE
activity enqueued on them, before investing too much effort on it. The
current implementation handles very few code-paths and there is a lot
more that we would need to do to make it work well for us.

This allows enqueuing more tasks to a CPUs which only have tasks with
SCHED_IDLE policy currently, as the new tasks should run on them without
any significant delays. And this avoids waking up an otherwise idle CPU,
hence save power without impacting performance.

We don't have lots of SCHED_IDLE tasks in Android currently, but it
should be possible to convert a few of the background tasks and take
advantage of this feature.

Only basic testing is done with the help of rt-app [1] currently to make
sure the task is getting placed correctly.

--
viresh

Viresh Kumar (2):
  sched: Start tracking SCHED_IDLE tasks count in cfs_rq
  sched: Enqueue tasks on a cpu with only SCHED_IDLE tasks

 kernel/sched/core.c  | 23 ++++++++++++++++
 kernel/sched/fair.c  | 64 +++++++++++++++++++++++++++++++++-----------
 kernel/sched/sched.h |  5 ++++
 3 files changed, 76 insertions(+), 16 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

[1] json: https://pastebin.ubuntu.com/p/Y4fr9xddV8/

