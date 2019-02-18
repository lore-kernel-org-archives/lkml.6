Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA90FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A838520C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550489971;
	bh=bJ5b8et9qP40oBoU5Wfc/GCAwM9pc/JtlLmc4vOI4FQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rWDPpSXC4bWk7dSuFIkUzcycQS7VYpMMoOLU+m0K9pOyNAjoekhU/KsBaB5/V6HF1
	 IocbOvN+7iwoIj8mIuBn8OyActMdjh6MFdZlTyANvQQT8AtlGanF2v9ovHDGISJKI1
	 aujbNPFtPYG1vdx4Tp4XMXpkgRzwGpOJp78nIJzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfBRLja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:39:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbfBRLj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:39:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71C5FA5D9D;
        Mon, 18 Feb 2019 11:39:29 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB8485D70A;
        Mon, 18 Feb 2019 11:39:27 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCHv2 0/3] perf tools: Assorted fixes
Date:   Mon, 18 Feb 2019 12:39:24 +0100
Message-Id: <20190218113927.30841-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 18 Feb 2019 11:39:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending assorted general fixes that queued
up in my other branches.

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
Jiri Olsa (3):
      perf header: Fix wrong node write in NUMA_TOPOLOGY feature
      perf tools: Add cpu_topology object
      perf tools: Add numa_topology object

 tools/perf/util/Build     |   1 +
 tools/perf/util/cputopo.c | 264 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cputopo.h |  33 ++++++++++++++++++++++
 tools/perf/util/header.c  | 269 ++++++++++++++++++++--------------------------------------------------------------------------------------------------------------------------------------------------------------
 4 files changed, 328 insertions(+), 239 deletions(-)
 create mode 100644 tools/perf/util/cputopo.c
 create mode 100644 tools/perf/util/cputopo.h
