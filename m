Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953F6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAE920867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYNelwM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAE920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeIFCiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFCiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:02 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6752C2083D;
        Wed,  5 Sep 2018 22:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185151;
        bh=HVkKYsAfHCEqg1f+8iWerqb7tKfM3M5QBHrMvjChbl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sYNelwM8mAcWUjbuoV7xHNOLd+JR9WIKZetLD3axhgbwVstrhUeKhPP4OY5vUTjYj
         GvVH+JOisxEeSnJxDxGfXx4JsHMp9FL1RWgErC9pAmCQqsPzqo69mi4Cu9qxReMf3Z
         nzn5nfTvYrwUpas5PT3b+glsOnqGekIXYPXmgFE0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 22/77] perf augmented_syscalls: Update the header comments
Date:   Wed,  5 Sep 2018 19:03:45 -0300
Message-Id: <20180905220440.20256-23-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Reflecting the fact that it now augments more than syscalls:sys_enter_SYSCALL
tracepoints that have filename strings as args. Also mention how the
extra data is handled by the by now modified 'perf trace' beautifiers,
that will use special "augmented" beautifiers when extra data is found
after the expected syscall enter/exit tracepoints.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ybskanehmdilj5fs7080nz1g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index be06d2c9e8c9..bfa28eaf27b3 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Augment the openat syscall with the contents of the filename pointer argument.
+ * Augment syscalls with the contents of the pointer arguments.
  *
  * Test it with:
  *
@@ -10,12 +10,10 @@
  * the last one should be the one for '/etc/passwd'.
  *
  * This matches what is marshalled into the raw_syscall:sys_enter payload
- * expected by the 'perf trace' beautifiers, and can be used by them unmodified,
- * which will be done as that feature is implemented in the next csets, for now
- * it will appear in a dump done by the default tracepoint handler in 'perf trace',
- * that uses bpf_output__fprintf() to just dump those contents, as done with
- * the bpf-output event associated with the __bpf_output__ map declared in
- * tools/perf/include/bpf/stdio.h.
+ * expected by the 'perf trace' beautifiers, and can be used by them, that will
+ * check if perf_sample->raw_data is more than what is expected for each
+ * syscalls:sys_{enter,exit}_SYSCALL tracepoint, uing the extra data as the
+ * contents of pointer arguments.
  */
 
 #include <stdio.h>
-- 
2.14.4

