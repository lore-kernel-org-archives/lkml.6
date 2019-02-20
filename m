Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F22C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E65C2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550665685;
	bh=Ia8uKhSJomID19sZRLlRsWmX2Ctz8qYCQr1sMelWhWU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EWIg4JCwHmNzBYtcXAWzAhO1nOMd5zQblR1YvCrarSRfCFHkwwykk819IVf3ZFjRV
	 spHDUBOt0HTqXK/u11rQ9nt0KR6/XfBH1rchXyflsUQYObkZQip2Ying6bIbAf6lol
	 tMdJO1wNcuM1InTH4I4KparU+xlzDOThCogmiDg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfBTM2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:28:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbfBTM2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:28:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04EE1C058CB0;
        Wed, 20 Feb 2019 12:28:03 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0994260139;
        Wed, 20 Feb 2019 12:28:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 0/6] perf tools: Assorted fixes
Date:   Wed, 20 Feb 2019 13:27:54 +0100
Message-Id: <20190220122800.864-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 20 Feb 2019 12:28:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending assorted general fixes that queued
up in my other branches.

Also available in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
Jiri Olsa (6):
      perf tools: Don't report zero period samples for slave events
      perf tools: Force sample_type for slave events
      perf script: Allow +- operator for type specific fields option
      perf tools: Add missing new line into pr_debug call
      perf tools: Increase debug leve for cpu_map__snprint verbose output
      perf tools: Make rm_rf to remove single file

 tools/perf/Documentation/perf-script.txt |  6 ++++++
 tools/perf/builtin-script.c              |  8 ++++++++
 tools/perf/util/bpf-event.c              |  2 +-
 tools/perf/util/cpumap.c                 |  2 +-
 tools/perf/util/evsel.c                  |  8 ++++++++
 tools/perf/util/session.c                |  7 +++++++
 tools/perf/util/util.c                   | 16 +++++++++++++---
 7 files changed, 44 insertions(+), 5 deletions(-)
