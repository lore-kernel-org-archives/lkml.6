Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA51C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7185825DF9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bq/hMMEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7185825DF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966394AbeF0TND (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:13:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37500 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965421AbeF0TM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:12:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id y5-v6so1409319pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TlrWWiQPCjtC68tVmQ7b4F+X4V3UVnh2azcLgqQiihM=;
        b=Bq/hMMEGB/x9xox1vKQmpA8TnWjUQ3cVxD760QU68bDDWQAVR6wgBN6aHeWoKQDwWf
         x3SiCzX21Hc7O5Po2zJoBeYAKx37/PB356xhoZrI+XW+nlrTfa/oSjmijvqwXuFbdM7p
         UU8MCvzxc55L1dlVyLFs81xckxYX0Kzr1iV9OVRNvhez1xceNcKKjNIPs5Dv3potbtfl
         yzvtwCvHZxxtgm0zqmLOVbBKcl9sm5LUe0UqATfRjGeh5E3FwJk/bVq1rVU9sJ1Q/WOD
         735uIGBvJkJA7woiZS0AVa+A0UXnWp+9RPEA9CyrVEIkAjhrk5LsJrUHA9X0pzN+/WMI
         3a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TlrWWiQPCjtC68tVmQ7b4F+X4V3UVnh2azcLgqQiihM=;
        b=c+tlHXkUrOz4PpyFkDalZS1xM5bCQvzaPtk4l7K0M0CoOjI0ZZOnhqEdLMD1h0BGjZ
         Y9sX5SuQwTeXXPl7Ad/7kW9t1/JgRI0zbwZ28QtH8B0tgbMXCGIQ4p+NQRakusHw/jdl
         tuRDbEHiUSqamGgGg+XH8MJSYifUmPiFHzyX2FxYsijritikuDrfY5FJVdExfefXDJ65
         hSTzleixMldl8Uh7/HhQ5F16R+D0MPzRKJarIidzeNtw93jCZS9rnqsvSkeJ9xyZ3Rsd
         t39aD0PZ+LyRj5CfUjLVRqplkm8nT2RkUtW09rFJSkWUQaaYDn/olsk/t1w5lK9TEPvw
         LCRA==
X-Gm-Message-State: APt69E0sX87+UzvvfiwmeaHW0FyJnGPnWAibYvpl4oV7hiBnOJEgVHcx
        vIADE/EO3x9H061SmX1OHNpvpA==
X-Google-Smtp-Source: AAOMgpfO799WQT738v3nYdNrGptJ4ETDeHHnyDhvPeuF0MH6bAKbr9PCDo1nUueKvKYhyXxFTTldvg==
X-Received: by 2002:a62:9c9c:: with SMTP id u28-v6mr7201380pfk.90.1530126778531;
        Wed, 27 Jun 2018 12:12:58 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id l6-v6sm8733667pfc.172.2018.06.27.12.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 12:12:57 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH v8 0/2] Directed kmem charging
Date:   Wed, 27 Jun 2018 12:12:48 -0700
Message-Id: <20180627191250.209150-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel's memory cgroup allows limiting the memory usage of
the jobs running on the system to provide isolation between the jobs.
All the kernel memory allocated in the context of the job and marked
with __GFP_ACCOUNT will also be included in the memory usage and be
limited by the job's limit.

The kernel memory can only be charged to the memcg of the process in
whose context kernel memory was allocated. However there are cases where
the allocated kernel memory should be charged to the memcg different
from the current processes's memcg. This patch series contains two such
concrete use-cases i.e. fsnotify and buffer_head.

The fsnotify event objects can consume a lot of system memory for large
or unlimited queues if there is either no or slow listener. The events
are allocated in the context of the event producer. However they should
be charged to the event consumer. Similarly the buffer_head objects can
be allocated in a memcg different from the memcg of the page for which
buffer_head objects are being allocated.

To solve this issue, this patch series introduces mechanism to charge
kernel memory to a given memcg. In case of fsnotify events, the memcg of
the consumer can be used for charging and for buffer_head, the memcg of
the page can be charged. For directed charging, the caller can use the
scope API memalloc_[un]use_memcg() to specify the memcg to charge for
all the __GFP_ACCOUNT allocations within the scope.

Shakeel Butt (2):
  fs: fsnotify: account fsnotify metadata to kmemcg
  fs, mm: account buffer_head to kmemcg

 fs/buffer.c                          | 15 ++++++-
 fs/notify/dnotify/dnotify.c          |  5 ++-
 fs/notify/fanotify/fanotify.c        | 17 ++++++--
 fs/notify/fanotify/fanotify_user.c   |  5 ++-
 fs/notify/group.c                    |  4 ++
 fs/notify/inotify/inotify_fsnotify.c | 15 ++++++-
 fs/notify/inotify/inotify_user.c     |  5 ++-
 include/linux/fsnotify_backend.h     | 12 ++++--
 include/linux/memcontrol.h           | 14 +++++++
 include/linux/sched.h                |  3 ++
 include/linux/sched/mm.h             | 41 +++++++++++++++++++
 kernel/fork.c                        |  3 ++
 mm/memcontrol.c                      | 60 ++++++++++++++++++++++++++--
 13 files changed, 182 insertions(+), 17 deletions(-)

-- 
2.18.0.rc2.346.g013aa6912e-goog

