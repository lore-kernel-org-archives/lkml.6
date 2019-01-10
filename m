Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B600C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB34205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crAkPTvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfAJWH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:07:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39855 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbfAJWHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:07:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so5779283pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ig5qBTqAOOl2ALQFgSUOe0w9ro7QA1aOFe2gQIbsj8Y=;
        b=crAkPTvPLfl2A5lFXysX3vaxjF/2y1f3sxNNf1vPvrnJgrf1xy0zKoKE0zzMIP8sS4
         0S4/4dPxl8/cpbT2+JIamABRXt4zrS5tHeKi87QxVixpM8yUAq1DkjhfZCKFm3gr/FEf
         r83CtOyVbwKYyJrYqv5cQI+2NexV0ZWdKBlYrAizrbZ1vMfqm8xh1WQK+W4l2XUDA73F
         EaY+oWW1RgTZl8J/azSIUL/Kstz71dOR7Hd7iLpZyF7k2F4Boy6FL/vx9o8H56KDhfPC
         dVpshDaNnUqN8JlZA++d4n+h8jU7ydNXmt4QX2GlX88chDJ+D4pRC1IsvTCI2aE7T49c
         EAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ig5qBTqAOOl2ALQFgSUOe0w9ro7QA1aOFe2gQIbsj8Y=;
        b=swJs0GOKqR4HIo3ehlVLWuD5Yf3nHsgK3bqKlBuKFpP1WgsoZU+wrE27MJIfdT0v1K
         1JFuOnFYEzL5E8AwtJls+QJDA/+0/+RLj29gYoVjnaqaa7xcBuHRgDzrh36D7vp3nUeC
         1TuavsdcZ9pxzC0lxuijBbwgPd7r5Rklb1wGpTHabZuiyHcqNMvhcX55N81slchHGXS7
         2jA2sqBsdjThc1DZHnAGXdhFJYHpZxJls0BuBttC4IINfrT76OEJ1+vXHro5OqiQ9fvW
         +kw6MCMzBbqGJK13NwkEOYRr9fu434HhVomjC3N6UH62sQmMvxq3gAibxtUcla0/Dq20
         HClg==
X-Gm-Message-State: AJcUukeF0hMKm5uh6O2f4ziPo0PXa8dWYZKUUSqCJFVvfoOBjJeMVUqC
        0LVQBpKhpkB+cqIFYiEceRkYng==
X-Google-Smtp-Source: ALg8bN73ksNs0MN12T2hkHxqycU/FXXGxYcKJ+wlnrOwmW+OoBldscti3YwBq5ZkSW4B9iPNx51+KA==
X-Received: by 2002:a17:902:6b87:: with SMTP id p7mr12264757plk.282.1547158074549;
        Thu, 10 Jan 2019 14:07:54 -0800 (PST)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:3320:4357:47df:276b])
        by smtp.googlemail.com with ESMTPSA id p7sm152958019pfj.72.2019.01.10.14.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:07:53 -0800 (PST)
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 0/5] psi: pressure stall monitors v2
Date:   Thu, 10 Jan 2019 14:07:13 -0800
Message-Id: <20190110220718.261134-1-surenb@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is respin of:
  https://lwn.net/ml/linux-kernel/20181214171508.7791-1-surenb@google.com/

Android is adopting psi to detect and remedy memory pressure that
results in stuttering and decreased responsiveness on mobile devices.

Psi gives us the stall information, but because we're dealing with
latencies in the millisecond range, periodically reading the pressure
files to detect stalls in a timely fashion is not feasible. Psi also
doesn't aggregate its averages at a high-enough frequency right now.

This patch series extends the psi interface such that users can
configure sensitive latency thresholds and use poll() and friends to
be notified when these are breached.

As high-frequency aggregation is costly, it implements an aggregation
method that is optimized for fast, short-interval averaging, and makes
the aggregation frequency adaptive, such that high-frequency updates
only happen while monitored stall events are actively occurring.

With these patches applied, Android can monitor for, and ward off,
mounting memory shortages before they cause problems for the user.
For example, using memory stall monitors in userspace low memory
killer daemon (lmkd) we can detect mounting pressure and kill less
important processes before device becomes visibly sluggish. In our
memory stress testing psi memory monitors produce roughly 10x less
false positives compared to vmpressure signals. Having ability to
specify multiple triggers for the same psi metric allows other parts
of Android framework to monitor memory state of the device and act
accordingly.

The new interface is straight-forward. The user opens one of the
pressure files for writing and writes a trigger description into the
file descriptor that defines the stall state - some or full, and the
maximum stall time over a given window of time. E.g.:

        /* Signal when stall time exceeds 100ms of a 1s window */
        char trigger[] = "full 100000 1000000"
        fd = open("/proc/pressure/memory")
        write(fd, trigger, sizeof(trigger))
        while (poll() >= 0) {
                ...
        };
        close(fd);

When the monitored stall state is entered, psi adapts its aggregation
frequency according to what the configured time window requires in
order to emit event signals in a timely fashion. Once the stalling
subsides, aggregation reverts back to normal.

The trigger is associated with the open file descriptor. To stop
monitoring, the user only needs to close the file descriptor and the
trigger is discarded.

Patches 1-4 prepare the psi code for polling support. Patch 5
implements the adaptive polling logic, the pressure growth detection
optimized for short intervals, and hooks up write() and poll() on the
pressure files.

The patches were developed in collaboration with Johannes Weiner.

The patches are based on 4.20-rc7.

Johannes Weiner (2):
  fs: kernfs: add poll file operation
  kernel: cgroup: add poll file operation

Suren Baghdasaryan (3):
  psi: introduce state_mask to represent stalled psi states
  psi: rename psi fields in preparation for psi trigger addition
  psi: introduce psi monitor

 Documentation/accounting/psi.txt | 104 ++++++
 fs/kernfs/file.c                 |  31 +-
 include/linux/cgroup-defs.h      |   4 +
 include/linux/kernfs.h           |   6 +
 include/linux/psi.h              |  10 +
 include/linux/psi_types.h        |  83 ++++-
 kernel/cgroup/cgroup.c           | 119 +++++-
 kernel/sched/psi.c               | 597 ++++++++++++++++++++++++++++---
 8 files changed, 885 insertions(+), 69 deletions(-)

Changes in v2:
- Preserved psi idle mode, as per Peter
- Changed input parser to use sscanf, as per Peter
- Removed percentage threshold support, as per Johannes and Joel
- Added explicit numbers corresponding to NR_PSI_TASK_COUNTS,
NR_PSI_RESOURCES and NR_PSI_STATES, as per Peter
- Added a note about psi_group_cpu struct new size in the changelog
of the patch introducing new member (0003-...), as per Peter
- Fixed 64-bit division using div_u64, as per kbuild test robot

-- 
2.20.1.97.g81188d93c3-goog

