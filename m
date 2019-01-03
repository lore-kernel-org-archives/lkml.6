Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C676C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFF020815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbfACPAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:00:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:32980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730737AbfACPAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:00:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CB01AC8D;
        Thu,  3 Jan 2019 15:00:36 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf bench: Add epoll-wait-mp1c benchmark calling epoll_wait(2)
Date:   Thu,  3 Jan 2019 16:00:28 +0100
Message-Id: <20190103150030.17030-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intention of a new benchmark is to measure events delivery
bandwidth: N threads produce events and 1 thread consumes events
calling epoll_wait(2).

Benchmark does measurements for 8, 16, 32, 64 and 128 threads in
a loop.

This one differs from epoll-wait in that it produces events from
many threads and consumes from one, thus mp1c (many producers
1 consumer).

Roman Penyaev (2):
  perf bench: rename epoll-wait bench to epoll-wait-1pmc
  perf bench: Add epoll-wait-mp1c benchmark calling epoll_wait(2)

 tools/perf/bench/Build                        |   3 +-
 tools/perf/bench/bench.h                      |   3 +-
 .../bench/{epoll-wait.c => epoll-wait-1pmc.c} |   6 +-
 tools/perf/bench/epoll-wait-mp1c.c            | 175 ++++++++++++++++++
 tools/perf/builtin-bench.c                    |   3 +-
 5 files changed, 186 insertions(+), 4 deletions(-)
 rename tools/perf/bench/{epoll-wait.c => epoll-wait-1pmc.c} (98%)
 create mode 100644 tools/perf/bench/epoll-wait-mp1c.c

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: linux-kernel@vger.kernel.org
-- 
2.19.1

