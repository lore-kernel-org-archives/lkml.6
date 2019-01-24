Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1B0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9980C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEU93vo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfAXVPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:15:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36433 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfAXVPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:15:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so3477343plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 13:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xO/xPi1H9RcNh3zL0bmtPchp8X0vIpi2bmKGvABys10=;
        b=nEU93vo9p1DcR+610e4VL627dSQ3fC1I2asgSaFjUWi4z8xBZmpbzT1frZ2MDGNByX
         8posn5i2ohAcTxoWWwj4UvqlcfIFKFCmvAt3kLd01Pk6Dsy1ZF2ID7VJH4Q6CHnzG64i
         oWOI7QJQwqJ4xz0mOWcXzel1GuFklJ6xYsgj4waaHRSB0B1AU3CvfqF/ow+AqO1ov6kY
         rNpJ1cPOT1qFOLTVDqxjspdFbVXmmDwk+97A0e4Ut4cJm04TH2EnkPuCxGb/dincba2K
         pjZqQMLs8h794KA62MZm5LXikOYg7Cb77228LjWdROmB+LoXMm2TSCOxJOEAp7db4pK7
         DGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xO/xPi1H9RcNh3zL0bmtPchp8X0vIpi2bmKGvABys10=;
        b=ZoTzzt5/XUth+ygP4Vw7EFqxY3xBlL+BYsOCgD+thFdeaxeMO4JmQwxltYXFgL7a4u
         NJWHpzl3HuoKnj9oVfi+uINJtP3aZfazEaDHMPXiEupgBhLonEfEjN5I1+sZ/9KRt/Mv
         K1CLHWQEGGfxsUEeZQzvQzskZBxSqBhzt+LkR5kUtBTbQr+xKoBdNdjNXxuy+YkVi568
         JKMQBKYioodj3P2SEnN8dsK+5Pf1RSf1Wp8WXz+g1y+XF7B6Y8Zfg67L9RzUdOxUV1Yo
         XustNeuHBhNJUKqlbvqVDe/Uy0DM/xZugZCXDPxV7H3qgFOv+SFGDqNibb0xZBr73B7x
         tEKg==
X-Gm-Message-State: AJcUukc18E74GiFt6JgsGTyPGT5QzNOQktS/be8KAtWPzNF1K7Y6e4OM
        Cq/NqAMm1PSq+/ZyKJs6bx4TuQ==
X-Google-Smtp-Source: ALg8bN61idbTluJOJwYMGOZ1awTthKG4I4dpmY3hOSMr3gMUs1dElf+ZY2FrGHicAlxE6OKULRh2Ig==
X-Received: by 2002:a17:902:4624:: with SMTP id o33mr7963957pld.289.1548364539901;
        Thu, 24 Jan 2019 13:15:39 -0800 (PST)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:3320:4357:47df:276b])
        by smtp.googlemail.com with ESMTPSA id j197sm29626418pgc.76.2019.01.24.13.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:15:38 -0800 (PST)
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 0/5] psi: pressure stall monitors v3
Date:   Thu, 24 Jan 2019 13:15:13 -0800
Message-Id: <20190124211518.244221-1-surenb@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is respin of:
  https://lwn.net/ml/linux-kernel/20190110220718.261134-1-surenb@google.com/

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
 kernel/sched/psi.c               | 605 ++++++++++++++++++++++++++++---
 8 files changed, 891 insertions(+), 71 deletions(-)

Changes in v3:
- Added smp_mb in the slowpath, as per Peter
- Changed psi_group.polling flag to atomic_t, as per Peter
- Added a comment in the hotpath about implicit smp_wmb in the
chmxchg, as per Johannes
- Minimized line-breaks wherever possible, as per Peter

-- 
2.20.1.321.g9e740568ce-goog

