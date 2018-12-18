Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4481CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB18218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171117;
	bh=48sIt9bqyo0zhDeAdrUYVkYlqmB4Oe5PoXxpkowaYXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YD24Nh8y2PjWkMSFvuPHIUBGTJPAAZQsa5SMkPTmo9OJCSOAG9JUn2vYPmw6WRben
	 ITxDe22J4T4goOALYiYAXjJNj1uqWVlv17+SYFmr8hLoz7rSsOAXkTd0FdIqD80ekS
	 GC2Ej/LtTO4s3R4KrdspSHEKM/UKbPF3NVBUEf/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeLRWL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:11:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbeLRWLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:11:55 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8629A21871;
        Tue, 18 Dec 2018 22:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171114;
        bh=48sIt9bqyo0zhDeAdrUYVkYlqmB4Oe5PoXxpkowaYXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+FIzSnS+y+IVMkFG4HCNjbg2+5C4yZYezcQGrLBZiAguvKcKFosUi5+Iu9NJJCvN
         dlNWI9P2WUO/dTbcUmKBiCrln3Tr2dlqk1yWtAPu4TBjQb5TIcaYH25jhXw0HLbUWr
         6Xe4K2plGSHm+dbMCy5n9d5M0SXHiSsiWMrrNtjw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 34/63] perf augmented_raw_syscalls: Do not include stdio.h
Date:   Tue, 18 Dec 2018 19:07:04 -0300
Message-Id: <20181218220733.15839-35-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We're not using that puts() thing, and thus we don't need to define the
__bpf_stdout__ map, reducing the setup time.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-3452xgatncpil7v22minkwbo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index a91c5874433e..6c5db6baeb3a 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -14,7 +14,6 @@
  * code that will combine entry/exit in a strace like way.
  */
 
-#include <stdio.h>
 #include <unistd.h>
 #include <pid_filter.h>
 
-- 
2.19.2

