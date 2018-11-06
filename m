Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BDCC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EA92081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EA92081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbeKGAsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:48:31 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:44293 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbeKGAsb (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 6 Nov 2018 19:48:31 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Tue, 06 Nov 2018 08:22:40 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     akpm@linux-foundation.org, jbaron@akamai.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf-bench: introduce epoll benchmarks
Date:   Tue,  6 Nov 2018 07:22:24 -0800
Message-Id: <20181106152226.20883-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been doing work on epoll, and I've found that most related (micro)benchmarks
are either randomly scattered across the net, or simply non-existent. These patches
are a start to addressing this (more to come). Similar to what we have for futexes,
perf-bench allows kernel developers mainly to quickly test performance changes to the
code in question. Similarly, such programs are not intended for comparing different
IO polling methods. Hence everything is very adhoc and outputs raw microbenchmark
numbers. Also this uses eventfd, similar tools tend to use pipes or sockets, but the
result is the same.

Thanks!

Davidlohr Bueso (2):
  perf-bench: Add epoll parallel epoll_wait benchmark
  perf-bench: Add epoll_ctl(2) benchmark

 tools/perf/Documentation/perf-bench.txt |  10 +
 tools/perf/bench/Build                  |   3 +
 tools/perf/bench/bench.h                |   3 +
 tools/perf/bench/epoll-ctl.c            | 411 ++++++++++++++++++++++++
 tools/perf/bench/epoll-wait.c           | 536 ++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c              |   9 +
 6 files changed, 972 insertions(+)
 create mode 100644 tools/perf/bench/epoll-ctl.c
 create mode 100644 tools/perf/bench/epoll-wait.c

-- 
2.16.4

