Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F32C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16CF26D4A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="E3A6gkw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16CF26D4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeFZPhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:37:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35635 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbeFZPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:37:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id z137-v6so2356954wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TnyDPwlhFnYJWpAuAR/kdT6H9t0g4ev/rss4zkCF3K8=;
        b=E3A6gkw3aCFnXmsaI0r2PIn0I/zdA//00Hg5qVXrUynRgFl8VMdvf9L5UvCERRvk0j
         V0DThrVEwYV6fPEZxHb+UrmRC8Bo8zo2dj1dfdMfnW0ae4Tqoqq2PUCsoxWhYKM5t69y
         qe8iPSXcjuWXz9idKVG2Vj4YS9lcYNJUfuji/jnVlMpWM6yTOyO4xcnlHc9b+iXQZ/SE
         Es+50SJhAtSiGai/mXMUk3mwgHXYHL31Ua8LXACGfX3hA9P6S1ITvreWaMVas+D26C3T
         HbSBwDlyNAoXzHJJIy2f6qRdIVDIuymku4SU2TRHUuYalPAoLX9dnU1H9s6te8GlLbJx
         Da6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TnyDPwlhFnYJWpAuAR/kdT6H9t0g4ev/rss4zkCF3K8=;
        b=CThNxk2SoULZoM142ekrQKq8mghksN0VR9RT2Kh77nfsRf7fxHmAKyERsa+0Xjm6bo
         1kponLHdV5T+ku2RCOlAsfzYTJDBJOHqJ8qGkReyoqewpyQgpKZKCmnaLdUrRDmCtKKe
         RewKCPNyqVLyHudoJZbnzErawfneo0u5k4f8L9YIojerqxy+Lkc99UYy5k5F5tMtaBSy
         3OJY94LhP7q5PvMEUCLlSHQ3HSeSz53fYFmNaDXpA0ses+hOT+W4tcL53sN5vNzIYEA1
         tDACx9A/araNrZVWUpAPTeLWYZBV3My+cJGmKeZEdkANexsQMAIqeJi8o21JLr6Wk/+n
         3TKA==
X-Gm-Message-State: APt69E1PybqYbaHKRmkh9XJgkeKGEdFX0BdRnMlCS0YwqOPE2E+i+xg0
        GZkPvz9vrKSPj0td7I9BU1hje2uh
X-Google-Smtp-Source: AAOMgpcNJKN41rHl5aP8/j0XqiJUIubAch6NLrfzZkfzNX7tXyLkV9Ylu4SAtyZ7r2psddQwKGKfYQ==
X-Received: by 2002:a1c:f513:: with SMTP id t19-v6mr2176522wmh.50.1530027435811;
        Tue, 26 Jun 2018 08:37:15 -0700 (PDT)
Received: from localhost.localdomain ([95.146.151.144])
        by smtp.gmail.com with ESMTPSA id l84-v6sm3411176wmi.3.2018.06.26.08.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 08:37:15 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        x86@kernel.org
Subject: [RFC 0/4] perf: Per PMU access controls (paranoid setting)
Date:   Tue, 26 Jun 2018 16:36:38 +0100
Message-Id: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org

Tvrtko Ursulin (4):
  perf: Move some access checks later in perf_event_open
  perf: Pass pmu pointer to perf_paranoid_* helpers
  perf: Allow per PMU access control
  perf Documentation: Document the per PMU perf_event_paranoid interface

 .../sysfs-bus-event_source-devices-events     |  14 +++
 arch/powerpc/perf/core-book3s.c               |   2 +-
 arch/x86/events/intel/bts.c                   |   2 +-
 arch/x86/events/intel/core.c                  |   2 +-
 arch/x86/events/intel/p4.c                    |   2 +-
 include/linux/perf_event.h                    |  18 ++-
 kernel/events/core.c                          | 104 +++++++++++++++---
 kernel/sysctl.c                               |   4 +-
 kernel/trace/trace_event_perf.c               |   6 +-
 9 files changed, 123 insertions(+), 31 deletions(-)

-- 
2.17.1

