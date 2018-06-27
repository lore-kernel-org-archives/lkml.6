Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A63C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671CE25D31
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="XFqqNDQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671CE25D31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934903AbeF0TJq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:09:46 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:38423 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934346AbeF0TJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:09:43 -0400
Received: by mail-qt0-f181.google.com with SMTP id c5-v6so2635112qth.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=eRQlFC2GJJfnG3FZSm0lGTBq3J0Mvh084K0x1yVBBWM=;
        b=XFqqNDQZ8Bw264jgucgsYR3NSq47RVmEcuuaOGHb5xqoxnNhAW6Fckkxnb+6D3uyxc
         uqKOVNZY9vXTcStv7S928lb5cQ1JW1JajtQui1glsLL8hTDITnD/4Gr0SVde6M8BrI5A
         yjdzi+7Yhqc4gget8kNzjNJl7ui5WGIR7TBY5Y5uy6ftoZFJTxql1juLGhRu59EwNudI
         iPbn3/xuR86eFI5y8POxLy+V9IrIaWZGFbu1inNu2dCICzKF5/Ks+wBhSJPSn7t1EClr
         uWQmuXtvBot4fgUP3iNc8ppYHbmZGEt9/39xDXtprIhgI/VhzmjqpZkA8wT2srxFqm81
         RhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=eRQlFC2GJJfnG3FZSm0lGTBq3J0Mvh084K0x1yVBBWM=;
        b=Un3NQV85kdErOUxJPdzqwGEowC1iyPx99NNDZykQX/+xL2wD0zE9QDDZ/qtqKw9vTw
         FP5aETTTYk76Pfv3Uka6a2xwIGZ+C9h7DJBhKcwmvHrTE5L1MasjvVmOY56rCYaRxkUb
         oT/aRl4dvw8yTDn5Qi96jw97Y2qzgM/DzOmRKIL+3mOZQ4MccDRiBVUVTZRcBL63fniB
         /jXVB7rt0Tye82Z4anm0Bho13mgzH8ASDcwLQIQqRcZYE/ndUmDa1X0NQKoGlCKR+RKo
         6uFwts14HO8RrwiZmG0Cu4eK+QRNJS7ZxE5XBMYZJoPfMN+wfTGAH3KPDHq05JRgpNj2
         dybw==
X-Gm-Message-State: APt69E1qDFi3lOOBUZNPT9O6vcWQZipeUuRUUNrt93UbB/JYQajQc2Iv
        wTKo4eP2ukzh7ol0v95tqqB3vA==
X-Google-Smtp-Source: AAOMgpdBLfUrY12wQ0mUtNqDIiNjdZh6j1VaYd5Eu0RDvKgRTr7dX1p4UCLRSLpu2W21GRBgzs5xug==
X-Received: by 2002:a0c:e588:: with SMTP id t8-v6mr6499843qvm.69.1530126582919;
        Wed, 27 Jun 2018 12:09:42 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n21-v6sm4120436qtn.34.2018.06.27.12.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:09:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/14][V4] Introduce io.latency io controller for cgroups
Date:   Wed, 27 Jun 2018 15:09:26 -0400
Message-Id: <20180627190940.4696-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes, just fixing some panic's in configurations we weren't
testing in production.

v3->v4:
- deal with a child having a configuration but the parent not.
- fix use of setup_timer, there was an API change between the kernel I
  wrote/tested these patches on and the current kernel.
- change the initialization location for iolatency.
- fix some spelling mistakes in the documentation.

v2->v3:
- added "skip readahead if the cgroup is congested".  During testing we would
  see stalls on taking mmap_sem because something was doing 'ps' or some other
  such thing and getting stuck because the throttled group was getting hit
  particularly hard trying to do readahead.  This is a weird sort of priority
  inversion, fixed it by skipping readahead if we're currently congested to not
  only help the overall latency of the throttled group, but reduce the priority
  inversion associated with higher priority tasks getting stuck trying to read
  /proc files for tasks that are stuck.
- added "block: use irq variant for blkcg->lock" to address a lockdep warning
  seen during testing.
- add a blk_cgroup_congested() helper to check for congestion in a hierarchical
  way.
- Fixed some assumptions related to accessing blkg out of band that resulted in
  panics.
- Made the throttling stuff only throttle if the group has done a decent amount
  of IO in the last window.
- Fix the wake up logic to reduce the thundering herd issues we saw in testing.
- Put a limit on how much of a hole we can dig into the artificial delay stuff.
  We were seeing in multiple back to back tests that we'd get so deep into the
  delay count that we'd take hours to unthrottle.  This stuff was originally
  introduced to keep us from flapping from delay to no delay if we had bursty
  behavior from the misbehaving group, so capping this keeps that protection
  while also keeping us from throttling forever.
- Limit the maximum delay to 250ms from 1 second.  There was a bug in the
  congestion checking stuff, it wasn't taking into account the hierarchy so we
  would sometimes not throttle when we needed to, which led me to have a 1
  second maximum.  However when that bug was fixed it turned out 1 second was
  too much, so limit to 250ms like balance dirty pages does.

v1->v2:
- fix how we get the swap device for the page when doing the swap throttling.
- add a bunch of comments how the throttling works.
- move the documentation to cgroup-v2.txt
- address the various other comments.

==== Original message =====

This series adds a latency based io controller for cgroups.  It is based on the
same concept as the writeback throttling code, which is watching the overall
total latency of IO's in a given window and then adjusting the queue depth of
the group accordingly.  This is meant to be a workload protection controller, so
whoever has the lowest latency target gets the preferential treatment with no
thought to fairness or proportionality.  It is meant to be work conserving, so
as long as nobody is missing their latency targets the disk is fair game.

We have been testing this in production for several months now to get the
behavior right and we are finally at the point that it is working well in all of
our test cases.  With this patch we protect our main workload (the web server)
and isolate out the system services (chef/yum/etc).  This works well in the
normal case, smoothing out weird request per second (RPS) dips that we would see
when one of the system services would run and compete for IO resources.  This
also works incredibly well in the runaway task case.

The runaway task usecase is where we have some task that slowly eats up all of
the memory on the system (think a memory leak).  Previously this sort of
workload would push the box into a swapping/oom death spiral that was only
recovered by rebooting the box.  With this patchset and proper configuration of
the memory.low and io.latency controllers we're able to survive this test with a
at most 20% dip in RPS.

There are a lot of extra patches in here to set everything up.  The following
are just infrastructure that should be relatively uncontroversial

[PATCH 01/13] block: add bi_blkg to the bio for cgroups
[PATCH 02/13] block: introduce bio_issue_as_root_blkg
[PATCH 03/13] blk-cgroup: allow controllers to output their own stats

The following simply allow us to tag swap IO and assign the appropriate cgroup
to the bio's so we can do the appropriate accounting inside the io controller

[PATCH 04/13] blk: introduce REQ_SWAP
[PATCH 05/13] swap,blkcg: issue swap io with the appropriate context

This is so that we can induce delays.  The io controller mostly throttles based
on queue depth, however for cases like REQ_SWAP/REQ_META where we cannot
throttle without inducing a priority inversion we have a mechanism to "back
charge" groups for this IO by inducing an artificial delay at user space return
time.

[PATCH 06/13] blkcg: add generic throttling mechanism
[PATCH 07/13] memcontrol: schedule throttling if we are congested

This is more moving things around and refactoring, Jens you may want to pay
close attention to this to make sure I didn't break anything.

[PATCH 08/13] blk-stat: export helpers for modifying blk_rq_stat
[PATCH 09/13] blk-rq-qos: refactor out common elements of blk-wbt
[PATCH 10/13] block: remove external dependency on wbt_flags
[PATCH 11/13] rq-qos: introduce dio_bio callback

And this is the meat of the controller and it's documentation.

[PATCH 12/13] block: introduce blk-iolatency io controller
[PATCH 13/13] Documentation: add a doc for blk-iolatency

Jens, I'm sending this through your tree since it's mostly block related,
however there are the two mm related patches, so if somebody from mm could weigh
in on how we want to handle those that would be great.  Thanks,

Josef
