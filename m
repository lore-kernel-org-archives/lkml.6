Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C07ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455342150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="BRTEDqCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455342150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbeISSFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:05:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32985 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbeISSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:05:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so5623014wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SyHiHPl5T2WwgUlkD2Y7J08DMV8cimo+sXtQLl6dzZM=;
        b=BRTEDqCbm5L9ec+GPF2twctxgYKuXHiCH9GV/fJb8PxJYpCFqfv+dCVRp8ZUkKP10K
         YB5jUQ1NtSWI+933b/i6Q1XJpcYdOMue/kY96MU/6yEiM9y4/J3ZGJMeUFgwb9/XsRzq
         HBqpmEA8OEiX5OFk01QYFO8Zqj+AT5YLA8YDyn7ShpHjwF9UHq3TLD0g3xTKJOAGPXol
         f+MPV3mq5e8RCz73qvN6ilVPZQzqd9pqafRqwUY/ywoEkImT78F6YPnAJAl3P/LJ+tpB
         3cKDx1PIgECiObRXkA+2znUIWSqWSyojrZNg//jI6YbIc8wz1RyvrxMeVe4eGd2U1amO
         zE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SyHiHPl5T2WwgUlkD2Y7J08DMV8cimo+sXtQLl6dzZM=;
        b=GHuAJi5HBReEiXOcJykqV71yePk+9CdhLPDd7Pqjc3JCa4lw7W+B3AkV/F25oCp+3m
         jcqxsucRP2B7+DS1LMxZCeXMPbGUvcJHNqJU9XKWBYxw9cATnZYjgavcIpkqQF8IbYDx
         B354UAX1QPTHVKwfSykXT2x2OpS6/fgH3L1qOt66fYjeBnFf9Bdj5DZMX1PWm9x+6DaM
         byGQKfRpfkPyz6qjeCE4M2+hCvxsyelHQ5mGmeW8bul64Z1DfxYft1tXxcSe09TheUd0
         6qnr+kTmbk7CDxci6blDUbKewrtRU0RfPLGm7vD0KCfnANhJmYHwLEjRz80s3VDZn/61
         ozvw==
X-Gm-Message-State: APzg51DLyuuRFElfwXkHujDyGZkiT0UTGXgM+Jqnq0ETQ6OE50GHqp7n
        eaKETdCQM/FdkIRTFn5+P5WPddj4Am0=
X-Google-Smtp-Source: ANB0VdbL9C97VWM2XSbS7BkWNqvEv5RBaRlQspoauIE631zJJKftAD/GKOhwz/3AKBzWDodkfwLolQ==
X-Received: by 2002:adf:9227:: with SMTP id 36-v6mr29354488wrj.275.1537360077403;
        Wed, 19 Sep 2018 05:27:57 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id l18-v6sm19412403wru.75.2018.09.19.05.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 05:27:56 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
Date:   Wed, 19 Sep 2018 13:27:46 +0100
Message-Id: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

For situations where sysadmins might want to allow different level of
access control for different PMUs, we start creating per-PMU
perf_event_paranoid controls in sysfs.

These work in equivalent fashion as the existing perf_event_paranoid
sysctl, which now becomes the parent control for each PMU.

On PMU registration the global/parent value will be inherited by each PMU,
as it will be propagated to all registered PMUs when the sysctl is
updated.

At any later point individual PMU access controls, located in
<sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
fine grained access control.

Discussion from previous posting:
https://lkml.org/lkml/2018/5/21/156

New in this version:

1. Hopefully fixed build issues in core-book3s.c. (Thanks kbuild test robot!)
2. Perf tool support for new controls, largely contributed by Jiri Olsa.

Tvrtko Ursulin (5):
  perf: Move some access checks later in perf_event_open
  perf: Pass pmu pointer to perf_paranoid_* helpers
  perf: Allow per PMU access control
  perf Documentation: Document the per PMU perf_event_paranoid interface
  tools/perf: Add support for per-PMU access control

 .../sysfs-bus-event_source-devices-events     |  14 +++
 arch/powerpc/perf/core-book3s.c               |  31 ++++--
 arch/x86/events/intel/bts.c                   |   2 +-
 arch/x86/events/intel/core.c                  |   2 +-
 arch/x86/events/intel/p4.c                    |   2 +-
 include/linux/perf_event.h                    |  18 ++-
 kernel/events/core.c                          | 104 +++++++++++++++---
 kernel/sysctl.c                               |   4 +-
 kernel/trace/trace_event_perf.c               |   6 +-
 tools/perf/arch/arm/util/cs-etm.c             |   2 +-
 tools/perf/arch/arm64/util/arm-spe.c          |   2 +-
 tools/perf/arch/x86/util/intel-bts.c          |   2 +-
 tools/perf/arch/x86/util/intel-pt.c           |   2 +-
 tools/perf/util/evsel.c                       |  41 ++++++-
 tools/perf/util/pmu.c                         |  17 +++
 tools/perf/util/pmu.h                         |   1 +
 16 files changed, 204 insertions(+), 46 deletions(-)

-- 
2.17.1

