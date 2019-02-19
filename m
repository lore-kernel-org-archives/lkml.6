Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E0EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2F62146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550570300;
	bh=0e9r504zVP2I44pn99ywKwe7UzeucM/cV++WgEaOhjI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XCq6ItMIZIxBujSXtWOyGO3UYLYyN1yiGbANF7+AGl6e5aLvmCvFTZndp3MnzSb5c
	 Jo7WTk1pxb4mYK1uZrDU9+L+h8JAWIXm4JL1LGDqkwLU/sPOD1g8msCrpBLxaJkeMo
	 f3PKSzBko20zGb7XX+3w+ugKKrAlyVXKB5HjP/e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfBSJ6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:58:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfBSJ6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:58:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFDE53B73B;
        Tue, 19 Feb 2019 09:58:18 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3A4C600C8;
        Tue, 19 Feb 2019 09:58:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCHv3 0/4] perf tools: Assorted fixes
Date:   Tue, 19 Feb 2019 10:58:11 +0100
Message-Id: <20190219095815.15931-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 19 Feb 2019 09:58:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending assorted general fixes that queued
up in my other branches.

v3 changes:
  - fix for fixes found by Namhyung
  - new patch to use sysfs__mountpoint

v2 changes:
  - renamed the interface to struct cpu_topology/numa_topology
    plus related changes in function names
  - adding missing Fixes tag

Also available in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
Jiri Olsa (4):
      perf header: Fix wrong node write in NUMA_TOPOLOGY feature
      perf tools: Add cpu_topology object
      perf tools: Add numa_topology object
      perf tools: Use sysfs__mountpoint() when reading cpu topology

 tools/perf/util/Build     |   1 +
 tools/perf/util/cputopo.c | 277 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cputopo.h |  33 ++++++++++++++++++++++
 tools/perf/util/header.c  | 269 ++++++++++++++++++++--------------------------------------------------------------------------------------------------------------------------------------------------------
 4 files changed, 341 insertions(+), 239 deletions(-)
 create mode 100644 tools/perf/util/cputopo.c
 create mode 100644 tools/perf/util/cputopo.h
