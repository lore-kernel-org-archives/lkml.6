Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A8DC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691A220989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131733;
	bh=+TDBo+77Qvjpkhgasz4TbA+ZKLN3nDEviGDXoS9otew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AUY51ZtFgBSnKUe08D0v2Dwfh01cgZHgk60nKPdX0wFfkbLTknMZnQ7wiGHMi0Mdt
	 8C1t8/QQeYhsRbnaNtvOwCB7zjJ67wW5s+j1LxyogjevZboEpqWBQ1srBf/Wm7yIWV
	 rIplUv+zdvythnG+KkpbKfQOgRU9tovdYiHcheN4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691A220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeLFV2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbeLFV2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:28:51 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0491208E7;
        Thu,  6 Dec 2018 21:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131730;
        bh=+TDBo+77Qvjpkhgasz4TbA+ZKLN3nDEviGDXoS9otew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gXX+4CKEo1A8iXySA2pBr49RKY6+DOqiQE3fjs13JOjdyZLBuNTARHXd7vcIiH0f0
         ZRvtd1dMGNMXxwJBeL1fqWPCap1qgxPggcLrwQSYQ9YhgHYuoM/XrQ/oFPcZZMA2A7
         xUSAQQ9pm8aM+dYWCDJYMN3HlkG0mo8750KSsqbI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sihyeon Jang <uneedsihyeon@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/75] perf beauty mmap_flags: Fixed syntax error Fixed missing ']' error
Date:   Thu,  6 Dec 2018 18:25:21 -0300
Message-Id: <20181206212602.20474-35-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sihyeon Jang <uneedsihyeon@gmail.com>

Committer testing:

Before:

  # tools/perf/trace/beauty/mmap_flags.sh
  static const char *mmap_flags[] = {
	[ilog2(0x40) + 1] = "32BIT",
  tools/perf/trace/beauty/mmap_flags.sh: line 23: [: missing `]'
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x10) + 1] = "FIXED",
	[ilog2(0x20) + 1] = "ANONYMOUS",
	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
  tools/perf/trace/beauty/mmap_flags.sh: line 28: [: missing `]'
	[ilog2(0x0100) + 1] = "GROWSDOWN",
	[ilog2(0x0800) + 1] = "DENYWRITE",
	[ilog2(0x1000) + 1] = "EXECUTABLE",
	[ilog2(0x2000) + 1] = "LOCKED",
	[ilog2(0x4000) + 1] = "NORESERVE",
	[ilog2(0x8000) + 1] = "POPULATE",
	[ilog2(0x10000) + 1] = "NONBLOCK",
	[ilog2(0x20000) + 1] = "STACK",
	[ilog2(0x40000) + 1] = "HUGETLB",
	[ilog2(0x80000) + 1] = "SYNC",
  };
  #

After:

  $ tools/perf/trace/beauty/mmap_flags.sh
  static const char *mmap_flags[] = {
	[ilog2(0x40) + 1] = "32BIT",
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x10) + 1] = "FIXED",
	[ilog2(0x20) + 1] = "ANONYMOUS",
	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
	[ilog2(0x0100) + 1] = "GROWSDOWN",
	[ilog2(0x0800) + 1] = "DENYWRITE",
	[ilog2(0x1000) + 1] = "EXECUTABLE",
	[ilog2(0x2000) + 1] = "LOCKED",
	[ilog2(0x4000) + 1] = "NORESERVE",
	[ilog2(0x8000) + 1] = "POPULATE",
	[ilog2(0x10000) + 1] = "NONBLOCK",
	[ilog2(0x20000) + 1] = "STACK",
	[ilog2(0x40000) + 1] = "HUGETLB",
	[ilog2(0x80000) + 1] = "SYNC",
  };
  $

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: aca70cc40a0b ("perf beauty mmap_flags: Check if the arch has a mmap.h file")
Link: http://lkml.kernel.org/r/20181202080651.4685-1-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap_flags.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index cd41023107d7..32bac9c0d694 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -20,12 +20,12 @@ egrep -q $regex ${arch_mman} && \
 (egrep $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} ] &&
+([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman-common.h | \
 	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} ] &&
+([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-- 
2.19.2

